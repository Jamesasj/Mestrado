from __future__ import print_function
"""
========================================
VISUALIZE TENNESSEE EASTMAN VARIABLES
========================================
"""

import numpy as np
import matplotlib.pyplot as plt
import csv


class TE():
    """ Tennessee Eastman Simulator Data Reading and Manipulation
    Parameters
    ----------

    Attributes
    ----------
    Each training data file contains 480 rows and 52 columns and
    each testing data file contains 960 rows and 52 columns.
    An observation vector at a particular time instant is given by

    x = [XMEAS(1), XMEAS(2), ..., XMEAS(41), XMV(1), ..., XMV(11)]^T
    where XMEAS(n) is the n-th measured variable and
    XMV(n) is the n-th manipulated variable.
    """
    
    XMEAS = ['Input Feed - A feed (stream 1)'	,       	#	1
        'Input Feed - D feed (stream 2)'	,       	#	2
        'Input Feed - E feed (stream 3)'	,       	#	3
        'Input Feed - A and C feed (stream 4)'	,       	#	4
        'Miscellaneous - Recycle flow (stream 8)'	,	#	5
        'Reactor feed rate (stream 6)'	,                 	#	6
        'Reactor pressure'	,                           	#	7
        'Reactor level'	,                                	#	8
        'Reactor temperature'	,                           	#	9
        'Miscellaneous - Purge rate (stream 9)'	,       	#	10
        'Separator - Product separator temperature'	,	#	11
        'Separator - Product separator level'	,       	#	12
        'Separator - Product separator pressure'	,	#	13
        'Separator - Product separator underflow (stream 10)'	,	#	14
        'Stripper level'	,                           	#	15
        'Stripper pressure'	,                           	#	16
        'Stripper underflow (stream 11)'             	,	#	17
        'Stripper temperature'	,                           	#	18
        'Stripper steam flow'	,                           	#	19
        'Miscellaneous - Compressor work'	,       	#	20
        'Miscellaneous - Reactor cooling water outlet temperature'	,	#	21
        'Miscellaneous - Separator cooling water outlet temperature'	,	#	22
        'Reactor Feed Analysis - Component A'	,	#	23
        'Reactor Feed Analysis - Component B'	,	#	24
        'Reactor Feed Analysis - Component C'	,	#	25
        'Reactor Feed Analysis - Component D'	,	#	26
        'Reactor Feed Analysis - Component E'	,	#	27
        'Reactor Feed Analysis - Component F'	,	#	28
        'Purge gas analysis - Component A'	,	#	29
        'Purge gas analysis - Component B'	,	#	30
        'Purge gas analysis - Component C'	,	#	31
        'Purge gas analysis - Component D'	,	#	32
        'Purge gas analysis - Component E'	,	#	33
        'Purge gas analysis - Component F'	,	#	34
        'Purge gas analysis - Component G'	,	#	35
        'Purge gas analysis - Component H'	,	#	36
        'Product analysis -  Component D'	,	#	37
        'Product analysis - Component E'	,	#	38
        'Product analysis - Component F'	,	#	39
        'Product analysis - Component G'	,	#	40
        'Product analysis - Component H']		#	41
			
    XMV = ['D feed flow (stream 2)'	,                 	#	1
        'E feed flow (stream 3)'	,                 	#	2
        'A feed flow (stream 1)'	,                 	#	3
        'A and C feed flow (stream 4)'	,                 	#	4
        'Compressor recycle valve'	,                 	#	5
        'Purge valve (stream 9)'	,                 	#	6
        'Separator pot liquid flow (stream 10)'	,       	#	7
        'Stripper liquid product flow (stream 11)'	,	#	8
        'Stripper steam valve'	,                           	#	9
        'Reactor cooling water flow'	,                 	#	10
        'Condenser cooling water flow'	,                 	#	11
        'Agitator speed']             # constant 50%			12

    def var_category_str(self, featnr):
        '''Returning string with the original category 'XMEAS #' or 'XMV #'
        '''
        if featnr < 41:
            name = 'XMEAS (' + str(featnr+1) + '): '
        else:
            name = 'XMV (' + str(featnr+1-41) + '): '
        return name


    def __init__(self):
        #print('Executing __init__() ....')

        self.Xtrain = None
        self.Xtest = None
        self.featname = self.XMEAS + self.XMV
        self.extendedfeatname = list(self.featname)
        self.numfeat = len(self.featname)
        for i in range(self.numfeat):
            self.extendedfeatname[i] = self.var_category_str(i) + self.featname[i]
        #print('TE.extendedfeatname=', self.extendedfeatname);
        #print('TE.featname=', self.featname); quit()

    def standardize(self):
        print('Data standardization to zero mean and unit variance...')
        X = self.Xtrain
        #print('\nTraining dataset before standardization=\n', X)
        #print('\nTest dataset before standardization=\n', self.Xtest)
        self.meanX = np.mean(X, axis=0)
        # ddof=1 ==> divide by (n-1) --- ddof=0 ==> divide by n
        ddof_std = 0    # https://docs.scipy.org/doc/numpy-1.15.1/reference/generated/numpy.std.html#numpy.std
        self.stdX = X.std(axis=0, ddof=ddof_std)

        #print('Dataset statistic:\n Mean=', meanX, '\nStandard deviation=\n', stdX)
        #minX = X.min(axis=0)
        #maxX = X.max(axis=0)
        #print('Dataset statistic:\nMin=', minX, '\nMax=', maxX )

        self.Xcentered_train = X - self.meanX
        #print('Dataset X=\n', X, '\nDataset centralized Xcentered_train=\n', self.Xcentered_train)
        self.Xstandardized_train = self.Xcentered_train / self.stdX
        #print('Dataset standadized Xstandardized_train=\n', self.Xstandardized_train)

        self.Xcentered_test = self.Xtest - self.meanX
        self.Xstandardized_test = self.Xcentered_test / self.stdX 


    def labelledcsvread(self, filename, delimiter = '\t'):

        f = open(filename, 'r')
        reader = csv.reader(f, delimiter=delimiter)
        ncol = len(next(reader)) # Read first line and count columns
        nfeat = ncol-1
        f.seek(0)              # go back to beginning of file
        #print('ncol=', ncol)
        
        x = np.zeros(nfeat)
        X = np.empty((0, nfeat))
        y = []
        for row in reader:
            #print(row)
            for j in range(nfeat):
                x[j] = float(row[j])
                #print('j=', j, ':', x[j])
            X = np.append(X, [x], axis=0)
            label = row[nfeat]
            y.append(label)
            #print('label=', label)
            #quit()
        #print('X.shape=\n', X.shape)#, '\nX=\n', X)
        #print('y=\n', y)
        
        
        # Resubsitution for all methods
        from sklearn.preprocessing import LabelEncoder
        from LabelBinarizer2 import LabelBinarizer2
        lb = LabelBinarizer2()
        Y = lb.fit_transform(y)
        classname = lb.classes_
        #print('lb.classes_=', lb.classes_, '\nY=\n',Y)

        le = LabelEncoder()
        ynum = le.fit_transform(y)
        #print(ynum)
        
        return X, Y, y, ynum, classname


    def plot_condition(self, X, y, classlabel, classname, featname, plot_time_axis=True, title=None):
        '''Given a set of patters with class label, plot in 2D.
        If the time axis option is true, plot the postion in time, following
        the order in the data matrix X (first pattern X[0] at t=0
        '''
        print ('Generating 2-D plot ...')
        #print('X=\n', X.shape, '\nclassname=', classname)
        numclasses = len(classname)
        xlab = featname[0]
        ylab = featname[1]
        fig, ax = plt.subplots(); # Create a figure and a set of subplots
        colors = 'bry'
        cmap = plt.get_cmap('gnuplot')
        colors = [cmap(i) for i in np.linspace(0, 1, numclasses)]

        #plot_time_axis=False   # DEBUG
        if plot_time_axis:
            from mpl_toolkits.mplot3d import Axes3D
            title = title + ' 2-D with time evolution'
            zlab = 't'
            ax = Axes3D(fig, azim=-45, elev=30)
            ax.set_title(title)
            ax.set_xlabel(xlab)
            #ax.w_xaxis.set_ticklabels([])
            ax.set_ylabel(ylab)
            #ax.w_yaxis.set_ticklabels([])
            ax.set_zlabel(zlab)
            #ax.w_zaxis.set_ticklabels([])
            toffset = 0
            for i in range(numclasses):
                idx = np.where(y == i)
                numpts = len(idx[0])
                t = np.linspace(toffset, toffset+numpts-1, numpts)
                toffset += numpts
                ax.scatter(X[idx, 0], X[idx, 1], t, c=colors[i], label=classname[i])
            #ax.set_zlim(bottom=0, top=toffset+numpts)
        else:
            for i, color in zip(classlabel, colors):
                idx = np.where(y == i)
                plt.scatter(X[idx, 0], X[idx, 1], c=color, label=classname[i],
                        cmap=plt.cm.Paired, edgecolor='black', s=20)
            plt.xlabel(xlab)
            plt.ylabel(ylab)
            plt.title(title)
        plt.legend()
        plt.axis('tight')
        plt.show()


    def plotscatter(self, datafile, feat1, feat2, title='Tennessee Eastman: Classes in Feature Space'):
        delimiter = '\t'
        X, Y, y, ynum, classname = self.labelledcsvread(filename=datafile, delimiter=delimiter)

        labels = ynum
        classes = classname
        classlabel = np.unique(ynum)

        X2feat = X[:, [feat1,feat2]] # only two features can be visualized directly

        X = X2feat
        y = ynum
        colors = 'bry'
        cmap = plt.get_cmap('gnuplot')
        colors = [cmap(i) for i in np.linspace(0, 1, 2)]

        # standardize
        mean = X.mean(axis=0)
        std = X.std(axis=0)
        #print('mean=', mean, 'std=', std)
        X = (X - mean) / std
        #featname = [self.featname[feat1], self.featname[feat2]]
        featname = [self.extendedfeatname[feat1], self.extendedfeatname[feat2]]
        self.plot_condition(X, y, classlabel, classname, featname, plot_time_axis=True, title=title)


    def datacsvreadTE(self, filename, delimiter = ' '):

        print('===> Reading TE data from file ', filename, '...')
        f = open(filename, 'rt')
        reader = csv.reader(f, delimiter=delimiter)
        row1 = next(reader)
        ncol = len(row1) # Read first line and count columns
        # count number of non-empty strings in first row
        nfeat = 0
        for j in range(ncol):
            cell = row1[j]
            if cell != '':
                nfeat = nfeat + 1
                #print('%.2e' % float(cell))

        f.seek(0)              # go back to beginning of file
        #print('ncol=', ncol, 'nfeat=', nfeat)
        
        x = np.zeros(nfeat)
        X = np.empty((0, nfeat))
        r = 0
        for row in reader:
            #print(row)
            c = 0
            ncol = len(row)
            for j in range(ncol):
                cell = row[j]
                if cell != '':
                    x[c] = float(cell)
                    #print('r=%4d' % r, 'j=%4d' % j, 'c=%4d' % c, 'x=%.4e' % x[c])
                    c = c + 1
            r = r + 1
            X = np.append(X, [x], axis=0)
            #if r > 0: # DBG
            #    break
        #print('X.shape=\n', X.shape)#, '\nX=\n', X)
        return X

    def filter_vars(self, X, mask):
        return X[:,np.array(mask,dtype=int)], list(np.array(self.extendedfeatname)[mask])

    def visualize_vars(self, infile=None, X=None, dropfigfile=None, title=None, mask=None):

        if not infile is None:
            if X is None:
                print('===> Reading TE data from file ', infile, '...')
                X = self.datacsvreadTE(infile)
            else:
                print('Data X exist. Ignoring infile...')

        featname = self.extendedfeatname
        #print('featname=',featname,'mask=',mask)
        if not mask is None:
            '''
            mask = np.array(mask,dtype=int)
            X = X[:,mask]
            featname = list(np.array(extendedfeatname)[mask])
            '''
            X, featname = self.filter_vars(X, mask)

        n, d = X.shape
        #print(X)
        tsfig = plt.figure(2, figsize=(40,30))
        for j in range(d):
            ts = X.T[j,:]
            ts = ts / np.mean(ts) + j
            #print('Feat#', j+1, '=', ts)
            plt.plot(ts, linewidth=0.5)

        if not title is None:
            plt.title(title)
        # Legend ouside plot:
        # https://stackoverflow.com/questions/4700614/how-to-put-the-legend-out-of-the-plot
        #plt.legend(featname, fontsize=7, loc='best')
        #plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', mode='expand')
        #plt.tight_layout(pad=70)
        #plt.legend(featname, fontsize=7, loc='best', bbox_to_anchor=(0.5, 0., 1.0, 0.5))
        plt.legend(featname, fontsize=7, loc='center left', bbox_to_anchor=(0.85, 0.60),
                fancybox=True, shadow=True, ncol=1)
        if not dropfigfile is None:
            print('Saving figure in ', dropfigfile)
            plt.savefig(dropfigfile, dpi=1200)
        plt.show()


def main():
    print('Executing main() ....')

    f = './Tennessee_Eastman/TE_process/data/d16.dat'
    f = './Tennessee_Eastman/TE_process/data/d16_te.dat'

    #visualize_vars(infile=f, dropfigfile='/tmp/outfig.svg')
    
    te = TE()
    #te.plotscatter('/home/thomas/Dropbox/software/TE/Tennessee_Eastman/te/out/all.csv')
    te.visualize_vars(infile=f, dropfigfile='/tmp/outfig.svg', title='Todas as variaveis')


    feat1 = 49 # First feature
    feat2 = 12 # Second feature
    te.plotscatter("./Tennessee_Eastman/te/out/all.csv", feat1, feat2)
    te.visualize_vars(infile=f, dropfigfile='/tmp/outfig1.svg', title='Subconjunto de variaveis', mask=[feat1,feat2])

if __name__ == "__main__":
    main()
