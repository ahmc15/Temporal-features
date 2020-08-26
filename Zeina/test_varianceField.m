% test variance Field
videoname = 'C:\Users\Adm\Desktop\Temporal-Features\Databases\Experiment1\v01packetloss\v01_ANC1.avi'
video = VideoReader(videoname);
NumFrames = countframes(video);
video = VideoReader(videoname);
tempo = 2;
direction =  'horizontal';

frame = rgb2gray(read(video,tempo)); %current frame 
nextframe= rgb2gray(read(video,tempo+1));

[ difference, meanLocal, variancefield ] = varianceField( frame, nextframe, direction );
[pd, pm] = temporalPatches( difference, meanLocal );
[ diff, meanPat ] = temporalPatchThreshold( pd, pm);
[ MSCN ] = temporalMSCN( diff, meanPat, variancefield );
[ ggdParameters ] = ggdFitting( MSCN );
temporal_features{tempo,1} = ggdParameters;

