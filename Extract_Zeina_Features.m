% Get a list of all txt files in the current folder, or subfolders of it.
clear all
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumDegradados\Freezing\*.avi','ReadFcn',@importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
pristinemodel=cell(numFiles,4);
pristinemodel = [fullFileNames,pristinemodel];%append list of names
listaDirecao={'','horizontal','vertical', 'diagonal1','diagonal2'};
for j = 2:5
    for k = 1:numFiles
        if isempty(pristinemodel{k,j})
            try
                namefile = split(fullFileNames{k},'\');
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', namefile(end),k,j,listaDirecao{1,j});
                pristinemodel{k,j}=temporalFeatures(pristinemodel{k,1},listaDirecao{1,j});
            catch
                pristinemodel{k,j}='error'
            end
        else
            continue
        end
    end
    save('VariumDegradados','pristinemodel')
end
%% Try again if it is error

for j = 2:5
    for k = 1:numFiles
        if pristinemodel{k,j}=='error'
            try
                namefile = split(fullFileNames{k},'\');
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', namefile(end),k,j,listaDirecao{1,j});
                pristinemodel{k,j}=temporalFeatures(pristinemodel{k,1},listaDirecao{1,j});
            catch
                pristinemodel{k,j}='error'
            end
        else
            continue
        end
    end
    VariumDegradados = pristinemodel;
    save('VariumDegradados','VariumDegradados')
end


