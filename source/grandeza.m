1; #Primeiro comando de um arquivo não pode ser uma função

#Cria uma nova grandeza
#
#coeficiente = coefientes da grandeza nos eixos [x,y,z,Mx,My,Mz] = [1,2,3,4,5,6]
#magnitude = módulo da grandeza
#tipo = true indica que é um momento
#x,y,z = coordenadas de aplicação da grandeza
#
#@param x - Posição x da grandeza
#@param y - posição y da grandeza
#@return A nova grandeza criada
function novaGrandeza = novaGrandeza(x, y)
    novaGrandeza = struct("magnitude", 0, "coeficiente",  [0, 0, 0, 0, 0, 0] , "tipo", false, "x", x, "y", y, "z", 0, "nome", "");

endfunction

#Converte os coeficientes de momento para um outro sistema de coordenadas em x, y, z
#@param grandeza - Grandeza que terá coeficientes convertidos
#@param x - Posição x do novo sistema de coordenadas
#@param y - Posição y do novo sistema de coordenadas
#@param z - Posição z do novo sistema de coordenadas
#@return Grandeza convertida
function retorno = calculaCoeficienteMomento(grandeza, x, y, z)
    if(grandeza.tipo)
        retorno = grandeza;
        return
    endif

    posicao = [grandeza.x-x,grandeza.y-y,grandeza.z-z];

    forca = [grandeza.coeficiente(1),grandeza.coeficiente(2),grandeza.coeficiente(3)];
    
    momento = cross(posicao, forca);

    grandeza.coeficiente(4) = momento(1);
    grandeza.coeficiente(5) = momento(2);
    grandeza.coeficiente(6) = momento(3);

    retorno = grandeza;

endfunction