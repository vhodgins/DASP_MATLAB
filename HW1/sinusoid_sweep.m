function [x, x_inv] = sinusoid_sweep(f1, f2, T, Fs)
   
t=0:(1/Fs):T; % Define time samples
w1=2*pi*f1; % convert frequencies to rad/sec
w2=2*pi*f2;
L = T/log(w2/w1); % Compute L parameter defined in notes
K = L*w1; % Compute K parameter defined in notes
phi_t = K*(exp(t/L) - 1); % Compute instanteous phase
x=sin(phi_t); % compute exponential sweep sine
w_t=(K/L)*exp(t/L); % Compute the instantaneous frequency
A=(1/2).^log2(w_t/w1); % use it to compute amplitude as in notes
x_inv = A.*fliplr(x); % apply amplitude to time-reversed signal to make 

end