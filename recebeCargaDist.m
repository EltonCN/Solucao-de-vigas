function retval = recebeCargaDist(cargaDist)
  numDecargaDist = input("Quantos cargas distribuídas teremos? \n");
  
  for i = 1: numDecargaDist
    
    cargaDist{i}.nome = input("qual o titulo da carga distribuída?: ");
    cargaDist{i}.comp = input("qual o comprimento da carga distribuída?: ");
    cargaDist{i}.func = input("qual a função que descreve carga distribuída?: ");
    cargaDist{i}.dimen = input("qual a dimensão da carga distribuída?: ");
    cargaDist{i}.eixo = input("qual o eixo de simetria da carga distribuída?: ");
    cargaDist{i}.dist = input("qual a distancia da origem?: ");
  endfor
  
  retval = cargaDist;
endfunction