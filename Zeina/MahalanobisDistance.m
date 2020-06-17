function [ Distance ] = MahalanobisDistance( MSGmodel, PristineModel)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%%
meanMSG = mean(MSGmodel,1);
meanPristine = mean(PristineModel,1);

covMSG = cov(MSGmodel);
covPristine = cov(PristineModel);
covarianceterm=inv((covMSG+covPristine)/2);
meanvector = (meanPristine-meanMSG);
Distance = sqrt(meanvector*covarianceterm*(meanvector.'));


end

