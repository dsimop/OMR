% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the semibreve notes
semibreve_note=imread('Musical_Objects/semibrevenote.tiff');
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(semibreve_note,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh = 4.293999999999999e+02;

D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[semibreve_note_x,semibreve_note_y]=find(E);
detected_semibreve_note=[semibreve_note_x semibreve_note_y];

semibreve_note_x_centred=detected_semibreve_note(:,1)-size(semibreve_note,1)/2-2;
semibreve_note_y_centred=detected_semibreve_note(:,2)-size(semibreve_note,2)/2;
detected_semibreve_note_centred=[semibreve_note_x_centred semibreve_note_y_centred];
detected_semibreve_note_centred=floor(detected_semibreve_note_centred);
clear semibreve_note_x semibreve_note_x_centred semibreve_note_y semibreve_note_y_centred C D E maxC se thresh;

% Recognising the identified semibreve notes
textCol=cell(size(detected_semibreve_note_centred,1),2);
notePositions=[stave_locs_cropped(1)-2*(stave_locs_cropped(2)-stave_locs_cropped(1)) ...
    2*stave_locs_cropped(1)-stave_locs_cropped(2)-(stave_locs_cropped(2)-stave_locs_cropped(1))/2 ...
    2*stave_locs_cropped(1)-stave_locs_cropped(2) ...
    stave_locs_cropped(1)-(stave_locs_cropped(2)-stave_locs_cropped(1))/2 ...
    stave_locs_cropped(1) ...
    stave_locs_cropped(1)+(stave_locs_cropped(2)-stave_locs_cropped(1))/2 ...
    stave_locs_cropped(2)...
    stave_locs_cropped(2)+(stave_locs_cropped(3)-stave_locs_cropped(2))/2 ...
    stave_locs_cropped(3)...
    stave_locs_cropped(3)+(stave_locs_cropped(4)-stave_locs_cropped(3))/2 ...
    stave_locs_cropped(4) ...
    stave_locs_cropped(4)+(stave_locs_cropped(5)-stave_locs_cropped(4))/2 ...
    stave_locs_cropped(5) ...
    stave_locs_cropped(5)+(stave_locs_cropped(5)-stave_locs_cropped(4))/2 ...
    2*stave_locs_cropped(5)-stave_locs_cropped(4) ...
    (2*stave_locs_cropped(5)-stave_locs_cropped(4))+(stave_locs_cropped(5)-stave_locs_cropped(4))/2 ...
    stave_locs_cropped(5)+2*(stave_locs_cropped(5)-stave_locs_cropped(4)) ...
    stave_locs_cropped(5)+2*(stave_locs_cropped(5)-stave_locs_cropped(4))+(stave_locs_cropped(5)-stave_locs_cropped(4))/2
    ];
for i=1:size(detected_semibreve_note_centred,1)
    idx=knnsearch(notePositions(:),detected_semibreve_note_centred(i,1));
    switch idx
        case 1
            textCol(i)={'6'}; textCol(i,2)={'C'};
        case 2
            textCol(i)={'5'}; textCol(i,2)={'B'};
        case 3
            textCol(i)={'5'}; textCol(i,2)={'A'};
        case 4
            textCol(i)={'5'}; textCol(i,2)={'G'};
        case 5
            textCol(i)={'5'}; textCol(i,2)={'F'};
        case 6
            textCol(i)={'5'}; textCol(i,2)={'E'};
        case 7
            textCol(i)={'5'}; textCol(i,2)={'D'};
        case 8
            textCol(i)={'5'}; textCol(i,2)={'C'};
        case 9
            textCol(i)={'4'};  textCol(i,2)={'B'};
        case 10
            textCol(i)={'4'};  textCol(i,2)={'A'};
        case 11
            textCol(i)={'4'}; textCol(i,2)={'G'};
        case 12
            textCol(i)={'4'};  textCol(i,2)={'F'};
        case 13
            textCol(i)={'4'};  textCol(i,2)={'E'};
        case 14
            textCol(i)={'4'}; textCol(i,2)={'D'};
        case 15
            textCol(i)={'4'}; textCol(i,2)={'C'};
        case 16
            textCol(i)={'3'}; textCol(i,2)={'B'};
        case 17
            textCol(i)={'3'}; textCol(i,2)={'A'};
        case 18
            textCol(i)={'3'}; textCol(i,2)={'G'};
    end
end
recogniseSemibreveNotes = [num2cell(detected_semibreve_note_centred),textCol];
recogniseSemibreveNotes=[recogniseSemibreveNotes repmat({'1'},size(recogniseSemibreveNotes,1),1)];
recogniseSemibreveNotes(:,[1 2]) = recogniseSemibreveNotes(:,[2 1]);
clear i textCol idx notePositions;

%% Deleting the semibreve note pixels from the cropped stave
for i=1:size(detected_semibreve_note,1)
    for j=detected_semibreve_note(i,1)-size(semibreve_note,1):detected_semibreve_note(i,1)
        for k=detected_semibreve_note(i,2)-size(semibreve_note,2):detected_semibreve_note(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k semibreve_note;
