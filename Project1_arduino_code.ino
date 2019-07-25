#include <Servo.h>

// for servo motor
Servo control;  
int servoPin = 11;
int angle = 0;    // the angle which the shaft makes

// for HC-sr04
int triggerPin = 6;
int echoPin = 7;
float time_taken;//time taken for the ultrasonic rays to hit the target and return;
int distance;//distance of the object 

// for buzzer
int buzzerPin = 9;


//function declaration
/* the reason int is used is because, when we read input in processing,
 it requires us to use an integer while converting data being read as string.
 string to double(using typecasting) is unacceptable in syntax.
 */
float time_elapsed();
int object_distance(int duration);

void setup() {
  control.writeMicroseconds(1500);
   Serial.begin(9600); // begin serial monitor
   
  control.attach(servoPin); // assigning signal pin for servo

// assigning pinMode for HC
    pinMode(triggerPin,OUTPUT);
    pinMode(echoPin,INPUT);
   
}

void loop() {
  for (angle = 20; angle <= 160; angle++) 
  { // makes the servo go from 0 => 90
      noTone(buzzerPin);

    control.write(angle);

    //calculates and outputs distance of an object
    time_taken = time_elapsed();
    distance = object_distance(time_taken);

    if(distance <=8)
    {
      tone(buzzerPin,5000);
      
    }
    else if(distance > 8 && distance <= 15)
    {
      delay(25);
      tone(buzzerPin,5000);
    }

    else if(distance>15 && distance <= 25)
    {
      delay(50);
      tone(buzzerPin,5000);
    }
    
    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");              

    delay(50);                                
  }
  
  for (angle = 160; angle > 20; angle--) 
  { // makes the servo go from 90 => 0
    noTone(buzzerPin);
    control.write(angle); 

    //calculates and outputs distance of an object
    time_taken = time_elapsed();
    distance = object_distance(time_taken);
    
    if(distance <=8)
    {
      tone(buzzerPin,5000);
    }
    else if(distance > 8 && distance <=15)
    {
      delay(25);
      tone(buzzerPin,5000);
    }

    else if(distance>15 && distance<=20)
    {
      delay(50);
      tone(buzzerPin,5000);
    }
    
    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");             

    delay(50);                           
  }

  
}

//function definition for time_elapsed
float time_elapsed()
{
  digitalWrite(triggerPin,LOW);
  delayMicroseconds(2);
  digitalWrite(triggerPin,HIGH);
  delayMicroseconds(10); //since
  float time1 = pulseIn(echoPin,HIGH);
  return time1;
}

//function definition for object_distance
int object_distance(float duration)
{
  int distance = (duration*0.0343)/2;
  return distance;
}
