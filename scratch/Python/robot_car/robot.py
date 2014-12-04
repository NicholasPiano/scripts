#robot program

#array to store world

world = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]








#array to store movements

movements = [[0,0],
             [0,0],
             [0,0],
             [0,0],
             [0,0]]

#array to store measurements

measurements = ['green', 'green', 'green', 'green', 'green']

#variables to store probabilities

sensor_right = 0.7
p_move = 0.8

#function to move

def move(p, M):
    q = [][]
    for i in range(len(p)):
        for j in range(len(p[0])):
            s = p_move*p[(i+M[0]) % len(p)][(j+M[1]) % len(p[0])]
            q[i].append(s)
    return q
        

#function to sense

def sense():
    

#loops to implement the functions

for i in range(len(p))

#print statements to output results

#Write a code that outputs p after multiplying each entry 
#by pHit or pMiss at the appropriate places. Remember that
#the red cells 1 and 2 are hits and the other green cells
#are misses


p=[0.2,0.2,0.2,0.2,0.2]
pHit = 0.6
pMiss = 0.2

#Enter code here
p[0]*=pMiss
p[1]*=pHit
p[2]*=pHit
p[3]*=pMiss
p[4]*=pMiss

print p

#Modify the code below so that the function sense, which 
#takes p and Z as inputs, will output the NON-normalized 
#probability distribution, q, after multiplying the entries 
#in p by pHit or pMiss according to the color in the 
#corresponding cell in world.


p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green', 'red', 'red', 'green', 'green']
Z = 'red'
pHit = 0.6
pMiss = 0.2

def sense(p, Z):
    q = p
    for i in range(0,5):
        if world[i] == Z:
            q[i] *= pHit
        else:
            q[i] *= pMiss
    return q

print sense(p,Z)

p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green', 'red', 'red', 'green', 'green']
Z = 'red'
pHit = 0.6
pMiss = 0.2

def sense(p, Z):
    q = []
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    sum1 = sum(q)
    r = []
    for i in range(len(p)):
        r.append(q[i]/sum1)
    return r
print sense(p,Z)

p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green', 'red', 'red', 'green', 'green']
Z = 'red'
pHit = 0.6
pMiss = 0.2

def sense(p, Z):
    q = []
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    sum1 = sum(q)
    r = []
    for i in range(len(p)):
        r.append(q[i]/sum1)
    return r
print sense(p,Z)

#Modify the code so that it updates the probability twice
#and gives the posterior distribution after both 
#measurements are incorporated. Make sure that your code 
#allows for any sequence of measurement of any length.

p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
pHit = 0.6
pMiss = 0.2

def sense(p, M):
    q = p
    for Z in M:
        for i in range(len(q)):
            if world[i] == Z:
                q[i] *= pHit
            else:
                q[i] *= pMiss
        sum1 = sum(q)
        for i in range(len(q)):
            q[i] /= sum1
    return q
    
print sense(p, measurements)

#Program a function that returns a new distribution 
#q, shifted to the right by U units. If U=0, q should 
#be the same as p.

p=[0, 1, 0, 0, 0]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
pHit = 0.6
pMiss = 0.2

def sense(p, Z):
    q=[]
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    s = sum(q)
    for i in range(len(q)):
        q[i] = q[i] / s
    return q

def move(p, U):
    q = p
    u = abs(U)
    if U > 0:
        for i in range(u):
            q.insert(0, q.pop())
    else:
        for i in range(u):
            q.append(q.pop(0))
    return q

print move(p, 4)

#Modify the move function to accommodate the added 
#probabilities of overshooting or undershooting 
#the intended destination.

p=[0, 1, 0, 0, 0]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
pHit = 0.6
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1

def sense(p, Z):
    q=[]
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    s = sum(q)
    for i in range(len(q)):
        q[i] = q[i] / s
    return q

def move(p, U):
    q = []
    for i in range(len(p)):
        exact = (p[(i-U)]%len(p))*pExact
        over = (p[(i-U-1)]%len(p))*pOvershoot
        under = (p[(i-U+1)]%len(p))*pUndershoot
        q.append(exact + over + under)
    return q
r = []
for i in range(50):
    r = move(p,1)
    p = r
print p

#Write code that makes the robot move twice and then prints 
#out the resulting distribution, starting with the initial 
#distribution p = [0, 1, 0, 0, 0]

