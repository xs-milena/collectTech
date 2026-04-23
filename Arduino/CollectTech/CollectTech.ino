// DEFINE O USO DA BIBLIOTECA
#include "Ultrasonic.h"

// DEFINIR PORTAS DE ENTRADA E SAIDA DE DADOS DO SENSOR
const int PINO_TRIGGER = 13;
const int PINO_ECHO = 12;

// CRIA O OBJETO SENSOR USANDO OS PINOS DEFINIDOS
HC_SR04 sensor(PINO_TRIGGER, PINO_ECHO);

// INICIA A COMUNICAÇÃO SERIAL
void setup() {
  Serial.begin(9600);
}


void loop (){
  // // IMPRIME A MENSAGEM
  // Serial.print("Distancia: ");
  float distance = sensor.distance();
  float conta = (100 - (distance*100)/112); 
  if(conta < 0){
    conta = 100;
  }


  Serial.println(conta);
  // Serial.println(";");

  // DEFINE O INTERVALO
  delay(1000);
}

// 1 - o sensor mede a distância
// 2 - transforma essa distância em %
// 3 - divide por 112 (altura do pupto)
// 4 - o 100 é 100% da capacidade da lixeira