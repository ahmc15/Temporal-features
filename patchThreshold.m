function [ patchesTrue ] = patchThreshold( patchs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

meanSigmaPatchs = mean(mean(patchs,2),1);
threshold = 0.75;
patchesTrue = zeros(96,96);
for i=1:size(meanSigmaPatchs,3)
    if meanSigmaPatchs>=threshold
        patchesTrue = cat(3,patchesTrue,patchs(:,:,i));                
    end    
end
patchesTrue = patchesTrue(97:end,:);
end

