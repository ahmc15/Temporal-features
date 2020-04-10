function [ differencePatchesOutput, meanPatchesOutput ] = temporalPatchThreshold( differencePatches, meanPatches )
%Gets the sharpest patches 
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
    variancePatch(1,i) = sum(sum(sqrt((differencePatches(:,:,i)-meanPatches(:,:,i)).^2),1),2);
end
threshold = ceil(size(variancePatch,2)*0.25);%gets the top 25 sharpest patches
[~, ordem] = sort(variancePatch,'descend');
differencePatchesOutput = differencePatches(:,:,ordem);
meanPatchesOutput = meanPatches(:,:,ordem);
differencePatchesOutput = differencePatches(:,:,1:threshold);
meanPatchesOutput = meanPatches(:,:,1:threshold);
end

