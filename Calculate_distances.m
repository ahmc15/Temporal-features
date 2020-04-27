% 
clear all
videopath = 'C:\Users\Adm\Desktop\Temporal-Features\LIVE Video Quality Challenge (VQC) Database\Video\';
videoList = load('C:\Users\Adm\Desktop\Temporal-Features\LIVE Video Quality Challenge (VQC) Database\newdata.mat');
videoList = videoList.videoList;

pristinemodel1 = load('PristineModelDiagonal2.mat');
pristinemodel1 = pristinemodel1.PristineModelDiagonal2;
pristinemodel = [pristinemodel1];
direction='diagonal2';
Distances=[];

for k=1:length(videoList)
    fprintf('Now reading file %s. Files left %d\n', videoList{k},(length(videoList)-k));
    video = strcat(videopath,videoList{k});
    msgmodel = temporalFeatures(video,direction);
    distance = MahalanobisDistance(msgmodel,pristinemodel);
    Distances=[Distances; distance];   
end
save(strcat('distancia',direction),'Distances');