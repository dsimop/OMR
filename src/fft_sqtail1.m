% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the semiquaver tail1
sqtail1=imread('Musical_Objects/sqtail1.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(sqtail1,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh=4.233599999999998e+02;

D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[tail1_x,tail1_y]=find(E);
detected_sqtail1=[tail1_x tail1_y];

tail1_x_upperleft=detected_sqtail1(:,1)-size(sqtail1,1)/2-16;
tail1_y_upperleft=detected_sqtail1(:,2)-size(sqtail1,2)/2-22;
detected_sqtail1_upperleft=[tail1_x_upperleft tail1_y_upperleft];
detected_sqtail1_upperleft=floor(detected_sqtail1_upperleft);

se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
    figure('name','Finding the tail1');
    imshow(E,'InitialMagnification','fit');
end
clear tail1_x tail1_y tail1_x_upperleft tail1_y_upperleft C D E maxC se thresh;

%% Deleting the tail1 pixels from the cropped stave
for i=1:size(detected_sqtail1,1)
    for j=detected_sqtail1(i,1)-size(sqtail1,1):detected_sqtail1(i,1)
        for k=detected_sqtail1(i,2)-size(sqtail1,2):detected_sqtail1(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k sqtail1;
