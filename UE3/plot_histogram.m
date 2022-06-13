function [hist] = plot_histogram(filename)
    [Y, Fs] = audioread(filename);
    l = size(Y, 1);
    figure('Name', 'Histiogram');
    hist = histogram(Y, Fs);

    dat_ = hist.Values;
    datn_ = dat_ / l;
    val_ = hist.BinEdges;

    figure('Name', 'Histogram über Häufigkeiten');
    plot(val_(1:length(val_)-1), datn_);
    xlabel('Amplitude');
    ylabel('Häufigkeit [%]');
    xlim([-1 1]);
end