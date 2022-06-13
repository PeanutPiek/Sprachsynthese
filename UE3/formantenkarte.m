clear
home
close all

f_ = [ 824.5 352.5 787.8 336.4 660.3 ];

x_ = [ 1439.9 2002.1 2186.5 2310.4 858.7 ];

figure('Name', 'Formatenkarte');
plot(x_, f_, 'o');
xlabel('F2 [Hz]');
ylabel('F1 [Hz]');