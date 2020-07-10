% restoredefaultpath;
clear variables;
clc

ffmpeg='C:\Users\Adm\Desktop\ffmpeg\bin\ffmpeg.exe';
dirIN='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\';
dirOutput='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\plusAudio\';

D = dir (strcat(dirIN,'*.avi'));
[nFiles, temp] = size(D);
result=[];

for idx = 1:nFiles
    input = strcat(dirIN,D(idx).name);
    output1=strrep(input,dirIN,'');
    system_input=[ffmpeg,' ','-i',' ',input,' ','-f lavfi -i anullsrc -c:v copy -c:a pcm_s16le -ac 2 -ar 48000 -shortest -y',' ',dirOutput,output1]
    output=system(system_input);
end