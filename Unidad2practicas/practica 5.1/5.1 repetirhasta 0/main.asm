;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que solicita números enteros al usuario en un bucle continuo hasta que se ingresa un cero.
; Al detectar el valor cero, muestra un mensaje de confirmación en pantalla y termina la ejecución.
INCLUDE Irvine32.inc

.data
    msgEntrada BYTE "Ingrese un numero", 0;
    msgIgualcero BYTE "El numero es igual a cero", 0 ; terminamos el mensaje en 0 para que el write string sepa que es el final
    num DWORD ? ; con ? porque no sabemos que tan grande sea el valor a ingresar

.code
main PROC


ciclo:
    mov edx,  OFFSET msgEntrada
    call WriteString
    call ReadInt ; Lee un entero del usuario y lo guarda en EAX

    cmp eax, 0; Compara el valor en EAX con 0
    je es_cero  ; Si es igual a 0, salta a la etiqueta es_cero
    jmp ciclo ; Vuelve a pedir un n�mero

es_cero:
    mov edx, OFFSET msgIgualcero
    call WriteString ; Muestra el mensaje de que es cero
    call Crlf

exit
main ENDP

END main