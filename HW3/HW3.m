%% Vincent Hodgins EECE525 HW 3 

%% Problem 1 -- DT Filter Response
clear
b = [.99893 -.99893];
a = [ 1 -.9978628];
freqz(b,a, 2^15, 44100)
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [1, 10000]);
title("Frequency Response of H(z)");

%% Problem 1 -- CT Filter Response
clear
w = logspace(0,4);
sb = [1 0];
sa = [1 2*pi*15.02];
freqs(sb,sa,w);
title("Frequency Response of Continuous Time filter H(s)")

%% Question 2 -- Plotting Peak Filter & White Noise FFT

clear
G = 12;
g = 10^(G/20);
Ho = g-1;
fc = 700; 
Fs = 44100;
T = 1/Fs;

omega = 200*2*pi;

if g>=1
    alp = (-1 + tan(.5*(omega*T))) / (1 + tan(.5*(omega*T)));
elseif g<1
    alp = (-g + tan(.5*(omega*T))) / (g + g*tan(.5*(omega*T)));
end 

d = -cos(2*pi*fc/Fs);

b = [(1+.5*Ho*(1+alp)) d*(1-alp) -(.5*Ho*(1+alp) + alp)];
a = [1 d*(1-alp) -alp];

Nr = 44100/2;

cl = 50/Nr;
ch = 10000/Nr;

[b,a] = butter(4,[cl, ch],'bandpass');
[h,w] = freqz(b,a, 2^15, 44100);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [1, 10000]);

T = 4;
fs = 44100;
n = T*Fs;
x = randn(1,n);

N = length(x);
X = fft(x);
f = (0:N-1)*(fs/N);
Xmag = abs(X)/N;

subplot(2,1,1);
plot(f, Xmag);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [1, 10000]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title("Frequency Spectrum's of input signal x and peak filtered x")


x2 = filter(b,a,x);


N = length(x2);
X2 = fft(x2);
f = (0:N-1)*(fs/N);
X2mag = abs(X2)/N;

subplot(2,1,2);
hold on
plot(f,X2mag);
ylabel("Magnitude")
yyaxis right
plot(w,(abs(h)));
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [1, 10000]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');



%% Problem 2 -- PSD Response

[Sx1, f1] = pwelch(x,hanning(256),128,2048,44100, 'onesided');
[Sx2, f2] = pwelch(x2,hanning(256),128,2048,44100, 'onesided');
H2 = 20*log10((Sx2 ./ Sx1) .^(.5));
hold on 
% plot(f1,Sx1);
% plot(f2,Sx2);
plot(f1, H2);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [21, 10000]);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');


% yyaxis right
% plot(w,20*log10(abs(h)));
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');

hold off
title("Response to WGN of Transfer function found from PSD approach");
legend(["PSD" "H(\Omega)"])


%% Problem 3
clear all
fc = 1000;
Q = 1; 
Fs = 48000;
Fc = 2*sin(pi*fc/Fs);
Qc = 1/Q;

T = 3;
x = randn(1, Fs*T);


[lp, bp, hp, bs] = hw3p3(fc, Q, x, Fs);

[LP, f1] = pwelch(lp,hanning(256),128,2048,48000, 'onesided');
[BP, f2] = pwelch(bp,hanning(256),128,2048,48000, 'onesided');
[HP, f3] = pwelch(hp,hanning(256),128,2048,48000, 'onesided');
[BS, f4] = pwelch(bs,hanning(256),128,2048,48000, 'onesided');
[X, f4] = pwelch(x,hanning(256),128,2048,48000, 'onesided');


lLP = 10*log10((LP ./ X) .^(.5));
lBP = 10*log10((BP ./ X) .^(.5));
lHP = 10*log10((HP ./ X) .^(.5));
lBS = 10*log10((BS ./ X) .^(.5));

hold on 
plot(f1, lLP);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [21, 10000]);
plot(f2, lBP);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [21, 10000]);
plot(f3, lHP);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [21, 10000]);
plot(f4, lBS);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [21, 10000]);
legend(["LP" "BP" "HP" "BR"]);
ti = sprintf("Dattorro Filtered WGN with parameters f_c=%d, Q=%.1f", fc, Q);
title(ti);

xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

