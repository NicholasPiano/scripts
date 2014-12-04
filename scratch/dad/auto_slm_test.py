#!usr/bin/python

#slm test runner
#goal: find optimum parameter set
#condition: maximum percentage coherence

#packages
import os
import re
import time

#result arrays
result_array = []
time_array = []

time_array["start"] = time.clock()
start = time_array["start"]

########################################### CHANGE FOR INDIVIDUAL PARAMETER
print "##### reading template..."
f = open("SLMDIRECT_TESTGRAMMAR_nuance9_wrapper.grxml", "r")
content = f.read() #returns array
f.close()
###########################################

test = 0 #printing

#start loop - changes single parameter by increments and reruns compile and test
for p in range(1001): #parameter in wrapper file goes from 0 to 1.
    time_array[str(p) + "_start"] = time.clock() - start

    ########################################### CHANGE FOR INDIVIDUAL PARAMETER
    #write value to .xml file
    f_template = open("SLMDIRECT_TESTGRAMMAR_nuance9_wrapper.grxml", "w")
    f_template.write(content[:501] + str(p/1000.0) + content[506:])
    f_template.close()
    time_array[str(p) + "_filewrite"] = time.clock() - start
    ###########################################

    #run Nuance grammar compiler
    os.system("sgc -train SLMDIRECT_TESTGRAMMAR_nuance9_training_slm_fsm.xml -no_gram")
    os.system("ssm_train SLMDIRECT_TESTGRAMMAR_nuance9_training_ssm.xml")
    os.system("sgc -optimize 9 SLMDIRECT_TESTGRAMMAR_nuance9_wrapper.grxml")
    time_array[str(p) + "_compiler"] = time.clock() - start

    #Perform recognition test
    os.system("acc_test acc_test.TEST.1001.script.txt -local_log acc_test.TEST.1001.log-file")
    time_array[str(p) + "_test"] = time.clock() - start

    #parse umt file and apply formulas
    utd = open("acc_test.TEST.1001.utd.txt", "r")
    data = []
    while utd:
        temp = []
        utd_content = utd.readline()
        if utd_content == "":
            break
        utd_content = re.sub(r'c:/EIG/voice-data/', '', utd_content)
        temp.extend(utd_content.split(':'))
        data.append(temp)

    #go through data array with formulas
    #result arrays
    L = []
    M = []
    N = []
    P = []
    Q = []
    V = []
    I = []
    #constants
    C2 = 11 #SSM confidence threshold
    C3 = 0.0 #-1446.23 #Score threshold
    #truth
    truth = open("truth.txt", "r")
    truth_array = []
    while truth:
        truth_content = truth.readline()
        if truth_content == "":
            break
        truth_array.append(truth_content)
    I = truth_array
    #loop - L then M, N, (P, Q), V
    for d in range(len(data)):
        Id = I[d]
        AN = data[d][10]
        AO = data[d][11]
        AQ = data[d][13]
        AR = data[d][14]
        #L
        if re.search("tO", AR)!=None: #"slotOverride"
            L.append(1)
        else:
            L.append(0)
        #M
        if L[d]==1 and AR[2:(len(Id)-2)]==Id[2:-2]:
            M.append(1)
        else:
            M.append(0)
        #N
        if M[d]==1 or AR==Id or (re.search("#", AR)!=None and Id!="" and AR[1:len(Id)]==Id):
            N.append(1)
        else:
            N.append(0)
        #P
        if Id!="" and re.search("Invalid", Id)==None and re.search("OOV", AQ)==None:
            P.append(1)
        else:
            P.append(0)
        #Q
        if P[d]==1 and N[d]==1 and (AN>C2 or (AN<C2 and AO>C3)):
            Q.append(1)
        else:
            Q.append(0)
        #V
        if P[d]==1 and N[d]==1 and AN>C2 and re.search("Invalid", AR)==None:
            V.append(1)
        else:
            V.append(0)
    #final results
    B6 = sum(P)
    B7 = sum(Q)
    B16 = sum(V)
    E6 = B6 + B16
    E7 = B7 + B16
    percentage = (E7/E6)*100
    #store final result
    result_array.append(pencentage)
    time_array[str(p) + "_formulas"] = time.clock() - start

    #print info
    if test==0:
        print "estimate time to completion is " + str(time.clock()/1000.0/60.0) + "minutes"
        test = 1
    print "parameter: " + str(p) + " percentage: " + str(percentage)
    print str(p/10.0) + "% completed"

#print results to octave file
print "writing to file..."
oc = open("graph.m", "w")
oc.write("x = 0:0.001:1;\n")
oc.write("y = [")
for t in result_array:
    oc.write(str(t) + " ")
oc.write("];\n")
oc.write("plot(x,y);\n")
oc.write("print('graph.png');")
