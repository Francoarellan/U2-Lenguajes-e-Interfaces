;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que ilustra la manipulación de la pila mediante las instrucciones PUSH y POP aplicando el principio LIFO.
; Muestra la preservación de registros en memoria y el control de flujo de subrutinas con CALL y RET.
INCLUDE Irvine32.inc

.code
main PROC

    ; BLOQUE 1: PUSH Y POP

    mov eax, 40 
    push eax ;guarda el valor en eax en la cima de la pila

    nop

    mov eax, 0 
    pop ebx ;saca el valor del tope de la cima y lo guarda en ebx
    nop

    ; BLOQUE 2: ORDEN DE LIFO
    mov eax, 10
    push eax ;guarda el 10 en la cima

    mov eax, 20
    push eax ; guarda el 20 como la nueva cima

    mov eax, 30
    push eax ; ahora el 30 es la nueva cima

    pop eax ; ahora eax va a valer 30
    pop ebx ; ahora ebx va a valer 20
    pop ecx ; ahora ecx va a valer 10

    nop

    ; BLOQUE 3: CONSERVAR REGISTROS

    mov eax, 100
    mov ebx, 200

    push eax ; guarda el valor de eax en la pila
    push ebx ; guarda el valor de ebx en la pila

    ;se sobrescriben los valores de los registros
    mov eax, 999 
    mov ebx, 666

    ;se recupera el valor original de ebx y eax
    pop ebx 
    pop eax

    nop

    ; BLOQUE 4: CALL Y RET

    mov eax, 50 
    mov ebx, 100

    call aumentarDiez ;llama al metodo, guarda la direccion de retorno en la pila y salta a la funcion

    nop
    exit

main ENDP

aumentarDiez PROC
    push ebx ;se guarda el valor de ebx en la pila

    ;se asigna un valor a ebx y se suma a eax
    mov ebx, 10
    add eax, ebx

    pop ebx ;se restaura el valor original de ebx antes de llamar a la funcion

    ret ;extrae la direccion de retorno de la pila y regresa
aumentarDiez ENDP

END main