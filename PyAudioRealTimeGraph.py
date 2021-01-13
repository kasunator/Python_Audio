# -*- coding: utf-8 -*-
"""
Created on Sun Jan 10 18:08:16 2021

@author: Kasun.Beddewela
"""

#tk did not work for me in windows anaconda

import pyaudio
import struct
import numpy as np 
import matplotlib.pyplot as plt



CHUNK = 1024*4
FORMAT = pyaudio.paInt16
CHANNELS =1 
RATE =44100

p= pyaudio.PyAudio()
stream = p.open(
    format= FORMAT,
    channels=CHANNELS,
    rate=RATE,
    input=True,
    output=True,
    frames_per_buffer=CHUNK
)


fig,ax = plt.subplots()
#numpy.arange([start, ]stop, [step, ]dtype=None)¶
x =np.arange(0,2*CHUNK,2)
line, = ax.plot(x, np.random.rand(CHUNK)) # put a random number for now
ax.set_ylim(-32768 ,32768 )
ax.set_xlim(0,CHUNK)

while True:
    data = stream.read(CHUNK)
    #data_int = np.array(struct.unpack(str(2*CHUNK)+'B', data), dtype='b')[::2] + 127
    data_int = np.fromstring(stream.read(CHUNK),dtype=np.int16)
    line.set_ydata(data_int)
    fig.canvas.draw()
    fig.canvas.flush_events()
    