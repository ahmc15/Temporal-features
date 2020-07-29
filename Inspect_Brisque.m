%Script created for inspecting the brisque features of the Varium database
close all
% clear all
% load('VariumDegradadosBrisque.mat')
lengthVideo= size(variumBrisque,1);
salvar = true;
for j=1:36
    featureDirPath=char(strcat('./Resultados/Feature',string(j),'/'));
    status=mkdir(featureDirPath);
    for i=1:6:lengthVideo
        try
            for k=0:5
                hax=subplot(2,3,k+1);
                x0=90;
                y0=90;
                width=1250;
                height=900;
                set(gcf,'position',[x0,y0,width,height])
                
                feature = variumBrisque{i,2}(:,j);
                featureDegradada = variumBrisque{i+k,2}(:,j);
                plot(featureDegradada-feature);
                title(char(strcat('Feature',string(j),{' '},variumBrisque{i+k,1}(74:end))))
            end
        catch
            continue
        end
        %         pause(2)
%         if salvar
%             saveas(hax,sprintf('%sbrisque_differenceFeature%d_%s.jpg',featureDirPath,j, variumBrisque{i,1}(74:end-4)))
%         end
    end
end
