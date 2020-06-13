load('C:\Users\Adm\Desktop\Temporal-Features\ST\Varium_SI_TI.mat')
signal = fft(Varium_SI_TI{42,3});%-mean(Varium_SI_TI{i+k,3});
signorm = (signal/sqrt((signal*signal.')/size(signal,2)));

signal_original=fft(Varium_SI_TI{37,3});
sigORG = (signal_original/sqrt((signal_original*signal_original.')/size(signal_original,2)));

fourier = signorm-sigORG;
P2 = abs(fourier/L).^2;
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

P3 = abs(sigORG/L).^2;
P4 = P3(1:L/2+1);
P4(2:end-1) = 2*P4(2:end-1);

plot(f,P1)
hold on
ylim([0 0.000001])
plot(f,P4)
hold off