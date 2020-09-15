% test variance Field
% clear all
videoname = 'C:\Users\Adm\Desktop\Temporal-Features\Databases\Experiment1\v01packetloss\v01_ANC1.avi';
video = VideoReader(videoname);
NumFrames = countframes(video);
video = VideoReader(videoname);
tempo = 100;
direction =  'horizontal';

frame = rgb2gray(read(video,tempo)); %current frame 
nextframe= rgb2gray(read(video,tempo+1));

[ difference, meanLocal, variancefield ] = varianceField( frame, nextframe, direction );
[pd, pm] = temporalPatches( difference, meanLocal );
[ diff, meanPat ] = temporalPatchThreshold( pd, pm);
[ MSCN ] = temporalMSCN( diff, meanPat, variancefield );
[ ggdParameters ] = ggdFitting( MSCN );
temporal_features{1,1} = ggdParameters;

desktopframe100 = struct();
myvars = who;
for i=1:length(myvars)
    desktopframe100.(myvars{i,1}) = eval(myvars{i,1});
end
save('desktopAndreframe100.mat','desktopframe100');