;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que simula el control de cupo de un estacionamiento mediante un menú interactivo.
; Permite registrar la entrada y salida de vehículos, validando si se encuentra totalmente lleno o vacío.
INCLUDE Irvine32.inc

.data
	msgop BYTE "1.Entrar  2.Salir  0.Terminar: ", 0
	msgLleno BYTE "Estacionamiento lleno",0
	msgVacio BYTE "Estacionamiento vacio",0
	
	autos DWORD 0
	tamanioestacionamiento  = 5 ;se lleno el estacionamiento

.code
main PROC

inicio:
	mov eax, autos ;aqui mostramos los autos actuales que inicialmente son 0
	call WriteDec
	
	mov edx, OFFSET msgop ;aqui preguntamos que quiere hacer
	call WriteString
	call ReadInt  ;aqui guardamos su respueta

	cmp eax, 1 ;hacemos comparaciones para saber que opcion es y lo mandamos a la etiqueta
	je entrar
	cmp eax, 2
	je salir
	cmp eax, 0
	je fin
	jmp inicio

entrar:
	mov eax, autos  ;aqui metemos el numero de autos que llevamos
	cmp eax, tamanioestacionamiento ;si es igual a lleno manda a la etiqueta lleno
	je lleno
	inc autos ;si no incrementa 1 auto
	jmp inicio ;y manda de vuelta al menu

lleno:
	mov edx, OFFSET msgLleno ;aqui mueve el mensaje al registro
	call WriteString ; escribe el mensaje
	jmp inicio ;vuelve al inicio

salir: 
	mov eax, autos ; aqui vemos el nuemro de autos que llevamos
	cmp eax, 0 ; lo compara con 0 y si si lo manda a vacio
	je vacio
	dec autos ;si no descuenta 1 auto
	jmp inicio ;vuelve al inicio

vacio:
	mov edx, OFFSET msgVacio ;mueve el mensaje al registro
	call WriteString ;escribe el mensaje
	jmp inicio ;vuelve al inicio


fin:
	exit
main ENDP
END main