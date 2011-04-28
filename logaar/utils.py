#
# Logaar - utility functions and classes
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

from multiprocessing import Process, Value
from os import getpid

class ProcessWrapper(object):
    """Wrapper class to start/stop processes.
    Provide shared dict.
    """
    def __init__(self, conf, shared={}):
        """Initialize the process and the shared memory.
        The "self._shared" dict and the "shared" optional argument are used to create
        self.shared
        """
        assert hasattr(self, '_shared'), "An attribute named '_shared', type dict is required."
        assert isinstance(self._shared, dict), "The attribute '_shared' must be a dict."
        self.shared = {}
        for name, val in self._shared.iteritems():
            self.shared[name] = Value('i', val)
#        shared = Value('i', val) for name, val in self._shared]
#        self.shared = shared
        self._p = Process(target=self._target, args=(conf, self.shared))

    def start(self):
        """Start the process"""
        self.shared['_enabled'].value = 1
        self._p.start()

    def stop(self):
        """Stop the process, either gracefully or by terminating it
        """
        timeout = 5
        self.shared['_enabled'].value = 0
        self._p.join(timeout)
        if self._p.is_alive():
            self._p.terminate()
            #TODO: add logging here

#    def _shared(self):
#        """Return a tuple of shared integers, to be redefined"""
#        raise NotImplementedError

    def _target(self):
        """Process code, to be redefined"""
        raise NotImplementedError
