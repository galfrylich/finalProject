#!/usr/bin/python
import os
import csv
import MySQLdb
from dotenv import load_dotenv
load_dotenv()


def create_connection():
        conn = MySQLdb.connect(os.environ.get('DB_HOST'),
        os.environ.get('DB_UNAME'),os.environ.get('DB_PASSWORD'))
        return conn

#add check if file allredy adde to database. 
#path from csv files
#call get csv files module
path = "./csv_files/1.csv"
def init_db():
        with open(path,encoding="utf16") as csv_file:
                csv_reader = csv.reader(csv_file, delimiter = '\t')
                all_rows = []
                next(csv_reader)
                for row in csv_reader:
                        all_rows.append(row)
                        
        #create connection
        conn = create_connection()
        query ="USE attendance_DB; INSERT INTO attendance_list (name,email,attendance_duration) VALUES (%s,%s,%s);"



        #check if the connection is open, then create a new table.
        if conn.open:
                cursor = conn.cursor()
                cursor.execute("CREATE DATABASE if not exists attendance_DB")
                print("attendance_DB database is created")
                cursor.execute("USE attendance_DB")
                cursor.execute("CREATE TABLE IF NOT EXISTS attendance_list(ID int NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, email varchar(255) NOT NULL,attendance_duration varchar(255) NOT NULL,PRIMARY KEY (ID));")
                cursor.executemany(query,all_rows)
                cursor.close() 
        else:
                print("there is no connection")

        conn.commit()


   