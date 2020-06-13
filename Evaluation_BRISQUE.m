%brisque for entire video


% PT-BR Script criado para a inspen��o da m�trica TI. At� o momento, a
% m�trica da zeina est� se mostrando ineficiente em detectar degrada��es em
% v�deos ent�o calculou-se a TI na base de dados Varium. Nesse script, 
% tentou-se v�rios opera��es estat�sticas para identificar o packetloss.
% 

clear all
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Varium\VariumDegradados\*.avi', 'ReadFcn', @importdata);
FileNamesavi = fds.Files;
fullFileNames = [FileNamesavi];
numFiles = length(fullFileNames);
CellFeatures = cell(numFiles,1);
VariumBrisque = [fullFileNames,CellFeatures];

for file=1:numFiles
    if isempty(VariumBrisque{file,2})
        try
            fprintf('Now reading file %s; \n ', fullFileNames{file}(64:1:end),file);
            brisque = BrisqueVideo(VariumBrisque{numFiles,1});
            VariumBrisque{file,2}=brisque;
        catch
            VariumBrisque{file,2}='error';
        end
    end
end
save('VariumDegradadosBrisque','VariumBrisque')
