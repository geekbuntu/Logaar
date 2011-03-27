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

from smtplib import SMTP

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def send(conf, log, sbj='', body=''):
    smtp_srv, emailsrc, emaildests, title = conf
    if smtp_srv:
        try:
            session = SMTP(smtp_srv)
            session.sendmail(emailsrc, emaildests, "Subject: [%s]: %s\n%s" % (title, sbj, body))
            session.close()
        except Exception,  e:
            log.error("Unable to deliver email: %s", e)


def send_html_and_text(sbj='Hello', body=''):

    me = ""
    you = ""

    # Create message container - the correct MIME type is multipart/alternative.
    msg = MIMEMultipart('alternative')
    msg['Subject'] = sbj
    msg['From'] = me
    msg['To'] = you

    # Create the body of the message (a plain-text and an HTML version).
    text = "Hi!\nHow are you?\nHere is the link you wanted:\nhttp://www.python.org"
    html = """\
    <html>
      <head></head>
      <body>
        <p>Hi!<br>
           How are you?<br>
           Here is the <a href="http://www.python.org">link</a> you wanted.
        </p>
      </body>
    </html>
    """

    # Record the MIME types of both parts - text/plain and text/html.
    part1 = MIMEText(text, 'plain')
    part2 = MIMEText(html, 'html')

    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case
    # the HTML message, is best and preferred.
    msg.attach(part1)
    msg.attach(part2)

    try:
        session = SMTP('localhost')
        session.sendmail(me, you, msg.as_string())
#        session.sendmail(emailsrc, emaildests, "Subject: [%s]: %s\n%s" % (title, sbj, body))
        session.close()
    except Exception,  e:
        log.error("Unable to deliver email: %s", e)


def send_html(sbj='Hello', body=''):

    me = ""
    you = ""

    # Create message container - the correct MIME type is multipart/alternative.
    msg = MIMEMultipart('alternative')
    msg['Subject'] = sbj
    msg['From'] = me
    msg['To'] = you

    # Create the body of the message (a plain-text and an HTML version).
    html = """\
    <html>
      <head></head>
      <style>

        table td {
            border: 1px solid #c0c0c0;
            padding: 2px;
        }
        table tr td.add {
            background-color: #f0fff0;
        }
        table tr td.del {
            background-color: #fff0f0;
        }
        </style>
      <body>
        <p>
            Automated email from Firelet
        </p>
        <table class="diff">
            <tr><td class="add"> added item </td></tr>
            <tr><td class="del"> deleted item </td></tr>
            <tr><td class="add"> added item </td></tr>
            <tr><td class="add"> added item </td></tr>
        </table>
      </body>
    </html>
    """

    # Record the MIME types of both parts - text/plain and text/html.
    part = MIMEText(html, 'html')

    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case
    # the HTML message, is best and preferred.
    msg.attach(part)

    try:
        session = SMTP('localhost')
        session.sendmail(me, you, msg.as_string())
#        session.sendmail(emailsrc, emaildests, "Subject: [%s]: %s\n%s" % (title, sbj, body))
        session.close()
    except Exception,  e:
        log.error("Unable to deliver email: %s", e)


#send_html()
