#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: James Alves
"""

import numpy as np
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import StratifiedKFold
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report, accuracy_score
from TE import TE

def KNN( X, y, classname ):
    print ('Classifier: K-Nearest Neighbor\n')
    skf = StratifiedKFold(n_splits=10, shuffle=True)
    knn = KNeighborsClassifier(n_neighbors=3)

    y_pred_overall = []
    y_test_overall = []

    for train_index, test_index in skf.split(X, y):
        X_train, X_test = X[train_index], X[test_index]
        y_train, y_test = y[train_index], y[test_index]
        knn.fit(X_train, y_train)
        y_pred = knn.predict(X_test)
        y_pred_overall = np.concatenate([y_pred_overall, y_pred])
        y_test_overall = np.concatenate([y_test_overall, y_test])

    print ('KNN Classification Report: ')
    print (classification_report(y_test_overall, y_pred_overall, target_names=classname, digits=3))
    print ('Accuracy=', '%.2f %%' % (100*accuracy_score(y_test_overall, y_pred_overall)))
    print ('KNN Confusion Matrix: ')
    print (confusion_matrix(y_test_overall, y_pred_overall))


if __name__ == '__main__':
    f = "./Tennessee_Eastman/te/out/all.csv"
    te = TE()
    delimiter = '\t'
    dados = te.labelledcsvread(f, delimiter) 
    X = dados[0] #dados
    y = dados[3] #target
    classname = np.unique(dados[2]) #target_names
    KNN( X, y, classname )
