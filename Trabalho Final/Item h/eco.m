clc;
clear all;
close all;

% Carregar o sinal de �udio
[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

% Parte h - Resposta em Frequ�ncia e Sinal Ap�s Filtro
a = 0.5;  % valor fornecido
D = round(0.5 * Fs);  % atraso de 0,5 segundos em termos de amostras

% Criar a resposta ao impulso
impulse_response = [1, zeros(1, D-1), a];

% Filtrar o sinal original
y_filtered = filter(impulse_response, 1, y);

N = length(y);

% Calcular a resposta em frequ�ncia do filtro
[Hz, freq] = freqz(impulse_response, 1, N, Fs);

% Calcular a FFT do sinal filtrado
Y_ECO = 2 * fft(y_filtered, N);
Y_ECO_amp = abs(Y_ECO);

% Gr�ficos
figure;
subplot(2, 1, 1);
freqz(impulse_response, 1, N, Fs);
title('Resposta em Frequ�ncia do filtro');
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');

% Espectro em Frequ�ncia do Sinal Filtrado
subplot(2,1,2);
plot(freq(1:N/2), Y_ECO_amp(1:N/2));
xlim([0 Fs/2]);
xlabel('Frequ�ncia (Hz)');
ylabel('Amplitude');
title('Sinal ap�s passar pelo filtro de eco - Dom�nio da Frequ�ncia');

% Sinal Original e Sinal Ap�s Filtro
figure;
t = (0:N-1)/Fs;
plot(t, y, 'b', t, y_filtered, 'r');
title('Sinal Original e Sinal Ap�s Filtro de eco - Dom�nio do tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sinal Original', 'Sinal com eco');

% Reproduzir o sinal filtrado
% sound(y_filtered, Fs);
