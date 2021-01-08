source recebeGrandezas.m
source sistemaLinear.m
source recebeApoios.m
source recebeCargaDist.m
source esforcoInterno.m
source singularidade.m
source alongamento.m
source torcao.m
source inclinacao.m
source grandeza.m
source tensao.m
source plotaSingularidade.m

clear
clc

viga = 0;
apoios = [];
cargas = [];
cargaPonto = [];
grandezas = [];

disp("Esse programa utiliza um sistema de coordenados orientado com a mao direita");
disp("Sendo que x eh o eixo horizontal, crescente para a direita. Y eh orientado para cima");
disp("Todas as unidades estao de acordo com o SI");
disp("A viga sempre deve estar paralela ao eixo X");
disp("Para calcular o angulo de torcao, qualquer viga sera considerada cilindrica");
disp("Viga deve estar na horizontal (eixo x)");
disp("");

xInicio = input("Qual o ponto de inicio da viga no eixo x?");
xFim = input("Qual o ponto de fim da viga no eixo x?");

areaSecao = input("Qual a area da secao transversal da viga?");
raioExterno = input("Qual o raio externo da viga?");
raioInterno = input("Qual o raio interno da viga (0 se a viga nao for vazada)?");

momentoX = input("Qual o momento de inercia da area em x?");
momentoY = input("Qual o momento de inercia da area em y?");

moduloElastico = input("Qual o modulo elastico da viga?");
moduloCisalhamento = input("Qual o modulo de cisalhamento da viga?");

momentoInerciaPolar = momentoX + momentoY;

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

variavelCalculada = [];

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

        variavelCalculada = [variavelCalculada, sistema.var(i)];

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

#analiseDeIntervalos(sistema, xInicio, xFim);

singularidade = [];

for i = 1:columns(grandezas)

    singularidade = [singularidade, converteGrandezaParaSingularidade(grandezas(i))];

endfor

for i = 1:columns(variavelCalculada)
    singularidade = [singularidade, converteVariavelParaSingularidade(variavelCalculada(i))];
endfor

for i = 1:columns(cargas)
    singularidade = [singularidade, converteCargaParaSingularidade(cargas(i))];
endfor

<<<<<<< HEAD
calculaInclinacao(singularidade, moduloElastico, momentoX, xFim);
calculaAlongamento(singularidade, areaSecao, moduloElastico, xFim);
calculaTorcao(singularidade, momentoInerciaPolar, moduloCisalhamento, xFim);

=======
forcaCortante = calculaInclinacao(singularidade, moduloElastico, momentoX, xFim);
forcaNormal = calculaAlongamento(singularidade, areaSecao, moduloElastico, xFim);
calculaTorcao(singularidade, momentoInerciaPolar, moduloCisalhamento, xFim);

tensaoNormal = calculaTensaoNormal(forcaNormal, areaSecao);
tensaoCisalhamento = calculaTensaoCisalhamento(forcaCortante, areaSecao, raioExterno, raioInterno);

plotaSingularidade(tensaoNormal, xFim, "Tensao normal", "Pa", 7);
plotaSingularidade(tensaoCisalhamento, xFim, "Tensao cisalhamento", "Pa", 8);
>>>>>>> 33c2c6cb5c6a78f902b7ff889bb721dcb5e410b2
