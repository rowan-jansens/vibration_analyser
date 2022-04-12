
#include <Servo.h>
#include <Wire.h>

#include <MPU6050.h>

MPU6050 mpu;

int esc_pin = 9;
int led_pin = 13;
int encoder_interupt_pin = 2;
int e_stop_pin = 8;

int serial_data = 0;

int serial_data_scale = 10;


//ISR vairables for RPM
volatile float rpmtime = 1, t, t_start;
double rpm;

//servo object + speed
Servo ESC;
int command_speed = 20;

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
  

  //init. timer for RPM measuring


  //Serial.println("Initialize MPU6050");

  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }

  //checkSettings(mpu);


  delay(500);

  //attach encoder as interupt
  pinMode(encoder_interupt_pin, INPUT);
  //attachInterrupt(encoder_interupt_pin, RPM, FALLING);

  t_start = micros();
}

void loop() {
  digitalWrite(13, HIGH);

  
  run_motor(ESC, command_speed, e_stop_pin);
  
  //compute and print RPM
  rpm = 60000000 / (rpmtime);
  


  Vector normAccel = mpu.readNormalizeAccel();

  Serial.print(normAccel.YAxis);
  Serial.write(13);



  //=============check for serial command ======================
  //============================================================
  if(Serial.available() > 0){   //check if any data was received
    serial_data = Serial.read();
    
    //Serial.println(serial_data, DEC);

    if (serial_data > 0){
      digitalWrite(13, LOW);
      collect_measurement(serial_data * serial_data_scale, mpu);
      digitalWrite(13, HIGH);
    }
  }
}

//ISR for encoder
void RPM () {
  t = micros();
  rpmtime = t - t_start;
  t_start = t;
}
