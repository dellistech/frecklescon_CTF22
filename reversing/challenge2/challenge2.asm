bits 32
section .text
global _start

_start:
    mov eax, 40
    push msg1
    push eax
    call output

    mov eax, 42
    push msg2
    push eax
    call output

    mov eax, 42
    push msg3
    push eax
    call output

    call flag_decrypter
    push msg9

    mov eax, 52
    push msg4
    push eax
    call output

    mov eax, 42
    push msg2
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
    cmp al, 0x63
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x6b
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x73
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x68
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
    cmp al, 0x34
    jne wrong
    inc ecx
    mov al, byte[input+ecx]
    cmp al, 0x74
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
    cmp al, 0x73
    jne wrong
    inc ecx
    jmp success

success:
    mov eax, 42
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
    mov al, byte[msg9+ecx]
    inc al
    mov byte[msg9+ecx],al
    inc ecx
    cmp ecx, 31
    jge flag_decrypter_return
    mov al, byte[msg9+ecx]
    dec al
    mov byte[msg9+ecx],al
    inc ecx
    cmp ecx, 31
    jge flag_decrypter_return
    jmp flag_decrypter_loop
flag_decrypter_return:
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
msg1 db "Starting Program: Freckles Treat Vault",0x0A,0
msg2 db "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",0x0A,0
msg3 db "PLEASE WAIT WHILE WE DECRYPT FLAG . . . ",0x0A,0
msg4 db "FLAG DECRYPTED SUCCESSFULLY AND LOADED ONTO STACK!",0x0A,0
msg5 db "Please enter Passcode:",0x0A,0
msg6 db "WRONG!",0x0A,0
msg7 db "Correct! BUT NO FLAG FOR YOU! - Freckles",0x0A,0
msg8 db "EXIT",0x0A,0
msg9 db 0x65,0x73,0x64,0x64,0x6a,0x6d,0x64,0x74,0x42,0x70,0x6d,0x33,0x31,0x7c,0x71,0x76,0x6d,0x75,0x30,0x6e,0x32,0x60,0x33,0x6f,0x33,0x6d,0x78,0x74,0x30,0x74,0x7c,0x0A,0




section .bss
lenstr:  resd 1
charbuf: resb 1
input:  resb 256
