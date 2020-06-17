function [ differencePatchesOutput, meanPatchesOutput ] = temporalPatchThreshold( differencePatches, meanPatches )
% Gets the sharpest patches 
%   Detailed explanation goes here
%   INPUT
%         differencePatches: 3D matrix of the sequence of patches of the frame diferences
%         meanPatches: 3D matrix of the sequence of the local gaussian average
%   OUTPUT
%         differencePatchesOutput: Sequence of the sharpest difference patches 
%         meanPatchesOutput: Sequence of the sharpest mean patches 
%   Code:
%       here describe the code

%%

variancePatch=zeros(1,size(differencePatches,3));

for i=1:size(differencePatches,3)
    variancePatch(1,i) = sum(sum(((differencePatches(:,:,i)-meanPatches(:,:,i)).^2),1),2);
end
threshold = ceil(size(variancePatch,2)*0.25);% gets the value of the threshold for the top 25 sharpest patches
[~, ordem] = sort(variancePatch,'descend');% index of the order of the patches 
differencePatchesOutput = differencePatches(:,:,ordem); %order the patches
meanPatchesOutput = meanPatches(:,:,ordem); %order the patches 
differencePatchesOutput = differencePatches(:,:,1:threshold); %selects the patches that pass the threshold
meanPatchesOutput = meanPatches(:,:,1:threshold); %selects the patches that pass the threshold
end

