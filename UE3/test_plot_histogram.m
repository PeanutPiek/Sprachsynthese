clear
home
close all

[Y, Fs] = audioread('Satz.wav');
l = size(Y, 1);
figure('Name', 'Histiogram');
hist = histogram(Y, Fs);

dat_ = hist.Values;
datn_ = dat_ / l;
val_ = hist.BinEdges;

[Y_f, Fs_f] = audioread('Satz_f.wav');
l_f = size(Y_f, 1);
figure('Name', 'Histiogram');
hist_f = histogram(Y_f, Fs_f);

dat_f_ = hist_f.Values;
datn_f_ = dat_f_ / l;
val_f_ = hist_f.BinEdges;

x1 = val_f_(1:length(val_f_)-1);
y1 = datn_f_;
x2 = val_(1:length(val_)-1);
y2 = datn_;

mean(x1)
mean(x2)

figure('Name', 'Histogram �ber H�ufigkeiten');
plot(x1, y1, x2, y2);
xlabel('Amplitude');
ylabel('H�ufigkeit [rel]');
xlim([-1 1]);
ylim([0 0.001]);

fy = plot_fft(Y);

f = plot_fft(datn_);
ylabel('H�ufigkeit [rel]');

ffy = plot_fft(Y_f);

ff = plot_fft(datn_f_);
ylabel('H�ufigkeit [rel]');