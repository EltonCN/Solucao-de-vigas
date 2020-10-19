source grandeza.m
source variavel.m
source sistemaLinear.m

grandeza = novaGrandeza()
grandeza.magnitude = 10
grandeza.coeficiente(1) = 1


var = novaVariavel()
var.coeficiente(1) = 1


sistema = novoSistema(0,0)
sistema = recebeVariavel(sistema, var)
sistema = recebeGrandeza(sistema, grandeza)

#sistema = solve(sistema)

var2 = novaVariavel()
var2.coeficiente(2) = 1

sistema = recebeVariavel(sistema, var2)
sistema = solve(sistema)

sistema2 = novoSistema(0,0)
