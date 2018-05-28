includes HomeNet;

configuration Ch7_GasShutter_51C { }
implementation { 

  components MainC, Ch7_GasShutter_51M, LedsC, new TimerMilliC(); 
      Ch7_GasShutter_51M.Boot -> MainC;
      Ch7_GasShutter_51M.Timer -> TimerMilliC;
      Ch7_GasShutter_51M.Leds -> LedsC;

  components new SensirionSht11C(), new PhotoSensorC(), new UltraredSensorC(), new VoltageC(); 
      Ch7_GasShutter_51M.Read_Humi -> SensirionSht11C.Humidity; 
      Ch7_GasShutter_51M.Read_Temp -> SensirionSht11C.Temperature; 
      Ch7_GasShutter_51M.Read_Photo -> PhotoSensorC; 
      Ch7_GasShutter_51M.Read_Ultrared -> UltraredSensorC; 
      Ch7_GasShutter_51M.Read_Voltage -> VoltageC;  

  components ActiveMessageC, new AMSenderC(AM_HOMENET), new AMReceiverC(AM_HOMENET); 
      Ch7_GasShutter_51M.CommControl -> ActiveMessageC; 
      Ch7_GasShutter_51M.AMSend -> AMSenderC; 
      Ch7_GasShutter_51M.Receive -> AMReceiverC;  

  components MotorC, new TimerMilliC() as GasTimerC;
      Ch7_GasShutter_51M.Motor -> MotorC;
      Ch7_GasShutter_51M.GasTimer -> GasTimerC;  
}  
