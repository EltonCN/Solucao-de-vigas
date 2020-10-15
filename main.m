clear
clc

apoios = {};
forcas = {};
torques = {};
momentos = {};

apoios = recebeApoios(apoios);
forcas = recebeForcas(forcas);
disp(forcas);
torques = recebeTorques(torques);
momentos = recebeMomentos(momentos);