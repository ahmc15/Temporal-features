%script feito para retira a diferença entre as curvas da TI do vídeo
%referência e o vídeo com as degradações de packetloss. 


close all
% load('C:\Users\Adm\Desktop\Temporal-Features\MAT-files\TI\variumFreezing_SI_TI.mat')
% length_video= size(variumFreezing,1);
% pausa=2;
%%
% for i = 1:5:length_video
%     video_ref = variumFreezing{i,1};
%     for feat=1:36
%         try
%             for k=0:4
%                 hax=subplot(2,3,k+1);
%                 diferenca = variumFreezing{i+k,2}(:,feat);%5-variumFreezing{i,2};
%                 plot(diferenca)
%                 titulo=strsplit(variumFreezing{i+k,1},'\');
%                 x0=90;
%                 y0=90;
%                 width=1250;
%                 height=900;
%                 set(gcf,'position',[x0,y0,width,height])
%                 title(char(titulo(end) ))
%             end
%             saveas(hax,sprintf('BrisqueFreezing_feature%d_%s.jpg',feat ,char(titulo(end))))
%         catch
%             continue
%         end
% %         pause(pausa)
%     end
% end
%%
load('C:\Users\Adm\Desktop\Temporal-Features\MAT-files\TI\variumFreezing_SI_TI.mat')
length_video= size(VariumFreezing_SI_TI,1);
pausa=2;

for i = 1:5:length_video
    video_ref = VariumFreezing_SI_TI{i,1};
    
    try
        for k=0:4
            hax=subplot(2,3,k+1);
            diferenca = VariumFreezing_SI_TI{i+k,3};%5-variumFreezing{i,2};
            plot(diferenca)
            titulo=strsplit(VariumFreezing_SI_TI{i+k,1},'\');
            x0=90;
            y0=90;
            width=1250;
            height=900;
            set(gcf,'position',[x0,y0,width,height])
            title(char(titulo(end) ))
        end
        saveas(hax,sprintf('TI_Freezing_%s.jpg',char(titulo(end))))
    catch
        continue
    end
    pause(pausa)
end

%%
% L = size(variumFreezing{5,3},2);
% Fs = 24.9500;  
% f = Fs*(0:(L/2))/L;
% for i = 37:6:42%1:6:length_video
%     video_ref = variumFreezing{i,1};
% %     figure;
%     try
%         for k=0:5
%             hax=subplot(2,3,k+1);
%                 x0=90;
%                 y0=90;
%                 width=1250;
%                 height=900;
%                 set(gcf,'position',[x0,y0,width,height])
%                 
%             signal = variumFreezing{i+k,3};%-mean(variumFreezing{i+k,3});
%             signorm = (signal/sqrt((signal*signal.')/size(signal,2)));
%             fourier = fft(signorm);
%             signal_original=fft(variumFreezing{i,3});
%             
%             P2 = abs(fourier/L).^2;
%             P1 = P2(1:L/2+1);
%             P1(2:end-1) = 2*P1(2:end-1);
%             
%             plot(f,P1)
%             ylim([0 0.0004])
%             title(char(variumFreezing{i+k,1}))
%             
%         end
% %         saveas(hax,sprintf('FFT_%s.jpg', variumFreezing{i,1}))
%     catch
%         continue
%     end
%     pause(pausa)    
% end
%%



