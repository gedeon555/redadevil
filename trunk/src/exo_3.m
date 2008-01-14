addpath '../lib/netlab';

fichiers_apprentissage = ['bn'; 'bq'; 'cc'; 'ch'; 'ck'; 'cn'; 'cp'; 'cs'; 'cv'; 'da'; 'dc'; 'dg'; 'di'; 'dk'; 'dn'; 'dq'; 'dt'; 'dx'; 'dz'; 'eb'; 'ei'; 'em'; 'es'; 'ew'; 'fc'; 'fk'; 'fr'; 'fy'; 'bp'; 'cb'; 'cg'; 'cj'; 'cm'; 'co'; 'cq'; 'ct'; 'cx'; 'db'; 'de'; 'dh'; 'dj'; 'dl'; 'dp'; 'dr'; 'dv'; 'dy'; 'ea'; 'ee'; 'ej'; 'en'; 'ev'; 'ey'; 'ff'; 'fo'; 'ft'; 'fz'];

for numero = 1:size(fichiers_apprentissage)
    nom_du_fichier = fichiers_apprentissage(numero, :);
    g = apprend_locuteur(['../data/tst/speech-' nom_du_fichier '.mfcc']);
    save (['../data/tst/speech-' nom_du_fichier '.gmm'], 'g');
end


for numero = 1:size(fichiers_apprentissage)
    nom_du_fichier = fichiers_apprentissage(numero, :);
    load ('-mat', ['../data/tst/speech-' nom_du_fichier '.gmm'], 'g');
    tab_g(numero) = g;
end

%for numero = 1:size(fichiers_tests)
%    nom_du_fichier = fichiers_tests(numero, :);
%    mfccs = load(['../data/ntst_11/speech-' nom_du_fichier '.mfcc']);
%    for i=1:size(tab_g, 2)
%        result(numero, i) = sum(log((gmmprob(tab_g(i), mfccs))));
%    end
%    fprintf('%s => %s\n', nom_du_fichier, fichiers_apprentissage(find(result(numero,:) == max(result(numero, :))), :));
%end
