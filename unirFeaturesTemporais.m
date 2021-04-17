clear all 
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\MAT-files\BrisqueFeatures\*.mat','ReadFcn',@importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
path1 = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\BrisqueFeatures\';
pathH = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\Zeinafeatures\horizontalALL\';
pathV = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\Zeinafeatures\verticalALL\';
pathD1 = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\Zeinafeatures\diagonal1ALL\';
pathD2 = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\Zeinafeatures\diagonal2ALL\';
pathlist = {path1, pathH, pathV, pathD1, pathD2};
savepath='C:\Users\Adm\Desktop\Temporal-Features\MAT-files\temporalFeturesConcatenation\Experiment_1_patch\';
for i = 1:numFiles
    namefile = split(fullFileNames{i},'\');
    namefile = namefile{end};
    newnamefile = strcat(savepath,namefile(1:end-4));
    visualFeatures=[];
    for dir = 1:size(pathlist,2)
        try
            load(strcat(pathlist{dir},namefile));
            visualFeatures = [visualFeatures;features];
        catch exception
            if size(visualFeatures,2)> size(features,2)
                
                diferenca = size(visualFeatures,2)-size(features,2);
                features = [features,repmat(features(:,end),1,diferenca)];
                visualFeatures = [visualFeatures;features];
                
             elseif size(visualFeatures,2)<size(features,2)
                 
                diferenca = size(visualFeatures,2)-size(features,2);
                features = features(:,1:end+diferenca);
                visualFeatures = [visualFeatures;features];
    end
        end
    end
     
    
    save(newnamefile,'visualFeatures');
end

