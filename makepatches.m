function [ ArrayPatches ] = makepatches( varianceField )
%Divides de variance field into a series of patches 96x96
%   The function takes a variance field and return patches of size 96x96
[rows cols] = size(varianceField);
borderRows = rem(rows,96)/2;
borderCols = rem(cols,96)/2;

borderless = varianceField(borderRows+1:end-borderRows, borderCols+1:end-borderCols);
listNum =(size(borderless,1)*size(borderless,2)/(96*96));
patchlist = zeros(96,96,listNum);
% for j=(1:96:end)
%     for i =(1:96:end)
%         patch = (i:i+96,j:j+96);
%         patchlist(:,:,n) = patch;
%         patchlist = cat(3,patchlist,patch) 
%     end
% end


for n=(1:listNum)
    for j=(1:96:end)
        for i =(1:96:end)
            patch = (i:i+96,j:j+96);
            patchlist(:,:,n) = patch; 
        end
    end
end

ArrayPatches = patchlist;
%dividir dimensões por tamanho do patch
%achar primeiro pixel do primeiro patch
%fazer lista de patches



end

