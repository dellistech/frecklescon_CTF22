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
    cmp dword[lenstr],32
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
    cmp al, 0x47
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
    mov al, byte[input+ecx]
    cmp al, 0x54
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
    cmp al, 0x61
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x74
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x7a
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x41
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6e
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x64
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
    cmp al, 0x63
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6b
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x41
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6c
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6c
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
    cmp al, 0x54
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x68
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x69
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6e
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x67
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x73
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
    mov bl, byte[input+ecx]
    xor al, bl
    mov byte[flag+ecx],al
    inc ecx
    cmp ecx, 32
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
flag db 0x00,0x00,0x00,0x1b,0x2c,0x09,0x11,0x27,0x31,0x0a,0x0f,0x46,0x48,0x3a,0x08,0x16,0x2d,0x19,0x3c,0x03,0x20,0x14,0x33,0x60,0x37,0x11,0x26,0x0d,0x08,0x1a,0x1d,0x0e,0x0A,0




section .bss
lenstr:  resd 1
charbuf: resb 1
input:  resb 256
