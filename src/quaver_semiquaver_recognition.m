% @Author: Dimitrios Simopoulos

% Separating the crotchets from the quavers and the semiquavers

for i=1:size(recogniseFilledNotes,1)
    for j=1:size(detected_qtail1_upperleft,1)
        if abs(cell2mat(recogniseFilledNotes(i,1))-detected_qtail1_upperleft(j,2))<5
            recogniseFilledNotes(i,5)={'0.125'};
        end
    end   
    for k=1:size(detected_qtail2_centred,1)
        if abs(cell2mat(recogniseFilledNotes(i,1))-detected_qtail2_centred(k,2))<5
            recogniseFilledNotes(i,5)={'0.125'};
        end
    end
     for l=1:size(detected_sqtail1_upperleft,1)
        if abs(cell2mat(recogniseFilledNotes(i,1))-detected_sqtail1_upperleft(l,2))<5
            recogniseFilledNotes(i,5)={'0.0625'};
        end
     end
     for m=1:size(detected_sqtail2_centred,1)
        if abs(cell2mat(recogniseFilledNotes(i,1))-detected_sqtail2_centred(m,2))<5
            recogniseFilledNotes(i,5)={'0.0625'};
        end
    end
end
clear i j k l m;
