function g = apprend_locuteur (nom_de_fichier)
    mfccs = load(nom_de_fichier);
    g = gmm(16, 32, 'diag');
    o = zeros(1, 16);
    o(1) = 1;
    o(14) = 20;
    o(5) = 1;
    g = gmminit(g, mfccs, o);
    g = gmmem(g, mfccs, o);
end