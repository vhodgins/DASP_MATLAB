function [x, x_inv] = sinusoid_sweep(f1, f2, T, Fs)
    N = T * Fs;     % Calculate number of samples
    t = (0:N-1)/Fs; % Create time vector for samples
    k = (f2/f1)^(1/T);
    f = f1* k.^t;
    x = sin(2*pi*f.*t);    % Compute linear swept sine
    x_inv = fliplr(x);  % Time reverse swept sine to create inverse 
end