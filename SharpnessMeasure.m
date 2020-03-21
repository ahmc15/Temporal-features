function [ Sharpness_score ] = Sharpness(img)
%Calculates sharpness through the variance field of the image
%  Detailed explanation goes here 
%  
%
%
if (nargin <1)
error('First argument (patch) is required');    
end
[row, col] = size(img);
img=double(img);

mean=[];
variance=[];
patch_sq=img.*img;

gamma_filter = fspecial('gaussian',7,7/6);
gamma_filter = gamma_filter/sum(sum(gamma_filter));

mean = imfilter(img, gamma_filter, 'replicate');
mean_sq = mean.*mean;
sigma = sqrt(abs(imfilter(patch_sq,gamma_filter, 'replicate')-mean_sq));

Sharpness_score = sigma;

end

