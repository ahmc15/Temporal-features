
close all
load('C:\Users\Adm\Desktop\Temporal-Features\ST\Varium_SI_TI.mat')
% for i=1:6:size(Varium_SI_TI,1)
i=200;
signal = Varium_SI_TI{i+5,3};
fftsignal = fft(signal);
signorm = (fftsignal/sqrt((fftsignal*fftsignal.')/size(fftsignal,2)));


signalOriginal=Varium_SI_TI{i,3};
fftsignalOriginal=fft(signalOriginal);
sigORG = (fftsignalOriginal/sqrt((fftsignalOriginal*fftsignalOriginal.')/size(fftsignalOriginal,2)));

fourier = signorm;
P2 = abs(fourier/L).^2;
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

P3 = abs(sigORG/L).^2;
P4 = P3(1:L/2+1);
P4(2:end-1) = 2*P4(2:end-1);

plot(f,P1)
hold on
ylim([0 0.00001])
plot(f,P4)
hold off
legend('Degradado','Original')
title(Varium_SI_TI{i,1})
pause(1)

%     
figure
plot(Varium_SI_TI{i,3})
hold on
xfilt = filter1('hp',Varium_SI_TI{i,3},'fc',(1.9/24.95));
% plot(xfilt,'m')
plot(Varium_SI_TI{i+5,3})
hold on
yfilt = filter1('hp',Varium_SI_TI{i+5,3},'fc',(1.9/24.95));
plot(yfilt-xfilt)
legend('Original','Original Filtrado','Degradado','Degradado Filtrado')
hold off
% %     end
% pause(2)
% end