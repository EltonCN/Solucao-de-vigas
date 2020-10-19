source grandeza.m
source variavel.m

function novoSistema = novoSistema(x, y)
    novoSistema = struct("b", [0;0;0;0;0;0], "var", [], "A", [], "x", x, "y", y, "calculado", false, "grandeza", [])

endfunction

function retorno = clearCalculado(sistema)
    if(sistema.calculado == false)
        retorno = sistema
        return
    endif
    
    
    for i = 1:size(sistema.var)(2)
        sistema.var(i) = setNaoCalculado(sistema.var(i))
    endfor

    sistema.calculado = false

    retorno = sistema
endfunction

#Recebe uma variável
function retorno = recebeVariavel(sistema, novaVariavel)
    sistema = clearCalculado(sistema)

    sistema.var(rows(sistema.var)+1) = novaVariavel

    retorno = sistema

endfunction

function retorno = recebeGrandeza(sistema, grandeza)
    sistema = clearCalculado(sistema)
    
    sistema.grandeza(rows(sistema.grandeza)+1) = grandeza

    retorno = sistema

endfunction

function retorno = solve(sistema)
    sistema = clearCalculado(sistema)
    
    for i = 1: columns(sistema.var)
        for j = 1:6
            sistema.A(j,i) = sistema.var(i).coeficiente(j)
        endfor
    endfor

    for i = 1:columns(sistema.grandeza)
        for j = 1:6
            sistema.b(j) -= sistema.grandeza(i).magnitude * sistema.grandeza(i).coeficiente(j)
        endfor

    endfor


    A = []
    b = []

    index = 1

    for i = 1:6
        zero = true
        for j = 1:size(sistema.A(i))(1)
            
            if(sistema.A(i,j) != 0)
                zero = false
            endif
        endfor

        if(zero == false)
            if(sistema.b(i) != 0)
                b(index) = sistema.b(i)

                for j = 1:columns(sistema.A(i,:))
                    A(index,j ) = sistema.A(i, j)
                endfor

                index += 1
            endif
        endif
    endfor

    try
        result = inv(A) * b
    catch err
        retorno = sistema
        disp("ERRO: Sistema não pode ser resolvido]")

        return
    end_try_catch

    for i = 1:rows(sistema.var)
        sistema.var(i) = setValor(sistema.var(i), result(i))

    endfor

    sistema.calculado = true

    retorno = sistema
endfunction

#Merge sistemaB no sistemaA
function retorno =  merge(sistemaA, sistemaB)
    
    if(sistemaB.x<sistemaA.x)
        cesta = sistemaB
        sistemaB = sistemaA
        sistemaA = cesta
    endif

    indice = columns(sistemaA.var)+1

    for i = 1:columns(sistemaB.var)


    endfor


    sistema = clearCalculado(sistemaA)

    retorno = sistema
endfunction