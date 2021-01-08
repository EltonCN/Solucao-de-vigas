source grandeza.m
source variavel.m

#Cria um novo sistema
#@param x - Posição x
#@param y - Posição y
function novoSistema = novoSistema(x, y)
    novoSistema = struct("b", [0;0;0;0;0;0], "var", [], "A", [], "x", x, "y", y, "calculado", false, "grandeza", [], "z", 0, "carga", []);

endfunction

#Define o sistema como não calculado
#@param sistema - O sistema a ser definido
#@return Sistema definido
function retorno = clearCalculado(sistema)
    if(sistema.calculado == false)
        retorno = sistema;
        return
    endif
    
    
    for i = 1:size(sistema.var)(2)
        sistema.var(i) = setNaoCalculado(sistema.var(i));
    endfor

    sistema.calculado = false;

    sistema.A = [];
    sistema.b = [0;0;0;0;0;0];

    retorno = sistema;
endfunction

#Recebe uma variável
#@param sistema - Sistema que receberá a variável
#@param novaVariavel - A variável que será recebida
#@return O sistema com a variável
function retorno = recebeVariavel(sistema, novaVariavel)
    sistema = clearCalculado(sistema);

    sistema.var(columns(sistema.var)+1) = novaVariavel;

    retorno = sistema;

endfunction

#Recebe uma grandeza
#@param sistema - Sistema que receberá a variável
#@param grandeza - A grandeza que será recebida
#@return O sistema com a grandeza
function retorno = recebeGrandeza(sistema, grandeza)
    sistema = clearCalculado(sistema);
    
    sistema.grandeza(columns(sistema.grandeza)+1) = grandeza;

    retorno = sistema;

endfunction

function retorno = recebeCargaDist(sistema, carga)
    sistema = clearCalculado(sistema);
    
    sistema.carga(columns(sistema.carga)+1) = carga;

    grandeza = transformaCargaEmGrandeza(carga);

    sistema.grandeza(columns(sistema.grandeza)+1) = grandeza;

    retorno = sistema;
endfunction

#Resolve o sistema
#@param - O sistema a ser resolvido
#@return O sistema resolvido, caso seja possível (verificar atributo calculado)
function retorno = solve(sistema)
    for i = 1:columns(sistema.var)
        sistema.var(i) = calculaCoeficienteMomento(sistema.var(i), sistema.x,sistema.y,sistema.z);
    endfor

    for i = 1:columns(sistema.grandeza)
        sistema.grandeza(i) = calculaCoeficienteMomento(sistema.grandeza(i), sistema.x,sistema.y,sistema.z);
    endfor 

    sistema = clearCalculado(sistema);
    
    for i = 1: columns(sistema.var)
        for j = 1:6
            sistema.A(j,i) = sistema.var(i).coeficiente(j);
        endfor
    endfor

    for i = 1:columns(sistema.grandeza)
        for j = 1:6
            sistema.b(j) -= sistema.grandeza(i).magnitude * sistema.grandeza(i).coeficiente(j);
        endfor

    endfor


    A = [];
    b = [];

    indice = 1;

    for i = 1:6
        zero = true;
        for j = 1:columns(sistema.A(i,:))
            
            if(sistema.A(i,j) != 0)
                zero = false;
                break
            endif
        endfor

        if(!sistema.b(i) == 0 )
                b(indice) = sistema.b(i);

                for j = 1:columns(sistema.A(i,:))
                    A(indice,j ) = sistema.A(i, j);
                endfor

                indice += 1;
        endif

    endfor

    indiceVar = 1:columns(sistema.var);

    #Remove colunas apenas com 0
    for j = columns(A):-1:1
        zero = true;
        for i = rows(A):-1:1
            if(A(i,j) != 0)
                zero = false;
                break
            endif
        endfor
        
        if(zero)
            A(:,j) = [];
            indiceVar(j) = [];

            sistema.var(j) = setValor(sistema.var(j), 0);
        endif

    endfor

    try
        #sistema.teste1 = A;
        #sistema.teste2 = b;
        #retorno = sistema;
        #return
        

        result = inv(A) * b';
    catch err
        retorno = sistema;
        disp("ERRO: Sistema não pode ser resolvido");

        return
    end_try_catch

    for i = 1:rows(result)
        sistema.var(indiceVar(i)) = setValor(sistema.var(indiceVar(i)), result(i));

        #{
        if(strcmp(sistema.var(indiceVar(i)).nome,"engastado Momento") == 1)
            sistema.var(indiceVar(i)).magnitude*=-1

        endif
        #}

    endfor


    sistema.calculado = true;

    retorno = sistema;
endfunction

#Merge sistemaB no sistemaA
#@param sistemaA - O sistema que receberá o outro sistema
#@param sistemaB - Sistema que será recebido
#@return SistemaA com variáveis do sistemaB
function retorno =  merge(sistemaA, sistemaB)
    
    if(sistemaB.x<sistemaA.x)
        cesta = sistemaB;
        sistemaB = sistemaA;
        sistemaA = cesta;
    endif

    indice = columns(sistemaA.var)+1;


    for i = 1:columns(sistemaB.var)
        sistemaA.var(indice) = calculaCoeficienteMomento(sistemaB.var(i), sistemaA.x,sistemaA.y,sistemaA.z);

        indice+=1;
    endfor


    retorno = clearCalculado(sistemaA);
endfunction