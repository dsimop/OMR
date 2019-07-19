% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the flats
flat=imread('Musical_Objects/flat.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(flat,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh =  3.280600000000000e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[flats_x,flats_y]=find(E);
detected_flats=[flats_x flats_y];

flats_x_centred=detected_flats(:,1)-size(flat,1)/2+12;
flats_y_centred=detected_flats(:,2)-size(flat,2)/2;
detected_flats_centred=[flats_x_centred flats_y_centred];
detected_flats_centred=floor(detected_flats_centred);
clear flats_x flats_y;

clear flats_x flats_x_centred flats_y flats_y_centred C D E se maxC thresh;

% Identifying the type of the flats
textCol=cell(size(detected_flats_centred,1),2);
flatPositions=[stave_locs_cropped(1)...
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

for i=1:size(detected_flats_centred,1)
     idx=knnsearch(flatPositions(:),detected_flats_centred(i,1));
    switch idx
        case 1
            textCol(i)={'Flat'}; textCol(i,2)={'F'};
        case 2
            textCol(i)={'Flat'}; textCol(i,2)={'D'};
        case 3
            textCol(i)={'Flat'}; textCol(i,2)={'B'};
        case 4
            textCol(i)={'Flat'}; textCol(i,2)={'G'};
        case 5
            textCol(i)={'Flat'}; textCol(i,2)={'E'};
        case 6
            textCol(i)={'Flat'}; textCol(i,2)={'E'};
        case 7
            textCol(i)={'Flat'}; textCol(i,2)={'C'};
        case 8
            textCol(i)={'Flat'}; textCol(i,2)={'A'};
        case 9
            textCol(i)={'Flat'}; textCol(i,2)={'F'};
        case 10
            textCol(i)={'Flat'};textCol(i,2)={'D'};
        case 11
            textCol(i)={'Flat'}; textCol(i,2)={'G'};
        otherwise
    end
end

recogniseFlats = [num2cell(detected_flats_centred),textCol];
clear i textCol idx flatPositions;

%% Deleting the flats' pixels from the cropped stave
for i=1:size(detected_flats,1)
    for j=detected_flats(i,1)-size(flat,1):detected_flats(i,1)
        for k=detected_flats(i,2)-size(flat,2):detected_flats(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k flat;
