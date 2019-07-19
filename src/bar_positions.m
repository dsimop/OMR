% @Author: Dimitrios Simopoulos

%% Finding the bar positions
myVerticalProjection=sum(cropped_stave,1);
stave_height=myVerticalProjection(find(myVerticalProjection,1,'last'));
bar_pos=find(myVerticalProjection==stave_height);

%Making more accurate the bar positions by deleting any faulty lines
indices=[];
for i=2:size(bar_pos,2)-1
    if bar_pos(i-1)+1~=bar_pos(i) && bar_pos(i)+1 ~=bar_pos(i+1)
        indices=[indices i];
    end
end
if bar_pos(1)+1~=bar_pos(2)
    indices=[indices 1];
end
if bar_pos(end-1)+1~=bar_pos(end)
    indices=[indices size(bar_pos,2)];
end
if bar_pos(end)~=bar_pos(end)-1
    bar_pos(end)=[];
end
for i=size(indices,2):-1:1
    bar_pos(indices(1,i))=[];
end
clear indices i;

% Excluding the bars from the vertical projection
myVerticalProjection(myVerticalProjection==stave_height)=0;

%% Plotting the vertical projection without the bar lines
if displayFigures==1
figure('name','Vertical Projection of the stave without the bar lines');
fill(1:size(myVerticalProjection,2),sum(myVerticalProjection,1),'k');
end

%% Visualise the stave without the bar lines
for i=1:size(bar_pos,2)
    cropped_stave(:,bar_pos(i))=0;
end
clear i myVerticalProjection;
if displayFigures==1
figure('name','The cropped stave without the bar lines');
imshow(cropped_stave,'InitialMagnification','fit');
end
