function [ inMatrix ] = deletenanline( inMatrix )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for linha = size(inMatrix,1):-1:1
    if any(ismissing(inMatrix(linha,:)))
        inMatrix(linha,:) = [];        
    end
end

end

