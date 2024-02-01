%%The code in this file demonstates calculating the
%DFT without using the  fft() function using the
%raw DFT formula
clear all;
close all;
clc;

Fs = 20e3;
Tdur = 1e-3; #this is the duration of the sin wave we want
Freq =  1e3; #this is the frequnecy of the sin wave

tvec = 0:1/Fs:Tdur-1/Fs;
#This is the sinusoidal signal
xn =  sin(2*pi*(Freq*tvec));

#figure
#plot(xn);
#xticks(fvec)
#ylabel(' Sin(x)')
#grid on

figure
plot(tvec, xn)
xlabel('Time in (sec)')
ylabel('applitude in [v]')
#xticks(0:1/Fs:Tdur-1) #This sets the resolution of the grid to T or 1/Freq
#xticks(0:19)
xticks(0:1/Fs:Tdur)
grid on



N = length(xn)

Xk = zeros(1,N);


for  k =0: N-1
    for n =0: N-1
        fprintf("n :  %d, xn( %d) = %e  + j %e \n", n, n+1, real(xn(n+1)), imag(xn(n+1)) );
        addition = xn(n+1)*exp(-j*2*pi*k*n);
        fprintf( " for k = %d, n = %d, addition : ,= %e + j %e \n", k, n, real(addition), imag(addition) );
        Xk(k+1) = Xk(k+1) + addition;
    endfor
    fprintf(" K ; %d, Xk(%d) = %e + j%e \n" , k, k+1 , real(Xk(k+1)) , imag(Xk(k+1)) );
end

fvec = (0:N/2-1)*Fs/N;



figure
#because the output of the fft is complex we have to take avs()
#plot(fvec,Xk);
plot(abs(Xk));
#xticks(fvec)
xlabel('Frequency in [Hz] ');
ylabel(' DFT')
grid on
