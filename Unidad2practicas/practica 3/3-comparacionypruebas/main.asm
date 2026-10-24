;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; DESCRIPCION: Evalua el impacto de comparaciones CMP y pruebas TEST sobre las banderas de estado (ZF, SF, CF, OF), 
; mostrando en cada paso los cambios del registro EFLAGS en consola mediante DumpRegs.
INCLUDE Irvine32.inc

.code
main PROC

    ; 1. ZF 
    mov eax, 5 ;comparamos el mismo numero para que de 0 y encender zeroflag
    cmp eax, 5

    call DumpRegs ; Muestra en consola el estado de todos los registros y banderas

    ; 2. SF
    mov eax, 3 ; Comparamos y hacemos que uno sea menor que el otro para que el resultado sea negativo y encender signflag
    cmp eax, 8

    call DumpRegs

    ; 3. CF
    mov eax, 10 ;aqui hacemos un prestamo para activar cf sin signo
    cmp eax, 20

    call DumpRegs

    ; 4. OF
    ; Se activa cuando hay desbordamiento en operaciones con signo
    mov al, 127 ; Maximo valor positivo para al
    cmp al, -1  ; 127-(-1)=128 se desborda

    call DumpRegs

    ; 5. Test

    mov al, 10000000b
    test al, 10000000b  ; Metodo que realiza una operacion AND bit a bit

    call DumpRegs  ;Se activa SF aunque no sea negativo ya que la cpu solo revisa el bit mas significativo. Si ese bit es 1 activa SF 

    exit
main ENDP

END main