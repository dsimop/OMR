% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the 4/4 time signature
found=false;

time_sig=imread('Musical_Objects/ts_4_4.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh = 1.117200000000000e+03;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[time_sig_x,time_sig_y]=find(E);
detected_time_sig_4_4=[time_sig_x time_sig_y];

if ~isempty(detected_time_sig_4_4)
    TimeSignature='4/4';
    found=true;
    clear time_sig_x time_sig_y;
    se = strel('disk',7);
    E = imdilate(D,se);
    if displayFigures==1
        figure('name','Finding the time signature');
        imshow(E,'InitialMagnification','fit');
    end
    detected_time_sig=detected_time_sig_4_4;
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 3/4 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_3_4.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.123080000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_3_4=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_3_4)
        TimeSignature='3/4';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
    detected_time_sig=detected_time_sig_3_4;
        clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 2/4 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_2_4.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.159340000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_2_4=[time_sig_x time_sig_y];
    
    clear time_sig_x time_sig_y;
    if ~isempty(detected_time_sig_2_4)
        TimeSignature='2/4';
        found=true;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
    detected_time_sig=detected_time_sig_2_4;
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 5/4 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_5_4.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.159290000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_5_4=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_5_4)
        TimeSignature='5/4';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
    detected_time_sig=detected_time_sig_5_4;
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 6/4 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_6_4.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.175020000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_6_4=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_6_4)
        TimeSignature='6/4';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
    detected_time_sig=    detected_time_sig_6_4; 
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 3/8 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_3_8.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.181070000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_3_8=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_3_8)
        TimeSignature='3/8';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
    detected_time_sig=detected_time_sig_3_8;
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 6/8 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_6_8.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.220100000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_6_8=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_6_8)
        TimeSignature='6/8';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
     detected_time_sig= detected_time_sig_6_8;
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 9/8 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_9_8.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.222060000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_9_8=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_9_8)
        TimeSignature='9/8';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
    end
     detected_time_sig= detected_time_sig_9_8;
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end
%% Fast-Fourier Transformation for the 12/8 time signature
if found==false
    time_sig=imread('Musical_Objects/ts_12_8.tiff');
    C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(time_sig,2),size(cropped_stave,1),size(cropped_stave,2))));
    
    thresh = 1.658160000000000e+03;
    D = C > thresh;
    se = strel('square',1);
    E = imdilate(D,se);
    [time_sig_x,time_sig_y]=find(E);
    detected_time_sig_12_8=[time_sig_x time_sig_y];
    
    if ~isempty(detected_time_sig_12_8)
        TimeSignature='12/8';
        found=true;
        clear time_sig_x time_sig_y;
        se = strel('disk',7);
        E = imdilate(D,se);
        if displayFigures==1
            figure('name','Finding the time signature');
            imshow(E,'InitialMagnification','fit');
        end
        detected_time_sig=detected_time_sig_12_8;
    end
    clear time_sig_x time_sig_x_centred time_sig_y time_sig_y_centred C D E se thresh;
end

clear detected_time_sig_12_8 detected_time_sig_2_4...
    detected_time_sig_3_4 detected_time_sig_3_8...
    detected_time_sig_4_4 detected_time_sig_5_4...
    detected_time_sig_6_4 detected_time_sig_6_8...
    detected_time_sig_9_8;

%% Deleting the time signature's pixels from the cropped stave
for i=detected_time_sig(1)-size(time_sig,1):detected_time_sig(1)
    for j=1:detected_time_sig(2)
        cropped_stave(i,j)=0;
    end
end
recogniseTimeSignature=[num2cell(detected_time_sig) cellstr(TimeSignature)];
posOfTimeSig=recogniseTimeSignature(1,2);
clear i j found TimeSignature time_sig time_sig detected_time_sig posOfTimeSig;
