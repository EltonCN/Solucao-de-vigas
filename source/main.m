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
momentoInercia = input("Qual o momento de inercia?");


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


forcaCortante = calculaInclinacao(singularidade, moduloElastico, momentoX, xFim);
forcaNormal = calculaAlongamento(singularidade, areaSecao, moduloElastico, xFim);
calculaTorcao(singularidade, momentoInerciaPolar, moduloCisalhamento, xFim);

tensaoNormal = calculaTensaoNormal(forcaNormal, areaSecao); #sempre igual
tensaoCisalhamento = calculaTensaoCisalhamento(forcaCortante, areaSecao, raioExterno, raioInterno); #maxima 
momento = calculaMomentoInterno(forcaCortante);
tensaoNormalFlexao = calculaTensaoNormalFlexao(momento, momentoInercia, raioExterno); #y maximo positivo
tensaoCisalhamentoTorque = calculaTensaoCisalhamentoTorque(singularidade, raioExterno, momentoInerciaPolar) #Positiva

plotaSingularidade(tensaoNormal, xFim, "Tensao normal", "Pa", 7);
plotaSingularidade(tensaoNormalFlexao, xFim, "Tensao normal de flexao", "Pa", 8);
plotaSingularidade(tensaoCisalhamento, xFim, "Tensao de cisalhamento", "Pa", 9);
plotaSingularidade(tensaoCisalhamentoTorque, xFim, "Tensao de cisalhamento por torque", "Pa", 10);

[tensaoNormalResultanteA, tensaoCisalhamentoResultanteA] = calculaTensaoResultante(tensaoNormal, tensaoCisalhamento, tensaoNormalFlexao, tensaoCisalhamentoTorque, 0);
[tensaoNormalResultanteB, tensaoCisalhamentoResultanteB] = calculaTensaoResultante(tensaoNormal, tensaoCisalhamento, tensaoNormalFlexao, tensaoCisalhamentoTorque, 1);
[tensaoNormalResultanteC, tensaoCisalhamentoResultanteC] = calculaTensaoResultante(tensaoNormal, tensaoCisalhamento, tensaoNormalFlexao, tensaoCisalhamentoTorque, 2);
[tensaoNormalResultanteD, tensaoCisalhamentoResultanteD] = calculaTensaoResultante(tensaoNormal, tensaoCisalhamento, tensaoNormalFlexao, tensaoCisalhamentoTorque, 3);


plotaTensaoPrincipal(tensaoNormalResultanteA, tensaoCisalhamentoResultanteA,  xFim, "Tensao principal no ponto A", "Pa", 11);
plotaTensaoPrincipal(tensaoNormalResultanteB, tensaoCisalhamentoResultanteB,  xFim, "Tensao principal no ponto B", "Pa", 12);
plotaTensaoPrincipal(tensaoNormalResultanteC, tensaoCisalhamentoResultanteC,  xFim, "Tensao principal no ponto C", "Pa", 13);
plotaTensaoPrincipal(tensaoNormalResultanteD, tensaoCisalhamentoResultanteD,  xFim, "Tensao principal no ponto D", "Pa", 14);

plotaCriterioTresca(tensaoNormalResultanteA, tensaoCisalhamentoResultanteA,  xFim, "Criterio de Tresca no ponto A", "Pa", 15);
plotaCriterioTresca(tensaoNormalResultanteB, tensaoCisalhamentoResultanteB,  xFim, "Criterio de Tresca no ponto B", "Pa", 16);
plotaCriterioTresca(tensaoNormalResultanteC, tensaoCisalhamentoResultanteC,  xFim, "Criterio de Tresca no ponto C", "Pa", 17);
plotaCriterioTresca(tensaoNormalResultanteD, tensaoCisalhamentoResultanteD,  xFim, "Criterio de Tresca no ponto D", "Pa", 18);
