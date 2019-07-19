% @Author: Dimitrios Simopoulos

for i=1:size(stave_locs_cropped)
    for j=1:size(cropped_stave,2)
        if(cropped_stave(stave_locs_cropped(i)-2,j)~=1)
            cropped_stave(stave_locs_cropped(i)-1,j)=0;
            cropped_stave(stave_locs_cropped(i),j)=0;
        end
        if(cropped_stave(stave_locs_cropped(i)+2,j)~=1)
            cropped_stave(stave_locs_cropped(i),j)=0;
            cropped_stave(stave_locs_cropped(i)+1,j)=0;
        end
    end
end