source grandeza.m
source sistemaLinear.m
source variavel.m

function analiseDeIntervalos(sistema, inicioBarra, fimBarra)

    ordenado = bubblesort(sistema);

    if (columns(ordenado) > 1)

        for i = 2:(columns(ordenado))

            resolvido = esforcoInterno(sistema, ordenado.grandeza(i -1).x, ordenado.grandeza(i).x);

        endfor
    else 
        esforcoInterno(sistema, inicioBarra, fimBarra);
    endif

endfunction

function resolvido = esforcoInterno(sistema, inicioIntervalo, fimIntervalo)

    ordenado = bubblesort(sistema);
    encontrouCargaDistribuida = false;

    #{
    for i = 1:columns(sistema.carga)
        
        if(sistema.carga(i).inicio >= inicioIntervalo && sistema.carga(i).fim <= fimIntervalo)
            
            resposta = solveIntervalo(ordenado, inicioIntervalo);

            ######### Calculo da força cortante #########
            polinomio1 = integraPol(sistema.carga(i).polinomio, inicioIntervalo);
            polinomio1(columns(sistema.carga(i).polinomio)) = polinomio1(columns(sistema.carga(i).polinomio)) + resposta.var(2).magnitude;     #Força cortante agora polinomial
            

            ######### Calculo do momento interno #########
            polinomio2 = integraPol(deslocaPolinomio(sistema.carga(i).polinomio), inicioIntervalo);
            polinomio2(columns(sistema.carga(i).polinomio)) = polinomio2(columns(sistema.carga(i).polinomio)) + resposta.var(3).magnitude;     #Momento interno agora polinomial


            resolvido(1) = polinomio1;  #Força cortante
            resolvido(2) = polinomio2;  #Momento interno

            encontrouCargaDistribuida = true;

            figure (1);
            t = linspace(inicioIntervalo, fimIntervalo); 
            plot(t, polyval(resolvido(1), t));
            title("Plot da força cortante");
            title("Plot da força cortante");
            xlabel("m");
            ylabel("N");

            figure (2);
            plot(t, polyval(resolvido(2), t)); 
            title("Plot do momento interno");
            xlabel("m");
            ylabel("N.m");

            return
        endif
    endfor
    #}

    if (encontrouCargaDistribuida == false)

        #for i = 1:columns(ordenado)
        #    resposta = solveIntervalo(ordenado, ordenado.grandeza(i).x);
        #endfor

        passo = (fimIntervalo-inicioIntervalo)/500;

        x = [];
        y = [];
        yMomento = [];

        pontoX = 0;

        for i=1:500
            resposta = solveIntervalo(ordenado, pontoX);

            y(i) = resposta.var(2).magnitude;
            x(i) = pontoX;
            yMomento(i) = resposta.var(3).magnitude;

            pontoX += passo;
        endfor


        #resposta = solveIntervalo(ordenado, fimIntervalo);

        #resolvido(1) = resposta.var(2).magnitude;  #Força cortante
        #resolvido(2) = resposta.var(3).magnitude;  #Momento interno

        figure (1);
        plot(x,y);
        title("Plot da força cortante")
        xlabel("m")
        ylabel("N")

        figure (2);
        plot(x,yMomento);
        title("Plot do momento interno")
        xlabel("m")
        ylabel("N.m")
    endif
    

endfunction

function vetor = deslocaPolinomio(polinomio)

    vetor(1) = 0;

    indice = 2;

    for i = 1:columns(polinomio)
        vetor(indice) = polinomio(i);

        indice += 1;
    endfor

endfunction

function novoPolinomio = integraPol(polinomio, limiteInferior)

    novoPolinomio = polyint(fliplr (polinomio));

    novoPolinomio = novoPolinomio(columns(novoPolinomio)) - polyval(novoPolinomio, limiteInferior);

endfunction


function ordenado = bubblesort(sistema)                            

    contador = 0;

    indice = columns(sistema.grandeza)+1;

    for i =1:columns(sistema.var)
        sistema.grandeza(indice) = transformaEmGrandeza(sistema.var(i));
        indice += 1;
    endfor
    sistema.var = [];

    do
        mudou = false;
        contador++;
           
        for i = contador:columns(sistema.grandeza) -1                               #ordenado se o for não alterar nada
            if(sistema.grandeza(i).x >  sistema.grandeza(i+1).x)
                mudou = true;
                sistema.grandeza([i, i+1]) = sistema.grandeza([i+1, i]);            #troca
            endif
        endfor

    until(mudou == false)

    ordenado = sistema;

endfunction

#Calcula o sistema apenas em um intervalo [0,x]
#@param sistema - Sistema que será resolvido
#@param x - Fim do intervalo
#@return Sistema sem as grandezas fora do intervalo, com esforços internos adicionados
function resultado = solveIntervalo(sistema, x)
    
    sistema = clearCalculado(sistema);
    sistema.var = [];

    for i = columns(sistema.grandeza):-1:1
        if sistema.grandeza(i).x > x
            sistema.grandeza(i) = [];
        endif
    endfor

    normal = novaVariavel(x,0);
    normal.coeficiente(1) = 1;
    normal.nome = "normal";

    cortante = novaVariavel(x,0);
    cortante.coeficiente(2) = 1;
    cortante.nome = "cortante";

    momento = novaVariavel(x,0);
    momento.coeficiente(6) = 1;
    momento.tipo = true;
    momento.nome = "momento";

    torque = novaVariavel(x,0);
    torque.coeficiente(4) = 1;
    torque.tipo = true;
    torque.nome = "torque";

    sistema = recebeVariavel(sistema, normal);
    sistema = recebeVariavel(sistema, cortante);
    sistema = recebeVariavel(sistema, momento);
    sistema = recebeVariavel(sistema, torque);

    sistema = solve(sistema);


    resultado = sistema;

endfunction