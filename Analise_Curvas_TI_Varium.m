%script feito para retira a diferença entre as curvas da TI do vídeo
%referência e o vídeo com as degradações de packetloss. 


close all
load('C:\Users\Adm\Desktop\Temporal-Features\ST\Varium_SI_TI.mat')
length_video= size(Varium_SI_TI,1);
pausa=2;
%%
% for i = 1:6:length_video
%     video_ref = Varium_SI_TI{i,1};
%         
%     try 
%         for k=0:5
%             
%             hax=subplot(2,3,k+1)
%             diferenca = Varium_SI_TI{i+k,3}-Varium_SI_TI{i,3};
%             plot(diferenca)
%             x0=90;
%             y0=90;
%             width=1250;
%             height=900;
%             set(gcf,'position',[x0,y0,width,height])
%             title(char(Varium_SI_TI{i+k,1}))
%         end
%          saveas(hax,sprintf('diff_%s.jpg', Varium_SI_TI{i,1}))
%     catch
%         continue
% 
%     end
%     pause(pausa)    
% end
%%
L = size(Varium_SI_TI{5,3},2);
Fs = 24.9500;  
f = Fs*(0:(L/2))/L;
for i = 37:6:42%1:6:length_video
    video_ref = Varium_SI_TI{i,1};
%     figure;
    try
        for k=0:5
            hax=subplot(2,3,k+1);
                x0=90;
                y0=90;
                width=1250;
                height=900;
                set(gcf,'position',[x0,y0,width,height])
                
            signal = Varium_SI_TI{i+k,3};%-mean(Varium_SI_TI{i+k,3});
            signorm = (signal/sqrt((signal*signal.')/size(signal,2)));
            fourier = fft(signorm);
            signal_original=fft(Varium_SI_TI{i,3});
            
            P2 = abs(fourier/L).^2;
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            
            plot(f,P1)
            ylim([0 0.0004])
            title(char(Varium_SI_TI{i+k,1}))
            
        end
%         saveas(hax,sprintf('FFT_%s.jpg', Varium_SI_TI{i,1}))
    catch
        continue
    end
    pause(pausa)    
end
%%



