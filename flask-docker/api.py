from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello to your search app!"

if __name__ == "__main__":
    app.run()
