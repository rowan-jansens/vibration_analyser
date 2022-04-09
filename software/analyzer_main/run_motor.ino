void run_motor(Servo ESC_obj, int command_speed, int e_stop_pin){

  
  //read e_stop pin
  int e_stop = digitalRead(e_stop_pin);

  if (e_stop == HIGH) {
    ESC_obj.write(0);
  } 
  else {
    ESC_obj.write(command_speed);
  }
}