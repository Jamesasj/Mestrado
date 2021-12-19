#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun  6 21:34:10 2018

@author: james
"""
import math
from textblob import TextBlob as tb

#from collections import Counter
#import matplotlib.pyplot as plt
import numpy as np
def tf(word, blob):
    return 1 + math.log(blob.words.count(word)) #/ len(blob.words)

def n_containing(word, bloblist):
    return sum(1 for blob in bloblist if word in blob.words)

def idf(word, bloblist):
    return math.log(len(bloblist) / (1 + n_containing(word, bloblist)))

def tfidf(word, blob, bloblist):
    return tf(word, blob) * idf(word, bloblist)

def vetorizar(texto):
    return texto.replace(',','').replace('.','').replace(':','').replace(';','').replace('!','').replace('?','').lower().split()

def todas(word, bloblist):
    total = 0
    for blob in bloblist:
        total +=blob.words.count(word) 
    
    return total

arquivo = "/home/james/Documentos/Metodos-Empiricos-R/Topics.txt"



with open(arquivo,"r") as dados:
    texto = dados.read()
    ltextos = texto.replace("<top>","").split("</top>")
    #ltextos = [elem.split("<title> ")[1] for elem in ltextos]
    tabela2 = np.zeros([50000,4])
    bloblist = [tb(elem) for elem in ltextos]
    diciona = dict()
    h=0
    
    for i, blob in enumerate(bloblist):
        for word in blob.words:
            tabela2[h,0] = n_containing(word, bloblist)
            tabela2[h,1] = todas(word, bloblist)
            tabela2[h,2] = 1 + math.log(tabela2[h,1])
            tabela2[h,3] = math.log(len(bloblist)/tabela2[h,0]) 
            h+=1
        
        #lTF[i] = [tf(word, blob) for word in blob.words]
        #lIDF[i] = [idf(word, bloblist) for word in blob.words]
        #lTFIDF[i] = [tfidf(word, blob, bloblist) for word in blob.words]
        
    #sc = plt.scatter(freqWordsDoc[:,0], freqWordsDoc[:,1])
    #plt.show()
        """
        print("Top words in document {}".format(i + 1))
        scores = {word: tfidf(word, blob, bloblist) for word in blob.words}
        sorted_words = sorted(scores.items(), key=lambda x: x[1], reverse=True)
        for word, score in sorted_words[:3]:
            print("\tWord: {}, TF-IDF: {}".format(word, round(score, 5)))
        """