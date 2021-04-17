function [ ALLfeatures ] = TemporalBrisqueVideo( videoname )
%Compute the BRISQUE metric for a video file
%   Detailed explanation goes here
%   INPUT
%         videoname: string of the video file with extension
%   OUTPUT
%         ALLFeatures: matrix of size (n,36). Each column is one of the
%           parameters of the BRISQUE algorithm
%   Code:
%       here describe the code
%%
v = VideoReader(videoname);
NFrames = countframes(v);
v = VideoReader(videoname);
ALLfeatures = [];
for framecount =1:NFrames-1
    frame = double(rgb2gray(read(v,framecount)));
    nextframe = double(rgb2gray(read(v,framecount+1)));
    features = temporal_brisque(frame, nextframe);
    ALLfeatures = [ALLfeatures, features];
end
end

