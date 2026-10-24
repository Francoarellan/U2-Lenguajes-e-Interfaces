;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que valida el ingreso de un PIN de acceso permitiendo un máximo de tres intentos.
; Muestra un mensaje de éxito si la clave es correcta o bloquea el sistema si se agotan los intentos.
INCLUDE Irvine32.inc

.data
	msgPin BYTE "ingrese la clave: ",0 ;todos los mensajes teminan en 0 para que Write String sepa el final
	msgError BYTE "clave Incorrecta",0
	msgAcceso BYTE "Acceso permitido",0
	msgBloqueo BYTE "sistema bloqueado",0
	msgIntentos BYTE "intentos restantes: ",0

	claveC =1234 ;definimos una clave para comparar con lo que se ingrese
.code
main PROC
	mov ebx,3 ;aqu� se define el numero de intentos
pedir_clave:
	mov edx,OFFSET msgPin ; aqu� movemos el mensaje a edx
	call WriteString ; write String escribe el mensaje
	call ReadInt ; aqu� se ingresan los datos directo a EAX

	cmp eax, ClaveC;por eso aqu� comparamos la clave con eax
	
	je acceso ; si es correcta brinca a la etiquta acceso

	mov edx, OFFSET msgError ;si no mueve el mensaje de error
	call WriteString ; aqu� se muestra el mensaje
	call Crlf ;salto de linea

	jmp intentar ; lo manda a etiqueta intentar para otro intento
intentar:
	dec ebx   ; decrementa el numero de intentos
	cmp ebx, 0 ; Verifica si se acabaron los intentos
	je bloqueado  ; Si EBX es 0 salta a la etiqueta bloqueado

	
	mov edx, OFFSET msgIntentos ;mueve el mensaje de los inentos restantes a edx
	call WriteString  ; Muestra "Intentos restantes: "
	mov eax, ebx ; Mueve el valor de EBX a EAX para poder imprimirlo con WriteDec
	call WriteDec  ; Imprime el n�mero almacenado en EAX
	call Crlf     ; Salto de l�nea

	jmp pedir_clave  ; Salta al inicio para volver a pedir la clave

acceso:
	mov edx, OFFSET msgAcceso ; mueve el mensaje a edx
	call WriteString ;escribe el mensaje que se acaba de mover
	jmp fin  ;brinca al final p�ara termianar el programa

bloqueado:
	mov edx, OFFSET msgBloqueo ; mueve el mensaje a edx
	call WriteString ; aqui escribe el mensaje
	jmp fin ; brinca al final simulando como si se ubiera apagado

fin:
	exit ;termina el programa

main ENDP
END main