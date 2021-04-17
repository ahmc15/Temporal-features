clear all 

savepath = 'C:\Users\Adm\Desktop\Temporal-Features\MAT-files\BrisqueFeatures\brisqueFeaturesALL\';
load('C:\Users\Adm\Desktop\Temporal-Features\MAT-files\EXP1Brisque.mat');
for i = 1:size(EXP1Brisque,1)   
    features = transpose(EXP1Brisque{i,2}); 
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
    namefile = split(EXP1Brisque{i},'\');
    newnamefile = strcat(savepath,namefile{end}(1:end-4));
    save(newnamefile,'features');
end

