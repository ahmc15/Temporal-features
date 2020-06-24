fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\Databases\Varium\VariumDegradados\*.avi','ReadFcn',@importdata);
fullFileNames = fds.Files;
energyTI=cell(size(Varium_SI_TI,1),1);

energyTI=[fullFileNames;energyTI];
for i=1:size(Varium_SI_TI,1)
    try
        sinal = highpassfilter(Varium_SI_TI{i,3});
        energyTI{i,2} = sum((abs(sinal)).^2);
    catch
        energyTI{i,2}='error';
    end
end
save('EnergyTI','energyTI');