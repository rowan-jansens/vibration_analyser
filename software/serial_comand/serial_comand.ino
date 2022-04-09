int serial_data = 0;

void setup() {
  pinMode(13, OUTPUT);
  Serial.begin(9600);

}

void loop() {
    if(Serial.available() > 0){   //check if any data was received
    serial_data = Serial.read();
    Serial.println(serial_data, DEC);

    if (serial_data == 1){
      digitalWrite(13, HIGH);
      delay(1000);
      digitalWrite(13, LOW);
      //serial_data = 0;
        
    }
    
//    switch(serial_data){
//      case '1':
//
//        digitalWrite(13, HIGH);
//        delay(1000);
//        digitalWrite(13, LOW);
//        break;
//
//    }
    }
    //Serial.println(48, DEC);


}
