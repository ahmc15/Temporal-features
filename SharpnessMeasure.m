function [ Sharpness_score ] = Sharpness(patch)
%Calculates sharpness through the variance field of the image
%  Detailed explanation goes here
%
%
if (nargin <1)
error('First argument (patch) is required');    
end



gamma_filter = fspecial('gaussian',7,7/6);
gamma_filter = gamma_filter/sum(sum(gamma_filter));




end

