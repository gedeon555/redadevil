%addpath '../lib/netlab';


wav = wavread('speech-aa.wav');
winsize = 80;

size_titi = size(wav, 1);
wav_fft = zeros(floor(winsize / 2), ceil(size(wav, 1) / winsize));
for i = 1 : winsize : size(wav, 1) - winsize
   tmp_fft = abs(fft(wav(i : i + winsize - 1)));
   wav_fft(:, floor(i / winsize) + 1) = tmp_fft(1 : winsize / 2);
end

%plot(1:4000/40:4000, wav_fft(:, 1));

fprintf('Computing pitch...\n');
get_auto_corr_pitch(wav_fft);

%[f0_time,f0_value,SHR,f0_candidates] = shrp(wav, 8000);

%mfcc = load('/home/homerlan/Desktop/dev/aa.mfcc');
%split_speech_silence ('aa.wav', get_silence_index (mfcc));