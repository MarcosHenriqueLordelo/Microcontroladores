.equ LED = PD2
.equ BOTAO = PD7
.def AUX = R16

.org 0x000
init:
	LDI AUX, 0x00000100
	OUT DDRD, AUX

main:
	SBIS PIND, BOTAO ;botao apertado pula RJMP main e entra em espera
	RJMP main

espera:
	SBIC PIND, BOTAO ;botao solto pula RJMP espera e segue pra delay
	RJMP espera
	RCALL delay
	SBIS PORTD, LED ;se led desligado liga led, senão desliga led
	RJMP liga_led
	RJMP desliga_led
	
liga_led:
	SBI PORTD, LED
	RJMP main
desliga_led:
	CBI PORTD, LED
	RJMP main

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