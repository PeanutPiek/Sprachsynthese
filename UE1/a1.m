clear;
home;
close all;

% ------------------------------------------------------------------------
% Sprachsynthese und -erkennung
% Übungsaufgabe (1) 
% ------------------------------------------------------------------------

T = 5;                                          % Zeit in s
Fs = 16e3;                                      % Abtastfrequenz in Hz
Ta = 1/Fs;                                      % Abtastrate (Sample Rate)
nBit = 16;                                      % Auflösung
% Zeitvektor
t_ = 0:Ta:T-Ta;
% f1
A1 = 1;                                         % Spitzenamplitude
f1 = 500;                                       % Frequenz in Hz
phi1 = 0;                                       % Phasenversatz in Rad
% f2
A2 = 0.5;                                       % Spitzenamplitude
f2 = 1e3;                                       % Frequenz in Hz
phi2 = -pi/2;                                   % Phasenversatz in Rad
% f3
A3 = 0.25;                                      % Spitzenamplitude
f3 = 2e3;                                       % Frequenz in Hz
phi3 = pi;                                      % Phasenversatz in Rad
% Schwingungen
sf1_ = A1 * sin(2*pi*f1*t_+phi1);               % Sinussignal 1
sf2_ = A2 * sin(2*pi*f2*t_+phi2);               % Sinussignal 2
sf3_ = A3 * sin(2*pi*f3*t_+phi3);               % Sinussignal 3

f_ = sf1_ + sf2_ + sf3_;                        % Überlagerte Schwingung
fn_ = (f_ - min(f_)) / (max(f_) - min(f_));     % Normalisierte Schwingung

% Plot Sinusschwingungen
figure('Name', 'Einzelschwingungen')
subplot(3, 1, 1);
% Plot f1
plot(t_, sf1_);
xlabel('Zeit in s');
ylabel('A(t)');
subplot(3, 1, 2);
% Plot f2
plot(t_, sf2_);
xlabel('Zeit in s');
ylabel('A(t)');
subplot(3, 1, 3);
% Plot f3
plot(t_, sf3_);
xlabel('Zeit in s');
ylabel('A(t)');

figure('Name', 'Einzelschwingungen bis 10ms')
subplot(3, 1, 1);
% Plot f1
plot(t_ * 1000, sf1_);
xlim([0, 10]);
xlabel('Zeit in ms');
ylabel('A(t)');
subplot(3, 1, 2);
% Plot f2
plot(t_ * 1000, sf2_);
xlim([0, 10]);
xlabel('Zeit in ms');
ylabel('A(t)');
subplot(3, 1, 3);
% Plot f3
plot(t_ * 1000, sf3_);
xlim([0, 10]);
xlabel('Zeit in ms');
ylabel('A(t)');

% Plot Überlagerte Schwingung
figure('Name', 'Überlagerte Schwingung bis 20ms')
% Plot bis 20ms
plot(t_ * 1000, f_)
xlabel('Zeit in ms');
ylabel('A(t)');
xlim([0 20]);

% Plot normalisierte Überlagerte Schwingung
figure('Name', 'Normalisierte Überlagerte Schwingung bis 20ms')
% Plot bis 20ms
plot(t_ * 1000, fn_)
xlabel('Zeit in ms');
ylabel('A(t)');
xlim([0 20]);

% Schreibe .wav
audiowrite('audio/A1.wav', fn_, Fs, 'BitsPerSample', nBit);

%
% Fouriertransformation
% ------------------------------------------------------------------------
%

% Anzahl an Stützstellen
N = T*Fs;
% Fouriertranformation für Signal bis 50ms
F50_ = fft(f_(1:(0.05/Ta)+1), N);
% Fouriertransformation für Signal bis 100ms
F100_ = fft(f_(1:(0.1/Ta)+1), N);
% Fouriertransformation für Signal bis 500ms
F500_ = fft(f_(1:(0.5/Ta)+1), N);
% Fouriertransformation für Signal bis 1s
F1000_ = fft(f_(1:(1/Ta)+1), N);
% Fouriertransformation für Signal bis 5s (komplett)
F5000_ = fft(f_, N);

df = Fs/N;
fq_ = 0:df:Fs-df;

