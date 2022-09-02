bits 32
section .text
global _start

_start:
    mov eax, 41
    push msg1
    push eax
    call output

    mov eax, 24
    push msg5
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
    cmp al, 0x65
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x78
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x48
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x61
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x78
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x54
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x68
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x65
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x50
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6c
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x61
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6e
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x65
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x74
    jne wrong
    inc ecx
    jmp success

success:
    call flag_decrypter
    mov eax, 50
    push msg7
    push eax
    call output
    jmp exit

flag_decrypter:
    push ebp
    mov ebp, esp
    xor eax, eax
    xor ecx, ecx
flag_decrypter_loop:
    mov al, byte[flag+ecx]
    xor al, 0x42
    mov byte[flag+ecx],al
    inc ecx
    cmp ecx, 31
    jge flag_decrypter_exit
    jmp flag_decrypter_loop
flag_decrypter_exit:
    mov esp, ebp
    pop ebp
    ret

wrong:
    mov eax, 7
    push msg6
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
    push msg8
    push eax
    call output
    mov eax, 0x01
    int 0x80
    ret

section .data
msg1 db "Starting Program: Freckles Treat Vault 4",0x0A,0
msg5 db "Please enter Passcode:",0x0A,0
msg6 db "WRONG!",0x0A,0
msg7 db "Correct! BUT NO FLAG FOR YOU!...AGAIN - Freckles",0x0A,0
msg8 db "EXIT",0x0A,0
flag db 0x24,0x30,0x27,0x21,0x29,0x2e,0x27,0x31,0x01,0x2d,0x2c,0x70,0x70,0x39,0x30,0x71,0x76,0x26,0x1d,0x24,0x30,0x72,0x2f,0x1d,0x2f,0x71,0x2f,0x72,0x30,0x3b,0x3f,0x0A,0




section .bss
lenstr:  resd 1
charbuf: resb 1
input:  resb 256
