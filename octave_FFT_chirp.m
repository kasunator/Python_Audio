# this code is taken from https://www.youtube.com/watch?v=W1eWGm3hw08
clear all;
close all;
clc;

Fs = 10e6;
Tdur = 100e-6
Fstart = 500e3;
Fstop = 1500e3
tvec = 0:1/Fs:Tdur-1/Fs;
#This is a chirp signal
xreal = sin(2*pi*(Fstart*tvec + (Fstop-Fstart)/(2*Tdur)*tvec.^2));

figure
plot(tvec,xreal)
xlabel('Time in (sec)')
ylabel('applitude in [v]')
grid on

# let the length of the frequency domain signal be Nfft and is shoudl be equal
# to the length of the time domain signal
Nfft = length(xreal);
# we know that our frequnecy domain vector has the length of an N fftm we know it will
# go from -5Mhz to 5 Mhz , half of the sampling frequency
fvec = (-Nfft/2:Nfft/2-1)*Fs/Nfft;
#now lets get the frequency domain singal of the xreal and call it xreal_f_dom
# for this we use fft function, but octave implements fft so that the output will
#first have postive frequnecy components and then the negative frequency componenets
#but we want the negative first and postive later for that we use the fftshift()
#fucntion
xreal_f_dom = fft(xreal, Nfft);
xreal_f_dom = fftshift(xreal_f_dom);
figure
#because the output of the fft is complex we have to take avs()
plot(fvec,abs(xreal_f_dom));
xlabel('Frequency in [Hz] ');
ylabel('Amplitude ')
grid on
