function g = apprend_locuteur2 (nom_de_fichier)
    mfccs = load(nom_de_fichier);
    options = statset('Display', 'iter');
    g = gmdistribution.fit(mfccs, 64, 'Options', options);
end