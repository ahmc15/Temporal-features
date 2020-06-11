
% model = pristinemodel;
% % estatisticas=cell(size(model,2),4);
% for j = 2:size(model,2)
%     for i = 1:size(model,1)
%         feature=pristinemodel{i,j};
% %         TI = Varium_SI_TI{i,j};
% %         TI = Varium_SI_TI{38,3};
% %         estatisticas{i,1} = pristinemodel{i,1};
% %         estatisticas{i,2} = var(pristinemodel{i,j});
% %         estatisticas{i,3} = std(pristinemodel{i,j});
% %         estatisticas{i,4} = prctile(pristinemodel{i,j},90);
% %         plotagem = plot((1:size(pristinemodel,2)),pristinemodel(1,:));
% %         title(Varium_SI_TI{38,1});
% %         saveas(plotagem, strcat('C:\Users\Adm\Desktop\Temporal-Features\ST\plotagens\',Varium_SI_TI{i,1},'.png'))
%         plot(feature(:,1))
%         pause(1);
%     end
% end


model = pristinemodel;
for j = 2%2:size(model,2)%indice coluna
    for i = 37:42%1:size(model,1)%indice linha
        feature = pristinemodel{i,j};
        nome = pristinemodel{i,1};
%         saveas(plotagem, strcat('C:\Users\Adm\Desktop\Temporal-Features\ST\plotagens\',Varium_SI_TI{i,1},'.png'))
        plotagem = plot(feature(:,2));
        title(char(strcat('horizontal',nome(64:end))));
%         saveas(plotagem, char(strcat(nome,'horizontalBeta','.png')))
%         title('horizontal');
        pause(3);
    end
end