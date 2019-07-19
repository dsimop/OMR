% @Author: Dimitrios Simopoulos

%% Finding the stems from the vertical projection
scan_line = sum(cropped_stave,1);
scan_filtered=(scan_line>stave_height*2.1/3);
[stem_peak_idx,stem_peak_locs,stem_peak_width] = findpeaks(double(scan_filtered));
if displayFigures==1
    figure( 'name','Vertical Projection of the stems');
    fill(1:size(cropped_stave,2),sum(cropped_stave,1),'k');
    hold on;
    for i=1:size(stem_peak_locs,2)
        plot([stem_peak_locs(i);stem_peak_locs(i)],[0;100],'r');
    end
    hold off;
end
clear i scan_line scan_filtered;

%% Deleting the stem pixels from the cropped stave
for i=1:size(stem_peak_locs,2)
    for j=1: size(cropped_stave,1)
        if cropped_stave(j,stem_peak_locs(i)-3)==0 && cropped_stave(j,stem_peak_locs(i)+3)==0
            cropped_stave(j,stem_peak_locs(i)-2)=0;
            cropped_stave(j,stem_peak_locs(i)-1)=0;
            cropped_stave(j,stem_peak_locs(i))=0;
            cropped_stave(j,stem_peak_locs(i)+1)=0;
            cropped_stave(j,stem_peak_locs(i)+2)=0;
            cropped_stave(j,stem_peak_locs(i)+3)=0;
        end
    end
end

clear i j;
