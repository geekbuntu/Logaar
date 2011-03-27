# Copyright (C) 2010 Federico Ceratto
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

from ConfigParser import SafeConfigParser

class ConfReader(object):
    def __init__(self, fn):
        defaults = {
            'title': 'Logaar',
            'listen_address': 'localhost',
            'listen_port': 8088,
            'logfile': 'logaar.log',
            'data_dir': '/var/lib/logaar',
            'demo_mode': False,
            'smtp_server_addr': '',
            'email_source': 'logaar@localhost.local',
            'email_dests': 'root@localhost',
            'public_url': None
        }
        #TODO: validate strings from the .ini file  ---> fmt = "-ofmt:%" +
            # conf.ip_list_netflow_address
        self.__slots__ = defaults.keys()
        config = SafeConfigParser(defaults)
        config.read(fn)

        for name, default in defaults.iteritems():
            if type(default) == int:
                self.__dict__[name] = config.getint('global', name)
            elif type(default) == float:
                self.__dict__[name] = config.getfloat('global', name)
            else:
                self.__dict__[name] = config.get('global', name)
