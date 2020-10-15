function retval = recebeMomento(momentos)
  numDeMomentos = input("Quantos momentos teremos? \n");
  
  for i = 1: numDeMomentos
    
    momentos{i}.nome = input("qual o titulo do momento?: ");
    momentos{i}.orient = input("qual a orientação to momento?: ");
    momentos{i}.modulo = input("qual modulo do momento?: ");
    momentos{i}.x = input("qual a componente x do momento?: ");
    momentos{i}.y = input("qual a componente y do momento?: ");
    momentos{i}.dist = input("qual a distancia da origem?: ");
    
  endfor
  retval = momentos;
endfunction