source singularidade.m

function tensaoCisalhamento = calculaTensaoCisalhamento(forcaCortante, areaSecao, raioExterno, raioInterno)

    tensaoCisalhamento = [];

    coeficiente = (4.0/3.0);

    r2 = raioExterno * raioExterno;
    r1 = raioInterno * raioInterno;
    r21 = raioExterno * raioInterno;

    coeficiente *= (r2 + r21 + r1)/(r2+r1);

    coeficiente = 1.0/coeficiente;

    for j =1:columns(forcaCortante)
        tensaoCisalhamento = [tensaoCisalhamento, divideMagnitude(forcaCortante(j), coeficiente)];
    endfor

endfunction

function tensaoNormal = calculaTensaoNormal(forcaNormal, areaSecao)

    tensaoNormal = [];

    for j = 1:columns(forcaNormal)
        tensaoNormal = [tensaoNormal, divideMagnitude(forcaNormal(j), areaSecao)];
    endfor


endfunction


function tensaoCisalhamentoTorque = calculaTensaoCisalhamentoTorque(singularidades, raioExterno, momentoInerciaPolar)
    tensaoCisalhamentoTorque = [];

    coeficiente = raioExterno/momentoInerciaPolar;
    coeficiente = 1/coeficiente;

    for i=1:columns(singularidades)
        
        #verifica se e torque
        if singularidades(i).magnitude(4) != 0
            tensaoCisalhamentoTorque = [tensaoCisalhamentoTorque, divideMagnitude(singularidades(i), coeficiente)];
        endif

    endfor


endfunction

function momento = calculaMomentoInterno(forcaCortante)
    momento = [];

    for i=1:columns(forcaCortante)
        m = integraSingularidade(forcaCortante(i));

        momento = [momento, m]; #momento interno da viga
    endfor
endfunction




function tensaoNormalFlexao = calculaTensaoNormalFlexao(momento, momentoInercia, raioExterno)
    tensaoNormalFlexao = [];

    coeficiente = raioExterno/momentoInercia;
    coeficiente = 1/coeficiente;

    for j = 1:columns(momento)
        tensaoNormalFlexao = [tensaoNormalFlexao, divideMagnitude(momento(j), coeficiente)];
    endfor
endfunction

#ponto (0 = A, 1 = B, 2=C, 3 =D)
#tensaoXXX = vetor de funcoes de singularidade dessa tensao
function [tensaoNormalResultante, tensaoCisalhamentoResultante] = calculaTensaoResultante(tensaoNormal, tensaoCisalhamento, tensaoNormalFlexao, tensaoCisalhamentoTorque, ponto)

    tensaoNormalResultante = [];

    for i = 1:columns(tensaoNormal)
        
        if(ponto == 0)
            tensaoNormalResultante = [tensaoNormalResultante, tensaoNormal(i)];
        endif
        if(ponto == 1)
            tensaoNormalResultante = [tensaoNormalResultante, tensaoNormal(i)];
        endif
        if(ponto == 2)
            tensaoNormalResultante = [tensaoNormalResultante, tensaoNormal(i)];
        endif
        if (ponto == 3)
            tensaoNormalResultante = [tensaoNormalResultante, tensaoNormal(i)];
        endif
    endfor
    
    for i = 1:columns(tensaoNormalFlexao)
        if(ponto == 0)

        endif
        if(ponto == 1)
            tensaoNormalResultante = [tensaoNormalResultante, tensaoNormalFlexao(i)];
        endif
        if(ponto == 2)
        
        endif
        if (ponto == 3)
            tensaoNormalResultante = [tensaoNormalResultante, divideMagnitude(tensaoNormalFlexao(i), -1) ];
        endif
    endfor
    


    tensaoCisalhamentoResultante = [];

    for i = 1:columns(tensaoCisalhamento)
        if(ponto == 0)
            tensaoCisalhamentoResultante = [tensaoCisalhamentoResultante, tensaoCisalhamento(i)];
        endif
        if(ponto == 1)
        endif
        if(ponto == 2) 
            tensaoCisalhamentoResultante = [tensaoCisalhamentoResultante, tensaoCisalhamento(i)];    
        endif
        if (ponto == 3)
        endif
    endfor

    #Verificar analise do sinal
    for i = 1:columns(tensaoCisalhamentoTorque)
        if(ponto == 0)
            tensaoCisalhamentoResultante = [tensaoCisalhamentoResultante, tensaoCisalhamentoTorque(i)];
        endif
        if(ponto == 1)
            tensaoCisalhamentoResultante = [tensaoCisalhamentoResultante, tensaoCisalhamentoTorque(i)];
        endif
        if(ponto == 2) 
            tensaoCisalhamentoResultante = [tensaoCisalhamentoResultante, divideMagnitude(tensaoCisalhamentoTorque(i), -1)];
        endif
        if (ponto == 3)
            tensaoCisalhamentoResultante = [tensaoCisalhamentoResultante, divideMagnitude(tensaoCisalhamentoTorque(i), -1)];
        endif
    endfor

    #sigma = normal, tau = cisalhamento

    

endfunction


function [maximo, minimo] = avaliaTensaoPrincipal(tensaoCisalhamentoResultante, tensaoNormalResultante, x)

    sigma = 0;
    tau = 0;

    for i = 1:columns(tensaoCisalhamentoResultante)
        tau += avaliaSingularidade(tensaoCisalhamentoResultante(i), x);
    endfor

    for i = 1:columns(tensaoNormalResultante)
        sigma += avaliaSingularidade(tensaoNormalResultante(i), x);
    endfor

    maximo = sigma;
    minimo = sigma;

    raiz = sqrt(((sigma^2)/2)+(tau^2));#help

    maximo += raiz;
    minimo -= raiz;

endfunction

function plotaTensaoPrincipal(tensaoCisalhamentoResultante, tensaoNormalResultante, maxX, nomePlot, eixoY, nPlot)

    passo = maxX/500;
    
    xAtual = 0;

    x = [];
    y = [];

    for i=1:500
        x(i) = xAtual;
        y(i) = avaliaTensaoPrincipal(tensaoCisalhamentoResultante, tensaoNormalResultante, xAtual);


        xAtual += passo;
    endfor

    figure (nPlot);
    plot(x,y);
    title(nomePlot);
    xlabel("m");
    ylabel(eixoY);

endfunction