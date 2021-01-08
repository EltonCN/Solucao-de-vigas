source singularidade.m #checar dps

function cortante = calculaInclinacao(singularidade, moduloElastico, momentoDeInerciaDeArea, maxX)

#momentoX = novaSingularidade

    #Procurar singularidades que precisa
    #Somar elas
    #Integrar quantas vezes for preciso -> integral final dara anguloTorcao sem os coeficientes constantes
    inclinacao = [];
    deflexao = [];
    cortante = [];
    momento = [];

    indice = 1;

    xApoio = 0;

    #ver se n da pra usar um for i=1:columns(singularidade)
    for i=1:columns(singularidade)
        # analiso quais singularidades são torque e faço a somatoria da integral dessas
        if singularidade(i).magnitude(2) != 0 | singularidade(i).magnitude(6) != 0
            #append no vetor (checar documentação)

            v = integraSingularidade(singularidade(i));

            cortante = [cortante, v];

            m = integraSingularidade(v);

            momento = [momento, m]; #momento interno da viga

            theta = integraSingularidade(m);

            for j = 1:columns(theta.magnitude) # verificar J
                theta.magnitude(j) /= (momentoDeInerciaDeArea * moduloElastico);
            endfor

            #{
            disp("x")
            theta.x
            disp("grau")
            theta.grau
            disp("magnitude")
            theta.magnitude
            disp("")
            #}
            

            inclinacao = [inclinacao, theta];
        
            deflexao = [deflexao, integraSingularidade(theta)];

            

            if (strcmp(singularidade(i).nome,"fixo Vertical") == 1) 
                xApoio = singularidade(i).x;
            elseif(strcmp(singularidade(i).nome,"engastado Vertical") == 1)
                xApoio = singularidade(i).x;
            elseif(strcmp(singularidade(i).nome,"móvel Vertical") == 1)
                xApoio = singularidade(i).x;
            endif

            indice += 1;

        endif

    endfor
    
#não sei oq é isso aqui
    passo = maxX/500;
    
    xAtual = 0;

    x = [];
    y = [];
    y2 = [];

    yV = [];
    yM = [];

    #analisa a inclinação em 10000 pontos ao longo da barra e plota o gráfico
    for i=1:500
        x(i) = xAtual;
        y(i) = 0;
        y2(i) = 0;
        yV(i) = 0;
        yM(i) = 0;

        if(isempty(inclinacao) == true)
        else

            for j = 1:columns(inclinacao)

                y(i) += avaliaSingularidade(inclinacao(j), xAtual);
            
                y2(i) += avaliaSingularidade(deflexao(j), xAtual);

                yV += avaliaSingularidade(cortante(j), xAtual);
                yM += avaliaSingularidade(momento(j), xAtual);

                y2(i) -= avaliaSingularidade(deflexao(j), xApoio);
            endfor
        endif

        

        xAtual += passo;
    endfor

    figure (1);
    plot(x,yV);
    title("Plot da força cortante")
    xlabel("m")
    ylabel("N")

    figure (2);
    plot(x,yM);
    title("Plot do momento interno")
    xlabel("m")
    ylabel("N.m")

    figure (3);
    plot(x,y);
    title("Plot da inclinação");
    xlabel("m");
    ylabel("rad");

    figure(4);
    plot(x,y2);
    title("Plot da deflexão");
    xlabel("m");
    ylabel("m");


endfunction

