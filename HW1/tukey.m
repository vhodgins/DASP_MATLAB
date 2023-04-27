function w=tukey(N,alpha)
% USAGE: w=tukey(N,alpha);
% 
%  Inputs: N = length of window
%          alpha = percentage of window length that the "top" is
%
%  Outputs: w = tukey window
%


if rem(N,2)==0  % i.e., if N is even
  M=N+1;
else  % if N is odd
  M=N;
end        % this makes sure that M is odd
w=ones(1,M);
M1=(M-1)/2;
Malpha=ceil(alpha*M1);
n=Malpha:M1;

w1=0.5*(1+cos((n - alpha*M1)*pi/((1-alpha)*M1)));
D=length(n);
w=[fliplr(w1) drop(drop(w,D),-D) w1];
w=w(1:N);