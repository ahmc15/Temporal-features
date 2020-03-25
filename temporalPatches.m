function [ differencePatches, meanPatches, variancePatches ] = temporalPatches( difference, meanLocal, varianceField )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



[rows, cols] = size(varianceField);
difference = [zeros(1,size(difference,2));difference];
meanLocal = [zeros(1,size(meanLocal,2));meanLocal];
varianceField = [zeros(1,size(varianceField,2));varianceField];

[rows, cols] = size(varianceField);
borderRows = rem(rows,96)/2;
borderCols = rem(cols,96)/2;

borderlessDifference =  difference(borderRows+1:rows-borderRows, borderCols+1:cols-borderCols);
borderlessMeanLocal =    meanLocal(borderRows+1:end-borderRows, borderCols+1:end-borderCols);
borderlessVariance = varianceField(borderRows+1:end-borderRows, borderCols+1:end-borderCols);

[brows, bcols] = size(borderlessVariance);
listNum =(size(borderlessVariance,1)*size(borderlessVariance,2)/(96*96));
differenceList = zeros(96,96);
meanLocalList = zeros(96,96);
varianceList = zeros(96,96);
patch = zeros(96,96);

for j=1:96:bcols
    for i =1:96:brows
        patch = borderlessDifference(i:i+95,j:j+95);
        differenceList = cat(3,differenceList,patch);
        patch = borderlessMeanLocal(i:i+95,j:j+95);
        meanLocalList = cat(3,meanLocalList,patch); 
        patch = borderlessVariance(i:i+95,j:j+95);
        varianceList = cat(3,varianceList ,patch); 
    end
end    


differencePatches = differenceList(:,:,2:end);
meanPatches = meanLocalList(:,:,2:end);
variancePatches = varianceList(:,:,2:end);
end

