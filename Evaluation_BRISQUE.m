%brisque for entire video


% PT-BR Script criado para a inspenção da métrica TI. Até o momento, a
% métrica da zeina está se mostrando ineficiente em detectar degradações em
% vídeos então calculou-se a TI na base de dados Varium. Nesse script,
% tentou-se vários operações estatísticas para identificar o packetloss.
%

clear all
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumDegradados\*.avi', 'ReadFcn', @importdata);
fileNamesavi = fds.Files;
fullFileNames = [fileNamesavi];
nFiles = length(fullFileNames);
cellFeatures = cell(nFiles,1);
variumBrisque = [fullFileNames,cellFeatures];

for ifile=1:1:nFiles
    try
        fprintf('Now reading file %s; \n ', fullFileNames{ifile}(74:1:end));
        brisque = BrisqueVideo(variumBrisque{ifile,1});
        variumBrisque{ifile,2}=brisque;
    catch
        variumBrisque{ifile,2}='error';
    end
    
end
save('VariumDegradadosBrisque','variumBrisque')
