% src/extrai_caracteristicas.m

function feats = extrai_caracteristicas(im_char)

    % 1) Redimensionar para tamanho fixo (32×32)
    im_resized = imresize(im_char, [64 32]);

    % 2) Converter para double
    im_double = im2double(im_resized);

    % 3) Achatar pixels em vetor linha
    feats = im_double(:)';
end
