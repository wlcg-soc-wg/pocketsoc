from flask import Flask
import os
import socket
import datetime
from time import gmtime, strftime

app = Flask(__name__)

@app.route('/')
def hello_world():
    current=strftime("%a, %d %b %Y %H:%M +0000", gmtime())
    me=socket.gethostname()
    message=me+" "+current+"\n"

    return message

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
