;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
INCLUDE Irvine32.inc
; Programa que demuestra el uso de instrucciones de desplazamiento (SHL, SHR, SAR) y rotación de bits (ROL, ROR, RCL, RCR).
; Muestra la manipulación a nivel de bit, el manejo del signo y la modificación de banderas mediante el registro CL e inmediatos.
.data
.code
main PROC
	mov eax, 0 ;limpiamos el registro eax
	mov ebx, 0 ;limpiamos el registro ebx

;1 SHL: DESPLAZAR UN BIT A LA IZQUIERDA 
	mov al, 10000110b ;aqui definimos nuestros bits
	shl al, 1 ;movemos a la izquierda

	call DumpRegs ;flags
	call WriteBin ;escribe los binarios

;2 SHR: DESPLAZAR UN BIT A LA DERECHA 
	mov al, 00001101b ;definimos bits
	shr al, 1 ;desplazamos a la derecha

	call DumpRegs ;flags
	call WriteBin ;escribe los bits

;3 SAR: DESPLAZAMIENTO ARITMETICO CON SIGNO PAR
	mov eax, 0 ;movemos un valor a eax
	mov al, -8 ;movemos a alow
	sar al, 1 ;desplazamos un valor negativo 1 bit a la derecha conservando el signo

	call DumpRegs ;flags
	call WriteBin ;escribe los bits

;4 SAR: DESPLAZAMIENTO ARITMETICO CON SIGNO IMPAR
	mov eax, 0 ;movemos un valor a eax
	mov al, -9 ;movemos un valor a aLow
	sar al, 1 ;desplazamos con signo a la derecha redondeando hacia abajo

	call DumpRegs ;flags
	call WriteBin ;escribe binarios

;5 CONTEO CONSTANTE: DESPLAZAR CON 2 POSICIONES 
	mov al, 00001100b ;definimos bits
	shl al, 2 ;desplazamos a la izquierda 2 posiciones

	call DumpRegs ;flags
	call WriteBin ;escribe los bits

;6 CONTEO CON CL: UTILIZANDO REGISTRO 
	mov al, 00001100b ;definimos bits en alow
	mov cl, 2 ;cargamos el numero de desplazamientos en el registro cLow
	shr al, cl ;desplazamos alow a la derecha las posiciones guardadas en cl

	call DumpRegs ;flags
	call WriteBin ;escribe los bits

;7 ROR, ROL, RCR, RCL: ROTACIONES DE BITS
	clc ;limpiamos la bandera de acarreo (carry flag a 0)

; ROL: ROTACION A LA IZQUIERDA
	mov al, 10000001b ;definimos bits en alow
	rol al, 1 ;rotamos a la izquierda el bit mas significativo pasa al final y al carry
	call DumpRegs ;flags
	call WriteBin ;escribe los bits

; ROR: ROTACION A LA DERECHA 
	mov al, 10000001b ;definimos bits en alow
	ror al, 1 ;rotamos a la derecha el bit menos significativo pasa al inicio y al carry
	call DumpRegs ;flags
	call WriteBin ;escribe los bits

; RCL: ROTACION A LA IZQUIERDA A TRAVES DEL CARRY 
	mov al, 10000001b ;definimos bits en alow
	rcl al, 1 ;rotamos a la izquierda metiendo la bandera de carry en el bit menos significativo
	call DumpRegs ;flags
	call WriteBin ;escribe los bits

; RCR: ROTACION A LA DERECHA A TRAVES DEL CARRY 
	mov al, 10000001b ;definimos bits en alow
	rcr al, 1 ;rotamos a la derecha metiendo la bandera de carry en el bit mas significativo
	call DumpRegs ;flags
	call WriteBin ;escribe los bits

	exit ;termina la ejecucion del programa

main ENDP
END main