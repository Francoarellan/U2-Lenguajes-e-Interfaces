;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; DESCRIPCION: Implementa un ciclo numores que imprime en pantalla los numeros del 5 al 1 en orden descendente, 
; utilizando ECX como contador con control de seguridad JECXZ y decremento automatico con LOOP.
INCLUDE Irvine32.inc

.code
main PROC
    mov ecx, 5 ;usamos ecx como contador con un valor de 5 
    jecxz fin_ciclo ;salta a fin de ciclo si ecx es igual a 0

ciclo:
    ;se copia el contador a eax
    mov eax, ecx
    call WriteDec ;metodo que imprime el valor decimal de eax
    call Crlf ;hace un salto de linea

    loop ciclo ;loop va decrementando ecx en uno y si el resultado no es 0 salta a la etiqueta ciclo

fin_ciclo:
    exit ;sale del programa

main ENDP

END main