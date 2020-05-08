% % clear all 
fds = fileDatastore('C:\Users\andre\Desktop\Temporal-features\LIVE Video Quality Challenge (VQC) Database\Video\*.mp4','ReadFcn',@importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
% pristinemodel=cell(numFiles,4);
% pristinemodel = [fullFileNames,pristinemodel];
listaDirecao={'','horizontal','vertical', 'diagonal1','diagonal2'};
for j = 2:5
    for k = 1:numFiles
%     fprintf('Now reading file %s Files remaining:%d\n ', fullFileNames{k}(92:1:end),(numFiles-k) );
        if isempty(pristinemodel{k,j})
            try
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', fullFileNames{k}(92:1:end),k,j,listaDirecao{1,j});
                pristinemodel{k,j}=temporalFeatures(pristinemodel{k,1},listaDirecao{1,j});
            catch
                pristinemodel{k,j}='error'
            end
        else
            continue
        end
    end
    end
% Try again if it is error

for j = 2:5
    for k = 1:numFiles
%     fprintf('Now reading file %s Files remaining:%d\n ', fullFileNames{k}(92:1:end),(numFiles-k) );
        if pristinemodel{k,j}=='error'
            try
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', fullFileNames{k}(92:1:end),k,j,listaDirecao{1,j});
                pristinemodel{k,j}=temporalFeatures(pristinemodel{k,1},listaDirecao{1,j});
            catch
                pristinemodel{k,j}='error'
            end
        else
            continue
        end
    end
end
listafinal=[];
for k = 1: 585
    if isempty(pristinemodel{k,2})
        continue
    else
        listafinal=[listafinal;pristinemodel{k,2}];
    end
end
