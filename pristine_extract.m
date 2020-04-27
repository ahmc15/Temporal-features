% Get a list of all txt files in the current folder, or subfolders of it.
clear all
direction = 'diagonal1';

fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\*.mp4', 'ReadFcn', @importdata);
FileNamesMp4 = fds.Files;
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\*.mov', 'ReadFcn', @importdata);
FileNamesMov = fds.Files;
fullFileNames = [FileNamesMp4; FileNamesMov];
numFiles = length(fullFileNames);
%Loop over all files reading them in and plotting them.
PristineModel = [];
for k = 1 : numFiles
    fprintf('Now reading file %s. Files left %d\n', fullFileNames{k}(55:end), (numFiles-k));
    pristine = temporalFeatures(fullFileNames{k},direction);
    PristineModel  = [PristineModel ; pristine];
end

save(strcat('PristineModel',direction,'files.mat'),'PristineModel');