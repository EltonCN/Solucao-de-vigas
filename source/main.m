source recebeGrandezas.m
source sistemaLinear.m
source recebeApoios.m
source recebeCargaDist.m

clear
clc

viga = 0;
apoios = [];
cargas = [];
cargaPonto = [];
grandezas = [];

disp("Esse programa utiliza um sistema de coordenados orientado com a mão direita")
disp("Sendo que x é o eixo horizontal, crescente para a direita. Y é orientado para cima")

grandezas = recebeGrandezas();
apoios = recebeApoios();
cargas = recebeCargaDist();


sistema = novoSistema(0,0);

for i = 1:columns(grandezas)
    sistema = recebeGrandeza(sistema, grandezas(i));
endfor

for i = 1:columns(apoios)
    variaveis = getVariavel(apoios(i));

    for j = 1:columns(variaveis)
        sistema = recebeVariavel(sistema, variaveis(j));
    endfor
endfor

for i = 1:columns(cargas)
    sistema = recebeCargaDist(sistema, cargas(i));
endfor

sistema = solve(sistema)

