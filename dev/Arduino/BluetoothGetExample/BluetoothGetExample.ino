#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
 
const char* ssid = "Bascope";
const char* password = "Porongo2163";
String codigoNFC="BETO123";
String mainURL = "http://192.168.0.14/micruber/api/";
String requestURL = mainURL + "usuarios?codigoNFC="+codigoNFC;
DynamicJsonDocument doc(1024);
 
void setup () {
 
Serial.begin(115200);
WiFi.begin(ssid, password);
 
while (WiFi.status() != WL_CONNECTED) {
 
delay(1000);
Serial.print("Connecting..");
 
}
 
}
 
void loop() {
 
if (WiFi.status() == WL_CONNECTED) { //Check WiFi connection status
Serial.println("concectado al wifi"); 
HTTPClient http;  //Declare an object of class HTTPClient

Serial.println(requestURL); 
http.begin(requestURL); 
int httpCode = http.GET();                                                                  //Send the request
 Serial.print("respuesta httpcode");
 Serial.println(httpCode);
if (httpCode > 0) { //Check the returning code
 
String payload = http.getString();   //Get the request response payload
//Serial.println(payload);                     //Print the response payload
Serial.println(payload); 
deserializeJson(doc, payload);
JsonObject obj = doc.as<JsonObject>();
int usuarioId = obj[String("usuarioId")];
float saldo = obj[String("saldoActual")];
if(saldo > 0)
{
  //dejar pasar  
}else
{
// no dejar pasar
}
http.end();   //Close connection
 
}
 
delay(1000);    //Send a request every 30 seconds
 
}
