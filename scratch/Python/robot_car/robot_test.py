#!usr/bin/python

colors = [['green', 'green', 'green'],
          ['green', 'red', 'red'],
          ['green', 'green', 'green']]

measurements = ['red', 'red']

motions = [[0,0], [0,1]]

sensor_right = 0.8

p_move = 1.0

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT

def move(mo, M):
    l = []
    for i in range(len(mo)):
        q = []
        for j in range(len(mo[0])):
            move = mo[(i - M[0])%len(mo)][(j - M[1])%len(mo[0])]*p_move
            q.append(move)
        l.append(q)
    return l

def sense(sen, Z):
    l = []
    for i in range(len(sen)):
        q = []
        for j in range(len(sen[0])):
            hit = (Z == colors[i][j])
            q.append(sen[i][j]*(hit*sensor_right + (1-hit)*(1-sensor_right)))
        l.append(q)
    return normalize(l)
    
def normalize(nor):
    sum = 0
    for i in range(len(nor)):
        for j in range(len(nor[0])):
            sum += nor[i][j]
    for i in range(len(nor)):
        for j in range(len(nor[0])):
            nor[i][j] /= sum
    return nor

#Your probability array must be printed 
#with the following code.

p = [[0,0,0],[0,0,0],[0,0,0]]
size = 1.0/(len(p)*len(p[0])) #uniform probability distribution
for n in range(len(p)):
    for k in range(len(p[0])):
        p[n][k] = size #initialize each element

r = []
w = []
for i in range(len(motions)):
    r = move(p, motions[i])
    w = sense(r, measurements[i])
    show(w)
    p = w
