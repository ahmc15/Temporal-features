clear all
clc

%function T = temporal_features(im)
disp('BOOM!')
video = VideoReader('Megamind.avi');
NumFrames = floor(video.FrameRate*video.Duration);
Parametros_Horizontais = [];
Parametros_Vertical = [];
Parametros_Dd1 = [];
Parametros_Dd2 = [];

for tempo = 1:5
disp(tempo)

frameT = rgb2gray(read(video,tempo)); %frame atual
frameT1= rgb2gray(read(video,tempo+1)); %frame t+1 futuro
[nrows,ncol] = size(frameT);
%frameTT = zeros(x,y);
Dhorizontal=zeros([nrows,ncol]);
Dvertical =zeros([nrows,ncol]);
Dd1=zeros([nrows,ncol]);
Dd2=zeros([nrows,ncol]);
%% extract horizontal, vetical and diagonal features
%aqui se perde 1 linha e 1 coluna
for i=2:nrows
    for j=2:ncol-1
    Dhorizontal(i,j) = frameT(i,j)-frameT1(i,j-1);
    Dvertical(i,j) = frameT(i,j)-frameT1(i-1,j);
    Dd1(i,j) = frameT(i,j)-frameT1(i-1,j-1);
    Dd2(i,j) = frameT(i,j)-frameT1(i-1,j+1);
    end
end
%disp('Directional features have been extracted succesfully!')

%% average of the features a gamma 
gamma_filter_mask = fspecial('gaussian',7,7/6)/;
gamma_filter_mask = gamma_filter_mask/sum(sum(gamma_filter_mask));
Dmed_horizontal=imfilter(Dhorizontal,gamma_filter_mask);                 
Dmed_vertical  =imfilter(Dvertical  ,gamma_filter_mask);
Dmed_Dd1       =imfilter(Dd1        ,gamma_filter_mask);
Dmed_Dd2       =imfilter(Dd2        ,gamma_filter_mask);
%disp('Features have been averaged!') 


%% four local variance fields
sigmaHorizontal=0;
sigmaVertical=0;
sigmaDd1=0;
sigmaDd2=0;

for i = 1:nrows
    for j=1:ncol
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

VarianceHorizontal = repmat(sigmaHorizontal,[nrows,ncol]);
VarianceVertical = repmat(sigmaVertical,[nrows,ncol]);
VarianceDd1 = repmat(sigmaDd1,[nrows,ncol]);
VarianceDd2 = repmat(sigmaDd2,[nrows,ncol]);

%disp('Variance fields: OK!')
%% mean subtracted contrast normalized coefficients(MSCN)

%corte dos patchs
borda=frameT;
bordaNrows = rem(nrows,96)/2;
bordaNcol = rem(ncol,96)/2;



for i=bordaNrows:96:nrows-(96+bordaNrows)
  for j=bordaNcol:96:ncol-(96+bordaNcol)
      DchapeuHorizontal = Dhorizontal(i:i+95,j:j+95)-Dmed_horizontal(i:i+95,j:j+95)/(sigmaHorizontal+1);
      DchapeuVertical = Dvertical(i:i+95,j:j+95)-Dmed_vertical(i:i+95,j:j+95)/(sigmaVertical+1);
      DchapeuDd1 = Dd1(i:i+95,j:j+95)-Dmed_Dd1(i:i+95,j:j+95)/(sigmaDd1+1);
      DchapeuDd2 = Dd2(i:i+95,j:j+95)-Dmed_Dd2(i:i+95,j:j+95)/(sigmaDd2+1);
      
      [muHat,sigmaHat] = normfit(DchapeuHorizontal(:));
      [muHat1,sigmaHat1] = normfit(DchapeuVertical(:));
      [muHat2,sigmaHat2] = normfit(DchapeuDd1(:));
      [muHat3,sigmaHat3] = normfit(DchapeuDd2(:));
      
      
      %[muHat1,sigmaHat1] = normfit(hist(DchapeuHorizontal(:))); 
      %Duvida sobre a necessidade de se ter q fazer o histograma
      
      Parametros_Horizontais= [Parametros_Horizontais;[muHat,sigmaHat]]; %mu and sigma of normal distribution fitting
      Parametros_Vertical= [Parametros_Vertical;[muHat1,sigmaHat1]];
      Parametros_Dd1= [Parametros_Dd1;[muHat2,sigmaHat2]];
      Parametros_Dd2= [Parametros_Dd2;[muHat3,sigmaHat3]];
     
      %fazer fitting da curva
      
      
  end 
end
histogram(Parametros_Horizontais(1,:);



end