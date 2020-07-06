function nf=numFrames(dirIN, format)

%global
width=1280;
height=720;
fwidth=0.5;
fheight=0.5;
nf=[];
switch format
    case 'yuv'
        D = dir (strcat(dirIN,'*.yuv'));
        [nFiles, temp] = size(D);
        for idx = 1:nFiles
            nameFile = strcat(dirIN,D(idx).name);
            filep = dir(nameFile);
            fileBytes = filep.bytes; %Filesize1
            clear filep
            framenumber = fileBytes/(width*height*(1+2*fheight*fwidth)); %Framenumber1
            framenumber=floor(framenumber);
            nf=[nf;framenumber];
        end
    case 'avi'
        D = dir (strcat(dirIN,'*.avi'));
        [nFiles, temp] = size(D);
        for idx = 1:nFiles
            nameFile = strcat(dirIN,D(idx).name);
            videoObject = VideoReader(nameFile);
            framenumber = videoObject.NumberOfFrames;
            nf=[nf;framenumber];
        end
end