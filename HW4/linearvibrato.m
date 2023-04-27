function y = linearvibrato(x, W, f_LFO, Fs)
%linearvibrato Applies vibrato to input signal x with a width in ms of W
%              a sampling rate of Fs, and a Low frequency oscillation of 
%              f_LFO in Hz. 

%       By Vincent Hodgins for EECE 525

% Convert width in msec to delays
W = floor((W/1000)*Fs); 

% Set up Time and output Vector
t = (1:length(x)) ./Fs;
y = zeros(1,length(x));

% Oscillating Width
ds = W + W*sin(2*pi*f_LFO*t);

% Cant have delay for first Width worth 
y(1:2*W)=x(1:2*W);

% Compute Vibrato Signal using equations from slides 
for t2=(2*W):length(x)
    d = floor(ds(t2));
    frac = mod(ds(t2),1);
    y(t2)= frac*x(t2-(d+1)) + (1-frac)*x(t2-d);
end
end