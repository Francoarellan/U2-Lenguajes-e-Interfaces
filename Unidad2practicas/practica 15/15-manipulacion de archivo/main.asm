;Lenguajes De Interfaces 10-11
;Alumno: Arellano Moreno Franco Antonio
;Docente: Jose Luis Medina Jimenez
; Programa que crea un archivo de texto llamado "Inventario.txt" y escribe en él una cadena de caracteres.
; Gestiona el archivo mediante un manejador (handle), validando posibles errores de creación, escritura y cierre.
INCLUDE Irvine32.inc

.data
    nombreArchivo BYTE "Inventario.txt", 0 
    texto BYTE "125", 0 ;definimos el numero
    archivoHandle DWORD ? ;no le damos tama�o porque no sabemos que ingresaremos

    mensajeExito BYTE "Archivo guardado correctamente.", 0 ; terminamos el nombre con 0 para que sepa el final de la cadena
    mensajeError BYTE "No se pudo guardar el archivo", 0

.code
main PROC

    mov edx, OFFSET nombreArchivo ;se mueve a edx el nombre del archivo 
    call CreateOutputFile ;le hablamos a createoutputfil para que reciba la direccion y cree el archivo

    cmp eax, INVALID_HANDLE_VALUE ;si el metodo salio bien se devuelve el handle en eax y se compara con lo que hay en eax si es diferente de -1 salio bien
    je error ; si es -1 brinca a error

    mov archivoHandle, eax ; guardamos en otra variable el handle del archivo para no perderlo

    ; 2. Escribir caracteres en archivo txt.
    mov eax, archivoHandle ; asignamos el handre a eax
    mov edx, OFFSET texto ; le asignamos la direccion del buffer
    mov ecx, SIZEOF texto - 1 ;el -1 sirve para que no se incluya el 00h 
    call WriteToFile ; llamamos al metodo

    jc errorEscritura ;si se activo cf hubo un error al escribir asi que saltamos a la etiqueta

    ;si eax contiene la cantidad de bytes recuperados entonces tuvo exito sino hubo un error en la escritura
    cmp eax, SIZEOF texto - 1
    jne errorEscritura

    mov eax, archivoHandle ;movemos otra vez a eax el handle para que CloseFile lo use
    call CloseFile

    ;aqui hacemos la prueba para saber si el archivo cerro correctamente si es diferente de 0 tuvo exito si es igual a 0 hubo un error y saltamos a la etiqueta
    test eax, eax
    jz error

    ;aqui ya solo mostramos el mensaje de exito y saltamos al fin del programa
    mov edx, OFFSET mensajeExito
    call WriteString
    jmp fin


errorEscritura:
    mov eax, archivoHandle
    call CloseFile

error:
    mov edx, OFFSET mensajeError
    call WriteString

fin:
    exit
main ENDP

END main