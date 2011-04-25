# Copyright (C) 2011 Federico Ceratto
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from pymongo import Connection, has_c, ASCENDING, DESCENDING
import re

from logging import getLogger
log = getLogger('dbconnector')

class DB(object):
    def __init__(self, host='localhost'):
        """Connect to MongoDB database, get logaar collections
        Create and populate them if needed"""
        if not has_c():
            log.warning("Pymongo C module not available. Consider installing it to increase performances.")

        c = Connection()
        self._connection = c

        if 'logaar' not in c.database_names():
            log.info("Creating logaar database")
        db = c.logaar

        if 'logs' not in db.collection_names():
            log.info("Creating collection 'logs'")
        self.logs = db.logs

        # Create index if needed
        db.logs.ensure_index(
            [
                ('date', 1),
                ('level', 1),
                ('message', 1),
                ('program', 1),
                ('pid', 1),
            ],
            unique = True,
            dropDups = True,
        )


        if 'incoming' not in db.collection_names():
            log.info("Creating collection 'incoming'")
            db.create_collection("incoming", capped=True,size="100000")
        self.incoming = db.incoming

        # Create index if needed
        db.incoming.ensure_index(
            [
                ("date", DESCENDING)
            ]
        )

        if 'rules' not in db.collection_names():
            log.info("Creating collection 'rules'")
            #TODO: rewrite this using proper collection dump/restore
            import setup_rules
            for rulevals in setup_rules.rules_tuple:
                d = dict(zip(setup_rules.keys, rulevals))
                db.rules.insert(d)
        self.rules = db.rules
        log.info('connected')

    #TODO: run c.disconnect() on DB.__del__() ?

    def disconnect(self):
        self._connection.disconnect()

    def search(self, coll, skip=0, sort_on=None, sort_dir='desc', free_search=None, limit=10, keys=None, search_key='rule', filter_d=None):
        """Search, sort and filter items"""
        if filter_d is None:
            filter_d = {}

        sort_dir = DESCENDING if sort_dir == 'desc' else ASCENDING

        #TODO: rexep caching
        if free_search:
            regexp = re.compile(free_search, re.IGNORECASE)
            filter_d[search_key] = regexp

        ru = coll.find(filter_d, limit=limit, skip=skip).sort(sort_on, sort_dir)
        if keys:
            # return a list of values related to "keys"
            return (
                [[str(r.get(k)) for k in keys] for r in ru],
                ru.count(),
                coll.count()
            )
        else:
            return (ru, ru.count(), coll.count())


    def stats(self, coll):
        """mongostats.py

           Prints statistics summarizing the frequency of each key
           in every collection of a Mongo database.  Helpful as a
           diagnostic tool.
        """

        # http://www.djcinnovations.com/archives/84

        # 'map' function in JavaScript
        # emits (key, 1) for each key present in a document
        map_fn = """
            function () {
                for (key in this) {
                    emit(key, 1);
                }
            };
        """

        # 'reduce' function in JavaScript
        # totals the counts associated with a given key
        reduce_fn = """
            function (key, values) {
                var sum = 0;
                for each (value in values) {
                    sum += value;
                }
                return sum;
            };
        """

        total = coll.count()

        # use map/reduce to count the frequency of each field
        #FIXME
        result = coll.map_reduce(map_fn, reduce_fn, self.out)

        print repr(result)
        print 'end'
        return (None, None)
        d = {}
        for item in result.find():
            key = item['_id']
            count = int(item['value'])
        d[key] = count
        return d, total



