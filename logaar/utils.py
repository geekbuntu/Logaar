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

from multiprocessing import Process, Manager
from os import getpid

def debug(s):
    #FIXME: __name__ won't work
    print __name__, getpid(), s

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
        manager = Manager()
        self.shared = manager.dict(self._shared.items() + shared.items())
        self._p = Process(target=self._target, args=(conf, self.shared))

    def start(self):
        """Start the process"""
        self._p.start()

    def stop(self):
        """Stop the process, either gracefully or by terminating it
        """
        timeout = 5
        self.shared['_enabled'] = False
        self._p.join(timeout)
        if self._p.is_alive():
            self._p.terminate()
            debug("%s did not exit after %d seconds - terminated" % (self.shared['name'], timeout))
#            debug("%s did not exit after %d seconds - terminated" % (self.__class__.__name, timeout))

    def _target(self):
        """Process code, to be redefined"""
        raise NotImplementedError
