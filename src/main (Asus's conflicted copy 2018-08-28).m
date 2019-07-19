% @Author: Dimitrios Simopoulos
clear;clc;close all;

% Specifying the image path
orig_image=imread('Scores/serenata.png');
% The user can determine if the figures will be displayed (Warning: time/memory consuming)
displayFigures=false;


%%
if ndims(orig_image) == 3
    orig_image=rgb2gray(orig_image);
end
bw=imcomplement(imbinarize(orig_image));
% Filter peaks for stave lines
run('stave_peaks_score.m');

% Removing the stave lines of the music score (just for visualisation, can be skipped)
run('removelines_score.m');

%% Dividing the music score into staves and recognising them

staves_dist=round(stave_locs(6)-stave_locs(5))/2;
t=1;
recogniseScore={};

for s=1 : size(stave_locs,1)/5
    
    % Cropping the image to get automatically the sub-images 
    warning off;
    cropped_stave=bw(stave_locs(t)-staves_dist:stave_locs(5*s)+staves_dist,1:size(bw_withoutlines,2));
    t=t+5;
    if displayFigures==1
    figure('name','The first stave');
    imshow(cropped_stave,'InitialMagnification','fit');
    end
    
    % Plotting the horizontal projection of the cropped stave
    if displayFigures==1
    figure('name','Horizontal Projection of the first stave');
    fill(sum(cropped_stave,2),1:size(cropped_stave,1),'k');
    xlim([-10 inf]);
    set(gca,'Ydir','reverse');
    end
    
    % Filter peaks for stave lines
    scan_line_cropped = mean(cropped_stave,2);
    scan_peak_thresh_cropped = mean(scan_line_cropped)+4.5/2*std(scan_line_cropped);
    scan_filtered_cropped = (scan_line_cropped>scan_peak_thresh_cropped);
    [stave_idx_cropped,stave_locs_cropped] = findpeaks(double(scan_filtered_cropped));
    clear scan_line_cropped scan_peak_thresh_cropped scan_filtered_cropped;
    
    % Removing the stave lines of the cropped image
    run('removelines.m');
    
    % Fast-Fourier Transformation for the clef
    run('fft_clef.m');
    
    % Fast-Fourier Transformation for the accidentals
    run('fft_sharps.m');
    run('fft_flats.m');
    run('fft_naturals.m');
    
    % Creating the Accidentals Matrix
    run('accidentals.m');
    
    % Fast-Fourier Transformation for the time signature (it is executed only in the first stave)
    if s==1
        run('fft_time_signature.m');
    end
    
    % Separating the Key Signature from the Accidentals
    run('keySig.m');
    
    % Fast-Fourier Transformation for the mf and ff
    run('fft_mf.m');
    run('fft_ff.m');
    
    % Finding the bar positions
    run('bar_positions.m');

    % Fast-Fourier Transformation for the rests
    run('fft_rests_minim_semibreve.m');
    run('fft_rests_crotchet.m');
    run('fft_rests_quaver.m');
    run('fft_rests_semiquaver.m');
    run('rests.m');
    
    % Finding the stems from the vertical projection and deleting them
    run('stems.m');

    % Fast-Fourier Transformation for the semibreve, minim, crotchet, quaver and semiquaver notes
    run('fft_notes_semibreve.m');
    run('fft_sqtail2.m');
    run('dots.m');
    run('noteheads_filled.m');
    run('fft_qtail1.m');
    run('fft_qtail2.m');
    run('fft_sqtail1.m');
    run('quaver_semiquaver_recognition.m');    
    run('noteheads_minim.m');

    % Creating a matrix including all the notes and their information
    run('notes.m');
    
    % Creating the recogniseScore variable that includes all the necessary
    % information - it can be considered as a 'database'
    run('recognition.m');
end 
clear s t stave_height stave_idx stave_locs staves_dist;

%% Reshaping the data in order to create the audio sample
run('                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           .m');
run('audio.m');