clear all

%Implementation of the algorithm proposed by Zeina Sinno and Alan Bovik in
%the paper titled "SPATIO-TEMPORAL MEASURES OF NATURALNESS". Implementation
%done by André da Costa, Master's students at the Univesidade de Brasília
%in 2020.
%input: Video Output

%function T = temporal_features(im)
disp('BOOM!')

video = VideoReader('Megamind.avi');
NumFrames = floor(video.FrameRate*video.Duration);
tic
Parametros_Horizontais = [];
Parametros_Vertical = [];
Parametros_Dd1 = [];
Parametros_Dd2 = [];
gam = 0.2:0.001:10;
r_gam = gamma(1./gam).*gamma(3./gam)./(gamma(2./gam)).^2;

for tempo = 2:10 %NumFrames-1
    frameT = rgb2gray(read(video,tempo)); %frame atual
    frameT1= rgb2gray(read(video,tempo+1)); %frame t+1 futuro
    [nrows,ncol] = size(frameT); %dimensões dos frames

    %Criação das matrizes de diferenças direcionais
    Dhorizontal=zeros([nrows,ncol]);
    Dvertical =zeros([nrows,ncol]);
    Dd1=zeros([nrows,ncol]);
    Dd2=zeros([nrows,ncol]);

    %% extract horizontal, vetical and diagonal features
    %aqui se perde 1 linha(primeira) e 1 coluna(Primeira e última)
    for j=2:ncol-1
        for i=2:nrows
            Dhorizontal(i,j) = frameT(i,j)-frameT1(i,j-1);
            Dvertical(i,j) = frameT(i,j)-frameT1(i-1,j);
            Dd1(i,j) = frameT(i,j)-frameT1(i-1,j-1);
            Dd2(i,j) = frameT(i,j)-frameT1(i-1,j+1);
        end
    end
    %% average of the features with a gamma filter
    %cálculo das médias locais de cada direção
    gamma_filter_mask = fspecial('gaussian',7,7/6);
    gamma_filter_mask = gamma_filter_mask/sum(sum(gamma_filter_mask));
    Dmed_horizontal=imfilter(Dhorizontal,gamma_filter_mask);                 
    Dmed_vertical  =imfilter(Dvertical  ,gamma_filter_mask);
    Dmed_Dd1       =imfilter(Dd1        ,gamma_filter_mask);
    Dmed_Dd2       =imfilter(Dd2        ,gamma_filter_mask);

    %% four local variance fields
    % cálculo das variância da diferenças entre os frames
    sigmaHorizontal=0;
    sigmaVertical=0;
    sigmaDd1=0;
    sigmaDd2=0;
    for j=1:ncol
        for i = 1:nrows
            sigmaHorizontal = sigmaHorizontal+(Dhorizontal(i,j)-Dmed_horizontal(i,j))^2;
            sigmaVertical= sigmaVertical+(Dvertical(i,j)-Dmed_vertical(i,j))^2;
            sigmaDd1= sigmaDd1+(Dd1(i,j)-Dmed_Dd1(i,j))^2;
            sigmaDd2= sigmaDd2+(Dd2(i,j)-Dmed_Dd2(i,j))^2;
        end
    end
    sigmaHorizontal = sqrt(sigmaHorizontal);
    sigmaVertical = sqrt(sigmaVertical);
    sigmaDd1 = sqrt(sigmaDd1);
    sigmaDd2 = sqrt(sigmaDd2);

    %Matrix dos sigmas/variance fields
    VarianceHorizontal = repmat(sigmaHorizontal,[nrows,ncol]);
    VarianceVertical = repmat(sigmaVertical,[nrows,ncol]);
    VarianceDd1 = repmat(sigmaDd1,[nrows,ncol]);
    VarianceDd2 = repmat(sigmaDd2,[nrows,ncol]);
    
    %% mean subtracted contrast normalized coefficients(MSCN)
    %corte dos patchs
    borda=frameT;
    bordaNrows = rem(nrows,96)/2;
    bordaNcol = rem(ncol,96)/2;
    Parame_horz = [];
    Parame_vert = [];
    Parame_Dd1 = [];
    Parame_Dd2 = [];
    for j=bordaNcol:96:ncol-(96+bordaNcol)
      for i=bordaNrows:96:nrows-(96+bordaNrows)
      
          DchapeuHorizontal = Dhorizontal(i:i+95,j:j+95)-Dmed_horizontal(i:i+95,j:j+95)/(sigmaHorizontal+1);
          DchapeuVertical = Dvertical(i:i+95,j:j+95)-Dmed_vertical(i:i+95,j:j+95)/(sigmaVertical+1);
          DchapeuDd1 = Dd1(i:i+95,j:j+95)-Dmed_Dd1(i:i+95,j:j+95)/(sigmaDd1+1);
          DchapeuDd2 = Dd2(i:i+95,j:j+95)-Dmed_Dd2(i:i+95,j:j+95)/(sigmaDd2+1);
          
          mu_horz = mean(mean(DchapeuHorizontal));
          mu_vert = mean(mean(DchapeuVertical));
          mu_Dd1 = mean(mean(DchapeuDd1));
          mu_Dd2 = mean(mean(DchapeuDd2));
          
          sigma_sq_horz = mean(mean((DchapeuHorizontal-mu_horz).^2));
          sigma_sq_vert = mean(mean((DchapeuVertical-mu_vert).^2));
          sigma_sq_Dd1 = mean(mean((DchapeuDd1-mu_Dd1).^2));
          sigma_sq_Dd2 = mean(mean((DchapeuDd2-mu_Dd2).^2));
          
          E_horz = mean(mean(abs(DchapeuHorizontal-mu_horz)));
          E_vert = mean(mean(abs(DchapeuVertical-mu_vert)));
          E_Dd1 = mean(mean(abs(DchapeuDd1-mu_Dd1)));
          E_Dd2 = mean(mean(abs(DchapeuDd2-mu_Dd2)));
          
          rho_horz = sigma_sq_horz/E_horz^2;
          rho_vert = sigma_sq_vert/E_vert^2;
          rho_Dd1 = sigma_sq_Dd1/E_Dd1^2;
          rho_Dd2 = sigma_sq_Dd2/E_Dd2^2;
                    
          [min_difference_horz, array_position_horz] = min(abs(rho_horz - r_gam));
          [min_difference_vert, array_position_vert] = min(abs(rho_vert - r_gam));
          [min_difference_Dd1, array_position_Dd1] = min(abs(rho_Dd1 - r_gam));
          [min_difference_Dd2, array_position_Dd2] = min(abs(rho_Dd2 - r_gam));
                    
          gam_horz = gam(array_position_horz);
          gam_vert = gam(array_position_vert);
          gam_Dd1 = gam(array_position_Dd1);
          gam_Dd2 = gam(array_position_Dd2);
          
          Parame_horz = [Parame_horz ;[sigma_sq_horz gam_horz]];
          Parame_vert = [Parame_vert ;[sigma_sq_vert gam_vert]];
          Parame_Dd1 = [Parame_Dd1 ;[sigma_sq_Dd1 gam_Dd1]];
          Parame_Dd2 = [Parame_Dd2 ;[sigma_sq_Dd2 gam_Dd2]];
      end 
    end
    Parametros_Horizontais = [Parametros_Horizontais Parame_horz];
    Parametros_Vertical = [Parametros_Vertical Parame_vert];
    Parametros_Dd1 = [Parametros_Dd1 Parame_Dd1];
    Parametros_Dd2 = [Parametros_Dd2 Parame_Dd2];
    Features = [Parametros_Horizontais Parametros_Vertical Parametros_Dd1 Parametros_Dd2];

end
toc
disp('FIM!')








