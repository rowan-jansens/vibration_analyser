void collect_measurement(){
  for (int i = 0; i < 2000; i++){


    run_motor(ESC, command_speed, e_stop_pin);
  
    //compute and print RPM
    rpm = 60000000 / (rpmtime);
    //Serial.println(rpm);
  
  
    Vector normAccel = mpu.readNormalizeAccel();
    double time_stamp = micros();
    //data_array[3][i] = {time_stamp, normAccel.YAxis, rpm);
  }


  
}
