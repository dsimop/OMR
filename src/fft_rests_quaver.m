% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the quaver rests
rest_quaver=imread('Musical_Objects/rest_quaver.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(rest_quaver,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh = 2.508800000000000e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[rest_quaver_x,rest_quaver_y]=find(E);
detected_rests_quaver=[rest_quaver_x rest_quaver_y];

rest_quaver_x_centred=detected_rests_quaver(:,1)-size(rest_quaver,1)/2-10;
rest_quaver_y_centred=detected_rests_quaver(:,2)-size(rest_quaver,2)/2;
detected_rests_quaver_centred=[rest_quaver_x_centred rest_quaver_y_centred];
detected_rests_quaver_centred=floor(detected_rests_quaver_centred);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the quaver rests');
imshow(E,'InitialMagnification','fit') % Display pixels with values over the threshold
end
clear rest_quaver_x rest_quaver_x_centred rest_quaver_y rest_quaver_y_centred C D E maxC se thresh;

% Identifying the type of the rest
textCol=cell(size(detected_rests_quaver_centred,1),3);
for i=1:size(textCol)
    textCol(i)={'Quaver'};
    textCol(i,2)={'Rest'};
    textCol(i,3)={'0.125'};
end
recogniseQuaverRests = [num2cell(detected_rests_quaver_centred),textCol];

%% Deleting the quaver rests' pixels from the cropped stave
for i=1:size(detected_rests_quaver,1)
    for j=detected_rests_quaver(i,1)-size(rest_quaver,1):detected_rests_quaver(i,1)
        for k=detected_rests_quaver(i,2)-size(rest_quaver,2):detected_rests_quaver(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k rest_quaver;
