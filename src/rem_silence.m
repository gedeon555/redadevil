file = '/home/homerlan/Desktop/dev/aa.mfcc';
addpath '../lib/netlab';

mfcc = load(file);
g = gmm(1, 2, 'diag');

o = zeros(1, 16);
o(1) = 1;
o(14) = 20;

g = gmmem(g, mfcc(:, 16), o);
id_gauss_parole = find (g.centres == max(g.centres));
threshold = g.centres(id_gauss_parole) - 2 * g.covars(id_gauss_parole);

parole = mfcc(:, 16) < threshold;
index_parole = find(parole == 0);