;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que lee dos números enteros por consola y compara sus valores mediante saltos condicionales.
; Imprime en pantalla si el primer número ingresado es mayor, menor o igual con respecto al segundo.
INCLUDE Irvine32.inc

.data
	msgMayor BYTE "El primero es mayor", 0 ;definimos los mensajes y terminamos en 0 para que sepa Writestring que es el fin de la cadena
	msgMenor BYTE "El primero es menor", 0
	msgIgual BYTE "Son iguales", 0
	msgPrimero BYTE "ingrese los dos numeros"

.code
main PROC
	mov edx, OFFSET msgPrimero ; Pedir primer n�mero
	call WriteString
	call ReadInt  ; Lee n�mero y lo guarda en eax
	mov ebx, eax ; copiamos el numero a ebx para que no se borre al ingresar el segundo numero

	call WriteString
	call ReadInt  ; lee el segundo numero

	; compara los dos numeros registro eax y ebx
	cmp ebx, eax 
	je  igual ; brinca a iguales si son el mismo valor
	jg  mayor ; brinca a mayor si el primero es mas grande

menor:
	mov edx, OFFSET msgMenor ;mueve el mensaje al registro
	call WriteString ;escribe el mensaje
	exit ;termina

mayor:
	mov edx, OFFSET msgMayor ; mueve el mensaje al registro
	call WriteString ;escribe el mensaje
	exit ;termina

igual:
	mov edx, OFFSET msgIgual
	call WriteString
	exit

main ENDP
END main