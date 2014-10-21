from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello to your search app!"

def run_server():
    app.debug = True
    app.run(host='0.0.0.0')

if __name__ == "__main__":
    run_server()
