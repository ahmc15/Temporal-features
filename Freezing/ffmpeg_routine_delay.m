%routine for ffmpeg
% output = system('H:\SESQA-p563\Software\bin\p563.exe H:\audio\clean\sp01.wav -out H:\put.txt');
clear variables;
clc;
%setting the parameters
%ffmpeg='C:\Users\Helard\Dropbox\Pesquisa-Unb\Metrics\ffmpeg\bin\ffmpeg.exe';
ffmpeg='C:\Users\hlrdb\Dropbox\Pesquisa-Unb\Metrics\ffmpeg32\ffmpeg\bin\ffmpeg.exe';

%input='D:\videot\video_only2.avi';

dirTest='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\avs\';
%dirTest='F:\vqegMM2_library(BD2)\';

%dirOutput='D:\videot\TestConditions\av2_TestConditions_imp2\';
dirOutput='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\avs\';

D = dir (strcat(dirTest,'*.avs'));
[nFiles, temp] = size(D);
result=[];

for idx = 1:nFiles
    %input1
    input2 = strcat(dirTest,D(idx).name);
    %[IN,fs,nb] = wavread(inFileName);
    %output
    output1=strrep(input2,dirTest,'');
    output1=strrep(output1,'.avs','');
    %output1=strrep(output1,'vqegMM2_','');
    %output1=strrep(output1,'-H','_H');
    %output1=strrep(output1,'Horig-Aorig','original');
    %names(idx,1)={name};
    %names=[names,',',name];
    %system_input=[ffmpeg,' ','-i',' ',input2,' ','-vcodec rawvideo -pix_fmt uyvy422 -y',' ',dirOutput,output1,'.avi'];
    system_input=[ffmpeg,' ','-i',' ',input2,' ','-c:v copy -r 30 -acodec pcm_s16le -ac 2 -ar 48000 -y',' ',dirOutput,output1,'.avi']
    %system_input=[ffmpeg,' ','-i',' ',input2,' ','-vcodec rawvideo -pix_fmt uyvy422 -acodec pcm_s16le -ac 2 -y',' ',dirOutput,output1,'.avi'];
    %quality=PQevalAudio (fileRef,inFileName);
    %-f rawvideo -vcodec copy -pix_fmt yuv420p -s 640x480 -r 30 
    %yuv420p
    output=system(system_input);
end