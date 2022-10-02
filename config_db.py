#!/usr/bin/python
import os
import MySQLdb
from dotenv import load_dotenv
load_dotenv()
import pandas as pd



def create_connection():
        conn = MySQLdb.connect(os.environ.get('DB_HOST'),
        os.environ.get('DB_UNAME'),os.environ.get('DB_PASSWORD'))
        return conn


""" 
    configuration of databse
    create_connection(): connect to db.
    init(): initialize the database and table with correct colums data.
    insert_to_db(): run attendance caculation algorithem and insert the result to databse.

"""

def init_db():     
        #create connection
        conn = create_connection()
        #check if the connection is open, then create a new table.
        if conn.open:
                cursor = conn.cursor()
                cursor.execute("CREATE DATABASE if not exists attendance_DB")
                print("attendance_DB database is created")
                cursor.execute("USE attendance_DB")
                #cursor.execute("DROP TABLE IF EXISTS attendance_list")
                cursor.execute("CREATE TABLE IF NOT EXISTS attendance_list(name varchar(255),average varchar(255));")
                cursor.close() 
        else:
                print("there is no connection")

        conn.commit()
        return conn
        
def insert_to_db(path,file_id,conn):
        os.system('python attendance_caculate.py /app/csv_files')
        csv_path = os.getcwd() + '/attendance_result.csv'
        df_result = pd.read_csv(csv_path, index_col=False, delimiter=',')
        df_filtered = df_result[['names', 'average']].copy()
        cursor = conn.cursor()
        cursor.execute("USE attendance_DB")
        for row in df_filtered.iterrows():
                query = "INSERT INTO attendance_DB.attendance_list VALUES (%s, %s)"
                cursor.execute(query, tuple(row))
        conn.commit()
        
