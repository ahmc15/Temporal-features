
model = VariumFreezing_SI_TI;
estatisticas=cell(size(model,2),4);
for j = 2:size(model,2)
    for i = 1:size(model,1)
        feature=VariumFreezing_SI_TI{i,j};
        TI = VariumFreezing_SI_TI{i,j};
        
        estatisticas{i,1} = VariumFreezing_SI_TI{i,1};
        estatisticas{i,2} = var(VariumFreezing_SI_TI{i,j});
        estatisticas{i,3} = std(VariumFreezing_SI_TI{i,j});
        estatisticas{i,4} = prctile(VariumFreezing_SI_TI{i,j},75);
%         plotagem = plot((1:size(VariumFreezing_SI_TI,2)),VariumFreezing_SI_TI(1,:));

%         saveas(plotagem, strcat('C:\Users\Adm\Desktop\Temporal-Features\ST\plotagens\',Varium_SI_TI{i,1},'.png'))
%         plot(feature(:,1))
        pause(2);
    end
end 

% 
% model = pristinemodel;
% for j = 2%2:size(model,2)%indice coluna
%     for i = 37:42%1:size(model,1)%indice linha
%         feature = pristinemodel{i,j};
%         nome = pristinemodel{i,1};
% %         saveas(plotagem, strcat('C:\Users\Adm\Desktop\Temporal-Features\ST\plotagens\',Varium_SI_TI{i,1},'.png'))
%         plotagem = plot(feature(:,2));
%         title(char(strcat('horizontal',nome(64:end))));
% %         saveas(plotagem, char(strcat(nome,'horizontalBeta','.png')))
% %         title('horizontal');
%         pause(3);
%     end
% end