source grandeza.m

function retval = recebeGrandezas(grandezas)
  numDeForcas = input("Quantas grandezas teremos? Total de forças não distribuídas, momentos e torques?: \n");
  
  for i = 1: numDeGrandezas
    
    x = input("Qual a posição x da grandeza?: ");
    y = input("Qual a posição y da grandeza?: ");

    grandezas(i) = novaGrandeza(x, y);

    grandezas(i).magnitude = input("Qual a magnitude da grandeza?: ");

    grandeza(i).tipo = input("A grandeza é um momento? Sim = 1, Não = 0: ");

    eixo = input("Qual o eixo da grandeza? x = 1, y = 2 z = 3: ");

    if(grandeza(i).tipo)
      eixo += 3;
    endif

    grandeza(i).coeficiente(eixo) = 1;
  endfor
  
  retval = grandezas;
endfunction