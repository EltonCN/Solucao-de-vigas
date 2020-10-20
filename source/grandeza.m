1;


#tipo = true indica que é um momento
function novaGrandeza = novaGrandeza(x, y)
    novaGrandeza = struct("magnitude", 0, "coeficiente", [0, 0, 0, 0, 0, 0] , "tipo", false, "x", x, "y", y, "z", 0);

endfunction


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