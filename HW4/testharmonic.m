
T = 6;
frs = 300*[ 1 2 3 2.1 ];
drs = [.6 .8 .8 .1];
nhs = [ 2 10 4  3];
tds = [ 1 2 3.5  3];
sq = [ 0 0 1 0 ];

test =  genharmonic(frs(1), 44100, T, drs(1), nhs(1), tds(1), sq(1) );
test = test + genharmonic(frs(2), 44100, T, drs(2), nhs(2), tds(2), sq(2) );
test = test + genharmonic(frs(3), 44100, T, drs(3), nhs(3), tds(3), sq(3) );
test = test + genharmonic(frs(4), 44100, T, drs(4), nhs(4), tds(4), sq(4) );
test = test./3;

test = audioread("test.wav");
test= linearvibrato(test, 3000, 1, 44100);

sound(test, 44100);

%% 
