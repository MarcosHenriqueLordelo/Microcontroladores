//Contador Display de 7 segmentos sem interrupção

.equ BOTAO = PB2
.equ DISPLAY = PORTD
.def AUX = r16
.ORG 0x0000

main:
	LDI AUX, 0xFF //Carrega aux com o valor 11111111
	OUT DDRD AUX //Configura DDRD todo como output
	LDI AUX, 0x00 //Carrega aux com o valor 00000000
	OUT DDRB, AUX //Configura DDRB todo como input
	OUT PORTD, AUX //Desliga o display

loop:
	SBIS PIND, BOTAO //Pula a instrução seguinte se o valor do botão for 1
	RJMP loop
	CPI AUX, 0x0F //se sim seta as flags Z,N,V,C,H como 1
	BRNE incr // se a flag Z = 0 -> incr senão executa a prox instrução
	LDI AUX, 0x00
	RJMP decod

incr:
	INC AUX

decod:
	RCALL decodifica
	RCALL atraso
	RJMP loop

//delay padrãozao
atraso:
	LDI r19, 16

volta:
	DEC r17
	BRNE volta
	DEC r18
	BRNE volta
	DEC r19
	BRNE volta
	RET

//decodifica a tabela 
decodifica:
	LDI ZH, HIGH(Tabela<<1)
	LDI ZL, LOW(Tabela<<1)
	ADD ZL, AUX
	BRCC le_tab
	INC ZH

//liga o display pro valor correspondente a aux na tabela
le_tab:
	LPM R0, Z
	OUT DISPLAY, R0
	RET

Tabela: .dw 0x063F, 0x4F5B, 0x6D66, 0x077D, 0x6F7F, 0x7C77, 0x5E39, 0x7179
	