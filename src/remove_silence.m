
wav = wavread('../data/dev_wav/aa.sph.wav');

frame_size = 256;

%test = zeros(2, 3);
%test
%test(1, :)

wav_split = zeros(size(wav) / 256,256);
for i = 1:256:size(wav)
   wav_split(floor(i / 256) + 1, :) = wav(i:i + 256 - 1);
end

fprintf('1\n');

wav_energy = zeros(1, size(wav_split));
new_wav = zeros(size(wav), 1);
j = 1;
for i = 1:size(wav_split) - 256
   v1 = std(wav_split(i, :));
   wav_energy(i) = v1 ^ 2;
   if v1 ^ 2 > 0
       %wav_split(i, :)
       new_wav((j - 1) * 256 + 1:j * 256) = wav_split(i, :);
       %new_wav((j - 1) * 256 + 1:j * 256)
       j = j + 1;
   end
end

size(wav_split)
j
wavwrite(new_wav, 'test.wav');


