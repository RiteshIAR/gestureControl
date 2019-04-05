/*
Created by @ritexarma (twitter)
This code is an implementation of serial communication 
Serial data can come from any applicaion such as hyperterminal
or putty or MATLAB
This particular code is to implement serial communication between
arduino and MATLAB for implementing gesture control robot
For more information click here
https://bytestrokes.wordpress.com/
 */

void setup() {
  // initialize serial:
  Serial.begin(9600);
  //Define Output pins for motor output
  pinMode(5, OUTPUT); //Enable left motor
  pinMode(6, OUTPUT); //left motor +
  pinMode(7, OUTPUT); //left motor -
  
  pinMode(10, OUTPUT); //right motor +
  pinMode(11, OUTPUT); //right motor -
  pinMode(12, OUTPUT); //enable right motor
}

void loop() {
  //infinite loop
  while (!Serial.available()) ; //if there is no serial data do nothing
  
  char inChar = Serial.read(); //if data is available read it
   digitalWrite(5, HIGH); //enable left motor
   digitalWrite(12, HIGH); //enable right motor
  if(inChar == 'w' || inChar == 'W') //if data is w or W move forward
  {
    //forward
    digitalWrite(6, HIGH);
    digitalWrite(7, LOW);
    digitalWrite(10, LOW);
    digitalWrite(11, HIGH);  
    }
  
  if(inChar == 'a' || inChar == 'A')  //if data is a or A move left
  {
    //left turn
    digitalWrite(6, HIGH);
    digitalWrite(7, LOW);
    digitalWrite(10, LOW);
    digitalWrite(11, LOW) ; 
    }

  if(inChar == 'd' || inChar == 'D') //if data is d or D move right
  {
    //right turn
    digitalWrite(6, LOW);
    digitalWrite(7, LOW);
    digitalWrite(10, LOW);
    digitalWrite(11, HIGH);  
    }
  
  if(inChar == 's' || inChar == 'S') //if data is s or S move back
  {
    //backward
    digitalWrite(6, LOW);
    digitalWrite(7, HIGH);
    digitalWrite(10, HIGH);
    digitalWrite(11, LOW);
    }

  if(inChar == 'x' || inChar == 'X') //if data is x or X stop
  {
    //stop
    digitalWrite(6, LOW);
    digitalWrite(7, LOW);
    digitalWrite(10, LOW);
    digitalWrite(11, LOW); 
    }
  
}

