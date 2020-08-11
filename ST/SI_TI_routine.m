clear all;
clc;

% dirIN='C:\Users\Adm\Desktop\Temporal-Features\Varium\VariumOriginais\';
dirIN='C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumDegradados\Freezing\';

D = dir (strcat(dirIN,'*.avi'));
[nFiles, temp] = size(D);

%########### LOW ################
vname_list=[];
vname_list=cell(nFiles,3);
SI_TI=[];

for idx = 1:nFiles
    %input1
    fprintf('Now reading file %s\n', D(idx).name);
    input = strcat(dirIN,D(idx).name);
    [SI, TI] = ST_perc_info_measurement(input,'max');

    output1=strrep(input,dirIN,'');
    vname=strrep(output1,'.avi','');
%     vname_list=[vname_list;vname];
    vname_list{idx,1} = vname;
    vname_list{idx,2} = SI;
    vname_list{idx,3} = TI;
%     SI_TI=[SI_TI;[SI, TI]];
end

% Results=table(vname_list,SI_TI);
Results=table(vname_list);
writetable(Results,'Varium_SI_TI.xls');