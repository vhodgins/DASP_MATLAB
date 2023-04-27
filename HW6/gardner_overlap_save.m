function y = gardner_overlap_save(x, h)
    % USAGE: Applies the Gardner method overlap_save method of convolution
    %        of input signal x and filter h(impulse response). Computes
    %        only one 2M point convolution, where m = length(h). 
    %
    %        By Vincent Hodgins - EECE 525
    %
    % Inputs: 
    %       x: input signal vector
    %       h: impulse response vector
    %       N: FFT length
    %
    % Output: 
    %       y: Convoluted output vector

    % Step 1: Obtain length of impulse response
    N = length(h);
    discard = 0;

    % Dumb checks to make sure it works with input from problem 1, however will not be needed 
    % in problem 2. 

    if (length(x) <= N)
        x = [zeros(1,(2*N)-length(x)) x];
    elseif (length(x) <= 2*N)
        discard = (2*N)-length(x);
        x = [x zeros(1, (2*N)-length(x))];
    end

    % Step 3: Pad h[n] and compute FFT
    hpad = [zeros(1,N) h];
    H = fft(hpad);

    % freq domain multiply 
    X = fft(x);
    Y = X .* H;
    y = ifft(Y);

    % save only after first N 
    y = y(1:(N-discard));


end
