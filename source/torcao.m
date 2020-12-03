source singularidade.m;

function calculaTorcao(singularidade, momentoInerciaPolar, moduloCisalhamento, maxX)

    #momentoX = novaSingularidade

    #Procurar singularidades que precisa
    #Somar elas
    #Integrar quantas vezes for preciso -> integral final dara anguloTorcao sem os coeficientes constantes

    singularidadeIntegrada = [];

    indice = 1;

    disp("Recebi essas singularidades")

    xApoio = 0

    #ver se n da pra usar um for i=1:columns(singularidade)
    for i=1:columns(singularidade)
        singularidade(i)
        # analiso quais singularidades são torque e faço a somatoria da integral dessas
        if singularidade(i).magnitude(4) != 0
            #append no vetor (checar documentação)
            singularidadeIntegrada = [singularidadeIntegrada, integraSingularidade(singularidade(i))];
        
            for j = 1:6
                singularidadeIntegrada(indice).magnitude(j) /= (moduloCisalhamento * momentoInerciaPolar);
            
                
            endfor

            if (strcmp(singularidade(i).nome,"engastado Torque") == 1) 
                xApoio = singularidade(i).x;
            elseif(strcmp(singularidade(i).nome,"fixo Torque") == 1)
                xApoio = singularidade(i).x;
            endif
            indice += 1;
        endif

    endfor


    #não sei oq é isso aqui
    passo = maxX/1000;
    
    xAtual = 0;

    x = [];
    y = [];

    #analisa o angulo de torção em 10000 pontos ao longo da barra e plota o gráfico
    for i=1:1000
        x(i) = xAtual;
        y(i) = 0;
        
        for j = 1:columns(singularidadeIntegrada)
        
            y(i) += avaliaSingularidade(singularidadeIntegrada(j), xAtual);

            y(i) -= avaliaSingularidade(singularidadeIntegrada(j), xApoio);

        endfor

        xAtual += passo;
    endfor

    figure (5);
    plot(x,y);
    title("Plot do angulo de torcao");
    xlabel("m");
    ylabel("rad");


endfunction