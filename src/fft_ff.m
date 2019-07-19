% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the ff
ff=imread('Musical_Objects/ff.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(ff,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh=1.018560000000000e+03;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[ff_x,ff_y]=find(E);
detected_ff=[ff_x ff_y];

ff_x_centred=detected_ff(:,1)-size(ff,1)/2+2;
ff_y_centred=detected_ff(:,2)-size(ff,2)/2+4;
detected_ff_centred=[ff_x_centred ff_y_centred];
detected_ff_centred=floor(detected_ff_centred);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the ff');
imshow(E,'InitialMagnification','fit') 
end
clear ff_x ff_x_centred ff_y ff_y_centred C D E maxC se thresh;

%% Deleting the ff's pixels from the cropped stave
for i=1:size(detected_ff,1)
    for j=detected_ff(i,1)-size(ff,1):detected_ff(i,1)
        for k=detected_ff(i,2)-size(ff,2):detected_ff(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear detected_ff ff i j k;
