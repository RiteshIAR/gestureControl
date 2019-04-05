/*
Created by @ritexarma (twitter)
This code is an implementation of serial communication 
Serial data can come from any applicaion such as hyperterminal
or putty or MATLAB
This particular code is to implement serial communication between
arduino and MATLAB for controlling servo motor
For more information click here
https://bytestrokes.wordpress.com/
 */

#include <Servo.h>      //include servo header file

Servo panServo;       //create servo object
int pos=90;       //initial position of servo = 90 degree

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);      //begin serial communication at 9600 baud rate

panServo.attach(9);     //attach servo to 9th pin of arduino
panServo.write(pos);      //initialise servo position
}

void loop() {
  // put your main code here, to run repeatedly:
while(!Serial.available());   //if no data available on serial port do nothing

char data = Serial.read();     //else read serial data
if(data == 'a')     // a in matlab code is for object in left
{
pos = pos-1;          //decrease position variable by 1
myPan.write(pos);   //move servo to that position
}
if(data == 's')       //s in matlab code is being sent for center position, do nothing
;
if(data == 'd')     //d is being sent for object in right
{
pos = pos+1;    //increase servo position by 1
myPan.write(pos);
}  
}