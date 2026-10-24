;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que demuestra el uso de instrucciones aritméticas fundamentales y la alteración de banderas del procesador.
; Ejecuta operaciones de resta, suma con desbordamiento, multiplicación y división con y sin signo utilizando la librería Irvine32.
INCLUDE Irvine32.inc

.code
main PROC
	; 1. resta basica
	sub eax, 15 ;restamos 15 al registro eax
	nop ;pausa para depurar

; 2. CF: ACARREO EN UNA SUMA SIN SIGNO
	mov eax, 0 ;limpiamos eax
	mov al, 255 ;movemos el valor maximo de un byte a alow
	add al, 1 ;sumamos 1 para activar la bandera de acarreo carry flag
	nop ;pausa para depurar
; 3. OF: CONDICION DE DESBORDAMIENTO

	mov eax, 0 ;limpiamos eax
	mov al, 127 ;movemos el limite positivo de 8 bits con signo a alow
	add al, 1 ;sumamos 1 para activar la bandera de desbordamiento overflow flag
	nop ;pausa para depurar
; 4. MUL: MULTIPLICACI�N DE VALORES 

	mov eax, 25 ;movemos 25 a eax
	mov ebx, 3 ;movemos 3 a ebx
	mul ebx ;multiplica eax por ebx  y guarda el resultado en eax
	nop ;pausa para depurar
; 5. MUL: PRODUCTO QUE NECESITA M�S DE 32 BITS

	mov eax, 65537 ;movemos un numero grande a eax
	mov ebx, 65537 ;movemos el mismo numero a ebx
	mul ebx ;multiplica eax por ebx y el resultado se divide entre edx y eax
	nop ;pausa para depurar
; 6. IMUL: MULTIPLICACI�N CON SIGNO

	mov eax, -5 ;movemos un numero negativo a eax
	imul eax, eax, 3 ;multiplicamos -5 por 3 conservando el signo
	nop ;pausa para depurar
; 7. DIV: DIVIDIENDO SIN SIGNO

	mov eax, 125 ;cargamos el dividendo en eax
	mov edx, 0 ;limpiamos edx antes de dividir
	mov ebx, 12 ;cargamos el divisor en ebx
	div ebx ;divide eax entre ebx cociente en eax, residuo en edx
	nop ;pausa para depurar

; IDIV: DIVISION CON SIGNO

	mov eax, -125 ;cargamos un valor negativo en eax
	cdq ;extiende el signo de eax hacia edx
	mov ebx, 12 ;cargamos el divisor en ebx
	idiv ebx ;divide con signo eax entre ebx
	nop ;pausa para depurar
	exit ;termina el programa

main ENDP
END main