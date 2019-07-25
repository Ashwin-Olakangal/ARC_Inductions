import processing.serial.*;

Serial myport;

//for taking input from serial monitor
int xInput,yInput;

String data,x,y;

float circleX = 512, circleY = 512,center = 512;

float speedX = 2,speedY = 2;

int life=3,score=0,n=1;

void setup()
{
  size(1224,1024);
  background(51);
  
  myport = new Serial (this, "COM3",9600);
  myport.bufferUntil('|');
}

void draw()
{
  fill(51,255);
  
  stroke(255,0,0);
  strokeWeight(2);
  
  rect(0,0,width,height);
  line(width-200,0,width-200,height);
  
  if(life == 0){
  background(51);
  fill(255,0,0,255);
  stroke(255,0,0);
  strokeWeight(2);
  textSize(30);
  text("Thank you for playing",width/2,650);
  text("Score: "+score,width/2,700);
  delay(7000);
  exit();
}

  user_paddle();
  ball();
  bounce(); 
  life_and_score();
  display();
}

void serialEvent(Serial myport)
{
  data = myport.readStringUntil('|');
  data = data.substring(0,data.length()-1);
  
  int index = data.indexOf(":");
  
  x = data.substring(0,index);
  y = data.substring(index+1,data.length()-1);
  
  xInput = int(x);
  yInput = int(y);
}

void user_paddle()
{
  stroke(255,0,0);
  strokeWeight(9);
  if(xInput>=200 && xInput <=924)
  {
    line(xInput-100,1000,xInput+100,1000);
  }
  
  else if(xInput < 200)
  line(0,1000,200,1000);
  
  else
  line(824,1000,1024,1000);
  
}

void ball()
{
  fill(255,0,0);
  stroke(255,0,0);
  circle(circleX,circleY,50);
  circleX += speedX;
  circleY += speedY;
}

void bounce()
{
  //y component
  if(xInput >=200 && xInput <=924)
  {
    if(circleY >= height-49 && (circleX >= xInput-100 && circleX <= xInput+100))
    {
      n += 1;
      speedY -= pow(2,n);
      score += 10;
    }
  }
  else // when xInput < 200 || xInput > 924
  {
    if(circleY >= height-49 && circleX > 924 && xInput > 924)
    {
      n += 1;
      speedY -= pow(2,n);
      score += 10;
    }
    
    else if(circleY >= height-49 && circleX < 200 && xInput < 200)
    {
      n += 1;
      speedY -= pow(2,n);
      score += 10;
    }
  }
  
  //for other borders
  
  if(circleY <=25)
  {
    n += 0.5;
    speedY += pow(2,n);
  }
  
  if(circleX >= width-225 )
  speedX -= pow(2,n);
  
  else if(circleX <= 25)
  speedX += pow(2,n);
  
  //controlling speed
  if(speedY >= 6)
  n = 1;
  else if(speedY <=2)
  n = 2;
  
}

void life_and_score()
{
 if(xInput >= 200 && xInput <= width-300)
 {
   if(circleY >= height-49 && (circleX < xInput-100 || circleX > xInput+100))
   {
     life--;
     
     if(life == 0)
      redraw();
     
     delay(3000);
     
     circleY = center - random(75,250.0);
     circleX = center - random(75,250.0);
     speedY = 2;
     speedX = 2;
     n = 1;
   }
 }  
 else
  {
    if(circleY >= height-49 && xInput <= 200 && circleX > 200)
    {
         life--;
         
         if(life == 0)
          redraw();
         
         delay(3000);
         
         circleY = center - random(75,250.0);
         circleX = center + random(75,250.0);
         speedY = 2;
         speedX = 2;
         n = 1;
    }
    else if(circleY >= height-49 && xInput >=924  && circleX < 924)
    {
         life--;
         
         if(life == 0)
          redraw();
          
         delay(3000);
         
         circleY = 512 + random(75,250.0);
         circleX = 512 + random(75,250.0);
         speedY = 2;
         speedX = 2;
         n = 1;
     }}
}

void display()
{
  textSize(20);
  text("Score: "+score,width-150,height/2);
  text("Life: "+life,width-150,(height/2) + 40);
}

void end_game()
{
  fill(255,0,0,255);
  rect(0,0,width,height);
 
  fill(51);
  stroke(0,0,255);
  textSize(20);
  text("Thank you for playing",width/2,650);
  delay(2000);
  exit();
}
  
