source singularidade.m

function forcaNormal = calculaAlongamento(singularidades, areaSecao, moduloElastico, maxX)

    #Calula a forca normal

    forcaNormal = [];
    alongamento = [];

    indice = 1;

    for i =1:columns(singularidades)

        if (singularidades(i).grau == -1)

            if (singularidades(i).magnitude(1) != 0)

                forcaExterna = singularidades(i);

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

    passo = maxX/500;
    
    xAtual = 0;

    x = [];
    y = [];

    for i=1:500
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