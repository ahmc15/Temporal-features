function [ NumFrames ] = countframes( video )
%Counts the number of frames in a video file
%   Detailed explanation goes here
%   INPUT
%         video: Object of the videoReader function
%   OUTPUT
%         NumFrames: Integer of the total of frames in a video file
%   Code:
%       here describe the code
NumFrames = 0;
while hasFrame(video)
    readFrame(video);
    NumFrames = NumFrames+1;
end

end

