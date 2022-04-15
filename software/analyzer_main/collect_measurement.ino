void collect_measurement(int num_data_points){

  //make empty data array
  double data_array[3][num_data_points];

  //loop and collect the samples
  for (int i = 0; i < num_data_points; i++){
    //save dirrectly into array
    mpu.getAcceleration(&ax, &ay, &az);

    data_array[1][i] = (double) ay  - ay_offset;
    data_array[0][i] = micros();
    data_array[2][i] = time_of_motor_0;

  }

  //turn on led to show that measurement period is complete
  digitalWrite(13, HIGH);
  delay(10);

  //loop again and print array to serial
  for (int i = 0; i < num_data_points; i++){
    Serial.print(data_array[0][i]);
    Serial.print(" ");
    Serial.print(data_array[1][i]);
    Serial.print(" ");
    Serial.print(data_array[2][i]);
    Serial.write(13);  //carrage return char
    digitalWrite(13, LOW);
    //add some dealy for matlab to keep up
    delay(2);
  }
}
