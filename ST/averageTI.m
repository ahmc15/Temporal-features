[rows,cols]=size(Varium_SI_TI);
TI=zeros(rows,1);
for i =1:rows
    TI_line=Varium_SI_TI{i,3};
    TI(i,1) = mean(TI_line);
end