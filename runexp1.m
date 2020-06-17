clear all
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Varium\VariumDegradados\*.avi', 'ReadFcn', @importdata);
FileNamesavi = fds.Files;
fullFileNames = [FileNamesavi];
nFiles = length(fullFileNames);

horizontalModel=[];
verticalModel=[];
diagonal1Model=[];
diagonal2Model=[];

load('.\Varium\PristineVarium.mat');
for i=1:size(pristinemodel,1)
    horizontalModel=[horizontalModel;pristinemodel{i,2}];
    verticalModel=[verticalModel;pristinemodel{i,3}];
    diagonal1Model=[diagonal1Model;pristinemodel{i,4}];
    diagonal2Model=[diagonal2Model;pristinemodel{i,5}];
end
listaDirecao={'','horizontal','vertical', 'diagonal1','diagonal2'};
listaModelos={'',horizontalModel,verticalModel,diagonal1Model,diagonal2Model};
DistancesVarium=cell(nFiles,4);
DistancesVarium = [fullFileNames,DistancesVarium];

for j=2:5
    for k = 1:nFiles
        if isempty(DistancesVarium{k,j})
            try
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', fullFileNames{k}(64:1:end),k,j,listaDirecao{1,j});
                video = fullFileNames{k};
                msgmodel = temporalFeatures(video,listaDirecao{1,j});
                DistancesVarium{k,j} = MahalanobisDistance(msgmodel,listaModelos{1,j});
            catch
                DistancesVarium{k,j} = 'error'
            end
        end
    end
    save('DistancesVarium','DistancesVarium')
end

for j=2:5
    for k = 1 : nFiles
        if DistancesVarium{k,j}=='error'
            try
                fprintf('Now reading file %s; posistion=(%d,%d); %s\n ', fullFileNames{k}(64:1:end),k,j,listaDirecao{1,j});
                video = fullFileNames{k};
                msgmodel = temporalFeatures(video,listaDirecao{1,j});
                DistancesVarium{k,j} = MahalanobisDistance(msgmodel,listaModelos{1,j});
            catch
                DistancesVarium{k,j} = 'error'
            end
        end
    end
    save('DistancesVarium','DistancesVarium')
end
% sound(2*sin(1:10000));
% save(strcat('distancia',direction),'Distances');