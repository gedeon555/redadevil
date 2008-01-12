addpath '../lib/netlab';

% dev files
%files = ['aa'; 'ad'; 'ag'; 'aj'; 'am'; 'ap'; 'as'; 'av'; 'az'; 'bc'; 'bf'; 'bi'; 'bl'; 'br'; 'bv'; 'by'; 'cd'; 'cl'; 'cz'; 'ds'; 'ab'; 'ae'; 'ah'; 'ak'; 'an'; 'aq'; 'at'; 'ax'; 'ba'; 'bd'; 'bg'; 'bj'; 'bm'; 'bs'; 'bw'; 'bz'; 'cf'; 'cr'; 'dd'; 'ac'; 'af'; 'ai'; 'al'; 'ao'; 'ar'; 'au'; 'ay'; 'bb'; 'be'; 'bh'; 'bk'; 'bo'; 'bu'; 'bx'; 'ca'; 'ci'; 'cu'; 'dm'];

% ntst_11 files
%files = ['cw'; 'ed'; 'eh'; 'eo'; 'er'; 'fd'; 'fh'; 'fl'; 'fp'; 'fu'; 'fx'; 'gc'; 'gf'; 'gi'; 'gl'; 'go'; 
%        'du'; 'ef'; 'ek'; 'ep'; 'ex'; 'fe'; 'fi'; 'fm'; 'fq'; 'fv'; 'ga'; 'gd'; 'gg'; 'gj'; 'gm'; 'gp'; 
%        'dw'; 'eg'; 'el'; 'eq'; 'ez'; 'fg'; 'fj'; 'fn'; 'fs'; 'fw'; 'gb'; 'ge'; 'gh'; 'gk'; 'gn'];
files = ['sp02'; 'sp05'; 'sp08'; 'sp11'; 'sp03'; 'sp06'; 'sp09'; 'sp01'; 'sp04'; 'sp07'; 'sp10'];

% tst files
% files = ['bn'; 'bq'; 'cc'; 'ch'; 'ck'; 'cn'; 'cp'; 'cs'; 'cv'; 'da'; 'dc'; 'dg'; 'di'; 'dk'; 'dn'; 'dq'; 'dt'; 'dx'; 'dz'; 'eb'; 'ei'; 'em'; 'es'; 'ew'; 'fc'; 'fk'; 'fr'; 'fy'; 'bp'; 'cb'; 'cg'; 'cj'; 'cm'; 'co'; 'cq'; 'ct'; 'cx'; 'db'; 'de'; 'dh'; 'dj'; 'dl'; 'dp'; 'dr'; 'dv'; 'dy'; 'ea'; 'ee'; 'ej'; 'en'; 'ev'; 'ey'; 'ff'; 'fo'; 'ft'; 'fz'];
        
for num_file = 1:size(files)
    filename = files(num_file, :);
    fprintf('Processing %s...\n', filename);
    mfcc = load(['../data/ntst_11/' filename '.mfcc']);
    split_speech_silence ([filename '.wav'], get_silence_index (mfcc));    
end