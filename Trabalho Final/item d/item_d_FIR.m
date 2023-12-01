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

% Projeto do filtro FIR
Fc = 5000; % Frequ�ncia de corte(teste 50,100,200)
N = 50; % Ordem do filtro (teste 50,100,200)
h = fir1(N, Fc/(Fs/2));

% Resposta em Frequ�ncia do Filtro
freqz(h, 1, 1024, Fs);

% Aplicar o filtro FIR ao sinal original
y_filtrado = filter(h, 1, y);

%Dominio da Frequencia
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
legend('Original', 'Filtrado');
xlim([0, Fs/2]);

%soundsc(y, Fs)
%soundsc(y_filtrado, Fs)
