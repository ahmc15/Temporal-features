function [ temporal_features ] = temporalFeatures( videoname, direction )
%Calculate de temporal features from a entire video file
%   Detailed explanation goes here
%   INPUT
%         videoname: string of the video file with extension
%   OUTPUT
%         temporalFeatures: matrix of size (n,2). Each column is one of the
%           two parameters of the generalized gaussian distribution of all
%           the patches of all frames
%   Code:
%       here describe the code

%%

video = VideoReader(videoname);
NumFrames = floor(video.FrameRate*video.Duration);
temporal_features = [];

for tempo= 1:NumFrames-1
    
    frame = rgb2gray(read(video,tempo)); %frame atual
    nextframe= rgb2gray(read(video,tempo+1));
    [ difference, meanLocal, variancefield ] = varianceField( frame, nextframe, direction );
    [pd, pm] = temporalPatches( difference, meanLocal );
    [ diff, meanPat ] = temporalPatchThreshold( pd, pm);
    [ MSCN ] = temporalMSCN( diff, meanPat, variancefield );
    [ ggdParameters ] = ggdFitting( MSCN );
    temporal_features = [temporal_features; ggdParameters];
    
end

