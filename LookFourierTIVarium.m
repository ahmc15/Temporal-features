close all
load('/ST/Varium_SI_TI.mat')
vector_ruido=[];
for i=199:204
signal = fft(Varium_SI_TI{i,3});%-mean(Varium_SI_TI{i+k,3});
signorm = (signal/sqrt((signal*signal.')/size(signal,2)));

signal_original=fft(Varium_SI_TI{37,3});
sigORG = (signal_original/sqrt((signal_original*signal_original.')/size(signal_original,2)));

fourier = signorm-sigORG;
P2 = abs(fourier/L).^2;
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
vector_ruido=[vector_ruido,sum(P1)];
plot(f,P1)
% ylim([0 0.000001])
pause(2)
% title(char(Varium_SI_TI{i+k,1}))
end
