includes HomeNet;

configuration Ch4_DoorLock_31C { }
implementation { 

  components MainC, Ch4_DoorLock_31M, LedsC, new TimerMilliC(); 
      Ch4_DoorLock_31M.Boot -> MainC;
      Ch4_DoorLock_31M.Timer -> TimerMilliC;
      Ch4_DoorLock_31M.Leds -> LedsC;

  components new SensirionSht11C(), new PhotoSensorC(), new UltraredSensorC(), new VoltageC(); 
      Ch4_DoorLock_31M.Read_Humi -> SensirionSht11C.Humidity; 
      Ch4_DoorLock_31M.Read_Temp -> SensirionSht11C.Temperature; 
      Ch4_DoorLock_31M.Read_Photo -> PhotoSensorC; 
      Ch4_DoorLock_31M.Read_Ultrared -> UltraredSensorC; 
      Ch4_DoorLock_31M.Read_Voltage -> VoltageC;  

  components ActiveMessageC, new AMSenderC(AM_HOMENET), new AMReceiverC(AM_HOMENET); 
      Ch4_DoorLock_31M.CommControl -> ActiveMessageC; 
      Ch4_DoorLock_31M.AMSend -> AMSenderC; 
      Ch4_DoorLock_31M.Receive -> AMReceiverC;  

  components RelayC, new TimerMilliC() as RelayTimerC;
      Ch4_DoorLock_31M.Relay -> RelayC;
      Ch4_DoorLock_31M.RelayTimer -> RelayTimerC;  
}  
