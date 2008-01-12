function g = apprend_locuteur (nom_de_fichier)
    %mfccs = load(nom_de_fichier);
    mfccs1 = load('../data/ntst_11/speech-sp01.mfcc');
    mfccs2 = load('../data/ntst_11/speech-sp02.mfcc');
    mfccs3 = load('../data/ntst_11/speech-sp03.mfcc');
    mfccs4 = load('../data/ntst_11/speech-sp04.mfcc');
    mfccs5 = load('../data/ntst_11/speech-sp05.mfcc');
    mfccs6 = load('../data/ntst_11/speech-sp06.mfcc');
    mfccs7 = load('../data/ntst_11/speech-sp07.mfcc');
    mfccs8 = load('../data/ntst_11/speech-sp08.mfcc');
    mfccs9 = load('../data/ntst_11/speech-sp08.mfcc');
    mfccs10 = load('../data/ntst_11/speech-sp10.mfcc');
    mfccs11 = load('../data/ntst_11/speech-sp11.mfcc');
    mfccs = [mfccs1;mfccs2;mfccs3;mfccs4;mfccs5;mfccs6;mfccs7;mfccs8;mfccs9;mfccs10;mfccs11];
    
    %[r, c, v] = find(mfccs == 0);
    %r
    %non_nuls = find(mfccs(:, 1) == 0 & mfccs(:, 2) == 0 &mfccs(:, 3) == 0 & mfccs(:, 4) == 0 & mfccs(:, 5) == 0 & mfccs(:, 6) == 0 & mfccs(:, 7) == 0 & mfccs(:, 8) == 0 & mfccs(:, 9) == 0 & mfccs(:, 10) == 0 & mfccs(:, 11) == 0 & mfccs(:, 12) == 0 & mfccs(:, 13) == 0 & mfccs(:, 14) == 0 & mfccs(:, 15) == 0);
    %non_nuls
    %mfccs_non_nuls = mfccs(non_nuls, 1:15);
    g = gmm(15, 255, 'diag');
    
    o = zeros(1, 16);
    o(1) = 1;
    o(14) = 20;
    g = gmminit(g, mfccs(:, 1:15), o);
    g = gmmem(g, mfccs(:, 1:15), o);
end