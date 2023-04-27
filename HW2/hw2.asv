% Vincent Hodgins
% EECE 525 HW 2

%% Question 3.a

x_cd = audioread('guitar1.wav');
x_dat = x_cd;
% Stages Determined : (5/3), (8/7), (4/7)  -- I just used trial and error
% since some of the stages start off below 44.1 and from there picked the
% lowest numbers for each subsequent stage

% Three Stage Resampling
x_dat = resample(x_dat, 8,7);
x_dat = resample(x_dat, 5,7);
x_dat = resample(x_dat, 4,3);

% Time signal for each
t_cd = (0:(length(x_cd)-1)) / 44100;
t_dat = (0:(length(x_dat)-1)) / 48000;

% Plot small time segment of each and compare
plot(t_cd,x_cd','b-o',t_dat,x_dat','r--x'); xlim([1 1.001])
xlabel("Time (t)")
ylabel("Magnitude")
title("Plot of x\_cd and x\_dat from 1-1.001 seconds")

%% Question 3.b

% Create time signals for each
t_cd = (0:length(x_cd)-1) / 44100;
t_dat = (0:length(x_dat)-1) / 48000;

% Limit to first .4 seconds of signal
x_cd = x_cd(t_cd < 0.4);
x_dat = x_dat(t_dat < 0.4);

% Apply fft
X_cd = fft(x_cd, 2^16);
X_dat = fft(x_dat, 2^16);

% Compute the frequency axis in Hz 
f = (0:2^16-1) * 4800 / 2^16;

% Plot the results in dB
figure;
plot(f(1:2^15), 20*log10(abs(X_cd(1:2^15))), 'b');
hold on;
plot(f(1:2^15), 20*log10(abs(X_dat(1:2^15))), 'r--');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('DFT of x\_cd and x\_dat from 0:.4 seconds');
legend('X\_cd', 'X\_dat');








