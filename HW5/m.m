function y = m(x, K,G)

M = 10^(G/20);
% Define the piecewise function
f1 = @(x) tanh(K)-((( (tanh(K)^2)-1)/M)* tanh(M*(x-K))); 
f2 = @(x) tanh(x);
f3 = @(x) -tanh(K)-((((tanh(K)^2)-1)/M)*tanh(M*(x+K))); 
% Evaluate the function at the x-values
y = zeros(size(x));
y(x < -K) = f3(x(x < -K));
y(x >= -K & x <= K) = f2(x(x >= -K & x <= K));
y(x > K) = f1(x(x > K));



end