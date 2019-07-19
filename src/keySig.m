% @Author: Dimitrios Simopoulos

%% Separating the Key Signature from the Accidentals
indices=[];
for i=1:size(Accidentals,1)
    if  cell2mat(Accidentals(i,2))<cell2mat(recogniseTimeSignature(1,2))
        indices=[indices i];
    end
end
recogniseKeySig=Accidentals(indices,:);
recogniseKeySig(:,[1 2]) = recogniseKeySig(:,[2 1]);
Accidentals(indices,:)=[];
recogniseAccidentals=Accidentals;
recogniseAccidentals(:,[1 2]) = recogniseAccidentals(:,[2 1]);
recogniseAccidentals=[recogniseAccidentals repmat({'Accidental'},size(recogniseAccidentals,1),1)];

clear Accidentals indices i recogniseNaturals recogniseFlats recogniseSharps;
