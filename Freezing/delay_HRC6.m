clear all;
clc;
%ffmpeg
%ffmpeg='C:\Users\Helard\Dropbox\Pesquisa-Unb\Metrics\ffmpeg\bin\ffmpeg.exe';

%File list of avi files: files list, frame number list
%dirIN='D:\Experimentos\h265\rec\';
%dirIN='D:\videos\Avi-Videos\hrc6\';
dirIN='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\';

%dirIN='D:\videos\Avi-Videos\rec_265\';
D = dir (strcat(dirIN,'*.avi'));
[nFiles, temp] = size(D);
%nf=numFrames('H:\VideosInput\');
nf=numFrames('C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\','avi');

%Loading Audio
%dirINa='H:\VideosInput\WavComponent\';
dirINa='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\';
Da=dir (strcat(dirINa,'*.wav'));
[nFilesa, temp] = size(Da);

%Aux Variables
%bitrateLvs=length([1 2 3 4]);
bitrateLvs=length([1]);

%Output directory for processed videos (Stalling)
dirOutput='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\hrc6\';
%Output directory for avs files
avsDirFile='C:\Users\hlrdb\Documents\AV-Research\VARIUM-sample\plusAudio\avs\';
for idx = 1:bitrateLvs:nFiles
    %Video to be processed (input)
    video1 = strcat(dirIN,D(idx).name);
    %Audio to be processed
    idy=floor((idx-1)/bitrateLvs)+1;
    audio=strcat(dirINa,Da(idx).name);
    %Base Video name
    v_name=strrep(D(idx).name,'.avi','');
    
    %Set all stalling parameters
    stn=3;
    hrc='_HRC6';
    processAvScript(hrc, nf(idx), dirOutput, avsDirFile, video1, audio, v_name, stn, [1 2 3], [3 3 2]);
    
    
    %Here we define the number of stalling effects that the video will have
%     for stn=1:3
%         switch stn
%             %####### ONE STALLING EVENT #########
%             case 1
%                 for pos=1:3
%                     for len=1:3
%                         if (pos==2)&&(len==2)
%                         processAvScript(ffmpeg, nf(idy), dirOutput, avsDirFile, video1, audio, v_name, stn, [pos], [len]);
%                         end
%                     end
%                 end
%             %####### TWO STALLING EVENTS #########    
%             case 2
%                 for pos1=1:3
%                     for pos2=1:3
%                         for len1=1:3
%                             for len2=1:3
%                                 if (pos1~=pos2)
%                                     if ((pos1==1)&&(pos2==3)&&(len1==1)&&(len2==3))||((pos1==2)&&(pos2==3)&&(len1==2)&&(len2==2))
%                                    processAvScript(ffmpeg, nf(idy), dirOutput, avsDirFile, video1, audio, v_name,stn, [pos1,pos2], [len1, len2]);
%                                     end
%                                 end
%                             end
%                         end
%                     end
%                 end
%             %####### THREE STALLING EVENTS #########    
%             otherwise
%                 for pos1=1:3
%                     for pos2=1:3
%                         for pos3=1:3
%                             for len1=1:3
%                                 for len2=1:3
%                                     for len3=1:3
%                                         if (pos1~=pos2)&&(pos1~=pos3)&&(pos2~=pos3)
%                                             if ((pos1==1)&&(pos2==2)&&(pos3==3)&&(len1==2)&&(len2==2)&&(len3==3))||((pos1==1)&&(pos2==2)&&(pos3==3)&&(len1==3)&&(len2==3)&&(len3==2))
%                                             processAvScript(ffmpeg, nf(idy), dirOutput, avsDirFile, video1, audio, v_name,stn, [pos1,pos2,pos3],[len1,len2,len3]);
%                                             end
%                                         end
%                                     end
%                                 end
%                             end
%                         end
%                     end
%                 end
%         end
%     end
end