clear variables;
clc;

%File list of avi files: files list, frame number list
dirIN='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\plusAudio\';
D = dir (strcat(dirIN,'*.avi'));
[nFiles, ~] = size(D);
nf=numFrames('C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\plusAudio\','avi');

%Loading Audio
dirINa='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\plusAudio\';
Da=dir (strcat(dirINa,'*.wav'));
[nFilesa, temp] = size(Da);

%Aux Variables
bitrateLvs=length([1]);

%Output directory for processed videos (Stalling)
dirOutput='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\plusAudio\hrc7\';
%Output directory for avs files
avsDirFile='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumOriginais\plusAudio\avs\';

for idx = 1:bitrateLvs:nFiles
    %Video to be processed (input)
    video1 = strcat(dirIN,D(idx).name);
    %Audio to be processed
    idy=floor((idx-1)/bitrateLvs)+1;
    audio=strcat(dirINa,Da(idx).name);
    %Base Video name
    v_name=strrep(D(idx).name,'.avi','');
    
    %Set all stalling parameters
    stn=1;
    hrc='_HRC10';
    processAvScript(hrc, nf(idx), dirOutput, avsDirFile, video1, audio, v_name, stn, [2], [2]);
end