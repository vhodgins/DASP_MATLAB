function y = overlap_save(x, h, N)
    % USAGE: Applies the overlap_save method of convolution between input
    %        signal x, and filter h(impulse response). Breaks each 
    %        convolution into blocks of length N.
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
    Nh = length(h);

    % Step 2: Choose output block size L: N = L + Nh - 1
    L = N - Nh + 1;

    % Step 3: Pad h[n] and compute FFT
    hpad = [h, zeros(1, N - Nh)];
    H = fft(hpad);

    % Step 4: Prepend zeros to input block
    xtilde = [zeros(1, Nh - 1), x];

    % Calculate number of blocks
    num_blocks = ceil(length(x) / L);

    % Initialize output signal y
    y = [];     

    % Step 5: Loop for each block
    for i = 0:num_blocks - 1
        % freq domain multiply each block

        xi = xtilde(i * L + 1 : i * L + N);
        Xi = fft(xi);
        Yi = Xi .* H;
        yi = ifft(Yi);

        % save only after first Nh-1
        yi = yi(Nh:N);

        % append to y 
        y = [y, yi];
    end

end
