function [ ggdParameters ] = ggdFitting( MSCN )
% Fits the MSCN coefficients to a generalized gaussian distribution
%   
%   INPUT
%       MSCN: sequence of matrices of size (96,96,n), where n is the
%           number of patches. The elements of the matrices are the MSCN
%           coefficients of the current frame.
%   OUTPUT
%       ggdParameters: matrix of size (n,2), where n is the
%           number of patches. The 2 columns are respectively the alpha and
%           beta shape parameters of the gaussian distribution.
%   Source of the GGD fitting algorithm:
%       'https://ieeexplore.ieee.org/document/350779'
%   Code:
%       mu_MSCN is the average over all lines and all collumns of the MSCN
%       matrix.
%%  

gam = 0.2:0.001:10;
r_gam = gamma(1./gam).*gamma(3./gam)./(gamma(2./gam)).^2;
ggdParameters=[];

for i=1:size(MSCN,3)

    mu_MSCN = mean(mean(MSCN(:,:,i))); %average of the MSCN coefficients of each patch
    sigma_sq_MSCN = mean(mean((MSCN(:,:,i)-mu_MSCN).^2)); %variance of each MSCN patch 
    E_MSCN = mean(mean(abs(MSCN(:,:,i)-mu_MSCN))); %determine the estimate for the modified mean of the absolute values
    rho_MSCN = sigma_sq_MSCN/E_MSCN^2; %calculate the ratio Rho
    [~, array_position] = min(abs(rho_MSCN - r_gam));
    gam_MSCN = gam(array_position);
    ggdParameters = [ggdParameters; sigma_sq_MSCN, gam_MSCN];
    
end
end

