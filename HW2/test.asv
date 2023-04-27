%% My Function
x = zeros(1,100);
x(1) = 1;
a = [-.9 .81 -.792];
b = [1 0 0 0];
qint = [0 0 0];
[s, o] = hw2p4(a, b, x, qint);
stem(o);
title("Filter applied using written function");
xlabel("Step (n)");
ylabel("Magnitude");

%% Matlab's function
y = filter(b,[1 a],x);
stem(y);
title("Filter applied using filter command");
xlabel("Step (n)");
ylabel("Magnitude");
