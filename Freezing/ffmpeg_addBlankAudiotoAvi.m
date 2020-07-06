restoredefaultpath;
clear variables;
clc

ffmpeg='C:\Users\hlrdb\Dropbox\Pesquisa-Unb\Metrics\ffmpeg\bin\ffmpeg.exe';

dirIN='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\';

dirOutput='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\';

D = dir (strcat(dirIN,'*.avi'));
[nFiles, temp] = size(D);
result=[];

for idx = 1:nFiles
    input = strcat(dirIN,D(idx).name);
    output1=strrep(input,dirIN,'');
    system_input=[ffmpeg,' ','-i',' ',input,' ','-f lavfi -i anullsrc -c:v copy -c:a pcm_s16le -ac 2 -ar 48000 -shortest -y',' ',dirOutput,output1]
    output=system(system_input);
end