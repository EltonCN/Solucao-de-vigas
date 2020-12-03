source grandeza.m
source variavel.m
source cargaDistribuida.m

function novaFuncaoSingularidade = novaFuncaoSingularidade()
    novaFuncaoSingularidade = struct("magnitude", [0,0,0,0,0,0,0], "grau", 0, "x", 0, "nome", "NULL");

endfunction

#Dipolo/ Momento: -2
#Delta de Dirac/Força perpendicular a barra: -1
#Degrau/Força paralela a barra: 0
#Rampa/ A partir de um ponto: 1
#Parábola: 2

#lado - True = esquerdo, False = direito
function valor = avaliaSingularidade(singularidade, x)
    
    valor = 0;

    if(singularidade.grau == 1)

        if(singularidade.x  >= x)
            valor += (x-singularidade.x)*singularidade.magnitude;
        endif

    elseif(singularidade.grau == 0)

        if(singularidade.x >= x)
            valor += singularidade.magnitude;
        endif

    elseif(singularidade.grau == -1)

        if(singularidade.x == x)
            valor += singularidade.magnitude;
        endif

    elseif(singularidade.grau == -2)

        if(singularidade.x == x)
            valor = inf;
        endif

    elseif(singularidade.grau == 2)
       if(singularidade.x  >= x)
            valor += ((x-singularidade.x)^2)*singularidade.magnitude;
        endif 

    endif

endfunction

function soma = somaSingularidade(singularidade1, singularidade2)

    if singularidade1.grau != singularidade2.grau
        error("Nao eh possivel somar singularidades de graus diferentes");
    endif

    soma = singularidade1

    for i = 1:6
        soma.magnitude[i] += singularidade2.magnitude[i]
    endfor

function sigularidade = converteGrandezaParaSingularidade(grandeza)
    singularidade = novaFuncaoSingularidade();
    

    if(grandeza.tipo == true) #É momento
        for i = 1:3
            if grandeza.coeficiente[i+3] != 0
                singularidade.magnitude[i+3] = grandeza.magnitude;

            endif

        endfor

        singularidade.grau = -2;

    else #É força
        for i = 1:3
            if grandeza.coeficiente[i] != 0
                singularidade.magnitude[i] = grandeza.magnitude;

            endif

        endfor

        singularidade.grau = -1;

    endif

    singularidade.x = grandeza.x;

    singularidade.nome = grandeza.nome;

endfunction


function singularidade = converteVariavelParaSingularidade(variavel)

    singularidade = converteGrandezaParaSingularidade(transformaEmGrandeza(variavel))

endfunction

function singularidade = converteCargaParaSingularidade(carga)
    singularidade = novaFuncaoSingularidade()
    error("NÃO IMPLEMENTADA converteCargaParaSingularidade NÃO IMPLEMENTADA :)")
endfunction

function integrada = integraSingularidade(singularidade)

    integrada = singularidade;

    integrada.grau += 1;

    if singularidade.grau == 1

        for i = 1:6

            integrada.magnitude[i] /= 2;

        endfor

    endif

endfunction