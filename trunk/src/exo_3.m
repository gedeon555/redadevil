clear;

addpath '../lib/netlab';

% files tst
fichiers_apprentissage = ['bn'; 'bq'; 'cc'; 'ch'; 'ck'; 'cn'; 'cp'; 'cs'; 'cv'; 'da'; 'dc'; 'dg'; 'di'; 'dk'; 'dn'; 'dq'; 'dt'; 'dx'; 'dz'; 'eb'; 'ei'; 'em'; 'es'; 'ew'; 'fc'; 'fk'; 'fr'; 'fy'; 'bp'; 'cb'; 'cg'; 'cj'; 'cm'; 'co'; 'cq'; 'ct'; 'cx'; 'db'; 'de'; 'dh'; 'dj'; 'dl'; 'dp'; 'dr'; 'dv'; 'dy'; 'ea'; 'ee'; 'ej'; 'en'; 'ev'; 'ey'; 'ff'; 'fo'; 'ft'; 'fz'];

% files dev
%fichiers_apprentissage = ['aa'; 'ad'; 'ag'; 'aj'; 'am'; 'ap'; 'as'; 'av'; 'az'; 'bc'; 'bf'; 'bi'; 'bl'; 'br'; 'bv'; 'by'; 'cd'; 'cl'; 'cz'; 'ds'; 'ab'; 'ae'; 'ah'; 'ak'; 'an'; 'aq'; 'at'; 'ax'; 'ba'; 'bd'; 'bg'; 'bj'; 'bm'; 'bs'; 'bw'; 'bz'; 'cf'; 'cr'; 'dd'; 'ac'; 'af'; 'ai'; 'al'; 'ao'; 'ar'; 'au'; 'ay'; 'bb'; 'be'; 'bh'; 'bk'; 'bo'; 'bu'; 'bx'; 'ca'; 'ci'; 'cu'; 'dm'];

%for numero = 1:size(fichiers_apprentissage)
%    nom_du_fichier = fichiers_apprentissage(numero, :);
%    g = apprend_locuteur(['../data/dev/speech-' nom_du_fichier '.mfcc']);
%    save (['../data/dev/speech-' nom_du_fichier '.gmm'], 'g');
%end

for numero = 1:size(fichiers_apprentissage)
    nom_du_fichier = fichiers_apprentissage(numero, :);
    load ('-mat', ['../data/tst/speech-' nom_du_fichier '.gmm'], 'g');
    tab_g(numero) = g;
end

%for i = 1:size(tab_g, 2)
%    nom_du_fichier = fichiers_apprentissage(i, :);
%    mfccs = load(['../data/dev/speech-' nom_du_fichier '.mfcc']);
%    fprintf('%i...\n', i);
%    for j = 1:size(tab_g, 2)
%        mat(j,i) = sum(log((gmmprob(tab_g(j), mfccs))));
%    end
%    mat(i,i) = -100000000000;
%end
%save (['../data/dev/speech-matrix.mat'], 'mat');

load ('-mat', ['../data/tst/speech-matrix.mat'], 'mat');

for i = 1:size(tab_g, 2)
   res(i) = find (mat(:,i) == max(mat(:, i))); 
end

res

modif = true;
while modif
    modif = false;
    for i = 1:size(res, 2)
        if res(i) ~= res(res(i))
           modif = true; 
        end
        res(i) = res(res(i)); 
    end
end

for i = 1:size(res, 2)
   nom_du_fichier = fichiers_apprentissage(i, :);
   fprintf('%s => %i\n', nom_du_fichier, res(i));
end

%for numero = 1:size(fichiers_tests)
%    nom_du_fichier = fichiers_tests(numero, :);
%    mfccs = load(['../data/ntst_11/speech-' nom_du_fichier '.mfcc']);
%    for i=1:size(tab_g, 2)
%        result(numero, i) = sum(log((gmmprob(tab_g(i), mfccs))));
%    end
%    fprintf('%s => %s\n', nom_du_fichier, fichiers_apprentissage(find(result(numero,:) == max(result(numero, :))), :));
%end
