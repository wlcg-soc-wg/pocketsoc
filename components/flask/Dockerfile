FROM python:3

WORKDIR /app

ADD ./files /app

RUN pip install --trusted-host pypi.python.org -r requirements.txt

CMD ["python", "app.py"]
