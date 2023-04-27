function y=drop(x,N)
% Syntax: y=drop(x,N)
%           x is vector
%           abs(N) is number of elements to drop
%           sign(N) indicates from which end of x to drop
%                   N>0: left or top
%                   N<0: right or bottom
%
% Emulates APL function
%
x_r=x(:).';
if N==0
  y=x_r;
elseif N<0
  y=x_r(1:(length(x_r)+N));
else
  y=x_r((N+1):length(x_r));
end
[m,n]=size(x);
if m>n
  y=y(:);
end