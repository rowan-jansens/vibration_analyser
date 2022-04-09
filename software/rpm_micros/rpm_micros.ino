
volatile unsigned long rpmtime, t, t_start;

void setup() {
  
  //start serial connection
  Serial.begin(9600);
  rpmtime = 0;
  
  pinMode(2, INPUT);
  attachInterrupt(2, RPM, RISING);
  t_start = micros();
}

void loop() {
  Serial.println(rpmtime);
  delay(100);
}

void RPM() {
  t = micros();
  rpmtime = t - t_start;
  t_start = t;
  Serial.print("poo");
}
