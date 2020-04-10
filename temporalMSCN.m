function [ MSCN ] = temporalMSCN( differencePatchesOutput, meanPatchesOutput, sigmafinal )
%Computes the MSCN coefficient
%   Detailed explanation goes here
%   INPUT
%         differencePatchesOutput: 3D matrix of the sequence of patches of the frame diferences
%         meanPatchesOutput: 3D matrix of the sequence of the local gaussian average
%         sigmafinal: standard deviation of the 
%   OUTPUT
%         differencePatchesOutput: 
%         meanPatchesOutput: 
%   Code:
%       here describe the code

%%
sigmaMatrix = repmat(sigmafinal,96,96);
MSCN = zeros(96,96,size(differencePatchesOutput,3));

for i=1:size(differencePatchesOutput,3)
    MSCN(:,:,i) = (differencePatchesOutput(:,:,i)-meanPatchesOutput(:,:,i))./(sigmafinal+1);
end
end

