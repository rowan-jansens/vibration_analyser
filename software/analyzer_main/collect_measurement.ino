void collect_measurement(int num_data_points){

  double data_array[3][num_data_points];

  double t_start = micros();

  for (int i = 0; i < num_data_points; i++){
  
    //compute and print RPM
    rpm = 60000000 / (rpmtime);
    Vector normAccel = mpu.readRawAccel();
    double time_stamp = micros() - t_start;

    
    data_array[0][i] = time_stamp;
    data_array[1][i] = normAccel.YAxis;
    data_array[2][i] = time_of_motor_0;
  }

  digitalWrite(13, HIGH);
  delay(10);


  
  for (int i = 0; i < num_data_points; i++){
    Serial.print(data_array[0][i]);
    Serial.print(" ");
    Serial.print(data_array[1][i]);
    Serial.print(" ");
    Serial.print(data_array[2][i]);
    Serial.write(10);
    digitalWrite(13, LOW);
    delay(2);
  }
  
}
