source grandeza.m

function novaVar = novaVariavel()
    novaVar = novaGrandeza()

    novaVar.calculada = false

endfunction

function retorno = setValor(var, valor)
    var.calculada = true

    var.magnitude = valor

    retorno = var
endfunction

function retorno = setNaoCalculado(var)
    car.calculada = false
    var.magnitude = 0

endfunction