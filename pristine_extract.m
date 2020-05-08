% Get a list of all txt files in the current folder, or subfolders of it.
clear all
direction = 'horizontal';

% fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\*.mp4', 'ReadFcn', @importdata);
% FileNamesMp4 = fds.Files;
% fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\*.mov', 'ReadFcn', @importdata);
% FileNamesMov = fds.Files;
% fullFileNames = [FileNamesMp4; FileNamesMov];
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Experiment1\originais\*.avi', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
%Loop over all files reading them in and plotting them.
Exp1HorizontalModel = [];
for k = 1 : numFiles
    fprintf('Now reading file %s. Files left %d\n', fullFileNames{k}(62:end), (numFiles-k));
    pristine = temporalFeatures(fullFileNames{k},direction);
    Exp1HorizontalModel  = [Exp1HorizontalModel ; pristine];
end

save(strcat('Exp1',direction,'files.mat'),'fullFileNames','Exp1HorizontalModel');