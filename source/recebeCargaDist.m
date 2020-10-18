function retval = recebeCargaDist(cargaDist)
  numDecargaDist = input("Quantos cargas distribuídas teremos? \n");
  
  for i = 1: numDecargaDist
    
    #cargaDist{i}.nome = input("qual o titulo da carga distribuída?: ");
    cargaDist{i}.comp = input("qual o comprimento da carga distribuída?: ");
    #cargaDist{i}.dimen = input("qual a dimensão da carga distribuída?: 1D = 1, 2D = 2, 3D = 3 ");
    #cargaDist{i}.eixo = input("qual o eixo de simetria da carga distribuída?: x = 1, y = 2, z = 3 ");
    #cargaDist{i}.dist = input("qual a distancia da origem?: ");
    cargaDist{i}.func.x3 = input("qual o fator de x³?: ");
    cargaDist{i}.func.x2 = input("qual o fator de x²?: ");
    cargaDist{i}.func.x = input("qual o fator de x?: ");
    cargaDist{i}.func.c = input("qual o fator da constante?: ");
    disp(cargaDist{i}.func);
  endfor
  retval = cargaDist;
endfunction