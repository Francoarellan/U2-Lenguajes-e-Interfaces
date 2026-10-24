;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
;contador de caracteres 
INCLUDE Irvine32.inc

.data
    mensaje BYTE "Escribe tu nombre: ", 0 ; Mensaje de instrucción para el usuario
    caracteresEscritos BYTE "Numero de caracteres: ", 0
    nombre BYTE 20 DUP(0) ; reservamos un espacio de memoria llamado buffer para el limite de caracteres a escribir

.code
main PROC
    ; Despliega la solicitud de nombre al usuario
    mov edx, OFFSET mensaje
    call WriteString

    mov edx, OFFSET nombre ; Entrega la dirección del primer caracter del buffer.
    mov ecx, SIZEOF nombre ; Entrega la cantidad de bytes que se pueden escribir.
    call ReadString ; Permite el ingreso de datos mediante consola (lee lo escrito por el usuario)

    ; Retorna lo escrito en el buffer
    mov edx, OFFSET nombre
    call WriteString
    call Crlf

    mov edx, OFFSET caracteresEscritos
    call WriteString
    call WriteDec

    exit
main ENDP

END main