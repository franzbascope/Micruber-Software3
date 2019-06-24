#include <SPI.h>
#include <MFRC522.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>

#define pinEncender  D2
#define pinApagar  D1

#define RST_PIN  20
#define SS_PIN  2
MFRC522 mfrc522(SS_PIN, RST_PIN); ///Creamos el objeto para el RC522
String mainURL = "http://192.168.0.14/micruber/api/";
const char* ssid = "Bascope";
const char* password = "Porongo2163";
void setup() {
  Serial.begin(115200); //Iniciamos La comunicacion serial
  SPI.begin();        //Iniciamos el Bus SPI
  mfrc522.PCD_Init(); // Iniciamos el MFRC522
  Serial.println("Comienzo programa");
  pinMode(pinEncender, OUTPUT);
  pinMode(pinApagar, OUTPUT);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {

    delay(1000);
    Serial.print("Connecting..");

  }
}

byte ActualUID[4]; //almacenará el código del Tag leído

void loop() {
  if (WiFi.status() == WL_CONNECTED)
  {
    String identificador = "";
    if ( mfrc522.PICC_IsNewCardPresent())
    {
      //Seleccionamos una tarjeta
      if ( mfrc522.PICC_ReadCardSerial())
      {
        // Enviamos serialemente su UID
        Serial.print(F("Request URL: "));
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          identificador += mfrc522.uid.uidByte[i] < 0x10 ? "0" : "";
          identificador += String( mfrc522.uid.uidByte[i], HEX);
          //                          Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
          //                          Serial.print(mfrc522.uid.uidByte[i], HEX);
          ActualUID[i] = mfrc522.uid.uidByte[i];
        }
        obtenerUsuarioByNFC(identificador);
        Serial.println(identificador);
        mfrc522.PICC_HaltA();

      }

    }
  }else
  {
    Serial.print("Se corto el wifi");
  }


}

void obtenerUsuarioByNFC(String nfc)
{

  DynamicJsonDocument doc(1024);
  HTTPClient http;  //Declare an object of class HTTPClient
  String requestURL = mainURL + "usuarios?codigoNFC=" + nfc;
  Serial.print(requestURL);
  http.begin(requestURL);
  int httpCode = http.GET();                                                                  //Send the request
  if (httpCode > 0) { //Check the returning code
    Serial.print(nfc);
    String payload = http.getString();   //Get the request response payload
    //Serial.println(payload);                     //Print the response payload
    Serial.println(payload);
    deserializeJson(doc, payload);
    JsonObject obj = doc.as<JsonObject>();
    int usuarioId = obj[String("usuarioId")];
    float saldo = obj[String("saldoActual")];
    Serial.print(saldo);
    if (saldo > 0)
    {
      digitalWrite(pinEncender, HIGH);
      delay(1000);
      digitalWrite(pinEncender, LOW);
      Serial.print("entre");
      realizarPago(usuarioId);
    } else
    {
      digitalWrite(pinApagar, HIGH);
      delay(1000);
      digitalWrite(pinApagar, LOW);
    }
    http.end();   //Close connection

  } else
  {
    Serial.print(httpCode);
  }

}
void realizarPago(int usuarioId)
{
  HTTPClient http;    //Declare object of class HTTPClient
  String input = "{\"usuarioId\":" + String(usuarioId) + ",\"vehiculoId\":1,\"lineaId\":1}";
  http.begin("http://192.168.0.14/micruber/api/pagosUsuario");      //Specify request destination
  http.addHeader("Content-Type", "application/json");  //Specify content-type header

  int httpCode = http.POST(input);   //Send the request
  String payload = http.getString();                  //Get the response payload
  Serial.println(payload);    //Print request response payload

  http.end();  //Close connection
}
