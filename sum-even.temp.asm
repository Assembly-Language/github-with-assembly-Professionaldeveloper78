INCLUDE c:\Users\AR\.vscode\extensions\istareatscreens.masm-runner-0.4.5\native\irvine\Irvine32.inc

.data
myArray word 9,4,1,22,12,89             ; Array of signed integers
msgSum byte "Sum of Even values: ",0       ; Message for sum output
msgCount byte "Total Even Numbers: ",0     ; Message for count output
sum dword 0                                ; Variable to store the sum of even numbers
count dword 0                              ; Variable to store the count of even numbers

.code
main proc
    ; Initialize the accumulator (EAX) to zero
    mov eax, 0

    ; Load the address of the array into ESI
    mov esi, offset myArray

    ; Set the loop counter (ECX) to the length of the array
    mov ecx, lengthof myArray

    ; Start looping through the array elements
EvenNumbers:
    ; Load the current element of the array into AX (word size)
    mov ax, word ptr [esi]

    ; Check if the number is odd by testing the least significant bit (LSB)
    test ax, 1
    ; If the number is odd, skip to the next element
    jnz skipEven

    ; If the number is even, extend it to 32-bit (EAX)
    movsx eax, word ptr [esi]

    ; Add the even number to the sum
    add sum, eax

    ; Increment the count of even numbers
    add count, 1

skipEven:
    ; Move to the next element in the array (size of each element is 'type myArray')
    add esi, type myArray

    ; Continue the loop until all elements are processed
    loop EvenNumbers

    ; Display the sum of even numbers
    mov edx, offset msgSum
    call writestring          ; Print the message
    call crlf                 ; New line
    mov eax, sum              ; Load the sum into EAX for printing
    call writeint             ; Print the sum
    call crlf                 ; New line

    ; Display the total count of even numbers
    mov edx, offset msgCount
    call writestring          ; Print the message
    call crlf                 ; New line
    mov eax, count            ; Load the count into EAX for printing
    call writeint             ; Print the count

    ; Exit the program
    exit
main endp
end main
