% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the semiquaver rests
rest_semiquaver=imread('Musical_Objects/rest_semiquaver.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(rest_semiquaver,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh = 4.625600000000000e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[rest_semiquaver_x,rest_semiquaver_y]=find(E);
detected_rests_semiquaver=[rest_semiquaver_x rest_semiquaver_y];

rest_semiquaver_x_centred=detected_rests_semiquaver(:,1)-size(rest_semiquaver,1)/2-10;
rest_semiquaver_y_centred=detected_rests_semiquaver(:,2)-size(rest_semiquaver,2)/2;
detected_rests_semiquaver_centred=[rest_semiquaver_x_centred rest_semiquaver_y_centred];
detected_rests_semiquaver_centred=floor(detected_rests_semiquaver_centred);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the semiquaver rests');
imshow(E,'InitialMagnification','fit'); 
end
clear rest_semiquaver_x rest_semiquaver_x_centred rest_semiquaver_y rest_semiquaver_y_centred C D E maxC se thresh;

% Identifying the type of the rest
textCol=cell(size(detected_rests_semiquaver_centred,1),3);
for i=1:size(textCol)
    textCol(i)={'Semiquaver'};
    textCol(i,2)={'Rest'};
    textCol(i,3)={'0.0625'};
end
recogniseSemiquaverRests = [num2cell(detected_rests_semiquaver_centred),textCol];

%% Deleting the semiquaver rests' pixels from the cropped stave
for i=1:size(detected_rests_semiquaver,1)
    for j=detected_rests_semiquaver(i,1)-size(rest_semiquaver,1):detected_rests_semiquaver(i,1)
        for k=detected_rests_semiquaver(i,2)-size(rest_semiquaver,2):detected_rests_semiquaver(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k rest_semiquaver;
