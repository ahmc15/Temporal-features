function [ ggdParameters ] = ggdFitting( MSCN )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

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

