function index_silence = get_silence_index (v_mfcc)

    g = gmm(1, 2, 'diag');

    o = zeros(1, 16);
    o(1) = 1;
    o(14) = 20;

    g = gmmem(g, v_mfcc(:, 16), o);
    id_gauss_parole = find (g.centres == max(g.centres));
    threshold = g.centres(id_gauss_parole) - 2 * g.covars(id_gauss_parole);

    parole = v_mfcc(:, 16) < threshold;
    index_silence = find(parole == 1);
    
end