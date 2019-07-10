#!/bin/python3
import smtplib
from email.message import EmailMessage
import mysql.connector
import getpass
import time

print("This script uses Gmail to send e-mails.")
sentfrom = input("Enter user for Gmail:")
passwd = getpass.getpass("Enter password for Gmail: ")

email_objs = []

# Connect to SMTP server
try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.ehlo()
    server.login(sentfrom, passwd)
except Exception as e:
    print("Error connecting to smtp server")
    print(e)
    exit(1)

db_host = "localhost"
db_user = "root"
db_passwd = "example"

# Connect to MySQL server
try:
    conn = mysql.connector.connect(
        host=db_host,
        user=db_user,
        passwd=db_passwd
    )
    cursor = conn.cursor()
    cursor.execute("use scientiometer")
except Exception as e:
    print("Error setting up DB connection")
    print(e)
    exit(1)


class Email:
    sent_from = sentfrom
    codes = []

    def __init__(self,  name, email, code, message_text, subject):
        self.name = name
        self.email = email
        self.code = code
        self.subject = subject
        self.message_text = message_text

    @property
    def message(self):
        message_obj = EmailMessage()
        message_obj['From'] = self.sent_from
        message_obj['To'] = self.email
        message_obj['Subject'] = self.subject
        self.message_text = self.message_text.format(self.name, self.code)
        message_obj.set_content(self.message_text)
        return message_obj

    def __str__(self):
        return "To: " +\
        self.message.values()[1].__str__() +\
        "\n\nMESSAGE :\n" +\
        self.message_text +\
        "\n======================================================================\n"

    def send(self):
        print(f'Sending message to {self.email}')
        server.sendmail(self.sent_from, self.email, self.message.as_string())


def create_emails():
    message_file = open(input("Enter message file path: "), 'r')
    message_string = "".join(message_file.readlines())
    print(message_string)
    subject = input("Enter subject: ")
    global email_objs
    cursor.execute("select name, email, code from researcher_data;")
    researchers = cursor.fetchall()

    for res in researchers:
        email_objs.append(Email(res[0], res[1], res[2], message_string, subject))


def menu():
    menu_options = """
Choose:
1 - Create e-mails
2 - Print e-mails
3 - Send e-mails
0 - Exit

>"""

    while(1):

        option = input(menu_options)
        if option == '1':
            print("Creating e-mails")
            create_emails()
        elif option == '2':
            for email in email_objs:
                print(email)
        elif option == '3':
            confirm = input(
                "Are you sure to send ALL the e-mails? \nType YES to confirm:")
            if (confirm == 'YES'):
                print("Sending e-mails")
                for email in email_objs:
                    email.send()
                    time.sleep(5)
            else:
                print("Operation aborted by user")

        elif option == '0':
            server.close()
            conn.close()
            exit(0)


menu()
