;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
INCLUDE Irvine32.inc

.data
	msgResult BYTE "El valor en decimal es: ", 0 ;temrina en 0 para que sepa el final de la cadena
	cadenaDec BYTE 11 DUP(0) ; buffer para guardar la cadena decimal

.code
main PROC

	mov eax, 125 ; valor a convertir 

;extraer digitos mediante division entre 10 y guardar en la pila
	mov ebx, 0Ah; divisor 10 en hexadecimal
	mov ecx, 0 ; contador de digitos en cero

dividirdec:
	mov edx, 0 ; limpiamos edx antes de dividir
	div ebx ; eax / 10 eax es cociente, edx es residuo
	push edx  ; guardamos el residuo en la pila
	inc ecx ;incrementamos la cuenta de digitos
	cmp eax, 0 ; evaluamos si el cociente llego a cero
	jne dividirdec

;construir la cadena sacando los digitos de la pila
	mov esi, OFFSET cadenaDec ; apuntamos al buffer de salida

guardardec:
	pop edx ; sacamos el residuo de la pila 
	mov al, dl ; pasamos el digito a al

	; MASCARA OR: convertimos el valor numerico a caracter ASCII 0 a 9
	or  al, 30h
	mov [esi], al ; guardamos el caracter en el buffer
	inc esi      ; avanzamos a la siguiente posicion
	loop guardardec

	mov BYTE PTR [esi], 0 ; colocamos el terminador nulo 00h al final

;mostrar el resultado en consola
	mov edx, OFFSET msgResult
	call WriteString

	mov edx, OFFSET cadenaDec
	call WriteString
	call Crlf

	exit

main ENDP
END main