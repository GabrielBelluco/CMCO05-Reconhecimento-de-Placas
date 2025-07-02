function imagem_processada = preprocessamento(imagem)
    imagem_cinza = rgb2gray(imagem); 
    imagem_filtro = medfilt2(imagem_cinza); 
    limiar = graythresh(imagem_filtro); 
    imagem_binarizada = im2bw(imagem_filtro, limiar);
    imagem_invertida = imcomplement(imagem_binarizada); 
    imagem_processada = imagem_invertida;
end
