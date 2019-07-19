% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the semiquaver tail2
sqtail2=imread('Musical_Objects/sqtail2.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(sqtail2,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh=3.894999999999999e+02;

D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[tail2_x,tail2_y]=find(E);
detected_sqtail2=[tail2_x tail2_y];

tail2_x_centred=detected_sqtail2(:,1)-size(sqtail2,1)/2-12;
tail2_y_centred=detected_sqtail2(:,2)-size(sqtail2,2)/2+1;
detected_sqtail2_centred=[tail2_x_centred tail2_y_centred];
detected_sqtail2_centred=floor(detected_sqtail2_centred);

se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
    figure('name','Finding the tail2');
    imshow(E,'InitialMagnification','fit');
end
clear tail2_x tail2_y tail2_x_centred tail2_y_centred C D E maxC se thresh;

%% Deleting the tail2 pixels from the cropped stave
for i=1:size(detected_sqtail2,1)
    for j=detected_sqtail2(i,1)-size(sqtail2,1):detected_sqtail2(i,1)
        for k=detected_sqtail2(i,2)-size(sqtail2,2):detected_sqtail2(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k sqtail2;
