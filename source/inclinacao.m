source singularidade.m ##checar dps

function singularidadeIntegrada = calculaInclinacao(singularidade, moduloElastico, momentoDeInerciaDeArea)

#momentoX = novaSingularidade

    #Procurar singularidades que precisa
    #Somar elas
    #Integrar quantas vezes for preciso -> integral final dara anguloTorcao sem os coeficientes constantes

    singularidadeIntegrada = [];

    indice = 1;

    #ver se n da pra usar um for i=1:columns(singularidade)
    for i=1:columns(singularidade)
        # analiso quais singularidades são torque e faço a somatoria da integral dessas
        if singularidade(i).magnitude(2) != 0 & singularidade(i).grau == -1
            #append no vetor (checar documentação)
            singularidadeIntegrada = [singularidadeIntegrada, integraSingularidade(singularidade)];
        
            for j = 1:6 # verificar J
                singularidadeIntegrada(indice).magnitude(j) /= (momentoDeInerciaDeArea * moduloElastico);
            endfor

            indice += 1;
        endif

    endfor

#não sei oq é isso aqui
    passo = maxX/500;
    
    xAtual = 0;

    x = [];
    y = [];

    #analisa a inclinação em 10000 pontos ao longo da barra e plota o gráfico
    for i=1:500
        x(i) = xAtual;
        y(i) = 0;
        
        for j = 1:columns(singularidadeIntegrada)
        
            y(i) += avaliaSingularidade(singularidadeIntegrada(j), xAtual);
        
        endfor

        xAtual += passo;
    endfor

    figure (4);
    plot(x,y);
    title("Plot da inclinação");
    xlabel("inclinação em y");
    ylabel("comprimento da barra");


endfunction