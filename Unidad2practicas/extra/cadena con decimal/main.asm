INCLUDE Irvine32.inc

.data
	tamanioTotal DWORD 100000 ; tamanio completo del archivo en bytes
	bloquesRecibidos DWORD 125 ; cantidad de bloques que llegaron
	tamanioBloque DWORD 512 ; tamanio de cada bloque

	bytesDescargados DWORD ? ; guardamos los bytes descargados
	bytesPendientes DWORD ? ; guardamos los bytes que faltan
	porcentajeAvance DWORD ? ; guardamos el porcentaje
	grupos1024 DWORD ? ; guardamos los grupos de 1024
	residuo1024 DWORD ? ; guardamos el residuo de la division

	buffer BYTE 11 DUP(0) ; buffer para guardar la cadena decimal

	msgDescargados BYTE "Bytes descargados: ", 0
	msgPendientes BYTE "Bytes pendientes: ", 0
	msgPorcentaje BYTE "Porcentaje de avance: ", 0
	msgSimboloPct BYTE "%", 0
	msgGrupos BYTE "Grupos completos de 1024 bytes: ", 0
	msgResiduo BYTE "Residuo del agrupamiento: ", 0

.code
main PROC

	; 1. calcular bytes descargados
	mov eax, bloquesRecibidos ; cargamos los bloques
	mov ebx, tamanioBloque ; cargamos el tamanio del bloque
	mul ebx ; eax = 125 * 512
	mov bytesDescargados, eax ; guardamos el resultado

	; 2. calcular bytes pendientes
	mov eax, tamanioTotal ; cargamos el total
	sub eax, bytesDescargados ; restamos los descargados
	mov bytesPendientes, eax ; guardamos los pendientes

	; 3. calcular porcentaje
	mov eax, bytesDescargados ; cargamos descargados
	mov ebx, 100 ; multiplicamos por 100 para la regla de 3
	mul ebx
	mov edx, 0 ; limpiamos edx antes de dividir
	div tamanioTotal ; dividimos entre el total
	mov porcentajeAvance, eax ; guardamos el porcentaje

	; 4. calcular grupos de 1024 y residuo
	mov eax, bytesDescargados ; cargamos descargados
	mov edx, 0 ; limpiamos edx para la division
	mov ebx, 1024 ; divisor 1024
	div ebx ; eax = cociente, edx = residuo
	mov grupos1024, eax ; guardamos grupos
	mov residuo1024, edx ; guardamos el residuo

	; mostrar bytes descargados
	mov edx, OFFSET msgDescargados ; cargamos el mensaje
	call WriteString
	mov eax, bytesDescargados ; valor a convertir
	mov esi, OFFSET buffer ; apuntamos al buffer
	call convertirDecimal ; convierte el numero a texto
	mov edx, esi ; pasamos la direccion para imprimir
	call WriteString
	call Crlf

	; mostrar bytes pendientes
	mov edx, OFFSET msgPendientes
	call WriteString
	mov eax, bytesPendientes
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, esi
	call WriteString
	call Crlf

	; mostrar porcentaje de avance
	mov edx, OFFSET msgPorcentaje
	call WriteString
	mov eax, porcentajeAvance
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, esi
	call WriteString
	mov edx, OFFSET msgSimboloPct
	call WriteString
	call Crlf

	; mostrar grupos de 1024
	mov edx, OFFSET msgGrupos
	call WriteString
	mov eax, grupos1024
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, esi
	call WriteString
	call Crlf

	; mostrar residuo
	mov edx, OFFSET msgResiduo
	call WriteString
	mov eax, residuo1024
	mov esi, OFFSET buffer
	call convertirDecimal
	mov edx, esi
	call WriteString
	call Crlf

	exit
main ENDP

; procedimiento para convertir numero a cadena ascii
convertirDecimal PROC
	push eax ; guardamos los registros en la pila
	push ebx
	push ecx
	push edx

	add esi, 10 ; nos posicionamos al final del buffer
	mov BYTE PTR [esi], 00h ; colocamos el terminador nulo 0

	mov ebx, 10 ; divisor 10 para extraer digitos

convertir_loop:
	mov edx, 0 ; limpiamos edx antes de dividir
	div ebx ; eax = cociente, edx = residuo

	add dl, 30h ; convertimos el residuo a ascii
	dec esi ; retrocedemos una posicion en el buffer
	mov [esi], dl ; guardamos el caracter

	cmp eax, 0 ; evaluamos si el cociente es cero
	jne convertir_loop ; si no es cero sigue dividiendo

	pop edx ; restauramos los registros
	pop ecx
	pop ebx
	pop eax
	ret ; regresamos al main
convertirDecimal ENDP

END main