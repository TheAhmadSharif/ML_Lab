import pickle
import numpy as np
import matplotlib.pyplot as plt
from random import random
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier


def unpickle(file):
    with open(file, 'rb') as f:
        dict = pickle.load(f, encoding="latin1")
    return dict

datadict = unpickle('data/cifar-10-batches-py/data_batch_1')
datadict_test = unpickle('data/cifar-10-batches-py/test_batch')

X = datadict["data"]
Y = datadict["labels"]

X = X.reshape(10000, 3, 32, 32).transpose(0,2,3,1).astype("uint8")
Y = np.array(Y)


X_test = datadict_test["data"]
Y_test = datadict_test["labels"]


labeldict = unpickle('data/cifar-10-batches-py/batches.meta')
label_names = labeldict["label_names"]




X_test = X.reshape(10000, 3, 32, 32).transpose(0,2,3,1).astype("uint8")
Y_test = np.array(Y_test)


print(X.size, '__size__', X_test.size)
print(Y.size, '__size__', Y_test.size)


x = 0;
for a in Y:
    # print(label_names[Y_test[a]], '__test__', label_names[Y[a]])
    if(label_names[Y[a]] != label_names[Y_test[a]]):
        x = x + 1
        # print(label_names[Y_test[a]], '__test__', label_names[Y[a]])

print(x, '_____ x')
def class_acc(pred,gt):
    print(Y)


for i in range(X.shape[0]):
    # Show some images randomly
    if random() > 0.999:
        plt.figure(1);
        plt.clf()
        plt.imshow(X[i])
        plt.title(f"Image {i} label={label_names[Y[i]]} (num {Y[i]})")
        plt.pause(1)
