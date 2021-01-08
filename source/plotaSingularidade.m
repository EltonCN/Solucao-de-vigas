source singularidade.m;

function plotaSingularidade(singularidade, maxX, nomePlot, eixoY, nPlot)

    passo = maxX/500;
    
    xAtual = 0;

    x = [];
    y = [];

    for i=1:500
        x(i) = xAtual;
        y(i) = 0;

        if(isempty(inclinacao) == true)
        else

            for j = 1:columns(inclinacao)

                y(i) += avaliaSingularidade(singularidade(j), xAtual);
            
            endfor
        endif

        xAtual += passo;
    endfor

    figure (nPlot);
    plot(x,y);
    title(nomePlot)
    xlabel("m")
    ylabel(eixoY)


endfunction