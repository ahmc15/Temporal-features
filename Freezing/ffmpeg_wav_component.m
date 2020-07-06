%routine for ffmpeg
% output = system('H:\SESQA-p563\Software\bin\p563.exe H:\audio\clean\sp01.wav -out H:\put.txt');
restoredefaultpath;
clear variables;
clc
%setting the parameters
%ffmpeg='D:\unb\pesquisa\PESQUISA\Instaladores\SOFTWARE-ffmpeg\ffmpeg\bin\ffmpeg.exe';
ffmpeg='C:\Users\hlrdb\Dropbox\Pesquisa-Unb\Metrics\ffmpeg\bin\ffmpeg.exe';
%input='D:\videot\video_only2.avi';
%dirTest='C:\Users\Helard\Dropbox\Pesquisa-Unb\Metrics\Audio\db-audio\wave-files(BD2)\Ref\';

dirIN='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\';



D = dir (strcat(dirIN,'*.avi'));
[nFiles, temp] = size(D);

%########### LOW ################
dirOutput='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\';

for idx = 1:nFiles
    %input1
    input = strcat(dirIN,D(idx).name);
    %[IN,fs,nb] = wavread(inFileName);
    %output
    output1=strrep(input,dirIN,'');
    output1=strrep(output1,'.avi','.wav');
    %output1=strrep(output1,'vqegMM2_','');
    %output1=strrep(output1,'-H','_H');
    %output1=strrep(output1,'Horig-Aorig','original');
    %names(idx,1)={name};
    %names=[names,',',name];
    %system_input=[ffmpeg,' ','-i',' ',input,' ','-vcodec copy -an -r 30 -pix_fmt yuv420p',' ','-y',' ',dirOutput,output1,'.avi'];
    %system_input=[ffmpeg,' ','-i',' ',input,' ','-vcodec rawvideo -pix_fmt uyvy422 -r 30 -s 640x480 -an',' ','-y',' ',dirOutput,output1,'.avi'];
    system_input=[ffmpeg,' -i ',input,' ','-acodec pcm_s16le -ac 2 -ar 48000 -y',' ',dirOutput,output1]
    %system_input=[ffmpeg,' ','-i',' ',input,' ','-vn -ar 20000 -y',' ',dirOutput,output1,'.wav'];    
    %system_input=[ffmpeg,' ','-i',' ',input,' ','-vcodec libx264 -vb 800k -pix_fmt yuv420p -r 30 -s 176x144 -an',' ','-y',' ',dirOutput,output1,'.avi'];
    %quality=PQevalAudio (fileRef,inFileName);
    %-acodec libmp3lame
    output=system(system_input);
    %system_input
end