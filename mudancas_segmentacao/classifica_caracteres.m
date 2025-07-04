% src/classifica_caracteres.m
function rotulos = classifica_caracteres(caracteres)

    % 1) Defina seus símbolos e parâmetros
    symbols = ['0','1','2','3','4','5','6','7','9', ...
               'A','B','C','D','E','F','G','J','M','P','R','S','T','U','W'];
    nt = numel(symbols);
    H = 64; W = 32;
    T = zeros(nt, H*W);

    % 2) Carrega e prepara cada template (garante 2-D)
    for k = 1:nt
        lbl   = symbols(k);
        fname = [lbl, '.png'];
        if exist(fname,'file')~=2
            error('Faltando template: %s', fname);
        end
        img = imread(fname);

        % Se for RGB ou RGBA, converte a 2-D
      if ndims(img)==3
        img = img(:,:,1);    % pega só o canal vermelho (todos iguais em B&N)
         end
        img = im2double(img);
        lvl = graythresh(img);
        bw  = img >= lvl;

        % Agora bw tem dimensão H_orig×W_orig; redimensiona para  H×W
        bw = imresize(bw, [H W]);

        % Garante que é 2-D antes de vectorizar
        bw = squeeze(bw);
        T(k,:) = bw(:)';
    end

    % 3) Classifica cada patch extraído
    nChars = numel(caracteres);
    rotulos = cell(1,nChars);
    for i = 1:nChars
        c = caracteres{i};

        if ndims(c) > 2
            c = rgb2gray(c);
        end

        c = im2double(c);
        lvl = graythresh(c);
        bw  = c >= lvl;
        bw  = imresize(bw, [H W]);
        bw  = squeeze(bw);
        v   = bw(:)';

        D = sum((T - v).^2, 2);
        [dmin, idx] = min(D);

        rotulos{i} = symbols(idx);
        fprintf('  Caractere %d reconhecido como %s (dist=%.3f)\n', ...
                i, symbols(idx), dmin);
    end
end