p=[0, 1, 0, 0, 0]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
pHit = 0.6
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1

def sense(p, Z):
    q=[]
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    s = sum(q)
    for i in range(len(q)):
        q[i] = q[i] / s
    return q

def move(p, U):
    q = []
    for i in range(len(p)):
        s = pExact * p[(i-U) % len(p)]
        s = s + pOvershoot * p[(i-U-1) % len(p)]
        s = s + pUndershoot * p[(i-U+1) % len(p)]
        q.append(s)
    return q
#
# ADD CODE HERE
#
print move(p,1)

#write code that moves 1000 times and then prints the 
#resulting probability distribution.

p=[0, 1, 0, 0, 0]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
pHit = 0.6
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1

def sense(p, Z):
    q=[]
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    s = sum(q)
    for i in range(len(q)):
        q[i] = q[i] / s
    return q

def move(p, U):
    q = []
    for i in range(len(p)):
        s = pExact * p[(i-U) % len(p)]
        s = s + pOvershoot * p[(i-U-1) % len(p)]
        s = s + pUndershoot * p[(i-U+1) % len(p)]
        q.append(s)
    return q
#
# ADD CODE HERE
#
print p

#Given the list motions=[1,1] which means the robot 
#moves right and then right again, compute the posterior 
#distribution if the robot first senses red, then moves 
#right one, then senses green, then moves right again, 
#starting with a uniform prior distribution.

p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
motions = [1,1]
pHit = 0.6
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1

def sense(p, Z):
    q=[]
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    s = sum(q)
    for i in range(len(q)):
        q[i] = q[i] / s
    return q

def move(p, U):
    q = []
    for i in range(len(p)):
        s = pExact * p[(i-U) % len(p)]
        s = s + pOvershoot * p[(i-U-1) % len(p)]
        s = s + pUndershoot * p[(i-U+1) % len(p)]
        q.append(s)
    return q
#
# ADD CODE HERE
#
print p

#Modify the previous code so that the robot senses red twice.

p=[0.2, 0.2, 0.2, 0.2, 0.2]
world=['green', 'red', 'red', 'green', 'green']
measurements = ['red', 'green']
motions = [1,1]
pHit = 0.6
pMiss = 0.2
pExact = 0.8
pOvershoot = 0.1
pUndershoot = 0.1

def sense(p, Z):
    q=[]
    for i in range(len(p)):
        hit = (Z == world[i])
        q.append(p[i] * (hit * pHit + (1-hit) * pMiss))
    s = sum(q)
    for i in range(len(q)):
        q[i] = q[i] / s
    return q

def move(p, U):
    q = []
    for i in range(len(p)):
        s = pExact * p[(i-U) % len(p)]
        s = s + pOvershoot * p[(i-U-1) % len(p)]
        s = s + pUndershoot * p[(i-U+1) % len(p)]
        q.append(s)
    return q

for k in range(len(measurements)):
    p = sense(p, measurements[k])
    p = move(p, motions[k])
    
print p

######################final

colors = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]

measurements = ['green', 'green', 'green' ,'green', 'green']


motions = [[0,0],[0,1],[1,0],[1,0],[0,1]]

sensor_right = 0.7

p_move = 0.8

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT

p = []

######################################################################

colors = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]

measurements = ['green', 'green', 'green' ,'green', 'green']


motions = [[0,0],[0,1],[1,0],[1,0],[0,1]]

sensor_right = 0.7

p_move = 0.8

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT

p = colors
size = 1.0/(len(p)*len(p[0])) #uniform probability distribution
for n in range(len(p)):
    for k in range(len(p[0])):
        p[n][k] = size #initialize each element

def move(p, M):
    q = p
    for i in range(len(p)):
        for j in range(len(p[0])):
            move = p[(i - M[0])%len(p)][(j - M[1])%len(p[0])]*p_move
            stay = p[(i - M[0])%len(p)][(j - M[1])%len(p[0])]*(1-p_move)
            q[i][j] = move + stay
    return q

def sense(p, Z):
    q = p
    for i in range(len(p)):
        for j in range(len(p[0])):
            hit = (Z == world[i][j])
            q[i][j] = p[i][j]*(hit*sensor_right + (1-hit)*(1-sensor-right))
            
    return normalize(q)
    
