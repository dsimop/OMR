% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the mf
mf=imread('Musical_Objects/mf.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(mf,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh = 9.243499999999997e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[mf_x,mf_y]=find(E);
detected_mf=[mf_x mf_y];

mf_x_centred=detected_mf(:,1)-size(mf,1)/2+2;
mf_y_centred=detected_mf(:,2)-size(mf,2)/2+4;
detected_mf_centred=[mf_x_centred mf_y_centred];
detected_mf_centred=floor(detected_mf_centred);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the mf');
imshow(E,'InitialMagnification','fit') 
end
clear mf_x mf_x_centred mf_y mf_y_centred C D E maxC se thresh;

%% Deleting the mf's pixels from the cropped stave
for i=1:size(detected_mf,1)
    for j=detected_mf(i,1)-size(mf,1):detected_mf(i,1)
        for k=detected_mf(i,2)-size(mf,2):detected_mf(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear detected_mf i j k mf;
