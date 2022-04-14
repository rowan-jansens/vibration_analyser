
//motor stuff
#include <Servo.h>
#include <Wire.h>
#include "I2Cdev.h"

//MPU Stuff
#include <MPU6050.h>


MPU6050 mpu;
int16_t ax, ay, az;

//variables
int esc_pin = 9;
int led_pin = 13;
int encoder_interupt_pin = 2;
int e_stop_pin = 8;
int serial_data = 0;
int serial_data_scale = 10;


//ISR vairables for RPM
volatile float time_of_motor_0 = 1, t_start, rpmtime = 1;
double rpm;


//servo object + speed
Servo ESC;
int command_speed = 20;

//==========================================================
//==========================================================

void setup() {
  //start serial connection
  Serial.begin(115200);

  //e-stop wire
  pinMode(e_stop_pin, INPUT_PULLUP);
  //LED
  pinMode(led_pin, OUTPUT);
  //ESC
  ESC.attach(esc_pin,1000,2000);
  ESC.write(0);
  

  //set up MPU
  #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
    #endif
    mpu.initialize();


  delay(500);

  //attach encoder as interupt
  pinMode(encoder_interupt_pin, INPUT);
  attachInterrupt(encoder_interupt_pin, RPM, RISING);

  t_start = micros();
}

//==========================================================
//==========================================================

void loop() {

  //turn on LED when in loop
  digitalWrite(13, HIGH);
  //run motor
  run_motor();
  //compute and print RPM
  rpm = 60000000 / (rpmtime);
  

  //poll MPU
  mpu.getRotation(&ax, &ay, &az);

  //print data
  Serial.print(rpm);
  Serial.print(" ");
  Serial.println(ay);


  //=============check for serial command ======================
  //============================================================
  if(Serial.available() > 0){   //check if any data was received
    serial_data = Serial.read();
    
    //Serial.println(serial_data, DEC);

    //if number is recived, collect that number (times 10) of data points
    if (serial_data > 0){
      digitalWrite(13, LOW);
      collect_measurement(serial_data * serial_data_scale);
      digitalWrite(13, HIGH);
    }
  }
}

//==========================================================
//==========================================================

//ISR for encoder
void RPM () {
  time_of_motor_0 = micros();
  rpmtime = time_of_motor_0 - t_start;
  t_start = time_of_motor_0;
}
