FROM python:3.7
WORKDIR /app
ENV FLASK_APP=app.py
COPY requirements.txt /app
RUN apt update 
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . /app
CMD ["flask", "run", "--host=0.0.0.0"]

