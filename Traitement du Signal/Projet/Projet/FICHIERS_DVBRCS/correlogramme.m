function CW = correlogramme(x)
    r = xcorr(x);
    CW = abs(fft(r));
    %semilogy(linspace(0,Fe,length(r)),CW)
end
