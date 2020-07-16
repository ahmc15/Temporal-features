function [ framedifferencefinal, Mediafinal, sigmafinal ] = varianceField( frame, nextframe, direction )
%Calculates the variance field of 2 frames in a specific direction
%   code created in march 2020 by André da Costa
%   INPUT
%       frame: current frame of the video file
%       nextframe: next frame of the video file
%       direction: direction of the diference. It can be 'horizontal',
%           'vertical', 'diagonal1' or 'diagonal2'.
%         
%   OUTPUT
%         framediffetencefinal: difference of the current frame and the
%           next frame based on the direction
%         Mediafinal: Average of the differences after the pass of the
%           7x7 gaussian filter 
%         sigmafinal: Standard deviation of the sum of all the differences
%           between the frame difference and the average.
%   Code:
%
%%
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

gamma_filter_mask = fspecial('gaussian',7,7/6);% creates 7x7 unitary gaussian filter
Media = imfilter(framedif, gamma_filter_mask,'replicate');%averages the frame difference using the gaussian filter
sigma = sqrt(sum(sum(((framedif-Media).^2),1),2));%the variance of the entire frame
% sigma         = sqrt(abs(filter2(gamma_filter_mask, framedif.*framedif, 'same') - Media.*Media));

framedifferencefinal=framedif;
Mediafinal = Media;
sigmafinal = sigma;

end

