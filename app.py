from flask import Flask
app = Flask(__name__)
 
@app.route('/')
def hello_world():
  return 'Hello'
 
if __name__ == '__main__':
    app.secret_key = 'Qm9nZGEgbWUgbzUgemV6YQ=='
    app.run(host='0.0.0.0',
            port=8080)
