% @Author: Dimitrios Simopoulos

% Recognition of the score
recogniseFullyStave=[recogniseFullyNotes; recogniseFullyRests];
recogniseFullyStave=sortrows(recogniseFullyStave, 1);
if s==1
    recogniseScore=recogniseFullyStave;
else
    recogniseScore=[recogniseScore ; recogniseFullyStave];
end
clear recogniseFullyStave;

% Clearing also other variables that are not needed at the end of the loop
clear stave_idx_cropped stave_locs_cropped stem_peak_idx stem_peak_locs stem_peak_width;
