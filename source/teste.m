source grandeza.m
source variavel.m
source sistemaLinear.m
source recebeGrandezas.m
source esforcoInterno.m

grandeza = novaGrandeza(0, 0);
grandeza.magnitude = 10;
grandeza.coeficiente(1) = 1;


var = novaVariavel(0,0 );
var.coeficiente(1) = 1;


sistema = novoSistema(0,0);
sistema = recebeVariavel(sistema, var);
sistema = recebeGrandeza(sistema, grandeza);

sistema = solve(sistema);

result1 = sistema;

var2 = novaVariavel(10,0);
var2.coeficiente(2) = 1;

sistema2 = novoSistema(10,0);
sistema2 = recebeVariavel(sistema2, var2);

sistema = merge(sistema, sistema2);

#sistema = solve(sistema);

#result2 = sistema;

grandeza2 = novaGrandeza(10,0);
grandeza2.magnitude = 10;
grandeza2.coeficiente(4) = 1;

sistema = recebeGrandeza(sistema, grandeza2);

#sistema = solve(sistema);

#result3 = sistema;

grandeza3 = novaGrandeza(5,0);
grandeza3.magnitude = 10;
grandeza3.coeficiente(4) = 1;

sistema = recebeGrandeza(sistema,grandeza3)

#sistema = bubblesort(sistema)
