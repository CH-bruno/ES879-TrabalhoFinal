clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Calculando a m�dia do sinal
ymedio = mean(y);

% Subtraindo a m�dia de cada elemento do sinal
% Pois: "Se a m�dia do sinal n�o for zero, ir� aparecer uma componente na frequ�ncia
% 0, correspondente ao ganho est�tico"
y = y - ymedio;

y_decimado = decimate(y, 8);

t = linspace(0, length(y_decimado)/(Fs/8), length(y_decimado));
figure;
subplot(2,1,1);
plot(t, y_decimado);
title("Dom�nio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

%Dominio da Frequencia
% FFT * 2
Y = 2 * fft(y_decimado);

% Calcule o vetor de frequ�ncias
frequencies = linspace(0, Fs/8, length(Y));

% Plote o espectro de magnitudes
subplot(2,1,2);
plot(frequencies, abs(Y));
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de �udio');
xlim([0, Fs/16]);

%soundsc(y, Fs)
%soundsc(y_decimado, Fs/8)
