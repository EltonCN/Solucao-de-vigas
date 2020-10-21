source grandeza.m

#Cria uma nova carga distribuída
#@param x - Posição de início da carga no eixo x
#@param comprimento - Comprimento da carga no eixo x
#@return A nova carga criada
function novaCarga = novaCarga(x, comprimento)

    novaCarga = novaGrandeza(0,0);

    novaCarga.comprimento = comprimento;
    novaCarga.polinomio = [0,0,0,0];
    novaCarga.inicio = x;
    novaCarga.fim = x+comprimento;
    novaCarga.coeficiente(2) = 1;

endfunction

function grandeza = transformaCargaEmGrandeza(carga)

    grandeza = novaGrandeza(carga.x,carga.y);

    carga = cargaParaPonto(carga);

    grandeza.coeficiente = carga.coeficiente;
    grandeza.magnitude = carga.magnitude;
    grandeza.nome = carga.nome;
    grandeza.tipo = carga.tipo;
    grandeza.z = carga.z;

endfunction

#Define os coeficientes do polinômio de uma carga
#@param carga - A carga que terá coeficientes determinados
#@param c - Coeficiente x^0
#@param x - Coeficiente x^1
#@param x2 - Coeficiente x^2
#@param x3 - Coeficiente x^3
#@return A carga com coeficientes inseridos
function retorno = defineCoeficiente(carga, c, x, x2, x3)

    carga.polinomio = [c,x,x2,x3];
    
    retorno = carga;

endfunction

#Calcula a força pontual equivalente a carga
#@param cargasDist - Carga distribuída que será convertida
#@return A carga com posição e magnitude determinados
function retval = cargaParaPonto(cargaDist)
    
    a = cargaDist.polinomio(4);
    b = cargaDist.polinomio(3);
    c = cargaDist.polinomio(2);
    d = cargaDist.polinomio(1);
    f1 = @(x) a.*x.^3.+b.*x.^2.+c.*x.+d; 
    f2 = @(x) x.*(a.*x.^3.+b.*x.^2.+c.*x.+d);
 
    [q1, ier1, nfun1, err1] = quad(f1, cargaDist.inicio, cargaDist.fim);
    [q2, ier2, nfun2, err2] = quad(f2, cargaDist.inicio, cargaDist.fim);

    cargaDist.x = q2/q1;
    cargaDist.magnitude = q1;

    retval = cargaDist;
endfunction