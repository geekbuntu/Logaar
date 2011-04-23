#
# Logaar - log collector thread
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

# Syslog-ng will support MongoDB from version 3.3

from datetime import datetime
from multiprocessing import Process, Manager
from os import getpid
import socket
from sys import exit
from time import time, sleep

from dbconnector import DB

def debug(s):
    print __name__, getpid(), s


def collector(conf, stats):
    """Listen on UDP and TCP sockets, receive Syslog messages and store them
    in the "incoming" collection"""
    debug('started')
    try:
        db = DB(host=conf.db_host)
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind((conf.syslog_address, conf.syslog_udp_port))
        sock.settimeout(1)
        debug('opened %s' %  repr(sock))
    except Exception, e:
        debug(e)
        sock.close()
        exit(1)

    while stats['_enabled']:
        try:
            data,addr = sock.recvfrom(1024)
            if not data:
                break
            stats['received'] += 1
            msg = {
                "host": "localhost",
                "msg": data,
                "tags": [],
                "date": datetime.utcnow(),
                "level": "info",
            }
            db.incoming.insert(msg)
            stats['inserted'] += 1
        except socket.error, e:
            debug(e)
        except KeyboardInterrupt:
            break
        sleep(.05)

    sock.close()
    debug('exited')


class Collector(object):

    def __init__(self, conf):

        manager = Manager()
        self.stats = manager.dict(
            received = 0,
            inserted = 0,
            error = '',
            _enabled = True
        )
        self._p = Process(target=collector, args=(conf, self.stats))

    def start(self):
        self._p.start()

    def stop(self):
        timeout = 5
        self.stats['_enabled'] = False
        self._p.join(timeout)
        if self._p.is_alive():
            self._p.terminate()
            debug("Collector did not exit after %d seconds - terminated" % timeout)





#
#
#
#class Collector(object):
#    """Listen on UDP and TCP sockets, receive Syslog messages and store them
#    in the "incoming" collection"""
#
#    def __init__(self, conf):
#        self.name = 'collector'
#        self.conf = conf
#        self.db = DB(host=conf.db_host)
#        self.shutdown = False
#        self.stats = {
#            'received': 0,
#            'inserted': 0,
#        }
#
#    def _inject(self, data):
#        msg = {
#            "host": "localhost",
#            "msg": data,
#            "tags": [],
#            "date": datetime.utcnow(),
#            "level": "info",
#        }
#        self.db.incoming.insert(msg)
#
#    def start(self):
#        # open UDP socket
#        try:
#            sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
#            sock.bind((self.conf.syslog_address, self.conf.syslog_udp_port))
#            debug('opened %s' %  repr(sock))
#        except Exception, e:
#            debug(e)
#            sock.close()
#            exit()
#
#        while not self.shutdown:
#            try:
#                data,addr = sock.recvfrom(1024)
#                if not data:
#                    break
#                self.stats['received'] += 1
#                self._inject(data)
#                self.stats['inserted'] += 1
#            except socket.error:
#                print __name__, 'socket error'
#            except KeyboardInterrupt:
#                break
#            sleep(.05)
#
#        sock.close()
#        debug('ended')


# The collector can be run autonomously
if __name__ == '__main__':
    from confreader import ConfReader
    conf = ConfReader(fn='logaar.ini')
    c = Collector(conf)
    c.start()
    sleep(5)
    c.stop()
