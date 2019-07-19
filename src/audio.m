% @Author: Dimitrios Simopoulos

song=recogniseScore(:,1)';
dur=str2double(recogniseScore(:,2)');
% Reformatting the duration array
for i=1:size(dur,2)
    if dur(1,i)==0.5
        dur(1,i)=2;
    elseif dur(1,i)==0.25
        dur(1,i)=4;
    elseif dur(1,i)==0.125
        dur(1,i)=8;
    elseif dur(1,i)==0.0625
        dur(1,i)=16;
    elseif dur(1,i)==0.75
        dur(1,i)=100/75;
    elseif dur(1,i)==0.375
        dur(1,i)=1000/375;
    elseif dur(1,i)==0.1875
        dur(1,i)=10000/1875;
    elseif dur(1,i)==0.0625
        dur(1,i)=100000/9375;
    end
end
% Making the tempo faster
dur=dur*3/2;

%% There is a mapping between the notesArray and the pitch, which represents the piano keys
notesArray={'3Gb' '3G' '3G#' '3Ab' '3A' '3A#' '3Bb' '3B' '3B#'...
            '4Cb' '4C' '4C#' '4Db' '4D' '4D#' '4Eb' '4E' '4E#'...
            '4Fb' '4F' '4F#' '4Gb' '4G' '4G#' '4Ab' '4A' '4A#'...
            '4Bb' '4B' '4B#' '5Cb' '5C' '5C#' '5Db' '5D' '5D#'...
            '5Eb' '5E' '5E#' '5Fb' '5F' '5F#' '5Gb' '5G' '5G#'...
            '5Ab' '5A' '5A#' '5Bb' '5B' '5B#' '6Cb' '6C' '6C#'};
pitch=[34 35 36 36 37 38 38 39 40 39 40 41 41 42 43 43 44 45 ...
       44 45 46 46 47 48 48 49 50 50 51 52 51 52 53 53 54 55 55 ...
       56 57 56 57 58 58 59 60 60 61 62 62 63 64 63 64 65];
mySong=[];
fs=44100;
for i=1:size(song,2)
      if isequal(cell2mat(song(1,i)),'Rest')
         mySong=[mySong rest(dur(1,i),fs)];
      else
          ind=find(strcmp(song(1,i),notesArray));
          mySong=[mySong key(pitch(ind),dur(1,i),fs)];
      end
end
audiowrite('Scores/NewAudioSample.wav',mySong,fs);
clear dur fs i mySong pitch notesArray;

%% The functions for the notes and the rests

% The following functions are written from Yi-Wen Chen and are included in the MathWorks File Exchange
% Repository. The purpose of using that is to achieve a fade-in
% fade-out effect in combination with the audio wave creation, based on the
% sine waves (sinusoids).

function wave = key(p, n, fs)
t = 0:1/fs:4/n;
idx = 440*2^((p-49)/12);
mid = (t(1)+t(end))/2;
tri = -(abs(t-mid)-mid);
tri = tri./max(tri);
wave = (sin(2*pi*idx*t)).*tri;
end

function wave = rest(n,fs)
t = 0:1/fs:4/n;
tt = 4/n:-1/fs:0;
wave = 0*sin(2*pi*t).*exp(tt);
end
