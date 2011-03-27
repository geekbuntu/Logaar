from copy import deepcopy
from datetime import datetime
from optparse import OptionParser
from hashlib import sha512

try:
    import json
except ImportError:
    import simplejson as json

def loadjson(n, d):
    try:
        f = open("%s/%s.json" % (d, n))
        s = f.read()
        f.close()
    except Exception, e:
        raise Alert, "Unable read json file: %s" % e
    try:
        return json.loads(s)
    except Exception, e:
        raise Alert, "Unable to load users from '%s/%s.json': %s" % (d, n, e)

class Users(object):
    """User management, with password hashing.
    users = {'username': ['role','pwdhash','email'], ... }
    """

    def __init__(self, d):
        self._dir = d
        self._users = loadjson('users', d=d)

    def list(self):
        return list(self._users)

    def _save(self):
        savejson('users', self._users, d=self._dir)

    def _hash(self, u, pwd): #TODO: should I add salting?
        return sha512("%s:::%s" % (u, pwd)).hexdigest()

    def create(self, username, role, pwd, email=None):
        assert username, "Username must be provided."
        assert username not in self._users, "User already exists."
        self._users[username] = [role, self._hash(username, pwd), email]
        self._save()

    def update(self, username, role=None, pwd=None, email=None):
        assert username in self._users, "Non existing user."
        if role is not None:
            self._users[username][0] = role
        if pwd is not None:
            self._users[username][1] = self._hash(username, pwd)
        if email is not None:
            self._users[username][2] = email
        self._save()

    def delete(self, username):
        try:
            self._users.pop(username)
        except KeyError:
            raise Alert, "Non existing user."
        self._save()

    def validate(self, username, pwd):
        assert username, "Missing username."
        assert username in self._users, "Incorrect user or password."
        assert self._hash(username, pwd) == self._users[username][1], \
            "Incorrect user or password."


def clean(s):
    """Remove dangerous characters.
    >>> clean(' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_')
    ' !#$%&()*+,-./0123456789:;=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_'
    """
    o = ''
    for x in s:
        n = ord(x)
        if 31 < n < 127  and n not in (34, 39, 60, 62, 96):
            o += x
    return o

def cli_args(args=None):
    """Parse command line arguments"""
    parser = OptionParser()
    parser.add_option("-c", "--conffile", dest="conffile",
        default='firelet.ini', help="configuration file", metavar="FILE")
    parser.add_option("-r", "--repodir", dest="repodir",
        help="configuration repository dir")
    parser.add_option("-D", "--debug",
        action="store_true", dest="debug", default=False,
        help="run in debug mode and print messages to stdout")
    parser.add_option("-q", "--quiet",
        action="store_true", dest="quiet", default=False,
        help="print less messages to stdout")
    if args:
        return parser.parse_args(args=args)
    return parser.parse_args()

class Alert(Exception):
    """Custom exception used to send an alert message to the user"""


class Bunch(object):
    """A dict that exposes its values as attributes."""
    def __init__(self, **kw):
        self.__dict__ = dict(kw)

    def __repr__(self):
        return repr(self.__dict__)

    def __len__(self):
        return len(self.__dict__)

    def __getitem__(self, name):
        return self.__dict__.__getitem__(name)

    def __setitem__(self, name, value):
        return self.__dict__.__setitem__(name, value)

    def __iter__(self):
        return self.__dict__.__iter__()

    def keys(self):
        return self.__dict__.keys()

    def _token(self):
        """Generate a simple hash"""
        return hex(abs(hash(str(self.__dict__))))[2:]

    def validate_token(self, t):
        assert t == self._token(), \
        "Unable to update: one or more items has been modified in the meantime."

    def attr_dict(self):
        """Provide a copy of the internal dict, with a token"""
        d = deepcopy(self.__dict__)
        d['token'] = self._token()
        return d

    def update(self, d):
        """Set/update the internal dictionary"""
        for k in self.__dict__:
            self.__dict__[k] = d[k]


def flag(s):
    """Parse string-based flags"""
    if s in (1, True, '1', 'True', 'y', 'on' ):
        return '1'
    elif s in (0, False, '0', 'False', 'n', 'off', ''):
        return '0'
    else:
        raise Exception, '"%s" is not a valid flag value' % s

def extract(d, keys):
    """Returns a new dict with only the chosen keys, if present"""
    return dict((k, d[k]) for k in keys if k in d)

def extract_all(d, keys):
    """Returns a new dict with only the chosen keys"""
    return dict((k, d[k]) for k in keys)


# RSS feeds generation
#
#def append_rss_item(channel, url, level, msg, ts, items):
#    """Append a new RSS item to items"""
#    i = Bunch(
#        title = "Firelet %s: %s" % (level, msg),
#        desc = msg,
#        link = url,
#        build_date = '',
#        pub_date = ts.strftime("%a, %d %b %Y %H:%M:%S GMT"),
#        guid = ts.isoformat()
#    )
#    items.append(i)
#
#def get_rss_channels(channel, url, msg_list=[]):
#    """Generate RSS feeds for different channels"""
#    if channel not in ('messages', 'confsaves', 'deployments'):
#        raise Exception, "unexistent RSS channel"
#
#    utc_rfc822 = datetime.utcnow().strftime("%a, %d %b %Y %H:%M:%S GMT")
#
#    c = Bunch(
#        title = 'Firelet %s RSS' % channel,
#        desc = "%s feed" % channel,
#        link = url,
#        build_date = utc_rfc822,
#        pub_date = utc_rfc822,
#        channel = channel
#    )
#
#    items = []
#
#    if channel == 'messages':
#        for level, ts, msg in msg_list:
#            append_rss_item(channel, url, level, msg, ts, items)
#
#    elif channel == 'confsaves':
#        for level, ts, msg in msg_list:
#            if 'saved:' in msg:
#                append_rss_item(channel, url, level, msg, ts, items)
#
#    elif channel == 'deployments':
#        for level, ts, msg in msg_list:
#            if 'deployed' in msg:
#                append_rss_item(channel, url, level, msg, ts, items)
#
#    return dict(c=c, items=items)
#
#
#
#
#
