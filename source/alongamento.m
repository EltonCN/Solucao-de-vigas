source singularidade.m

function calculaAlongamento(singularidades, areaSecao, moduloElastico, maxX)
    #Calula a forca normal

    forcaNormal = [];
    alongamento = [];

    indice = 1;

    xApoio = 0;

    for i =1:columns(singularidades)

        if (singularidades(i).grau == -1)

            if (singularidades(i).magnitude(1) != 0)

                forcaExterna = singularidades(i);

                forcaInterna = integraSingularidade(forcaExterna);

                forcaNormal = [forcaNormal, forcaInterna];
                alongamento = [alongamento, integraSingularidade(forcaNormal(i))];

                for j = 1:6

                    alongamento(indice).magnitude(j) /= (moduloElastico*areaSecao);

                endfor

                if (strcmp(singularidades(i).nome,"fixo horizontal") == 1) 
                    xApoio = singularidades(i).x;
                elseif(strcmp(singularidades(i).nome,"engastado horizontal") == 1)
                    xApoio = singularidades(i).x;
                endif

                indice += 1;

            endif
        endif

    endfor

    passo = maxX/500;
    
    xAtual = 0;

    x = [];
    y = [];

    for i=1:500
        x(i) = xAtual;

        y(i) = 0;


        if(isempty(alongamento) == false)

            for j =1:columns(alongamento)
                y(i) += avaliaSingularidade(alongamento(j), xAtual);
                y(i) -= avaliaSingularidade(alongamento(j), xApoio);
            endfor

        endif

        

        xAtual += passo;
    endfor

    figure (5);
    plot(x,y);
    title("Plot do alongamento");
    xlabel("m");
    ylabel("m");

endfunction