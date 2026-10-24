;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que recibe de 1 a 99 unidades, las valida e incrementa una existencia base acumulada.
; Convierte los datos entre formato ASCII y numérico utilizando máscaras lógicas (AND 0Fh y OR 30h) junto con divisiones.
INCLUDE Irvine32.inc

.data
	msgPedir  BYTE "Unidades recibidas 1-99: ", 0
	msgError  BYTE "error intente de nuevo", 0
	msgTotal  BYTE "existencia actual: ", 0

	buffer    BYTE 10 DUP(0); guarda la entrada de texto
	resTexto  BYTE 10 DUP(0) ; guarda el resultado en texto

	cantidadRecibida DWORD 0 ;inicializamos en 0
	existenciaActual DWORD 0 ;inicializamos en 0

.code
main PROC

pedir:
	; 1. pedir entrada al usuario
	mov edx, OFFSET msgPedir ;movemos el mensaje a edx
	call WriteString ;escribe el mensaje

	mov edx, OFFSET buffer ;movemos la direccion del buffer a edx
	mov ecx, SIZEOF buffer ;movemos el tama�o del buffer a ecx
	call ReadString   ;lee el texto y guarda el numero de caracteres en eax

	; 2. validar tama�o de la entrada
	cmp eax, 1
	jl  error  ;si esta vacio salta a error
	cmp eax, 2
	jg  error  ;si tiene mas de 2 digitos salta a error

	; 3. convertir de texto a numero usando mascara AND y registro AL
	mov esi, OFFSET buffer ;apuntamos al texto ingresado
	mov ecx, eax    ;veces a repetir el ciclo 1 o 2
	mov ebx, 0  ;limpiamos ebx para acumular el numero

convertir:
	mov al, [esi] ;tomamos un caracter en al

	; validar que sea digito comparando con valores hexadecimales ASCII ('0'=30h, '9'=39h)
	cmp al, 30h
	jl  error   ;si es menor a 30h salta a error
	cmp al, 39h
	jg  error   ;si es mayor a 39h salta a error

	; MASCARA HEXADECIMAL: extrae el valor numerico de al
	and al, 0Fh ;mascara 0Fh sobre al para quitar la zona ASCII

	imul ebx, ebx, 0Ah ;multiplicamos el acumulado por 10 en hex (0Ah = 10)
	movzx eax, al ;pasamos el valor num�rico de al a eax
	add ebx, eax ;sumamos a ebx

	inc esi ;avanzamos el puntero esi al siguiente caracter
	loop convertir ;repite la conversion

	; 4. validar rango entre 1 y 99 (1h y 63h en hex)
	cmp ebx, 1h
	jl  error ;si es menor a 1 salta a error
	cmp ebx, 63h
	jg  error ;si es mayor a 99 (63h) salta a error

	; 5. guardar y hacer la suma de 25 base (19h) mas entrada
	mov cantidadRecibida, ebx ;guardamos la entrada
	mov eax, 19h ;movemos las 25 unidades iniciales en hex (19h = 25)
	add eax, cantidadRecibida ;sumamos la cantidad recibida
	mov existenciaActual, eax ;guardamos la existencia final

	; 6. convertir la existencia actual a texto usando divisiones y al
	mov esi, OFFSET resTexto ;usamos esi para apuntar a la variable de salida
	mov ebx, 0Ah ;cargamos 10 en hex para dividir

	mov edx, 0 ;limpiamos edx para la division
	div ebx ;eax / 10 eax se queda decenas y edx unidades

	cmp al, 0 ;revisamos si al tiene valor
	je  solo_unidades ;si al es 0 solo guardamos unidades

	; MASCARA OR: convierte las decenas en al a caracter ASCII
	or  al, 30h ;mascara OR con 30h sobre al
	mov [esi], al ;guardamos al en el arreglo
	inc esi ;avanzamos posicion

solo_unidades:
	; MASCARA OR: convierte las unidades guardadas en dl a caracter ASCII
	mov al, dl ;movemos las unidades a al
	or  al, 30h ;mascara OR con 30h sobre al
	mov [esi], al ;guardamos al en el arreglo
	inc esi ;avanzamos posicion

	mov BYTE PTR [esi], 0 ;ponemos el 0 final en la cadena

	; 7. imprimir resultado final
	mov edx, OFFSET msgTotal ;mandamos el mensaje a edx
	call WriteString ;escribe el mensaje

	mov edx, OFFSET resTexto ;movemos la cadena convertida a edx
	call WriteString ;imprime el numero final
	call Crlf ;salto de linea
	exit ;termina el programa

error:
	mov edx, OFFSET msgError ;movemos el mensaje de error a edx
	call WriteString ;escribe el mensaje de error
	jmp pedir ;vuelve a pedir los datos

main ENDP
END main