% @Author: Dimitrios Simopoulos

%% Creating the Accidentals Matrix
mat=[recogniseSharps; recogniseFlats; recogniseNaturals];
Accidentals = sortrows(mat, 2);
indices=[];
for i=1:size(Accidentals,1)-1
    if abs(cell2mat(Accidentals(i,2))- cell2mat(Accidentals(i+1,2)))<5
        indices=[indices i];
    end
end

for i=size(indices,2):-1:1
    Accidentals(indices(i),:)=[];
end
clear i recogniseSharps recogniseFlats recogniseNaturals mat indices detected_sharps detected_flats detected_naturals detected_sharps_centred detected_flats_centred detected_naturals_centred;
