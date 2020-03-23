function [ framedifference, Media, sigma ] = varianceField( frame, nextframe, direction )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if (nargin <3)
    error('Function requires 3 arguments');
end
[nrows,ncol] = size(frame);
framedifference = zeros(nrows,ncols);

switch direction
    case horizontal
        for j=2:ncol-1
            for i=2:nrows
                framedifference = frame(i,j)-nextframe(i,j-1);
            end
        end
    case vertical
         for j=2:ncol-1
            for i=2:nrows
                framedifference = frame(i,j)-frameT1(i-1,j);
            end
         end
    case diagonal1
        for j=2:ncol-1
            for i=2:nrows
                framedifference = frame(i,j)-nextframe(i-1,j-1);
            end
        end
    case diagonal2
        for j=2:ncol-1
            for i=2:nrows
                framedifference = frame(i,j)-nextframe(i-1,j+1);
            end
        end

framedifference = framedifference(2:end,2:end-1);
[nrows,ncol] = size(framedifference);

gamma_filter_mask = fspecial('gaussian',7,7/6);
gamma_filter_mask = gamma_filter_mask/sum(sum(gamma_filter_mask));
Media = imfilter(framedifference, gamma_filter_mask);
sigma = sum(sum((framedifference-Media).^2),1),2);
sigma = repmat(sigma, [nrows,ncols]);
end

