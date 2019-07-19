% @Author: Dimitrios Simopoulos

% Creating a matrix including all the notes and their information
recogniseStaveNotes=[recogniseSemibreveNotes; recogniseFilledNotes; recogniseMinimNotes];
recogniseStaveNotes = sortrows(recogniseStaveNotes, 1);
%%
recogniseFullyNotes=[recogniseStaveNotes; recogniseAccidentals];
recogniseFullyNotes = sortrows(recogniseFullyNotes, 1);
recogniseFullyNotes=[recogniseFullyNotes repmat({' '},size(recogniseFullyNotes,1),1)];
%%
for i=1:size(recogniseKeySig,1)
    for j=1:size(recogniseFullyNotes,1)
        if(cell2mat(recogniseKeySig(i,4))==cell2mat(recogniseFullyNotes(j,4)))
            recogniseFullyNotes(j,6)=recogniseKeySig(i,3);
        end
    end
end

%%
ind=[];
for i=1:size(recogniseFullyNotes,1)-1
    if isequal(cell2mat(recogniseFullyNotes(i,5)),'Accidental')
        ind=[ind i];
        recogniseFullyNotes(i+1,6)=recogniseFullyNotes(i,3);
    end
end
recogniseFullyNotes(ind,:)=[];

clear i ind recogniseSemibreveNotes recogniseFilledNotes recogniseStaveNotes ...
    recogniseMinimNotes recogniseAccidentals recogniseKeySig detected_qtail1 detected_qtail1_upperleft...
    detected_qtail2 detected_qtail2_centred detected_semibreve_note detected_semibreve_note_centred...
    detected_sqtail1 detected_sqtail1_upperleft detected_sqtail2 detected_sqtail2_centred distance_betw_stave_lines indices ...
    minimNoteHeads noteHeads;

%% Merging the notes with the dots, where necessary
for i=1:size(recogniseFullyNotes,1)
    for j=1:size(dots_centred,1)
        if abs(cell2mat(recogniseFullyNotes(i,1))-dots_centred(j,1))<30
            d=str2double(cell2mat(recogniseFullyNotes(i,5)));
            d=d*3/2;
            recogniseFullyNotes(i,5)={num2str(d)};
        end
    end
end

clear dots_centred i j d;
