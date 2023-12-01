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


% Dominio do tempo
t = linspace(0, length(y)/Fs, length(y));
figure;
subplot(2,1,1);
plot(t, y);
title("Dom�nio do tempo");
xlabel("t(s)");
ylabel("Amplitude");

% Dominio da Frequencia
% Ao pegar somente a parte positiva do sinal, requer que essa amplitude da metade
%do espectro seja multiplicada por 2 para representar a amplitude do sinal com
% precis�o.
Y = 2 * fft(y);

% Calculando o vetor de frequ�ncias
frequencies = linspace(0, Fs, length(Y));

% Plotando o espectro de magnitudes
subplot(2,1,2);
plot(frequencies, abs(Y));
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');
title('Espectro de Magnitudes do Sinal de �udio');
xlim([0, Fs/2]);

% Encontrando picos no espectro
[peaks, locs] = findpeaks(abs(Y), frequencies);

% Identificar a frequ�ncia m�xima
[maxPeak, maxIndex] = max(peaks);
f_max_espectro = locs(maxIndex);

% Mostrando a frequ�ncia m�xima no console
disp(['Frequ�ncia m�xima no espectro: ', num2str(f_max_espectro), ' Hz']);
