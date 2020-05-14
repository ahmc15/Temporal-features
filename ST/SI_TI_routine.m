clear all;
clc;

dirIN='H:\VideosInput\VideosInput\';



D = dir (strcat(dirIN,'*.avi'));
[nFiles, temp] = size(D);

%########### LOW ################
vname_list=[];
SI_TI=[];

for idx = 1:nFiles
    %input1
    input = strcat(dirIN,D(idx).name);
    [SI, TI] = ST_perc_info_measurement(input,'max');

    output1=strrep(input,dirIN,'');
    vname=strrep(output1,'.avi','');
    vname_list=[vname_list;vname];
    SI_TI=[SI_TI;[SI, TI]];
end

Results=table(vname_list,SI_TI);
writetable(Results,'SI_TI.xls');