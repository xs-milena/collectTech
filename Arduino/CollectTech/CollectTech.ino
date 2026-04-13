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
  Serial.println(sensor.distance());
  // Serial.println(";");

  // DEFINE O INTERVALO
  delay(1000);
}