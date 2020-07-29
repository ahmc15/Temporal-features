close all
pathvideo = 'Databases\Varium\VariumDegradados\Freezing\v12_1280_HRC7.avi';
% pathvideo = 'Databases\Varium\VariumDegradados\v12_1280x720_I12.avi';
% fds = fileDatastore('Databases\Varium\VariumDegradados\*.avi', 'ReadFcn', @importdata);
% fileNamesavi = fds.Files;
% fullFileNames = [fileNamesavi];
% for file=1:size(fileNamesavi)
% video = VideoReader(fullFileNames{file,1});
% NumFrames = countframes(video);
% video = VideoReader(fullFileNames{file,1});
video = VideoReader(pathvideo);
NumFrames = countframes(video);
video = VideoReader(pathvideo);
tempo = 120;
% for tempo =1:120 
    frame = rgb2gray(read(video,tempo));
    nextframe= rgb2gray(read(video,tempo+1));
    [nrows,ncol] = size(frame);
    framedif = zeros(nrows,ncol);
    for j=2:ncol-1
        for i=2:nrows
            framedif(i,j) = frame(i,j)-nextframe(i-1,j-1);
        end
    end
    framedif          = framedif(2:end,2:end-1);
    gamma_filter_mask = fspecial('gaussian',7,7/6);% creates 7x7 unitary gaussian filter
    Media             = imfilter(framedif, gamma_filter_mask,'replicate');%averages the frame difference using the gaussian filter
    sigmaZ             = sqrt(abs(filter2(gamma_filter_mask, framedif.*framedif, 'same') - Media.*Media));
% sigmaZ = sqrt(sum(sum(((framedif-Media).^2),1),2));%the variance of the entire frame
    mscn              = (framedif-Media)./(sigmaZ+1);
    figure
    histogramZeina =  histogram(mscn,250);%,'Normalization','probability')
    title('Zeina MSCN')
%     title(char(strcat('Zeina',fullFileNames{file,1}(74:end))))
%     saveas(histogramZeina,sprintf('histogramZeina_%s.jpg', fullFileNames{file,1}(74:1:end)))
%     pause(1)
    %%
    %Brisque
    imdist = double(frame);
    mu            = imfilter( imdist,gamma_filter_mask, 'replicate');
    mu_sq         = mu.*mu;
    sigma         = sqrt(abs(imfilter( imdist.*imdist,gamma_filter_mask, 'replicate') - mu_sq));
    structdis     = (imdist-mu)./(sigma+1);
    
    imdist2 = double(nextframe);
    mu2            = imfilter( imdist2,gamma_filter_mask, 'replicate');
    mu_sq2         = mu2.*mu2;
    sigma2         = sqrt(abs(imfilter( imdist2.*imdist2,gamma_filter_mask, 'replicate') - mu_sq2));
    structdis2     = (imdist2-mu2)./(sigma2+1);
    brisque=structdis-structdis2;
    
    figure
    histogrambrisque = histogram(structdis,250);%,'Normalization','probability')
    title('Brisque primeiro frame')
    figure
    histogrambrisque = histogram(structdis2,250);
    title('Brisque segundo frame')
    figure
    histogrambrisque = histogram(brisque,250);
    title('BRISQUE DIFERENÇA DE COEFICIENTES')
%     title(char(strcat('Brisque_',fullFileNames{file,1}(74:end))))
%     saveas(histogrambrisque,sprintf('histogramBrisque_%s.jpg', fullFileNames{file,1}(74:1:end)))
    %     pause(1)

%     title(tempo)
% end