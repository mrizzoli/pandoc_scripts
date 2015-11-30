#!/usr/bin/python

import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email import Encoders
import os

#mail_user = "marco@rizzoli.me.uk"
mail_pwd = os.getenv('mail_pwd')
mail_user = 'my.talkative.python@gmail.com'

def mail(to, subject, text, attach):
   msg = MIMEMultipart()

   msg['From'] = mail_user
   msg['To'] = to
   msg['Subject'] = subject

   msg.attach(MIMEText(text))

   part = MIMEBase('application', 'octet-stream')
   part.set_payload(open(attach, 'rb').read())
   Encoders.encode_base64(part)
   part.add_header('Content-Disposition',
           'attachment; filename="%s"' % os.path.basename(attach))
   msg.attach(part)

   mailServer = smtplib.SMTP("smtp.gmail.com", 587)
   mailServer.ehlo()
   mailServer.starttls()
   mailServer.ehlo()
   mailServer.login(mail_user, mail_pwd)
   mailServer.sendmail(mail_user, to, msg.as_string())
   # Should be mailServer.quit(), but that crashes...
   mailServer.close()

mail("marco@rizzoli.me.uk",
   "Here's your file",
   "This is an email sent automatically",
    "/tmp/tesi_wd/template_tesi.pdf")

