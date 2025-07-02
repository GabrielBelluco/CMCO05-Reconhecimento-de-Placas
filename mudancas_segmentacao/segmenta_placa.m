function bbox_final = segmenta_placa(imagem_processada, imagem_original)
    imagem_cinza = rgb2gray(imagem_original);
    imagem_eq = histeq(imagem_cinza);
    imagem_suave = medfilt2(imagem_eq);

    limiar = graythresh(imagem_suave);
    imagem_bin = im2bw(imagem_suave, limiar);
    imagem_inv = imcomplement(imagem_bin);

    se = strel('rectangle', [5 15]);  
    imagem_morf = imclose(imagem_inv, se);

    labeled = bwlabel(imagem_morf);
    stats = regionprops(labeled, 'BoundingBox', 'Area');

    candidatos = [];
    for i = 1:length(stats)
        bbox = stats(i).BoundingBox;
        largura = bbox(3);
        altura = bbox(4);
        proporcao = largura / altura;

        if proporcao > 1.5 && proporcao < 7 && stats(i).Area > 500
            candidatos = [candidatos; bbox];
        end
    end

    if isempty(candidatos)
        error('Nenhuma placa candidata encontrada com os critérios ajustados.');
    end

    areas = candidatos(:,3) .* candidatos(:,4);
    [~, idx] = max(areas);
    bbox_final = candidatos(idx, :);

    % debug opcional
    imshow(imagem_original);
    hold on;
    for i = 1:size(candidatos, 1)
        cor = 'g';
        if i == idx
            cor = 'r';
        end
        rectangle('Position', candidatos(i,:), 'EdgeColor', cor, 'LineWidth', 2);
    end
    hold off;
end
