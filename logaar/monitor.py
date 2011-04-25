#
# Logaar - monitoring thread
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

from threading import Timer
from time import time

import logging as log

#FIXME: unused
def stat_generator(processes, stats):
    """Monitor processes, generate statistics"""
#    global stats
#    global processes

    # access shared memory, fetch and reset counters
    recv = processes['collector'].shared['received']
    processes['collector'].shared['received']= 0
    stats['collector_series'].append(recv)
    if len(stats['collector_series']) > 20:
        stats['collector_series'].pop()

#    print "Runtime: %d, processed logs: %d ps, successful: %d ps" % \
#        (time() - stats['start_time'], stats['processed'], stats['success'])
#    stats['processed'] = 0
#    stats['success'] = 0
    Timer(1, stat_generator).start(processes, stats)

