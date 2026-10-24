;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que convierte un valor numérico de 32 bits a su representación en formato texto hexadecimal (ASCII).
; Extrae cada nibble mediante desplazamientos y máscaras de bits, convirtiendo y guardando los caracteres de derecha a izquierda.
INCLUDE Irvine32.inc

.data
	msgResult BYTE "El valor en hexadecimal es: ", 0
	cadenaHex BYTE 9 DUP(0) ;buffer para los 8 digitos y el cero nulo

.code
main PROC

	mov eax, 12AB34CDh ;valor numerico de prueba
	mov esi, OFFSET cadenaHex ;apuntamos al buffer
	add esi, 7 ;nos posicionamos al final para llenar de derecha a izquierda
	mov ecx, 8 ;procesamos los 8 digitos hex

convertir_hex:
	mov edx, eax ;copiamos eax a edx
	and dl, 0Fh ;mascara AND 0Fh para aislar los 4 bits bajos

	cmp dl, 9 ;comparar con 9
	jg  es_letra ;si es mayor a 9 pasa a convertir letras A-F

	or  dl, 30h ;mascara OR 30h para pasar digito 0-9 a ascii
	jmp guardar_caracter

es_letra:
	add dl, 37h ;37h,55 decimal convierte valores 10-15 directo a ascii de A - F

guardar_caracter:
	mov [esi], dl ;guardamos el caracter ascii en la posicion actual
	dec esi ;retrocedemos una posicion en la cadena
	shr eax, 4 ;desplazamos 4 bits a la derecha para tomar el siguiente nibble
	loop convertir_hex

;mostrar resultado en consola
	mov edx, OFFSET msgResult; mueve el mensaje a edx
	call WriteString ; escribe el mensaje

	mov edx, OFFSET cadenaHex ; mueve el mesnaje a edx
	call WriteString ;escrigbe el mensaje
	call Crlf ; hace el salto de linea

	exit ; sale del programa

main ENDP
END main