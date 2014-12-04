#!usr/bin/python3

#python script to be left running checking the internet connection constantly

from os import system
from time import time

def ping(host):
  return system('ping -c 1 ' + host + ' | sed "/.*time=.*/!d; s/.*time=//"')

start = time()


for i in range(10):
  response = ping('www.google.com')
  #print(response)


#get command line options
#arrays for storing results of tests on every timestep
#timer for counting
#print statements for console or file