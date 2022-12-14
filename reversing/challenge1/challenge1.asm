bits 32
section .text
global _start

_start:
    mov eax, 16
    push msg1
    push eax
    call output

read:
    push ebp
    mov ebp,esp
    xor ecx, ecx
    mov dword[lenstr], ecx

readsubroutine:
    
    mov edx, 1
    mov ecx, charbuf
    mov ebx, 0
    mov eax, 3
    int 0x80

    cmp eax,0
    je readingdone
    cmp byte[charbuf],0x0A
    je readingdone
    cmp byte[charbuf], 0x0
    je readingdone
    mov ecx, dword[lenstr]
    cmp ecx, 255
    jge wrong
    inc dword[lenstr]
    mov bl, byte[charbuf]
    mov edx, input
    mov [edx+ecx],bl
    jmp readsubroutine

readingdone:
    cmp dword[lenstr],16
    jne wrong

checkpasscode:
    xor eax, eax
    xor ecx, ecx
    mov al, byte[input+ecx]
    cmp al, 0x66
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x72
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x33
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x63
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6b
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6c
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x33
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x35
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x63
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x30
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6e
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x72
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x75
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6c
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x33
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x35
    jne wrong
    inc ecx
    jmp success

success:
    mov eax, 9
    push msg3
    push eax
    call output
    jmp exit

wrong:
    mov eax, 7
    push msg2
    push eax
    call output
    jmp exit

output:
    push ebp
    mov ebp, esp

    add esp, 8
    mov edx, [esp]
    add esp, 4
    mov ecx, [esp]
    mov ebx, 1
    mov eax, 4
    int 0x80 

    
    mov esp, ebp
    pop ebp
    ret
exit:
    mov eax, 5
    push msg4
    push eax
    call output
    mov eax, 0x01
    int 0x80
    ret

section .data
msg1 db "Input Passcode:",0x0A,0
msg2 db "WRONG!",0x0A,0
msg3 db "Correct!",0x0A,0
msg4 db "EXIT",0x0A,0



section .bss
lenstr:  resd 1
charbuf: resb 1
input:  resb 256

