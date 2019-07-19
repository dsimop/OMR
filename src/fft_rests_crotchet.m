% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the crotchet rests
rest_crotchet=imread('Musical_Objects/rest_crotchet.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(rest_crotchet,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh = 4.537400000000000e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[rest_crotchet_x,rest_crotchet_y]=find(E);
detected_rests_crotchet=[rest_crotchet_x rest_crotchet_y];

rest_crotchet_x_centred=detected_rests_crotchet(:,1)-size(rest_crotchet,1)/2-6;
rest_crotchet_y_centred=detected_rests_crotchet(:,2)-size(rest_crotchet,2)/2;
detected_rests_crotchet_centred=[rest_crotchet_x_centred rest_crotchet_y_centred];
detected_rests_crotchet_centred=floor(detected_rests_crotchet_centred);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the crotchet rests');
imshow(E,'InitialMagnification','fit');
end
clear rest_crotchet_x rest_crotchet_x_centred rest_crotchet_y rest_crotchet_y_centred C D E maxC se thresh;

% Identifying the type of the rest
textCol=cell(size(detected_rests_crotchet_centred,1),3);
for i=1:size(textCol)
    textCol(i,1)={'Crotchet'};
    textCol(i,2)={'Rest'};
    textCol(i,3)={'0.25'};
end
recogniseCrotchetRests = [num2cell(detected_rests_crotchet_centred),textCol];

%% Deleting the crotchet rests' pixels from the cropped stave
for i=1:size(detected_rests_crotchet,1)
    for j=detected_rests_crotchet(i,1)-size(rest_crotchet,1):detected_rests_crotchet(i,1)
        for k=detected_rests_crotchet(i,2)-size(rest_crotchet,2):detected_rests_crotchet(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k rest_crotchet;
