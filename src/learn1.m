addpath '../lib/netlab';

dir = '/home/homerlan/Desktop/Reda/redadevil';
filename = [dir '/data/dev-pitch.txt'];
data = load(filename);

data_female = data(find(data(:, 2) == 1))
data_male = data(find(data(:, 2) == 0))

g = gmm(1, 1, 'diag');
h = gmm(1, 1, 'diag');

o = zeros(1, 16);
o(1) = 1;
o(14) = 100;

g = gmminit(g, data_female, o);
g = gmmem(g, data_female, o);

h = gmminit(h, data_male, o);
h = gmmem(h, data_male, o);

x = 80:1:400;
plot(x, gaussmf(x, [ sqrt(g.covars) g.centres ]));
hold on;
plot(gaussmf(x, [ sqrt(h.covars) h.centres ]));