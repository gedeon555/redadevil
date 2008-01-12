addpath '../lib/netlab';

dir = '/home/homerlan/Desktop/Reda/redadevil';
filename = [dir '/data/dev-pitch.txt'];
data = load(filename);

% 1 = female
% 0 = male

data_female = data(find(data(:, 2) == 1));
data_male = data(find(data(:, 2) == 0));

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
    %proba_male = gaussmf(data(i), [ sqrt(h.covars) h.centres ]);
    %proba_female = gaussmf(data(i), [ sqrt(g.covars) g.centres ]);
    
    if data(i) <= threshold
        fprintf('%i Male = %i\n', i, round(data(i) - threshold));
    else
        fprintf('%i Female = %i\n', i, round(data(i) - threshold)); 
    end
end

% Test on dev base
%for i=1:size(data, 1)
%    proba_male = gaussmf(data(i, 1), [ sqrt(h.covars) h.centres ]);
%    proba_female = gaussmf(data(i, 1), [ sqrt(g.covars) g.centres ]);
%    
%    %if data(i, 1) <= threshold
%    if proba_male > proba_female
%        fprintf('%i Male == %i (%i)\n', i, data(i, 2), round(data(i, 1) - threshold));
%        if data(i, 2) == 1
%           errors = errors + 1; 
%        end
%    else
%        fprintf('%i Female == %i (%i)\n', i, data(i, 2), round(data(i, 1) - threshold));
%        if data(i, 2) == 0
%           errors = errors + 1; 
%        end
%    end
%    total = total + 1;
%end
%fprintf('Errors: %i/%i (%i percents)\n', errors, total, round (100 * errors / total));

%x = 0:1:400;
%plot(x, gaussmf(x, [ sqrt(g.covars) g.centres ]));
%hold on;
%plot(gaussmf(x, [ sqrt(h.covars) h.centres ]));