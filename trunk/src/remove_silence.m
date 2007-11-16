clear
FS = 256;
dir_in = '../data/dev_wav';
dir_out = '../data/dev_wav_without_silence';

list = ls([dir_in '/aa.sph.wav']);

for num_file = 1:size(list)

    file = list(num_file, :);
    fprintf('Traitement du fichier : %s\n', file);
    wav = wavread([dir_in '/' file]);
    wav_split = zeros(floor(size(wav, 1) / FS) + 1, FS);
    for i = 1 : FS : size(wav, 1)
        if i + FS > size(wav)
            wav_split(floor(i / FS) + 1, 1 : size(wav(i : end), 1)) = wav(i : end);
        else
            wav_split(floor(i / FS) + 1, :) = wav(i : i + FS - 1);
        end
    end
    fprintf('Splitage terminé\n');

    fprintf('Calcul de l''énergie');
    wav_energy = zeros(1, size(wav_split, 1));
    for i = 1 : size(wav_split) - FS
        v1 = std(wav_split(i, :));
        wav_energy(i) = v1 * v1;
    end
    wav_energy = log(wav_energy + 0.00001);
    
    save('wav_energy_3.txt', 'wav_energy');
    
    [a2, b2] = gmmb_em(wav_energy', 'components', 2, 'maxloops', 1000);
    [a3, b3] = gmmb_em(wav_energy', 'components', 3, 'maxloops', 1000);
    fprintf('Avec deux gaussienne : lh = %f, nb_iter = %f\n', b2(3), b2(2));
    fprintf('Avec trois gaussienne : lh = %f, nb_iter = %f\n', b3(3), b3(2));
    if abs(b3(3)) < abs(b2(3))
        a = a3;
        g = [1 2 3];
        if a.mu(g(2)) > a.mu(g(1))
            tmp = g(2);
            g(2) = g(1);
            g(1) = tmp;
        end
        if a.mu(g(3)) > a.mu(g(1))
            tmp = g(3);
            g(3) = g(1);
            g(1) = tmp;
        end
        if a.mu(g(3)) > a.mu(g(2))
            tmp = g(3);
            g(3) = g(2);
            g(2) = tmp;
        end
    else
        a = a2;
        g = [1 2 3];
        if a.mu(g(2)) > a.mu(g(1))
            tmp = g(2);
            g(2) = g(1);
            g(1) = tmp;
        end
    end

    X = a.mu(g(2)):0.01:a.mu(g(1));    
    plot(X, exp(-(X - a.mu(g(2))).^2/(2*a.sigma(:,:,g(2))^2)));
    hold all
    plot(X, exp(-(X - a.mu(g(1))).^2/(2*a.sigma(:,:,g(1))^2)));
    if size(a.mu, 2) == 3
        fprintf('Trois gaussiennes sélectionné\n');
        plot(X, exp(-(X - a.mu(g(3))).^2/(2*a.sigma(:,:,g(3))^2)));
    end
    hold off;
    %GMM = exp(-(X - a.mu(2)).^2/(2*a.sigma(:,:,2)^2)) + exp(-(X - a.mu(1)).^2/(2*a.sigma(:,:,1)^2));
    %seuil = min(GMM);
    seuil = 1;
    
    plot(wav_energy);
    
    j = 1;
    j2 = 1;
    new_wav = zeros(size(wav, 1), 1);
    new_wav_2 = zeros(size(wav, 1), 1);
    for i = 1 : size(wav_split) - FS
        if wav_energy(i) > seuil %a.mu(g(1)) - 3 * a.sigma(:,:,g(1)) && wav_energy(i) < a.mu(g(1)) + 3 * a.sigma(:,:,g(1))
        %if gaussmf(wav_energy(i), [ a.sigma(:,:,g(1)) a.mu(g(1)) ]) > gaussmf(wav_energy(i), [ a.sigma(:,:,g(3)) a.mu(g(3)) ])
            %if gaussmf(wav_energy(i), [ a.sigma(:,:,g(1)) a.mu(g(1)) ]) > gaussmf(wav_energy(i), [ a.sigma(:,:,g(2)) a.mu(g(2)) ])
            new_wav((j - 1) * FS + 1 : j * FS) = wav_split(i, :);
            j = j + 1;
        %end
            %end
        %end
        else
        %if gaussmf(wav_energy(i), [ a.sigma(:,:,g(2)) a.mu(g(2)) ]) > gaussmf(wav_energy(i), [ a.sigma(:,:,g(1)) a.mu(g(1)) ])
            %if gaussmf(wav_energy(i), [ a.sigma(:,:,g(1)) a.mu(g(1)) ]) > gaussmf(wav_energy(i), [ a.sigma(:,:,g(3)) a.mu(g(3)) ])
            %if gaussmf(wav_energy(i), [ a.sigma(:,:,g(1)) a.mu(g(1)) ]) > gaussmf(wav_energy(i), [ a.sigma(:,:,g(2)) a.mu(g(2)) ])
            new_wav_2((j2 - 1) * FS + 1 : j2 * FS) = wav_split(i, :);
            j2 = j2 + 1;
        end
    end

    wavwrite(new_wav(1 : j * FS), [dir_out '/' file])
    wavwrite(new_wav_2(1 : j2 * FS), [dir_out '/' file '2.wav'])
    
    clear('new_wav');
    clear('wav_split');
    clear('wav');
end


%k = 2; d = 1; c = 2; e = 10;
%X = wav_energy(1:floor(size(wav_energy, 2)/2))';
%size(X)
%T = wav_energy(floor(size(wav_energy, 2)/2) : end)';
%fprintf('Running 10 times normal EM with k-means initialization\n');
%normal_em=[];
%for i=1:10
%  [W,M,R,Tlogl] = gmmbvl_em(X,T,k,0,0,0);
%  normal_em = [normal_em Tlogl];

%end
%fprintf('Average log-likelihood %f with std. dev. %f best run: %f \n',mean(normal_em),std(normal_em), max(normal_em));
%size(normal_em)
%     max_k = 10;
%fprintf('Running greedy EM\n');
%[W,M,R,Tlogl] = gmmbvl_em(X,T,max_k,10,1,0);
%title('Mixture model');


%figure(2); clf;plot(Tlogl,'-o');hold on;
%xlabel 'number of components'
%ylabel 'log-likelihood of test set'
%plot(repmat(mean(normal_em),max_k,1),'r')
%plot(repmat(mean(normal_em)+std(normal_em),max_k,1),'r--')
%plot(repmat(max(normal_em),max_k,1),'g')
%plot(repmat(mean(normal_em)-std(normal_em),max_k,1),'r--')

%[Tlogl,best_k] = max(Tlogl);
%fprintf('Best number of components according to cross-validation: %d (yielding log-likelihood %f ) \n',best_k,Tlogl);


%legend('Greedy EM','mean of normal EM', 'one standard deviation margins of normal EM','best result of normal EM',4);
%title('Log-likelihood plots');

