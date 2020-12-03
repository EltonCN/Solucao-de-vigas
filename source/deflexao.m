source singularidade.m ##checar dps

function calculaDeflexao(singularidade, singularidadeIntegrada)

#momentoX = novaSingularidade

    #Procurar singularidades que precisa
    #Somar elas
    #Integrar quantas vezes for preciso -> integral final dara anguloTorcao sem os coeficientes constantes

    deflexao = [];

    indice = 1;

    #ver se n da pra usar um for i=1:columns(singularidade)
    for i=1:columns(singularidadeIntegrada)
    
        #append no vetor (checar documentação)
        deflexao = [deflexao, integraSingularidade(singularidadeIntegrada)];

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
        
        for j = 1:columns(deflexao)
        
            y(i) += avaliaSingularidade(deflexao(j), xAtual);
        
        endfor

        xAtual += passo;
    endfor

    figure (4);
    plot(x,y);
    title("Plot da inclinação");
    xlabel("inclinação em y");
    ylabel("comprimento da barra");


endfunction