function [ Distance ] = MahalanobisDistance( MSGmodel, PristineModel)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%%
meanMSG = mean(MSGmodel,1);
meanPristine = mean(PristineModel,1);

covMSG = (MSGmodel);
covPristine = cov(PristineModel);

Distance = sqrt((meanMSG-meanPristine)()^1(meanMSG-meanPristine));
(meanMSG-meanPristine)

end

