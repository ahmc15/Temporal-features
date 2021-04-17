clear all 
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\MAT-files\Zeinafeatures\vertical\*.mat','ReadFcn',@importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
savepath = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\Zeinafeatures\verticalmedia\';

for i = 1:numFiles
    load(fullFileNames{i});
%       featuresMedia = makeMediaFeatures(featuresVertical )
    featuresMedia = features;
    for j = 1:size(features,2)
        media = mean(features{1,j},1);
        featuresMedia{1,j} = media(1,1);
        featuresMedia{2,j} = media(1,2);
    end
    features = cell2mat(featuresMedia);
    features = [features,features(:,end)];
    features2=zeros(size(features,1),(round(size(features,2)/10)));
    
    for m = 1:size(features2,1)
        for k = 1:(size(features2,2)-1)
            if k == (size(features2,2)-1)
                features2(m,k) = mean(features(m,10*k:end));
            else
                features2(m,k) = mean(features(m,10*k:10*k+10));
            end
        end
    end
    features = features2;  
    namefile = split(fullFileNames{i},'\');
    newnamefile = strcat(savepath,namefile{end}(1:end-4));
    save(newnamefile,'features');
end

