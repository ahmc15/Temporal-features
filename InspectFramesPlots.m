% PT-BR Script criado para a inspenção da métrica TI. Até o momento, a
% métrica da zeina está se mostrando ineficiente em detectar degradações em
% vídeos então calculou-se a TI na base de dados Varium. Nesse script, 
% tentou-se vários operações estatísticas para identificar o packetloss.
% 


filePath = 'C:\Users\Adm\Desktop\Temporal-Features\Varium\VariumDegradados\v2_1280x720_I12_pckErr5.avi';
pausa=2;
v = VideoReader(filePath);
NumFrames = countframes(v);
video = filePath;
v = VideoReader(video);
[~,TI]=ST_perc_info_measurement(video, 'max');
TI=TI';
%limite = prctile(TI, 75);
medialocal=[];
janela=zeros(1,5);
for j =6:(size(TI,1)-6)
    limite = max(TI(j-5:j+5,1));
    medialocal= [medialocal ,mean(TI(j-5:j+5,1))];
    if TI(j,1) >=limite
        janela=[janela,TI(j,1)];
        frameCandidato=rgb2gray(read(v,j));
        imshow(frameCandidato)
%         pause(pausa)
%         frameDiferenca = rgb2gray(read(v,j)-read(v,j-1));
%         imshow(frameDiferenca)
%         name=strcat('C:\Users\Adm\Desktop\Temporal-Features\frame',string(j),'.png');
%         imwrite(A,char(name))
%         title(TI(j,1))
        pause(pausa)
    else
        janela=[janela,0];
    end
end
janela=[janela, zeros(1,6)];
plot(TI)
hold on
stem(janela)
hold off

