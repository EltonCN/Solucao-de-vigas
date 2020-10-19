disp("")

function novaGrandeza = novaGrandeza()
    novaGrandeza = struct("magnitude", 0, "coeficiente", [0,0,0,0,0,0] , "tipo", false)

endfunction


function retorno = calculaCoeficienteMomento(grandeza, deltaX, deltaY, deltaZ)
    if(grandeza.tipo)
        retorno = grandeza
        return
    endif

    posicao = [deltaX,deltaY,deltaZ]

    forca = [grandeza.coeficiente(1),grandeza.coeficiente(2),grandeza.coeficiente(3)]
    
    momento = cross(posicao, forca)

    grandeza.coeficiente(4) = momento(1)
    grandeza.coeficiente(5) = momento(2)
    grandeza.coeficiente(6) = momento(3)

    retorno = grandeza

endfunction