def normalize(p):
    sum = 0
    q = p
    for i in range(len(p)):
        for j in range(len(p[0])):
            sum += p[i][j]
    for i in range(len(p)):
        for j in range(len(p[0])):
            q[i][j] /= sum
    return q
            

#Your probability array must be printed 
#with the following code.

r = []
for i in range(len(motions)):
    r = move(p, motions[i])
    r = sense(p, measurements[i])
    
    show(p)

#################################################################
colors = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]

measurements = ['green', 'green', 'green' ,'green', 'green']


motions = [[0,0],[0,1],[1,0],[1,0],[0,1]]

sensor_right = 0.7

p_move = 0.8

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT

def move(mo, M):
    q = mo
    for i in range(len(mo)):
        for j in range(len(mo[0])):
            move = mo[(i - M[0])%len(mo)][(j - M[1])%len(mo[0])]*p_move
            stay = mo[i%len(mo)][j%len(mo[0])]*(1-p_move)
            q[i][j] = move + stay
    return q

def sense(sen, Z):
    q = sen
    for i in range(len(sen)):
        for j in range(len(sen[0])):
            #print colors[i][j]
            hit = (Z == colors[i][j])
            q[i][j] = sen[i][j]*(hit*sensor_right + (1-hit)*(1-sensor_right))
    #print "q"
    #show1(q)
    norm = normalize(q)
    #print "norm"
    #show1(norm)
            
    return norm
    
def normalize(nor):
    sum = 0
    q = nor
    for i in range(len(nor)):
        for j in range(len(nor[0])):
            sum += nor[i][j]
    for i in range(len(nor)):
        for j in range(len(nor[0])):
            q[i][j] /= sum
    return q
            
def show1(sho):
    for i in range(len(sho)):
        print "[",
        for j in range(len(sho[0])):
            print str(sho[i][j])[:5] + ", ",
        print "]"

#Your probability array must be printed 
#with the following code.

p = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
size = 1.0/(len(p)*len(p[0])) #uniform probability distribution
for n in range(len(p)):
    for k in range(len(p[0])):
        p[n][k] = size #initialize each element

r = []
for i in range(len(motions)):
    r = move(p, motions[i])
    r = sense(p, measurements[i])
    show1(r)
    p = r
    print "next"

############################################################

colors = [['red', 'green', 'green', 'red' , 'red'],
          ['red', 'red', 'green', 'red', 'red'],
          ['red', 'red', 'green', 'green', 'red'],
          ['red', 'red', 'red', 'red', 'red']]

measurements = ['green', 'green', 'green' ,'green', 'green']


motions = [[0,0],[0,1],[1,0],[1,0],[0,1]]

sensor_right = 0.7

p_move = 0.8

def show(p):
    for i in range(len(p)):
        print p[i]

#DO NOT USE IMPORT
#ENTER CODE BELOW HERE
#ANY CODE ABOVE WILL CAUSE
#HOMEWORK TO BE GRADED
#INCORRECT

def move(mo, M):
    q = mo
    for i in range(len(mo)):
        for j in range(len(mo[0])):
            move = mo[(i - M[0])%len(mo)][(j - M[1])%len(mo[0])]*p_move
            stay = mo[i%len(mo)][j%len(mo[0])]*(1-p_move)
            q[i][j] = move + stay
    return q

def sense(sen, Z):
    q = sen
    for i in range(len(sen)):
        for j in range(len(sen[0])):
            #print colors[i][j]
            hit = (Z == colors[i][j])
            q[i][j] = sen[i][j]*(hit*sensor_right + (1-hit)*(1-sensor_right))
            
    return normalize(q)
    
def normalize(nor):
    sum = 0
    q = nor
    for i in range(len(nor)):
        for j in range(len(nor[0])):
            sum += nor[i][j]
    for i in range(len(nor)):
        for j in range(len(nor[0])):
            q[i][j] /= sum
    return q

#Your probability array must be printed 
#with the following code.

p = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
size = 1.0/(len(p)*len(p[0])) #uniform probability distribution
for n in range(len(p)):
    for k in range(len(p[0])):
        p[n][k] = size #initialize each element

r = []
for i in range(len(motions)):
    r = move(p, motions[i])
    r = sense(p, measurements[i])
    show(r)
    p = r
