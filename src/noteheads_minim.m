% @Author: Dimitrios Simopoulos

%% Recognising the minim noteheads
se = strel('disk',7);
cropped_stave = imclose(cropped_stave,se);
clear se;

%% Finding the minim note heads
[B,L] = bwboundaries(cropped_stave,'noholes');

stats = regionprops(L,'Area','Centroid');
threshold = 0.5;
minimNoteHeads=[];
% loop over the boundaries
for k = 1:length(B)
    
    % obtain (X,Y) boundary coordinates corresponding to label 'k'
    boundary = B{k};
    
    % compute a simple estimate of the object's perimeter
    delta_sq = diff(boundary).^2;
    perimeter = sum(sqrt(sum(delta_sq,2)));
    
    % obtain the area calculation corresponding to label 'k'
    area = stats(k).Area;
    
    % compute the roundness metric
    metric = 4*pi*area/perimeter^2;
    
    % mark objects above the threshold with a black circle
    if metric > threshold
        centroid = stats(k).Centroid;
        minimNoteHeads(end+1,:)=round(centroid);
    end
end
clear k B L stats metric threshold centroid delta_sq area boundary perimeter;


%% Recognising the identified minim notes
textCol=cell(size(minimNoteHeads,1),2);
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

for i=1:size(minimNoteHeads,1)
    idx=knnsearch(notePositions(:),minimNoteHeads(i,2));
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
recogniseMinimNotes = [num2cell(minimNoteHeads),textCol];
recogniseMinimNotes=[recogniseMinimNotes repmat({'0.5'},size(recogniseMinimNotes,1),1)];
clear i textCol notePositions idx ind;

%% Deleting the recognised minim noteheads
for i=1:size(minimNoteHeads,1)
    for j=minimNoteHeads(i,1)-25:minimNoteHeads(i,1)+25
        for k=minimNoteHeads(i,2)-15:minimNoteHeads(i,2)+15
            cropped_stave(k,j)=0;
        end
    end
end
clear i j k;
