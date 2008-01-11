addpath '../lib/netlab';

dir = '/home/homerlan/Desktop/Reda/redadevil';
filename = [dir '/data/dev-pitch.txt'];
data = load(filename);

% 1 = female
% 0 = male

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

sigma_female = sqrt(g.covars);
mu_female = g.centres;
sigma_male = sqrt(h.covars);
mu_male = h.centres;

threshold = ((mu_female - sigma_female * 2) + (mu_male + sigma_male * 2)) / 2;

errors = 0;
total = 0;

filename = [dir '/data/tst-pitch.txt'];
data = load(filename);
for i=1:size(data)
    if data(i) <= threshold
        fprintf('%i Male = %i\n', i, round(data(i) - threshold));
    else
        fprintf('%i Female = %i\n', i, round(data(i) - threshold)); 
    end
end

%x = 0:1:400;
%plot(x, gaussmf(x, [ sqrt(g.covars) g.centres ]));
%hold on;
%plot(gaussmf(x, [ sqrt(h.covars) h.centres ]));