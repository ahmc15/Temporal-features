% 
% clear all
% videopath = 'C:\Users\Adm\Desktop\Temporal-Features\LIVE Video Quality Challenge (VQC) Database\Video\';
% videoList = load('C:\Users\Adm\Desktop\Temporal-Features\LIVE Video Quality Challenge (VQC) Database\newdata.mat');
% videoList = videoList.videoList;
% 
% pristinemodel1 = load('PristineModelDiagonal2.mat');
% pristinemodel1 = pristinemodel1.PristineModelDiagonal2;
% pristinemodel = [pristinemodel1];
% direction='diagonal2';
% Distances=[];
% 
% for k=1:length(videoList)
%     fprintf('Now reading file %s. Files left %d\n', videoList{k},(length(videoList)-k));
%     video = strcat(videopath,videoList{k});
%     msgmodel = temporalFeatures(video,direction);
%     distance = MahalanobisDistance(msgmodel,pristinemodel);
%     Distances=[Distances; distance];   
% end
% save(strcat('distancia',direction),'Distances');
%%
close all
load('VariumOriginaisBrisque.mat');
load('LIVEVQCBrisque.mat');
load('stockvideosmovBrisque.mat');
load('stockvideosmp4Brisque.mat');
pristinemodel=[];
listaNomes=cell(size(variumOriginaisBrisque,1),37);
for i=1:size(variumOriginaisBrisque,1)
    feat = variumOriginaisBrisque{i,2};
    pristinemodel= [pristinemodel;feat];
end
% 
% for i=1:size(stockvideosmov,1)
%     feat = stockvideosmov{i,2};
%     pristinemodel= [pristinemodel;feat];
% end
% for i=1:size(stockvideosmp4,1)
%     try
%         feat = stockvideosmp4{i,2};
%         pristinemodel= [pristinemodel;feat];
%     catch
%         continue
%     end
% end
[row, col] = find(isnan(pristinemodel));
pristinemodel(row,:)=[];

Distances=[];
for i =1:size(LIVEVQCBrisque,1)%cada linha ou para cada vídeo
    listaNomes{i,1} = LIVEVQCBrisque{i,1}(end-7:end);%pegar o nome do video
    features = LIVEVQCBrisque{i,2};%pegar todas as features desse video
    features = deletenanline(features);
    
    distance = MahalanobisDistance(features(:,1:3),pristinemodel(:,1:3));
    Distances = [Distances;distance];
    listaNomes{i,1+1} = distance;
end
        
load('newmos.mat')
figure() 
scatter(newmos,(-Distances(:,1)),'filled')%,'MarkerFaceAlpha',.6)
title('Features all')
ylabel('-Mahalanobis Distance') 
xlabel('MOS') 


