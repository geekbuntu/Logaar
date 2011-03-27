from logging import getLogger
from pymongo import Connection, has_c

log = getLogger(__name__)

class DB(object):
    def __init__(self, host='localhost'):
        """Connect to MongoDB database, get logaar collections
        Create and populate them if needed"""
        if not has_c():
            log.warning("Pymongo C module not available. Consider installing it to increase performances.")

        c = Connection()

        if 'logaar' not in c.database_names():
            log.info("Creating logaar database")
        db = c.logaar

        if 'logs' not in db.collection_names():
            log.info("Creating collection 'logs'")
        self.logs = db.logs

        if 'incoming' not in db.collection_names():
            log.info("Creating collection 'incoming'")
            db.create_collection("incoming", capped=True,size="100000")
        self.incoming = db.incoming

        if 'rules' not in db.collection_names():
            log.info("Creating collection 'rules'")
            #TODO: rewrite this with proper collection dump/restore
            import setup_rules
            for rulevals in setup_rules.rules_tuple:
                d = dict(zip(setup_rules.keys, rulevals))
                db.rules.insert(d)
        self.rules = db.rules

    #TODO: run c.disconnect() on DB.__del__() ?





