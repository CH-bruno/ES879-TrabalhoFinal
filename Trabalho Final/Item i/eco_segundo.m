clc;
clear all;
close all;

% Carregar o sinal de �udio
[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Especifica��es do filtro
a = 0.5; % Par�metro dado
t_atraso = 0.025; % Atraso desejado em segundos

% Calcular o n�mero de amostras para o atraso desejado
D = round(t_atraso * Fs);

% Construir a fun��o de transfer�ncia
num = [1, zeros(1, D), a];
den = 1;

% Calcular a resposta em frequ�ncia usando freqz
N = 8192; % Aumente o n�mero de pontos de frequ�ncia
[H, Freq] = freqz(num, den, N, Fs);

% Filtrar o sinal
y_filtrado = filter(num, den, y);

soundsc(y_filtrado, Fs);