from flask import Flask,render_template
from config_db import *


app = Flask(__name__)


@app.route("/")
def base():
    return render_template('base.html')

    
@app.route('/index')
def index():
    return render_template('index.html')    

@app.before_first_request
def init():
    init_db()

@app.route("/show_table")
def show_students():
    conn = create_connection()
    cursor = conn.cursor()
    cursor.execute("USE attendance_DB")
    cursor.execute("SELECT * FROM attendance_list")
    all_students = cursor.fetchall()
    return render_template('show_students.html', students=all_students)

if __name__ == '__main__':
    app.run(host='0.0.0.0')   