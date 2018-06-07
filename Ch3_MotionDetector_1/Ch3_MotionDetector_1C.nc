includes HomeNet;

configuration Ch3_MotionDetector_1C { }
implementation { 

  components MainC, Ch3_MotionDetector_1M, LedsC, new TimerMilliC(); 
      Ch3_MotionDetector_1M.Boot -> MainC;
      Ch3_MotionDetector_1M.Timer -> TimerMilliC;
      Ch3_MotionDetector_1M.Leds -> LedsC;

  components new SensirionSht11C(), new PhotoSensorC(), new UltraredSensorC(), new VoltageC(); 
      Ch3_MotionDetector_1M.Read_Humi -> SensirionSht11C.Humidity; 
      Ch3_MotionDetector_1M.Read_Temp -> SensirionSht11C.Temperature; 
      Ch3_MotionDetector_1M.Read_Photo -> PhotoSensorC; 
      Ch3_MotionDetector_1M.Read_Ultrared -> UltraredSensorC; 
      Ch3_MotionDetector_1M.Read_Voltage -> VoltageC;  

  components ActiveMessageC, new AMSenderC(AM_HOMENET), new AMReceiverC(AM_HOMENET); 
      Ch3_MotionDetector_1M.CommControl -> ActiveMessageC; 
      Ch3_MotionDetector_1M.AMSend -> AMSenderC; 
      Ch3_MotionDetector_1M.Receive -> AMReceiverC;  

  components new PirSensorC(), ZigbexBusC, new TimerMilliC() as PirTimerC; 
      Ch3_MotionDetector_1M.Pir -> PirSensorC;
      Ch3_MotionDetector_1M.PirPw -> ZigbexBusC.PW3;
      Ch3_MotionDetector_1M.PirTimer -> PirTimerC;  
}  
