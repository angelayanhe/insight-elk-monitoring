#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 26 21:26:08 2019

@author: yanhe
"""

def helper(line, dt, header):
    id=int(time.time()*1000)
    recevQ = mesgPat.sub(r'\1', line)
    sendQ = mesgPat.sub(r'\2', line)
    localAdd = mesgPat.sub(r'\3', line)
    localPort = mesgPat.sub(r'\4', line)
    foreignAdd = mesgPat.sub(r'\5', line)
    foreignPort = mesgPat.sub(r'\6', line)
    state = mesgPat.sub(r'\7', line)
    msg='{ "id": "'+ str(id) + '", "epochtime": ' + str(id) + \
    ', "timestamp": "' + dt + '", "Recv-Q":' + recevQ + ', "Send-Q":' +sendQ + \
    ', "LocalPort": "' + localPort +'", "LocalAddress": "' + localAdd + \
    '", "ForeignAddress": "' + foreignAdd + '", "ForeignPort": "' + \
    foreignPort + '", "State": "' + state +'"}'
    print msg
    pload = requests.put('http://54.202.220.36:9200/tcp/_doc/'+str(id),data=msg,headers=header,auth=('elastic', 'changeme'))
    print pload.json()


import os,re,json,requests,time
from datetime import datetime
if __name__ == '__main__':

    header = {
    "Content-Type":"application/json",
    }
    while True:
        s=os.popen('netstat | grep tcp').read().strip().split("\n")
        mesgPat = re.compile(r'^tcp\s+(\d+)\s+(\d+)\s+([\w\-\.]+):(\w*)\s+([\w\.\-]+):(\w+)\s+([_A-Z]+)')
        dt= datetime.fromtimestamp(int(time.time()*1000)/1000).strftime('%Y-%m-%d %H:%M:%S')
        for i in s:
            helper(i,dt,header)
        time.sleep(10)