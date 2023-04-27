clear
Nr = 44100/2;

cl = 50/Nr;
ch = 10000/Nr;

[b,a] = butter(4,[cl, ch],'bandpass');
freqz(b,a);
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
title("Frequency Response of Transfer function");