source grandeza.m

#Cria uma nova variável
#@param x - Posição x da variável
#@param y - Posição y da variável
#@return A nova variável
function novaVar = novaVariavel(x, y)
    novaVar = novaGrandeza(x, y);

    novaVar.calculada = false;

endfunction

#Converte a variável para uma grandeza
function grandeza = transformaEmGrandeza(var)

    grandeza = novaGrandeza(var.x,var.y);

    grandeza.coeficiente = var.coeficiente;
    grandeza.magnitude = var.magnitude;
    grandeza.nome = var.nome;
    grandeza.tipo = var.tipo;
    grandeza.z = var.z;

endfunction

#Define a maginitude da variável
#@param var - Variável que terá magnitude determinada
#@param valor - Magnitude
#@return A variável com mangnitude determinada
function retorno = setValor(var, valor)
    var.calculada = true;

    var.magnitude = valor;

    retorno = var;
endfunction

#Define a variável como não calculada
#@param var - Variável
#@return Variável definida como não calculada
function retorno = setNaoCalculado(var)
    car.calculada = false;
    var.magnitude = 0;

    retorno = var;
endfunction