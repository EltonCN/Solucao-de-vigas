source grandeza.m

function retval = recebeGrandezas(grandezas)
  numDeGrandezas = input("Quantas grandezas teremos? Total de forças não distribuídas, momentos e torques?: \n");
  
  for i = 1: numDeGrandezas
    
    x = input("Qual a posição x da grandeza?: ");
    y = input("Qual a posição y da grandeza?: ");

    grandezas(i) = novaGrandeza(x, y);

    grandezas(i).tipo = input("A grandeza é um momento? Sim = 1, Não = 0: ");

    eixo = input("Qual o eixo da grandeza? x = 1, y = 2, z = 3: ");

    grandezas(i).magnitude = input("Qual a magnitude da grandeza (utilize valor negativo para indicar uma orientação contrária ao eixo)?: ");

    if(grandezas(i).tipo)
      eixo += 3;
    endif

    
    grandezas(i).coeficiente(eixo) = 1;
  endfor
  
  retval = grandezas;
endfunction