function g_eq = preprocessamento(im_path)
    % Carrega, converte para escala de cinza, filtra e equaliza histograma
    im = imread(im_path);
    g = rgb2gray(im);
    g = im2double(g);
    g = medfilt2(g, [3 3]);     % Filtro de mediana
    g_eq = histeq(g);           % Equalização de histograma
    imwrite(g_eq, "../resultados/preprocessada.jpg");
end
