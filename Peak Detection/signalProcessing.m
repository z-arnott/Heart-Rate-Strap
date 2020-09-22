function processedSignal = signalProcessing(signal, sampleRate)
    %Remove mean value
    temp1 = signal - mean(signal);
    %Normalize data betwee -1 and 1
    temp2 = normalize(temp1, 'range', [-1 1]);
    %Biquad Bandstop at 50Hz, 2nd order
    [B, A] = butter(1, [49 51]/(sampleRate/2), 'stop');
    temp1 = filter(B, A, temp2);
    %0.5Hz Butterworth, Highpass, 4th order
    [B, A] = butter(2, 0.5/(sampleRate/2), 'high');
    temp2 = filter(B, A, temp1);
    %R-Peak filtering: Bandpass filter between 15 and 20Hz, 4th order
    [B, A] = butter(2, [15 20]/(sampleRate/2), 'bandpass');
    processedSignal = filter(B, A, temp2);     
end
        