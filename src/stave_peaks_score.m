% @Author: Dimitrios Simopoulos

%% Filter peaks for stave lines
% This piece of code was used from Andy Zeng, but it is edited in order to
% identify more accurately the stave lines.
scan_line = mean(bw,2);
scan_peak_thresh = mean(scan_line)+9/2*std(scan_line);
scan_filtered = (scan_line>scan_peak_thresh);
[stave_idx,stave_locs] = findpeaks(double(scan_filtered));
clear scan_line scan_peak_thresh scan_filtered;

%% Plotting the horizontal projection of the image
if displayFigures==1
figure('name','Horizontal Projection of the original image');
fill(sum(bw,2),1:size(bw,1),'k');
xlim([-10 inf]);
set(gca,'Ydir','reverse');
end

%% Visualizing the stave lines
if displayFigures==1
figure('name','Visualizing the stave lines');
imshow(imcomplement(bw),'InitialMagnification','fit');
hold on;
for i=1:size(stave_idx)
    plot([1;size(orig_image,2)],[stave_locs(i);stave_locs(i)],'r');
end
clear i;
hold off;
end
