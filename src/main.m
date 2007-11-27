addpath '../lib/netlab';

mfcc = load('/home/homerlan/Desktop/dev/aa.mfcc');
split_speech_silence ('aa.wav', get_silence_index (mfcc));