% Plot Fouriertransformationen
figure('Name', 'Spektrum der Überlagerten Sinusschwingung')
subplot(5, 1, 1);
% Plot Frequenzspektrum bis 50ms
plot(fq_, abs(F50_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 50ms');
subplot(5, 1, 2);
% Plot Frequenzspektrum bis 100ms
plot(fq_, abs(F100_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 100ms');
subplot(5, 1, 3);
% plot Frequenzspektrum bis 500ms
plot(fq_, abs(F500_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 500ms');
subplot(5, 1, 4);
% Plot Frequenzspektrum bis 1s
plot(fq_, abs(F1000_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 1s');
subplot(5, 1, 5);
% Plot Frequenzspektrum bis 5s (komplett)
plot(fq_, abs(F5000_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 5s');

% Plot Bereich <= 4kHz
%
% Durch die Erhöhung der Sampleanzahl verbessern wir die Frequenzauflösung.
% Bei geringer Sampleanzahl sind neben den relevanten Frequenzen auch 
% Störungen enthalten.
%

figure('Name', 'Spektrum bis 4kHz')
subplot(5, 1, 1);
% Plot Frequenzspektrum bis 50ms
plot(fq_, abs(F50_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0, 4000]);
title('Spektrum bis 50ms');
subplot(5, 1, 2);
% Plot Frequenzspektrum bis 100ms
plot(fq_, abs(F100_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0, 4000]);
title('Spektrum bis 100ms');
subplot(5, 1, 3);
% plot Frequenzspektrum bis 500ms
plot(fq_, abs(F500_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0, 4000]);
title('Spektrum bis 500ms');
subplot(5, 1, 4);
% Plot Frequenzspektrum bis 1s
plot(fq_, abs(F1000_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0, 4000]);
title('Spektrum bis 1s');
subplot(5, 1, 5);
% Plot Frequenzspektrum bis 5s (komplett)
plot(fq_, abs(F5000_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0, 4000]);
title('Spektrum bis 5s');


%
% Fouriertransformation aufgenommener Signale
% ------------------------------------------------------------------------
%

%
% Vokal/Phon 'A'
%
[ya_, Fs_a] = audioread('audio/a.wav');
Na = length(ya_);
T_a = Na/Fs_a;

Fa50_ = fft(ya_(1:0.05*Fs_a), Na);
Fa100_ = fft(ya_(1:0.1*Fs_a), Na);
Fa500_ = fft(ya_(1:0.5*Fs_a), Na);
Fa1000_ = fft(ya_(1:0.5*Fs_a), Na);
Fa_ = fft(ya_, Na);

dfa = Fs_a/Na;
fq_a = 0:dfa:Fs_a-dfa;

% Plot Fouriertransformationen
figure('Name', 'Vokal A')
subplot(5, 1, 1);
% Plot Frequenzspektrum bis 50ms
plot(fq_a, abs(Fa50_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 50ms');
subplot(5, 1, 2);
% Plot Frequenzspektrum bis 100ms
plot(fq_a, abs(Fa100_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 100ms');
subplot(5, 1, 3);
% plot Frequenzspektrum bis 500ms
plot(fq_a, abs(Fa500_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 500ms');
subplot(5, 1, 4);
% Plot Frequenzspektrum bis 1s
plot(fq_a, abs(Fa1000_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 1s');
subplot(5, 1, 5);
% Plot Frequenzspektrum bis 5s (komplett)
plot(fq_a, abs(Fa_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0 Fs_a/2]);
title(sprintf('Spektrum über gesamtes Signal (%0.3f s)', T_a));

%
% Vokal/Phon 'I'
%
[yi_, Fs_i] = audioread('audio/i.wav');
Ni = length(yi_);
T_i = Ni/Fs_i;

Fi50_ = fft(yi_(1:0.05*Fs_i), Ni);
Fi100_ = fft(yi_(1:0.1*Fs_i), Ni);
Fi500_ = fft(yi_(1:0.5*Fs_i), Ni);
Fi1000_ = fft(yi_(1:0.5*Fs_i), Ni);
Fi_ = fft(yi_, Ni);

dfi = Fs_i/Ni;
fq_i = 0:dfi:Fs_i-dfi;

% Plot Fouriertransformationen
figure('Name', 'Vokal I')
subplot(5, 1, 1);
% Plot Frequenzspektrum bis 50ms
plot(fq_i, abs(Fi50_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 50ms');
subplot(5, 1, 2);
% Plot Frequenzspektrum bis 100ms
plot(fq_i, abs(Fi100_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 100ms');
subplot(5, 1, 3);
% plot Frequenzspektrum bis 500ms
plot(fq_i, abs(Fi500_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 500ms');
subplot(5, 1, 4);
% Plot Frequenzspektrum bis 1s
plot(fq_i, abs(Fi1000_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
title('Spektrum bis 1s');
subplot(5, 1, 5);
% Plot Frequenzspektrum bis 5s (komplett)
plot(fq_i, abs(Fi_));
xlabel('Frequenz in Hz');
ylabel('A(f)');
xlim([0 Fs_i/2]);
title(sprintf('Spektrum über gesamtes Signal (%0.3f s)', T_i));
