includes HomeNet;

configuration Ch5_Outlet_61C { }
implementation { 

  components MainC, Ch5_Outlet_61M, LedsC, new TimerMilliC(); 
      Ch5_Outlet_61M.Boot -> MainC;
      Ch5_Outlet_61M.Timer -> TimerMilliC;
      Ch5_Outlet_61M.Leds -> LedsC;

  components new SensirionSht11C(), new PhotoSensorC(), new UltraredSensorC(), new VoltageC(); 
      Ch5_Outlet_61M.Read_Humi -> SensirionSht11C.Humidity; 
      Ch5_Outlet_61M.Read_Temp -> SensirionSht11C.Temperature; 
      Ch5_Outlet_61M.Read_Photo -> PhotoSensorC; 
      Ch5_Outlet_61M.Read_Ultrared -> UltraredSensorC; 
      Ch5_Outlet_61M.Read_Voltage -> VoltageC;  

  components ActiveMessageC, new AMSenderC(AM_HOMENET), new AMReceiverC(AM_HOMENET); 
     Ch5_Outlet_61M.CommControl -> ActiveMessageC; 
     Ch5_Outlet_61M.AMSend -> AMSenderC; 
     Ch5_Outlet_61M.Receive -> AMReceiverC;  

  components RelayC, new TimerMilliC() as RelayTimerC;
     Ch5_Outlet_61M.Relay -> RelayC;
     Ch5_Outlet_61M.RelayTimer -> RelayTimerC;  
}  
