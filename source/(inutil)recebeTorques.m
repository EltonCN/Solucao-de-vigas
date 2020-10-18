function retval = recebeTorques(torques)
  numDeTorques = input("Quantos torques teremos? \n");
  
  for i = 1: numDeTorques
    
    torques{i}.nome = input("qual o titulo do torque?: ");
    torques{i}.orient = input("qual a orientação to torque?: ");
    torques{i}.modulo = input("qual modulo do torque?: ");
    torques{i}.dist = input("qual a distancia da origem?: ");
    
  endfor
  retval = torques;
endfunction