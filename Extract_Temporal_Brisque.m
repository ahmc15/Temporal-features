% Get a list of all txt files in the current folder, or subfolders of it.
clear all
fprintf('START \n');
% fds = fileDatastore('/home/andre/Documents/UnB-AVQ-2018/Exp1/*avi','ReadFcn',@importdata);
fds = fileDatastore('D:\DatabaseTemporalFeatures\Experiment1\v01packetloss\*avi','ReadFcn',@importdata);
% fds = fileDatastore('C:\Users\Adm\Desktop\videov40HRC6\*avi','ReadFcn',@importdata);
%fds = fileDatastore('D:\DatabaseTemporalFeatures\Experiment1\v01packetloss\*avi','ReadFcn',@importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
LimFiles = 3;
Im_Exp1_Teste=cell(numFiles,1);
Im_Exp1_Teste = [fullFileNames,Im_Exp1_Teste];%append list of names
%load('Im_Exp1_Teste500to600.mat')

for k = 1:numFiles 
        if isempty(Im_Exp1_Teste{k,2})
            try
                namefile = split(fullFileNames{k},'\');                
                fprintf('Now reading file; posistion=(%d,%d) \n ' ,k,2);
                Im_Exp1_Teste{k,2}=TemporalBrisqueVideo(Im_Exp1_Teste{k,1});                
            catch exception
                msgText = getReport(exception,'extended','hyperlinks','off');
                Im_Exp1_Teste{k,2}=msgText;
            end
        else
            continue            
        end
        if not(mod(k,5)) %saves after completing every 5% of the total video
            save('Im_Teste_TemporalBrisque','Im_Exp1_Teste');
        end    
    save('Im_Teste_TemporalBrisque','Im_Exp1_Teste');
 end