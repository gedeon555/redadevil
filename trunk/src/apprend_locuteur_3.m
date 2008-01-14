function g = apprend_locuteur (nom_de_fichier)
    mfccs = load(nom_de_fichier);
    g = gmmb_em(mfccs, 'init', 'fcm1', 'components', 16, 'verbose', true); 
end