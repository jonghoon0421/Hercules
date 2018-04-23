# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    send.py                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jonkim <jonkim@student.42.us.org>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/04/20 16:55:05 by jonkim            #+#    #+#              #
#    Updated: 2018/04/20 21:20:20 by jonkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/usr/bin/python3

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.image import MIMEImage
from email.mime.text import MIMEText
from sys import stdin
from pathlib import Path
import getpass
import os

form = input("Include an attachment? (y/n) ")
if form == 'n':
    title = input("Subject: ")
    print("Type your message (\"Ctrl + D\" when complete)")
    msg = ""
    for line in stdin:
        msg += line
    msg.strip()
    send = input("Sender: ")
    password = getpass.getpass("Password: ")
    s = send.split("@")[1]
    s.strip()
    if s.find('gmail') != -1:
        smtpserver = 'smtp.gmail.com'
    elif s.find('hotmail') != -1:
        smtpserver = 'smtp.live.com'
    else:
        smtpserver = 'smtp.mail.yahoo.com'
    recv = input("Receiver: ")
    
    # create message object instance
    mess = MIMEMultipart()
    
    # set the parameters of the message
    mess['From'] = send
    mess['To'] = recv
    mess['Subject'] = title
    
    # add in the message body
    mess.attach(MIMEText(msg, 'plain'))
    try:
        # create server
        server = smtplib.SMTP(smtpserver, 587)
        server.starttls()
        # login credentials
        server.login(mess['From'], password)
        # send the message through the server
        server.sendmail(mess['From'], mess['To'], mess.as_string())
        print("e-mail sent")
        server.quit()
    except SMTPException:
        print("Error: unable to send e-mail")
else:
    title = input("Subject: ")
    print("Type your message (\"Ctrl + D\" when complete)")
    msg = ""
    for line in stdin:
        msg += line
    msg.strip()
    pic = input("File name (current directory only): ")
    send = input("Sender: ")
    password = getpass.getpass("Password: ")
    s = send.split("@")[1]
    s.strip()
    if s.find('gmail') != -1:
        smtpserver = 'smtp.gmail.com'
    elif s.find('hotmail') != -1:
        smtpserver = 'smtp.live.com'
    else:
        smtpserver = 'smtp.mail.yahoo.com'
    recv = input("Receiver: ")
    
    # create message object instance
    mess = MIMEMultipart()
    
    # set the parameters of the message
    mess['From'] = send
    mess['To'] = recv
    mess['Subject'] = title
    
    # add in the message body
    mess.attach(MIMEText(msg, 'plain'))
    img_data = open(pic, 'rb').read()
    tmpimg = MIMEImage(img_data, name=os.path.basename(pic))
    mess.attach(tmpimg)
    try:
        # create server
        server = smtplib.SMTP(smtpserver, 587)
        server.starttls()
        # login credentials
        server.login(mess['From'], password)
        # send the message through the server
        server.sendmail(mess['From'], mess['To'], mess.as_string())
        print("Success: e-mail sent")
        server.quit()
    except SMTPException:
        print("Error: unable to send e-mail")
