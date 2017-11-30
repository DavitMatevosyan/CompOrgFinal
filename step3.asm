%include "io.inc"

section .data
arrlen: dd 101 ; length of the array

section .bss
array: resd 101 ; reserve the array here

section .text
global CMAIN

fill_array:
    mov eax, 2 ; index of the array, starts from 2 as 0 and 1 are not prime, (ecx will act as i)
loop1:
    mov dword [array + eax*4], 1 ; set all elements of array 1 starting from index 2 (array[i] = 1)
    inc eax
    inc ecx
    cmp eax, dword [arrlen]
    jb loop1
    ret
    
is_prime:
    PRINT_DEC 4, eax ; print eax (it acts as i)
    NEWLINE
    jmp con_point2 ; continue the execution of code from con_point2    
    
print_array:
    mov eax, 0
loop2:
    mov ebx, dword [array + eax*4]
    cmp ebx, 1 ; check if array[i] = 1, if it is then i is a prime number
    je is_prime
con_point2: ; continuation point after is_prime is finished   
    inc eax
    cmp eax, dword [arrlen]
    jb loop2
    ret
    
is_true:
    mov edx, eax ; keep initial value of eax
    imul eax, eax ; compute (eax)^2 (this will act as j)
loop4:
    mov dword [array + 4*eax], 0 ; mov 0 to array[j], where j = i^2 + c*i
    add eax, edx ; set j = i^2 + c*i where c is 0, 1, 2, 3 ....
    cmp eax, dword [arrlen]
    jb loop4
    mov eax, edx
    xor edx, edx
    jmp con_point ; continue the execution of code from con_point                                           

sieve:
    mov eax, 2 ; index of the array (this will act as i)
loop3:
    mov ebx, dword [array + eax*4] ; mov array[i] into ebx
    cmp ebx, 0
    jne is_true ; if ebx is 1 jump to is_true function
con_point: ; specifies the continuation point after is_true is finished     
    inc eax
    mov edx, eax
    imul edx, edx
    cmp edx, dword [arrlen]
    jb loop3
    ret

fact:
    mov eax, 8 ; <- this number's fact is counted
    mov ecx, eax ; "inverse" iterator
    dec ecx 
inner_fact:
    mul ecx 
    dec ecx
    cmp ecx, 1 ; multiply eax by ecx till ecx = 1
    ja inner_fact 
    PRINT_DEC 4, eax ; print eax
    NEWLINE
    ret

; A09160169 last 2:  69 xDD  00-0f XX-YY
split:
    mov eax, 15 ; my num / eax = 0x000f
    mov edx, 0 ; for normal divisions    
    mov ecx, 100 
    div ecx ; div by 100 to split into 2 parts
    
    xor eax, edx ; Delete this if u want edx = YY and eax = XX
    xor edx, eax 
    xor eax, edx
    
    PRINT_DEC 4, edx ; edx = XX
    NEWLINE
    PRINT_DEC 4, eax ; eax = YY
    
    
    ret


CMAIN:
    mov ebp, esp; for correct debugging
    call fill_array
    call sieve
    call print_array
    call fact
    call split
    xor eax, eax
    ret