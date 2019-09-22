.equ LED1 = PD2
.equ LED2 = PD3
.equ LED3 = PD4
.def AUX = R16

.ORG 0x000
init:
	LDI AUX, 0x00011100
	OUT DDRD, AUX

main:
	RCALL desliga_3
	RCALL liga_1
	RCALL delay
	RCALL desliga_1
	RCALL liga_2
	RCALL delay
	RCALL desliga_2
	RCALL liga_3
	RCALL delay
	RJMP main


liga_1:
	SBI PORTD, LED1
RET
desliga_1:
	CBI PORTD, LED1
RET

liga_2:
	SBI PORTD, LED2
RET
desliga_2:
	CBI PORTD, LED2
RET

liga_3:
	SBI PORTD, LED3
RET
desliga_3:
	CBI PORTD, LED3
RET

delay:
	LDI AUX, 60

outer_loop:
	LDI r24, low(3037)
	LDI r25, high(3037)

delay_loop:
	ADIW r24, 1
	BRNE delay_loop
	DEC AUX
	BRNE outer_loop
RET
