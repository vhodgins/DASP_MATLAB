function y = genharmonic(ff, Fs, T, dr, nharm, tdrop, square)
%genharmonic: Creates a vector containing the sum of nharm harmonic
%sinusoids with fundamental frquency ff, T seconds long. dr specifies the
%drop rate (0-1) at which harmonics amplitude is dampened. tdrop specifices
%the drop rate of the amplitude per second 


N = Fs*T;
y = zeros(1,N);
curlevel =1;

for t=(1:N)
    curlevel= curlevel*(1-tdrop/Fs);
    amp = curlevel;
    for nh=1:nharm
        amp = amp*(1-dr);
        if square==0
        y(t) = y(t) + (amp*sin(2*pi*(ff*nh)*t/Fs));
        else
            if sin(2*pi*(ff*nh)*t/Fs)>=0
                y(t) = y(t) + amp;
            else
                y(t) = y(t) - amp;
            end 
        end 
    end
end

end
