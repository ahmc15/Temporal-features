function [ ALLfeatures ] = BrisqueVideo( videoname )
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
    NumFrames = countframes(v);
    v = VideoReader(videoname);
    ALLfeatures = [];
    for framecount =1:NumFrames
        frame = double(rgb2gray(read(v,framecount)));
        features = brisque_feature(frame);
        ALLfeatures = [ALLfeatures; features];
    end
end

