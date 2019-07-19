% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the naturals
natural=imread('Musical_Objects/natural.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(natural,2),size(cropped_stave,1),size(cropped_stave,2))));

thresh =  4.177800000000000e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[naturals_x,naturals_y]=find(E);
detected_naturals=[naturals_x naturals_y];

naturals_x_centred=detected_naturals(:,1)-size(natural,1)/2;
naturals_y_centred=detected_naturals(:,2)-size(natural,2)/2+3;
detected_naturals_centred=[naturals_x_centred naturals_y_centred];
detected_naturals_centred=floor(detected_naturals_centred);
clear naturals_x naturals_y naturals_x_centred naturals_y naturals_y_centred C D E maxC se thresh;

% Identifying the type of the rest
textCol=cell(size(detected_naturals_centred,1),2);
naturalPositions=[stave_locs_cropped(1)...
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


for i=1:size(detected_naturals_centred,1)
    idx=knnsearch(naturalPositions(:),detected_naturals_centred(i,1));
    switch idx
        case 1
            textCol(i)={'Natural'}; textCol(i,2)={'F'};
        case 2
            textCol(i)={'Natural'}; textCol(i,2)={'D'};
        case 3
            textCol(i)={'Natural'}; textCol(i,2)={'B'};
        case 4
            textCol(i)={'Natural'}; textCol(i,2)={'G'};
        case 5
            textCol(i)={'Natural'}; textCol(i,2)={'E'};
        case 6
            textCol(i)={'Natural'}; textCol(i,2)={'E'};
        case 7
            textCol(i)={'Natural'}; textCol(i,2)={'C'};
        case 8
            textCol(i)={'Natural'}; textCol(i,2)={'A'};
        case 9
            textCol(i)={'Natural'}; textCol(i,2)={'F'};
        case 10
            textCol(i)={'Natural'};textCol(i,2)={'D'};
        case 11
            textCol(i)={'Natural'}; textCol(i,2)={'G'};
        otherwise
    end
end

recogniseNaturals = [num2cell(detected_naturals_centred),textCol];
clear i textCol idx naturalPositions;

%% Deleting the naturals' pixels from the cropped stave
for i=1:size(detected_naturals,1)
    for j=detected_naturals(i,1)-size(natural,1):detected_naturals(i,1)
        for k=detected_naturals(i,2)-size(natural,2):detected_naturals(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k natural;
