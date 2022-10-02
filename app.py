from flask import Flask,render_template
from config_db import *
from get_csv_files import *



app = Flask(__name__)

@app.before_first_request
def init():
    conn = init_db()
    file_handler(conn)

@app.route("/")
def base():
    return render_template('base.html')

    
@app.route('/index')
def index():
    return render_template('index.html')    


@app.route("/show_table")
def show_students():
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("USE attendance_DB")
    cursor.execute("SELECT * FROM attendance_list")
    all_students = cursor.fetchall()
    print(all_students)
    return render_template('show_students.html', students=all_students)


def file_handler(connection):
    csv_files = file_transfer()
    for file_name in csv_files:
        file_path = '/app/csv_files/{}'.format(file_name)
        file_name = file_name.split('-')[1]
        file_id = file_name.split('.')[0]
        insert_to_db(file_path,file_id,connection)




if __name__ == '__main__':
    app.run(host='0.0.0.0')   