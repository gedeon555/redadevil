function split_speech_silence (file_wav, index_silence)

    wav_file = wavread(['../data/ntst_11/' file_wav]);
    wav_file_tmp = wav_file;
    for i = 1:size(index_silence)
        begin = 80 * (index_silence(i) - 1) + 1;
        wav_file_tmp(begin:begin + 80) = Inf;
    end

    fprintf('%s\n', file_wav);
    wavwrite(wav_file(find(wav_file_tmp ~= Inf)), 8000, 8, ['../data/ntst_11/speech-' file_wav]);
    %wavwrite(wav_file(find(wav_file_tmp == Inf)), 8000, 8, ['/home/homerlan/Desktop/Reda/dev/silence-' file_wav]);
    
end