source grandeza.m
source sistemaLinear.m
source variavel.m


function esforcoInterno(sistema, inicioIntervalo, fimIntervalo)

    sistema.carga;

    encontrouCargaDistribuida = false;

    for i = 1:columns(sistema.carga)
        if(sistema.carga(i).inicio >= inicioIntervalo && sistema.carga(i).fim <= fimIntervalo)
            
            resolvido = solveIntervalo(sistema, inicioIntervalo);

            ######### Calculo da força cortante #########
            polinomio = integraPol(sistema.carga(i).polinomio, inicioIntervalo);
            resolvido.var(2).magnitude = polinomio(columns(polinomio)) + resolvido.var(2).magnitude;     #Força cortante agora polinomial
            

            ######### Calculo do momento interno #########
            polinomio = integraPol(deslocaPolinomio(sistema.carga(i).polinomio), inicioIntervalo);
            resolvido.var(3).magnitude = polinomio(columns(polinomio)) + resolvido.var(3).magnitude;     #Momento interno agora polinomial


            encontrouCargaDistribuida = true;
        endif
    endfor

    if (encontrouCargaDistribuida == false)

        ordenado = bubblesort(sistema);
        resolvido = solveIntervalo(sistema, fimIntervalo);

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
    sistema.var = []

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
    for i = columns(sistema.grandeza):-1:1
        if sistema.grandeza(i).x > x
            sistema.grandeza(i) = []
        endif
    endfor

    normal = novaVariavel(x,0)
    normal.coeficiente(1) = 1
    normal.nome = "normal"

    cortante = novaVariavel(x,0)
    cortante.coeficiente(2) = -1
    cortante.nome = "cortante"

    momento = novaVariavel(x,0)
    momento.coeficiente(6) = 1
    momento.nome = "momento"

    torque = novaVariavel(x,0)
    torque.coeficiente(4) = 1
    torque.nome = "torque"

    sistema = recebeVariavel(sistema, normal)
    sistema = recebeVariavel(sistema, cortante)
    sistema = recebeVariavel(sistema, momento)
    sistema = recebeVariavel(sistema, torque)

    sistema = solve(sistema)

    resultado = sistema

endfunction