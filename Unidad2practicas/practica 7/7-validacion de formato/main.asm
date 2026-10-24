;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que valida el formato de una cadena de texto según la estructura de tres letras mayúsculas, un guion y tres dígitos.
; Utiliza el registro ESI como puntero para inspeccionar individualmente los caracteres ingresados mediante comparaciones ASCII.
INCLUDE Irvine32.inc

.data
	;TEC-123
	msgPedir  BYTE "Ingrese el codigo Formato  3 letras, guion, 3 numeros", 0 ;
	msgValido BYTE "Formato correcto", 0
	msgError  BYTE "Formato invalido Intente de nuevo", 0

	bufferCodigo BYTE 31 DUP(0) ;buffer para guardar la entrada de texto

.code
main PROC

pedir_codigo:
	;pedir texto al usuario
	mov edx, OFFSET msgPedir
	call WriteString

	mov edx, OFFSET bufferCodigo ; gauda la direccoin del buffer
	mov ecx, SIZEOF bufferCodigo - 1 ; guarda los bits de tama�o
	call ReadString ;eax guarda el numero de caracteres leidos

	;validar tama�o exacto de 7 caracteres
	cmp eax, 7 ;compara a 7 para ver si tiene los caracteres
	jne formato_invalido ;si no tiene 7 caracteres salta a error

	;validar las 3 primeras letras en mayusculas
	mov esi, OFFSET bufferCodigo ;apuntamos al inicio de la cadena
	mov ecx, 3 ;revisamos 3 posiciones

validar_letras:
	mov al, [esi] ;cargamos el caracter actual en al
	cmp al, 41h ;comparamos con 'A' en hexa
	jl  formato_invalido ;si es menor salta a error
	cmp al, 5Ah ;comparamos con 'Z' en hex
	jg  formato_invalido ;si es mayor salta a error
	inc esi ;avanzamos posicion
	loop validar_letras

	;validar guion en la posicion 3
	mov al, [esi]
	cmp al, 2Dh ;2Dh es el caracter '-' en hex
	jne formato_invalido ;si no es guion salta a error
	inc esi ;avanzamos posicion

	;validar los 3 ultimos digitos
	mov ecx, 3 ;revisamos 3 posiciones

validar_digitos:
	mov al, [esi]
	cmp al, 30h ;comparamos con '0' en hexa
	jl  formato_invalido ;si es menor salta a error
	cmp al, 39h ;comparamos con '9' en hex
	jg  formato_invalido ;si es mayor salta a error
	inc esi ;avanzamos posicion
	loop validar_digitos

	;si paso todas las validaciones muestra mensaje correcto
	mov edx, OFFSET msgValido ;mueve el mensaje a edx
	call WriteString ;escribe el emnsaje
	
	exit;termina

formato_invalido:
	mov edx, OFFSET msgError;mueve el mensaje a edx
	call WriteString ; escribe el mensaje
	jmp pedir_codigo ;vuelve a pedir los datos desde el inicio

main ENDP
END main