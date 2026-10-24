;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que demuestra el control de flujo mediante saltos incondicionales (jmp) y condicionales (cmp/je).
; Compara los valores de dos registros e imprime en pantalla si los números son iguales o diferentes.
INCLUDE Irvine32.inc

.data
    ;declaracion de mensajes
    msgIguales BYTE "Los valores son iguales", 0
    msgDiferentes BYTE "Los valores son diferentes", 0

.code
main PROC

    mov eax, 5 ;movemos a eax el valor 5
    jmp continuar ;jmp salta directamente a la etiqueta continuar
    mov eax, 10 ;no se hace la op por que salto a continuar

continuar:
    call DumpRegs
    mov eax, 10 ;asignamos valores a eax y ebx para nuevas comparaciones
    mov ebx, 10

    cmp eax, ebx ;si al Comparar ambos valores son iguales brinca a la etiqueta iguales
    je iguales

    ;si son diferentes se muestra el mensaje y salta al fin
    mov edx, OFFSET msgDiferentes ;aqui lo mueve a edx
    call WriteString ;aqui escribe el mensaje

    jmp fin ;brinca al fin

    ;se muestra el mensaje de iguales
    iguales:
        mov edx, OFFSET msgIguales ;nueve el mensaje al registro
        call WriteString ;escribe el mensaje

    ;se hace un salto de linea y termina el programa
    fin:
        call crlf
        exit

main ENDP

END main