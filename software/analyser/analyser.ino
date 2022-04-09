
#include <Servo.h>
Servo ESC;
int speed = 20;

volatile float rpmtime, t, t_start;
float rpm;

//
//tachmyter stuff
#include <Wire.h>




void setup() {
  
  //start serial connection
  Serial.begin(9600);
  //configure pin 2 as an input and enable the internal pull-up resistor

  //switch
  pinMode(8, INPUT_PULLUP);
  //LED
  pinMode(13, OUTPUT);
  //
  ESC.attach(9,1000,2000);
  ESC.write(0);

  rpmtime = 0;


  pinMode(2, INPUT);
  attachInterrupt(2, RPM, FALLING);
  t_start = micros();


}

void loop() {

  //delay(1000);
  //read the pushbutton value into a variable
  int sensorVal = digitalRead(8);
  //print out the value of the pushbutton
  //Serial.println((sensorVal * -1) + 1);

  // Keep in mind the pull-up means the pushbutton's logic is inverted. It goes
  // HIGH when it's open, and LOW when it's pressed. Turn on pin 13 when the
  // button's pressed, and off when it's not:
  if (sensorVal == HIGH) {
    digitalWrite(13, LOW);
    ESC.write(0);
  } else {
    digitalWrite(13, HIGH);
    ESC.write(speed);
  }

  rpm = 60000000 / (rpmtime);
  Serial.println(rpm);

}

void RPM () {
  t = micros();
  rpmtime = t - t_start;
  t_start = t;
}
