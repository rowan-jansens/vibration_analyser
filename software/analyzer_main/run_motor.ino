void run_motor(){

  
  //read e_stop pin
  int e_stop = digitalRead(e_stop_pin);

  if (e_stop == HIGH) {
    ESC.write(0);
  } 
  else {
    ESC.write(command_speed);
  }
}
