function y = hw3p2(x, fc, Q, G, Fs)
%hw3q2:  Applies a 2nd order peak filter specified by fc, G, and Q
%        to input time vector x with sampling rate Fs. Then plots the
%        resulting filter.
%
%       y : Output - Peak filtered signal
%       x : Input - Signal to be filtered
%       fc : Input - Filter center frequency
%       Q : Input - Quality Factor
%       G : Input - Gain in dB desired at peak
%       Fs: Input - Sampling Frequency
%
%       By Vincent Hodgins for EECE525 HW3

% Apply Conversions
g = 10^(G/20);
Ho = g-1;
T = 1/Fs;
BW = fc/Q;
omega = BW*2*pi;

% Pos / Neg gain? 
if g>=1
    alp = (-1 + tan(.5*(omega*T))) / (1 + tan(.5*(omega*T)));
elseif g<1
    alp = (-g + tan(.5*(omega*T))) / (g + g*tan(.5*(omega*T)));
end 

% Construct filter and filter
d = -cos(2*pi*fc/Fs);
b = [(1+.5*Ho*(1+alp)) d*(1-alp) -(.5*Ho*(1+alp) + alp)];
a = [1 d*(1-alp) -alp];
y = filter(b,a,x);

% Get frequency response, phase, and group delay
[h, w] = freqz(b,a,44100);
[psi, pl] = phasedelay(b,a,1024);
[gamma, gl] = grpdelay(b,a,1024);


% Plot Data 
subplot(2,2,1);
plot(w,20*log10(abs(h)))
title("Magnitude Response");
xlabel("Frequency (rad/sec)");
ylabel("Magnitude (dB)");
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [.0001, pi]);


subplot(2,2,2);
plot(w,angle(h));
title("Phase Response");
xlabel("Frequency (rad/sec)");
ylabel("Phase (rad)");
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [.0001, pi]);



subplot(2,2,3);
plot(pl,psi);
title("Phase Delay");
xlabel("Frequency (rad/sec)");
ylabel("Phase Delay (samples)");
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [.001, pi]);


subplot(2,2,4);
plot(gl,gamma);
title("Group Delay");
xlabel("Frequency (rad/sec)");
ylabel("Group Delay (samples)");
set(findall(gcf, 'Type', 'axes'), 'Xscale', 'log');
set(findall(gcf, 'Type', 'axes'), 'Xlim', [.001, pi]);

ti = sprintf("Filter Specs for G=%d, f_c=%d, Q=%d", G, fc, Q);

sgtitle(ti);

end