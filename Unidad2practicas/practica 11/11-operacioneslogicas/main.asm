;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que demuestra la manipulación y evaluación de bits mediante operaciones lógicas a nivel de bit (AND, OR, XOR y TEST).
; Simula el control de estados de un equipo como máscaras de encendido, apagado e inspección de alarmas.
INCLUDE Irvine32.inc
;estados de la computadora
;0-computadora encendida
;1-alarma encendida
;2-computadora conectada a internet

;estado inicial : 0000 0101
.data
	msgEncendido BYTE " la alarma esta encendida",0
	msgApagador BYTE " la alarma esta apagada",0
.code
main PROC
;operaci�n and evalucacion de estado de alarma

	mov eax,0 ;limpiamos el registro
	mov al, 00000111b  ;estado de alarma
	and al, 00000010b  ; mascara para evaluar los bits
	
	call WriteBin ; Muestra en consola el resultado bit a bit
	nop ; para parar la ejecuci�n aqu�

; 2 operaci�n or encender alarma
	mov eax, 0
	mov al, 00000101b
	or  al, 00000010b ; aqu� se forza el bit a ser 1 

	call WriteBin ; Muestra en consola el resultado bit a bit
	nop

; 3 operaci�n xor apagar y enbcender la computadora

	mov eax, 0
	mov al, 00000101b
	xor al, 00000001b ;usamos el xor para invertir el bit  ahora prendemos o apagamos

	call WriteBin ; Muestra en consola el resultado bit a bit
	nop

; 4 operaci�n test evaluar la alarma encendida o apagada

	mov eax,0
	mov al, 00000111b ;usamos este estado para simular que esta encendida

	test al, 00000010b ; usamos el test para actualizar banderas es un and en op l�gicas
	jz alarma_apagada ; si fue 0 se va a alarma apagada

	mov edx, OFFSET msgEncendido ; si el bit estaba prendido sigue aqui
	call WriteString
	jmp fin


alarma_apagada:
	mov edx, OFFSET msgApagador
	call WriteString
fin:
	exit

main ENDP
END main