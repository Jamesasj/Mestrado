#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: James Alves
"""

import numpy as np
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
from sklearn.model_selection import StratifiedKFold
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report, accuracy_score
from TE import TE

def QDA( X, y, classname ):
    print ('Classifier: Quadratic Discriminant Analysis\n')
    skf = StratifiedKFold(n_splits=10, shuffle=True)
    clf = QuadraticDiscriminantAnalysis()

    y_pred_overall = []
    y_test_overall = []

    for train_index, test_index in skf.split(X, y):
        X_train, X_test = X[train_index], X[test_index]
        y_train, y_test = y[train_index], y[test_index]
        clf.fit(X_train, y_train)
        y_pred = clf.predict(X_test)
        y_pred_overall = np.concatenate([y_pred_overall, y_pred])
        y_test_overall = np.concatenate([y_test_overall, y_test])

    print ('Quadratic Discriminant Analysis Report: ')
    print (classification_report(y_test_overall, y_pred_overall, target_names=classname, digits=3))
    print ('Accuracy=', '%.2f %%' % (100*accuracy_score(y_test_overall, y_pred_overall)))
    print ('QDA Confusion Matrix: ')
    print (confusion_matrix(y_test_overall, y_pred_overall))


if __name__ == '__main__':
    f = "./Tennessee_Eastman/te/out/all.csv"
    te = TE()
    delimiter = '\t'
    dados = te.labelledcsvread(f, delimiter) 
    X = np.array(dados[0]) #dados
    y = np.array(dados[3]) #target
    classname = np.unique(dados[2]) #target_names
    QDA( X, y, classname )
