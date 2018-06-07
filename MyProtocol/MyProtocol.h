
/*       Packet Struct define      */
typedef struct _MyPacket{
	uint16_t SrcAddr;
	uint16_t DstAddr;
	uint16_t PacketType;
	uint16_t Actions;
}MyPacket_t;


/*       Packet Type define        */
#define GasDetectEvent	0x01
//#define FireDetectEvent	0x02
//...


/*          Actions define         */
#define TurnOffPower	0x01
//#define ConnectToFireStation 0x02 
//...
