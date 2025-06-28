% main.m - Script principal de execução
clear; clc;

% Pré-processamento da imagem
g_eq = preprocessamento("../imagens/card1.jpg");

% Segmentação da placa
placa = segmenta_placa(g_eq);

% Exibir resultado
if isempty(placa)
    disp("Nenhuma placa encontrada.");
else
    figure, imshow(placa), title("Placa Segmentada");
end
