source singularidade.m

function calculaAlongamento(singularidades, areaSecao, moduloElastico, maxX)

    #Calula a forca normal

    forcaNormal = [];
    alongamento = [];

    indice = 1

    for i =1:columns(singularidades)

        if (singularidade(i).grau == -1)

            if (singularidade(i).magnitude[1] != 0)

                forcaExterna = singularidade(i);

                forcaInterna = integraSingularidade(forcaExterna);

                forcaNormal = [forcaNormal, somaSingularidade(forcaNormal, forcaInterna)];
                alongamento = [alongamento, integraSingularidade(forcaNormal(i))]

                for j = 1:6

                    alongamento(indice).magnitude(j) /= (moduloElastico*areaSecao);

                endfor

                indice += 1

            endif
        endif

    endfor

    passo = maxX/10000;
    
    xAtual = 0;

    x = [];
    y = [];

    for i=1:10000
        x(i) = xAtual;

        y(i) = 0;

        for j =1:columns(alongamento)
            y(i) += avaliaSingularidade(alongamento(j), xAtual);
        endfor
        
        xAtual += passo;
    endfor

    figure (3);
    plot(x,y);
    title("Plot do alongamento");
    xlabel("m");
    ylabel("m");

endfunction