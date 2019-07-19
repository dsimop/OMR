% @Author: Dimitrios Simopoulos

%% Removing the stave lines;
% Drawing white lines with a specific line width could not work eficiently.
% So, I change the binary value of the appropriate pixels of the bw image.
tmp=bw;

for i=1:size(stave_locs)
    for j=1:size(bw,2)
        if(bw(stave_locs(i)-2,j)~=1)
            bw(stave_locs(i)-1,j)=0;
            bw(stave_locs(i),j)=0;
        end
        if(bw(stave_locs(i)+2,j)~=1)
            bw(stave_locs(i),j)=0;
            bw(stave_locs(i)+1,j)=0;
        end
    end
end
distance_betw_stave_lines=stave_locs(2)-stave_locs(1);
bw_withoutlines=bw;
bw=tmp;
clear i j tmp;
if displayFigures==1
figure('name','Removing the stave lines');
imshow(imcomplement(bw_withoutlines),'InitialMagnification','fit');
hold off;
end