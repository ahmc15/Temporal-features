videoname = 'Databases\Varium\VariumDegradados\Packetloss\v12_1280x720_I12.avi';
video = VideoReader(videoname);
temporal_features = [];
tempo=120
direction='horizontal';
frame = rgb2gray(read(video,tempo)); %current frame
nextframe= rgb2gray(read(video,tempo+1));
[ difference, meanLocal, variancefield ] = varianceField( frame, nextframe, direction );
[pd, pm] = temporalPatches( difference, meanLocal );
[ diff, meanPat ] = temporalPatchThreshold( pd, pm);
[ MSCN ] = temporalMSCN( diff, meanPat, variancefield );
for i=1:size(MSCN,3)
    histogram(MSCN(:,:,i));
    pause(1)
end
