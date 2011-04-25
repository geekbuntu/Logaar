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
from logging import getLogger
import socket
from setproctitle import setproctitle
from sys import exit
from time import time, sleep

from dbconnector import DB
from utils import ProcessWrapper

class Collector(ProcessWrapper):
    """Log collector process"""

    _shared = dict(
        name = 'collector',
        _enabled = True,
        received = 0,
        inserted = 0,
        error = '',
    )

    def _target(self, conf, shared):
        """Listen on UDP and TCP sockets, receive Syslog messages and store them
        in the "incoming" collection"""
        setproctitle('logaar_collector')
        log = getLogger('collector')
        log.info('started')
        try:
            db = DB(host=conf.db_host)
            sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            sock.bind((conf.syslog_address, conf.syslog_udp_port))
            sock.settimeout(1)
            log.debug('socket opened, FD: %d' % sock.fileno())
        except Exception, e:
            log.warn("Error: %s" % e)
            sock.close()
            db.disconnect()
            log.info('exited')
            exit(1)

        while shared['_enabled']:
            try:
                data,addr = sock.recvfrom(1024)
                if not data:
                    break
                shared['received'] += 1
                msg = {
                    "host": "localhost",
                    "msg": data,
                    "tags": [],
                    "date": datetime.utcnow(),
                    "level": "info",
                }
                db.incoming.insert(msg)
                shared['inserted'] += 1
            except socket.timeout:
                pass
            except socket.error, e:
                log.warn("Error: %s" % e)
            except KeyboardInterrupt:
                break
            sleep(.05)

        sock.close()
        db.disconnect()
        log.info('exited')
