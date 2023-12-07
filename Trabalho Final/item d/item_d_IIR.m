clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);

% Subtraindo a m�dia de cada elemento do sinal
y = y - ymedio;

% Projeto do filtro IIR (Butterworth)
Fc_b = 500; % frequ�ncia de corte
N_b = 20; % ordem (testar 20, 30 e 50)
d = fdesign.lowpass('N,F3dB',N_b,Fc_b/(Fs/2));
h_b = design(d,'butter');

fvtool(h_b);

% Fazendo a convolu��o do filtro com o sinal contaminado
y_filtrado = filter(h_b, y);

% Dom�nio da Frequ�ncia
Y_original = 2 * fft(y);
Y_filtrado = 2 * fft(y_filtrado);

% Plote os espectros de magnitude do sinal original e do sinal filtrado
figure;
plot(linspace(0, Fs, length(Y_original)), abs(Y_original), 'b', 'LineWidth', 1.5);
hold on;
plot(linspace(0, Fs, length(Y_filtrado)), abs(Y_filtrado), 'r', 'LineWidth', 1.5);
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');
title('Compara��o do Espectro de Magnitude do Sinal Original e Filtrado');
legend('Sinal Original', 'Sinal Filtrado');
xlim([0, Fs/2]);

% Vetor de tempo para o sinal filtrado
t_filtrado = linspace(0, length(y_filtrado)/Fs, length(y_filtrado));

% Plot no dom�nio do tempo
figure;
plot(linspace(0, length(y)/Fs, length(y)), y, 'b', 'LineWidth', 1.5);
hold on;
plot(t_filtrado, y_filtrado, 'r', 'LineWidth', 1.5);
title("Compara��o do Sinal Original e Filtrado no Dom�nio do Tempo");
xlabel("t (s)");
ylabel("Amplitude");
legend('Sinal Original', 'Sinal Filtrado');

%soundsc(y, Fs)
%soundsc(y_filtrado, Fs);
