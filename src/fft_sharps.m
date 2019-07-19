% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the sharps
sharp=imread('Musical_Objects/sharp.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(sharp,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh = 6.022999999999997e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[sharps_x,sharps_y]=find(E);
detected_sharps=[sharps_x sharps_y];

sharps_x_centred=detected_sharps(:,1)-size(sharp,1)/2+1;
sharps_y_centred=detected_sharps(:,2)-size(sharp,2)/2+1;
detected_sharps_centred=[sharps_x_centred sharps_y_centred];
detected_sharps_centred=floor(detected_sharps_centred);
clear sharps_x sharps_y;


se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the sharps');
imshow(E,'InitialMagnification','fit');
end

clear sharps_x sharps_x_centred sharps_y sharps_y_centred C D E maxC se thresh;

% Identifying the type of the sharps
textCol=cell(size(detected_sharps_centred,1),2);
sharpPositions=[stave_locs_cropped(1)...
    stave_locs_cropped(2)...
    stave_locs_cropped(3)...
    stave_locs_cropped(4)...
    stave_locs_cropped(5)...
    (stave_locs_cropped(1)+stave_locs_cropped(2))/2 ...
    (stave_locs_cropped(2)+stave_locs_cropped(3))/2 ...
    (stave_locs_cropped(3)+stave_locs_cropped(4))/2 ...
    (stave_locs_cropped(4)+stave_locs_cropped(5))/2 ...
    (stave_locs_cropped(5)+(stave_locs_cropped(5)-stave_locs_cropped(4))/2)...
    (stave_locs_cropped(1)-((stave_locs_cropped(2)-stave_locs_cropped(1))/2))];

for i=1:size(detected_sharps_centred,1)
    idx=knnsearch(sharpPositions(:),detected_sharps_centred(i,1));
    switch idx
        case 1
            textCol(i)={'Sharp'}; textCol(i,2)={'F'};
        case 2
            textCol(i)={'Sharp'}; textCol(i,2)={'D'};
        case 3
            textCol(i)={'Sharp'}; textCol(i,2)={'B'};
        case 4
            textCol(i)={'Sharp'}; textCol(i,2)={'G'};
        case 5
            textCol(i)={'Sharp'}; textCol(i,2)={'E'};
        case 6
            textCol(i)={'Sharp'}; textCol(i,2)={'E'};
        case 7
            textCol(i)={'Sharp'}; textCol(i,2)={'C'};
        case 8
            textCol(i)={'Sharp'}; textCol(i,2)={'A'};
        case 9
            textCol(i)={'Sharp'}; textCol(i,2)={'F'};
        case 10
            textCol(i)={'Sharp'};textCol(i,2)={'D'};
        case 11
            textCol(i)={'Sharp'}; textCol(i,2)={'G'};
        otherwise
    end
end

recogniseSharps = [num2cell(detected_sharps_centred),textCol];
clear i textCol idx sharpPositions;

%% Deleting the sharps' pixels from the cropped stave
for i=1:size(detected_sharps,1)
    for j=detected_sharps(i,1)-size(sharp,1):detected_sharps(i,1)
        for k=detected_sharps(i,2)-size(sharp,2):detected_sharps(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k sharp;
