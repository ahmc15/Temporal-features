%brisque for entire video


% PT-BR Script criado para a inspen��o da m�trica TI. At� o momento, a
% m�trica da zeina est� se mostrando ineficiente em detectar degrada��es em
% v�deos ent�o calculou-se a TI na base de dados Varium. Nesse script,
% tentou-se v�rios opera��es estat�sticas para identificar o packetloss.
%

clear all
fds = fileDatastore('D:\DatabaseTemporalFeatures\Experiment1\*avi', 'ReadFcn', @importdata);
fileNamesavi = fds.Files;
fullFileNames = [fileNamesavi];
nFiles = length(fullFileNames);
cellFeatures = cell(nFiles,1);
variumBrisque = [fullFileNames,cellFeatures];

for ifile=1:1:nFiles
    tic
    namefile = split(fullFileNames{ifile},'\');
    try
        fprintf('Now reading file %s; \n ', namefile{end});
        brisque = BrisqueVideo(variumBrisque{ifile,1});
        variumBrisque{ifile,2}=brisque;
    catch
        fprintf('ERROR on file file %s; \n ', namefile{end});
        variumBrisque{ifile,2}='error';
    end
    toc
end
EXP1Brisque = variumBrisque;
save('EXP1Brisque','EXP1Brisque')
