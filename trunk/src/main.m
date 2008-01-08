addpath '../lib/netlab';

files = ['aa'; 'ad'; 'ag'; 'aj'; 'am'; 'ap'; 'as'; 'av'; 'az'; 'bc'; 'bf'; 'bi'; 'bl'; 'br'; 'bv'; 'by'; 'cd'; 'cl'; 'cz'; 'ds'; 'ab'; 'ae'; 'ah'; 'ak'; 'an'; 'aq'; 'at'; 'ax'; 'ba'; 'bd'; 'bg'; 'bj'; 'bm'; 'bs'; 'bw'; 'bz'; 'cf'; 'cr'; 'dd'; 'ac'; 'af'; 'ai'; 'al'; 'ao'; 'ar'; 'au'; 'ay'; 'bb'; 'be'; 'bh'; 'bk'; 'bo'; 'bu'; 'bx'; 'ca'; 'ci'; 'cu'; 'dm'];

for num_file = 1:size(files)
    filename = files(num_file, :);
    fprintf('Processing %s...\n', filename);
    mfcc = load(['/home/homerlan/Desktop/Reda/dev/' filename '.mfcc']);
    split_speech_silence ([filename '.wav'], get_silence_index (mfcc));    
end