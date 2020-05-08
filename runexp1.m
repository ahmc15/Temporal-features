clear all
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Experiment1\v01packetloss\*.avi', 'ReadFcn', @importdata);
FileNamesavi = fds.Files;
fullFileNames = [FileNamesavi];
numFiles = length(fullFileNames);

pristinemodel1 = load('Exp1Horizontalv1atev45.mat');
pristinemodel1 = pristinemodel1.Exp1HorizontalModel;
pristinemodel = [pristinemodel1];
direction='horizontal';
% pristinemodel1 = temporalFeatures('C:\Users\Adm\Desktop\Temporal-Features\Experiment1\v01_ANC1.avi',direction);
% pristinemodel2 = temporalFeatures('C:\Users\Adm\Desktop\Temporal-Features\Experiment1\v01.avi',direction);
% pristinemodel = [pristinemodel1; pristinemodel2];
Distances=[];
%Loop over all files reading them in and plotting them.

for k = 1 : numFiles
    fprintf('Now reading file %s. Files left %d\n', fullFileNames{k}(66:end), (numFiles-k));
    video = fullFileNames{k};
    msgmodel = temporalFeatures(video,direction);
    distance = MahalanobisDistance(msgmodel,pristinemodel);
    Distances=[Distances; distance]; 
end
sound(2*sin(1:10000));
% save(strcat('distancia',direction),'Distances');