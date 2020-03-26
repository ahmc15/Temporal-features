function [ output_args ] = temporalFeatures( input_args )
%Calculate de temporal features from a entire video file
%   Detailed explanation goes here

% video = VideoReader('Megamind.avi');
% NumFrames = floor(video.FrameRate*video.Duration);
% tempo = 30;
% frame = rgb2gray(read(video,tempo)); %frame atual
% nextframe= rgb2gray(read(video,tempo+1));
% [ difference, meanLocal, varianceField ] = varianceField( frame, nextframe, 'horizontal' );
% [pd, pm] = temporalPatches( difference, meanLocal );
% [ diff, meanPat ] = temporalPatchThreshold( pd, pm);
% [ MSCN ] = temporalMSCN( diff, meanPat, varianceField );
% [ ggdParameters ] = ggdFitting( MSCN );
end

