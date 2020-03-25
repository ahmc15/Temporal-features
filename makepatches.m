function [ ArrayPatches ] = makepatches( varianceField )
%Divides de variance field into a series of patches 96x96
%   The function takes a variance field and return patches of size 96x96.
%   Each patch is stored in the third dimension of the output.

[rows, cols] = size(varianceField);
borderRows = rem(rows,96)/2;
borderCols = rem(cols,96)/2;

borderless = varianceField(borderRows+1:end-borderRows, borderCols+1:end-borderCols);
[brows, bcols] = size(borderless);
listNum =(size(borderless,1)*size(borderless,2)/(96*96));
patchlist = zeros(96,96);

for j=1:96:bcols
    for i =1:96:brows
        patch = borderless(i:i+95,j:j+95);
        patchlist = cat(3,patchlist,patch); 
    end
end

ArrayPatches = patchlist(:,:,2:end);
end

