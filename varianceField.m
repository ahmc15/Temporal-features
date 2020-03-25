function [ framedifferencefinal, Mediafinal, sigmafinal ] = varianceField( frame, nextframe, direction )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if (nargin <3)
    error('Function requires 3 arguments');
end
[nrows,ncol] = size(frame);
framedif = zeros(nrows,ncol);

switch direction
    case 'horizontal'
        for j=2:ncol-1
            for i=2:nrows
                framedif(i,j) = frame(i,j)-nextframe(i,j-1);                
            end
        end
    case 'vertical'
         for j=2:ncol-1
            for i=2:nrows
                framedif(i,j) = frame(i,j)-nextframe(i-1,j);
            end
         end
    case 'diagonal1'
        for j=2:ncol-1
            for i=2:nrows
                framedif(i,j) = frame(i,j)-nextframe(i-1,j-1);
            end
        end
    case 'diagonal2'
        for j=2:ncol-1
            for i=2:nrows
                framedif(i,j) = frame(i,j)-nextframe(i-1,j+1);
            end
        end
end
framedif = framedif(2:end,2:end-1);
[nrows,ncol] = size(framedif);

gamma_filter_mask = fspecial('gaussian',7,7/6);
gamma_filter_mask = gamma_filter_mask./sum(sum(gamma_filter_mask));
Media = imfilter(framedif, gamma_filter_mask,'replicate');
sigma = sum(sum(((framedif-Media).^2),1),2);
sigma = repmat(sigma, [nrows,ncol]);

framedifferencefinal=framedif;
Mediafinal = Media;
sigmafinal = sigma;

end

