const int xPin = A0;
const int yPin = A1;

void setup() {
  Serial.begin(9600);
  
}

void loop() {
  
  Serial.print(analogRead(xPin));
  Serial.print(":");
  Serial.println(analogRead(yPin)); 
  Serial.print("|");

}
