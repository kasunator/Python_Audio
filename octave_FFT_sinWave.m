# this code is taken from https://www.youtube.com/watch?v=W1eWGm3hw08
#but we run the fft on a pure sin wave instead of a chirp
# the objective is to understand the  inner details of
#the fft() function
clear all;
close all;
clc;

Fs = 10e6;
Tdur = 8e-6 #this is the duration of the sin wave we want
#Fstart = 500e3;
#Fstop = 1500e3
Freq =  500e3; #this is the frequnecy of the sin wave

tvec = 0:1/Fs:Tdur-1/Fs;
#This is a chirp signal
#xreal = sin(2*pi*(Fstart*tvec + (Fstop-Fstart)/(2*Tdur)*tvec.^2));
Xn =  sin(2*pi*(Freq*tvec));
figure
plot(tvec, Xn)
xlabel('Time in (sec)')
ylabel('applitude in [v]')
xticks(0:1/Freq:Tdur) #This sets the resolution of the grid to T or 1/Freq
grid on

# let the length of the frequency domain signal be Nfft and is shoudl be equal
# to the length of the time domain signal
Nfft = length(Xn);
# we know that our frequnecy domain vector has the nleght of an N fftm we knwo iy will
# go from -5Mhz to 5 Mhz , half of the sampling frequency
fvec = (-Nfft/2:Nfft/2-1)*Fs/Nfft;
#now lets get the frequency domain singal of the xreal and call it xreal_f_dom
# for this we use fft function, but octave implements fft so that the output will
#first have postive frequnecy components and then the negative frequency componenets
#but we want the negative first and postive later for that we use the fftshift()
#fucntion
xreal_f_dom = fft(Xn, Nfft);

#figure
#because the output of the fft is complex we have to take avs()
#plot(fvec,abs(xreal_f_dom));
#xticks(fvec)
#xlabel('Frequency in [Hz] ');
#ylabel('FFT with NO fftshift ')
#grid on

fvecPos = fvec(Nfft/2+1:Nfft)
xreal_f_dom_pos = xreal_f_dom(1:Nfft/2)
figure
plot(fvecPos,abs(xreal_f_dom_pos));
xticks(fvec)
xlabel('Frequency in [Hz] ');
ylabel('FFT with No shift, BUT postive only ')
grid on


xreal_f_dom = fftshift(xreal_f_dom);
figure
#because the output of the fft is complex we have to take avs()
plot(fvec,abs(xreal_f_dom));
xticks(fvec)
xlabel('Frequency in [Hz] ');
ylabel('FFT with fftshift ')
grid on
