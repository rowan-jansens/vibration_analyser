/*
 SineWavePoints
 
 Write sine wave points to the serial port, followed by the Carriage Return and LineFeed terminator.
 */

int i = 0;
int serial_data = 0;

// The setup routine runs once when you press reset:
void setup() {
  // Initialize serial communication at 9600 bits per second:
  pinMode(13, OUTPUT);
  Serial.begin(9600);
}

// The loop routine runs over and over again forever:
void loop() {

  if(Serial.available() > 0){   //check if any data was received
    serial_data = Serial.read();
    //Serial.println(serial_data, DEC);

    if (serial_data == 1){
      digitalWrite(13, HIGH);
      for (i; i < 2000; i++){
        Serial.print(millis());
        Serial.print(" ");
        Serial.print(sin(i*50.0/360.0));
        Serial.write(13);
        Serial.write(10);
        delay(2);
      }
      digitalWrite(13, LOW);
      //serial_data = 0;
        
    }
  }
}
