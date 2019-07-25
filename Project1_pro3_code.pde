import processing.serial.*;

//creating an object in Serial class
Serial myPort;

int sensorAngle, objectDistance;

String angle,distance,input; // variables for holding values of data recieved

void setup()
{
 
  size(1600,1000);
  background(51);
  
  myPort = new Serial(this,"COM3",9600); // initializes myPort
  myPort.bufferUntil('.');// waits until recieving '.': to obtain atleast one line of input
}

void draw()
{
   fill(51,5);              
   noStroke();
   rect(0, 150, width, 850); 
   
   noStroke();
   fill(51,255);
   rect(0,0,width,150); 
   
   //calling all the functions
   
   create_arc();
   line_rotation();
   detect_object();
   screen_details();

}

// function definition for serialEvent: defined in inbuilt library
void serialEvent (Serial myPort)
{
  input = myPort.readStringUntil('.');//reads string until it encounters '.'
  input = input.substring(0,input.length()-1);

  int index1 = input.indexOf(","); // reads the index value of ','
  
  angle = input.substring(0,index1); // reads the substring between 0 and , which gives us angle
  distance = input.substring(index1+1, input.length());// reads the remaining string as distance
  
  sensorAngle = int(angle);// converts string to int and gives us sensor angle
  objectDistance = int(distance);//converts string to int and gives us object distance
  System.out.println(sensorAngle);
  
}
  

//function definition to create sonar
void create_arc()
{
  noFill();
  stroke(50,205,50); //rgb numbering for limegreen color
  
  arc(800,1000,1488,1488,PI,TWO_PI);
  arc(800,1000,1116,1116,PI,TWO_PI);
  arc(800,1000,744,744,PI,TWO_PI);
  arc(800,1000,372,372,PI,TWO_PI);
  
  line(800,1000,1449.5,625);//30 deg. line
  line(800,1000,1175,351.5);//60 deg. line
  line(800,1000,800,250);  //90 deg. line
  line(800,1000,425,351.5);//120 deg. line
  line(800,1000,150.5,625);//150 deg. line
  
  
}

//function definition for line used to rotate in sonar
void line_rotation()
{
  strokeWeight(5);
  stroke(50,205,50);
   
  line(800,1000,800+(800*cos(radians(sensorAngle))),1000-(800*sin(radians(sensorAngle))));
}

//function definition for detecting the object
void detect_object()
{
  
    strokeWeight(5);
    stroke(255,0,0);// color code for red in rgb
    
   
    float pixleDist = (objectDistance*20);                        // converts the distance from the sensor from cm to pixels
    
    if(objectDistance<=40)                                                  // limiting the range to 40 cms
    {                               
       //line(0,0,pixleDist,0);  
       line(800+((pixleDist*cos(radians(sensorAngle)))),1000-(pixleDist*sin(radians(sensorAngle))),800+(800*cos(radians(sensorAngle))),1000-(800*sin(radians(sensorAngle))));
    }
    
}


void screen_details()
{
    
    
    fill(255,218,185);
    textSize(20);
    
    text("10cm",(width/2)+(width*0.115),height*0.93);
    text("20cm",(width/2)+(width*0.24),height*0.93);
    text("30cm",(width/2)+(width*0.365),height*0.93);
    text("40cm",(width/2)+(width*0.45),height*0.93);
    
    textSize(40);
    text("Angle :"+angle,730,50);
    
    textSize(28);
    text("Detection:",50,30);
    
    if(objectDistance<=40) {
      text("Distance :"+objectDistance,1200,50);
     
    }
    else
    {
       text("Distance :",1200,50); 
    } 
    
      if(objectDistance >40 || objectDistance == 0)
      {
        fill(128,128,128);
        text("Very Close",50,60);
        text("Near",50,90);
        text("Distant",50,120);
        
        //only highlights this text
        fill(255,218,185);
        text("None",50,150);
      }
      
      else  if(objectDistance>=25 && objectDistance <40)
      {
        fill(128,128,128);
        text("Very Close",50,60);
        text("Near",50,90);
        
        //only highlights this text
        fill(255,218,185);
        text("Distant",50,120);
        
        fill(128,128,128);
        text("None",50,150);
      }
      
      else  if(objectDistance>=15 && objectDistance <25)
      {
        fill(128,128,128);
        text("Very Close",50,60);
        
        //only highlights this text
        fill(255,218,185);
        text("Near",50,90);
        
        fill(128,128,128);
        text("Distant",50,120);
        text("None",50,150);
      }
    
      else if(objectDistance<15)
      {
        //only highlights this text
        fill(255,218,185);
        text("Very Close",50,60);
        
        fill(128,128,128);
        text("Near",50,90);
        text("Distant",50,120);
        text("None",50,150);
      }
     
   fill(255,218,185); // reverts back to original
   
   text("30°",1499.5,605);
   text("60°",1205,291.5);
   text("90°",780,190);
   text("120°",365,291.5);
   text("150°",45.5,605);
    

}
