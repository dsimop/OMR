% @Author: Dimitrios Simopoulos

%% Fast-Fourier Transformation for the semibreve (whole) and minim (half) rests
rest=imread('Musical_Objects/rest.tiff');
% This code is introduced in the "FFT-Based Correlation to Locate Image Features" Tutorial from MathWorks
C = real(ifft2(fft2(cropped_stave) .* fft2(rot90(rest,2),size(cropped_stave,1),size(cropped_stave,2))));
thresh = 3.375899999999999e+02;
D = C > thresh;
se = strel('square',1);
E = imdilate(D,se);
[rest_x,rest_y]=find(E);
detected_rests=[rest_x rest_y];
indices=[];
for i=1:size(detected_rests,1)-1
    if abs(detected_rests(i+1,2)-detected_rests(i,2))<8
        indices=[indices i];
    end
end
for i=size(indices,2):-1:1
    detected_rests(indices(i),:)=[];
end
rest_x_upperleft=detected_rests(:,1)-size(rest,1)/2-6;
rest_y_upperleft=detected_rests(:,2)-size(rest,2)/2-14;
detected_rests_upperleft=[rest_x_upperleft rest_y_upperleft];
detected_rests_upperleft=floor(detected_rests_upperleft);
se = strel('disk',7);
E = imdilate(D,se);
if displayFigures==1
figure('name','Finding the semibreve and the minim rests');
imshow(E,'InitialMagnification','fit') % Display pixels with values over the threshold
end
clear rest_x rest_x_upperleft rest_y rest_y_upperleft C D E se thresh;

%% Identifying the type of the semibreve and minim rests
textCol=cell(size(detected_rests_upperleft,1),3);
for i=1:size(detected_rests_upperleft,1)
    for j=1:size(stave_locs_cropped) %The number of the stave lines is 5
        if abs(detected_rests_upperleft(i,1)-stave_locs_cropped(j))<5
            textCol(i) ={'Semibreve'};
            textCol(i,2) ={'Rest'};
            textCol(i,3) ={'1'};
            break
        else
            textCol(i) ={'Minim'};
            textCol(i,2) ={'Rest'};
            textCol(i,3) ={'0.5'};
        end
    end
end
recogniseMinimSemibreveRests = [num2cell(detected_rests_upperleft),textCol];
clear i j textCol detected_rests_upperleft;

%% Deleting the semibreve (whole) and minim (half) rests' pixels from the cropped stave
for i=1:size(detected_rests,1)
    for j=detected_rests(i,1)-size(rest,1):detected_rests(i,1)
        for k=detected_rests(i,2)-size(rest,2):detected_rests(i,2)
            cropped_stave(j,k)=0;
        end
    end
end
clear i j k rest;
