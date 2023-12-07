clc;
clear all;
close all;

% Carregar o sinal de �udio
[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);
y = y - ymedio;

% Especifica��es do filtro
a = 0.5; % Par�metro dado
t_atraso = 0.5; % Atraso desejado em segundos

% Calcular o n�mero de amostras para o atraso desejado
D = round(t_atraso * Fs);

% Construir a fun��o de transfer�ncia
num = [1, zeros(1, D), a];
den = 1;

% Calcular a resposta em frequ�ncia usando freqz
N = 1024; 
[H, Freq] = freqz(num, den, N, Fs);

% Filtrar o sinal
y_filtrado = filter(num, den, y);

% Plotar a resposta em frequ�ncia e os sinais no dom�nio do tempo
figure;
plot(Freq, abs(H));
title('Resposta em Frequ�ncia');
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');

figure;
subplot(2,1,1);
plot((0:length(y)-1)/Fs, y, 'b', 'LineWidth', 1.5);
title('Sinal Original - Dom�nio do Tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot((0:length(y_filtrado)-1)/Fs, y_filtrado, 'r', 'LineWidth', 1.5);
title('Sinal com Eco - Dom�nio do Tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');


% Calcular a transformada de Fourier do sinal original e filtrado
Y_original = 2 * fft(y);
Y_filtrado = 2 * fft(y_filtrado);

% Calcular a frequ�ncia correspondente para cada componente da transformada de Fourier
frequencias = linspace(0, Fs, length(Y_original));

% Plotar o espectro no dom�nio da frequ�ncia
figure;
subplot(2,1,1);
plot(frequencias, abs(Y_original), 'b', 'LineWidth', 1.5);
title('Espectro do Sinal original');
xlabel('Frequ�ncia (Hz)');
ylabel('Amplitude');
xlim([0 Fs/16]);

subplot(2,1,2);
plot(frequencias, abs(Y_filtrado), 'r', 'LineWidth', 1.5);
xlim([0 Fs/16]);
title('Espectro do Sinal com Eco');
xlabel('Frequ�ncia (Hz)');
ylabel('Amplitude');


