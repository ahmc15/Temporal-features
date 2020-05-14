% Get a list of all txt files in the current folder, or subfolders of it.


clear all
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Varium\VariumOriginais\*.avi','ReadFcn',@importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
pristinemodel=cell(numFiles,4);
pristinemodel = [fullFileNames,pristinemodel];
listaDirecao={'','horizontal','vertical', 'diagonal1','diagonal2'};
for j = 2:5
    for k = 1:numFiles
        if isempty(pristinemodel{k,j})
            try
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', fullFileNames{k}(63:1:end),k,j,listaDirecao{1,j});
                pristinemodel{k,j}=temporalFeatures(pristinemodel{k,1},listaDirecao{1,j});
            catch
                pristinemodel{k,j}='error'
            end
        else
            continue
        end
    end
    save('PristineVarium','pristinemodel')
end
%% Try again if it is error

for j = 2:5
    for k = 1:numFiles
        if pristinemodel{k,j}=='error'
            try
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', fullFileNames{k}(63:1:end),k,j,listaDirecao{1,j});
                pristinemodel{k,j}=temporalFeatures(pristinemodel{k,1},listaDirecao{1,j});
            catch
                pristinemodel{k,j}='error'
            end
        else
            continue
        end
    end
    save('PristineVarium','pristinemodel')
end


