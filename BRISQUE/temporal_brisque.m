function [ feat ] = temporal_brisque( frame, nextframe)
%TEMPORAL_BRISQUE Summary of this function goes here
%   Detailed explanation goes here


%------------------------------------------------
% Feature Computation
%-------------------------------------------------


scalenum = 2;
window = fspecial('gaussian',7,7/6);
window = window/sum(sum(window));

feat = [];
% tic
for itr_scale = 1:scalenum
    mu            = filter2(window, frame, 'same');
    mu_sq         = mu.*mu;
    sigma         = sqrt(abs(filter2(window, frame.*frame, 'same') - mu_sq));
    MSCN     = (frame-mu)./(sigma+1);
    
    mu            = filter2(window, nextframe, 'same');
    mu_sq         = mu.*mu;
    sigma         = sqrt(abs(filter2(window, nextframe.*nextframe, 'same') - mu_sq));
    nextMSCN      = (nextframe-mu)./(sigma+1);  
    
    shifts                   = [ 0 1;1 0 ; 1 1; -1 1];

    for itr_shift =1:4
        shifted_structdis        = circshift(nextMSCN,shifts(itr_shift,:));
        pair                     = MSCN(:).*shifted_structdis(:);
        [alpha leftstd rightstd] = estimateaggdparam(pair);
        const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
        meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
        feat                     =[feat; alpha; meanparam; leftstd^2; rightstd^2];
    end
    frame                        = imresize(frame,0.5);
    nextframe                    = imresize(nextframe,0.5);
end

% toc


