%%EKG simulator, written by stevensarns, simulates EKG wave at 1000x/sec -> 60 Beats Per Minute
%%Waveform is created from an array of 50 data points to create the PQRST complex
sampleFreq = 1000

x = [40 38 42 43 44 45 44 43 42 41 40 40 40 40 40 39 42 43 60 80 100 120 80 50  5 10 20 30 40 50 35 40 41 42 43 44 45 46 47 48 49 50 51 51 50 49 48 45 42 40 40];
t = 1;
signal = [];

for j = 0:1000
    t = t + 1;
    if t > 100
        t = 1;
    end
    if t < 51
        for i = 0:9
            y = x(t) + randi([-3 3], 1);
            signal = [signal y];
        end
    else
        for i = 0:9
            y = 50 + randi([-2 2], 1);
            signal = [signal y];
        end
    end
end

%simulated signal has no noise, signal processing not needed
%signal = signalProcessing(signal, sampleFreq);
plot(signal);

%threshold detection
[c1, c2] = twoclass(signal,0.001);
threshold = max(c1, c2);

%peak detection
values = PTDetect(signal,threshold);

%distance between peaks in seconds
distances = [];
for k = 1:(length(values)-2)
    distances = [distances (values(i+1) - values(i))];
end
distance = mean(distances) * 1/sampleFreq;

%Beats in one minute
HR = distance * 60;
    