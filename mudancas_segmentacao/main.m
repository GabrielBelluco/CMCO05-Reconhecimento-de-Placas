% main.m
imagem_original = imread('placa.jpg');
imagem_processada = preprocessamento(imagem_original);
bbox  = segmenta_placa(imagem_processada, imagem_original);
placa_crop = imcrop(imagem_original, bbox); imwrite(placa_crop,'placa_segmentada_nova.jpg');
caracteres = segmenta_caracteres(placa_crop);

for i = 1:length(caracteres)
    fprintf("Agora exibindo o Caractere %d\n", i);
    figure; imshow(caracteres{i}); drawnow;
    char_resized = imresize(caracteres{i}, [64 32]);
    figure; imshow(char_resized); drawnow;
    feats = extrai_caracteristicas(caracteres{i});
    fprintf("Caractere %d: vetor de características com %d elementos\n", i, numel(feats));
end

rotulos = classifica_caracteres(caracteres);
placa   = strjoin(rotulos,'');
fprintf("Placa reconhecida: %s\n", placa);
