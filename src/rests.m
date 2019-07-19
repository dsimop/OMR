% @Author: Dimitrios Simopoulos

% Merging the rests into the recogniseRests Table
recogniseFullyRests=[recogniseQuaverRests ; recogniseCrotchetRests; recogniseMinimSemibreveRests ; recogniseSemiquaverRests];
recogniseFullyRests=sortrows(recogniseFullyRests, 2);
recogniseFullyRests(:,[1 2]) = recogniseFullyRests(:,[2 1]);
recogniseFullyRests=[recogniseFullyRests repmat({''},size(recogniseFullyRests,1),1)];
clear textCol recogniseQuaverRests  recogniseCrotchetRests recogniseMinimSemibreveRests recogniseSemiquaverRests ...
    detected_rests detected_rests_crotchet detected_rests_crotchet detected_rests_quaver detected_rests_quaver_centred...
    detected_rests_crotchet_centred detected_rests_semiquaver detected_rests_semiquaver_centred;
