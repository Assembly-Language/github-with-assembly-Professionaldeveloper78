INCLUDE c:\Users\AR\.vscode\extensions\istareatscreens.masm-runner-0.4.5\native\irvine\Irvine32.inc

.data
myArray word 2, 8, -9, -6, -3             ; Array of signed integers
msgSum byte "Sum of positive numbers: ",0  ; Message for sum output
msgCount byte "Total positive numbers: ",0 ; Message for count output
sum dword 0                                ; Variable to store the sum of positives
count dword 0                              ; Variable to store the count of positives

.code
main proc
    ; Initialize the accumulator (EAX) to zero
    mov eax, 0

    ; Load the address of the array into ESI
    mov esi, offset myArray

    ; Set the loop counter (ECX) to the length of the array
    mov ecx, lengthof myArray

    ; Start looping through the array elements
positiveNumbers:
    ; Load the current element of the array into AX (word size)
    mov ax, word ptr [esi]

    ; Check if the number is negative by testing the sign bit (bit 15)
    test ax, 8000h
    ; If the number is negative, skip to the next element
    jnz skipPositive

    ; If the number is positive, extend it to 32-bit (EAX)
    movsx eax, word ptr [esi]

    ; Add the positive number to the sum
    add sum, eax

    ; Increment the count of positive numbers
    add count, 1

skipPositive:
    ; Move to the next element in the array (size of each element is 'type myArray')
    add esi, type myArray

    ; Continue the loop until all elements are processed
    loop positiveNumbers

    ; Display the sum of positive numbers
    mov edx, offset msgSum
    call writestring         ; Print the message
    call crlf                ; New line
    mov eax, sum             ; Load the sum into EAX for printing
    call writeint            ; Print the sum
    call crlf                ; New line

    ; Display the total count of positive numbers
    mov edx, offset msgCount
    call writestring         ; Print the message
    call crlf                ; New line
    mov eax, count           ; Load the count into EAX for printing
    call writeint            ; Print the count

    ; Exit the program
    exit
main endp
end main
