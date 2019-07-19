% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the cleff
clef=imread('Musical_Objects/clef.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks 
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(clef,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh=2.169800000000000e+03;

D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[clef_x,clef_y]=find(E);
detected_clef=[clef_x clef_y];

clef_x_centred=detected_clef(:,1)-size(clef,1)/2+22;
clef_y_centred=detected_clef(:,2)-size(clef,2)/2+1;
detected_clef_centred=[clef_x_centred clef_y_centred];
detected_clef_centred=floor(detected_clef_centred);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the cleff');
imshow(E,'InitialMagnification','fit');
end
clear clef_x clef_x_centred clef_y clef_y_centred C D E maxC se thresh;

%% Deleting the clef pixels from the cropped stave
for i=1:detected_clef(1)
    for j=1:detected_clef(2)
        cropped_stave(i,j)=0;
    end
end
clear i j clef detected_clef;
