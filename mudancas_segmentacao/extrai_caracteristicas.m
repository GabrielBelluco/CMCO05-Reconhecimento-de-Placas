
function feats = extrai_caracteristicas(im_char)

    im_resized = imresize(im_char, [64 32]);

    im_double = im2double(im_resized);

    feats = im_double(:)';
end
