function [ differencePatches, meanPatches ] = temporalPatches( difference, meanLocal )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(difference);
difference = [zeros(1,size(difference,2));difference];
meanLocal = [zeros(1,size(meanLocal,2));meanLocal];

[rows, cols] = size(difference);
borderRows = rem(rows,96)/2;
borderCols = rem(cols,96)/2;

borderlessDifference =  difference(borderRows+1:rows-borderRows, borderCols+1:cols-borderCols);
borderlessMeanLocal =    meanLocal(borderRows+1:end-borderRows, borderCols+1:end-borderCols);

[brows, bcols] = size(borderlessDifference);
listNum =(size(borderlessDifference,1)*size(borderlessDifference,2)/(96*96));
differenceList = zeros(96,96);
meanLocalList = zeros(96,96);
patch = zeros(96,96);

for j=1:96:bcols
    for i =1:96:brows
        patch = borderlessDifference(i:i+95,j:j+95);
        differenceList = cat(3,differenceList,patch);
        patch = borderlessMeanLocal(i:i+95,j:j+95);
        meanLocalList = cat(3,meanLocalList,patch); 
    end
end    

differencePatches = differenceList(:,:,2:end);
meanPatches = meanLocalList(:,:,2:end);
end

