% Get a list of all txt files in the current folder, or subfolders of it.
clear all
% fds = fileDatastore('*.mov', 'ReadFcn', @importdata)
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\*.mp4', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
% Loop over all files reading them in and plotting them.
PristineModel = [];
for k = 1 : numFiles
    fprintf('Now reading file %s\n', fullFileNames{k});
    pristine = temporalFeatures(fullFileNames{k},'horizontal');
%     pristine = temporalFeatures('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\049021673childrunningsunset.mp4','horizontal');
    PristineModel  = [PristineModel ; pristine];
    % Now have code to read in the data using whatever function you want.
    % Now code to plot the data or process it however you want...
end

% fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\*.mov', 'ReadFcn', @importdata);
% fullFileNames = fds.Files;
% numFiles = length(fullFileNames);
% % Loop over all files reading them in and plotting them.
% for k = 1 : 10%numFiles
%     fprintf('Now reading file %s\n', fullFileNames{k});
%     pristine = temporalFeatures(fullFileNames{k},'horizontal');
% %     pristine = temporalFeatures('C:\Users\Adm\Desktop\Temporal-Features\PristineVideos\049021673childrunningsunset.mp4','horizontal');
%     PristineModel  = [PristineModel ; pristine];
%     % Now have code to read in the data using whatever function you want.
%     % Now code to plot the data or process it however you want...
% 
% end
save('PristineModelHorizontalfiles.mat','PristineModel');