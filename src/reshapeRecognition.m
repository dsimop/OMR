% @Author: Dimitrios Simopoulos

%% Reshaping the final score recognition array for the audio creation

for i=1:size(recogniseScore,1)
    if size(recogniseScore,2)==6
        if ~(isempty(cell2mat(recogniseScore(i,6))))
            if isequal(cell2mat(recogniseScore(i,6)),'Sharp')
                str=char(recogniseScore(i,4));
                shrp='#';
                recogniseScore(i,4)={strcat(str,shrp)};
            elseif isequal(cell2mat(recogniseScore(i,6)),'Flat')
                str=char(recogniseScore(i,4));
                flt='b';
                recogniseScore(i,4)={strcat(str,flt)};
            end
        end
    end
end

for i=1:size(recogniseScore,1)
    if ~isequal(cell2mat(recogniseScore(i,4)),'Rest')
        str1=cell2mat(recogniseScore(i,3));
        str2=cell2mat(recogniseScore(i,4));
        recogniseScore(i,4)={strcat(str1,str2)};
    end
end
recogniseScore=recogniseScore(:,4:5);
clear i str1 str2 shrp flt str;
