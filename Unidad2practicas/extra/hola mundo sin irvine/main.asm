.386
;386: Se refiere a la arquitectura intel 80386. Nos va permitir reconocer los registros tipo EAX, EBX, etc...

.model flat, stdcall
; .model define el modelo de memoria y la convención de llamadas.
; flat: Utiliza de manera plana los espacios de direcciones. Típico en win32 de 32 bits.

.stack 4096
; Reserva espacio para la pila del programa
; 4096 bytes = 4KB.

GetStdHandle PROTO,
    nStdHandle:DWORD
; PROTO se declara prototipo para conocer que windows tiene o maneja esa función

WriteConsoleA PROTO,
    hConsoleOutput:DWORD,
    lpBuffer:PTR BYTE,
    nNumberOfCharsToWrite:DWORD,
    lpNumberOfCharsWritten:PTR DWORD,
    lpReserved:DWORD

; 1) hConsoleOutput: HANDLE de la consola donde queremos escribir.
; 2) lpBuffer: Dirección de memoria donde comienza el texto.
; 3) nNumberOfCharsToWrite: Número de caracteres que se van escribir.
; 4) lpNumberOfCharsWritten: Dirección donde windows guarda el numero de caracteres ya escritos.
; 5) lpReserved: Parámetro reservado.

ExitProcess PROTO,
    dwExitProcess:DWORD
; Declaración de la función ExitProcess. Esta función termina el proceso actual. El DWORD es el código de salida

STD_OUTPUT_HANDLE_EQU EQU -11
;EQU crea una constante simbólica
;STD_OUTPUT_HANDLE = -11
;Windows utiliza el -11 para salidas estandar.
; NO SE USA GetStdHandle(-11)
; SE USA GetStdHandle(STD_OUTPUT_HANDLE)

.data
    mensaje BYTE "Hola Mundo", 0Dh, 0Ah, 0
    bytesEscritos DWORD ?
    hConsole DWORD ?

.code
main PROC
    ; Obtener el HANDLE de la consola de salida
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE_EQU
    mov hConsole, eax

    ; Escribir el mensaje en la consola
    INVOKE WriteConsoleA, \
        hConsole, \
        ADDR mensaje, \
        LENGTHOF mensaje - 1, \
        ADDR bytesEscritos, \
        0

    ; Salir del programa
    INVOKE ExitProcess, 0
main ENDP

END main