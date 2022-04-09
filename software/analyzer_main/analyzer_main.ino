#include <Servo.h>
#include <Wire.h>

#include <MPU6050.h>

MPU6050 mpu;

int esc_pin = 9;
int led_pin = 13;
int encoder_interupt_pin = 2;
int e_stop_pin = 8;


int num_data_points = 2000;


//ISR vairables for RPM
volatile float rpmtime = 1, t, t_start;
double rpm;
double data_array[3][2000];

//servo object + speed
Servo ESC;
int command_speed = 20;

void setup() {

  
  
  //start serial connection
  Serial.begin(115200);
  while(!Serial){}
  //e-stop wire
  pinMode(e_stop_pin, INPUT_PULLUP);
  //LED
  pinMode(led_pin, OUTPUT);
  //ESC
  ESC.attach(esc_pin,1000,2000);
  ESC.write(0);
  

  //init. timer for RPM measuring

  
  Serial.println("Initialize MPU6050");

  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }

  checkSettings();


  delay(500);

  //attach encoder as interupt
  pinMode(encoder_interupt_pin, INPUT);
  attachInterrupt(encoder_interupt_pin, RPM, FALLING);

  t_start = micros();
}

void loop() {

  
  

  
  //double t1 = micros();
  run_motor(ESC, command_speed, e_stop_pin);
  
  //compute and print RPM
  rpm = 60000000 / (rpmtime);
  //Serial.println(rpm);


  Vector normAccel = mpu.readNormalizeAccel();
  Serial.println(normAccel.YAxis);
  //double t2 = micros();
  //Serial.println(t2-t1);


  //=============check for serial command ======================
  //============================================================
  //if(Serial.available() > 0){   //check if any data was received
    //int serial_data = Serial.read();
    //Serial.println(serial_data, DEC);

    //if (serial_data == 1){
    //}
 // }
}

//ISR for encoder
void RPM () {
  t = micros();
  rpmtime = t - t_start;
  t_start = t;
}
