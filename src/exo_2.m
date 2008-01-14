addpath '../lib/netlab';
%addpath '../lib/gmmbayestb-v1.0'
%addpath '../lib/stats/gmdistribution'

fichiers_apprentissage = ['sp02'; 'sp05'; 'sp08'; 'sp11'; 'sp03'; 'sp06'; 'sp09'; 'sp01'; 'sp04'; 'sp07'; 'sp10'];

for numero = 1:size(fichiers_apprentissage)
    nom_du_fichier = fichiers_apprentissage(numero, :);
    g = apprend_locuteur(['../data/ntst_11/speech-' nom_du_fichier '.mfcc']);
    save (['../data/ntst_11/speech-' nom_du_fichier '.gmm'], 'g');
end


for numero = 1:size(fichiers_apprentissage)
    nom_du_fichier = fichiers_apprentissage(numero, :);
    load ('-mat', ['../data/ntst_11/speech-' nom_du_fichier '.gmm'], 'g');
    tab_g(numero) = g;
end

fichiers_tests = ['cw'; 'ed'; 'eh'; 'eo'; 'er'; 'fd'; 'fh'; 'fl'; 'fp'; 'fu'; 'fx'; 'gc'; 'gf'; 'gi'; 'gl'; 'go'; 
        'du'; 'ef'; 'ek'; 'ep'; 'ex'; 'fe'; 'fi'; 'fm'; 'fq'; 'fv'; 'ga'; 'gd'; 'gg'; 'gj'; 'gm'; 'gp'; 
        'dw'; 'eg'; 'el'; 'eq'; 'ez'; 'fg'; 'fj'; 'fn'; 'fs'; 'fw'; 'gb'; 'ge'; 'gh'; 'gk'; 'gn'];


for numero = 1:size(fichiers_tests)
    nom_du_fichier = fichiers_tests(numero, :);
    %fprintf('%s...\n', nom_du_fichier);
    mfccs = load(['../data/ntst_11/speech-' nom_du_fichier '.mfcc']);
    for i=1:size(tab_g, 2)
        %fprintf('%i .. ', i);
        result(numero, i) = sum(log((gmmprob(tab_g(i), mfccs))));
    end
    %fprintf('\n');
    fprintf('%s => %s\n', nom_du_fichier, fichiers_apprentissage(find(result(numero,:) == max(result(numero, :))), :));
end
