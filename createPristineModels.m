function [ horizontalmodel, verticalmodel, diagonal1model, diagonal2model ] = createPristineModels( videopath )
% Extracts the features of a collection of videos files in a folder
%   Detailed explanation goes here

fds = fileDatastore(strcat(videopath,'\*.avi'), 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);

horizontalmodel = [];
verticalmodel = [];
diagonal1model = [];
diagonal2model = [];

for k = 1 : numFiles
    fprintf('Now reading file %s. Files left %d\n', fullFileNames{k}(62:end), (numFiles-k));
    horizontal = temporalFeatures(fullFileNames{k},'horizontal');
    vertical = temporalFeatures(fullFileNames{k},'vertical');
    diagonal1 = temporalFeatures(fullFileNames{k},'diagonal1');
    diagonal2 = temporalFeatures(fullFileNames{k},'diagonal2');
    
    horizontalmodel = [horizontalmodel; horizontal];
    verticalmodel = [verticalmodel; vertical];
    diagonal1model = [diagonal1model, vertical];
    diagonal2model = [diagonal2model, vertical];

end
save('PristineModelExp1','fullFileNames','horizontalmodel','verticalmodel','diagonal1model','diagonal2model')


end

