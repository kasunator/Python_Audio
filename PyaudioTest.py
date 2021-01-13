# -*- coding: utf-8 -*-
"""
Created on Sun Jan 10 17:06:23 2021

@author: Kasun.Beddewela
"""

import pyaudio
import struct
import numpy as np

chunk = 1024  # Record in chunks of 1024 samples
sample_format = pyaudio.paInt16  # 16 bits per sample
channels = 1
fs = 44100  # Record at 44100 samples per second
seconds = 3
filename = "output.wav"

p = pyaudio.PyAudio()  # Create an interface to PortAudio

print('Recording')

stream = p.open(format=sample_format,
                channels=channels,
                rate=fs,
                frames_per_buffer=chunk,
                input=True)

frames = [1,2,3]  # Initialize array to store frames

# Store data in chunks for 3 seconds
#for i in range(0, int(fs / chunk * seconds)):
for i in range(0, 1): # lets just read 1 chunk at a time
    print("interation:" + str(i))
    data = stream.read(chunk)
    #print(len(data))
    #print(data)
    print("data[0]:{} data[1]:{}".format(data[0],data[1]))
    #data_int = np.array(struct.unpack(str(2*chunk)+'B', data), dtype='b')[::2] + 127
    npData = np.fromstring(stream.read(chunk),dtype=np.int16)
    print(npData)
    #frames.append(data)

# Stop and close the stream 
stream.stop_stream()
stream.close()
# Terminate the PortAudio interface
p.terminate()

print('Finished recording')