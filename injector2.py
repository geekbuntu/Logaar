from datetime import datetime
import socket
import sys
from time import time

from pymongo import Connection

db = Connection().logaar

incoming = db.incoming
if 'capped' not in incoming.options():
    db.drop_collection('incoming')
    db.create_collection("incoming", capped=True,size="100000")
    incoming = db.incoming

port = 514

def inject(data):
    # <19>Mar 22 21:19:01 ehm nullmailer[1727]: Sending failed:  Connection timed out

    msg = {
        "host": "localhost",
        "msg": data,
        "tags": [],
        "date": datetime.utcnow(),
        "level": "info",
    }
    incoming.insert(msg)


def main():
    try:
        sock=socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind(("0.0.0.0",port))
    except Exception, e:
        print e
        sys.exit(1)

    while 1:
        try:
            data,addr=sock.recvfrom(1024)
            if not data:
                print "close"
                break

            inject(data)
            print 'added', len(data), time(), incoming.count()
        except socket.error:
            pass

    sock.close()

main()
