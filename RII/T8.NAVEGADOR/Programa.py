
from flask import Flask, redirect, url_for, request,render_template, abort,jsonify
import os, json, csv

app = Flask("CodeFlix")

@app.route('/')
def home():
    return  render_template('index.html')

@app.route('/pagina1')
def pagina1():
    return  render_template('/pagina1.html')

@app.route('/pagina2')
def pagina2():
    return  render_template('/pagina2.html')

@app.route('/gravar', methods=['POST'])
def gravar():
    pagina = request.form['pagina']
    entrada = request.form['entrada']
    saida = request.form['saida']
    tempo = request.form['tempo']
    with open("resultados.csv",'a') as csvfile:
        spamwriter = csv.writer(csvfile, delimiter=' ', quotechar=' ', quoting=csv.QUOTE_MINIMAL)
        spamwriter.writerow([pagina, entrada, saida, tempo ])

if __name__=='__main__':    
    app.run('0.0.0.0',debug=True, port=8080)