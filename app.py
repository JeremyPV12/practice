from flask import Flask, render_template

app = Flask(__name__)

@app.route("/home")
def home():
    return render_template("index.html")


@app.route("/contacto")
def contacto():
    return "contacto"


@app.route("/acerca-de")
def acerca_de():
    return "acerca-de"

if __name__ == "__main__":
    app.run(debug=True)