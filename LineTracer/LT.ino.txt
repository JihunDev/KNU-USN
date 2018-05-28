
unsigned char runSpeed = 50; //모터의 속도 변수 50지정
unsigned char leftSpeed; //leftSensor 변수
unsigned char rightSpeed; //rightSensor 변수

boolean leftSensor = 0; //leftSensor의 변수 초기값(0) 지정
boolean rightSensor = 0; //rightSensor의 변수 초기값(0) 지정
unsigned char sensor; //leftSensor와 rightSensor의 합을 저장할 변수 

void setup(){

  pinMode(2, OUTPUT); //2pin output 지정
  pinMode(3, OUTPUT); //3pin output 지정
  pinMode(4, INPUT);  //4pin input 지정
  pinMode(8, OUTPUT); //8pin output 지정
  pinMode(11, OUTPUT); //11pin output 지정
  
  Serial.begin(9600); //serial 통신 보드레이트 9600 으로 설정
  Serial.println("Serial Monite Commucation Start!");
 
  while (1) { // 무한 루프
    if(digitalRead(4) == 1) { //4pin에 입력이 들어오면
      StartTone(); //start 음 출력
       for(int i = 0; i < 3; i++) {
          digitalWrite(2, HIGH);
          digitalWrite(3, HIGH);
          delay(100);
          digitalWrite(2, LOW);
          digitalWrite(3, LOW); 
          delay(100);
        } //for 문을 이용하여 led가 3번 깜빡임
      break; //무한 루프에서 빠져 나옴 
     }
   }
}

void loop() {
  
  leftSensor = !digitalRead(A5); //5pin에 값을 leftSensor 변수에 저장
  rightSensor = !digitalRead(A4); //4pin에 값을 rightSensor 변수에 저장

  sensor = leftSensor + 2*rightSensor; //sensor변수에 leftSensor(0,1)과 rightSensor(0,2)의 값을 저장
  
  
  Serial.print("leftSensor : ");
  Serial.print(leftSensor);
  Serial.print("rightSensor : ");
  Serial.print(rightSensor);
  Serial.print("Sensor : ");
  Serial.println(sensor);
  //serial 모니터에서 각각의 값확인 을 위해 print 출력
  SensorRun(sensor);

  digitalWrite(8, HIGH); //모터 출력을 HIGH로 설정
  digitalWrite(11, HIGH);
  
  analogWrite(9, 0xff-leftSpeed); //모터의 속도 설정
  analogWrite(10, 0xff-rightSpeed);
  
  digitalWrite(2, leftSensor); //센서의 값이 있을때 2pin 으로 출력
  digitalWrite(3, rightSensor); //센서의 값이 있을때 3pin 으로 출력
 
  if(digitalRead(4) == 1) { // 4pin에 값이 있으면
    while (1) { // 무한 루프
      delay(1000); //1초의 시간 딜레이를 갖고
      if(digitalRead(4) == 1) { // 4pin에 값이 있으면
        StartTone(); // start음을 내고
        break; // 무한 루프를 빠져나온다
       }
     }
  }
}

void SensorRun(char sr) {
  switch(sr){
       case 0x01: //값이 1일때 left가 움직임
         leftSpeed = runSpeed;
         rightSpeed = 0;
         break;
       case 0x02: // 값이 2일때 right가 움직임
         leftSpeed = 0;
         rightSpeed = runSpeed;
         break;
       case 0x03: //값이 3일때 움직이지 않고 stop음을 출력
         leftSpeed = 0;
         rightSpeed = 0;
         StopTone();
         break;
       case 0x00: //값이 0일때 left와 right모두 움직임
         leftSpeed = runSpeed;
         rightSpeed = runSpeed;
         break;  
   }
}

void StartTone() {
  tone(7,262,250);
  delay(300);
  tone(7,330,250);
  delay(300);
  tone(7,392,250);
  delay(300);
  noTone(7);
  delay(300);
}// start음 출력

void StopTone() {
  tone(7,370,350);
  delay(300);
} // stop음 출력