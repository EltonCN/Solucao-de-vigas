source grandeza.m
source variavel.m
source cargaDistribuida.m

function novaFuncaoSingularidade = novaFuncaoSingularidade()
    novaFuncaoSingularidade = struct("magnitude", [0,0,0,0,0,0,0], "grau", 0, "x", 0, "nome", "NULL");

endfunction

#Dipolo/ Momento: -2
#Delta de Dirac/: -1
#Degrau/: 0
#Rampa/ A partir de um ponto: 1
#Parábola: 2

#lado - True = esquerdo, False = direito
function valor = avaliaSingularidade(singularidade, x)
    
    valor = 0;

    magnitude = 0;

    for i = 1:columns(singularidade.magnitude)

        magnitude += singularidade.magnitude(i);

    endfor

    if(singularidade.grau == 0)

        if(singularidade.x >= x)
            valor += magnitude;
        endif

    elseif(singularidade.grau == -1)

        if(singularidade.x == x)
            valor += magnitude;
        endif

    elseif(singularidade.grau == -2)

        if(singularidade.x == x)
            valor = inf;
        endif

    elseif(singularidade.grau >= 1)
       if(singularidade.x  >= x)
            valor += ((x-singularidade.x)^singularidade.grau)*magnitude;
        endif 

    endif

endfunction

function soma = somaSingularidade(singularidade1, singularidade2)

    if singularidade1.grau != singularidade2.grau
        error("Nao eh possivel somar singularidades de graus diferentes");
    endif

    soma = singularidade1

    for i = 1:6
        soma.magnitude(i) += singularidade2.magnitude(i)
    endfor
endfunction

function singularidade = converteGrandezaParaSingularidade(grandeza)


    singularidade = novaFuncaoSingularidade();
    

    if(grandeza.tipo == true) #É momento
        for i = 1:3
            if grandeza.coeficiente(i+3) != 0
                singularidade.magnitude(i+3) = grandeza.magnitude*grandeza.coeficiente(i+3);

            endif

        endfor

        if (grandeza.coeficiente(4) != 0)
            singularidade.grau = 0;
        else
            singularidade.grau = -2;
        endif

        

    else #É força
        for i = 1:3
            if grandeza.coeficiente(i) != 0
                singularidade.magnitude(i) = grandeza.magnitude*grandeza.coeficiente(i);

            endif

        endfor

        singularidade.grau = -1;

    endif

    singularidade.x = grandeza.x;

    singularidade.nome = grandeza.nome;

endfunction


function sing = converteVariavelParaSingularidade(variavel)

    a = transformaEmGrandeza(variavel);


    sing = converteGrandezaParaSingularidade(a);
endfunction

#@todo Implementar direito
function singularidade = converteCargaParaSingularidade(carga)
    singularidade = novaFuncaoSingularidade();
    

    if (carga.polinomio(1) != 0)

        singularidade.grau = 0;
        singularidade.x = carga.inicio;

        singularidade.magnitude(2) = carga.polinomio(1);

    endif

endfunction

function singularidade = divideMagnitude(sing, divisor)

    singularidade = sing;

    for i = 1:6

            singularidade.magnitude(i) /= divisor;

    endfor

endfunction

function integrada = integraSingularidade(singularidade)

    integrada = singularidade;

    integrada.grau += 1;

    if singularidade.grau >= 1

        for i = 1:6

            integrada.magnitude(i) /= singularidade.grau+1;

        endfor

    endif

endfunction