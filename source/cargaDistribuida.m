source grandeza.m

function novaCarga = novaCarga(x, comprimento)

    novaCarga = novaGrandeza(x,0);

    novaCarga.comprimento = comprimento;
    novaCarga.polinomio = [0,0,0,0];

endfunction

function retorno = defineCoeficiente(carga, c, x, x2, x3)

    carga.polinomio = [c,x,x2,x3];
    
    retorno = carga;

endfunction