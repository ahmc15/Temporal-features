function [ ggdParameters ] = ggdFitting( MSCN )
%Fits the MSCN coefficients to a generalized gaussian distribution
%   Detailed explanation goes here
%   INPUT
%       MSCN: sequence of matrices of size (96,96,n), where n is the
%           number of patches. The elements of the matrices are the MSCN
%           coefficients of the current frame.
%   OUTPUT
%       ggdParameters: matrix of size (2,n), where n is the
%           number of patches. The 2 columns are respectively the alpha and
%           beta shape parameters of the gaussian distribution.
%       
%   Code:
%       here describe the code
%%  

gam = 0.2:0.001:10;
r_gam = gamma(1./gam).*gamma(3./gam)./(gamma(2./gam)).^2;
tic
ggdParameters=[];
for i=1:size(MSCN,3)

    mu_MSCN = mean(mean(MSCN(:,:,i))); 
    sigma_sq_MSCN = mean(mean((MSCN(:,:,i)-mu_MSCN).^2));
    E_MSCN = mean(mean(abs(MSCN(:,:,i)-mu_MSCN)));
    rho_MSCN = sigma_sq_MSCN/E_MSCN^2;
    [~, array_position] = min(abs(rho_MSCN - r_gam));
    gam_MSCN = gam(array_position);
    ggdParameters = [ggdParameters; sigma_sq_MSCN, gam_MSCN];
    
end
end

