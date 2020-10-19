function novoSistema = criaNovoSistema(x, y)
    novoSistema = struct("b", [0;0;0;0;0;0], "A", "var", [], A, [[],[],[],[],[],[]], "x", x, "y", y)

endfunction

#Recebe uma variável
function recebeVariavel(sistema, novaVariavel)
    coluna = rows(sistema.var)+1
    
    linha = novaVariavel.eixo

    if(novaVariavel.tipo == false)
        linha += 3
    endif

    for i 1:6
        sistema.A[i][coluna] = 0
    endfor

    sistema.var[coluna] = novaVariavel
    sistema.A[linha][coluna] = 1

endfunction

#Recebe uma variável especificando seus 6 coeficientes no sistema
function recebeVariavel(sistema, novaVariavel, coeficiente)
    coluna = rows(sistema.var)+1
    
    linha = novaVariavel.eixo

    if(novaVariavel.tipo == false)
        linha += 3
    endif

    for i 1:6
        sistema.A[i][coluna] = coeficiente[i]
    endfor

    sistema.var[coluna] = novaVariavel

endfunction

function recebeGrandeza(sistema, grandeza)
    coluna = grandeza.eixo

    if(grandeza.tipo == false)
        coluna+= 3
    endif

    sistema.b[coluna] += -grandeza.magnitude

endfunction

function solve(sistema)
    result = sistema.A\sistema.b

    for i = 1:rows(sistema.var)
        sistema.var[i] = result[i]

endfunction

#Merge sistemaB no sistemaA
function merge(sistemaA, sistemaB)
    
    #b = A.b + B.b
    for i = 1:6
        sistemaA.b[i] = sistemaB.b[i]
    endfor

    if(rows(sistemaB.var) == 0)
        return
    endif

    index = rows(sistemaA.var) + 1

    #var = var.A concat var.B
    for i = 1:rows(sistemaB.var)
        sistemaA.var[index] = sistemaB.var[i]
        index+=1
    endfor

    coluna = rows(sistema.var)+1

    for i = 1:rows(sistemaB.var)
        for j = 1:6
            sistemaA.A[j][coluna] = sistemaB.A[j][i]
        endfor
    endfor

endfunction