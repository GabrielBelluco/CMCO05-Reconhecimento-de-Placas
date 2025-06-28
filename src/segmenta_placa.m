function placa = segmenta_placa(im_gray)
    % Detecta bordas e segmenta placa baseada na razão largura/altura
    edges = edge(im_gray, "canny");
    se = strel("rectangle", [10 25]);
    dilatada = imdilate(edges, se);
    fechada = imclose(dilatada, se);

    labeled = bwlabel(fechada);
    stats = regionprops(labeled, 'BoundingBox', 'Area');

    for i = 1:length(stats)
        box = stats(i).BoundingBox;
        ar = box(3) / box(4);
        if ar > 2 && ar < 5
            placa = imcrop(im_gray, box);
            imwrite(placa, "../resultados/placa.jpg");
            return;
        end
    end

    placa = [];
end
