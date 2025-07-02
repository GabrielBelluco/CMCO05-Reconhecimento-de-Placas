function caracteres = segmenta_caracteres(imagem_placa)

    imagem_cinza = rgb2gray(imagem_placa);
    imagem_filtro = medfilt2(imagem_cinza);

    % Binarização adaptativa com fallback
    limiar = graythresh(imagem_filtro);
    imagem_bin = im2bw(imagem_filtro, limiar);

    % Fallback se binarização automática falhar (imagem muito escura/clara)
    if sum(imagem_bin(:)) < 0.01 * numel(imagem_bin)
        fprintf('Limiar automático falhou. Usando valor fixo 0.5\n');
        imagem_bin = im2bw(imagem_filtro, 0.5);
    end

    imagem_inv = imcomplement(imagem_bin);

    % Encontra componentes conectados (potenciais caracteres)
    labeled = bwlabel(imagem_inv);
    stats = regionprops(labeled, 'BoundingBox', 'Area');

    caracteres = {};  % lista de imagens de caracteres

    for i = 1:length(stats)
        bbox = stats(i).BoundingBox;
        largura = bbox(3);
        altura = bbox(4);
        proporcao = altura / largura;

        % Filtros ajustados para ignorar letras decorativas (ex: "UF", "BR")
        if proporcao > 1 && proporcao < 5 && stats(i).Area > 300
            caractere = imcrop(imagem_inv, bbox);
            caracteres{end+1} = caractere;
        end
    end

    % Ordenar caracteres da esquerda para a direita (por posição X)
