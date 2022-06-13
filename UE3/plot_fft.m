function [f, f_] = plot_fft(Y)
    N = length(Y);
    f_ = fft(Y);
    f1_ = zeros(N, 1);
    f1_(N/2+1:N) = abs(f_(1:N/2));
    f2_ = zeros(N, 1);
    f2_(1:N/2+1) = abs(f_(N/2:N));

    xn_ = -N/2:1:N/2-1;

    f = figure;
    plot(xn_, f1_, xn_, f2_);
    xlim([-1e5 1e5]);
    xlabel('Frequenz [Hz]');
end