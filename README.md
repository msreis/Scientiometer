# Scientiometer

This is the README file of Scientiometer, a platform for scientiometric analyses of research institutions. Although Scientiometer was originally designed for evaluation of researchers and scientific production at Instituto Butantan, this software may be employed for evaluation of any other institution.

In the following, we explain how to install and configure Scientiometer.


## 1) Dependencies:

sudo apt-get install docker docker-compose


## 2) Check whether docker is actually installed and running:

systemctl status docker


## 3) Get Scientiometer source-code:

git clone https://github.com/msreis/Scientiometer.git


## 4) Configure the mysql user and password in the Docker configuration file:

vim docker-compose.yml

Changing the variables MYSQL_USER and MYSQL_PASSWORD.


## 5) Enter into Scientiometer root folder and run Docker:

sudo docker-compose up 


## 6) Open a browser (e.g. Mozilla Firefox) and at the URL type:

http://localhost:8080

This will open the phpMySQLadmin web interface, which interacts directly to the mysql deamon within Docker.


## 7) Log in at the phpMySQLadmin, using user and password provided in step (4).


## 8) Create database and tables. To this end, go to "Import" page, select the SQL file by clicking in "Browse your Computer", and finally confirm the upload by clicking onto the "Go" button at the end of the page. The file to be browsed is scripts/create_tables.sql


## 9) Store CSV files into data/ folder that is located in the project root directory. The column separator of those CSV files must be a pipe (|) character.


## 10) Install the Python3's pip:

sudo apt-get install python3-pip


## 11) Install the mysql connector Python3 library through the following command:

sudo pip3 install mysql-connector


## 12) Run the script that import CSV files into the mysql database within Docker, using the CSV file stored at data/ folder. For example, for a 2018 report of the LECC laboratory located at DDC division, one should type:

python3 scripts/from_csv_to_database.py --file data/DDC-LECC.csv --year 2018 --div DDC --lab LECC


