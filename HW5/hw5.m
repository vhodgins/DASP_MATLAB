%% Problem 1
clear
x = audioread("impulse_response.wav");
Fs = 48000;

% Compute Fourier transform
X = fft(x);

% Compute frequency axis
df = Fs/length(x); % frequency resolution
f = 0:df:Fs/2; % positive frequency axis

% Plot positive frequencies
plot(f, 20*log10(abs(X(1:length(f)))));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
set(gca, 'XScale', 'log');


%%

[b,a] = prony(x,40,40);
%freqz(b,a)

% subplot(2,1,1) 
% stem(impz(b,a,length(x)))
% title 'Impulse Response with Prony Design'
% 
% subplot(2,1,2)
% stem(x)
% title 'Input Impulse Response'


%  Testing Filter: 

y = filter(b,a,[1 zeros(1,423)]);

t = 0.01:.01:4.24;

test = sinusoid_sweep(1,10000,4.24,48000);

cx = conv(test,x);
cy = conv(test,y);

hold on;
plot(1:length(cx), 20*log10(cx));
plot(1:length(cy), 20*log10(cy));
% stem(x);
% stem(y);
legend('x','y');
xlabel("Frequency (Hz)");
% xlabel("Sample")
ylabel("Magnitude (dB)")
title("Frequency Response of Prony filtered & Original Signal { n=40, d=40 }")
% title("Frequency Response of Original Signal");
hold off;


%% Impulse Response

hold on 
stem(x);
stem(y);
legend('x','y');
xlabel("Sample");
ylabel("Magnitude");
title("Impulse response of Prony Filtered & Original Signal { n=40, d=40 }")


%% Problem 2 
clear
% Input G matrix found from wolframalpha.com

% Recursively Solve
t = 10;
T = .000001;
n = t/T; 

R1 = 400;
R2 = 400; 
C = 0.001*(10^-6); 

ieq = zeros(1,n+1);
ieq(1) = 0;
v2 = zeros(1,n+1);

G1 = 1/R1;
G2 = 1/R2;
Gc = 2*C / T;

alpha = G1*G2*Gc + G1 + Gc;

f2 = 48000/2;
vs = sinusoid_sweep(.001,f2, t, 1/T);

for i=2:n+1
    
    v2(i) = ((G2*Gc + 1)/alpha)*ieq(i-1) + ((G1*G2*Gc + G1)/alpha)*(vs(i));
    ieq(i) = 2*Gc*(v2(i)) - ieq(i-1);
end

plot((1:n+1)*T*f2, (abs(v2)));
title("DK-Modeled Swept Sinusoud Response {R1=400, R2=400, C=1nf}");
xlabel("Frequency (Hz)")
ylabel("Voltage Response Magnitude")


%% Problem 3
clear

T = .001;
Fs = 48000;

% Get coefficients for butterworth filters
[hb, ha] = butter(4, 100/(Fs/2), "high");
[lb, la] = butter(4, 15000/(Fs/2), "low");

x = [1 zeros(1,(T*Fs))];

x1 = filter(hb,ha,x);
x2 = m(x1, .3, 30); 
% x2=x1;
x3 = filter(lb,la,x2);
% x3=x2;

[x, xinv] = sinusoid_sweep(10,21000, 2, Fs, 1);
% Convolve by sinusoid and inverse sinusoid for impulse response
convolved = conv(x3, x);
final = conv(convolved, xinv);

window=2048;
overlap=256;
% Compute the STFT of the final impulse response
[S,F,T] = spectrogram(final, hamming(window), overlap, [], Fs);

% Plot Results
surf(T,F,(abs(S)),'edgecolor','none'); axis tight;view(45,45);
title('Impulse response of Second Wiener-Hammerstein Filter');
ylabel('Frequency (Hz)');
ylim([10,21000])
xlabel('Time (s)');
set(gca,'YScale','log')

%% 

[x, xinv] = sinusoid_sweep(10,21000, 2, Fs, .001);
x1 = filter(hb,ha,x);
% x2 = m(x1, .3, 30); 
x2=x1;
X = filter(lb,la,x2);

% Take the DFT of the audio signal
N = length(X);                  % Length of signal
Y = fft(X)/N;                   % Normalized DFT
f = (0:N-1)*(Fs/N);             % Frequency vector

% Plot the positive frequencies of the DFT
positive_freq_idx = 1:N/2+1;    % Indices of positive frequencies
figure;
plot(f(positive_freq_idx), abs(Y(positive_freq_idx)))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Response found from Low-Amplitude Sweep Combined Filters')

