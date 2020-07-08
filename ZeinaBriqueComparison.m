close all
pathvideo = 'Databases\Varium\VariumDegradados\v12_1280x720_I12_pckErr5.avi';
% pathvideo = 'Databases\Varium\VariumDegradados\v12_1280x720_I12.avi';

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
    mscn              = (framedif-Media)./(sigmaZ+1);
    
    % imshow(uint8(framedif))
    % title('Zeina diferenca dos frames')
    % figure
    % imshow(uint8(Media))
    % title('Zeina media local das dif frames')
    % figure
    % imshow(uint8(sigmaZ))
    % title('Zeina variancia das dif frames')
%     figure
    histogram(mscn,250)%,'Normalization','probability')
%     imshow((mscn))
    title('Zeina MSCN')
    pause(1)
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
    sigma2         = sqrt(abs(imfilter( imdist2.*imdist2,gamma_filter_mask, 'replicate') - mu_sq));
    structdis2     = (imdist2-mu2)./(sigma2+1);
    brisque=structdis-structdis2;
    figure
%     imshow((brisque))
    histogram(brisque,250)%,'Normalization','probability')
    title('BRISQUE DIFERENÇA DE COEFICIENTES')
    pause(1)
    % figure
    % imshow(uint8(imdist))
    % title('Brisque frame')
    % figure
    % imshow(uint8(mu))
    % title('Brisque media local das dif frames')
    % figure
%     imshow(uint8(sigma))
%     title('Brisque variancia das dif frames')
    
%     x0=90;
%     y0=90;
%     width=1250;
%     height=900;
%     set(gcf,'position',get(0, 'Screensize'))
%     
%     subplot(1,2,1)
%     imshow((brisque))
% %     title('brisque  dif dos coeficientes')
%     subplot(1,2,2)
%     imshow((mscn))
% %     title('Zeina mscn')
%     title(tempo)
% end