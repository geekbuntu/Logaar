#
# Logaar - log parsing daemon
#
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

from datetime import datetime
from logging import getLogger
from setproctitle import setproctitle
from sys import exit
from time import time, sleep
import re

#from core import Alert, Users, clean
from dbconnector import DB
from utils import ProcessWrapper

class Parser(ProcessWrapper):
    """Log parser process"""

    _shared = dict(
        _enabled = 0,
        error = 0,
        processed = 0,
        failures = 0,
        success = 0,
        start_time = int(time()),
    )

    def _target(self, conf, shared):
        setproctitle('logaar_parser')
        log = getLogger('parser')
        log.info('started')
        db = DB(host=conf.db_host)
        while shared['_enabled'].value:
            sleep(.1)
            for msg in db.incoming.find({'processed': None}, tailable=True):
                try:
                    db.incoming.update(msg,  {'processed': 1}, safe=True, multi=False)
                    shared['processed'].value += 1
                    li = msg['msg'].split()
                    host = li[3]
                    program = li[4]
                    text = ' '.join(li[5:])
                    if program.endswith(']:') and '[' in program:
                        program, pid = program.split('[')
                        pid = pid[:-2]
                    else:
                        pid = None

                    new_msg = {
                        "host": host,
                        "msg": text,
                        "program": program,
                        "tags": [],
                        "date": str(msg['date']),
                        "level": "info",
                        "pid": pid,
                        'score': 0
                    }

                    prog_rules =  db.rules.find({"program": program, "rule_type": "regexp"})

                    for rule in prog_rules:
                        if re.search(rule['rule'], text):
                            new_msg['score'] += rule['score']

                    #TODO: try/except in case of duplicates
                    db.logs.insert(new_msg)

                    db.incoming.update(msg,{'$inc':{'processed': 1}}, safe=True, multi=False)
                    shared['success'].value += 1
    #              #FIXME: count failures
                    if not shared['_enabled'].value:
                        break
                except Exception, e:
                    log.warn("Error while parsing %s: %s" % (repr(msg), e))

        db.disconnect()
        log.info('exited')







