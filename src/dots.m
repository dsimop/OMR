% @Author: Dimitrios Simopoulos

%% Finding the dots for the dotted notes
cropped_stave=bwareaopen(cropped_stave,20);
se = strel('square',3);
cropped_stave=imclose(cropped_stave,se);

[B,L] = bwboundaries(cropped_stave,'noholes');
for k = 1:length(B)
  boundary = B{k};
end
stats = regionprops(L,'Area','Centroid');
threshold = 1;
dots_centred=[];

for k = 1:length(B)
  boundary = B{k};
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  area = stats(k).Area;
  metric = 4*pi*area/perimeter^2;
  if metric > threshold
    centroid = stats(k).Centroid;
    dots_centred(end+1,:)=round(centroid);    
  end
end
clear B k L stats threshold boundary delta_sq perimeter area metric centroid;

%% Deleting the dots from the image (the radius is approx. 6 pixels)

for i=1:size(dots_centred,1)
    for j=dots_centred(i,1)-5:dots_centred(i,1)+6
        for k=dots_centred(i,2)-6:dots_centred(i,2)+6
            cropped_stave(k,j)=0;
        end
    end
end
clear i j k;
