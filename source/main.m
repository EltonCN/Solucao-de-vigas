source recebeGrandezas.m
source sistemaLinear.m
source recebeApoios.m
source recebeCargaDist.m
source esforcoInterno.m

clear
clc

viga = 0;
apoios = [];
cargas = [];
cargaPonto = [];
grandezas = [];

disp("Esse programa utiliza um sistema de coordenados orientado com a mao direita");
disp("Sendo que x eh o eixo horizontal, crescente para a direita. Y eh orientado para cima");
disp("");
disp("");

xInicio = input("Qual o ponto de inicio da viga no eixo x?");
xFim = input("Qual o ponto de fim da viga no eixo x?");

grandezas = recebeGrandezas();
apoios = recebeApoios();
cargas = recebeCargaDistUsuario();


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

sistema = solve(sistema);

disp("");
disp("");
disp("");

if(sistema.calculado == false)
    disp("Seu sistema nao pode ser resolvido");
else
    for i= 1:columns(sistema.var)
        zero = true;
        for j = 1:6
            if(sistema.var(i).coeficiente(j) != 0)
                zero = false;
            endif
        endfor

        if(zero)
            continue;
        endif

        disp("A variavel "); 
        disp(sistema.var(i).nome);
        disp("possui magnitude ");
        disp(sistema.var(i).magnitude);
        disp("");
    endfor
endif

disp("");
disp("");
disp("");

analiseDeIntervalos(sistema, xInicio, xFim);
