function [y_LP, y_BP, y_HP, y_BS] = hw3p3(fc,Q,x, Fs)
%hw2p4 : Recursively applies a low pass, band pass, and high pass filter
%        to input signal x
%
%       y_LP : Output - Low Passed Signal
%       y_BP : Output - Band Passed Signal
%       y_HP : Output - High Passed Signal
%
%       fc : Input - Filter cutoff frequency
%       Q : Input - Quality Factor
%       x : Input - Input signal to filter
%       Fs: Input - Sampling Frequency
%
%       By Vincent Hodgins for EECE525 HW3

% Catch div/0 Error
if Q==0
    error("Q must be nonzero");
end 

% Apply Conversions
Fc = 2*sin(pi*fc/Fs);
Qc = 1/Q;

% Check for complex poles
b = (2 - Fc*Qc - Fc*Fc);
c = (1 - Fc*Qc);

if (b*b - 4*c)>=0
    error("Combination of Q and fc result in real valued poles")
end

% Check for stability
root = -.5*(b + sqrt(b*b - 4*c));
if abs(root)>1
    error("System is unstable, change Q and fc values")
end

% Construct matricies according to DSP-8 slide 13
A = [(1-Fc*Qc-(Fc^2)) -Fc ; Fc 1 ];
B = [Fc 0]';
C = [ (-Qc - Fc)  -1 ; 1 0 ; Fc 1; Qc 0];
D = [1 0 0 -1]';

% Initialize state matrix and output vector
xlen = length(x);
state = zeros(2,xlen);
output = zeros(4,xlen);

% Recursively solve 
for t=2:xlen
   state(:, t) = A*state(:,(t-1)) + B*x(t-1); 
   output(:,t) = C*state(:,(t-1)) + D*x(t-1);
end 

y_HP = output(1,:);
y_BP = output(2,:);
y_LP = output(3,:);
y_BS = y_HP - y_LP;

end