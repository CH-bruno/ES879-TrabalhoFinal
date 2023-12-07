clc;
clear all;
close all;

[y, Fs] = audioread("Viva la vida - coldplay.wav");
y = y(:, 1) + y(:, 2);

ymedio = mean(y);
y = y - ymedio;

%Especifica��es do filtro de eco desejado
a = 0.5; 
t_atraso = 0.025;

% Calculando o n�mero de amostras para o atraso desejado
D = round(t_atraso * Fs);

% Fun�ao de transfer�ncia do eco
num = [1, zeros(1, D), a];
den = 1;

% Resposta em frequ�ncia do filtro
[H, Freq] = freqz(num, den, 1024, Fs);

y_filtrado = filter(num, den, y);

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


Y_original = 2 * fft(y);
Y_filtrado = 2 * fft(y_filtrado);

frequencias = linspace(0, Fs, length(Y_original));

%Plotando espectro no dom�nio da frequ�ncia
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

soundsc(y_filtrado, Fs);
audiowrite("Audio com eco de 0,025s.wav", y_filtrado, Fs);
