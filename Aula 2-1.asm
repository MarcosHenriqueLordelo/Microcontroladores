.equ LED1 = PD2
.equ LED2 = PD3
.equ LED3 = PD4
.equ BOTAO = PD7
.def AUX = R16

.ORG 0x000
init:
	LDI AUX, 0x00011100
	OUT DDRD, AUX

main:
	SBIS PIND, BOTAO; se botao apertado realiza ciclo reverso
	RCALL reverse
	RCALL flash
	RJMP main

flash:
	RCALL desliga_3
	RCALL liga_1
	RCALL delay
	RCALL desliga_1
	RCALL liga_2
	RCALL delay
	RCALL desliga_2
	RCALL liga_3
	RCALL delay
RET

reverse:
	RCALL desliga_1
	RCALL liga_3
	RCALL delay
	RCALL desliga_3
	RCALL liga_2
	RCALL delay
	RCALL desliga_2
	RCALL liga_1
	RCALL delay
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
