imagem_original = imread('placa5.png');
imagem_processada = preprocessamento(imagem_original);

bbox = segmenta_placa(imagem_processada, imagem_original);
placa_crop = imcrop(imagem_original, bbox);
imwrite(placa_crop, 'placa_segmentada_nova.jpg');

caracteres = segmenta_caracteres(placa_crop);

for i = 1:length(caracteres)
    figure;
    imshow(caracteres{i});
    title(['Caractere ', num2str(i)]);
end
