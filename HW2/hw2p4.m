function [state, output] = hw2p4(a,b,x, q_init)
%hw2p4 : Recursively applies a filter to a discrete time signal x
%
%       state : Output - Contains all states achieved in filtering
%       output : Output - The filtered signal y[n]
%       a : Input - a coefficients of filter
%       b : Input - b coefficients of filter
%       x : Input - Input signal to filter
%       q_init : Input - Initial conditions vector
%
%       By Vincent Hodgins for EECE525

% Construct matricies according to DSP-8 slide 13
A = [ 0 1 0 ; 0 0 1; -a(3) -a(2) -a(1)];
B = [0 0 1]';
C = [ b(4)-a(3)*b(1) b(3)-a(2)*b(1) b(2)-a(1)*b(1) ];
D = [b(1)];

% Initialize state matrix and output vector
xlen = length(x);
state = zeros(3,xlen);
state(:,1)=q_init;
output = zeros(1,xlen);

% Recursively solve 
for t=2:xlen
   state(:, t) = A*state(:,(t-1)) + B*x(t-1); 
   output(t) = C*state(:,(t-1)) + D*x(t-1);
end 


end