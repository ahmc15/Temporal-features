function [ differencePatchesOutput, meanPatchesOutput ] = temporalPatchThreshold( differencePatches, meanPatches )
%Gets the patches with the sharpess patches 
%   Detailed explanation goes here
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

