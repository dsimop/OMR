% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the tail1
qtail1=imread('Musical_Objects/qtail1.tiff');
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(qtail1,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh=2.602999999999999e+02;

D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[tail1_x,tail1_y]=find(E);
detected_qtail1=[tail1_x tail1_y];

tail1_x_upperleft=detected_qtail1(:,1)-size(qtail1,1)/2-20;
tail1_y_upperleft=detected_qtail1(:,2)-size(qtail1,2)/2-20;
detected_qtail1_upperleft=[tail1_x_upperleft tail1_y_upperleft];
detected_qtail1_upperleft=floor(detected_qtail1_upperleft);

se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
    figure('name','Finding the tail1');
    imshow(E,'InitialMagnification','fit');
end
clear tail1_x tail1_y tail1_x_upperleft tail1_y_upperleft C D E maxC se thresh;

%% Deleting the tail1 pixels from the cropped stave
for i=1:size(detected_qtail1,1)
    for j=detected_qtail1(i,1)-size(qtail1,1):detected_qtail1(i,1)
        for k=detected_qtail1(i,2)-size(qtail1,2):detected_qtail1(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k qtail1;
