clear
clc

#viga = 0;
#apoios = {};
cargas = {};
cargaPonto = {};
#grandezas = {};

#viga = recebeViga(viga);
#apoios = recebeApoios(apoios);
cargas = recebeCargaDist(cargas);
cargaPonto = cargaParaPonto(cargas);
#grandezas = recebeGrandezas(gradezas);
#disp(grandezas);