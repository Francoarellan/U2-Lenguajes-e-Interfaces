;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; DESCRIPCION: Implementa un ciclo condicional tipo while que compara EAX contra 5 antes de ejecutar, 
; mostrando en pantalla los numeros del 1 al 5 en orden ascendente usando saltos y comparaciones.
INCLUDE Irvine32.inc

.data
	msgMostrar BYTE "El valor de EAX es: ", 0 ;terminamos con 0 para que sepa que es el final de la cadena

.code
main PROC

	mov eax, 1 ;inicializamos eax en 1

ciclo:
	cmp eax, 5 ;comparamos eax con 5
	jg  fin ;si eax > 5 salta a fin

	mov edx, OFFSET msgMostrar ;cargamos el mensaje
	call WriteString ;escribe el texto
	call WriteInt ;muestra el valor de eax
	call Crlf ;salto de linea

	inc eax ;eax = eax + 1
	jmp ciclo ;vuelve al inicio del ciclo

fin:
	exit ;termina el programa

main ENDP
END main