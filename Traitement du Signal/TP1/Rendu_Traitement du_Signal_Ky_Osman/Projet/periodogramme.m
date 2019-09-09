function pw = periodogramme(x)
    N = length(x);
    pw = (abs(fft(x)).^2)/N;
    
    