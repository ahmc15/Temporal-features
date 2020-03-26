function [ MSCN ] = temporalMSCN( differencePatchesOutput, meanPatchesOutput, sigmafinal )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

sigmaMatrix = repmat(sigmafinal,96,96);
MSCN = zeros(96,96,size(differencePatchesOutput,3));

for i=1:size(differencePatchesOutput,3)
    MSCN(:,:,i) = (differencePatchesOutput(:,:,i)-meanPatchesOutput(:,:,i))./(sigmafinal+1);
end
end

