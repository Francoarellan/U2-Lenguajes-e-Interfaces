;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; DESCRIPCION: Captura el nombre del usuario desde teclado mediante un buffer en memoria usando ReadString
; y lo muestra de nuevo en consola utilizando su direccion en EDX con WriteString
INCLUDE Irvine32.inc
	
.data
mensaje BYTE "Escribe tu nombre: ",0 ; termina con 0 para WriteString
nombre BYTE 30 DUP(0) ; aqu� definimos un buffer para el nombre

.code
main PROC
	mov edx, OFFSET mensaje ;movemos el mensje a edx
	call WriteString ; escribe el mensaje
	
	mov edx, OFFSET nombre ;offset para mandarlo al primer byte o  caracter de la cadena
	mov ecx, SIZEOF nombre ; calcula el tama�o de bytes de la variable nombre

	call ReadString ; ingreso de datos que va a el buffer

	mov edx, OFFSET nombre ;aqu� mueve el nombre a edx
	call WriteString ; aqu� escribe el nombre
	exit ;termina el programa
	
main ENDP
END main 