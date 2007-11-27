%DEMGMM1 Demonstrate density modelling with a Gaussian mixture model.
%
%	Description
%	The problem consists of modelling data generated by a mixture of
%	three Gaussians in 2 dimensions.  The priors are 0.3, 0.5 and 0.2;
%	the centres are (2, 3.5), (0, 0) and (0,2); the variances are 0.2,
%	0.5 and 1.0. The first figure contains a  scatter plot of the data.
%
%	A Gaussian mixture model with three components is trained using EM.
%	The parameter vector is printed before training and after training.
%	The user should press any key to continue at these points.  The
%	parameter vector consists of priors (the column), centres (given as
%	(x, y) pairs as the next two columns), and variances (the last
%	column).
%
%	The second figure is a 3 dimensional view of the density function,
%	while the third shows the 1-standard deviation circles for the three
%	components of the mixture model.
%
%	See also
%	GMM, GMMINIT, GMMEM, GMMPROB, GMMUNPAK
%

%	Copyright (c) Ian T Nabney (1996-2001)

% Generate the data
% Fix seeds for reproducible results
randn('state', 42);
rand('state', 42);

ndata = 500;
[data, datac, datap, datasd] = dem2ddat(ndata);

clc
disp('This demonstration illustrates the use of a Gaussian mixture model')
disp('to approximate the unconditional probability density of data in')
disp('a two-dimensional space.  We begin by generating the data from')
disp('a mixture of three Gaussians and plotting it.')
disp(' ')
disp('Press any key to continue')
pause

fh1 = figure;
plot(data(:, 1), data(:, 2), 'o')
set(gca, 'Box', 'on')
% Set up mixture model
ncentres = 3;
input_dim = 2;
mix = gmm(input_dim, ncentres, 'spherical');

options = foptions;
options(14) = 5;	% Just use 5 iterations of k-means in initialisation
% Initialise the model parameters from the data
mix = gmminit(mix, data, options);

clc
disp('The data is drawn from a mixture with parameters')
disp('    Priors        Centres         Variances')
disp([datap' datac (datasd.^2)'])
disp(' ')
disp('The mixture model has three components and spherical covariance')
disp('matrices.  The model parameters after initialisation using the')
disp('k-means algorithm are as follows')
% Print out model
disp('    Priors        Centres         Variances')
disp([mix.priors' mix.centres mix.covars'])
disp('Press any key to continue')
pause

% Set up vector of options for EM trainer
options = zeros(1, 18);
options(1)  = 1;		% Prints out error values.
options(14) = 10;		% Max. Number of iterations.

disp('We now train the model using the EM algorithm for 10 iterations')
disp(' ')
disp('Press any key to continue')
pause
[mix, options, errlog] = gmmem(mix, data, options);

% Print out model
disp(' ')
disp('The trained model has parameters ')
disp('    Priors        Centres         Variances')
disp([mix.priors' mix.centres mix.covars'])
disp('Note the close correspondence between these parameters and those')
disp('of the distribution used to generate the data, which are repeated here.')
disp('    Priors        Centres         Variances')
disp([datap' datac (datasd.^2)'])
disp(' ')
disp('Press any key to continue')
pause

clc
disp('We now plot the density given by the mixture model as a surface plot')
disp(' ')
disp('Press any key to continue')
pause
% Plot the result
x = -4.0:0.2:5.0;
y = -4.0:0.2:5.0;
[X, Y] = meshgrid(x,y);
X = X(:);
Y = Y(:);
grid = [X Y];
Z = gmmprob(mix, grid);
Z = reshape(Z, length(x), length(y));
c = mesh(x, y, Z);
hold on
title('Surface plot of probability density')
hold off

clc
disp('The final plot shows the centres and widths, given by one standard')
disp('deviation, of the three components of the mixture model.')
disp(' ')
disp('Press any key to continue.')
pause
% Try to calculate a sensible position for the second figure, below the first
fig1_pos = get(fh1, 'Position');
fig2_pos = fig1_pos;
fig2_pos(2) = fig2_pos(2) - fig1_pos(4);
fh2 = figure;
set(fh2, 'Position', fig2_pos)

hp1 = plot(data(:, 1), data(:, 2), 'bo');
axis('equal');
hold on
hp2 = plot(mix.centres(:, 1), mix.centres(:,2), 'g+');
set(hp2, 'MarkerSize', 10);
set(hp2, 'LineWidth', 3);

title('Plot of data and mixture centres')
angles = 0:pi/30:2*pi;
for i = 1 : mix.ncentres
  x_circle = mix.centres(i,1)*ones(1, length(angles)) + ...
    sqrt(mix.covars(i))*cos(angles);
  y_circle = mix.centres(i,2)*ones(1, length(angles)) + ...
    sqrt(mix.covars(i))*sin(angles);
  plot(x_circle, y_circle, 'r')
end
hold off
disp('Note how the data cluster positions and widths are captured by')
disp('the mixture model.')
disp(' ')
disp('Press any key to end.')
pause

close(fh1);
close(fh2);
clear all; 

