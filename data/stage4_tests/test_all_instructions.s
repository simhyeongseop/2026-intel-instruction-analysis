.intel_syntax noprefix
// Auto-generated Intel assembly test
// Rule: follow manual syntax exactly, randomize concrete values only

// === CMC ===
    cmc

// === ADC AL, imm8 ===
    adc al, 0xff

// === ADC AX, imm16 ===
    adc ax, 0xffff

// === ADC EAX, imm32 ===
    adc eax, 0xffffffff

// === ADC RAX, imm32 ===
    adc rax, 0x7fffffff
    adc rax, -1

// === ADC r8, imm8 ===
    adc al, 0xff
    adc dl, 0xff
    adc bl, 0xff
    adc cl, 0xff

// === ADC m8, imm8 ===
    adc BYTE PTR [rbx], 0xff
    adc BYTE PTR [rax + rbx*1 + 0x10], 0xff
    adc BYTE PTR [rax + rbx*4 + 0x100], 0xff
    adc BYTE PTR [rip + 0x100], 0xff
    adc BYTE PTR [rax], 0xff
    adc BYTE PTR [rip + 0x1000], 0xff

// === ADC r16, imm16 ===
    adc cx, 0xffff
    adc ax, 0xffff
    adc di, 0xffff
    adc si, 0xffff
    adc dx, 0xffff
    adc bx, 0xffff

// === ADC m16, imm16 ===
    adc WORD PTR [rax + rbx*1 + 0x10], 0xffff
    adc WORD PTR [rbx], 0xffff
    adc WORD PTR [rip + 0x1000], 0xffff
    adc WORD PTR [rax], 0xffff
    adc WORD PTR [rax + rbx*4 + 0x100], 0xffff
    adc WORD PTR [rip + 0x100], 0xffff

// === ADC r32, imm32 ===
    adc edx, 0xffffffff
    adc edi, 0xffffffff
    adc esi, 0xffffffff
    adc ecx, 0xffffffff
    adc ebx, 0xffffffff
    adc eax, 0xffffffff

// === ADC m32, imm32 ===
    adc DWORD PTR [rip + 0x1000], 0xffffffff
    adc DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    adc DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    adc DWORD PTR [rbx], 0xffffffff
    adc DWORD PTR [rax], 0xffffffff
    adc DWORD PTR [rip + 0x100], 0xffffffff

// === ADC r64, imm32 ===
    adc r8, -1
    adc rbx, -1
    adc rdx, 0x7fffffff
    adc r12, -1
    adc rdi, -1
    adc rsi, 0x7fffffff
    adc r11, -1
    adc r10, 0x7fffffff
    adc r9, 0x7fffffff
    adc r12, 0x7fffffff

// === ADC m64, imm32 ===
    adc QWORD PTR [rax], -1
    adc QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    adc QWORD PTR [rax + rbx*4 + 0x100], -1
    adc QWORD PTR [rip + 0x100], -1
    adc QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    adc QWORD PTR [rax], 0x7fffffff
    adc QWORD PTR [rip + 0x100], 0x7fffffff
    adc QWORD PTR [rip + 0x1000], 0x7fffffff
    adc QWORD PTR [rbx], 0x7fffffff
    adc QWORD PTR [rip + 0x1000], -1

// === ADC r16, imm8 ===
    adc ax, 0xff
    adc si, 0xff
    adc di, 0xff
    adc bx, 0xff
    adc cx, 0xff
    adc dx, 0xff

// === ADC m16, imm8 ===
    adc WORD PTR [rax + rbx*1 + 0x10], 0xff
    adc WORD PTR [rip + 0x100], 0xff
    adc WORD PTR [rip + 0x1000], 0xff
    adc WORD PTR [rax + rbx*4 + 0x100], 0xff
    adc WORD PTR [rbx], 0xff
    adc WORD PTR [rax], 0xff

// === ADC r32, imm8 ===
    adc ecx, 0xff
    adc edi, 0xff
    adc ebx, 0xff
    adc eax, 0xff
    adc edx, 0xff
    adc esi, 0xff

// === ADC m32, imm8 ===
    adc DWORD PTR [rip + 0x1000], 0xff
    adc DWORD PTR [rax], 0xff
    adc DWORD PTR [rax + rbx*1 + 0x10], 0xff
    adc DWORD PTR [rbx], 0xff
    adc DWORD PTR [rip + 0x100], 0xff
    adc DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === ADC r64, imm8 ===
    adc rdx, 0xff
    adc r9, 0xff
    adc rcx, 0xff
    adc rdi, 0xff
    adc rbx, 0xff
    adc r13, 0xff
    adc rax, 0xff
    adc r10, 0xff
    adc r12, 0xff
    adc rsi, 0xff

// === ADC m64, imm8 ===
    adc QWORD PTR [rax + rbx*4 + 0x100], 0xff
    adc QWORD PTR [rax + rbx*1 + 0x10], 0xff
    adc QWORD PTR [rbx], 0xff
    adc QWORD PTR [rax], 0xff
    adc QWORD PTR [rip + 0x100], 0xff
    adc QWORD PTR [rip + 0x1000], 0xff

// === ADC r8, r8 ===
    adc bl, dl
    adc al, dl
    adc dl, cl
    adc bl, al
    adc bl, cl
    adc cl, bl
    adc cl, al
    adc al, al
    adc dl, bl
    adc al, bl

// === ADC m8, r8 ===
    adc BYTE PTR [rbx], al
    adc BYTE PTR [rax], bl
    adc BYTE PTR [rax + rbx*1 + 0x10], cl
    adc BYTE PTR [rip + 0x1000], dl
    adc BYTE PTR [rax + rbx*4 + 0x100], al
    adc BYTE PTR [rip + 0x100], bl
    adc BYTE PTR [rax + rbx*4 + 0x100], bl
    adc BYTE PTR [rip + 0x100], cl
    adc BYTE PTR [rip + 0x1000], bl
    adc BYTE PTR [rax], dl

// === ADC r16, r16 ===
    adc cx, di
    adc cx, dx
    adc ax, di
    adc di, ax
    adc cx, si
    adc cx, ax
    adc dx, cx
    adc di, bx
    adc bx, si
    adc ax, dx

// === ADC m16, r16 ===
    adc WORD PTR [rip + 0x1000], bx
    adc WORD PTR [rax + rbx*1 + 0x10], di
    adc WORD PTR [rax + rbx*4 + 0x100], ax
    adc WORD PTR [rip + 0x1000], di
    adc WORD PTR [rax + rbx*1 + 0x10], dx
    adc WORD PTR [rax], di
    adc WORD PTR [rax + rbx*4 + 0x100], di
    adc WORD PTR [rbx], bx
    adc WORD PTR [rax], bx
    adc WORD PTR [rip + 0x100], bx

// === ADC r32, r32 ===
    adc edx, edx
    adc eax, esi
    adc edi, ecx
    adc edx, esi
    adc edx, eax
    adc eax, ecx
    adc edi, eax
    adc ebx, edi
    adc edi, esi
    adc edx, edi

// === ADC m32, r32 ===
    adc DWORD PTR [rip + 0x100], ebx
    adc DWORD PTR [rip + 0x1000], esi
    adc DWORD PTR [rbx], eax
    adc DWORD PTR [rax], edi
    adc DWORD PTR [rbx], edx
    adc DWORD PTR [rip + 0x1000], eax
    adc DWORD PTR [rax + rbx*4 + 0x100], esi
    adc DWORD PTR [rax], ebx
    adc DWORD PTR [rip + 0x1000], edi
    adc DWORD PTR [rbx], edi

// === ADC r64, r64 ===
    adc rax, rsi
    adc rbx, r9
    adc r11, rcx
    adc r11, rbx
    adc rbx, rbx
    adc r9, r11
    adc r11, rdx
    adc rbx, rdx
    adc r8, rdi
    adc r13, r12

// === ADC m64, r64 ===
    adc QWORD PTR [rax + rbx*4 + 0x100], rdi
    adc QWORD PTR [rax], r12
    adc QWORD PTR [rip + 0x100], r10
    adc QWORD PTR [rbx], rdi
    adc QWORD PTR [rbx], rax
    adc QWORD PTR [rip + 0x100], rcx
    adc QWORD PTR [rax + rbx*1 + 0x10], rbx
    adc QWORD PTR [rax], rsi
    adc QWORD PTR [rbx], r8
    adc QWORD PTR [rbx], r13

// === ADC r8, m8 ===
    adc al, BYTE PTR [rip + 0x1000]
    adc dl, BYTE PTR [rax + rbx*1 + 0x10]
    adc bl, BYTE PTR [rax]
    adc cl, BYTE PTR [rbx]
    adc al, BYTE PTR [rip + 0x100]
    adc dl, BYTE PTR [rip + 0x100]
    adc cl, BYTE PTR [rax + rbx*4 + 0x100]
    adc cl, BYTE PTR [rax + rbx*1 + 0x10]
    adc al, BYTE PTR [rbx]
    adc bl, BYTE PTR [rax + rbx*4 + 0x100]

// === ADC r16, m16 ===
    adc ax, WORD PTR [rax]
    adc bx, WORD PTR [rip + 0x1000]
    adc dx, WORD PTR [rip + 0x100]
    adc si, WORD PTR [rax + rbx*1 + 0x10]
    adc dx, WORD PTR [rbx]
    adc di, WORD PTR [rip + 0x1000]
    adc cx, WORD PTR [rbx]
    adc ax, WORD PTR [rax + rbx*1 + 0x10]
    adc bx, WORD PTR [rax]
    adc ax, WORD PTR [rax + rbx*4 + 0x100]

// === ADC r32, m32 ===
    adc edi, DWORD PTR [rip + 0x100]
    adc eax, DWORD PTR [rax + rbx*1 + 0x10]
    adc ebx, DWORD PTR [rax]
    adc edx, DWORD PTR [rax + rbx*4 + 0x100]
    adc edx, DWORD PTR [rbx]
    adc ecx, DWORD PTR [rbx]
    adc ecx, DWORD PTR [rip + 0x100]
    adc ebx, DWORD PTR [rip + 0x1000]
    adc esi, DWORD PTR [rbx]
    adc esi, DWORD PTR [rip + 0x100]

// === ADC r64, m64 ===
    adc r11, QWORD PTR [rbx]
    adc r11, QWORD PTR [rax]
    adc r8, QWORD PTR [rax]
    adc rax, QWORD PTR [rax + rbx*4 + 0x100]
    adc r13, QWORD PTR [rip + 0x100]
    adc r10, QWORD PTR [rax + rbx*4 + 0x100]
    adc r9, QWORD PTR [rip + 0x1000]
    adc rbx, QWORD PTR [rax + rbx*4 + 0x100]
    adc r9, QWORD PTR [rbx]
    adc rbx, QWORD PTR [rip + 0x100]

// === ADD AL, imm8 ===
    add al, 0xff

// === ADD AX, imm16 ===
    add ax, 0xffff

// === ADD EAX, imm32 ===
    add eax, 0xffffffff

// === ADD RAX, imm32 ===
    add rax, -1
    add rax, 0x7fffffff

// === ADD r8, imm8 ===
    add al, 0xff
    add bl, 0xff
    add cl, 0xff
    add dl, 0xff

// === ADD m8, imm8 ===
    add BYTE PTR [rax], 0xff
    add BYTE PTR [rax + rbx*1 + 0x10], 0xff
    add BYTE PTR [rip + 0x1000], 0xff
    add BYTE PTR [rax + rbx*4 + 0x100], 0xff
    add BYTE PTR [rip + 0x100], 0xff
    add BYTE PTR [rbx], 0xff

// === ADD r16, imm16 ===
    add dx, 0xffff
    add cx, 0xffff
    add di, 0xffff
    add ax, 0xffff
    add si, 0xffff
    add bx, 0xffff

// === ADD m16, imm16 ===
    add WORD PTR [rip + 0x100], 0xffff
    add WORD PTR [rax], 0xffff
    add WORD PTR [rax + rbx*1 + 0x10], 0xffff
    add WORD PTR [rbx], 0xffff
    add WORD PTR [rip + 0x1000], 0xffff
    add WORD PTR [rax + rbx*4 + 0x100], 0xffff

// === ADD r32, imm32 ===
    add edi, 0xffffffff
    add edx, 0xffffffff
    add ecx, 0xffffffff
    add ebx, 0xffffffff
    add eax, 0xffffffff
    add esi, 0xffffffff

// === ADD m32, imm32 ===
    add DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    add DWORD PTR [rbx], 0xffffffff
    add DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    add DWORD PTR [rax], 0xffffffff
    add DWORD PTR [rip + 0x1000], 0xffffffff
    add DWORD PTR [rip + 0x100], 0xffffffff

// === ADD r64, imm32 ===
    add r8, 0x7fffffff
    add r11, -1
    add rcx, 0x7fffffff
    add r13, -1
    add r8, -1
    add rdi, 0x7fffffff
    add r9, 0x7fffffff
    add rax, -1
    add rsi, -1
    add rbx, 0x7fffffff

// === ADD m64, imm32 ===
    add QWORD PTR [rax + rbx*1 + 0x10], -1
    add QWORD PTR [rbx], -1
    add QWORD PTR [rbx], 0x7fffffff
    add QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    add QWORD PTR [rax], -1
    add QWORD PTR [rip + 0x1000], 0x7fffffff
    add QWORD PTR [rip + 0x1000], -1
    add QWORD PTR [rip + 0x100], -1
    add QWORD PTR [rax + rbx*4 + 0x100], -1
    add QWORD PTR [rip + 0x100], 0x7fffffff

// === ADD r16, imm8 ===
    add si, 0xff
    add ax, 0xff
    add di, 0xff
    add cx, 0xff
    add bx, 0xff
    add dx, 0xff

// === ADD m16, imm8 ===
    add WORD PTR [rax + rbx*1 + 0x10], 0xff
    add WORD PTR [rip + 0x1000], 0xff
    add WORD PTR [rax + rbx*4 + 0x100], 0xff
    add WORD PTR [rax], 0xff
    add WORD PTR [rbx], 0xff
    add WORD PTR [rip + 0x100], 0xff

// === ADD r32, imm8 ===
    add ecx, 0xff
    add esi, 0xff
    add edx, 0xff
    add edi, 0xff
    add eax, 0xff
    add ebx, 0xff

// === ADD m32, imm8 ===
    add DWORD PTR [rax + rbx*4 + 0x100], 0xff
    add DWORD PTR [rax], 0xff
    add DWORD PTR [rax + rbx*1 + 0x10], 0xff
    add DWORD PTR [rip + 0x1000], 0xff
    add DWORD PTR [rip + 0x100], 0xff
    add DWORD PTR [rbx], 0xff

// === ADD r64, imm8 ===
    add rdi, 0xff
    add rax, 0xff
    add r10, 0xff
    add r8, 0xff
    add rdx, 0xff
    add r13, 0xff
    add r11, 0xff
    add rcx, 0xff
    add r9, 0xff
    add r12, 0xff

// === ADD m64, imm8 ===
    add QWORD PTR [rip + 0x100], 0xff
    add QWORD PTR [rip + 0x1000], 0xff
    add QWORD PTR [rbx], 0xff
    add QWORD PTR [rax + rbx*1 + 0x10], 0xff
    add QWORD PTR [rax + rbx*4 + 0x100], 0xff
    add QWORD PTR [rax], 0xff

// === ADD r8, r8 ===
    add cl, dl
    add dl, bl
    add al, bl
    add dl, dl
    add al, al
    add dl, al
    add bl, cl
    add cl, al
    add al, cl
    add cl, bl

// === ADD m8, r8 ===
    add BYTE PTR [rax + rbx*4 + 0x100], dl
    add BYTE PTR [rax + rbx*1 + 0x10], bl
    add BYTE PTR [rip + 0x1000], cl
    add BYTE PTR [rip + 0x1000], bl
    add BYTE PTR [rax], al
    add BYTE PTR [rax + rbx*1 + 0x10], dl
    add BYTE PTR [rax], cl
    add BYTE PTR [rip + 0x100], al
    add BYTE PTR [rax + rbx*4 + 0x100], al
    add BYTE PTR [rax + rbx*4 + 0x100], bl

// === ADD r16, r16 ===
    add ax, bx
    add di, cx
    add di, di
    add di, ax
    add dx, ax
    add bx, si
    add cx, cx
    add si, si
    add si, bx
    add cx, si

// === ADD m16, r16 ===
    add WORD PTR [rax + rbx*4 + 0x100], bx
    add WORD PTR [rax + rbx*4 + 0x100], cx
    add WORD PTR [rip + 0x1000], di
    add WORD PTR [rbx], cx
    add WORD PTR [rip + 0x100], di
    add WORD PTR [rax], si
    add WORD PTR [rip + 0x1000], cx
    add WORD PTR [rax + rbx*1 + 0x10], ax
    add WORD PTR [rax], dx
    add WORD PTR [rip + 0x1000], bx

// === ADD r32, r32 ===
    add ecx, ecx
    add edx, esi
    add edi, ecx
    add eax, ebx
    add ebx, eax
    add esi, ecx
    add edi, edi
    add esi, edx
    add edi, esi
    add ecx, esi

// === ADD m32, r32 ===
    add DWORD PTR [rax + rbx*4 + 0x100], edx
    add DWORD PTR [rip + 0x100], eax
    add DWORD PTR [rax + rbx*1 + 0x10], ecx
    add DWORD PTR [rax + rbx*4 + 0x100], ebx
    add DWORD PTR [rax + rbx*4 + 0x100], edi
    add DWORD PTR [rip + 0x100], edi
    add DWORD PTR [rbx], edi
    add DWORD PTR [rax + rbx*4 + 0x100], ecx
    add DWORD PTR [rax + rbx*4 + 0x100], eax
    add DWORD PTR [rip + 0x1000], esi

// === ADD r64, r64 ===
    add rbx, r12
    add r9, r10
    add rdi, rbx
    add rdx, r13
    add r10, rdi
    add rsi, rsi
    add rdi, r9
    add r12, r9
    add rax, rcx
    add r11, r11

// === ADD m64, r64 ===
    add QWORD PTR [rbx], r11
    add QWORD PTR [rax + rbx*1 + 0x10], r11
    add QWORD PTR [rax + rbx*4 + 0x100], r8
    add QWORD PTR [rax], rsi
    add QWORD PTR [rip + 0x100], r13
    add QWORD PTR [rax + rbx*4 + 0x100], rdx
    add QWORD PTR [rax + rbx*4 + 0x100], r10
    add QWORD PTR [rbx], r8
    add QWORD PTR [rip + 0x100], rbx
    add QWORD PTR [rax], r8

// === ADD r8, m8 ===
    add cl, BYTE PTR [rip + 0x1000]
    add al, BYTE PTR [rax + rbx*4 + 0x100]
    add bl, BYTE PTR [rax + rbx*4 + 0x100]
    add bl, BYTE PTR [rbx]
    add al, BYTE PTR [rip + 0x100]
    add cl, BYTE PTR [rbx]
    add bl, BYTE PTR [rax]
    add dl, BYTE PTR [rip + 0x100]
    add bl, BYTE PTR [rip + 0x1000]
    add al, BYTE PTR [rax + rbx*1 + 0x10]

// === ADD r16, m16 ===
    add bx, WORD PTR [rip + 0x100]
    add dx, WORD PTR [rax + rbx*4 + 0x100]
    add bx, WORD PTR [rip + 0x1000]
    add si, WORD PTR [rax + rbx*4 + 0x100]
    add bx, WORD PTR [rbx]
    add dx, WORD PTR [rip + 0x100]
    add di, WORD PTR [rax]
    add si, WORD PTR [rax + rbx*1 + 0x10]
    add dx, WORD PTR [rip + 0x1000]
    add ax, WORD PTR [rax]

// === ADD r32, m32 ===
    add ebx, DWORD PTR [rax + rbx*1 + 0x10]
    add esi, DWORD PTR [rax]
    add edi, DWORD PTR [rbx]
    add ecx, DWORD PTR [rax + rbx*4 + 0x100]
    add edi, DWORD PTR [rax + rbx*1 + 0x10]
    add ebx, DWORD PTR [rbx]
    add edx, DWORD PTR [rbx]
    add ecx, DWORD PTR [rax]
    add ecx, DWORD PTR [rip + 0x1000]
    add edi, DWORD PTR [rax]

// === ADD r64, m64 ===
    add r11, QWORD PTR [rax + rbx*1 + 0x10]
    add r13, QWORD PTR [rax + rbx*1 + 0x10]
    add rsi, QWORD PTR [rip + 0x1000]
    add rcx, QWORD PTR [rip + 0x100]
    add r12, QWORD PTR [rax + rbx*1 + 0x10]
    add r9, QWORD PTR [rip + 0x1000]
    add rsi, QWORD PTR [rbx]
    add r13, QWORD PTR [rip + 0x1000]
    add rcx, QWORD PTR [rbx]
    add r8, QWORD PTR [rax + rbx*1 + 0x10]

// === AND AL, imm8 ===
    and al, 0xff

// === AND AX, imm16 ===
    and ax, 0xffff

// === AND EAX, imm32 ===
    and eax, 0xffffffff

// === AND RAX, imm32 ===
    and rax, 0x7fffffff
    and rax, -1

// === AND r8 , imm8 ===
    and cl, 0xff
    and al, 0xff
    and dl, 0xff
    and bl, 0xff

// === AND m8 , imm8 ===
    and BYTE PTR [rip + 0x1000], 0xff
    and BYTE PTR [rax + rbx*4 + 0x100], 0xff
    and BYTE PTR [rip + 0x100], 0xff
    and BYTE PTR [rax], 0xff
    and BYTE PTR [rbx], 0xff
    and BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === AND r16, imm16 ===
    and dx, 0xffff
    and bx, 0xffff
    and si, 0xffff
    and di, 0xffff
    and ax, 0xffff
    and cx, 0xffff

// === AND m16, imm16 ===
    and WORD PTR [rax + rbx*1 + 0x10], 0xffff
    and WORD PTR [rip + 0x1000], 0xffff
    and WORD PTR [rax + rbx*4 + 0x100], 0xffff
    and WORD PTR [rax], 0xffff
    and WORD PTR [rip + 0x100], 0xffff
    and WORD PTR [rbx], 0xffff

// === AND r32, imm32 ===
    and eax, 0xffffffff
    and ebx, 0xffffffff
    and ecx, 0xffffffff
    and edx, 0xffffffff
    and esi, 0xffffffff
    and edi, 0xffffffff

// === AND m32, imm32 ===
    and DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    and DWORD PTR [rip + 0x100], 0xffffffff
    and DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    and DWORD PTR [rip + 0x1000], 0xffffffff
    and DWORD PTR [rbx], 0xffffffff
    and DWORD PTR [rax], 0xffffffff

// === AND r64, imm32 ===
    and rdi, -1
    and r12, 0x7fffffff
    and rdx, 0x7fffffff
    and r10, -1
    and r8, 0x7fffffff
    and rdx, -1
    and r11, -1
    and rbx, -1
    and rax, 0x7fffffff
    and r9, 0x7fffffff

// === AND m64, imm32 ===
    and QWORD PTR [rax], 0x7fffffff
    and QWORD PTR [rip + 0x1000], -1
    and QWORD PTR [rip + 0x100], -1
    and QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    and QWORD PTR [rip + 0x1000], 0x7fffffff
    and QWORD PTR [rax], -1
    and QWORD PTR [rip + 0x100], 0x7fffffff
    and QWORD PTR [rbx], -1
    and QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    and QWORD PTR [rax + rbx*4 + 0x100], -1

// === AND r16, imm8 ===
    and dx, 0xff
    and ax, 0xff
    and bx, 0xff
    and si, 0xff
    and cx, 0xff
    and di, 0xff

// === AND m16, imm8 ===
    and WORD PTR [rax], 0xff
    and WORD PTR [rip + 0x100], 0xff
    and WORD PTR [rbx], 0xff
    and WORD PTR [rax + rbx*1 + 0x10], 0xff
    and WORD PTR [rax + rbx*4 + 0x100], 0xff
    and WORD PTR [rip + 0x1000], 0xff

// === AND r32, imm8 ===
    and esi, 0xff
    and edx, 0xff
    and ecx, 0xff
    and edi, 0xff
    and ebx, 0xff
    and eax, 0xff

// === AND m32, imm8 ===
    and DWORD PTR [rbx], 0xff
    and DWORD PTR [rip + 0x1000], 0xff
    and DWORD PTR [rip + 0x100], 0xff
    and DWORD PTR [rax + rbx*4 + 0x100], 0xff
    and DWORD PTR [rax + rbx*1 + 0x10], 0xff
    and DWORD PTR [rax], 0xff

// === AND r64, imm8 ===
    and r12, 0xff
    and rsi, 0xff
    and rdi, 0xff
    and rdx, 0xff
    and rbx, 0xff
    and r13, 0xff
    and r9, 0xff
    and r8, 0xff
    and rax, 0xff
    and r10, 0xff

// === AND m64, imm8 ===
    and QWORD PTR [rip + 0x1000], 0xff
    and QWORD PTR [rax], 0xff
    and QWORD PTR [rax + rbx*1 + 0x10], 0xff
    and QWORD PTR [rbx], 0xff
    and QWORD PTR [rip + 0x100], 0xff
    and QWORD PTR [rax + rbx*4 + 0x100], 0xff

// === AND r16, r16 ===
    and di, cx
    and bx, dx
    and ax, si
    and bx, bx
    and ax, ax
    and dx, ax
    and dx, si
    and cx, di
    and dx, cx
    and di, di

// === AND m16, r16 ===
    and WORD PTR [rax], si
    and WORD PTR [rip + 0x100], cx
    and WORD PTR [rip + 0x100], di
    and WORD PTR [rax + rbx*1 + 0x10], di
    and WORD PTR [rax + rbx*1 + 0x10], bx
    and WORD PTR [rip + 0x1000], bx
    and WORD PTR [rip + 0x100], si
    and WORD PTR [rax + rbx*4 + 0x100], dx
    and WORD PTR [rip + 0x100], bx
    and WORD PTR [rax + rbx*4 + 0x100], cx

// === AND r32, r32 ===
    and ebx, esi
    and ecx, ecx
    and edx, eax
    and edx, edi
    and eax, esi
    and edi, esi
    and ebx, edx
    and ebx, ecx
    and esi, eax
    and ebx, edi

// === AND m32, r32 ===
    and DWORD PTR [rax], eax
    and DWORD PTR [rax + rbx*1 + 0x10], ecx
    and DWORD PTR [rax], ebx
    and DWORD PTR [rax + rbx*1 + 0x10], esi
    and DWORD PTR [rip + 0x1000], esi
    and DWORD PTR [rax + rbx*4 + 0x100], ebx
    and DWORD PTR [rip + 0x1000], ebx
    and DWORD PTR [rax], edx
    and DWORD PTR [rax + rbx*1 + 0x10], ebx
    and DWORD PTR [rip + 0x1000], ecx

// === AND r64, r64 ===
    and r9, rsi
    and r10, rdx
    and rdi, rcx
    and r8, r10
    and rax, r8
    and rsi, r10
    and r8, rax
    and r13, r8
    and r9, rdx
    and r11, r10

// === AND m64, r64 ===
    and QWORD PTR [rbx], r13
    and QWORD PTR [rax + rbx*1 + 0x10], rsi
    and QWORD PTR [rip + 0x100], r10
    and QWORD PTR [rbx], r10
    and QWORD PTR [rax + rbx*1 + 0x10], rcx
    and QWORD PTR [rax + rbx*1 + 0x10], rdx
    and QWORD PTR [rax + rbx*4 + 0x100], r12
    and QWORD PTR [rax + rbx*1 + 0x10], r8
    and QWORD PTR [rax], rdi
    and QWORD PTR [rax + rbx*1 + 0x10], rax

// === AND r16, m16 ===
    and si, WORD PTR [rax + rbx*1 + 0x10]
    and cx, WORD PTR [rax]
    and ax, WORD PTR [rax + rbx*4 + 0x100]
    and di, WORD PTR [rip + 0x1000]
    and cx, WORD PTR [rip + 0x1000]
    and ax, WORD PTR [rip + 0x1000]
    and si, WORD PTR [rax]
    and bx, WORD PTR [rax]
    and ax, WORD PTR [rax]
    and dx, WORD PTR [rip + 0x100]

// === AND r32, m32 ===
    and ecx, DWORD PTR [rbx]
    and ecx, DWORD PTR [rax + rbx*1 + 0x10]
    and edi, DWORD PTR [rax]
    and edi, DWORD PTR [rbx]
    and eax, DWORD PTR [rax]
    and ebx, DWORD PTR [rax + rbx*4 + 0x100]
    and ecx, DWORD PTR [rip + 0x100]
    and ecx, DWORD PTR [rax]
    and eax, DWORD PTR [rbx]
    and edx, DWORD PTR [rip + 0x1000]

// === AND r64, m64 ===
    and rsi, QWORD PTR [rax]
    and r9, QWORD PTR [rax]
    and r9, QWORD PTR [rip + 0x1000]
    and rdx, QWORD PTR [rbx]
    and r9, QWORD PTR [rip + 0x100]
    and r10, QWORD PTR [rax]
    and rdi, QWORD PTR [rip + 0x1000]
    and r13, QWORD PTR [rip + 0x100]
    and r12, QWORD PTR [rax + rbx*1 + 0x10]
    and r12, QWORD PTR [rax]

// === BSF r16, r16 ===
    bsf bx, di
    bsf ax, ax
    bsf ax, dx
    bsf cx, di
    bsf si, bx
    bsf ax, bx
    bsf di, si
    bsf cx, cx
    bsf bx, ax
    bsf bx, dx

// === BSF r16, m16 ===
    bsf ax, WORD PTR [rip + 0x100]
    bsf si, WORD PTR [rip + 0x1000]
    bsf cx, WORD PTR [rax]
    bsf cx, WORD PTR [rip + 0x1000]
    bsf si, WORD PTR [rax]
    bsf bx, WORD PTR [rip + 0x1000]
    bsf cx, WORD PTR [rip + 0x100]
    bsf si, WORD PTR [rbx]
    bsf si, WORD PTR [rax + rbx*1 + 0x10]
    bsf cx, WORD PTR [rbx]

// === BSF r32, r32 ===
    bsf ecx, edi
    bsf esi, ecx
    bsf ebx, eax
    bsf ecx, edx
    bsf eax, eax
    bsf eax, edx
    bsf edx, esi
    bsf esi, eax
    bsf edi, eax
    bsf esi, edx

// === BSF r32, m32 ===
    bsf edi, DWORD PTR [rax + rbx*4 + 0x100]
    bsf edx, DWORD PTR [rax + rbx*1 + 0x10]
    bsf eax, DWORD PTR [rip + 0x1000]
    bsf ebx, DWORD PTR [rax + rbx*4 + 0x100]
    bsf esi, DWORD PTR [rax + rbx*1 + 0x10]
    bsf edi, DWORD PTR [rip + 0x1000]
    bsf ebx, DWORD PTR [rip + 0x1000]
    bsf ebx, DWORD PTR [rip + 0x100]
    bsf ecx, DWORD PTR [rax + rbx*1 + 0x10]
    bsf esi, DWORD PTR [rip + 0x1000]

// === BSF r64, r64 ===
    bsf rdi, rdx
    bsf rax, rax
    bsf r8, r9
    bsf r9, r8
    bsf rcx, rdi
    bsf rdi, rax
    bsf rdx, rcx
    bsf r12, rdi
    bsf rax, rbx
    bsf r9, rdx

// === BSF r64, m64 ===
    bsf r8, QWORD PTR [rax + rbx*1 + 0x10]
    bsf rsi, QWORD PTR [rbx]
    bsf r8, QWORD PTR [rbx]
    bsf rsi, QWORD PTR [rax]
    bsf r9, QWORD PTR [rip + 0x100]
    bsf r11, QWORD PTR [rax]
    bsf r12, QWORD PTR [rbx]
    bsf r12, QWORD PTR [rip + 0x100]
    bsf r13, QWORD PTR [rbx]
    bsf rdx, QWORD PTR [rbx]

// === BSR r16, r16 ===
    bsr cx, cx
    bsr ax, ax
    bsr ax, di
    bsr ax, si
    bsr dx, di
    bsr ax, cx
    bsr bx, ax
    bsr di, si
    bsr si, dx
    bsr si, cx

// === BSR r16, m16 ===
    bsr bx, WORD PTR [rax]
    bsr ax, WORD PTR [rax + rbx*4 + 0x100]
    bsr dx, WORD PTR [rax + rbx*4 + 0x100]
    bsr bx, WORD PTR [rbx]
    bsr si, WORD PTR [rax]
    bsr cx, WORD PTR [rip + 0x1000]
    bsr cx, WORD PTR [rax + rbx*4 + 0x100]
    bsr cx, WORD PTR [rip + 0x100]
    bsr si, WORD PTR [rip + 0x100]
    bsr dx, WORD PTR [rax + rbx*1 + 0x10]

// === BSR r32, r32 ===
    bsr esi, ebx
    bsr eax, ebx
    bsr esi, edi
    bsr esi, edx
    bsr ecx, ebx
    bsr edx, eax
    bsr ebx, ebx
    bsr edx, edi
    bsr ebx, eax
    bsr edi, ebx

// === BSR r32, m32 ===
    bsr edx, DWORD PTR [rax + rbx*1 + 0x10]
    bsr ecx, DWORD PTR [rip + 0x100]
    bsr ebx, DWORD PTR [rax]
    bsr ecx, DWORD PTR [rax + rbx*4 + 0x100]
    bsr edx, DWORD PTR [rax]
    bsr edi, DWORD PTR [rip + 0x100]
    bsr eax, DWORD PTR [rax + rbx*1 + 0x10]
    bsr ebx, DWORD PTR [rbx]
    bsr eax, DWORD PTR [rbx]
    bsr ebx, DWORD PTR [rax + rbx*4 + 0x100]

// === BSR r64, r64 ===
    bsr r13, rcx
    bsr rbx, r12
    bsr r11, r13
    bsr r12, rcx
    bsr rbx, rdi
    bsr r10, rbx
    bsr r10, r11
    bsr r9, r13
    bsr rax, r12
    bsr rdi, r11

// === BSR r64, m64 ===
    bsr rbx, QWORD PTR [rax + rbx*4 + 0x100]
    bsr rbx, QWORD PTR [rax]
    bsr r10, QWORD PTR [rax + rbx*4 + 0x100]
    bsr rdx, QWORD PTR [rip + 0x100]
    bsr rdi, QWORD PTR [rax + rbx*1 + 0x10]
    bsr r10, QWORD PTR [rip + 0x100]
    bsr rbx, QWORD PTR [rip + 0x1000]
    bsr r11, QWORD PTR [rax + rbx*1 + 0x10]
    bsr r11, QWORD PTR [rip + 0x1000]
    bsr r9, QWORD PTR [rip + 0x1000]

// === BSWAP r32 ===
    bswap edx
    bswap ebx
    bswap edi
    bswap eax
    bswap esi
    bswap ecx

// === BSWAP r64 ===
    bswap rsi
    bswap r11
    bswap r12
    bswap rax
    bswap r9
    bswap r8
    bswap rdx
    bswap r13
    bswap rdi
    bswap rcx

// === BT r16, r16 ===
    bt dx, bx
    bt bx, bx
    bt dx, ax
    bt ax, cx
    bt bx, cx
    bt bx, dx
    bt di, bx
    bt di, cx
    bt di, si
    bt cx, di

// === BT m16, r16 ===
    bt WORD PTR [rbx], ax
    bt WORD PTR [rip + 0x1000], si
    bt WORD PTR [rip + 0x100], di
    bt WORD PTR [rax], si
    bt WORD PTR [rip + 0x1000], dx
    bt WORD PTR [rip + 0x100], ax
    bt WORD PTR [rax + rbx*4 + 0x100], bx
    bt WORD PTR [rip + 0x1000], bx
    bt WORD PTR [rip + 0x1000], cx
    bt WORD PTR [rip + 0x1000], ax

// === BT r32, r32 ===
    bt edi, esi
    bt esi, edi
    bt edx, ecx
    bt ebx, ebx
    bt esi, ecx
    bt edi, ecx
    bt edx, ebx
    bt ecx, edi
    bt eax, ecx
    bt esi, ebx

// === BT m32, r32 ===
    bt DWORD PTR [rbx], ebx
    bt DWORD PTR [rax + rbx*1 + 0x10], ebx
    bt DWORD PTR [rax], edi
    bt DWORD PTR [rbx], eax
    bt DWORD PTR [rax + rbx*1 + 0x10], edi
    bt DWORD PTR [rip + 0x100], edx
    bt DWORD PTR [rax + rbx*4 + 0x100], eax
    bt DWORD PTR [rax + rbx*1 + 0x10], ecx
    bt DWORD PTR [rax + rbx*4 + 0x100], edi
    bt DWORD PTR [rip + 0x100], edi

// === BT r64, r64 ===
    bt rsi, r9
    bt rdi, r9
    bt r8, r11
    bt r13, r13
    bt rsi, r13
    bt r12, rdi
    bt rdx, rdi
    bt rdx, r8
    bt rdi, r11
    bt r9, rsi

// === BT m64, r64 ===
    bt QWORD PTR [rax + rbx*4 + 0x100], r8
    bt QWORD PTR [rip + 0x1000], r11
    bt QWORD PTR [rip + 0x100], r8
    bt QWORD PTR [rax], r8
    bt QWORD PTR [rbx], rsi
    bt QWORD PTR [rbx], rbx
    bt QWORD PTR [rbx], rdi
    bt QWORD PTR [rax + rbx*1 + 0x10], rdi
    bt QWORD PTR [rax], r10
    bt QWORD PTR [rip + 0x1000], rax

// === BT r16, imm8 ===
    bt si, 0xff
    bt cx, 0xff
    bt dx, 0xff
    bt ax, 0xff
    bt bx, 0xff
    bt di, 0xff

// === BT m16, imm8 ===
    bt WORD PTR [rax + rbx*1 + 0x10], 0xff
    bt WORD PTR [rip + 0x1000], 0xff
    bt WORD PTR [rbx], 0xff
    bt WORD PTR [rip + 0x100], 0xff
    bt WORD PTR [rax], 0xff
    bt WORD PTR [rax + rbx*4 + 0x100], 0xff

// === BT r32, imm8 ===
    bt edx, 0xff
    bt esi, 0xff
    bt ecx, 0xff
    bt edi, 0xff
    bt ebx, 0xff
    bt eax, 0xff

// === BT m32, imm8 ===
    bt DWORD PTR [rip + 0x1000], 0xff
    bt DWORD PTR [rax], 0xff
    bt DWORD PTR [rax + rbx*1 + 0x10], 0xff
    bt DWORD PTR [rax + rbx*4 + 0x100], 0xff
    bt DWORD PTR [rip + 0x100], 0xff
    bt DWORD PTR [rbx], 0xff

// === BT r64, imm8 ===
    bt r10, 0xff
    bt rdi, 0xff
    bt r9, 0xff
    bt rdx, 0xff
    bt rsi, 0xff
    bt rcx, 0xff
    bt r12, 0xff
    bt rbx, 0xff
    bt r13, 0xff
    bt r8, 0xff

// === BT m64, imm8 ===
    bt QWORD PTR [rip + 0x1000], 0xff
    bt QWORD PTR [rax + rbx*1 + 0x10], 0xff
    bt QWORD PTR [rax + rbx*4 + 0x100], 0xff
    bt QWORD PTR [rax], 0xff
    bt QWORD PTR [rbx], 0xff
    bt QWORD PTR [rip + 0x100], 0xff

// === BTC r16, r16 ===
    btc bx, ax
    btc cx, ax
    btc di, bx
    btc si, ax
    btc di, di
    btc cx, dx
    btc dx, bx
    btc ax, cx
    btc ax, ax
    btc dx, di

// === BTC m16, r16 ===
    btc WORD PTR [rip + 0x100], di
    btc WORD PTR [rax + rbx*1 + 0x10], ax
    btc WORD PTR [rip + 0x100], bx
    btc WORD PTR [rbx], cx
    btc WORD PTR [rax + rbx*1 + 0x10], bx
    btc WORD PTR [rax], ax
    btc WORD PTR [rip + 0x100], dx
    btc WORD PTR [rip + 0x1000], si
    btc WORD PTR [rip + 0x1000], bx
    btc WORD PTR [rax], si

// === BTC r32, r32 ===
    btc edi, edi
    btc esi, edx
    btc ebx, edi
    btc edx, ecx
    btc ebx, ebx
    btc ebx, ecx
    btc eax, edx
    btc ecx, ebx
    btc eax, ecx
    btc edi, ebx

// === BTC m32, r32 ===
    btc DWORD PTR [rbx], edx
    btc DWORD PTR [rax], eax
    btc DWORD PTR [rip + 0x100], esi
    btc DWORD PTR [rbx], ecx
    btc DWORD PTR [rax + rbx*4 + 0x100], esi
    btc DWORD PTR [rax + rbx*4 + 0x100], eax
    btc DWORD PTR [rip + 0x1000], edx
    btc DWORD PTR [rbx], eax
    btc DWORD PTR [rbx], esi
    btc DWORD PTR [rax + rbx*4 + 0x100], edx

// === BTC r64, r64 ===
    btc r13, r12
    btc rcx, rax
    btc rax, r11
    btc rdi, rdx
    btc r8, r8
    btc r13, rcx
    btc rbx, r11
    btc r8, r10
    btc r11, rax
    btc rax, rdi

// === BTC m64, r64 ===
    btc QWORD PTR [rax + rbx*4 + 0x100], r9
    btc QWORD PTR [rip + 0x100], rdi
    btc QWORD PTR [rax], rax
    btc QWORD PTR [rax], r9
    btc QWORD PTR [rbx], rcx
    btc QWORD PTR [rax + rbx*1 + 0x10], r11
    btc QWORD PTR [rax + rbx*4 + 0x100], rdx
    btc QWORD PTR [rip + 0x100], r9
    btc QWORD PTR [rax], rdx
    btc QWORD PTR [rax], r12

// === BTC r16, imm8 ===
    btc dx, 0xff
    btc bx, 0xff
    btc ax, 0xff
    btc si, 0xff
    btc di, 0xff
    btc cx, 0xff

// === BTC m16, imm8 ===
    btc WORD PTR [rbx], 0xff
    btc WORD PTR [rax + rbx*4 + 0x100], 0xff
    btc WORD PTR [rip + 0x1000], 0xff
    btc WORD PTR [rax], 0xff
    btc WORD PTR [rax + rbx*1 + 0x10], 0xff
    btc WORD PTR [rip + 0x100], 0xff

// === BTC r32, imm8 ===
    btc esi, 0xff
    btc ecx, 0xff
    btc edx, 0xff
    btc edi, 0xff
    btc ebx, 0xff
    btc eax, 0xff

// === BTC m32, imm8 ===
    btc DWORD PTR [rax], 0xff
    btc DWORD PTR [rbx], 0xff
    btc DWORD PTR [rax + rbx*4 + 0x100], 0xff
    btc DWORD PTR [rax + rbx*1 + 0x10], 0xff
    btc DWORD PTR [rip + 0x100], 0xff
    btc DWORD PTR [rip + 0x1000], 0xff

// === BTC r64, imm8 ===
    btc rax, 0xff
    btc r9, 0xff
    btc rsi, 0xff
    btc r13, 0xff
    btc r8, 0xff
    btc rbx, 0xff
    btc r12, 0xff
    btc rcx, 0xff
    btc rdx, 0xff
    btc r10, 0xff

// === BTC m64, imm8 ===
    btc QWORD PTR [rax + rbx*1 + 0x10], 0xff
    btc QWORD PTR [rip + 0x1000], 0xff
    btc QWORD PTR [rip + 0x100], 0xff
    btc QWORD PTR [rax], 0xff
    btc QWORD PTR [rax + rbx*4 + 0x100], 0xff
    btc QWORD PTR [rbx], 0xff

// === BTR r16, r16 ===
    btr dx, dx
    btr ax, dx
    btr si, si
    btr dx, bx
    btr bx, cx
    btr dx, si
    btr di, bx
    btr si, di
    btr si, bx
    btr dx, di

// === BTR m16, r16 ===
    btr WORD PTR [rax + rbx*4 + 0x100], dx
    btr WORD PTR [rip + 0x100], bx
    btr WORD PTR [rax + rbx*1 + 0x10], dx
    btr WORD PTR [rax], cx
    btr WORD PTR [rax], bx
    btr WORD PTR [rax + rbx*1 + 0x10], si
    btr WORD PTR [rbx], ax
    btr WORD PTR [rip + 0x100], cx
    btr WORD PTR [rbx], si
    btr WORD PTR [rip + 0x100], di

// === BTR r32, r32 ===
    btr ebx, esi
    btr eax, ebx
    btr ebx, edx
    btr eax, eax
    btr ecx, ecx
    btr eax, edi
    btr edi, edi
    btr edx, edx
    btr eax, ecx
    btr edi, ebx

// === BTR m32, r32 ===
    btr DWORD PTR [rax], ecx
    btr DWORD PTR [rip + 0x1000], esi
    btr DWORD PTR [rax], ebx
    btr DWORD PTR [rax + rbx*1 + 0x10], eax
    btr DWORD PTR [rip + 0x100], esi
    btr DWORD PTR [rax + rbx*4 + 0x100], ecx
    btr DWORD PTR [rbx], edi
    btr DWORD PTR [rip + 0x100], edx
    btr DWORD PTR [rbx], eax
    btr DWORD PTR [rip + 0x1000], ecx

// === BTR r64, r64 ===
    btr r12, r8
    btr rsi, rcx
    btr r13, r12
    btr r13, rcx
    btr rsi, rax
    btr rdi, r11
    btr rcx, rax
    btr r10, rcx
    btr rdx, rdi
    btr rdx, rax

// === BTR m64, r64 ===
    btr QWORD PTR [rip + 0x100], r9
    btr QWORD PTR [rax + rbx*4 + 0x100], r8
    btr QWORD PTR [rip + 0x100], rbx
    btr QWORD PTR [rip + 0x100], rsi
    btr QWORD PTR [rip + 0x100], r11
    btr QWORD PTR [rax + rbx*4 + 0x100], rcx
    btr QWORD PTR [rip + 0x100], r10
    btr QWORD PTR [rax], r12
    btr QWORD PTR [rax + rbx*1 + 0x10], r8
    btr QWORD PTR [rip + 0x100], rcx

// === BTR r16, imm8 ===
    btr ax, 0xff
    btr dx, 0xff
    btr bx, 0xff
    btr si, 0xff
    btr di, 0xff
    btr cx, 0xff

// === BTR m16, imm8 ===
    btr WORD PTR [rbx], 0xff
    btr WORD PTR [rax + rbx*4 + 0x100], 0xff
    btr WORD PTR [rax], 0xff
    btr WORD PTR [rip + 0x1000], 0xff
    btr WORD PTR [rip + 0x100], 0xff
    btr WORD PTR [rax + rbx*1 + 0x10], 0xff

// === BTR r32, imm8 ===
    btr edx, 0xff
    btr eax, 0xff
    btr esi, 0xff
    btr ebx, 0xff
    btr ecx, 0xff
    btr edi, 0xff

// === BTR m32, imm8 ===
    btr DWORD PTR [rax + rbx*1 + 0x10], 0xff
    btr DWORD PTR [rip + 0x1000], 0xff
    btr DWORD PTR [rip + 0x100], 0xff
    btr DWORD PTR [rax], 0xff
    btr DWORD PTR [rbx], 0xff
    btr DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === BTR r64, imm8 ===
    btr r11, 0xff
    btr rdx, 0xff
    btr rdi, 0xff
    btr rcx, 0xff
    btr rax, 0xff
    btr r10, 0xff
    btr r13, 0xff
    btr r12, 0xff
    btr rsi, 0xff
    btr rbx, 0xff

// === BTR m64, imm8 ===
    btr QWORD PTR [rbx], 0xff
    btr QWORD PTR [rax + rbx*4 + 0x100], 0xff
    btr QWORD PTR [rax], 0xff
    btr QWORD PTR [rax + rbx*1 + 0x10], 0xff
    btr QWORD PTR [rip + 0x1000], 0xff
    btr QWORD PTR [rip + 0x100], 0xff

// === BTS r16, r16 ===
    bts si, dx
    bts di, cx
    bts cx, bx
    bts dx, di
    bts ax, si
    bts bx, dx
    bts dx, si
    bts cx, dx
    bts dx, cx
    bts dx, bx

// === BTS m16, r16 ===
    bts WORD PTR [rip + 0x100], ax
    bts WORD PTR [rbx], si
    bts WORD PTR [rax], ax
    bts WORD PTR [rip + 0x1000], dx
    bts WORD PTR [rax + rbx*1 + 0x10], si
    bts WORD PTR [rax], di
    bts WORD PTR [rax + rbx*4 + 0x100], ax
    bts WORD PTR [rip + 0x100], cx
    bts WORD PTR [rbx], bx
    bts WORD PTR [rip + 0x1000], bx

// === BTS r32, r32 ===
    bts eax, ecx
    bts ecx, eax
    bts eax, edi
    bts ebx, eax
    bts ecx, ebx
    bts edx, esi
    bts edi, edx
    bts edi, ebx
    bts edx, eax
    bts ecx, ecx

// === BTS m32, r32 ===
    bts DWORD PTR [rax + rbx*1 + 0x10], ebx
    bts DWORD PTR [rip + 0x1000], edx
    bts DWORD PTR [rip + 0x1000], ecx
    bts DWORD PTR [rax], eax
    bts DWORD PTR [rbx], edi
    bts DWORD PTR [rax + rbx*1 + 0x10], ecx
    bts DWORD PTR [rax + rbx*4 + 0x100], edi
    bts DWORD PTR [rax], edi
    bts DWORD PTR [rax + rbx*4 + 0x100], esi
    bts DWORD PTR [rip + 0x100], esi

// === BTS r64, r64 ===
    bts r13, r11
    bts rsi, r10
    bts r10, rdi
    bts r8, r8
    bts r11, rsi
    bts r10, r11
    bts r11, rdx
    bts rax, rax
    bts rdi, rbx
    bts r11, r12

// === BTS m64, r64 ===
    bts QWORD PTR [rip + 0x1000], r13
    bts QWORD PTR [rax + rbx*1 + 0x10], r8
    bts QWORD PTR [rax + rbx*4 + 0x100], rdi
    bts QWORD PTR [rip + 0x1000], r8
    bts QWORD PTR [rbx], rdi
    bts QWORD PTR [rax + rbx*1 + 0x10], r10
    bts QWORD PTR [rax + rbx*1 + 0x10], rcx
    bts QWORD PTR [rbx], r9
    bts QWORD PTR [rax], r9
    bts QWORD PTR [rbx], r8

// === BTS r16, imm8 ===
    bts dx, 0xff
    bts di, 0xff
    bts ax, 0xff
    bts si, 0xff
    bts bx, 0xff
    bts cx, 0xff

// === BTS m16, imm8 ===
    bts WORD PTR [rip + 0x1000], 0xff
    bts WORD PTR [rax + rbx*4 + 0x100], 0xff
    bts WORD PTR [rax + rbx*1 + 0x10], 0xff
    bts WORD PTR [rbx], 0xff
    bts WORD PTR [rax], 0xff
    bts WORD PTR [rip + 0x100], 0xff

// === BTS r32, imm8 ===
    bts edx, 0xff
    bts eax, 0xff
    bts esi, 0xff
    bts ecx, 0xff
    bts edi, 0xff
    bts ebx, 0xff

// === BTS m32, imm8 ===
    bts DWORD PTR [rip + 0x100], 0xff
    bts DWORD PTR [rax + rbx*4 + 0x100], 0xff
    bts DWORD PTR [rip + 0x1000], 0xff
    bts DWORD PTR [rbx], 0xff
    bts DWORD PTR [rax], 0xff
    bts DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === BTS r64, imm8 ===
    bts r8, 0xff
    bts rbx, 0xff
    bts r10, 0xff
    bts rax, 0xff
    bts rdx, 0xff
    bts r13, 0xff
    bts rdi, 0xff
    bts rcx, 0xff
    bts r9, 0xff
    bts r12, 0xff

// === BTS m64, imm8 ===
    bts QWORD PTR [rbx], 0xff
    bts QWORD PTR [rax + rbx*1 + 0x10], 0xff
    bts QWORD PTR [rip + 0x100], 0xff
    bts QWORD PTR [rax], 0xff
    bts QWORD PTR [rip + 0x1000], 0xff
    bts QWORD PTR [rax + rbx*4 + 0x100], 0xff

// === CALL rel32 ===
    call 0f
0:

// === CALL r64 ===
    call r10
    call rbx
    call r12
    call rsi
    call rcx
    call rax
    call r13
    call rdx
    call rdi
    call r11

// === CALL m64 ===
    call QWORD PTR [rax + rbx*1 + 0x10]
    call QWORD PTR [rax + rbx*4 + 0x100]
    call QWORD PTR [rip + 0x1000]
    call QWORD PTR [rax]
    call QWORD PTR [rip + 0x100]
    call QWORD PTR [rbx]

// === CBW ===
    cbw

// === CWDE ===
    cwde

// === CDQE ===
    cdqe

// === CLC ===
    clc

// === CLD ===
    cld

// === CLI ===
    cli

// === CLTS ===
    clts

// === CMOVA r16, r16 ===
    cmova si, dx
    cmova bx, cx
    cmova cx, di
    cmova di, si
    cmova di, dx
    cmova dx, dx
    cmova si, si
    cmova cx, dx
    cmova ax, dx
    cmova di, ax

// === CMOVA r16, m16 ===
    cmova dx, WORD PTR [rip + 0x1000]
    cmova di, WORD PTR [rax]
    cmova dx, WORD PTR [rip + 0x100]
    cmova ax, WORD PTR [rax]
    cmova cx, WORD PTR [rip + 0x100]
    cmova dx, WORD PTR [rax]
    cmova bx, WORD PTR [rip + 0x100]
    cmova cx, WORD PTR [rip + 0x1000]
    cmova cx, WORD PTR [rax + rbx*4 + 0x100]
    cmova dx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVA r32, r32 ===
    cmova edx, edx
    cmova edi, ecx
    cmova eax, edi
    cmova ecx, eax
    cmova esi, edi
    cmova esi, edx
    cmova eax, edx
    cmova edx, edi
    cmova ecx, ecx
    cmova edi, ebx

// === CMOVA r32, m32 ===
    cmova ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmova edi, DWORD PTR [rbx]
    cmova ecx, DWORD PTR [rip + 0x100]
    cmova edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmova esi, DWORD PTR [rip + 0x100]
    cmova ecx, DWORD PTR [rax]
    cmova ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmova eax, DWORD PTR [rip + 0x1000]
    cmova ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmova edx, DWORD PTR [rip + 0x1000]

// === CMOVA r64, r64 ===
    cmova r11, rdx
    cmova r9, rdi
    cmova rsi, rax
    cmova rcx, r13
    cmova r13, rsi
    cmova rcx, r10
    cmova r8, rbx
    cmova r9, r13
    cmova r10, r11
    cmova rcx, rdi

// === CMOVA r64, m64 ===
    cmova r9, QWORD PTR [rax]
    cmova rsi, QWORD PTR [rax]
    cmova rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmova rax, QWORD PTR [rip + 0x1000]
    cmova rdx, QWORD PTR [rip + 0x100]
    cmova rdi, QWORD PTR [rip + 0x1000]
    cmova r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmova r13, QWORD PTR [rbx]
    cmova r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmova r10, QWORD PTR [rax]

// === CMOVAE r16, r16 ===
    cmovae di, dx
    cmovae bx, si
    cmovae di, cx
    cmovae si, bx
    cmovae si, ax
    cmovae bx, cx
    cmovae si, cx
    cmovae bx, ax
    cmovae di, ax
    cmovae ax, ax

// === CMOVAE r16, m16 ===
    cmovae bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovae si, WORD PTR [rip + 0x100]
    cmovae dx, WORD PTR [rip + 0x100]
    cmovae cx, WORD PTR [rax]
    cmovae si, WORD PTR [rip + 0x1000]
    cmovae bx, WORD PTR [rax]
    cmovae cx, WORD PTR [rip + 0x1000]
    cmovae si, WORD PTR [rax + rbx*1 + 0x10]
    cmovae bx, WORD PTR [rip + 0x1000]
    cmovae dx, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVAE r32, r32 ===
    cmovae ecx, esi
    cmovae edx, edx
    cmovae eax, ebx
    cmovae edx, ecx
    cmovae edx, ebx
    cmovae edi, edx
    cmovae ebx, ecx
    cmovae ecx, edi
    cmovae ecx, ebx
    cmovae edi, esi

// === CMOVAE r32, m32 ===
    cmovae ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovae esi, DWORD PTR [rip + 0x100]
    cmovae edx, DWORD PTR [rip + 0x1000]
    cmovae edi, DWORD PTR [rip + 0x1000]
    cmovae ebx, DWORD PTR [rbx]
    cmovae eax, DWORD PTR [rip + 0x100]
    cmovae eax, DWORD PTR [rip + 0x1000]
    cmovae ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovae edx, DWORD PTR [rax]
    cmovae edi, DWORD PTR [rax]

// === CMOVAE r64, r64 ===
    cmovae r9, rdx
    cmovae rbx, r9
    cmovae rsi, rsi
    cmovae rdi, r9
    cmovae r9, r8
    cmovae rcx, r12
    cmovae r8, rcx
    cmovae r8, rdx
    cmovae r8, r9
    cmovae r10, rdi

// === CMOVAE r64, m64 ===
    cmovae r13, QWORD PTR [rax]
    cmovae r10, QWORD PTR [rip + 0x100]
    cmovae r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovae rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovae rdi, QWORD PTR [rip + 0x100]
    cmovae rsi, QWORD PTR [rip + 0x1000]
    cmovae rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovae r10, QWORD PTR [rip + 0x1000]
    cmovae rdi, QWORD PTR [rbx]
    cmovae r11, QWORD PTR [rax + rbx*1 + 0x10]

// === CMOVB r16, r16 ===
    cmovb bx, dx
    cmovb di, dx
    cmovb cx, ax
    cmovb dx, dx
    cmovb dx, si
    cmovb dx, cx
    cmovb ax, cx
    cmovb bx, ax
    cmovb si, dx
    cmovb cx, bx

// === CMOVB r16, m16 ===
    cmovb cx, WORD PTR [rax]
    cmovb ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovb dx, WORD PTR [rbx]
    cmovb di, WORD PTR [rbx]
    cmovb ax, WORD PTR [rip + 0x100]
    cmovb si, WORD PTR [rax]
    cmovb ax, WORD PTR [rip + 0x1000]
    cmovb di, WORD PTR [rax]
    cmovb si, WORD PTR [rax + rbx*1 + 0x10]
    cmovb dx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVB r32, r32 ===
    cmovb edx, ecx
    cmovb edi, esi
    cmovb ebx, ebx
    cmovb edi, ecx
    cmovb ecx, ebx
    cmovb esi, ecx
    cmovb edi, edi
    cmovb ebx, ecx
    cmovb edi, ebx
    cmovb edx, edx

// === CMOVB r32, m32 ===
    cmovb eax, DWORD PTR [rip + 0x1000]
    cmovb edi, DWORD PTR [rip + 0x1000]
    cmovb eax, DWORD PTR [rax]
    cmovb ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovb eax, DWORD PTR [rip + 0x100]
    cmovb edi, DWORD PTR [rax]
    cmovb edi, DWORD PTR [rbx]
    cmovb ecx, DWORD PTR [rip + 0x100]
    cmovb edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovb edx, DWORD PTR [rax]

// === CMOVB r64, r64 ===
    cmovb rbx, r11
    cmovb r13, r11
    cmovb r10, r11
    cmovb r11, r13
    cmovb r8, rdi
    cmovb rbx, rbx
    cmovb r10, rbx
    cmovb r12, rdi
    cmovb r10, rdx
    cmovb r13, r9

// === CMOVB r64, m64 ===
    cmovb rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovb r8, QWORD PTR [rax]
    cmovb rsi, QWORD PTR [rip + 0x1000]
    cmovb r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovb rbx, QWORD PTR [rip + 0x100]
    cmovb r12, QWORD PTR [rip + 0x1000]
    cmovb r8, QWORD PTR [rip + 0x100]
    cmovb r9, QWORD PTR [rip + 0x1000]
    cmovb rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovb r13, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVBE r16, r16 ===
    cmovbe di, si
    cmovbe dx, dx
    cmovbe di, di
    cmovbe dx, si
    cmovbe bx, di
    cmovbe si, ax
    cmovbe di, cx
    cmovbe di, bx
    cmovbe cx, dx
    cmovbe cx, si

// === CMOVBE r16, m16 ===
    cmovbe si, WORD PTR [rax + rbx*1 + 0x10]
    cmovbe ax, WORD PTR [rip + 0x100]
    cmovbe di, WORD PTR [rip + 0x100]
    cmovbe ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovbe di, WORD PTR [rbx]
    cmovbe ax, WORD PTR [rip + 0x1000]
    cmovbe bx, WORD PTR [rip + 0x100]
    cmovbe dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovbe cx, WORD PTR [rax]
    cmovbe cx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVBE r32, r32 ===
    cmovbe edx, edi
    cmovbe ebx, esi
    cmovbe esi, edx
    cmovbe ebx, ebx
    cmovbe eax, ecx
    cmovbe eax, ebx
    cmovbe eax, esi
    cmovbe edx, edx
    cmovbe edx, ecx
    cmovbe edx, ebx

// === CMOVBE r32, m32 ===
    cmovbe ebx, DWORD PTR [rip + 0x100]
    cmovbe esi, DWORD PTR [rax]
    cmovbe ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovbe edi, DWORD PTR [rip + 0x1000]
    cmovbe esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovbe ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovbe edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovbe ecx, DWORD PTR [rbx]
    cmovbe eax, DWORD PTR [rbx]
    cmovbe ecx, DWORD PTR [rip + 0x100]

// === CMOVBE r64, r64 ===
    cmovbe rsi, rsi
    cmovbe rbx, rax
    cmovbe r13, r12
    cmovbe rcx, r13
    cmovbe rdx, r10
    cmovbe r9, r12
    cmovbe rdx, rdi
    cmovbe rbx, r10
    cmovbe r13, r8
    cmovbe r8, rsi

// === CMOVBE r64, m64 ===
    cmovbe r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovbe rsi, QWORD PTR [rax]
    cmovbe rdx, QWORD PTR [rax]
    cmovbe rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovbe rbx, QWORD PTR [rip + 0x100]
    cmovbe r12, QWORD PTR [rbx]
    cmovbe rax, QWORD PTR [rbx]
    cmovbe rdi, QWORD PTR [rip + 0x100]
    cmovbe rdi, QWORD PTR [rbx]
    cmovbe rsi, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVC r16, r16 ===
    cmovc cx, si
    cmovc ax, cx
    cmovc bx, si
    cmovc si, si
    cmovc cx, di
    cmovc bx, di
    cmovc ax, dx
    cmovc cx, cx
    cmovc ax, si
    cmovc si, cx

// === CMOVC r16, m16 ===
    cmovc di, WORD PTR [rip + 0x1000]
    cmovc ax, WORD PTR [rbx]
    cmovc si, WORD PTR [rax + rbx*4 + 0x100]
    cmovc cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovc si, WORD PTR [rax]
    cmovc dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovc cx, WORD PTR [rip + 0x100]
    cmovc bx, WORD PTR [rbx]
    cmovc si, WORD PTR [rbx]
    cmovc ax, WORD PTR [rip + 0x100]

// === CMOVC r32, r32 ===
    cmovc ebx, ecx
    cmovc esi, esi
    cmovc eax, esi
    cmovc edi, eax
    cmovc ebx, esi
    cmovc eax, ecx
    cmovc edx, ebx
    cmovc ecx, ebx
    cmovc edi, esi
    cmovc ebx, eax

// === CMOVC r32, m32 ===
    cmovc edi, DWORD PTR [rip + 0x100]
    cmovc ecx, DWORD PTR [rip + 0x100]
    cmovc edx, DWORD PTR [rip + 0x1000]
    cmovc ebx, DWORD PTR [rax]
    cmovc esi, DWORD PTR [rip + 0x1000]
    cmovc eax, DWORD PTR [rbx]
    cmovc eax, DWORD PTR [rip + 0x100]
    cmovc ecx, DWORD PTR [rbx]
    cmovc edx, DWORD PTR [rbx]
    cmovc ecx, DWORD PTR [rax]

// === CMOVC r64, r64 ===
    cmovc rbx, rsi
    cmovc r13, r8
    cmovc rbx, rdx
    cmovc rdx, rbx
    cmovc rdi, r12
    cmovc rdi, rdi
    cmovc rdx, rax
    cmovc rbx, rdi
    cmovc rsi, rsi
    cmovc rax, r9

// === CMOVC r64, m64 ===
    cmovc r9, QWORD PTR [rip + 0x100]
    cmovc rbx, QWORD PTR [rip + 0x1000]
    cmovc r13, QWORD PTR [rax]
    cmovc rax, QWORD PTR [rip + 0x100]
    cmovc r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovc rdi, QWORD PTR [rip + 0x100]
    cmovc r10, QWORD PTR [rax + rbx*1 + 0x10]
    cmovc r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovc rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovc r8, QWORD PTR [rip + 0x1000]

// === CMOVE r16, r16 ===
    cmove di, dx
    cmove bx, di
    cmove cx, cx
    cmove cx, ax
    cmove si, di
    cmove bx, si
    cmove si, ax
    cmove bx, dx
    cmove si, si
    cmove bx, ax

// === CMOVE r16, m16 ===
    cmove dx, WORD PTR [rax + rbx*1 + 0x10]
    cmove di, WORD PTR [rax]
    cmove si, WORD PTR [rip + 0x1000]
    cmove ax, WORD PTR [rax]
    cmove dx, WORD PTR [rax]
    cmove di, WORD PTR [rip + 0x1000]
    cmove dx, WORD PTR [rip + 0x1000]
    cmove si, WORD PTR [rax]
    cmove bx, WORD PTR [rbx]
    cmove di, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVE r32, r32 ===
    cmove ebx, edi
    cmove eax, edx
    cmove esi, ebx
    cmove edx, esi
    cmove ebx, ebx
    cmove edi, eax
    cmove edi, edx
    cmove ecx, edi
    cmove edx, ebx
    cmove esi, esi

// === CMOVE r32, m32 ===
    cmove edx, DWORD PTR [rbx]
    cmove eax, DWORD PTR [rip + 0x100]
    cmove ebx, DWORD PTR [rip + 0x1000]
    cmove ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmove esi, DWORD PTR [rip + 0x1000]
    cmove eax, DWORD PTR [rip + 0x1000]
    cmove eax, DWORD PTR [rax]
    cmove ecx, DWORD PTR [rip + 0x100]
    cmove ebx, DWORD PTR [rbx]
    cmove edi, DWORD PTR [rip + 0x1000]

// === CMOVE r64, r64 ===
    cmove r12, r12
    cmove rdi, r9
    cmove rcx, rcx
    cmove r10, r12
    cmove r9, rax
    cmove r13, rdx
    cmove rax, rax
    cmove r9, rsi
    cmove r10, rdi
    cmove r11, r9

// === CMOVE r64, m64 ===
    cmove r13, QWORD PTR [rbx]
    cmove rsi, QWORD PTR [rbx]
    cmove r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmove rbx, QWORD PTR [rbx]
    cmove r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmove rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmove rdi, QWORD PTR [rbx]
    cmove r13, QWORD PTR [rax]
    cmove rdi, QWORD PTR [rip + 0x1000]
    cmove r10, QWORD PTR [rip + 0x1000]

// === CMOVG r16, r16 ===
    cmovg ax, di
    cmovg bx, di
    cmovg si, dx
    cmovg ax, dx
    cmovg ax, cx
    cmovg si, ax
    cmovg bx, bx
    cmovg cx, ax
    cmovg dx, cx
    cmovg cx, dx

// === CMOVG r16, m16 ===
    cmovg cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovg dx, WORD PTR [rip + 0x1000]
    cmovg si, WORD PTR [rax + rbx*1 + 0x10]
    cmovg ax, WORD PTR [rip + 0x1000]
    cmovg si, WORD PTR [rax]
    cmovg cx, WORD PTR [rax]
    cmovg di, WORD PTR [rip + 0x100]
    cmovg dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovg di, WORD PTR [rax + rbx*1 + 0x10]
    cmovg bx, WORD PTR [rax]

// === CMOVG r32, r32 ===
    cmovg eax, edx
    cmovg ecx, edi
    cmovg ecx, edx
    cmovg ebx, ebx
    cmovg esi, esi
    cmovg edx, esi
    cmovg edx, edi
    cmovg edx, ecx
    cmovg ebx, eax
    cmovg ebx, edx

// === CMOVG r32, m32 ===
    cmovg edi, DWORD PTR [rax]
    cmovg edx, DWORD PTR [rip + 0x1000]
    cmovg ebx, DWORD PTR [rbx]
    cmovg esi, DWORD PTR [rax]
    cmovg eax, DWORD PTR [rax]
    cmovg edi, DWORD PTR [rbx]
    cmovg esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovg eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovg edx, DWORD PTR [rip + 0x100]
    cmovg ecx, DWORD PTR [rip + 0x1000]

// === CMOVG r64, r64 ===
    cmovg r9, rbx
    cmovg r11, r11
    cmovg rax, rdx
    cmovg r10, rax
    cmovg rdx, rdi
    cmovg rbx, r13
    cmovg r13, rsi
    cmovg r10, r11
    cmovg rdi, r13
    cmovg rdx, r10

// === CMOVG r64, m64 ===
    cmovg rcx, QWORD PTR [rip + 0x1000]
    cmovg r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmovg rsi, QWORD PTR [rax]
    cmovg r11, QWORD PTR [rip + 0x1000]
    cmovg rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovg r9, QWORD PTR [rip + 0x100]
    cmovg r13, QWORD PTR [rax]
    cmovg rdi, QWORD PTR [rbx]
    cmovg rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovg rcx, QWORD PTR [rip + 0x100]

// === CMOVGE r16, r16 ===
    cmovge bx, si
    cmovge cx, ax
    cmovge di, dx
    cmovge dx, bx
    cmovge di, ax
    cmovge si, cx
    cmovge di, bx
    cmovge bx, di
    cmovge dx, ax
    cmovge si, si

// === CMOVGE r16, m16 ===
    cmovge dx, WORD PTR [rip + 0x1000]
    cmovge si, WORD PTR [rip + 0x1000]
    cmovge dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovge di, WORD PTR [rbx]
    cmovge si, WORD PTR [rbx]
    cmovge cx, WORD PTR [rip + 0x1000]
    cmovge di, WORD PTR [rip + 0x100]
    cmovge bx, WORD PTR [rip + 0x100]
    cmovge bx, WORD PTR [rip + 0x1000]
    cmovge si, WORD PTR [rax]

// === CMOVGE r32, r32 ===
    cmovge eax, esi
    cmovge ebx, ebx
    cmovge ebx, ecx
    cmovge ebx, eax
    cmovge edx, esi
    cmovge esi, ecx
    cmovge edi, ecx
    cmovge edi, edx
    cmovge edx, edx
    cmovge esi, eax

// === CMOVGE r32, m32 ===
    cmovge esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovge ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovge esi, DWORD PTR [rbx]
    cmovge edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovge edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovge esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovge ecx, DWORD PTR [rbx]
    cmovge eax, DWORD PTR [rbx]
    cmovge ecx, DWORD PTR [rip + 0x1000]
    cmovge ebx, DWORD PTR [rax]

// === CMOVGE r64, r64 ===
    cmovge r9, rdi
    cmovge rdi, r12
    cmovge r13, rdi
    cmovge r11, r12
    cmovge rcx, r10
    cmovge r13, r11
    cmovge r9, rsi
    cmovge r10, r13
    cmovge rbx, r12
    cmovge rbx, r13

// === CMOVGE r64, m64 ===
    cmovge r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovge r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovge r12, QWORD PTR [rbx]
    cmovge r8, QWORD PTR [rax + rbx*4 + 0x100]
    cmovge rdi, QWORD PTR [rax]
    cmovge r13, QWORD PTR [rip + 0x1000]
    cmovge rbx, QWORD PTR [rip + 0x100]
    cmovge r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovge r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovge rdi, QWORD PTR [rbx]

// === CMOVL r16, r16 ===
    cmovl cx, si
    cmovl dx, cx
    cmovl cx, ax
    cmovl cx, di
    cmovl ax, si
    cmovl dx, dx
    cmovl si, si
    cmovl dx, bx
    cmovl di, ax
    cmovl bx, cx

// === CMOVL r16, m16 ===
    cmovl di, WORD PTR [rip + 0x100]
    cmovl bx, WORD PTR [rax]
    cmovl ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovl ax, WORD PTR [rip + 0x1000]
    cmovl cx, WORD PTR [rip + 0x100]
    cmovl dx, WORD PTR [rip + 0x1000]
    cmovl di, WORD PTR [rbx]
    cmovl bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovl bx, WORD PTR [rbx]
    cmovl si, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVL r32, r32 ===
    cmovl esi, edi
    cmovl ebx, ecx
    cmovl edi, esi
    cmovl ebx, edx
    cmovl edx, edx
    cmovl esi, eax
    cmovl esi, ecx
    cmovl edx, edi
    cmovl edi, eax
    cmovl eax, edi

// === CMOVL r32, m32 ===
    cmovl esi, DWORD PTR [rax]
    cmovl ecx, DWORD PTR [rax]
    cmovl ebx, DWORD PTR [rbx]
    cmovl ecx, DWORD PTR [rip + 0x100]
    cmovl eax, DWORD PTR [rax]
    cmovl ecx, DWORD PTR [rbx]
    cmovl edx, DWORD PTR [rip + 0x1000]
    cmovl ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovl esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovl edx, DWORD PTR [rax]

// === CMOVL r64, r64 ===
    cmovl rdi, rdi
    cmovl rsi, rsi
    cmovl r8, rax
    cmovl rdi, rdx
    cmovl r11, rcx
    cmovl r11, r8
    cmovl r9, rsi
    cmovl r13, r8
    cmovl r12, r13
    cmovl rcx, r9

// === CMOVL r64, m64 ===
    cmovl rcx, QWORD PTR [rax]
    cmovl r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovl r13, QWORD PTR [rbx]
    cmovl r8, QWORD PTR [rip + 0x1000]
    cmovl rsi, QWORD PTR [rip + 0x100]
    cmovl r11, QWORD PTR [rax]
    cmovl rbx, QWORD PTR [rip + 0x100]
    cmovl r13, QWORD PTR [rip + 0x100]
    cmovl rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovl r9, QWORD PTR [rip + 0x1000]

// === CMOVLE r16, r16 ===
    cmovle di, di
    cmovle bx, si
    cmovle cx, di
    cmovle ax, bx
    cmovle ax, cx
    cmovle bx, ax
    cmovle di, dx
    cmovle dx, cx
    cmovle cx, si
    cmovle bx, dx

// === CMOVLE r16, m16 ===
    cmovle bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovle cx, WORD PTR [rbx]
    cmovle si, WORD PTR [rax + rbx*1 + 0x10]
    cmovle dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovle di, WORD PTR [rip + 0x100]
    cmovle cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovle di, WORD PTR [rax + rbx*4 + 0x100]
    cmovle ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovle si, WORD PTR [rip + 0x100]
    cmovle cx, WORD PTR [rax]

// === CMOVLE r32, r32 ===
    cmovle edi, esi
    cmovle eax, esi
    cmovle esi, eax
    cmovle edx, edx
    cmovle ecx, ecx
    cmovle eax, ebx
    cmovle esi, edi
    cmovle edi, ecx
    cmovle ecx, eax
    cmovle ecx, esi

// === CMOVLE r32, m32 ===
    cmovle ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovle ebx, DWORD PTR [rip + 0x1000]
    cmovle eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovle ecx, DWORD PTR [rip + 0x100]
    cmovle esi, DWORD PTR [rbx]
    cmovle esi, DWORD PTR [rip + 0x1000]
    cmovle ebx, DWORD PTR [rip + 0x100]
    cmovle edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovle edi, DWORD PTR [rip + 0x100]
    cmovle edx, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVLE r64, r64 ===
    cmovle r9, r9
    cmovle r8, rdi
    cmovle r11, rax
    cmovle r9, rax
    cmovle rdi, rdi
    cmovle rsi, r13
    cmovle r11, rsi
    cmovle r12, r13
    cmovle rdx, r12
    cmovle rsi, rdx

// === CMOVLE r64, m64 ===
    cmovle r8, QWORD PTR [rip + 0x100]
    cmovle r9, QWORD PTR [rip + 0x1000]
    cmovle r9, QWORD PTR [rax]
    cmovle rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovle r11, QWORD PTR [rbx]
    cmovle rcx, QWORD PTR [rip + 0x1000]
    cmovle rax, QWORD PTR [rip + 0x100]
    cmovle rsi, QWORD PTR [rip + 0x100]
    cmovle rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmovle r8, QWORD PTR [rip + 0x1000]

// === CMOVNA r16, r16 ===
    cmovna bx, cx
    cmovna ax, cx
    cmovna si, dx
    cmovna dx, ax
    cmovna ax, di
    cmovna ax, ax
    cmovna di, cx
    cmovna dx, dx
    cmovna si, cx
    cmovna bx, di

// === CMOVNA r16, m16 ===
    cmovna ax, WORD PTR [rip + 0x1000]
    cmovna cx, WORD PTR [rip + 0x1000]
    cmovna si, WORD PTR [rax + rbx*4 + 0x100]
    cmovna bx, WORD PTR [rbx]
    cmovna cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovna dx, WORD PTR [rip + 0x100]
    cmovna cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovna cx, WORD PTR [rax]
    cmovna bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovna di, WORD PTR [rip + 0x1000]

// === CMOVNA r32, r32 ===
    cmovna edx, ecx
    cmovna eax, edx
    cmovna esi, ecx
    cmovna edi, ecx
    cmovna edx, ebx
    cmovna esi, edi
    cmovna ecx, ebx
    cmovna ebx, ebx
    cmovna ecx, ecx
    cmovna esi, eax

// === CMOVNA r32, m32 ===
    cmovna edi, DWORD PTR [rip + 0x1000]
    cmovna esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovna edx, DWORD PTR [rip + 0x1000]
    cmovna edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovna esi, DWORD PTR [rax]
    cmovna edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovna edx, DWORD PTR [rax]
    cmovna ebx, DWORD PTR [rip + 0x100]
    cmovna ecx, DWORD PTR [rip + 0x1000]
    cmovna edi, DWORD PTR [rax]

// === CMOVNA r64, r64 ===
    cmovna rdx, r8
    cmovna rcx, rdx
    cmovna rdx, r13
    cmovna r13, r12
    cmovna r12, rsi
    cmovna r9, rax
    cmovna rsi, rax
    cmovna r9, rbx
    cmovna rsi, r8
    cmovna r11, r9

// === CMOVNA r64, m64 ===
    cmovna r12, QWORD PTR [rip + 0x1000]
    cmovna rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovna r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovna r12, QWORD PTR [rip + 0x100]
    cmovna r9, QWORD PTR [rip + 0x1000]
    cmovna r13, QWORD PTR [rbx]
    cmovna rsi, QWORD PTR [rax]
    cmovna r10, QWORD PTR [rax + rbx*1 + 0x10]
    cmovna r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovna r11, QWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNAE r16, r16 ===
    cmovnae ax, si
    cmovnae di, bx
    cmovnae dx, cx
    cmovnae cx, di
    cmovnae dx, ax
    cmovnae ax, dx
    cmovnae ax, bx
    cmovnae si, dx
    cmovnae ax, ax
    cmovnae cx, si

// === CMOVNAE r16, m16 ===
    cmovnae di, WORD PTR [rax]
    cmovnae ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnae dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnae si, WORD PTR [rip + 0x1000]
    cmovnae cx, WORD PTR [rip + 0x100]
    cmovnae si, WORD PTR [rax + rbx*4 + 0x100]
    cmovnae di, WORD PTR [rip + 0x100]
    cmovnae bx, WORD PTR [rip + 0x100]
    cmovnae cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnae dx, WORD PTR [rip + 0x1000]

// === CMOVNAE r32, r32 ===
    cmovnae ebx, eax
    cmovnae edi, ecx
    cmovnae esi, ebx
    cmovnae edi, esi
    cmovnae esi, edx
    cmovnae edx, edx
    cmovnae edi, ebx
    cmovnae ecx, ebx
    cmovnae ebx, ecx
    cmovnae eax, edx

// === CMOVNAE r32, m32 ===
    cmovnae eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnae ebx, DWORD PTR [rbx]
    cmovnae esi, DWORD PTR [rip + 0x100]
    cmovnae ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnae eax, DWORD PTR [rbx]
    cmovnae esi, DWORD PTR [rax]
    cmovnae eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnae ebx, DWORD PTR [rax]
    cmovnae esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnae ecx, DWORD PTR [rbx]

// === CMOVNAE r64, r64 ===
    cmovnae r9, r12
    cmovnae rsi, r11
    cmovnae rdx, r8
    cmovnae r8, r12
    cmovnae rdx, rdi
    cmovnae r9, r13
    cmovnae r13, r11
    cmovnae r8, r9
    cmovnae rbx, r13
    cmovnae rsi, r10

// === CMOVNAE r64, m64 ===
    cmovnae rax, QWORD PTR [rbx]
    cmovnae r13, QWORD PTR [rip + 0x1000]
    cmovnae rax, QWORD PTR [rip + 0x1000]
    cmovnae rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnae r12, QWORD PTR [rip + 0x1000]
    cmovnae rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnae r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnae rdi, QWORD PTR [rip + 0x100]
    cmovnae rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnae rax, QWORD PTR [rip + 0x100]

// === CMOVNB r16, r16 ===
    cmovnb bx, cx
    cmovnb bx, di
    cmovnb dx, bx
    cmovnb di, dx
    cmovnb si, cx
    cmovnb di, ax
    cmovnb bx, si
    cmovnb si, dx
    cmovnb dx, si
    cmovnb ax, ax

// === CMOVNB r16, m16 ===
    cmovnb bx, WORD PTR [rip + 0x1000]
    cmovnb bx, WORD PTR [rbx]
    cmovnb bx, WORD PTR [rax]
    cmovnb cx, WORD PTR [rip + 0x1000]
    cmovnb di, WORD PTR [rbx]
    cmovnb cx, WORD PTR [rbx]
    cmovnb dx, WORD PTR [rax]
    cmovnb ax, WORD PTR [rip + 0x100]
    cmovnb dx, WORD PTR [rip + 0x1000]
    cmovnb si, WORD PTR [rip + 0x100]

// === CMOVNB r32, r32 ===
    cmovnb ebx, ecx
    cmovnb esi, ecx
    cmovnb edx, ecx
    cmovnb edi, edi
    cmovnb ecx, edx
    cmovnb ecx, edi
    cmovnb ebx, ebx
    cmovnb ecx, ecx
    cmovnb ecx, eax
    cmovnb eax, esi

// === CMOVNB r32, m32 ===
    cmovnb eax, DWORD PTR [rip + 0x1000]
    cmovnb esi, DWORD PTR [rip + 0x1000]
    cmovnb edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnb eax, DWORD PTR [rbx]
    cmovnb edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnb ebx, DWORD PTR [rip + 0x100]
    cmovnb ecx, DWORD PTR [rbx]
    cmovnb edi, DWORD PTR [rip + 0x100]
    cmovnb esi, DWORD PTR [rbx]
    cmovnb edx, DWORD PTR [rip + 0x1000]

// === CMOVNB r64, r64 ===
    cmovnb r8, r10
    cmovnb rsi, rbx
    cmovnb r10, rsi
    cmovnb r9, rbx
    cmovnb rsi, r8
    cmovnb r12, rcx
    cmovnb rcx, rax
    cmovnb rbx, rsi
    cmovnb r12, r10
    cmovnb rdx, rdx

// === CMOVNB r64, m64 ===
    cmovnb rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnb rsi, QWORD PTR [rax]
    cmovnb rbx, QWORD PTR [rax]
    cmovnb rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnb rcx, QWORD PTR [rip + 0x100]
    cmovnb rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnb rax, QWORD PTR [rbx]
    cmovnb rax, QWORD PTR [rip + 0x100]
    cmovnb r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnb rsi, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNBE r16, r16 ===
    cmovnbe dx, ax
    cmovnbe di, si
    cmovnbe ax, dx
    cmovnbe di, di
    cmovnbe dx, dx
    cmovnbe ax, si
    cmovnbe bx, dx
    cmovnbe dx, bx
    cmovnbe cx, ax
    cmovnbe di, dx

// === CMOVNBE r16, m16 ===
    cmovnbe di, WORD PTR [rax]
    cmovnbe di, WORD PTR [rax + rbx*4 + 0x100]
    cmovnbe bx, WORD PTR [rax]
    cmovnbe dx, WORD PTR [rbx]
    cmovnbe ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovnbe si, WORD PTR [rip + 0x100]
    cmovnbe si, WORD PTR [rax + rbx*4 + 0x100]
    cmovnbe si, WORD PTR [rax]
    cmovnbe di, WORD PTR [rax + rbx*1 + 0x10]
    cmovnbe ax, WORD PTR [rip + 0x100]

// === CMOVNBE r32, r32 ===
    cmovnbe edx, esi
    cmovnbe ebx, eax
    cmovnbe ebx, edi
    cmovnbe ebx, edx
    cmovnbe ecx, edi
    cmovnbe ecx, edx
    cmovnbe ecx, esi
    cmovnbe edx, edx
    cmovnbe ecx, eax
    cmovnbe esi, esi

// === CMOVNBE r32, m32 ===
    cmovnbe eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnbe eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnbe edi, DWORD PTR [rip + 0x1000]
    cmovnbe ebx, DWORD PTR [rip + 0x100]
    cmovnbe edi, DWORD PTR [rax]
    cmovnbe edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnbe esi, DWORD PTR [rax]
    cmovnbe esi, DWORD PTR [rip + 0x1000]
    cmovnbe edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnbe ebx, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNBE r64, r64 ===
    cmovnbe rcx, rdi
    cmovnbe r12, rbx
    cmovnbe r13, r11
    cmovnbe r9, r12
    cmovnbe rax, rbx
    cmovnbe r10, rbx
    cmovnbe r13, rdi
    cmovnbe r10, r11
    cmovnbe rbx, rdx
    cmovnbe r8, r10

// === CMOVNBE r64, m64 ===
    cmovnbe rcx, QWORD PTR [rip + 0x100]
    cmovnbe r8, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnbe rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnbe rsi, QWORD PTR [rbx]
    cmovnbe rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnbe rdx, QWORD PTR [rax]
    cmovnbe r11, QWORD PTR [rbx]
    cmovnbe r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnbe r13, QWORD PTR [rbx]
    cmovnbe rdi, QWORD PTR [rbx]

// === CMOVNC r16, r16 ===
    cmovnc dx, ax
    cmovnc bx, bx
    cmovnc ax, dx
    cmovnc si, di
    cmovnc ax, si
    cmovnc di, si
    cmovnc dx, cx
    cmovnc cx, si
    cmovnc ax, bx
    cmovnc si, bx

// === CMOVNC r16, m16 ===
    cmovnc bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnc si, WORD PTR [rbx]
    cmovnc si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnc bx, WORD PTR [rip + 0x1000]
    cmovnc si, WORD PTR [rip + 0x1000]
    cmovnc ax, WORD PTR [rax]
    cmovnc dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnc dx, WORD PTR [rbx]
    cmovnc cx, WORD PTR [rax]
    cmovnc cx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVNC r32, r32 ===
    cmovnc edx, esi
    cmovnc ebx, edi
    cmovnc edi, ecx
    cmovnc eax, eax
    cmovnc eax, ecx
    cmovnc ebx, esi
    cmovnc ebx, ebx
    cmovnc eax, esi
    cmovnc ecx, ecx
    cmovnc esi, edi

// === CMOVNC r32, m32 ===
    cmovnc esi, DWORD PTR [rip + 0x1000]
    cmovnc edx, DWORD PTR [rip + 0x100]
    cmovnc esi, DWORD PTR [rax]
    cmovnc ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnc esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnc eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnc edx, DWORD PTR [rax]
    cmovnc edx, DWORD PTR [rip + 0x1000]
    cmovnc eax, DWORD PTR [rbx]
    cmovnc eax, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNC r64, r64 ===
    cmovnc r8, r10
    cmovnc r9, rax
    cmovnc r11, rsi
    cmovnc rbx, rcx
    cmovnc rsi, r13
    cmovnc r8, rax
    cmovnc rdi, rbx
    cmovnc r8, rsi
    cmovnc r10, rdx
    cmovnc r12, r12

// === CMOVNC r64, m64 ===
    cmovnc r10, QWORD PTR [rip + 0x100]
    cmovnc rdi, QWORD PTR [rbx]
    cmovnc rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnc r8, QWORD PTR [rip + 0x100]
    cmovnc rsi, QWORD PTR [rax]
    cmovnc r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnc r8, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnc r9, QWORD PTR [rip + 0x1000]
    cmovnc r8, QWORD PTR [rax]
    cmovnc rax, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNE r16, r16 ===
    cmovne cx, bx
    cmovne cx, cx
    cmovne di, di
    cmovne si, di
    cmovne dx, di
    cmovne bx, ax
    cmovne di, dx
    cmovne bx, bx
    cmovne bx, cx
    cmovne si, dx

// === CMOVNE r16, m16 ===
    cmovne di, WORD PTR [rip + 0x1000]
    cmovne di, WORD PTR [rax + rbx*4 + 0x100]
    cmovne cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovne cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovne ax, WORD PTR [rax]
    cmovne cx, WORD PTR [rip + 0x100]
    cmovne ax, WORD PTR [rip + 0x100]
    cmovne cx, WORD PTR [rip + 0x1000]
    cmovne dx, WORD PTR [rip + 0x1000]
    cmovne bx, WORD PTR [rax]

// === CMOVNE r32, r32 ===
    cmovne esi, eax
    cmovne ecx, edx
    cmovne eax, ecx
    cmovne ecx, ebx
    cmovne edx, eax
    cmovne edx, esi
    cmovne esi, ecx
    cmovne esi, edi
    cmovne eax, eax
    cmovne eax, edx

// === CMOVNE r32, m32 ===
    cmovne esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovne edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovne ecx, DWORD PTR [rip + 0x1000]
    cmovne edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovne edx, DWORD PTR [rbx]
    cmovne esi, DWORD PTR [rip + 0x100]
    cmovne ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovne edi, DWORD PTR [rip + 0x100]
    cmovne ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovne esi, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNE r64, r64 ===
    cmovne rsi, r12
    cmovne rax, rdx
    cmovne r11, rax
    cmovne r11, r10
    cmovne r8, r10
    cmovne rdi, r13
    cmovne r8, rax
    cmovne r8, r8
    cmovne r13, r11
    cmovne rcx, r12

// === CMOVNE r64, m64 ===
    cmovne r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovne rbx, QWORD PTR [rbx]
    cmovne r10, QWORD PTR [rbx]
    cmovne r8, QWORD PTR [rip + 0x100]
    cmovne r9, QWORD PTR [rax]
    cmovne r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovne r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovne r9, QWORD PTR [rip + 0x100]
    cmovne rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovne rax, QWORD PTR [rip + 0x1000]

// === CMOVNG r16, r16 ===
    cmovng bx, si
    cmovng si, dx
    cmovng bx, dx
    cmovng dx, si
    cmovng bx, di
    cmovng dx, ax
    cmovng di, ax
    cmovng ax, dx
    cmovng bx, cx
    cmovng ax, bx

// === CMOVNG r16, m16 ===
    cmovng si, WORD PTR [rip + 0x100]
    cmovng dx, WORD PTR [rbx]
    cmovng bx, WORD PTR [rip + 0x1000]
    cmovng ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovng si, WORD PTR [rip + 0x1000]
    cmovng bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovng bx, WORD PTR [rbx]
    cmovng di, WORD PTR [rbx]
    cmovng ax, WORD PTR [rbx]
    cmovng bx, WORD PTR [rip + 0x100]

// === CMOVNG r32, r32 ===
    cmovng esi, ebx
    cmovng ecx, ecx
    cmovng edx, eax
    cmovng edx, edi
    cmovng eax, edx
    cmovng esi, ecx
    cmovng edi, ebx
    cmovng edi, eax
    cmovng edx, esi
    cmovng ecx, edi

// === CMOVNG r32, m32 ===
    cmovng ebx, DWORD PTR [rbx]
    cmovng ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng ecx, DWORD PTR [rbx]
    cmovng esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovng eax, DWORD PTR [rbx]
    cmovng ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng edi, DWORD PTR [rax]
    cmovng eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng ecx, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNG r64, r64 ===
    cmovng r10, r10
    cmovng rdi, rsi
    cmovng r10, r9
    cmovng rdi, rdx
    cmovng rbx, rbx
    cmovng r11, r12
    cmovng r10, rax
    cmovng rsi, rcx
    cmovng rdi, rdi
    cmovng r9, r8

// === CMOVNG r64, m64 ===
    cmovng rsi, QWORD PTR [rbx]
    cmovng rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovng rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmovng r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovng r10, QWORD PTR [rip + 0x100]
    cmovng r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovng rax, QWORD PTR [rip + 0x1000]
    cmovng rcx, QWORD PTR [rax]
    cmovng rdx, QWORD PTR [rip + 0x1000]
    cmovng r11, QWORD PTR [rbx]

// === CMOVNGE r16, r16 ===
    cmovnge bx, ax
    cmovnge dx, ax
    cmovnge ax, si
    cmovnge di, cx
    cmovnge si, dx
    cmovnge dx, bx
    cmovnge si, si
    cmovnge di, bx
    cmovnge bx, di
    cmovnge ax, cx

// === CMOVNGE r16, m16 ===
    cmovnge bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnge si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnge dx, WORD PTR [rbx]
    cmovnge si, WORD PTR [rax]
    cmovnge dx, WORD PTR [rip + 0x1000]
    cmovnge si, WORD PTR [rax + rbx*4 + 0x100]
    cmovnge cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnge ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnge ax, WORD PTR [rbx]
    cmovnge bx, WORD PTR [rbx]

// === CMOVNGE r32, r32 ===
    cmovnge esi, esi
    cmovnge esi, eax
    cmovnge edx, eax
    cmovnge eax, ecx
    cmovnge eax, edi
    cmovnge eax, ebx
    cmovnge esi, edx
    cmovnge ecx, ecx
    cmovnge edi, eax
    cmovnge ebx, eax

// === CMOVNGE r32, m32 ===
    cmovnge ebx, DWORD PTR [rip + 0x1000]
    cmovnge edi, DWORD PTR [rip + 0x1000]
    cmovnge eax, DWORD PTR [rax]
    cmovnge edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnge ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnge eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnge ecx, DWORD PTR [rip + 0x100]
    cmovnge edx, DWORD PTR [rip + 0x100]
    cmovnge edi, DWORD PTR [rax]
    cmovnge eax, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNGE r64, r64 ===
    cmovnge r8, r8
    cmovnge rcx, r9
    cmovnge rdi, r12
    cmovnge r13, rax
    cmovnge rbx, rdi
    cmovnge rcx, r8
    cmovnge r12, r12
    cmovnge r11, r9
    cmovnge rsi, rsi
    cmovnge rcx, rax

// === CMOVNGE r64, m64 ===
    cmovnge rdx, QWORD PTR [rip + 0x1000]
    cmovnge r8, QWORD PTR [rax]
    cmovnge r9, QWORD PTR [rip + 0x100]
    cmovnge rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnge r13, QWORD PTR [rip + 0x100]
    cmovnge rdx, QWORD PTR [rbx]
    cmovnge rax, QWORD PTR [rip + 0x100]
    cmovnge rdi, QWORD PTR [rip + 0x100]
    cmovnge r9, QWORD PTR [rbx]
    cmovnge r10, QWORD PTR [rbx]

// === CMOVNL r16, r16 ===
    cmovnl dx, si
    cmovnl di, di
    cmovnl ax, dx
    cmovnl ax, ax
    cmovnl cx, cx
    cmovnl bx, bx
    cmovnl bx, dx
    cmovnl dx, ax
    cmovnl cx, di
    cmovnl di, si

// === CMOVNL r16, m16 ===
    cmovnl cx, WORD PTR [rip + 0x100]
    cmovnl di, WORD PTR [rax]
    cmovnl si, WORD PTR [rip + 0x1000]
    cmovnl dx, WORD PTR [rax]
    cmovnl ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovnl ax, WORD PTR [rip + 0x1000]
    cmovnl ax, WORD PTR [rip + 0x100]
    cmovnl dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnl si, WORD PTR [rax + rbx*4 + 0x100]
    cmovnl di, WORD PTR [rbx]

// === CMOVNL r32, r32 ===
    cmovnl eax, esi
    cmovnl ebx, ecx
    cmovnl ebx, eax
    cmovnl ebx, esi
    cmovnl edi, edi
    cmovnl ecx, ebx
    cmovnl ebx, ebx
    cmovnl edi, ebx
    cmovnl esi, edx
    cmovnl eax, ecx

// === CMOVNL r32, m32 ===
    cmovnl esi, DWORD PTR [rip + 0x1000]
    cmovnl ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnl esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl esi, DWORD PTR [rbx]
    cmovnl esi, DWORD PTR [rax]
    cmovnl ecx, DWORD PTR [rip + 0x100]
    cmovnl edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl ecx, DWORD PTR [rax]
    cmovnl eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnl ebx, DWORD PTR [rip + 0x100]

// === CMOVNL r64, r64 ===
    cmovnl r12, r9
    cmovnl rbx, rsi
    cmovnl r11, rcx
    cmovnl rax, r9
    cmovnl rdi, r9
    cmovnl rsi, r13
    cmovnl rcx, rsi
    cmovnl r10, r9
    cmovnl rdx, r11
    cmovnl r8, rcx

// === CMOVNL r64, m64 ===
    cmovnl r8, QWORD PTR [rbx]
    cmovnl rdi, QWORD PTR [rip + 0x100]
    cmovnl rbx, QWORD PTR [rip + 0x100]
    cmovnl r10, QWORD PTR [rbx]
    cmovnl r13, QWORD PTR [rax]
    cmovnl rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnl r12, QWORD PTR [rip + 0x100]
    cmovnl r9, QWORD PTR [rip + 0x1000]
    cmovnl r9, QWORD PTR [rbx]
    cmovnl r12, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNLE r16, r16 ===
    cmovnle di, dx
    cmovnle dx, bx
    cmovnle cx, cx
    cmovnle bx, di
    cmovnle cx, bx
    cmovnle di, cx
    cmovnle cx, si
    cmovnle dx, si
    cmovnle si, dx
    cmovnle cx, dx

// === CMOVNLE r16, m16 ===
    cmovnle ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovnle dx, WORD PTR [rip + 0x1000]
    cmovnle cx, WORD PTR [rbx]
    cmovnle si, WORD PTR [rip + 0x1000]
    cmovnle di, WORD PTR [rax]
    cmovnle bx, WORD PTR [rip + 0x100]
    cmovnle si, WORD PTR [rax]
    cmovnle bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnle ax, WORD PTR [rip + 0x1000]
    cmovnle cx, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVNLE r32, r32 ===
    cmovnle esi, edx
    cmovnle eax, edi
    cmovnle eax, esi
    cmovnle ecx, eax
    cmovnle esi, eax
    cmovnle edx, edi
    cmovnle ecx, edx
    cmovnle ebx, edx
    cmovnle edx, ebx
    cmovnle ecx, ebx

// === CMOVNLE r32, m32 ===
    cmovnle edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnle edi, DWORD PTR [rip + 0x1000]
    cmovnle ebx, DWORD PTR [rbx]
    cmovnle ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnle esi, DWORD PTR [rbx]
    cmovnle eax, DWORD PTR [rbx]
    cmovnle edx, DWORD PTR [rip + 0x100]
    cmovnle ebx, DWORD PTR [rax]
    cmovnle esi, DWORD PTR [rax]
    cmovnle edi, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNLE r64, r64 ===
    cmovnle r12, rax
    cmovnle rbx, r12
    cmovnle rdi, rcx
    cmovnle r9, rdx
    cmovnle rbx, r13
    cmovnle rbx, r9
    cmovnle rcx, rcx
    cmovnle r8, rsi
    cmovnle rbx, rsi
    cmovnle r9, rdi

// === CMOVNLE r64, m64 ===
    cmovnle r8, QWORD PTR [rip + 0x100]
    cmovnle rax, QWORD PTR [rax]
    cmovnle r12, QWORD PTR [rax]
    cmovnle r10, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnle rcx, QWORD PTR [rip + 0x100]
    cmovnle rdx, QWORD PTR [rbx]
    cmovnle rdi, QWORD PTR [rip + 0x100]
    cmovnle r10, QWORD PTR [rip + 0x1000]
    cmovnle rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnle rsi, QWORD PTR [rbx]

// === CMOVNO r16, r16 ===
    cmovno bx, si
    cmovno si, di
    cmovno bx, di
    cmovno cx, si
    cmovno dx, di
    cmovno dx, dx
    cmovno ax, cx
    cmovno ax, bx
    cmovno bx, dx
    cmovno cx, dx

// === CMOVNO r16, m16 ===
    cmovno di, WORD PTR [rbx]
    cmovno dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovno ax, WORD PTR [rax]
    cmovno bx, WORD PTR [rip + 0x100]
    cmovno si, WORD PTR [rax]
    cmovno di, WORD PTR [rip + 0x1000]
    cmovno ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovno cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovno dx, WORD PTR [rax]
    cmovno di, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVNO r32, r32 ===
    cmovno ecx, ebx
    cmovno edx, esi
    cmovno edx, ebx
    cmovno edi, edi
    cmovno ecx, ecx
    cmovno ecx, edi
    cmovno eax, edi
    cmovno edi, ebx
    cmovno eax, edx
    cmovno esi, edx

// === CMOVNO r32, m32 ===
    cmovno esi, DWORD PTR [rbx]
    cmovno edi, DWORD PTR [rip + 0x1000]
    cmovno edi, DWORD PTR [rax]
    cmovno edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovno edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovno ecx, DWORD PTR [rip + 0x100]
    cmovno ebx, DWORD PTR [rip + 0x100]
    cmovno ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovno ebx, DWORD PTR [rip + 0x1000]
    cmovno esi, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNO r64, r64 ===
    cmovno r11, rax
    cmovno rsi, rdi
    cmovno rdx, r13
    cmovno r12, r11
    cmovno rcx, r13
    cmovno rdi, rcx
    cmovno r10, r9
    cmovno r10, r13
    cmovno rdx, rdi
    cmovno r9, rdx

// === CMOVNO r64, m64 ===
    cmovno rdx, QWORD PTR [rip + 0x100]
    cmovno rbx, QWORD PTR [rbx]
    cmovno rdx, QWORD PTR [rax]
    cmovno r9, QWORD PTR [rbx]
    cmovno rsi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovno rdx, QWORD PTR [rip + 0x1000]
    cmovno r12, QWORD PTR [rbx]
    cmovno rax, QWORD PTR [rbx]
    cmovno rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovno rsi, QWORD PTR [rax]

// === CMOVNP r16, r16 ===
    cmovnp bx, bx
    cmovnp cx, dx
    cmovnp cx, ax
    cmovnp di, si
    cmovnp si, cx
    cmovnp bx, di
    cmovnp dx, bx
    cmovnp ax, bx
    cmovnp bx, cx
    cmovnp ax, cx

// === CMOVNP r16, m16 ===
    cmovnp ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnp ax, WORD PTR [rbx]
    cmovnp bx, WORD PTR [rbx]
    cmovnp cx, WORD PTR [rax]
    cmovnp di, WORD PTR [rax]
    cmovnp cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnp cx, WORD PTR [rip + 0x100]
    cmovnp dx, WORD PTR [rax]
    cmovnp si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnp di, WORD PTR [rip + 0x1000]

// === CMOVNP r32, r32 ===
    cmovnp eax, ecx
    cmovnp ebx, ebx
    cmovnp edi, edi
    cmovnp edi, ecx
    cmovnp ecx, edx
    cmovnp ecx, eax
    cmovnp eax, esi
    cmovnp esi, ebx
    cmovnp ecx, ecx
    cmovnp eax, ebx

// === CMOVNP r32, m32 ===
    cmovnp ecx, DWORD PTR [rbx]
    cmovnp esi, DWORD PTR [rax]
    cmovnp edx, DWORD PTR [rip + 0x100]
    cmovnp eax, DWORD PTR [rip + 0x100]
    cmovnp eax, DWORD PTR [rbx]
    cmovnp edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnp eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnp edi, DWORD PTR [rip + 0x1000]
    cmovnp ebx, DWORD PTR [rip + 0x1000]
    cmovnp esi, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNP r64, r64 ===
    cmovnp rbx, r11
    cmovnp r13, r9
    cmovnp rbx, rdi
    cmovnp rdi, rdi
    cmovnp r9, rbx
    cmovnp r8, r8
    cmovnp rdx, rcx
    cmovnp r10, r12
    cmovnp r12, rcx
    cmovnp rsi, r8

// === CMOVNP r64, m64 ===
    cmovnp rdx, QWORD PTR [rax]
    cmovnp r8, QWORD PTR [rax]
    cmovnp r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnp rcx, QWORD PTR [rax]
    cmovnp r12, QWORD PTR [rip + 0x1000]
    cmovnp r10, QWORD PTR [rip + 0x1000]
    cmovnp rdi, QWORD PTR [rip + 0x1000]
    cmovnp r8, QWORD PTR [rbx]
    cmovnp rdi, QWORD PTR [rbx]
    cmovnp rax, QWORD PTR [rax]

// === CMOVNS r16, r16 ===
    cmovns dx, dx
    cmovns ax, cx
    cmovns bx, ax
    cmovns cx, si
    cmovns si, di
    cmovns dx, si
    cmovns cx, di
    cmovns di, dx
    cmovns si, dx
    cmovns dx, ax

// === CMOVNS r16, m16 ===
    cmovns cx, WORD PTR [rbx]
    cmovns di, WORD PTR [rbx]
    cmovns di, WORD PTR [rax + rbx*4 + 0x100]
    cmovns ax, WORD PTR [rip + 0x100]
    cmovns ax, WORD PTR [rip + 0x1000]
    cmovns si, WORD PTR [rax]
    cmovns ax, WORD PTR [rax]
    cmovns ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovns dx, WORD PTR [rip + 0x1000]
    cmovns si, WORD PTR [rbx]

// === CMOVNS r32, r32 ===
    cmovns edx, esi
    cmovns esi, esi
    cmovns esi, eax
    cmovns ebx, eax
    cmovns ecx, edx
    cmovns edi, eax
    cmovns edx, ebx
    cmovns eax, edx
    cmovns esi, edx
    cmovns edi, esi

// === CMOVNS r32, m32 ===
    cmovns edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovns eax, DWORD PTR [rip + 0x100]
    cmovns edx, DWORD PTR [rip + 0x100]
    cmovns eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovns edi, DWORD PTR [rax]
    cmovns edi, DWORD PTR [rip + 0x100]
    cmovns edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovns esi, DWORD PTR [rbx]
    cmovns edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovns ebx, DWORD PTR [rip + 0x100]

// === CMOVNS r64, r64 ===
    cmovns rax, rax
    cmovns r9, rcx
    cmovns r13, r9
    cmovns rcx, rax
    cmovns r13, r12
    cmovns r10, rbx
    cmovns r12, r12
    cmovns rsi, r9
    cmovns rcx, r12
    cmovns rdx, r9

// === CMOVNS r64, m64 ===
    cmovns rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovns r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovns rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmovns r10, QWORD PTR [rbx]
    cmovns r13, QWORD PTR [rip + 0x1000]
    cmovns r13, QWORD PTR [rax]
    cmovns r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovns r10, QWORD PTR [rip + 0x100]
    cmovns r11, QWORD PTR [rip + 0x1000]
    cmovns r11, QWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNZ r16, r16 ===
    cmovnz ax, di
    cmovnz cx, cx
    cmovnz cx, si
    cmovnz si, bx
    cmovnz dx, dx
    cmovnz ax, cx
    cmovnz ax, dx
    cmovnz dx, si
    cmovnz si, di
    cmovnz cx, ax

// === CMOVNZ r16, m16 ===
    cmovnz si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnz dx, WORD PTR [rax]
    cmovnz ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnz cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnz cx, WORD PTR [rip + 0x1000]
    cmovnz dx, WORD PTR [rbx]
    cmovnz cx, WORD PTR [rbx]
    cmovnz ax, WORD PTR [rip + 0x100]
    cmovnz ax, WORD PTR [rip + 0x1000]
    cmovnz di, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVNZ r32, r32 ===
    cmovnz ebx, esi
    cmovnz ebx, eax
    cmovnz edi, eax
    cmovnz ebx, ecx
    cmovnz esi, ecx
    cmovnz edx, ecx
    cmovnz ebx, ebx
    cmovnz edx, edi
    cmovnz edx, edx
    cmovnz edi, ebx

// === CMOVNZ r32, m32 ===
    cmovnz eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnz edx, DWORD PTR [rip + 0x1000]
    cmovnz esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnz eax, DWORD PTR [rip + 0x100]
    cmovnz ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnz eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnz ecx, DWORD PTR [rip + 0x100]
    cmovnz ebx, DWORD PTR [rax]
    cmovnz eax, DWORD PTR [rbx]
    cmovnz ecx, DWORD PTR [rip + 0x1000]

// === CMOVNZ r64, r64 ===
    cmovnz rax, rcx
    cmovnz rdi, rsi
    cmovnz rdi, rdi
    cmovnz rax, r12
    cmovnz rax, rdi
    cmovnz rsi, r11
    cmovnz rax, r10
    cmovnz r13, r13
    cmovnz r11, r11
    cmovnz r10, rdx

// === CMOVNZ r64, m64 ===
    cmovnz r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnz r8, QWORD PTR [rip + 0x1000]
    cmovnz r9, QWORD PTR [rbx]
    cmovnz r10, QWORD PTR [rip + 0x100]
    cmovnz rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnz rbx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnz rdx, QWORD PTR [rax]
    cmovnz rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnz rdx, QWORD PTR [rip + 0x100]
    cmovnz rdx, QWORD PTR [rip + 0x1000]

// === CMOVO r16, r16 ===
    cmovo ax, ax
    cmovo ax, si
    cmovo ax, cx
    cmovo bx, cx
    cmovo bx, si
    cmovo cx, si
    cmovo bx, ax
    cmovo dx, di
    cmovo di, cx
    cmovo ax, dx

// === CMOVO r16, m16 ===
    cmovo si, WORD PTR [rip + 0x100]
    cmovo di, WORD PTR [rax + rbx*4 + 0x100]
    cmovo cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovo dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovo bx, WORD PTR [rip + 0x100]
    cmovo si, WORD PTR [rax + rbx*4 + 0x100]
    cmovo di, WORD PTR [rbx]
    cmovo cx, WORD PTR [rax]
    cmovo dx, WORD PTR [rbx]
    cmovo bx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVO r32, r32 ===
    cmovo ebx, edx
    cmovo ecx, edi
    cmovo edx, eax
    cmovo eax, ebx
    cmovo ebx, ebx
    cmovo ebx, ecx
    cmovo eax, ecx
    cmovo edx, edi
    cmovo edx, edx
    cmovo ecx, eax

// === CMOVO r32, m32 ===
    cmovo edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovo esi, DWORD PTR [rip + 0x100]
    cmovo edi, DWORD PTR [rax]
    cmovo ecx, DWORD PTR [rax]
    cmovo esi, DWORD PTR [rip + 0x1000]
    cmovo ebx, DWORD PTR [rip + 0x100]
    cmovo eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovo eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovo edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovo eax, DWORD PTR [rip + 0x1000]

// === CMOVO r64, r64 ===
    cmovo r10, rbx
    cmovo rcx, rdx
    cmovo r11, rcx
    cmovo r9, r10
    cmovo r10, rsi
    cmovo rsi, r9
    cmovo r12, r11
    cmovo rax, r11
    cmovo r10, r8
    cmovo rdx, r8

// === CMOVO r64, m64 ===
    cmovo rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovo rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovo r8, QWORD PTR [rip + 0x100]
    cmovo rdi, QWORD PTR [rip + 0x100]
    cmovo rsi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovo rsi, QWORD PTR [rbx]
    cmovo rax, QWORD PTR [rbx]
    cmovo rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovo r13, QWORD PTR [rip + 0x100]
    cmovo r10, QWORD PTR [rip + 0x100]

// === CMOVP r16, r16 ===
    cmovp dx, bx
    cmovp di, ax
    cmovp bx, dx
    cmovp ax, cx
    cmovp cx, ax
    cmovp bx, ax
    cmovp ax, si
    cmovp ax, di
    cmovp di, dx
    cmovp di, si

// === CMOVP r16, m16 ===
    cmovp ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovp ax, WORD PTR [rip + 0x100]
    cmovp bx, WORD PTR [rip + 0x1000]
    cmovp si, WORD PTR [rax + rbx*4 + 0x100]
    cmovp ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovp ax, WORD PTR [rax]
    cmovp cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovp si, WORD PTR [rip + 0x1000]
    cmovp si, WORD PTR [rip + 0x100]
    cmovp di, WORD PTR [rip + 0x1000]

// === CMOVP r32, r32 ===
    cmovp esi, ebx
    cmovp ecx, edi
    cmovp edx, edx
    cmovp esi, esi
    cmovp edi, ebx
    cmovp ecx, eax
    cmovp eax, ebx
    cmovp ebx, eax
    cmovp esi, eax
    cmovp eax, esi

// === CMOVP r32, m32 ===
    cmovp edi, DWORD PTR [rax]
    cmovp ecx, DWORD PTR [rax]
    cmovp edi, DWORD PTR [rip + 0x1000]
    cmovp ebx, DWORD PTR [rbx]
    cmovp ecx, DWORD PTR [rip + 0x1000]
    cmovp eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovp esi, DWORD PTR [rip + 0x1000]
    cmovp eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovp ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovp eax, DWORD PTR [rip + 0x100]

// === CMOVP r64, r64 ===
    cmovp rdi, r8
    cmovp rax, r11
    cmovp r13, rsi
    cmovp rax, r8
    cmovp r9, rbx
    cmovp rsi, r12
    cmovp r10, r9
    cmovp r10, rdx
    cmovp rbx, rax
    cmovp rdx, rbx

// === CMOVP r64, m64 ===
    cmovp rsi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovp rcx, QWORD PTR [rbx]
    cmovp r9, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovp r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmovp r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp rax, QWORD PTR [rbx]

// === CMOVPE r16, r16 ===
    cmovpe bx, dx
    cmovpe cx, cx
    cmovpe si, di
    cmovpe si, si
    cmovpe si, dx
    cmovpe ax, si
    cmovpe bx, bx
    cmovpe si, ax
    cmovpe di, bx
    cmovpe dx, di

// === CMOVPE r16, m16 ===
    cmovpe si, WORD PTR [rax + rbx*1 + 0x10]
    cmovpe ax, WORD PTR [rbx]
    cmovpe di, WORD PTR [rax + rbx*4 + 0x100]
    cmovpe cx, WORD PTR [rax]
    cmovpe ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovpe bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovpe dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovpe bx, WORD PTR [rax]
    cmovpe di, WORD PTR [rip + 0x1000]
    cmovpe si, WORD PTR [rax]

// === CMOVPE r32, r32 ===
    cmovpe ecx, edx
    cmovpe edx, ebx
    cmovpe eax, edi
    cmovpe eax, eax
    cmovpe eax, esi
    cmovpe esi, edx
    cmovpe edi, ecx
    cmovpe eax, ebx
    cmovpe ecx, ebx
    cmovpe edx, eax

// === CMOVPE r32, m32 ===
    cmovpe edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpe eax, DWORD PTR [rax]
    cmovpe ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpe ecx, DWORD PTR [rip + 0x100]
    cmovpe edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpe esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpe esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpe edi, DWORD PTR [rip + 0x1000]
    cmovpe esi, DWORD PTR [rip + 0x100]
    cmovpe esi, DWORD PTR [rax]

// === CMOVPE r64, r64 ===
    cmovpe r9, rax
    cmovpe r12, rdx
    cmovpe r8, rbx
    cmovpe rax, rax
    cmovpe r9, r9
    cmovpe rax, rbx
    cmovpe rdx, r12
    cmovpe r9, rdi
    cmovpe r11, rsi
    cmovpe r11, rdx

// === CMOVPE r64, m64 ===
    cmovpe rdx, QWORD PTR [rax]
    cmovpe r9, QWORD PTR [rip + 0x100]
    cmovpe rbx, QWORD PTR [rax]
    cmovpe rbx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovpe rbx, QWORD PTR [rip + 0x100]
    cmovpe r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovpe rax, QWORD PTR [rax]
    cmovpe rsi, QWORD PTR [rip + 0x100]
    cmovpe rax, QWORD PTR [rbx]
    cmovpe rbx, QWORD PTR [rax + rbx*1 + 0x10]

// === CMOVPO r16, r16 ===
    cmovpo cx, cx
    cmovpo ax, cx
    cmovpo cx, si
    cmovpo dx, dx
    cmovpo cx, bx
    cmovpo bx, bx
    cmovpo di, di
    cmovpo si, cx
    cmovpo di, si
    cmovpo di, dx

// === CMOVPO r16, m16 ===
    cmovpo di, WORD PTR [rax + rbx*1 + 0x10]
    cmovpo cx, WORD PTR [rbx]
    cmovpo bx, WORD PTR [rip + 0x100]
    cmovpo ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovpo di, WORD PTR [rax]
    cmovpo bx, WORD PTR [rip + 0x1000]
    cmovpo bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovpo bx, WORD PTR [rax]
    cmovpo ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovpo si, WORD PTR [rip + 0x1000]

// === CMOVPO r32, r32 ===
    cmovpo esi, esi
    cmovpo ebx, edx
    cmovpo edi, edx
    cmovpo ecx, ebx
    cmovpo edi, eax
    cmovpo edi, esi
    cmovpo edx, edi
    cmovpo edx, ebx
    cmovpo eax, edx
    cmovpo ebx, esi

// === CMOVPO r32, m32 ===
    cmovpo ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpo edi, DWORD PTR [rbx]
    cmovpo ecx, DWORD PTR [rip + 0x100]
    cmovpo edx, DWORD PTR [rip + 0x1000]
    cmovpo ebx, DWORD PTR [rip + 0x1000]
    cmovpo esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpo esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpo ecx, DWORD PTR [rip + 0x1000]
    cmovpo ebx, DWORD PTR [rip + 0x100]
    cmovpo ebx, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVPO r64, r64 ===
    cmovpo r12, r8
    cmovpo r10, r9
    cmovpo r12, rbx
    cmovpo rsi, r13
    cmovpo rbx, rdx
    cmovpo rsi, r11
    cmovpo rdx, rbx
    cmovpo r9, r11
    cmovpo r8, r9
    cmovpo rax, r8

// === CMOVPO r64, m64 ===
    cmovpo rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovpo rdi, QWORD PTR [rip + 0x100]
    cmovpo r12, QWORD PTR [rax]
    cmovpo r9, QWORD PTR [rbx]
    cmovpo rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovpo r11, QWORD PTR [rbx]
    cmovpo rbx, QWORD PTR [rip + 0x1000]
    cmovpo rbx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovpo rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovpo rax, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVS r16, r16 ===
    cmovs di, si
    cmovs si, si
    cmovs bx, cx
    cmovs cx, dx
    cmovs bx, si
    cmovs si, di
    cmovs si, dx
    cmovs ax, ax
    cmovs cx, di
    cmovs di, di

// === CMOVS r16, m16 ===
    cmovs cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovs dx, WORD PTR [rax]
    cmovs bx, WORD PTR [rip + 0x100]
    cmovs di, WORD PTR [rbx]
    cmovs cx, WORD PTR [rip + 0x1000]
    cmovs bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovs di, WORD PTR [rax]
    cmovs di, WORD PTR [rip + 0x100]
    cmovs dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovs bx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVS r32, r32 ===
    cmovs ecx, ebx
    cmovs esi, edi
    cmovs eax, ecx
    cmovs eax, esi
    cmovs ebx, edx
    cmovs eax, eax
    cmovs eax, edi
    cmovs edi, edi
    cmovs ecx, edx
    cmovs eax, edx

// === CMOVS r32, m32 ===
    cmovs eax, DWORD PTR [rip + 0x100]
    cmovs edx, DWORD PTR [rbx]
    cmovs esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovs ecx, DWORD PTR [rip + 0x1000]
    cmovs esi, DWORD PTR [rip + 0x1000]
    cmovs esi, DWORD PTR [rax]
    cmovs ebx, DWORD PTR [rax]
    cmovs eax, DWORD PTR [rip + 0x1000]
    cmovs edi, DWORD PTR [rip + 0x100]
    cmovs esi, DWORD PTR [rbx]

// === CMOVS r64, r64 ===
    cmovs r12, rdx
    cmovs r10, rsi
    cmovs r12, r8
    cmovs r11, r11
    cmovs rax, r12
    cmovs r12, r13
    cmovs r10, r8
    cmovs r9, rcx
    cmovs rdx, r12
    cmovs rdx, rbx

// === CMOVS r64, m64 ===
    cmovs rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovs r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovs r10, QWORD PTR [rax]
    cmovs r9, QWORD PTR [rip + 0x1000]
    cmovs rdx, QWORD PTR [rip + 0x1000]
    cmovs r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovs rdi, QWORD PTR [rip + 0x1000]
    cmovs r8, QWORD PTR [rax]
    cmovs r11, QWORD PTR [rbx]
    cmovs rcx, QWORD PTR [rax]

// === CMOVZ r16, r16 ===
    cmovz si, si
    cmovz bx, bx
    cmovz ax, dx
    cmovz bx, ax
    cmovz si, di
    cmovz dx, cx
    cmovz dx, ax
    cmovz di, di
    cmovz ax, di
    cmovz di, dx

// === CMOVZ r16, m16 ===
    cmovz si, WORD PTR [rbx]
    cmovz dx, WORD PTR [rip + 0x100]
    cmovz bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovz di, WORD PTR [rip + 0x100]
    cmovz si, WORD PTR [rax]
    cmovz dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovz dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovz ax, WORD PTR [rbx]
    cmovz bx, WORD PTR [rbx]
    cmovz si, WORD PTR [rip + 0x1000]

// === CMOVZ r32, r32 ===
    cmovz eax, edi
    cmovz esi, edi
    cmovz ebx, edi
    cmovz ebx, ecx
    cmovz ebx, esi
    cmovz edx, edx
    cmovz eax, ebx
    cmovz edx, esi
    cmovz ebx, edx
    cmovz esi, ecx

// === CMOVZ r32, m32 ===
    cmovz esi, DWORD PTR [rip + 0x100]
    cmovz esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovz ebx, DWORD PTR [rbx]
    cmovz ecx, DWORD PTR [rbx]
    cmovz esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovz ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovz ecx, DWORD PTR [rip + 0x1000]
    cmovz ebx, DWORD PTR [rip + 0x1000]
    cmovz edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovz edi, DWORD PTR [rip + 0x1000]

// === CMOVZ r64, r64 ===
    cmovz r10, r8
    cmovz r10, rbx
    cmovz rbx, rbx
    cmovz rsi, rdx
    cmovz rdx, rax
    cmovz r8, rsi
    cmovz rax, r11
    cmovz r13, r10
    cmovz rax, rdi
    cmovz r10, r9

// === CMOVZ r64, m64 ===
    cmovz r9, QWORD PTR [rax]
    cmovz rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovz r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovz r11, QWORD PTR [rip + 0x1000]
    cmovz r12, QWORD PTR [rip + 0x1000]
    cmovz rax, QWORD PTR [rip + 0x1000]
    cmovz r8, QWORD PTR [rip + 0x1000]
    cmovz rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovz r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovz r11, QWORD PTR [rax]

// === CMP AL, imm8 ===
    cmp al, 0xff

// === CMP AX, imm16 ===
    cmp ax, 0xffff

// === CMP EAX, imm32 ===
    cmp eax, 0xffffffff

// === CMP RAX, imm32 ===
    cmp rax, -1
    cmp rax, 0x7fffffff

// === CMP r8, imm8 ===
    cmp bl, 0xff
    cmp cl, 0xff
    cmp dl, 0xff
    cmp al, 0xff

// === CMP m8, imm8 ===
    cmp BYTE PTR [rip + 0x100], 0xff
    cmp BYTE PTR [rip + 0x1000], 0xff
    cmp BYTE PTR [rax + rbx*1 + 0x10], 0xff
    cmp BYTE PTR [rax], 0xff
    cmp BYTE PTR [rax + rbx*4 + 0x100], 0xff
    cmp BYTE PTR [rbx], 0xff

// === CMP r16, imm16 ===
    cmp ax, 0xffff
    cmp di, 0xffff
    cmp si, 0xffff
    cmp bx, 0xffff
    cmp cx, 0xffff
    cmp dx, 0xffff

// === CMP m16, imm16 ===
    cmp WORD PTR [rip + 0x100], 0xffff
    cmp WORD PTR [rbx], 0xffff
    cmp WORD PTR [rax + rbx*1 + 0x10], 0xffff
    cmp WORD PTR [rax + rbx*4 + 0x100], 0xffff
    cmp WORD PTR [rip + 0x1000], 0xffff
    cmp WORD PTR [rax], 0xffff

// === CMP r32, imm32 ===
    cmp eax, 0xffffffff
    cmp esi, 0xffffffff
    cmp edi, 0xffffffff
    cmp ebx, 0xffffffff
    cmp edx, 0xffffffff
    cmp ecx, 0xffffffff

// === CMP m32, imm32 ===
    cmp DWORD PTR [rip + 0x100], 0xffffffff
    cmp DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    cmp DWORD PTR [rip + 0x1000], 0xffffffff
    cmp DWORD PTR [rbx], 0xffffffff
    cmp DWORD PTR [rax], 0xffffffff
    cmp DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === CMP r64, imm32 ===
    cmp r12, -1
    cmp r9, -1
    cmp r10, 0x7fffffff
    cmp rax, -1
    cmp rdi, 0x7fffffff
    cmp r13, 0x7fffffff
    cmp r8, -1
    cmp rsi, -1
    cmp r11, -1
    cmp rdx, -1

// === CMP m64, imm32 ===
    cmp QWORD PTR [rbx], 0x7fffffff
    cmp QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    cmp QWORD PTR [rax + rbx*1 + 0x10], -1
    cmp QWORD PTR [rax], -1
    cmp QWORD PTR [rax + rbx*4 + 0x100], -1
    cmp QWORD PTR [rbx], -1
    cmp QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    cmp QWORD PTR [rax], 0x7fffffff
    cmp QWORD PTR [rip + 0x1000], 0x7fffffff
    cmp QWORD PTR [rip + 0x100], -1

// === CMP r16, imm8 ===
    cmp di, 0xff
    cmp cx, 0xff
    cmp bx, 0xff
    cmp ax, 0xff
    cmp dx, 0xff
    cmp si, 0xff

// === CMP m16, imm8 ===
    cmp WORD PTR [rip + 0x100], 0xff
    cmp WORD PTR [rax + rbx*4 + 0x100], 0xff
    cmp WORD PTR [rbx], 0xff
    cmp WORD PTR [rax + rbx*1 + 0x10], 0xff
    cmp WORD PTR [rip + 0x1000], 0xff
    cmp WORD PTR [rax], 0xff

// === CMP r32, imm8 ===
    cmp edx, 0xff
    cmp ebx, 0xff
    cmp eax, 0xff
    cmp edi, 0xff
    cmp ecx, 0xff
    cmp esi, 0xff

// === CMP m32, imm8 ===
    cmp DWORD PTR [rax], 0xff
    cmp DWORD PTR [rax + rbx*1 + 0x10], 0xff
    cmp DWORD PTR [rip + 0x100], 0xff
    cmp DWORD PTR [rbx], 0xff
    cmp DWORD PTR [rip + 0x1000], 0xff
    cmp DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === CMP r64, imm8 ===
    cmp r9, 0xff
    cmp rsi, 0xff
    cmp r11, 0xff
    cmp rax, 0xff
    cmp r8, 0xff
    cmp r10, 0xff
    cmp rcx, 0xff
    cmp rdi, 0xff
    cmp rdx, 0xff
    cmp r12, 0xff

// === CMP m64, imm8 ===
    cmp QWORD PTR [rip + 0x1000], 0xff
    cmp QWORD PTR [rax], 0xff
    cmp QWORD PTR [rbx], 0xff
    cmp QWORD PTR [rax + rbx*1 + 0x10], 0xff
    cmp QWORD PTR [rip + 0x100], 0xff
    cmp QWORD PTR [rax + rbx*4 + 0x100], 0xff

// === CMP r8, r8 ===
    cmp bl, dl
    cmp al, bl
    cmp dl, bl
    cmp cl, bl
    cmp cl, al
    cmp cl, cl
    cmp bl, cl
    cmp al, cl
    cmp al, dl
    cmp dl, cl

// === CMP m8, r8 ===
    cmp BYTE PTR [rax + rbx*1 + 0x10], bl
    cmp BYTE PTR [rax + rbx*4 + 0x100], al
    cmp BYTE PTR [rax], al
    cmp BYTE PTR [rip + 0x100], cl
    cmp BYTE PTR [rip + 0x1000], cl
    cmp BYTE PTR [rax], cl
    cmp BYTE PTR [rax + rbx*1 + 0x10], al
    cmp BYTE PTR [rbx], bl
    cmp BYTE PTR [rax + rbx*1 + 0x10], cl
    cmp BYTE PTR [rbx], dl

// === CMP r16, r16 ===
    cmp dx, di
    cmp si, cx
    cmp si, di
    cmp si, dx
    cmp di, dx
    cmp ax, di
    cmp dx, ax
    cmp ax, dx
    cmp cx, dx
    cmp ax, cx

// === CMP m16, r16 ===
    cmp WORD PTR [rbx], bx
    cmp WORD PTR [rax + rbx*4 + 0x100], ax
    cmp WORD PTR [rax], cx
    cmp WORD PTR [rip + 0x1000], si
    cmp WORD PTR [rax], di
    cmp WORD PTR [rip + 0x1000], dx
    cmp WORD PTR [rax + rbx*1 + 0x10], cx
    cmp WORD PTR [rbx], dx
    cmp WORD PTR [rip + 0x100], dx
    cmp WORD PTR [rip + 0x1000], di

// === CMP r32, r32 ===
    cmp edx, ebx
    cmp esi, edi
    cmp edx, edx
    cmp ebx, eax
    cmp ecx, edx
    cmp edi, edx
    cmp ecx, eax
    cmp edi, ecx
    cmp ecx, ecx
    cmp esi, edx

// === CMP m32, r32 ===
    cmp DWORD PTR [rax + rbx*4 + 0x100], eax
    cmp DWORD PTR [rip + 0x100], ebx
    cmp DWORD PTR [rax + rbx*1 + 0x10], esi
    cmp DWORD PTR [rip + 0x1000], edx
    cmp DWORD PTR [rax + rbx*1 + 0x10], eax
    cmp DWORD PTR [rax + rbx*1 + 0x10], ebx
    cmp DWORD PTR [rax + rbx*4 + 0x100], esi
    cmp DWORD PTR [rip + 0x1000], eax
    cmp DWORD PTR [rip + 0x1000], edi
    cmp DWORD PTR [rip + 0x100], esi

// === CMP r64,r64 ===
    cmp r10, r9
    cmp rcx, r8
    cmp rdx, r13
    cmp rsi, r12
    cmp r11, rcx
    cmp rbx, r12
    cmp rcx, rcx
    cmp rdx, r11
    cmp r11, r10
    cmp rcx, rbx

// === CMP m64,r64 ===
    cmp QWORD PTR [rax + rbx*1 + 0x10], r11
    cmp QWORD PTR [rax], rax
    cmp QWORD PTR [rax + rbx*4 + 0x100], r13
    cmp QWORD PTR [rax], rdx
    cmp QWORD PTR [rbx], r12
    cmp QWORD PTR [rip + 0x1000], rax
    cmp QWORD PTR [rax + rbx*1 + 0x10], r13
    cmp QWORD PTR [rax + rbx*1 + 0x10], r10
    cmp QWORD PTR [rax + rbx*1 + 0x10], rdi
    cmp QWORD PTR [rax + rbx*4 + 0x100], r9

// === CMP r8, m8 ===
    cmp dl, BYTE PTR [rax + rbx*1 + 0x10]
    cmp dl, BYTE PTR [rbx]
    cmp al, BYTE PTR [rax + rbx*4 + 0x100]
    cmp dl, BYTE PTR [rax]
    cmp dl, BYTE PTR [rip + 0x100]
    cmp bl, BYTE PTR [rip + 0x100]
    cmp cl, BYTE PTR [rip + 0x100]
    cmp bl, BYTE PTR [rbx]
    cmp bl, BYTE PTR [rax + rbx*1 + 0x10]
    cmp dl, BYTE PTR [rip + 0x1000]

// === CMP r16, m16 ===
    cmp di, WORD PTR [rip + 0x100]
    cmp dx, WORD PTR [rip + 0x1000]
    cmp cx, WORD PTR [rax]
    cmp ax, WORD PTR [rax + rbx*4 + 0x100]
    cmp dx, WORD PTR [rbx]
    cmp cx, WORD PTR [rax + rbx*4 + 0x100]
    cmp si, WORD PTR [rax]
    cmp bx, WORD PTR [rbx]
    cmp ax, WORD PTR [rax + rbx*1 + 0x10]
    cmp bx, WORD PTR [rax]

// === CMP r32, m32 ===
    cmp edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmp ecx, DWORD PTR [rbx]
    cmp esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmp eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmp ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmp ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmp edx, DWORD PTR [rip + 0x1000]
    cmp esi, DWORD PTR [rbx]
    cmp ecx, DWORD PTR [rax]
    cmp edx, DWORD PTR [rip + 0x100]

// === CMP r64, m64 ===
    cmp r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmp r13, QWORD PTR [rip + 0x1000]
    cmp r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmp r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmp rbx, QWORD PTR [rax + rbx*4 + 0x100]
    cmp r12, QWORD PTR [rip + 0x100]
    cmp rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmp r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmp rax, QWORD PTR [rip + 0x1000]
    cmp rbx, QWORD PTR [rip + 0x100]

// === CMPS m8, m8 ===
    cmps BYTE PTR [rsi], BYTE PTR [rdi]

// === CMPS m16, m16 ===
    cmps WORD PTR [rsi], WORD PTR [rdi]

// === CMPS m32, m32 ===
    cmps DWORD PTR [rsi], DWORD PTR [rdi]

// === CMPS m64, m64 ===
    cmps QWORD PTR [rsi], QWORD PTR [rdi]

// === CMPSB ===
    cmpsb

// === CMPSW ===
    cmpsw

// === CMPSD ===
    cmpsd

// === CMPSQ ===
    cmpsq

// === CMPXCHG r8, r8 ===
    cmpxchg al, cl
    cmpxchg bl, bl
    cmpxchg cl, bl
    cmpxchg dl, bl
    cmpxchg cl, al
    cmpxchg cl, cl
    cmpxchg bl, dl
    cmpxchg dl, dl
    cmpxchg dl, al
    cmpxchg dl, cl

// === CMPXCHG m8, r8 ===
    cmpxchg BYTE PTR [rax + rbx*1 + 0x10], cl
    cmpxchg BYTE PTR [rip + 0x1000], al
    cmpxchg BYTE PTR [rip + 0x1000], cl
    cmpxchg BYTE PTR [rbx], dl
    cmpxchg BYTE PTR [rip + 0x1000], dl
    cmpxchg BYTE PTR [rbx], bl
    cmpxchg BYTE PTR [rax + rbx*4 + 0x100], bl
    cmpxchg BYTE PTR [rax], dl
    cmpxchg BYTE PTR [rax], cl
    cmpxchg BYTE PTR [rip + 0x100], al

// === CMPXCHG r16, r16 ===
    cmpxchg dx, ax
    cmpxchg bx, di
    cmpxchg dx, cx
    cmpxchg bx, cx
    cmpxchg si, cx
    cmpxchg si, si
    cmpxchg ax, si
    cmpxchg cx, bx
    cmpxchg di, si
    cmpxchg si, bx

// === CMPXCHG m16, r16 ===
    cmpxchg WORD PTR [rip + 0x100], si
    cmpxchg WORD PTR [rbx], ax
    cmpxchg WORD PTR [rip + 0x1000], ax
    cmpxchg WORD PTR [rax + rbx*1 + 0x10], ax
    cmpxchg WORD PTR [rax + rbx*1 + 0x10], si
    cmpxchg WORD PTR [rax + rbx*4 + 0x100], dx
    cmpxchg WORD PTR [rax], bx
    cmpxchg WORD PTR [rax + rbx*4 + 0x100], di
    cmpxchg WORD PTR [rax], dx
    cmpxchg WORD PTR [rax + rbx*1 + 0x10], dx

// === CMPXCHG r32, r32 ===
    cmpxchg edx, ecx
    cmpxchg ebx, esi
    cmpxchg ebx, ebx
    cmpxchg edi, edx
    cmpxchg eax, esi
    cmpxchg edi, ecx
    cmpxchg edi, esi
    cmpxchg edi, eax
    cmpxchg ecx, esi
    cmpxchg ecx, ebx

// === CMPXCHG m32, r32 ===
    cmpxchg DWORD PTR [rip + 0x1000], edi
    cmpxchg DWORD PTR [rax + rbx*1 + 0x10], edi
    cmpxchg DWORD PTR [rax + rbx*1 + 0x10], edx
    cmpxchg DWORD PTR [rax + rbx*4 + 0x100], edx
    cmpxchg DWORD PTR [rax + rbx*4 + 0x100], eax
    cmpxchg DWORD PTR [rip + 0x1000], ebx
    cmpxchg DWORD PTR [rip + 0x100], esi
    cmpxchg DWORD PTR [rax + rbx*4 + 0x100], ecx
    cmpxchg DWORD PTR [rip + 0x1000], ecx
    cmpxchg DWORD PTR [rax], edi

// === CMPXCHG r64, r64 ===
    cmpxchg rax, r13
    cmpxchg r11, rbx
    cmpxchg r13, rdi
    cmpxchg r11, rdi
    cmpxchg r13, r8
    cmpxchg r13, r9
    cmpxchg r10, rdx
    cmpxchg rcx, rdx
    cmpxchg r11, r13
    cmpxchg r12, r13

// === CMPXCHG m64, r64 ===
    cmpxchg QWORD PTR [rax + rbx*1 + 0x10], r11
    cmpxchg QWORD PTR [rbx], r8
    cmpxchg QWORD PTR [rax], rbx
    cmpxchg QWORD PTR [rip + 0x100], rsi
    cmpxchg QWORD PTR [rax], rcx
    cmpxchg QWORD PTR [rip + 0x1000], r9
    cmpxchg QWORD PTR [rax], r8
    cmpxchg QWORD PTR [rax + rbx*4 + 0x100], rbx
    cmpxchg QWORD PTR [rip + 0x100], rdi
    cmpxchg QWORD PTR [rip + 0x1000], rdx

// === CRC32 r32, r8 ===
    crc32 edx, al
    crc32 edi, bl
    crc32 esi, al
    crc32 edx, cl
    crc32 eax, cl
    crc32 edi, cl
    crc32 eax, bl
    crc32 edx, bl
    crc32 ebx, dl
    crc32 ecx, cl

// === CRC32 r32, m8 ===
    crc32 edx, BYTE PTR [rax + rbx*1 + 0x10]
    crc32 edx, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 eax, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 edi, BYTE PTR [rax]
    crc32 esi, BYTE PTR [rip + 0x1000]
    crc32 ecx, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 edi, BYTE PTR [rax + rbx*1 + 0x10]
    crc32 ebx, BYTE PTR [rip + 0x100]
    crc32 edx, BYTE PTR [rax]
    crc32 ecx, BYTE PTR [rax + rbx*1 + 0x10]

// === CRC32 r32, r16 ===
    crc32 edx, dx
    crc32 ebx, si
    crc32 ebx, ax
    crc32 edx, cx
    crc32 edi, si
    crc32 eax, si
    crc32 edi, cx
    crc32 ecx, dx
    crc32 esi, di
    crc32 esi, dx

// === CRC32 r32, m16 ===
    crc32 edi, WORD PTR [rbx]
    crc32 edi, WORD PTR [rip + 0x1000]
    crc32 eax, WORD PTR [rax + rbx*1 + 0x10]
    crc32 esi, WORD PTR [rip + 0x100]
    crc32 edx, WORD PTR [rip + 0x100]
    crc32 eax, WORD PTR [rax]
    crc32 ebx, WORD PTR [rax + rbx*1 + 0x10]
    crc32 ebx, WORD PTR [rax]
    crc32 ebx, WORD PTR [rip + 0x100]
    crc32 ebx, WORD PTR [rax + rbx*4 + 0x100]

// === CRC32 r32, r32 ===
    crc32 edx, ebx
    crc32 ecx, ecx
    crc32 edx, esi
    crc32 eax, edi
    crc32 eax, esi
    crc32 ecx, esi
    crc32 eax, ecx
    crc32 eax, eax
    crc32 ecx, edx
    crc32 esi, edx

// === CRC32 r32, m32 ===
    crc32 edi, DWORD PTR [rax]
    crc32 eax, DWORD PTR [rax]
    crc32 eax, DWORD PTR [rip + 0x100]
    crc32 eax, DWORD PTR [rax + rbx*4 + 0x100]
    crc32 ebx, DWORD PTR [rip + 0x100]
    crc32 esi, DWORD PTR [rax + rbx*1 + 0x10]
    crc32 ecx, DWORD PTR [rax + rbx*4 + 0x100]
    crc32 edx, DWORD PTR [rip + 0x1000]
    crc32 ebx, DWORD PTR [rip + 0x1000]
    crc32 ecx, DWORD PTR [rip + 0x1000]

// === CRC32 r64, r8 ===
    crc32 r9, dl
    crc32 rdx, bl
    crc32 r11, cl
    crc32 r11, al
    crc32 r10, dl
    crc32 rbx, cl
    crc32 rbx, dl
    crc32 r11, bl
    crc32 r9, al
    crc32 r10, cl

// === CRC32 r64, m8 ===
    crc32 rcx, BYTE PTR [rax]
    crc32 rdx, BYTE PTR [rax]
    crc32 rdi, BYTE PTR [rax + rbx*1 + 0x10]
    crc32 rcx, BYTE PTR [rip + 0x1000]
    crc32 r10, BYTE PTR [rip + 0x1000]
    crc32 rsi, BYTE PTR [rip + 0x1000]
    crc32 r13, BYTE PTR [rbx]
    crc32 rdi, BYTE PTR [rip + 0x1000]
    crc32 rbx, BYTE PTR [rax]
    crc32 rbx, BYTE PTR [rip + 0x100]

// === CRC32 r64, r64 ===
    crc32 r12, rax
    crc32 rdx, rdi
    crc32 r11, rsi
    crc32 r13, rax
    crc32 rcx, r12
    crc32 rbx, rcx
    crc32 rdi, r11
    crc32 r9, r11
    crc32 r11, r13
    crc32 r11, rax

// === CRC32 r64, m64 ===
    crc32 r13, QWORD PTR [rip + 0x1000]
    crc32 rdx, QWORD PTR [rbx]
    crc32 rdx, QWORD PTR [rip + 0x100]
    crc32 r10, QWORD PTR [rip + 0x1000]
    crc32 r9, QWORD PTR [rip + 0x1000]
    crc32 r8, QWORD PTR [rax + rbx*4 + 0x100]
    crc32 rax, QWORD PTR [rip + 0x1000]
    crc32 r8, QWORD PTR [rbx]
    crc32 r13, QWORD PTR [rip + 0x100]
    crc32 r11, QWORD PTR [rax + rbx*1 + 0x10]

// === CWD ===
    cwd

// === CDQ ===
    cdq

// === CQO ===
    cqo

// === DEC r8 ===
    dec al
    dec cl
    dec dl
    dec bl

// === DEC m8 ===
    dec BYTE PTR [rax + rbx*4 + 0x100]
    dec BYTE PTR [rbx]
    dec BYTE PTR [rax + rbx*1 + 0x10]
    dec BYTE PTR [rip + 0x1000]
    dec BYTE PTR [rip + 0x100]
    dec BYTE PTR [rax]

// === DEC r16 ===
    dec ax
    dec di
    dec dx
    dec cx
    dec si
    dec bx

// === DEC m16 ===
    dec WORD PTR [rax + rbx*1 + 0x10]
    dec WORD PTR [rax]
    dec WORD PTR [rip + 0x1000]
    dec WORD PTR [rip + 0x100]
    dec WORD PTR [rax + rbx*4 + 0x100]
    dec WORD PTR [rbx]

// === DEC r32 ===
    dec esi
    dec eax
    dec edx
    dec ecx
    dec ebx
    dec edi

// === DEC m32 ===
    dec DWORD PTR [rax + rbx*1 + 0x10]
    dec DWORD PTR [rip + 0x100]
    dec DWORD PTR [rip + 0x1000]
    dec DWORD PTR [rax + rbx*4 + 0x100]
    dec DWORD PTR [rbx]
    dec DWORD PTR [rax]

// === DEC r64 ===
    dec rcx
    dec r12
    dec rbx
    dec r13
    dec r8
    dec r11
    dec rsi
    dec rdx
    dec rdi
    dec r10

// === DEC m64 ===
    dec QWORD PTR [rip + 0x1000]
    dec QWORD PTR [rax + rbx*4 + 0x100]
    dec QWORD PTR [rax]
    dec QWORD PTR [rip + 0x100]
    dec QWORD PTR [rax + rbx*1 + 0x10]
    dec QWORD PTR [rbx]

// === DIV r8 ===
    div cl
    div dl
    div al
    div bl

// === DIV m8 ===
    div BYTE PTR [rip + 0x1000]
    div BYTE PTR [rax + rbx*4 + 0x100]
    div BYTE PTR [rip + 0x100]
    div BYTE PTR [rbx]
    div BYTE PTR [rax]
    div BYTE PTR [rax + rbx*1 + 0x10]

// === DIV r16 ===
    div ax
    div di
    div cx
    div bx
    div si
    div dx

// === DIV m16 ===
    div WORD PTR [rip + 0x1000]
    div WORD PTR [rax]
    div WORD PTR [rbx]
    div WORD PTR [rax + rbx*4 + 0x100]
    div WORD PTR [rax + rbx*1 + 0x10]
    div WORD PTR [rip + 0x100]

// === DIV r32 ===
    div esi
    div ebx
    div ecx
    div edx
    div eax
    div edi

// === DIV m32 ===
    div DWORD PTR [rax + rbx*4 + 0x100]
    div DWORD PTR [rax]
    div DWORD PTR [rbx]
    div DWORD PTR [rip + 0x1000]
    div DWORD PTR [rip + 0x100]
    div DWORD PTR [rax + rbx*1 + 0x10]

// === DIV r64 ===
    div rcx
    div rdi
    div rsi
    div r8
    div rdx
    div rax
    div r11
    div r12
    div rbx
    div r13

// === DIV m64 ===
    div QWORD PTR [rax + rbx*1 + 0x10]
    div QWORD PTR [rax + rbx*4 + 0x100]
    div QWORD PTR [rax]
    div QWORD PTR [rbx]
    div QWORD PTR [rip + 0x100]
    div QWORD PTR [rip + 0x1000]

// === EMMS ===
    emms

// === ENTER imm16, 0 ===
    enter 0xffff, 1

// === ENTER imm16,1 ===
    enter 0xffff, 1

// === ENTER imm16, imm8 ===
    enter 0xffff, 0xff

// === ERETS ===
    erets

// === ERETU ===
    eretu

// === F2XM1 ===
    f2xm1

// === FABS ===
    fabs

// === FADD m32fp ===
    fadd DWORD PTR [rax]
    fadd DWORD PTR [rax + rbx*1 + 0x10]
    fadd DWORD PTR [rip + 0x1000]
    fadd DWORD PTR [rip + 0x100]
    fadd DWORD PTR [rax + rbx*4 + 0x100]
    fadd DWORD PTR [rbx]

// === FADD m64fp ===
    fadd QWORD PTR [rax + rbx*4 + 0x100]
    fadd QWORD PTR [rip + 0x100]
    fadd QWORD PTR [rax]
    fadd QWORD PTR [rip + 0x1000]
    fadd QWORD PTR [rbx]
    fadd QWORD PTR [rax + rbx*1 + 0x10]

// === FADD ST(0), ST(i) ===
    fadd st(0), st(2)
    fadd st(0), st(1)
    fadd st(0), st(0)
    fadd st(0), st(3)

// === FADD ST(i), ST(0) ===
    fadd st(3), st(0)
    fadd st(0), st(0)
    fadd st(2), st(0)
    fadd st(1), st(0)

// === FADDP ST(i), ST(0) ===
    faddp st(3), st(0)
    faddp st(0), st(0)
    faddp st(1), st(0)
    faddp st(2), st(0)

// === FADDP ===
    faddp

// === FIADD m32int ===
    fiadd DWORD PTR [rip + 0x100]
    fiadd DWORD PTR [rax + rbx*1 + 0x10]
    fiadd DWORD PTR [rip + 0x1000]
    fiadd DWORD PTR [rbx]
    fiadd DWORD PTR [rax + rbx*4 + 0x100]
    fiadd DWORD PTR [rax]

// === FIADD m16int ===
    fiadd WORD PTR [rax + rbx*4 + 0x100]
    fiadd WORD PTR [rax]
    fiadd WORD PTR [rax + rbx*1 + 0x10]
    fiadd WORD PTR [rip + 0x1000]
    fiadd WORD PTR [rbx]
    fiadd WORD PTR [rip + 0x100]

// === FBLD m80bcd ===
    fbld TBYTE PTR [rip + 0x100]
    fbld TBYTE PTR [rax + rbx*1 + 0x10]
    fbld TBYTE PTR [rax + rbx*4 + 0x100]
    fbld TBYTE PTR [rip + 0x1000]
    fbld TBYTE PTR [rbx]
    fbld TBYTE PTR [rax]

// === FBSTP m80bcd ===
    fbstp TBYTE PTR [rax]
    fbstp TBYTE PTR [rip + 0x100]
    fbstp TBYTE PTR [rip + 0x1000]
    fbstp TBYTE PTR [rbx]
    fbstp TBYTE PTR [rax + rbx*4 + 0x100]
    fbstp TBYTE PTR [rax + rbx*1 + 0x10]

// === FCHS ===
    fchs

// === FCLEX ===
    fclex

// === FNCLEX ===
    fnclex

// === FCMOVB ST(0), ST(i) ===
    fcmovb st(0), st(0)
    fcmovb st(0), st(2)
    fcmovb st(0), st(1)
    fcmovb st(0), st(3)

// === FCMOVE ST(0), ST(i) ===
    fcmove st(0), st(1)
    fcmove st(0), st(2)
    fcmove st(0), st(0)
    fcmove st(0), st(3)

// === FCMOVBE ST(0), ST(i) ===
    fcmovbe st(0), st(1)
    fcmovbe st(0), st(3)
    fcmovbe st(0), st(2)
    fcmovbe st(0), st(0)

// === FCMOVU ST(0), ST(i) ===
    fcmovu st(0), st(3)
    fcmovu st(0), st(2)
    fcmovu st(0), st(0)
    fcmovu st(0), st(1)

// === FCMOVNB ST(0), ST(i) ===
    fcmovnb st(0), st(0)
    fcmovnb st(0), st(3)
    fcmovnb st(0), st(2)
    fcmovnb st(0), st(1)

// === FCMOVNE ST(0), ST(i) ===
    fcmovne st(0), st(1)
    fcmovne st(0), st(2)
    fcmovne st(0), st(3)
    fcmovne st(0), st(0)

// === FCMOVNBE ST(0), ST(i) ===
    fcmovnbe st(0), st(3)
    fcmovnbe st(0), st(1)
    fcmovnbe st(0), st(0)
    fcmovnbe st(0), st(2)

// === FCMOVNU ST(0), ST(i) ===
    fcmovnu st(0), st(2)
    fcmovnu st(0), st(3)
    fcmovnu st(0), st(1)
    fcmovnu st(0), st(0)

// === FCOM m32fp ===
    fcom DWORD PTR [rax + rbx*4 + 0x100]
    fcom DWORD PTR [rax + rbx*1 + 0x10]
    fcom DWORD PTR [rip + 0x1000]
    fcom DWORD PTR [rbx]
    fcom DWORD PTR [rip + 0x100]
    fcom DWORD PTR [rax]

// === FCOM m64fp ===
    fcom QWORD PTR [rax]
    fcom QWORD PTR [rip + 0x1000]
    fcom QWORD PTR [rip + 0x100]
    fcom QWORD PTR [rax + rbx*1 + 0x10]
    fcom QWORD PTR [rbx]
    fcom QWORD PTR [rax + rbx*4 + 0x100]

// === FCOM ST(i) ===
    fcom st(1)
    fcom st(0)
    fcom st(2)
    fcom st(3)

// === FCOM ===
    fcom

// === FCOMP m32fp ===
    fcomp DWORD PTR [rax]
    fcomp DWORD PTR [rip + 0x100]
    fcomp DWORD PTR [rax + rbx*4 + 0x100]
    fcomp DWORD PTR [rax + rbx*1 + 0x10]
    fcomp DWORD PTR [rip + 0x1000]
    fcomp DWORD PTR [rbx]

// === FCOMP m64fp ===
    fcomp QWORD PTR [rax]
    fcomp QWORD PTR [rax + rbx*1 + 0x10]
    fcomp QWORD PTR [rax + rbx*4 + 0x100]
    fcomp QWORD PTR [rbx]
    fcomp QWORD PTR [rip + 0x1000]
    fcomp QWORD PTR [rip + 0x100]

// === FCOMP ST(i) ===
    fcomp st(2)
    fcomp st(1)
    fcomp st(0)
    fcomp st(3)

// === FCOMP ===
    fcomp

// === FCOMPP ===
    fcompp

// === FCOMI ST, ST(i) ===
    fcomi st(0), st(2)
    fcomi st(0), st(0)
    fcomi st(0), st(1)
    fcomi st(0), st(3)

// === FCOMIP ST, ST(i) ===
    fcomip st(0), st(3)
    fcomip st(0), st(2)
    fcomip st(0), st(1)
    fcomip st(0), st(0)

// === FUCOMI ST, ST(i) ===
    fucomi st(0), st(1)
    fucomi st(0), st(3)
    fucomi st(0), st(0)
    fucomi st(0), st(2)

// === FUCOMIP ST, ST(i) ===
    fucomip st(0), st(2)
    fucomip st(0), st(3)
    fucomip st(0), st(0)
    fucomip st(0), st(1)

// === FCOS ===
    fcos

// === FDECSTP ===
    fdecstp

// === FDIV m32fp ===
    fdiv DWORD PTR [rax + rbx*4 + 0x100]
    fdiv DWORD PTR [rax + rbx*1 + 0x10]
    fdiv DWORD PTR [rax]
    fdiv DWORD PTR [rip + 0x1000]
    fdiv DWORD PTR [rbx]
    fdiv DWORD PTR [rip + 0x100]

// === FDIV m64fp ===
    fdiv QWORD PTR [rip + 0x1000]
    fdiv QWORD PTR [rax + rbx*4 + 0x100]
    fdiv QWORD PTR [rip + 0x100]
    fdiv QWORD PTR [rax + rbx*1 + 0x10]
    fdiv QWORD PTR [rax]
    fdiv QWORD PTR [rbx]

// === FDIV ST(0), ST(i) ===
    fdiv st(0), st(3)
    fdiv st(0), st(0)
    fdiv st(0), st(2)
    fdiv st(0), st(1)

// === FDIV ST(i), ST(0) ===
    fdiv st(2), st(0)
    fdiv st(3), st(0)
    fdiv st(1), st(0)
    fdiv st(0), st(0)

// === FDIVP ST(i), ST(0) ===
    fdivp st(3), st(0)
    fdivp st(2), st(0)
    fdivp st(1), st(0)
    fdivp st(0), st(0)

// === FDIVP ===
    fdivp

// === FIDIV m32int ===
    fidiv DWORD PTR [rip + 0x1000]
    fidiv DWORD PTR [rbx]
    fidiv DWORD PTR [rax + rbx*4 + 0x100]
    fidiv DWORD PTR [rax]
    fidiv DWORD PTR [rip + 0x100]
    fidiv DWORD PTR [rax + rbx*1 + 0x10]

// === FIDIV m16int ===
    fidiv WORD PTR [rax + rbx*4 + 0x100]
    fidiv WORD PTR [rax + rbx*1 + 0x10]
    fidiv WORD PTR [rip + 0x1000]
    fidiv WORD PTR [rip + 0x100]
    fidiv WORD PTR [rbx]
    fidiv WORD PTR [rax]

// === FDIVR m32fp ===
    fdivr DWORD PTR [rax]
    fdivr DWORD PTR [rax + rbx*4 + 0x100]
    fdivr DWORD PTR [rip + 0x100]
    fdivr DWORD PTR [rip + 0x1000]
    fdivr DWORD PTR [rbx]
    fdivr DWORD PTR [rax + rbx*1 + 0x10]

// === FDIVR m64fp ===
    fdivr QWORD PTR [rax + rbx*1 + 0x10]
    fdivr QWORD PTR [rax]
    fdivr QWORD PTR [rip + 0x1000]
    fdivr QWORD PTR [rax + rbx*4 + 0x100]
    fdivr QWORD PTR [rip + 0x100]
    fdivr QWORD PTR [rbx]

// === FDIVR ST(0), ST(i) ===
    fdivr st(0), st(0)
    fdivr st(0), st(1)
    fdivr st(0), st(3)
    fdivr st(0), st(2)

// === FDIVR ST(i), ST(0) ===
    fdivr st(0), st(0)
    fdivr st(1), st(0)
    fdivr st(3), st(0)
    fdivr st(2), st(0)

// === FDIVRP ST(i), ST(0) ===
    fdivrp st(0), st(0)
    fdivrp st(1), st(0)
    fdivrp st(2), st(0)
    fdivrp st(3), st(0)

// === FDIVRP ===
    fdivrp

// === FIDIVR m32int ===
    fidivr DWORD PTR [rax]
    fidivr DWORD PTR [rax + rbx*1 + 0x10]
    fidivr DWORD PTR [rip + 0x1000]
    fidivr DWORD PTR [rbx]
    fidivr DWORD PTR [rax + rbx*4 + 0x100]
    fidivr DWORD PTR [rip + 0x100]

// === FIDIVR m16int ===
    fidivr WORD PTR [rax + rbx*4 + 0x100]
    fidivr WORD PTR [rip + 0x100]
    fidivr WORD PTR [rip + 0x1000]
    fidivr WORD PTR [rax + rbx*1 + 0x10]
    fidivr WORD PTR [rbx]
    fidivr WORD PTR [rax]

// === FFREE ST(i) ===
    ffree st(3)
    ffree st(2)
    ffree st(0)
    ffree st(1)

// === FICOM m16int ===
    ficom WORD PTR [rip + 0x100]
    ficom WORD PTR [rax + rbx*4 + 0x100]
    ficom WORD PTR [rbx]
    ficom WORD PTR [rax + rbx*1 + 0x10]
    ficom WORD PTR [rax]
    ficom WORD PTR [rip + 0x1000]

// === FICOM m32int ===
    ficom DWORD PTR [rax + rbx*1 + 0x10]
    ficom DWORD PTR [rax]
    ficom DWORD PTR [rip + 0x1000]
    ficom DWORD PTR [rbx]
    ficom DWORD PTR [rip + 0x100]
    ficom DWORD PTR [rax + rbx*4 + 0x100]

// === FICOMP m16int ===
    ficomp WORD PTR [rip + 0x100]
    ficomp WORD PTR [rax]
    ficomp WORD PTR [rbx]
    ficomp WORD PTR [rax + rbx*4 + 0x100]
    ficomp WORD PTR [rax + rbx*1 + 0x10]
    ficomp WORD PTR [rip + 0x1000]

// === FICOMP m32int ===
    ficomp DWORD PTR [rax + rbx*4 + 0x100]
    ficomp DWORD PTR [rax + rbx*1 + 0x10]
    ficomp DWORD PTR [rip + 0x100]
    ficomp DWORD PTR [rbx]
    ficomp DWORD PTR [rax]
    ficomp DWORD PTR [rip + 0x1000]

// === FILD m16int ===
    fild WORD PTR [rip + 0x1000]
    fild WORD PTR [rbx]
    fild WORD PTR [rax + rbx*4 + 0x100]
    fild WORD PTR [rax + rbx*1 + 0x10]
    fild WORD PTR [rax]
    fild WORD PTR [rip + 0x100]

// === FILD m32int ===
    fild DWORD PTR [rax]
    fild DWORD PTR [rax + rbx*1 + 0x10]
    fild DWORD PTR [rip + 0x1000]
    fild DWORD PTR [rax + rbx*4 + 0x100]
    fild DWORD PTR [rbx]
    fild DWORD PTR [rip + 0x100]

// === FILD m64int ===
    fild QWORD PTR [rax]
    fild QWORD PTR [rbx]
    fild QWORD PTR [rip + 0x100]
    fild QWORD PTR [rax + rbx*4 + 0x100]
    fild QWORD PTR [rip + 0x1000]
    fild QWORD PTR [rax + rbx*1 + 0x10]

// === FINCSTP ===
    fincstp

// === FINIT ===
    finit

// === FNINIT ===
    fninit

// === FIST m16int ===
    fist WORD PTR [rbx]
    fist WORD PTR [rax + rbx*1 + 0x10]
    fist WORD PTR [rip + 0x1000]
    fist WORD PTR [rip + 0x100]
    fist WORD PTR [rax + rbx*4 + 0x100]
    fist WORD PTR [rax]

// === FIST m32int ===
    fist DWORD PTR [rax]
    fist DWORD PTR [rip + 0x1000]
    fist DWORD PTR [rip + 0x100]
    fist DWORD PTR [rbx]
    fist DWORD PTR [rax + rbx*4 + 0x100]
    fist DWORD PTR [rax + rbx*1 + 0x10]

// === FISTP m16int ===
    fistp WORD PTR [rip + 0x1000]
    fistp WORD PTR [rax + rbx*4 + 0x100]
    fistp WORD PTR [rax + rbx*1 + 0x10]
    fistp WORD PTR [rax]
    fistp WORD PTR [rip + 0x100]
    fistp WORD PTR [rbx]

// === FISTP m32int ===
    fistp DWORD PTR [rip + 0x1000]
    fistp DWORD PTR [rip + 0x100]
    fistp DWORD PTR [rax]
    fistp DWORD PTR [rax + rbx*4 + 0x100]
    fistp DWORD PTR [rbx]
    fistp DWORD PTR [rax + rbx*1 + 0x10]

// === FISTP m64int ===
    fistp QWORD PTR [rax + rbx*4 + 0x100]
    fistp QWORD PTR [rip + 0x100]
    fistp QWORD PTR [rip + 0x1000]
    fistp QWORD PTR [rax]
    fistp QWORD PTR [rbx]
    fistp QWORD PTR [rax + rbx*1 + 0x10]

// === FISTTP m16int ===
    fisttp WORD PTR [rax + rbx*1 + 0x10]
    fisttp WORD PTR [rax + rbx*4 + 0x100]
    fisttp WORD PTR [rip + 0x100]
    fisttp WORD PTR [rbx]
    fisttp WORD PTR [rax]
    fisttp WORD PTR [rip + 0x1000]

// === FISTTP m32int ===
    fisttp DWORD PTR [rip + 0x100]
    fisttp DWORD PTR [rax]
    fisttp DWORD PTR [rbx]
    fisttp DWORD PTR [rip + 0x1000]
    fisttp DWORD PTR [rax + rbx*4 + 0x100]
    fisttp DWORD PTR [rax + rbx*1 + 0x10]

// === FISTTP m64int ===
    fisttp QWORD PTR [rip + 0x1000]
    fisttp QWORD PTR [rip + 0x100]
    fisttp QWORD PTR [rax + rbx*4 + 0x100]
    fisttp QWORD PTR [rbx]
    fisttp QWORD PTR [rax]
    fisttp QWORD PTR [rax + rbx*1 + 0x10]

// === FLD m32fp ===
    fld DWORD PTR [rip + 0x1000]
    fld DWORD PTR [rax + rbx*1 + 0x10]
    fld DWORD PTR [rip + 0x100]
    fld DWORD PTR [rbx]
    fld DWORD PTR [rax]
    fld DWORD PTR [rax + rbx*4 + 0x100]

// === FLD m64fp ===
    fld QWORD PTR [rax]
    fld QWORD PTR [rip + 0x100]
    fld QWORD PTR [rbx]
    fld QWORD PTR [rax + rbx*4 + 0x100]
    fld QWORD PTR [rip + 0x1000]
    fld QWORD PTR [rax + rbx*1 + 0x10]

// === FLD m80fp ===
    fld TBYTE PTR [rax]
    fld TBYTE PTR [rbx]
    fld TBYTE PTR [rax + rbx*1 + 0x10]
    fld TBYTE PTR [rax + rbx*4 + 0x100]
    fld TBYTE PTR [rip + 0x1000]
    fld TBYTE PTR [rip + 0x100]

// === FLD ST(i) ===
    fld st(1)
    fld st(0)
    fld st(2)
    fld st(3)

// === FLD1 ===
    fld1

// === FLDL2T ===
    fldl2t

// === FLDL2E ===
    fldl2e

// === FLDPI ===
    fldpi

// === FLDLG2 ===
    fldlg2

// === FLDLN2 ===
    fldln2

// === FLDZ ===
    fldz

// === FLDCW m2byte ===
    fldcw WORD PTR [rax + rbx*1 + 0x10]
    fldcw WORD PTR [rbx]
    fldcw WORD PTR [rax]
    fldcw WORD PTR [rax + rbx*4 + 0x100]
    fldcw WORD PTR [rip + 0x1000]
    fldcw WORD PTR [rip + 0x100]

// === FLDENV m14/28byte ===
    fldenv [rax + rbx*4 + 0x100]
    fldenv [rax + rbx*1 + 0x10]
    fldenv [rip + 0x1000]
    fldenv [rip + 0x100]
    fldenv [rbx]
    fldenv [rax]

// === FMUL m32fp ===
    fmul DWORD PTR [rip + 0x100]
    fmul DWORD PTR [rbx]
    fmul DWORD PTR [rax + rbx*4 + 0x100]
    fmul DWORD PTR [rip + 0x1000]
    fmul DWORD PTR [rax + rbx*1 + 0x10]
    fmul DWORD PTR [rax]

// === FMUL m64fp ===
    fmul QWORD PTR [rax]
    fmul QWORD PTR [rip + 0x1000]
    fmul QWORD PTR [rip + 0x100]
    fmul QWORD PTR [rbx]
    fmul QWORD PTR [rax + rbx*4 + 0x100]
    fmul QWORD PTR [rax + rbx*1 + 0x10]

// === FMUL ST(0), ST(i) ===
    fmul st(0), st(1)
    fmul st(0), st(3)
    fmul st(0), st(0)
    fmul st(0), st(2)

// === FMUL ST(i), ST(0) ===
    fmul st(2), st(0)
    fmul st(3), st(0)
    fmul st(1), st(0)
    fmul st(0), st(0)

// === FMULP ST(i), ST(0) ===
    fmulp st(3), st(0)
    fmulp st(2), st(0)
    fmulp st(1), st(0)
    fmulp st(0), st(0)

// === FMULP ===
    fmulp

// === FIMUL m32int ===
    fimul DWORD PTR [rax + rbx*1 + 0x10]
    fimul DWORD PTR [rbx]
    fimul DWORD PTR [rax]
    fimul DWORD PTR [rip + 0x1000]
    fimul DWORD PTR [rax + rbx*4 + 0x100]
    fimul DWORD PTR [rip + 0x100]

// === FIMUL m16int ===
    fimul WORD PTR [rax + rbx*1 + 0x10]
    fimul WORD PTR [rip + 0x1000]
    fimul WORD PTR [rbx]
    fimul WORD PTR [rip + 0x100]
    fimul WORD PTR [rax]
    fimul WORD PTR [rax + rbx*4 + 0x100]

// === FNOP ===
    fnop

// === FPATAN ===
    fpatan

// === FPREM ===
    fprem

// === FPREM1 ===
    fprem1

// === FPTAN ===
    fptan

// === FRNDINT ===
    frndint

// === FRSTOR m94/108byte ===
    frstor [rax]
    frstor [rbx]
    frstor [rax + rbx*1 + 0x10]
    frstor [rip + 0x100]
    frstor [rax + rbx*4 + 0x100]
    frstor [rip + 0x1000]

// === FSAVE m94/108byte ===
    fsave [rbx]
    fsave [rax + rbx*1 + 0x10]
    fsave [rax + rbx*4 + 0x100]
    fsave [rip + 0x1000]
    fsave [rip + 0x100]
    fsave [rax]

// === FNSAVE m94/108byte ===
    fnsave [rip + 0x100]
    fnsave [rbx]
    fnsave [rip + 0x1000]
    fnsave [rax]
    fnsave [rax + rbx*1 + 0x10]
    fnsave [rax + rbx*4 + 0x100]

// === FSCALE ===
    fscale

// === FSIN ===
    fsin

// === FSINCOS ===
    fsincos

// === FSQRT ===
    fsqrt

// === FST m32fp ===
    fst DWORD PTR [rbx]
    fst DWORD PTR [rip + 0x100]
    fst DWORD PTR [rax + rbx*4 + 0x100]
    fst DWORD PTR [rax]
    fst DWORD PTR [rax + rbx*1 + 0x10]
    fst DWORD PTR [rip + 0x1000]

// === FST m64fp ===
    fst QWORD PTR [rax + rbx*1 + 0x10]
    fst QWORD PTR [rip + 0x100]
    fst QWORD PTR [rbx]
    fst QWORD PTR [rax + rbx*4 + 0x100]
    fst QWORD PTR [rip + 0x1000]
    fst QWORD PTR [rax]

// === FST ST(i) ===
    fst st(2)
    fst st(3)
    fst st(1)
    fst st(0)

// === FSTP m32fp ===
    fstp DWORD PTR [rbx]
    fstp DWORD PTR [rax + rbx*4 + 0x100]
    fstp DWORD PTR [rax]
    fstp DWORD PTR [rip + 0x100]
    fstp DWORD PTR [rip + 0x1000]
    fstp DWORD PTR [rax + rbx*1 + 0x10]

// === FSTP m64fp ===
    fstp QWORD PTR [rip + 0x1000]
    fstp QWORD PTR [rip + 0x100]
    fstp QWORD PTR [rax + rbx*4 + 0x100]
    fstp QWORD PTR [rax]
    fstp QWORD PTR [rbx]
    fstp QWORD PTR [rax + rbx*1 + 0x10]

// === FSTP m80fp ===
    fstp TBYTE PTR [rip + 0x1000]
    fstp TBYTE PTR [rip + 0x100]
    fstp TBYTE PTR [rbx]
    fstp TBYTE PTR [rax + rbx*4 + 0x100]
    fstp TBYTE PTR [rax + rbx*1 + 0x10]
    fstp TBYTE PTR [rax]

// === FSTP ST(i) ===
    fstp st(0)
    fstp st(1)
    fstp st(2)
    fstp st(3)

// === FSTCW m2byte ===
    fstcw WORD PTR [rip + 0x100]
    fstcw WORD PTR [rax + rbx*1 + 0x10]
    fstcw WORD PTR [rip + 0x1000]
    fstcw WORD PTR [rax]
    fstcw WORD PTR [rax + rbx*4 + 0x100]
    fstcw WORD PTR [rbx]

// === FNSTCW m2byte ===
    fnstcw WORD PTR [rbx]
    fnstcw WORD PTR [rax + rbx*1 + 0x10]
    fnstcw WORD PTR [rip + 0x100]
    fnstcw WORD PTR [rip + 0x1000]
    fnstcw WORD PTR [rax]
    fnstcw WORD PTR [rax + rbx*4 + 0x100]

// === FSTENV m14/28byte ===
    fstenv [rax]
    fstenv [rax + rbx*4 + 0x100]
    fstenv [rax + rbx*1 + 0x10]
    fstenv [rip + 0x100]
    fstenv [rbx]
    fstenv [rip + 0x1000]

// === FNSTENV m14/28byte ===
    fnstenv [rax + rbx*1 + 0x10]
    fnstenv [rax + rbx*4 + 0x100]
    fnstenv [rip + 0x100]
    fnstenv [rip + 0x1000]
    fnstenv [rax]
    fnstenv [rbx]

// === FSTSW m2byte ===
    fstsw WORD PTR [rbx]
    fstsw WORD PTR [rax + rbx*4 + 0x100]
    fstsw WORD PTR [rax]
    fstsw WORD PTR [rip + 0x100]
    fstsw WORD PTR [rax + rbx*1 + 0x10]
    fstsw WORD PTR [rip + 0x1000]

// === FSTSW AX ===
    fstsw ax

// === FNSTSW m2byte ===
    fnstsw WORD PTR [rbx]
    fnstsw WORD PTR [rax]
    fnstsw WORD PTR [rip + 0x100]
    fnstsw WORD PTR [rax + rbx*1 + 0x10]
    fnstsw WORD PTR [rip + 0x1000]
    fnstsw WORD PTR [rax + rbx*4 + 0x100]

// === FNSTSW AX ===
    fnstsw ax

// === FSUB m32fp ===
    fsub DWORD PTR [rax + rbx*1 + 0x10]
    fsub DWORD PTR [rip + 0x1000]
    fsub DWORD PTR [rip + 0x100]
    fsub DWORD PTR [rax]
    fsub DWORD PTR [rax + rbx*4 + 0x100]
    fsub DWORD PTR [rbx]

// === FSUB m64fp ===
    fsub QWORD PTR [rax]
    fsub QWORD PTR [rip + 0x1000]
    fsub QWORD PTR [rax + rbx*1 + 0x10]
    fsub QWORD PTR [rbx]
    fsub QWORD PTR [rip + 0x100]
    fsub QWORD PTR [rax + rbx*4 + 0x100]

// === FSUB ST(0), ST(i) ===
    fsub st(0), st(0)
    fsub st(0), st(2)
    fsub st(0), st(1)
    fsub st(0), st(3)

// === FSUB ST(i), ST(0) ===
    fsub st(2), st(0)
    fsub st(1), st(0)
    fsub st(3), st(0)
    fsub st(0), st(0)

// === FSUBP ST(i), ST(0) ===
    fsubp st(3), st(0)
    fsubp st(1), st(0)
    fsubp st(0), st(0)
    fsubp st(2), st(0)

// === FSUBP ===
    fsubp

// === FISUB m32int ===
    fisub DWORD PTR [rax]
    fisub DWORD PTR [rip + 0x100]
    fisub DWORD PTR [rip + 0x1000]
    fisub DWORD PTR [rax + rbx*1 + 0x10]
    fisub DWORD PTR [rbx]
    fisub DWORD PTR [rax + rbx*4 + 0x100]

// === FISUB m16int ===
    fisub WORD PTR [rip + 0x1000]
    fisub WORD PTR [rax + rbx*1 + 0x10]
    fisub WORD PTR [rbx]
    fisub WORD PTR [rax + rbx*4 + 0x100]
    fisub WORD PTR [rax]
    fisub WORD PTR [rip + 0x100]

// === FSUBR m32fp ===
    fsubr DWORD PTR [rbx]
    fsubr DWORD PTR [rax + rbx*4 + 0x100]
    fsubr DWORD PTR [rax]
    fsubr DWORD PTR [rip + 0x1000]
    fsubr DWORD PTR [rip + 0x100]
    fsubr DWORD PTR [rax + rbx*1 + 0x10]

// === FSUBR m64fp ===
    fsubr QWORD PTR [rax + rbx*1 + 0x10]
    fsubr QWORD PTR [rip + 0x1000]
    fsubr QWORD PTR [rbx]
    fsubr QWORD PTR [rax + rbx*4 + 0x100]
    fsubr QWORD PTR [rax]
    fsubr QWORD PTR [rip + 0x100]

// === FSUBR ST(0), ST(i) ===
    fsubr st(0), st(1)
    fsubr st(0), st(3)
    fsubr st(0), st(2)
    fsubr st(0), st(0)

// === FSUBR ST(i), ST(0) ===
    fsubr st(1), st(0)
    fsubr st(2), st(0)
    fsubr st(3), st(0)
    fsubr st(0), st(0)

// === FSUBRP ST(i), ST(0) ===
    fsubrp st(2), st(0)
    fsubrp st(3), st(0)
    fsubrp st(1), st(0)
    fsubrp st(0), st(0)

// === FSUBRP ===
    fsubrp

// === FISUBR m32int ===
    fisubr DWORD PTR [rax]
    fisubr DWORD PTR [rbx]
    fisubr DWORD PTR [rax + rbx*1 + 0x10]
    fisubr DWORD PTR [rip + 0x100]
    fisubr DWORD PTR [rip + 0x1000]
    fisubr DWORD PTR [rax + rbx*4 + 0x100]

// === FISUBR m16int ===
    fisubr WORD PTR [rbx]
    fisubr WORD PTR [rip + 0x100]
    fisubr WORD PTR [rip + 0x1000]
    fisubr WORD PTR [rax]
    fisubr WORD PTR [rax + rbx*1 + 0x10]
    fisubr WORD PTR [rax + rbx*4 + 0x100]

// === FTST ===
    ftst

// === FUCOM ST(i) ===
    fucom st(3)
    fucom st(2)
    fucom st(1)
    fucom st(0)

// === FUCOM ===
    fucom

// === FUCOMP ST(i) ===
    fucomp st(0)
    fucomp st(2)
    fucomp st(3)
    fucomp st(1)

// === FUCOMP ===
    fucomp

// === FUCOMPP ===
    fucompp

// === FXAM ===
    fxam

// === FXCH ST(i) ===
    fxch st(2)
    fxch st(3)
    fxch st(1)
    fxch st(0)

// === FXCH ===
    fxch

// === FYL2X ===
    fyl2x

// === FYL2XP1 ===
    fyl2xp1

// === HLT ===
    hlt

// === IDIV r8 ===
    idiv al
    idiv bl
    idiv cl
    idiv dl

// === IDIV m8 ===
    idiv BYTE PTR [rbx]
    idiv BYTE PTR [rip + 0x1000]
    idiv BYTE PTR [rip + 0x100]
    idiv BYTE PTR [rax]
    idiv BYTE PTR [rax + rbx*4 + 0x100]
    idiv BYTE PTR [rax + rbx*1 + 0x10]

// === IDIV r16 ===
    idiv si
    idiv di
    idiv ax
    idiv cx
    idiv bx
    idiv dx

// === IDIV m16 ===
    idiv WORD PTR [rip + 0x100]
    idiv WORD PTR [rip + 0x1000]
    idiv WORD PTR [rax]
    idiv WORD PTR [rax + rbx*4 + 0x100]
    idiv WORD PTR [rbx]
    idiv WORD PTR [rax + rbx*1 + 0x10]

// === IDIV r32 ===
    idiv esi
    idiv eax
    idiv ebx
    idiv edx
    idiv edi
    idiv ecx

// === IDIV m32 ===
    idiv DWORD PTR [rip + 0x1000]
    idiv DWORD PTR [rbx]
    idiv DWORD PTR [rax]
    idiv DWORD PTR [rip + 0x100]
    idiv DWORD PTR [rax + rbx*4 + 0x100]
    idiv DWORD PTR [rax + rbx*1 + 0x10]

// === IDIV r64 ===
    idiv rdx
    idiv r9
    idiv rax
    idiv r12
    idiv rcx
    idiv rbx
    idiv r10
    idiv rdi
    idiv r8
    idiv rsi

// === IDIV m64 ===
    idiv QWORD PTR [rax]
    idiv QWORD PTR [rax + rbx*1 + 0x10]
    idiv QWORD PTR [rax + rbx*4 + 0x100]
    idiv QWORD PTR [rip + 0x100]
    idiv QWORD PTR [rbx]
    idiv QWORD PTR [rip + 0x1000]

// === IMUL r8 ===
    imul dl
    imul cl
    imul bl
    imul al

// === IMUL m8 ===
    imul BYTE PTR [rax]
    imul BYTE PTR [rax + rbx*1 + 0x10]
    imul BYTE PTR [rax + rbx*4 + 0x100]
    imul BYTE PTR [rip + 0x1000]
    imul BYTE PTR [rip + 0x100]
    imul BYTE PTR [rbx]

// === IMUL r16 ===
    imul dx
    imul si
    imul cx
    imul ax
    imul bx
    imul di

// === IMUL m16 ===
    imul WORD PTR [rax + rbx*1 + 0x10]
    imul WORD PTR [rax + rbx*4 + 0x100]
    imul WORD PTR [rbx]
    imul WORD PTR [rax]
    imul WORD PTR [rip + 0x1000]
    imul WORD PTR [rip + 0x100]

// === IMUL r32 ===
    imul edx
    imul ecx
    imul edi
    imul eax
    imul esi
    imul ebx

// === IMUL m32 ===
    imul DWORD PTR [rip + 0x100]
    imul DWORD PTR [rbx]
    imul DWORD PTR [rax]
    imul DWORD PTR [rax + rbx*1 + 0x10]
    imul DWORD PTR [rax + rbx*4 + 0x100]
    imul DWORD PTR [rip + 0x1000]

// === IMUL r64 ===
    imul r8
    imul r12
    imul rbx
    imul r10
    imul rdi
    imul r9
    imul rax
    imul r13
    imul r11
    imul rcx

// === IMUL m64 ===
    imul QWORD PTR [rax]
    imul QWORD PTR [rax + rbx*4 + 0x100]
    imul QWORD PTR [rbx]
    imul QWORD PTR [rip + 0x100]
    imul QWORD PTR [rip + 0x1000]
    imul QWORD PTR [rax + rbx*1 + 0x10]

// === IMUL r16, r16 ===
    imul dx, si
    imul cx, cx
    imul dx, cx
    imul ax, ax
    imul di, di
    imul cx, si
    imul di, dx
    imul bx, dx
    imul bx, cx
    imul bx, si

// === IMUL r16, m16 ===
    imul bx, WORD PTR [rip + 0x1000]
    imul bx, WORD PTR [rax + rbx*1 + 0x10]
    imul ax, WORD PTR [rbx]
    imul bx, WORD PTR [rax]
    imul si, WORD PTR [rip + 0x1000]
    imul si, WORD PTR [rax + rbx*1 + 0x10]
    imul bx, WORD PTR [rip + 0x100]
    imul dx, WORD PTR [rax]
    imul di, WORD PTR [rax + rbx*1 + 0x10]
    imul ax, WORD PTR [rax]

// === IMUL r32, r32 ===
    imul eax, ebx
    imul edi, ebx
    imul esi, ecx
    imul eax, ecx
    imul edi, edi
    imul esi, eax
    imul eax, esi
    imul ecx, eax
    imul eax, edx
    imul edx, edi

// === IMUL r32, m32 ===
    imul ecx, DWORD PTR [rip + 0x100]
    imul edi, DWORD PTR [rax]
    imul esi, DWORD PTR [rbx]
    imul ebx, DWORD PTR [rax + rbx*1 + 0x10]
    imul esi, DWORD PTR [rax + rbx*1 + 0x10]
    imul eax, DWORD PTR [rax]
    imul eax, DWORD PTR [rip + 0x100]
    imul edi, DWORD PTR [rax + rbx*4 + 0x100]
    imul edi, DWORD PTR [rip + 0x1000]
    imul edx, DWORD PTR [rax]

// === IMUL r64, r64 ===
    imul r12, rcx
    imul rsi, r11
    imul rbx, rbx
    imul r8, r11
    imul r11, rdx
    imul rsi, r13
    imul r9, r12
    imul r10, r9
    imul r9, r8
    imul rcx, r11

// === IMUL r64, m64 ===
    imul r9, QWORD PTR [rax + rbx*1 + 0x10]
    imul r13, QWORD PTR [rax + rbx*4 + 0x100]
    imul r9, QWORD PTR [rip + 0x100]
    imul rdx, QWORD PTR [rax]
    imul rcx, QWORD PTR [rax]
    imul r10, QWORD PTR [rbx]
    imul rbx, QWORD PTR [rip + 0x1000]
    imul r11, QWORD PTR [rip + 0x1000]
    imul r12, QWORD PTR [rbx]
    imul rax, QWORD PTR [rip + 0x1000]

// === IMUL r16, r16, imm8 ===
    imul ax, dx, 0xff
    imul dx, cx, 0xff
    imul si, dx, 0xff
    imul cx, cx, 0xff
    imul dx, bx, 0xff
    imul si, di, 0xff
    imul bx, ax, 0xff
    imul ax, bx, 0xff
    imul cx, di, 0xff
    imul cx, si, 0xff

// === IMUL r16, m16, imm8 ===
    imul dx, WORD PTR [rax + rbx*1 + 0x10], 0xff
    imul bx, WORD PTR [rax], 0xff
    imul bx, WORD PTR [rip + 0x100], 0xff
    imul di, WORD PTR [rax + rbx*1 + 0x10], 0xff
    imul ax, WORD PTR [rbx], 0xff
    imul si, WORD PTR [rbx], 0xff
    imul bx, WORD PTR [rip + 0x1000], 0xff
    imul si, WORD PTR [rip + 0x1000], 0xff
    imul ax, WORD PTR [rip + 0x100], 0xff
    imul dx, WORD PTR [rip + 0x1000], 0xff

// === IMUL r32, r32, imm8 ===
    imul ecx, eax, 0xff
    imul ebx, ecx, 0xff
    imul edi, eax, 0xff
    imul esi, esi, 0xff
    imul eax, edx, 0xff
    imul esi, ecx, 0xff
    imul ecx, edi, 0xff
    imul edx, edx, 0xff
    imul eax, ecx, 0xff
    imul edx, ecx, 0xff

// === IMUL r32, m32, imm8 ===
    imul edx, DWORD PTR [rip + 0x1000], 0xff
    imul edx, DWORD PTR [rax], 0xff
    imul ebx, DWORD PTR [rax], 0xff
    imul eax, DWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul ebx, DWORD PTR [rbx], 0xff
    imul edx, DWORD PTR [rbx], 0xff
    imul edi, DWORD PTR [rip + 0x1000], 0xff
    imul esi, DWORD PTR [rip + 0x100], 0xff
    imul eax, DWORD PTR [rax], 0xff
    imul edx, DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === IMUL r64, r64, imm8 ===
    imul r11, r13, 0xff
    imul r9, rbx, 0xff
    imul r11, r8, 0xff
    imul r10, rbx, 0xff
    imul rcx, r8, 0xff
    imul rbx, r8, 0xff
    imul r8, r12, 0xff
    imul r11, r9, 0xff
    imul rax, r9, 0xff
    imul rcx, rbx, 0xff

// === IMUL r64, m64, imm8 ===
    imul r9, QWORD PTR [rax], 0xff
    imul rbx, QWORD PTR [rax + rbx*1 + 0x10], 0xff
    imul r11, QWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul r9, QWORD PTR [rbx], 0xff
    imul r8, QWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul rsi, QWORD PTR [rip + 0x100], 0xff
    imul r10, QWORD PTR [rax + rbx*1 + 0x10], 0xff
    imul r13, QWORD PTR [rax], 0xff
    imul rdi, QWORD PTR [rax + rbx*1 + 0x10], 0xff
    imul r12, QWORD PTR [rax], 0xff

// === IMUL r16, r16, imm16 ===
    imul ax, dx, 0xffff
    imul bx, di, 0xffff
    imul si, dx, 0xffff
    imul dx, ax, 0xffff
    imul cx, cx, 0xffff
    imul si, di, 0xffff
    imul dx, si, 0xffff
    imul di, bx, 0xffff
    imul si, si, 0xffff
    imul cx, bx, 0xffff

// === IMUL r16, m16, imm16 ===
    imul cx, WORD PTR [rax], 0xffff
    imul di, WORD PTR [rbx], 0xffff
    imul ax, WORD PTR [rax], 0xffff
    imul dx, WORD PTR [rax + rbx*4 + 0x100], 0xffff
    imul dx, WORD PTR [rip + 0x1000], 0xffff
    imul bx, WORD PTR [rip + 0x100], 0xffff
    imul bx, WORD PTR [rbx], 0xffff
    imul cx, WORD PTR [rbx], 0xffff
    imul di, WORD PTR [rax + rbx*4 + 0x100], 0xffff
    imul dx, WORD PTR [rbx], 0xffff

// === IMUL r32, r32, imm32 ===
    imul eax, ecx, 0xffffffff
    imul ebx, ecx, 0xffffffff
    imul edx, edi, 0xffffffff
    imul edx, eax, 0xffffffff
    imul ebx, edi, 0xffffffff
    imul edx, edx, 0xffffffff
    imul edx, esi, 0xffffffff
    imul esi, edx, 0xffffffff
    imul edi, ecx, 0xffffffff
    imul ecx, eax, 0xffffffff

// === IMUL r32, m32, imm32 ===
    imul eax, DWORD PTR [rip + 0x1000], 0xffffffff
    imul edx, DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    imul esi, DWORD PTR [rip + 0x1000], 0xffffffff
    imul ebx, DWORD PTR [rip + 0x100], 0xffffffff
    imul ecx, DWORD PTR [rax], 0xffffffff
    imul edi, DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    imul eax, DWORD PTR [rip + 0x100], 0xffffffff
    imul esi, DWORD PTR [rax], 0xffffffff
    imul edx, DWORD PTR [rip + 0x1000], 0xffffffff
    imul edi, DWORD PTR [rax], 0xffffffff

// === IMUL r64, r64, imm32 ===
    imul r12, r8, 0x7fffffff
    imul r12, rcx, -1
    imul rcx, rdx, -1
    imul rdi, rax, -1
    imul r13, r12, -1
    imul rdx, rcx, 0x7fffffff
    imul r13, r8, 0x7fffffff
    imul rcx, r9, -1
    imul r8, r13, 0x7fffffff
    imul rsi, rax, -1

// === IMUL r64, m64, imm32 ===
    imul r13, QWORD PTR [rip + 0x100], 0x7fffffff
    imul r9, QWORD PTR [rax + rbx*1 + 0x10], -1
    imul r13, QWORD PTR [rax + rbx*1 + 0x10], -1
    imul r13, QWORD PTR [rax], 0x7fffffff
    imul rdx, QWORD PTR [rax], -1
    imul r12, QWORD PTR [rax], 0x7fffffff
    imul rsi, QWORD PTR [rax], 0x7fffffff
    imul r8, QWORD PTR [rax + rbx*4 + 0x100], -1
    imul rbx, QWORD PTR [rax + rbx*1 + 0x10], -1
    imul r9, QWORD PTR [rip + 0x100], -1

// === IN AL, imm8 ===
    in al, 0xff

// === IN AX, imm8 ===
    in ax, 0xff

// === IN EAX, imm8 ===
    in eax, 0xff

// === IN AL,DX ===
    in al, dx

// === IN AX,DX ===
    in ax, dx

// === IN EAX,DX ===
    in eax, dx

// === INC r8 ===
    inc cl
    inc al
    inc bl
    inc dl

// === INC m8 ===
    inc BYTE PTR [rax]
    inc BYTE PTR [rip + 0x100]
    inc BYTE PTR [rip + 0x1000]
    inc BYTE PTR [rax + rbx*1 + 0x10]
    inc BYTE PTR [rax + rbx*4 + 0x100]
    inc BYTE PTR [rbx]

// === INC r16 ===
    inc cx
    inc si
    inc di
    inc dx
    inc ax
    inc bx

// === INC m16 ===
    inc WORD PTR [rax + rbx*4 + 0x100]
    inc WORD PTR [rip + 0x100]
    inc WORD PTR [rax + rbx*1 + 0x10]
    inc WORD PTR [rax]
    inc WORD PTR [rbx]
    inc WORD PTR [rip + 0x1000]

// === INC r32 ===
    inc ebx
    inc edi
    inc edx
    inc esi
    inc ecx
    inc eax

// === INC m32 ===
    inc DWORD PTR [rax]
    inc DWORD PTR [rax + rbx*1 + 0x10]
    inc DWORD PTR [rip + 0x1000]
    inc DWORD PTR [rip + 0x100]
    inc DWORD PTR [rbx]
    inc DWORD PTR [rax + rbx*4 + 0x100]

// === INC r64 ===
    inc r12
    inc r9
    inc r8
    inc rdi
    inc r13
    inc rcx
    inc rax
    inc rsi
    inc rbx
    inc r10

// === INC m64 ===
    inc QWORD PTR [rax]
    inc QWORD PTR [rbx]
    inc QWORD PTR [rip + 0x1000]
    inc QWORD PTR [rip + 0x100]
    inc QWORD PTR [rax + rbx*1 + 0x10]
    inc QWORD PTR [rax + rbx*4 + 0x100]

// === INS m8, DX ===
    ins BYTE PTR [rdi], dx

// === INS m16, DX ===
    ins WORD PTR [rdi], dx

// === INS m32, DX ===
    ins DWORD PTR [rdi], dx

// === INSB ===
    insb

// === INSW ===
    insw

// === INSD ===
    insd

// === INT3 ===
    int3

// === INT imm8 ===
    int 0xff

// === INT1 ===
    int1

// === INVD ===
    invd

// === INVLPG m ===
    invlpg [rbx]
    invlpg [rip + 0x1000]
    invlpg [rax + rbx*4 + 0x100]
    invlpg [rax + rbx*1 + 0x10]
    invlpg [rip + 0x100]
    invlpg [rax]

// === IRETQ ===
    iretq

// === JA rel8 ===
    ja 0f
0:

// === JAE rel8 ===
    jae 0f
0:

// === JB rel8 ===
    jb 0f
0:

// === JBE rel8 ===
    jbe 0f
0:

// === JC rel8 ===
    jc 0f
0:

// === JRCXZ rel8 ===
    jrcxz 0f
0:

// === JE rel8 ===
    je 0f
0:

// === JG rel8 ===
    jg 0f
0:

// === JGE rel8 ===
    jge 0f
0:

// === JL rel8 ===
    jl 0f
0:

// === JLE rel8 ===
    jle 0f
0:

// === JNA rel8 ===
    jna 0f
0:

// === JNAE rel8 ===
    jnae 0f
0:

// === JNB rel8 ===
    jnb 0f
0:

// === JNBE rel8 ===
    jnbe 0f
0:

// === JNC rel8 ===
    jnc 0f
0:

// === JNE rel8 ===
    jne 0f
0:

// === JNG rel8 ===
    jng 0f
0:

// === JNGE rel8 ===
    jnge 0f
0:

// === JNL rel8 ===
    jnl 0f
0:

// === JNLE rel8 ===
    jnle 0f
0:

// === JNO rel8 ===
    jno 0f
0:

// === JNP rel8 ===
    jnp 0f
0:

// === JNS rel8 ===
    jns 0f
0:

// === JNZ rel8 ===
    jnz 0f
0:

// === JO rel8 ===
    jo 0f
0:

// === JP rel8 ===
    jp 0f
0:

// === JPE rel8 ===
    jpe 0f
0:

// === JPO rel8 ===
    jpo 0f
0:

// === JS rel8 ===
    js 0f
0:

// === JZ rel8 ===
    jz 0f
0:

// === JA rel32 ===
    ja 0f
0:

// === JAE rel32 ===
    jae 0f
0:

// === JB rel32 ===
    jb 0f
0:

// === JBE rel32 ===
    jbe 0f
0:

// === JC rel32 ===
    jc 0f
0:

// === JE rel32 ===
    je 0f
0:

// === JZ rel32 ===
    jz 0f
0:

// === JG rel32 ===
    jg 0f
0:

// === JGE rel32 ===
    jge 0f
0:

// === JL rel32 ===
    jl 0f
0:

// === JLE rel32 ===
    jle 0f
0:

// === JNA rel32 ===
    jna 0f
0:

// === JNAE rel32 ===
    jnae 0f
0:

// === JNB rel32 ===
    jnb 0f
0:

// === JNBE rel32 ===
    jnbe 0f
0:

// === JNC rel32 ===
    jnc 0f
0:

// === JNE rel32 ===
    jne 0f
0:

// === JNG rel32 ===
    jng 0f
0:

// === JNGE rel32 ===
    jnge 0f
0:

// === JNL rel32 ===
    jnl 0f
0:

// === JNLE rel32 ===
    jnle 0f
0:

// === JNO rel32 ===
    jno 0f
0:

// === JNP rel32 ===
    jnp 0f
0:

// === JNS rel32 ===
    jns 0f
0:

// === JNZ rel32 ===
    jnz 0f
0:

// === JO rel32 ===
    jo 0f
0:

// === JP rel32 ===
    jp 0f
0:

// === JPE rel32 ===
    jpe 0f
0:

// === JPO rel32 ===
    jpo 0f
0:

// === JS rel32 ===
    js 0f
0:

// === JMP rel8 ===
    jmp 0f
0:

// === JMP rel32 ===
    jmp 0f
0:

// === JMP r64 ===
    jmp r12
    jmp r11
    jmp rcx
    jmp r10
    jmp r13
    jmp rsi
    jmp rax
    jmp r8
    jmp rdi
    jmp rdx

// === JMP m64 ===
    jmp QWORD PTR [rbx]
    jmp QWORD PTR [rip + 0x100]
    jmp QWORD PTR [rax + rbx*1 + 0x10]
    jmp QWORD PTR [rax + rbx*4 + 0x100]
    jmp QWORD PTR [rip + 0x1000]
    jmp QWORD PTR [rax]

// === LAHF ===
    lahf

// === LAR r16, r16/m16 ===
    lar di, bx
    lar di, di
    lar si, di
    lar si, dx
    lar ax, WORD PTR [rax + rbx*1 + 0x10]
    lar cx, WORD PTR [rbx]
    lar si, WORD PTR [rip + 0x1000]
    lar dx, di
    lar ax, WORD PTR [rax]
    lar cx, si

// === LAR r32, r32/m16 ===
    lar edx, WORD PTR [rax + rbx*1 + 0x10]
    lar ecx, WORD PTR [rax + rbx*1 + 0x10]
    lar esi, esi
    lar edi, esi
    lar ebx, WORD PTR [rax + rbx*4 + 0x100]
    lar edx, WORD PTR [rax]
    lar ebx, ebx
    lar edi, WORD PTR [rip + 0x1000]
    lar eax, WORD PTR [rax + rbx*1 + 0x10]
    lar esi, WORD PTR [rip + 0x1000]

// === LSS r16,m16:16 ===
    lss di, DWORD PTR [rax + rbx*4 + 0x100]
    lss cx, DWORD PTR [rip + 0x100]
    lss cx, DWORD PTR [rip + 0x1000]
    lss di, DWORD PTR [rax + rbx*1 + 0x10]
    lss bx, DWORD PTR [rax]
    lss si, DWORD PTR [rip + 0x1000]
    lss di, DWORD PTR [rip + 0x100]
    lss di, DWORD PTR [rax]
    lss bx, DWORD PTR [rip + 0x100]
    lss di, DWORD PTR [rip + 0x1000]

// === LSS r32,m16:32 ===
    lss edi, FWORD PTR [rax + rbx*1 + 0x10]
    lss eax, FWORD PTR [rip + 0x100]
    lss eax, FWORD PTR [rax + rbx*1 + 0x10]
    lss edx, FWORD PTR [rax + rbx*4 + 0x100]
    lss edx, FWORD PTR [rip + 0x1000]
    lss edx, FWORD PTR [rbx]
    lss ecx, FWORD PTR [rip + 0x1000]
    lss edi, FWORD PTR [rax + rbx*4 + 0x100]
    lss ebx, FWORD PTR [rax + rbx*4 + 0x100]
    lss ebx, FWORD PTR [rbx]

// === LSS r64,m16:64 ===
    lss r11, TBYTE PTR [rip + 0x1000]
    lss rcx, TBYTE PTR [rax + rbx*1 + 0x10]
    lss rbx, TBYTE PTR [rax + rbx*1 + 0x10]
    lss rbx, TBYTE PTR [rbx]
    lss rsi, TBYTE PTR [rip + 0x1000]
    lss rax, TBYTE PTR [rax]
    lss r9, TBYTE PTR [rax + rbx*1 + 0x10]
    lss r12, TBYTE PTR [rax + rbx*4 + 0x100]
    lss r12, TBYTE PTR [rip + 0x1000]
    lss r8, TBYTE PTR [rax + rbx*1 + 0x10]

// === LFS r16,m16:16 ===
    lfs ax, DWORD PTR [rbx]
    lfs cx, DWORD PTR [rip + 0x1000]
    lfs cx, DWORD PTR [rax]
    lfs si, DWORD PTR [rip + 0x100]
    lfs si, DWORD PTR [rax]
    lfs di, DWORD PTR [rip + 0x1000]
    lfs dx, DWORD PTR [rax + rbx*1 + 0x10]
    lfs si, DWORD PTR [rax + rbx*4 + 0x100]
    lfs di, DWORD PTR [rax + rbx*4 + 0x100]
    lfs bx, DWORD PTR [rip + 0x100]

// === LFS r32,m16:32 ===
    lfs edx, FWORD PTR [rip + 0x1000]
    lfs esi, FWORD PTR [rax + rbx*4 + 0x100]
    lfs ecx, FWORD PTR [rax]
    lfs edx, FWORD PTR [rip + 0x100]
    lfs ebx, FWORD PTR [rip + 0x100]
    lfs edi, FWORD PTR [rax + rbx*1 + 0x10]
    lfs edi, FWORD PTR [rbx]
    lfs ecx, FWORD PTR [rbx]
    lfs edi, FWORD PTR [rax + rbx*4 + 0x100]
    lfs ecx, FWORD PTR [rip + 0x1000]

// === LFS r64,m16:64 ===
    lfs r9, TBYTE PTR [rax]
    lfs rsi, TBYTE PTR [rax + rbx*4 + 0x100]
    lfs rdi, TBYTE PTR [rax + rbx*4 + 0x100]
    lfs rbx, TBYTE PTR [rip + 0x1000]
    lfs r9, TBYTE PTR [rbx]
    lfs r12, TBYTE PTR [rax + rbx*4 + 0x100]
    lfs r9, TBYTE PTR [rip + 0x1000]
    lfs r12, TBYTE PTR [rax]
    lfs r10, TBYTE PTR [rip + 0x1000]
    lfs r11, TBYTE PTR [rip + 0x1000]

// === LGS r16,m16:16 ===
    lgs bx, DWORD PTR [rax]
    lgs dx, DWORD PTR [rax]
    lgs si, DWORD PTR [rip + 0x100]
    lgs di, DWORD PTR [rip + 0x100]
    lgs ax, DWORD PTR [rip + 0x100]
    lgs si, DWORD PTR [rbx]
    lgs si, DWORD PTR [rax + rbx*4 + 0x100]
    lgs bx, DWORD PTR [rax + rbx*1 + 0x10]
    lgs cx, DWORD PTR [rip + 0x1000]
    lgs bx, DWORD PTR [rbx]

// === LGS r32,m16:32 ===
    lgs ecx, FWORD PTR [rip + 0x100]
    lgs edx, FWORD PTR [rip + 0x100]
    lgs esi, FWORD PTR [rax + rbx*4 + 0x100]
    lgs eax, FWORD PTR [rip + 0x1000]
    lgs ebx, FWORD PTR [rbx]
    lgs eax, FWORD PTR [rbx]
    lgs edi, FWORD PTR [rax + rbx*1 + 0x10]
    lgs ecx, FWORD PTR [rax + rbx*4 + 0x100]
    lgs ecx, FWORD PTR [rax]
    lgs edi, FWORD PTR [rax + rbx*4 + 0x100]

// === LGS r64,m16:64 ===
    lgs rbx, TBYTE PTR [rip + 0x1000]
    lgs r8, TBYTE PTR [rax + rbx*4 + 0x100]
    lgs r11, TBYTE PTR [rip + 0x1000]
    lgs r12, TBYTE PTR [rax + rbx*1 + 0x10]
    lgs rdi, TBYTE PTR [rip + 0x100]
    lgs rsi, TBYTE PTR [rip + 0x100]
    lgs rdx, TBYTE PTR [rip + 0x1000]
    lgs rax, TBYTE PTR [rax + rbx*4 + 0x100]
    lgs rsi, TBYTE PTR [rax]
    lgs rdx, TBYTE PTR [rip + 0x100]

// === LEA r16,m ===
    lea si, [rax]
    lea di, [rax + rbx*1 + 0x10]
    lea cx, [rip + 0x1000]
    lea bx, [rbx]
    lea si, [rip + 0x100]
    lea dx, [rax + rbx*1 + 0x10]
    lea bx, [rip + 0x1000]
    lea cx, [rax + rbx*4 + 0x100]
    lea dx, [rbx]
    lea si, [rax + rbx*4 + 0x100]

// === LEA r32,m ===
    lea eax, [rax]
    lea edi, [rax + rbx*4 + 0x100]
    lea eax, [rip + 0x1000]
    lea ebx, [rip + 0x100]
    lea edx, [rax]
    lea esi, [rbx]
    lea esi, [rip + 0x100]
    lea ebx, [rax]
    lea edx, [rax + rbx*4 + 0x100]
    lea edi, [rbx]

// === LEA r64,m ===
    lea r13, [rip + 0x1000]
    lea rcx, [rip + 0x1000]
    lea rsi, [rax]
    lea r8, [rax + rbx*1 + 0x10]
    lea r8, [rax + rbx*4 + 0x100]
    lea rdx, [rip + 0x100]
    lea r12, [rip + 0x1000]
    lea r8, [rip + 0x100]
    lea r13, [rax]
    lea rdi, [rax + rbx*4 + 0x100]

// === LEAVE ===
    leave

// === LGDT m16&64 ===
    lgdt [rax]
    lgdt [rbx]
    lgdt [rip + 0x100]

// === LIDT m16&64 ===
    lidt [rax]
    lidt [rbx]
    lidt [rip + 0x100]

// === LKGS r16 ===
    lkgs ax
    lkgs dx
    lkgs bx
    lkgs di
    lkgs cx
    lkgs si

// === LKGS m16 ===
    lkgs WORD PTR [rax]
    lkgs WORD PTR [rax + rbx*1 + 0x10]
    lkgs WORD PTR [rax + rbx*4 + 0x100]
    lkgs WORD PTR [rip + 0x100]
    lkgs WORD PTR [rbx]
    lkgs WORD PTR [rip + 0x1000]

// === LLDT r16 ===
    lldt ax
    lldt di
    lldt si
    lldt cx
    lldt dx
    lldt bx

// === LLDT m16 ===
    lldt WORD PTR [rip + 0x100]
    lldt WORD PTR [rip + 0x1000]
    lldt WORD PTR [rax + rbx*1 + 0x10]
    lldt WORD PTR [rax]
    lldt WORD PTR [rax + rbx*4 + 0x100]
    lldt WORD PTR [rbx]

// === LMSW r16 ===
    lmsw cx
    lmsw bx
    lmsw ax
    lmsw si
    lmsw di
    lmsw dx

// === LMSW m16 ===
    lmsw WORD PTR [rax + rbx*4 + 0x100]
    lmsw WORD PTR [rip + 0x1000]
    lmsw WORD PTR [rbx]
    lmsw WORD PTR [rax]
    lmsw WORD PTR [rip + 0x100]
    lmsw WORD PTR [rax + rbx*1 + 0x10]

// === LOCK ===
    lock

// === LODS m8 ===
    lods BYTE PTR [rsi]

// === LODS m16 ===
    lods WORD PTR [rsi]

// === LODS m32 ===
    lods DWORD PTR [rsi]

// === LODS m64 ===
    lods QWORD PTR [rsi]

// === LODSB ===
    lodsb

// === LODSW ===
    lodsw

// === LODSD ===
    lodsd

// === LODSQ ===
    lodsq

// === LOOP rel8 ===
    loop 0f
0:

// === LOOPE rel8 ===
    loope 0f
0:

// === LOOPNE rel8 ===
    loopne 0f
0:

// === LSL r16, r16/m16 ===
    lsl bx, bx
    lsl cx, WORD PTR [rax + rbx*1 + 0x10]
    lsl si, WORD PTR [rbx]
    lsl cx, di
    lsl di, ax
    lsl di, dx
    lsl ax, di
    lsl bx, dx
    lsl cx, cx
    lsl di, WORD PTR [rip + 0x1000]

// === LSL r32, r32/m16 ===
    lsl ecx, edx
    lsl ebx, ecx
    lsl eax, WORD PTR [rax + rbx*1 + 0x10]
    lsl edi, WORD PTR [rip + 0x100]
    lsl eax, ecx
    lsl edi, WORD PTR [rbx]
    lsl edi, esi
    lsl esi, WORD PTR [rax + rbx*4 + 0x100]
    lsl ebx, WORD PTR [rax + rbx*4 + 0x100]
    lsl eax, WORD PTR [rax + rbx*4 + 0x100]

// === LSL r64, r32/m16 ===
    lsl rax, eax
    lsl r13, ebx
    lsl rbx, ecx
    lsl r10, esi
    lsl rax, ebx
    lsl r13, WORD PTR [rbx]
    lsl rcx, edx
    lsl rsi, WORD PTR [rip + 0x1000]
    lsl rsi, WORD PTR [rax]
    lsl r9, WORD PTR [rip + 0x100]

// === LTR r16 ===
    ltr di
    ltr si
    ltr cx
    ltr bx
    ltr dx
    ltr ax

// === LTR m16 ===
    ltr WORD PTR [rip + 0x1000]
    ltr WORD PTR [rax + rbx*1 + 0x10]
    ltr WORD PTR [rax]
    ltr WORD PTR [rax + rbx*4 + 0x100]
    ltr WORD PTR [rip + 0x100]
    ltr WORD PTR [rbx]

// === MONITOR ===
    monitor

// === MOV r8, r8 ===
    mov dl, cl
    mov cl, al
    mov al, bl
    mov cl, cl
    mov al, dl
    mov bl, cl
    mov bl, bl
    mov cl, dl
    mov dl, bl
    mov bl, dl

// === MOV m8, r8 ===
    mov BYTE PTR [rbx], bl
    mov BYTE PTR [rax + rbx*4 + 0x100], dl
    mov BYTE PTR [rip + 0x100], cl
    mov BYTE PTR [rax + rbx*1 + 0x10], al
    mov BYTE PTR [rip + 0x100], al
    mov BYTE PTR [rax + rbx*4 + 0x100], bl
    mov BYTE PTR [rax], bl
    mov BYTE PTR [rbx], dl
    mov BYTE PTR [rax + rbx*1 + 0x10], bl
    mov BYTE PTR [rax + rbx*1 + 0x10], dl

// === MOV r16, r16 ===
    mov ax, cx
    mov bx, si
    mov dx, dx
    mov ax, si
    mov dx, ax
    mov cx, si
    mov si, si
    mov cx, ax
    mov di, ax
    mov si, cx

// === MOV m16, r16 ===
    mov WORD PTR [rax], cx
    mov WORD PTR [rip + 0x100], dx
    mov WORD PTR [rbx], dx
    mov WORD PTR [rip + 0x100], di
    mov WORD PTR [rip + 0x1000], si
    mov WORD PTR [rax + rbx*1 + 0x10], cx
    mov WORD PTR [rax + rbx*4 + 0x100], ax
    mov WORD PTR [rip + 0x100], si
    mov WORD PTR [rip + 0x1000], ax
    mov WORD PTR [rip + 0x1000], bx

// === MOV r32, r32 ===
    mov ecx, esi
    mov edi, ebx
    mov edi, eax
    mov edi, edx
    mov edx, ecx
    mov ecx, edi
    mov eax, edi
    mov ebx, edi
    mov eax, eax
    mov esi, ebx

// === MOV m32, r32 ===
    mov DWORD PTR [rip + 0x100], esi
    mov DWORD PTR [rip + 0x100], ebx
    mov DWORD PTR [rip + 0x100], ecx
    mov DWORD PTR [rax + rbx*4 + 0x100], ebx
    mov DWORD PTR [rax + rbx*4 + 0x100], esi
    mov DWORD PTR [rip + 0x1000], edx
    mov DWORD PTR [rip + 0x100], edi
    mov DWORD PTR [rax], eax
    mov DWORD PTR [rip + 0x100], edx
    mov DWORD PTR [rbx], ebx

// === MOV r64, r64 ===
    mov rdx, rbx
    mov rsi, rcx
    mov rbx, rbx
    mov r12, rcx
    mov rdi, rdx
    mov rsi, rax
    mov rsi, rsi
    mov rsi, r12
    mov r9, rcx
    mov r13, rbx

// === MOV m64, r64 ===
    mov QWORD PTR [rbx], rdi
    mov QWORD PTR [rip + 0x100], r8
    mov QWORD PTR [rax + rbx*4 + 0x100], r9
    mov QWORD PTR [rip + 0x100], r13
    mov QWORD PTR [rax + rbx*1 + 0x10], r8
    mov QWORD PTR [rax], rbx
    mov QWORD PTR [rbx], r11
    mov QWORD PTR [rbx], r13
    mov QWORD PTR [rax + rbx*1 + 0x10], rdx
    mov QWORD PTR [rip + 0x100], rdx

// === MOV r8, m8 ===
    mov al, BYTE PTR [rip + 0x1000]
    mov cl, BYTE PTR [rax + rbx*4 + 0x100]
    mov bl, BYTE PTR [rbx]
    mov al, BYTE PTR [rax + rbx*4 + 0x100]
    mov bl, BYTE PTR [rax + rbx*4 + 0x100]
    mov al, BYTE PTR [rax]
    mov cl, BYTE PTR [rax]
    mov bl, BYTE PTR [rax + rbx*1 + 0x10]
    mov dl, BYTE PTR [rax]
    mov cl, BYTE PTR [rax + rbx*1 + 0x10]

// === MOV r16, m16 ===
    mov cx, WORD PTR [rax + rbx*1 + 0x10]
    mov cx, WORD PTR [rax]
    mov si, WORD PTR [rax + rbx*1 + 0x10]
    mov ax, WORD PTR [rbx]
    mov di, WORD PTR [rbx]
    mov bx, WORD PTR [rip + 0x1000]
    mov bx, WORD PTR [rax + rbx*4 + 0x100]
    mov dx, WORD PTR [rax + rbx*1 + 0x10]
    mov ax, WORD PTR [rip + 0x100]
    mov si, WORD PTR [rax]

// === MOV r32, m32 ===
    mov ebx, DWORD PTR [rax]
    mov eax, DWORD PTR [rax + rbx*1 + 0x10]
    mov edi, DWORD PTR [rax + rbx*1 + 0x10]
    mov edi, DWORD PTR [rax]
    mov ecx, DWORD PTR [rip + 0x100]
    mov ebx, DWORD PTR [rip + 0x1000]
    mov esi, DWORD PTR [rax + rbx*1 + 0x10]
    mov ebx, DWORD PTR [rax + rbx*4 + 0x100]
    mov ecx, DWORD PTR [rax + rbx*4 + 0x100]
    mov esi, DWORD PTR [rip + 0x1000]

// === MOV r64, m64 ===
    mov rdi, QWORD PTR [rax + rbx*4 + 0x100]
    mov rbx, QWORD PTR [rip + 0x1000]
    mov r10, QWORD PTR [rax + rbx*1 + 0x10]
    mov rbx, QWORD PTR [rbx]
    mov rax, QWORD PTR [rax + rbx*1 + 0x10]
    mov rsi, QWORD PTR [rax]
    mov rsi, QWORD PTR [rip + 0x100]
    mov rdx, QWORD PTR [rax + rbx*1 + 0x10]
    mov rdi, QWORD PTR [rip + 0x1000]
    mov r13, QWORD PTR [rax + rbx*4 + 0x100]

// === MOV r16, Sreg ===
    mov dx, gs
    mov bx, es
    mov cx, cs
    mov bx, ss
    mov bx, cs
    mov cx, ss
    mov dx, cs
    mov dx, fs
    mov si, cs
    mov si, ss

// === MOV m16, Sreg ===
    mov WORD PTR [rax + rbx*1 + 0x10], ds
    mov WORD PTR [rip + 0x100], ss
    mov WORD PTR [rbx], gs
    mov WORD PTR [rax + rbx*1 + 0x10], ss
    mov WORD PTR [rax + rbx*4 + 0x100], ss
    mov WORD PTR [rip + 0x100], es
    mov WORD PTR [rax + rbx*4 + 0x100], fs
    mov WORD PTR [rax + rbx*1 + 0x10], cs
    mov WORD PTR [rax + rbx*1 + 0x10], es
    mov WORD PTR [rax + rbx*4 + 0x100], es

// === MOV r16/r32/m16, Sreg ===
    mov ecx, ss
    mov esi, ds
    mov cx, ds
    mov WORD PTR [rip + 0x100], fs
    mov WORD PTR [rax + rbx*4 + 0x100], gs
    mov si, ds
    mov WORD PTR [rbx], ds
    mov WORD PTR [rax + rbx*4 + 0x100], ss
    mov WORD PTR [rip + 0x1000], es
    mov si, ss

// === MOV r64/m16, Sreg ===
    mov r8, fs
    mov r11, cs
    mov r12, ss
    mov rcx, fs
    mov r13, fs
    mov r9, ds
    mov rsi, gs
    mov rdx, ds
    mov WORD PTR [rip + 0x100], cs
    mov r11, ds

// === MOV Sreg, r16 ===
    mov cs, di
    mov cs, bx
    mov gs, dx
    mov ss, bx
    mov ss, cx
    mov ss, ax
    mov ds, dx
    mov fs, bx
    mov gs, cx
    mov ds, bx

// === MOV Sreg, m16 ===
    mov ss, WORD PTR [rip + 0x1000]
    mov es, WORD PTR [rbx]
    mov gs, WORD PTR [rbx]
    mov ds, WORD PTR [rax + rbx*4 + 0x100]
    mov fs, WORD PTR [rax + rbx*1 + 0x10]
    mov ss, WORD PTR [rax + rbx*1 + 0x10]
    mov ds, WORD PTR [rip + 0x1000]
    mov cs, WORD PTR [rip + 0x100]
    mov ss, WORD PTR [rax]
    mov gs, WORD PTR [rip + 0x100]

// === MOV Sreg, r64 ===
    mov ss, rbx
    mov fs, r12
    mov ds, rbx
    mov cs, r8
    mov cs, rbx
    mov ss, rcx
    mov es, r13
    mov cs, rdx
    mov fs, rax
    mov ds, r8

// === MOV Sreg, m64 ===
    mov cs, WORD PTR [rip + 0x100]
    mov ds, WORD PTR [rax + rbx*4 + 0x100]
    mov gs, WORD PTR [rax]
    mov es, WORD PTR [rip + 0x1000]
    mov fs, WORD PTR [rip + 0x1000]
    mov gs, WORD PTR [rax + rbx*1 + 0x10]
    mov gs, WORD PTR [rip + 0x100]
    mov fs, WORD PTR [rax + rbx*1 + 0x10]
    mov ss, WORD PTR [rax + rbx*1 + 0x10]
    mov ss, WORD PTR [rbx]

// === MOV AL, moffs8 ===
    mov al, [0x1000]

// === MOV AX, moffs16 ===
    mov ax, [0x1000]

// === MOV EAX, moffs32 ===
    mov eax, [0x1000]

// === MOV RAX, moffs64 ===
    mov rax, [0x1000]

// === MOV moffs8, AL ===
    mov [0x1000], al

// === MOV moffs16, AX ===
    mov [0x1000], ax

// === MOV moffs32, EAX ===
    mov [0x1000], eax

// === MOV moffs64, RAX ===
    mov [0x1000], rax

// === MOV r8, imm8 ===
    mov dl, 0xff
    mov al, 0xff
    mov cl, 0xff
    mov bl, 0xff

// === MOV r16, imm16 ===
    mov dx, 0xffff
    mov bx, 0xffff
    mov si, 0xffff
    mov di, 0xffff
    mov ax, 0xffff
    mov cx, 0xffff

// === MOV r32, imm32 ===
    mov esi, 0xffffffff
    mov ecx, 0xffffffff
    mov edx, 0xffffffff
    mov ebx, 0xffffffff
    mov eax, 0xffffffff
    mov edi, 0xffffffff

// === MOV r64, imm64 ===
    mov r11, 0x7fffffffffffffff
    mov r8, 0x7fffffffffffffff
    mov rdi, 0x7fffffffffffffff
    mov r9, 0x7fffffffffffffff
    mov rax, 0x7fffffffffffffff
    mov rbx, 0x7fffffffffffffff
    mov rdx, 0x7fffffffffffffff
    mov rcx, 0x7fffffffffffffff
    mov rsi, 0x7fffffffffffffff
    mov r12, 0x7fffffffffffffff

// === MOV m8, imm8 ===
    mov BYTE PTR [rax], 0xff
    mov BYTE PTR [rax + rbx*1 + 0x10], 0xff
    mov BYTE PTR [rax + rbx*4 + 0x100], 0xff
    mov BYTE PTR [rbx], 0xff
    mov BYTE PTR [rip + 0x1000], 0xff
    mov BYTE PTR [rip + 0x100], 0xff

// === MOV m16, imm16 ===
    mov WORD PTR [rax + rbx*4 + 0x100], 0xffff
    mov WORD PTR [rip + 0x100], 0xffff
    mov WORD PTR [rax], 0xffff
    mov WORD PTR [rax + rbx*1 + 0x10], 0xffff
    mov WORD PTR [rip + 0x1000], 0xffff
    mov WORD PTR [rbx], 0xffff

// === MOV m32, imm32 ===
    mov DWORD PTR [rip + 0x1000], 0xffffffff
    mov DWORD PTR [rbx], 0xffffffff
    mov DWORD PTR [rip + 0x100], 0xffffffff
    mov DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    mov DWORD PTR [rax], 0xffffffff
    mov DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === MOV r64, imm32 ===
    mov rdx, 0x7fffffff
    mov rsi, 0x7fffffff
    mov rax, 0x7fffffff
    mov r9, 0x7fffffff
    mov rbx, 0x7fffffff
    mov r8, -1
    mov r10, 0x7fffffff
    mov r10, -1
    mov rcx, -1
    mov rdi, -1

// === MOV m64, imm32 ===
    mov QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    mov QWORD PTR [rip + 0x1000], 0x7fffffff
    mov QWORD PTR [rip + 0x1000], -1
    mov QWORD PTR [rax + rbx*1 + 0x10], -1
    mov QWORD PTR [rip + 0x100], -1
    mov QWORD PTR [rax], 0x7fffffff
    mov QWORD PTR [rax + rbx*4 + 0x100], -1
    mov QWORD PTR [rip + 0x100], 0x7fffffff
    mov QWORD PTR [rbx], 0x7fffffff
    mov QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff

// === MOV r64, CR0–CR7 ===
    mov r13, cr0
    mov rcx, cr4
    mov r10, cr0
    mov r8, cr0
    mov rdx, cr0
    mov rbx, cr4
    mov r10, cr3
    mov rdi, cr4
    mov r8, cr3
    mov r9, cr2

// === MOV r64, CR8 ===
    mov rax, cr8
    mov r9, cr8
    mov r12, cr8
    mov rdx, cr8
    mov rsi, cr8
    mov rcx, cr8
    mov r13, cr8
    mov r10, cr8
    mov r8, cr8
    mov r11, cr8

// === MOV CR0–CR7, r64 ===
    mov cr4, r9
    mov cr3, r11
    mov cr0, r11
    mov cr3, r9
    mov cr0, rcx
    mov cr3, rax
    mov cr2, r9
    mov cr0, rax
    mov cr0, rbx
    mov cr0, r8

// === MOV CR8, r64 ===
    mov cr8, rdx
    mov cr8, r9
    mov cr8, rsi
    mov cr8, rcx
    mov cr8, rax
    mov cr8, rbx
    mov cr8, r12
    mov cr8, r13
    mov cr8, r11
    mov cr8, rdi

// === MOV r64, DR0–DR7 ===
    mov r12, dr3
    mov rcx, dr6
    mov r10, dr2
    mov rsi, dr0
    mov r9, dr7
    mov rbx, dr2
    mov r11, dr7
    mov rbx, dr6
    mov rbx, dr3
    mov rcx, dr0

// === MOV DR0–DR7, r64 ===
    mov dr2, rcx
    mov dr6, rdx
    mov dr6, r12
    mov dr1, rdx
    mov dr7, rbx
    mov dr2, rbx
    mov dr7, rax
    mov dr2, r12
    mov dr3, r10
    mov dr3, rbx

// === MOVDQ2Q mm, xmm ===
    movdq2q mm2, xmm3
    movdq2q mm0, xmm1
    movdq2q mm1, xmm0
    movdq2q mm3, xmm3
    movdq2q mm3, xmm0
    movdq2q mm2, xmm2
    movdq2q mm2, xmm0
    movdq2q mm0, xmm2
    movdq2q mm1, xmm1
    movdq2q mm3, xmm2

// === MOVNTQ m64, mm ===
    movntq QWORD PTR [rax + rbx*4 + 0x100], mm2
    movntq QWORD PTR [rip + 0x100], mm1
    movntq QWORD PTR [rax], mm1
    movntq QWORD PTR [rip + 0x100], mm0
    movntq QWORD PTR [rax + rbx*4 + 0x100], mm3
    movntq QWORD PTR [rax + rbx*4 + 0x100], mm0
    movntq QWORD PTR [rip + 0x1000], mm2
    movntq QWORD PTR [rip + 0x1000], mm3
    movntq QWORD PTR [rbx], mm1
    movntq QWORD PTR [rax + rbx*1 + 0x10], mm0

// === MOVS m8, m8 ===
    movs BYTE PTR [rdi], BYTE PTR [rsi]

// === MOVS m16, m16 ===
    movs WORD PTR [rdi], WORD PTR [rsi]

// === MOVS m32, m32 ===
    movs DWORD PTR [rdi], DWORD PTR [rsi]

// === MOVS m64, m64 ===
    movs QWORD PTR [rdi], QWORD PTR [rsi]

// === MOVSB ===
    movsb

// === MOVSW ===
    movsw

// === MOVSD ===
    movsd

// === MOVSQ ===
    movsq

// === MOVSX r16, r8 ===
    movsx bx, dl
    movsx si, al
    movsx bx, cl
    movsx cx, dl
    movsx di, bl
    movsx ax, bl
    movsx di, cl
    movsx di, al
    movsx dx, bl
    movsx si, cl

// === MOVSX r16, m8 ===
    movsx bx, BYTE PTR [rip + 0x100]
    movsx di, BYTE PTR [rip + 0x100]
    movsx ax, BYTE PTR [rax + rbx*4 + 0x100]
    movsx dx, BYTE PTR [rax]
    movsx bx, BYTE PTR [rax + rbx*4 + 0x100]
    movsx ax, BYTE PTR [rax]
    movsx di, BYTE PTR [rip + 0x1000]
    movsx si, BYTE PTR [rbx]
    movsx di, BYTE PTR [rax + rbx*1 + 0x10]
    movsx si, BYTE PTR [rip + 0x1000]

// === MOVSX r32, r8 ===
    movsx edi, cl
    movsx esi, cl
    movsx ebx, dl
    movsx ecx, bl
    movsx edi, dl
    movsx ecx, dl
    movsx ecx, cl
    movsx eax, al
    movsx ebx, bl
    movsx edx, bl

// === MOVSX r32, m8 ===
    movsx esi, BYTE PTR [rax + rbx*4 + 0x100]
    movsx edi, BYTE PTR [rax + rbx*4 + 0x100]
    movsx eax, BYTE PTR [rax]
    movsx ebx, BYTE PTR [rax]
    movsx eax, BYTE PTR [rax + rbx*1 + 0x10]
    movsx ecx, BYTE PTR [rax + rbx*1 + 0x10]
    movsx ecx, BYTE PTR [rax]
    movsx esi, BYTE PTR [rip + 0x1000]
    movsx edx, BYTE PTR [rip + 0x100]
    movsx esi, BYTE PTR [rax]

// === MOVSX r64, r8 ===
    movsx r8, cl
    movsx r9, bl
    movsx r8, al
    movsx r13, dl
    movsx rsi, al
    movsx r8, dl
    movsx r11, cl
    movsx r9, cl
    movsx rax, al
    movsx rdx, al

// === MOVSX r64, m8 ===
    movsx rax, BYTE PTR [rax + rbx*1 + 0x10]
    movsx r13, BYTE PTR [rax + rbx*4 + 0x100]
    movsx rbx, BYTE PTR [rax + rbx*4 + 0x100]
    movsx r11, BYTE PTR [rip + 0x1000]
    movsx r11, BYTE PTR [rax + rbx*1 + 0x10]
    movsx rdx, BYTE PTR [rip + 0x100]
    movsx rbx, BYTE PTR [rip + 0x1000]
    movsx r10, BYTE PTR [rip + 0x1000]
    movsx rdi, BYTE PTR [rax + rbx*4 + 0x100]
    movsx r10, BYTE PTR [rax + rbx*4 + 0x100]

// === MOVSX r32, r16 ===
    movsx edx, cx
    movsx edi, si
    movsx edi, cx
    movsx esi, dx
    movsx edi, bx
    movsx eax, si
    movsx ecx, di
    movsx eax, di
    movsx edx, ax
    movsx ebx, cx

// === MOVSX r32, m16 ===
    movsx ecx, WORD PTR [rip + 0x100]
    movsx ecx, WORD PTR [rbx]
    movsx edx, WORD PTR [rax + rbx*4 + 0x100]
    movsx eax, WORD PTR [rbx]
    movsx eax, WORD PTR [rip + 0x1000]
    movsx eax, WORD PTR [rip + 0x100]
    movsx edi, WORD PTR [rip + 0x1000]
    movsx eax, WORD PTR [rax]
    movsx ecx, WORD PTR [rip + 0x1000]
    movsx ecx, WORD PTR [rax]

// === MOVSX r64, r16 ===
    movsx rdx, bx
    movsx rsi, ax
    movsx rcx, bx
    movsx r13, di
    movsx rbx, cx
    movsx rax, di
    movsx r9, di
    movsx r9, dx
    movsx r12, di
    movsx rsi, di

// === MOVSX r64, m16 ===
    movsx r9, WORD PTR [rax + rbx*1 + 0x10]
    movsx r8, WORD PTR [rax + rbx*4 + 0x100]
    movsx rdx, WORD PTR [rip + 0x1000]
    movsx r10, WORD PTR [rip + 0x100]
    movsx r8, WORD PTR [rip + 0x1000]
    movsx rax, WORD PTR [rax]
    movsx rax, WORD PTR [rbx]
    movsx rcx, WORD PTR [rax]
    movsx rdx, WORD PTR [rax]
    movsx r12, WORD PTR [rip + 0x1000]

// === MOVSXD r64, r32 ===
    movsxd r9, edi
    movsxd r9, eax
    movsxd r12, ebx
    movsxd rcx, esi
    movsxd rax, ecx
    movsxd r13, ecx
    movsxd rcx, ecx
    movsxd rbx, edx
    movsxd r8, eax
    movsxd r9, ebx

// === MOVSXD r64, m32 ===
    movsxd r11, DWORD PTR [rip + 0x1000]
    movsxd r11, DWORD PTR [rip + 0x100]
    movsxd r11, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd rdi, DWORD PTR [rbx]
    movsxd rsi, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd r9, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd r8, DWORD PTR [rip + 0x100]
    movsxd rdx, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd r10, DWORD PTR [rbx]
    movsxd r12, DWORD PTR [rbx]

// === MOVZX r16, r8 ===
    movzx dx, bl
    movzx si, cl
    movzx cx, dl
    movzx di, cl
    movzx bx, cl
    movzx bx, bl
    movzx bx, dl
    movzx si, al
    movzx ax, al
    movzx si, bl

// === MOVZX r16, m8 ===
    movzx di, BYTE PTR [rax + rbx*4 + 0x100]
    movzx di, BYTE PTR [rip + 0x1000]
    movzx di, BYTE PTR [rax]
    movzx cx, BYTE PTR [rax + rbx*4 + 0x100]
    movzx bx, BYTE PTR [rbx]
    movzx bx, BYTE PTR [rip + 0x1000]
    movzx bx, BYTE PTR [rax]
    movzx bx, BYTE PTR [rip + 0x100]
    movzx si, BYTE PTR [rax + rbx*1 + 0x10]
    movzx di, BYTE PTR [rbx]

// === MOVZX r32, r8 ===
    movzx ecx, al
    movzx eax, cl
    movzx edi, dl
    movzx ecx, dl
    movzx eax, al
    movzx ebx, al
    movzx edi, bl
    movzx edi, cl
    movzx ebx, cl
    movzx esi, al

// === MOVZX r32, m8 ===
    movzx eax, BYTE PTR [rip + 0x1000]
    movzx edx, BYTE PTR [rax + rbx*4 + 0x100]
    movzx ebx, BYTE PTR [rax + rbx*4 + 0x100]
    movzx edi, BYTE PTR [rip + 0x1000]
    movzx edx, BYTE PTR [rax + rbx*1 + 0x10]
    movzx ecx, BYTE PTR [rax + rbx*1 + 0x10]
    movzx eax, BYTE PTR [rax + rbx*1 + 0x10]
    movzx ecx, BYTE PTR [rip + 0x1000]
    movzx edx, BYTE PTR [rbx]
    movzx ebx, BYTE PTR [rax]

// === MOVZX r64, r8 ===
    movzx r12, cl
    movzx r8, dl
    movzx r9, dl
    movzx rdx, al
    movzx r11, al
    movzx r13, cl
    movzx r12, al
    movzx rcx, al
    movzx rdx, cl
    movzx r12, bl

// === MOVZX r64, m8 ===
    movzx rsi, BYTE PTR [rip + 0x1000]
    movzx rax, BYTE PTR [rax]
    movzx r13, BYTE PTR [rax]
    movzx r8, BYTE PTR [rax + rbx*4 + 0x100]
    movzx rcx, BYTE PTR [rip + 0x100]
    movzx r11, BYTE PTR [rbx]
    movzx r9, BYTE PTR [rip + 0x100]
    movzx r12, BYTE PTR [rip + 0x1000]
    movzx rdx, BYTE PTR [rip + 0x1000]
    movzx rax, BYTE PTR [rip + 0x100]

// === MOVZX r32, r16 ===
    movzx eax, di
    movzx ecx, cx
    movzx ecx, ax
    movzx edx, si
    movzx edx, ax
    movzx edi, bx
    movzx edi, ax
    movzx esi, cx
    movzx esi, di
    movzx edi, di

// === MOVZX r32, m16 ===
    movzx ecx, WORD PTR [rax]
    movzx edi, WORD PTR [rax]
    movzx eax, WORD PTR [rip + 0x1000]
    movzx edx, WORD PTR [rax + rbx*4 + 0x100]
    movzx edi, WORD PTR [rip + 0x100]
    movzx ebx, WORD PTR [rax]
    movzx esi, WORD PTR [rip + 0x1000]
    movzx eax, WORD PTR [rax + rbx*4 + 0x100]
    movzx ebx, WORD PTR [rax + rbx*4 + 0x100]
    movzx esi, WORD PTR [rax]

// === MOVZX r64, r16 ===
    movzx r11, di
    movzx rax, di
    movzx r10, cx
    movzx rcx, cx
    movzx r11, cx
    movzx r8, bx
    movzx r10, si
    movzx r8, cx
    movzx r8, si
    movzx rsi, bx

// === MOVZX r64, m16 ===
    movzx rsi, WORD PTR [rax]
    movzx rdx, WORD PTR [rax + rbx*1 + 0x10]
    movzx r11, WORD PTR [rip + 0x100]
    movzx r11, WORD PTR [rip + 0x1000]
    movzx rcx, WORD PTR [rax + rbx*1 + 0x10]
    movzx rdi, WORD PTR [rax + rbx*1 + 0x10]
    movzx r11, WORD PTR [rax + rbx*1 + 0x10]
    movzx rcx, WORD PTR [rip + 0x100]
    movzx r11, WORD PTR [rbx]
    movzx rbx, WORD PTR [rax + rbx*4 + 0x100]

// === MUL r8 ===
    mul bl
    mul cl
    mul dl
    mul al

// === MUL m8 ===
    mul BYTE PTR [rbx]
    mul BYTE PTR [rax]
    mul BYTE PTR [rax + rbx*4 + 0x100]
    mul BYTE PTR [rip + 0x100]
    mul BYTE PTR [rax + rbx*1 + 0x10]
    mul BYTE PTR [rip + 0x1000]

// === MUL r16 ===
    mul si
    mul ax
    mul dx
    mul cx
    mul bx
    mul di

// === MUL m16 ===
    mul WORD PTR [rbx]
    mul WORD PTR [rip + 0x1000]
    mul WORD PTR [rax]
    mul WORD PTR [rax + rbx*4 + 0x100]
    mul WORD PTR [rax + rbx*1 + 0x10]
    mul WORD PTR [rip + 0x100]

// === MUL r32 ===
    mul eax
    mul edx
    mul edi
    mul ebx
    mul ecx
    mul esi

// === MUL m32 ===
    mul DWORD PTR [rip + 0x1000]
    mul DWORD PTR [rax + rbx*1 + 0x10]
    mul DWORD PTR [rip + 0x100]
    mul DWORD PTR [rbx]
    mul DWORD PTR [rax]
    mul DWORD PTR [rax + rbx*4 + 0x100]

// === MUL r64 ===
    mul rcx
    mul r8
    mul rdi
    mul r10
    mul rax
    mul rsi
    mul rdx
    mul r13
    mul r9
    mul rbx

// === MUL m64 ===
    mul QWORD PTR [rax + rbx*4 + 0x100]
    mul QWORD PTR [rax + rbx*1 + 0x10]
    mul QWORD PTR [rbx]
    mul QWORD PTR [rip + 0x100]
    mul QWORD PTR [rip + 0x1000]
    mul QWORD PTR [rax]

// === MWAIT ===
    mwait

// === NEG r8 ===
    neg al
    neg bl
    neg cl
    neg dl

// === NEG m8 ===
    neg BYTE PTR [rax + rbx*1 + 0x10]
    neg BYTE PTR [rip + 0x100]
    neg BYTE PTR [rax]
    neg BYTE PTR [rip + 0x1000]
    neg BYTE PTR [rbx]
    neg BYTE PTR [rax + rbx*4 + 0x100]

// === NEG r16 ===
    neg di
    neg dx
    neg ax
    neg si
    neg bx
    neg cx

// === NEG m16 ===
    neg WORD PTR [rbx]
    neg WORD PTR [rax]
    neg WORD PTR [rax + rbx*4 + 0x100]
    neg WORD PTR [rip + 0x1000]
    neg WORD PTR [rax + rbx*1 + 0x10]
    neg WORD PTR [rip + 0x100]

// === NEG r32 ===
    neg edi
    neg esi
    neg eax
    neg ecx
    neg edx
    neg ebx

// === NEG m32 ===
    neg DWORD PTR [rbx]
    neg DWORD PTR [rax + rbx*4 + 0x100]
    neg DWORD PTR [rip + 0x100]
    neg DWORD PTR [rax]
    neg DWORD PTR [rax + rbx*1 + 0x10]
    neg DWORD PTR [rip + 0x1000]

// === NEG r64 ===
    neg r9
    neg r10
    neg r13
    neg r12
    neg rax
    neg rbx
    neg rsi
    neg rdx
    neg rcx
    neg r11

// === NEG m64 ===
    neg QWORD PTR [rip + 0x100]
    neg QWORD PTR [rbx]
    neg QWORD PTR [rax + rbx*4 + 0x100]
    neg QWORD PTR [rax + rbx*1 + 0x10]
    neg QWORD PTR [rip + 0x1000]
    neg QWORD PTR [rax]

// === NOP ===
    nop

// === NOP r16 ===
    nop si
    nop dx
    nop bx
    nop di
    nop ax
    nop cx

// === NOP m16 ===
    nop WORD PTR [rbx]
    nop WORD PTR [rax + rbx*1 + 0x10]
    nop WORD PTR [rax + rbx*4 + 0x100]
    nop WORD PTR [rax]
    nop WORD PTR [rip + 0x1000]
    nop WORD PTR [rip + 0x100]

// === NOP r32 ===
    nop ecx
    nop edx
    nop ebx
    nop edi
    nop eax
    nop esi

// === NOP m32 ===
    nop DWORD PTR [rax + rbx*1 + 0x10]
    nop DWORD PTR [rax]
    nop DWORD PTR [rip + 0x1000]
    nop DWORD PTR [rip + 0x100]
    nop DWORD PTR [rax + rbx*4 + 0x100]
    nop DWORD PTR [rbx]

// === NOT r8 ===
    not al
    not cl
    not bl
    not dl

// === NOT m8 ===
    not BYTE PTR [rax + rbx*1 + 0x10]
    not BYTE PTR [rax]
    not BYTE PTR [rip + 0x100]
    not BYTE PTR [rip + 0x1000]
    not BYTE PTR [rbx]
    not BYTE PTR [rax + rbx*4 + 0x100]

// === NOT r16 ===
    not ax
    not cx
    not bx
    not si
    not dx
    not di

// === NOT m16 ===
    not WORD PTR [rip + 0x100]
    not WORD PTR [rax]
    not WORD PTR [rbx]
    not WORD PTR [rax + rbx*4 + 0x100]
    not WORD PTR [rip + 0x1000]
    not WORD PTR [rax + rbx*1 + 0x10]

// === NOT r32 ===
    not eax
    not esi
    not edi
    not ecx
    not edx
    not ebx

// === NOT m32 ===
    not DWORD PTR [rax + rbx*1 + 0x10]
    not DWORD PTR [rbx]
    not DWORD PTR [rax]
    not DWORD PTR [rax + rbx*4 + 0x100]
    not DWORD PTR [rip + 0x1000]
    not DWORD PTR [rip + 0x100]

// === NOT r64 ===
    not rdx
    not r9
    not r8
    not rdi
    not r12
    not rax
    not r10
    not rsi
    not r13
    not rbx

// === NOT m64 ===
    not QWORD PTR [rbx]
    not QWORD PTR [rax + rbx*1 + 0x10]
    not QWORD PTR [rip + 0x1000]
    not QWORD PTR [rip + 0x100]
    not QWORD PTR [rax]
    not QWORD PTR [rax + rbx*4 + 0x100]

// === OR AL, imm8 ===
    or al, 0xff

// === OR AX, imm16 ===
    or ax, 0xffff

// === OR EAX, imm32 ===
    or eax, 0xffffffff

// === OR RAX, imm32 ===
    or rax, 0x7fffffff
    or rax, -1

// === OR r8, imm8 ===
    or bl, 0xff
    or al, 0xff
    or dl, 0xff
    or cl, 0xff

// === OR m8, imm8 ===
    or BYTE PTR [rax + rbx*4 + 0x100], 0xff
    or BYTE PTR [rip + 0x100], 0xff
    or BYTE PTR [rbx], 0xff
    or BYTE PTR [rip + 0x1000], 0xff
    or BYTE PTR [rax + rbx*1 + 0x10], 0xff
    or BYTE PTR [rax], 0xff

// === OR r16, imm16 ===
    or cx, 0xffff
    or dx, 0xffff
    or di, 0xffff
    or ax, 0xffff
    or si, 0xffff
    or bx, 0xffff

// === OR m16, imm16 ===
    or WORD PTR [rax], 0xffff
    or WORD PTR [rbx], 0xffff
    or WORD PTR [rax + rbx*4 + 0x100], 0xffff
    or WORD PTR [rip + 0x100], 0xffff
    or WORD PTR [rip + 0x1000], 0xffff
    or WORD PTR [rax + rbx*1 + 0x10], 0xffff

// === OR r32, imm32 ===
    or edx, 0xffffffff
    or ebx, 0xffffffff
    or esi, 0xffffffff
    or edi, 0xffffffff
    or ecx, 0xffffffff
    or eax, 0xffffffff

// === OR m32, imm32 ===
    or DWORD PTR [rip + 0x1000], 0xffffffff
    or DWORD PTR [rbx], 0xffffffff
    or DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    or DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    or DWORD PTR [rip + 0x100], 0xffffffff
    or DWORD PTR [rax], 0xffffffff

// === OR r64, imm32 ===
    or rcx, 0x7fffffff
    or rbx, -1
    or r11, -1
    or r9, -1
    or r13, -1
    or rdi, -1
    or r13, 0x7fffffff
    or r12, 0x7fffffff
    or r11, 0x7fffffff
    or rbx, 0x7fffffff

// === OR m64, imm32 ===
    or QWORD PTR [rbx], -1
    or QWORD PTR [rip + 0x100], -1
    or QWORD PTR [rbx], 0x7fffffff
    or QWORD PTR [rip + 0x100], 0x7fffffff
    or QWORD PTR [rax], -1
    or QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    or QWORD PTR [rax + rbx*4 + 0x100], -1
    or QWORD PTR [rip + 0x1000], -1
    or QWORD PTR [rip + 0x1000], 0x7fffffff
    or QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff

// === OR r16, imm8 ===
    or bx, 0xff
    or dx, 0xff
    or cx, 0xff
    or di, 0xff
    or si, 0xff
    or ax, 0xff

// === OR m16, imm8 ===
    or WORD PTR [rax + rbx*1 + 0x10], 0xff
    or WORD PTR [rax + rbx*4 + 0x100], 0xff
    or WORD PTR [rax], 0xff
    or WORD PTR [rip + 0x100], 0xff
    or WORD PTR [rbx], 0xff
    or WORD PTR [rip + 0x1000], 0xff

// === OR r32, imm8 ===
    or ebx, 0xff
    or eax, 0xff
    or edx, 0xff
    or esi, 0xff
    or ecx, 0xff
    or edi, 0xff

// === OR m32, imm8 ===
    or DWORD PTR [rbx], 0xff
    or DWORD PTR [rax], 0xff
    or DWORD PTR [rax + rbx*1 + 0x10], 0xff
    or DWORD PTR [rip + 0x100], 0xff
    or DWORD PTR [rip + 0x1000], 0xff
    or DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === OR r64, imm8 ===
    or rax, 0xff
    or r11, 0xff
    or rcx, 0xff
    or r10, 0xff
    or rsi, 0xff
    or rbx, 0xff
    or r8, 0xff
    or r13, 0xff
    or r9, 0xff
    or rdx, 0xff

// === OR m64, imm8 ===
    or QWORD PTR [rip + 0x100], 0xff
    or QWORD PTR [rbx], 0xff
    or QWORD PTR [rax], 0xff
    or QWORD PTR [rax + rbx*4 + 0x100], 0xff
    or QWORD PTR [rax + rbx*1 + 0x10], 0xff
    or QWORD PTR [rip + 0x1000], 0xff

// === OR r8, r8 ===
    or bl, cl
    or al, al
    or al, cl
    or cl, al
    or al, dl
    or dl, cl
    or bl, dl
    or al, bl
    or dl, bl
    or bl, al

// === OR m8, r8 ===
    or BYTE PTR [rax + rbx*4 + 0x100], al
    or BYTE PTR [rax + rbx*1 + 0x10], cl
    or BYTE PTR [rip + 0x1000], bl
    or BYTE PTR [rip + 0x1000], dl
    or BYTE PTR [rax + rbx*1 + 0x10], bl
    or BYTE PTR [rax + rbx*1 + 0x10], al
    or BYTE PTR [rax], dl
    or BYTE PTR [rip + 0x1000], cl
    or BYTE PTR [rax + rbx*1 + 0x10], dl
    or BYTE PTR [rbx], cl

// === OR r16, r16 ===
    or dx, bx
    or cx, ax
    or si, bx
    or dx, si
    or ax, bx
    or ax, dx
    or dx, dx
    or bx, ax
    or di, bx
    or bx, dx

// === OR m16, r16 ===
    or WORD PTR [rax], si
    or WORD PTR [rip + 0x1000], cx
    or WORD PTR [rbx], si
    or WORD PTR [rip + 0x1000], bx
    or WORD PTR [rbx], dx
    or WORD PTR [rax + rbx*1 + 0x10], di
    or WORD PTR [rax], di
    or WORD PTR [rax + rbx*4 + 0x100], di
    or WORD PTR [rax + rbx*4 + 0x100], ax
    or WORD PTR [rax + rbx*1 + 0x10], cx

// === OR r32, r32 ===
    or ebx, esi
    or edx, edx
    or eax, ebx
    or ecx, edx
    or eax, edi
    or eax, edx
    or edx, ebx
    or edi, edi
    or ecx, ecx
    or edi, edx

// === OR m32, r32 ===
    or DWORD PTR [rbx], eax
    or DWORD PTR [rax + rbx*1 + 0x10], ecx
    or DWORD PTR [rip + 0x1000], esi
    or DWORD PTR [rax + rbx*1 + 0x10], eax
    or DWORD PTR [rip + 0x100], edx
    or DWORD PTR [rax], eax
    or DWORD PTR [rax + rbx*4 + 0x100], edi
    or DWORD PTR [rip + 0x1000], edx
    or DWORD PTR [rax + rbx*4 + 0x100], ebx
    or DWORD PTR [rip + 0x100], eax

// === OR r64, r64 ===
    or r11, r12
    or rdi, rax
    or rsi, r10
    or rdx, r9
    or rbx, rbx
    or r12, rcx
    or r11, rax
    or r13, r8
    or rdx, rbx
    or rsi, r12

// === OR m64, r64 ===
    or QWORD PTR [rax + rbx*4 + 0x100], r11
    or QWORD PTR [rax], rsi
    or QWORD PTR [rbx], r11
    or QWORD PTR [rax + rbx*1 + 0x10], rcx
    or QWORD PTR [rax + rbx*1 + 0x10], r13
    or QWORD PTR [rax + rbx*4 + 0x100], r9
    or QWORD PTR [rip + 0x1000], rdi
    or QWORD PTR [rax], rdx
    or QWORD PTR [rip + 0x100], r12
    or QWORD PTR [rip + 0x1000], rcx

// === OR r8, m8 ===
    or cl, BYTE PTR [rax]
    or dl, BYTE PTR [rax + rbx*1 + 0x10]
    or dl, BYTE PTR [rbx]
    or al, BYTE PTR [rax + rbx*1 + 0x10]
    or al, BYTE PTR [rax]
    or bl, BYTE PTR [rax + rbx*4 + 0x100]
    or cl, BYTE PTR [rbx]
    or al, BYTE PTR [rbx]
    or al, BYTE PTR [rip + 0x1000]
    or bl, BYTE PTR [rip + 0x1000]

// === OR r16, m16 ===
    or bx, WORD PTR [rip + 0x1000]
    or bx, WORD PTR [rbx]
    or di, WORD PTR [rip + 0x100]
    or di, WORD PTR [rbx]
    or si, WORD PTR [rip + 0x100]
    or cx, WORD PTR [rbx]
    or cx, WORD PTR [rip + 0x100]
    or ax, WORD PTR [rax + rbx*4 + 0x100]
    or ax, WORD PTR [rip + 0x100]
    or bx, WORD PTR [rax]

// === OR r32, m32 ===
    or edx, DWORD PTR [rax]
    or eax, DWORD PTR [rax + rbx*4 + 0x100]
    or eax, DWORD PTR [rip + 0x1000]
    or ebx, DWORD PTR [rbx]
    or ebx, DWORD PTR [rip + 0x1000]
    or edi, DWORD PTR [rax]
    or edx, DWORD PTR [rip + 0x100]
    or esi, DWORD PTR [rip + 0x100]
    or ecx, DWORD PTR [rax]
    or edx, DWORD PTR [rbx]

// === OR r64, m64 ===
    or r13, QWORD PTR [rax + rbx*4 + 0x100]
    or r11, QWORD PTR [rax + rbx*4 + 0x100]
    or rsi, QWORD PTR [rax + rbx*1 + 0x10]
    or r8, QWORD PTR [rbx]
    or rdi, QWORD PTR [rax + rbx*4 + 0x100]
    or rdi, QWORD PTR [rbx]
    or rcx, QWORD PTR [rip + 0x1000]
    or rax, QWORD PTR [rbx]
    or r10, QWORD PTR [rax + rbx*1 + 0x10]
    or rdx, QWORD PTR [rip + 0x1000]

// === OUT imm8, AL ===
    out 0xff, al

// === OUT imm8, AX ===
    out 0xff, ax

// === OUT imm8, EAX ===
    out 0xff, eax

// === OUT DX, AL ===
    out dx, al

// === OUT DX, AX ===
    out dx, ax

// === OUT DX, EAX ===
    out dx, eax

// === OUTS DX, m8 ===
    outs dx, BYTE PTR [rsi]

// === OUTS DX, m16 ===
    outs dx, WORD PTR [rsi]

// === OUTS DX, m32 ===
    outs dx, DWORD PTR [rsi]

// === OUTSB ===
    outsb

// === OUTSW ===
    outsw

// === OUTSD ===
    outsd

// === PAUSE ===
    pause

// === POP r16 ===
    pop dx
    pop bx
    pop di
    pop cx
    pop ax
    pop si

// === POP m16 ===
    pop WORD PTR [rbx]
    pop WORD PTR [rax + rbx*1 + 0x10]
    pop WORD PTR [rax + rbx*4 + 0x100]
    pop WORD PTR [rip + 0x100]
    pop WORD PTR [rip + 0x1000]
    pop WORD PTR [rax]

// === POP r64 ===
    pop rsi
    pop rcx
    pop rdi
    pop rdx
    pop r12
    pop rax
    pop r8
    pop r11
    pop r10
    pop r13

// === POP m64 ===
    pop QWORD PTR [rax + rbx*1 + 0x10]
    pop QWORD PTR [rax]
    pop QWORD PTR [rip + 0x100]
    pop QWORD PTR [rbx]
    pop QWORD PTR [rip + 0x1000]
    pop QWORD PTR [rax + rbx*4 + 0x100]

// === POP FS ===
    pop fs

// === POP GS ===
    pop gs

// === POPCNT r16, r16 ===
    popcnt dx, cx
    popcnt ax, ax
    popcnt di, bx
    popcnt bx, dx
    popcnt dx, dx
    popcnt cx, si
    popcnt bx, ax
    popcnt dx, bx
    popcnt ax, dx
    popcnt ax, si

// === POPCNT r16, m16 ===
    popcnt dx, WORD PTR [rip + 0x100]
    popcnt si, WORD PTR [rax + rbx*1 + 0x10]
    popcnt dx, WORD PTR [rax + rbx*1 + 0x10]
    popcnt bx, WORD PTR [rip + 0x100]
    popcnt si, WORD PTR [rax]
    popcnt cx, WORD PTR [rbx]
    popcnt dx, WORD PTR [rip + 0x1000]
    popcnt di, WORD PTR [rbx]
    popcnt ax, WORD PTR [rax + rbx*4 + 0x100]
    popcnt cx, WORD PTR [rax + rbx*4 + 0x100]

// === POPCNT r32, r32 ===
    popcnt edi, esi
    popcnt esi, edx
    popcnt edi, ebx
    popcnt edx, edx
    popcnt eax, edx
    popcnt ebx, ecx
    popcnt eax, ebx
    popcnt ecx, edi
    popcnt ecx, ebx
    popcnt edx, ecx

// === POPCNT r32, m32 ===
    popcnt ecx, DWORD PTR [rax + rbx*4 + 0x100]
    popcnt ebx, DWORD PTR [rbx]
    popcnt esi, DWORD PTR [rbx]
    popcnt ebx, DWORD PTR [rax + rbx*4 + 0x100]
    popcnt ecx, DWORD PTR [rip + 0x1000]
    popcnt edx, DWORD PTR [rip + 0x100]
    popcnt edx, DWORD PTR [rax + rbx*1 + 0x10]
    popcnt esi, DWORD PTR [rip + 0x100]
    popcnt edx, DWORD PTR [rax]
    popcnt ecx, DWORD PTR [rip + 0x100]

// === POPCNT r64, r64 ===
    popcnt rbx, r13
    popcnt r13, rdx
    popcnt rcx, rax
    popcnt r12, rcx
    popcnt r9, r13
    popcnt r13, rdi
    popcnt r12, rdi
    popcnt r10, r9
    popcnt r8, r13
    popcnt r9, r8

// === POPCNT r64, m64 ===
    popcnt rax, QWORD PTR [rax]
    popcnt r9, QWORD PTR [rbx]
    popcnt r12, QWORD PTR [rip + 0x1000]
    popcnt r13, QWORD PTR [rax]
    popcnt r11, QWORD PTR [rip + 0x100]
    popcnt rcx, QWORD PTR [rax]
    popcnt rdx, QWORD PTR [rip + 0x100]
    popcnt r8, QWORD PTR [rbx]
    popcnt rbx, QWORD PTR [rax + rbx*4 + 0x100]
    popcnt rdi, QWORD PTR [rip + 0x1000]

// === POPF ===
    popf

// === POPFQ ===
    popfq

// === PUSH r16 ===
    push dx
    push si
    push di
    push bx
    push cx
    push ax

// === PUSH m16 ===
    push WORD PTR [rax + rbx*1 + 0x10]
    push WORD PTR [rax + rbx*4 + 0x100]
    push WORD PTR [rip + 0x1000]
    push WORD PTR [rbx]
    push WORD PTR [rip + 0x100]
    push WORD PTR [rax]

// === PUSH r64 ===
    push r13
    push rsi
    push rdi
    push rdx
    push r9
    push rbx
    push r12
    push rcx
    push r10
    push r11

// === PUSH m64 ===
    push QWORD PTR [rax + rbx*1 + 0x10]
    push QWORD PTR [rax]
    push QWORD PTR [rbx]
    push QWORD PTR [rip + 0x100]
    push QWORD PTR [rip + 0x1000]
    push QWORD PTR [rax + rbx*4 + 0x100]

// === PUSH imm8 ===
    push 0xff

// === PUSH imm16 ===
    push 0xffff

// === PUSH imm32 ===
    push -1
    push 0x7fffffff

// === PUSH FS ===
    push fs

// === PUSH GS ===
    push gs

// === PUSHF ===
    pushf

// === PUSHFQ ===
    pushfq

// === RCL r8, 1 ===
    rcl al, 1
    rcl dl, 1
    rcl cl, 1
    rcl bl, 1

// === RCL m8, 1 ===
    rcl BYTE PTR [rax], 1
    rcl BYTE PTR [rax + rbx*4 + 0x100], 1
    rcl BYTE PTR [rax + rbx*1 + 0x10], 1
    rcl BYTE PTR [rbx], 1
    rcl BYTE PTR [rip + 0x100], 1
    rcl BYTE PTR [rip + 0x1000], 1

// === RCL r8, CL ===
    rcl cl, cl
    rcl bl, cl
    rcl dl, cl
    rcl al, cl

// === RCL m8, CL ===
    rcl BYTE PTR [rax + rbx*4 + 0x100], cl
    rcl BYTE PTR [rax], cl
    rcl BYTE PTR [rip + 0x100], cl
    rcl BYTE PTR [rbx], cl
    rcl BYTE PTR [rax + rbx*1 + 0x10], cl
    rcl BYTE PTR [rip + 0x1000], cl

// === RCL r8, imm8 ===
    rcl al, 0xff
    rcl bl, 0xff
    rcl dl, 0xff
    rcl cl, 0xff

// === RCL m8, imm8 ===
    rcl BYTE PTR [rip + 0x100], 0xff
    rcl BYTE PTR [rax], 0xff
    rcl BYTE PTR [rax + rbx*4 + 0x100], 0xff
    rcl BYTE PTR [rip + 0x1000], 0xff
    rcl BYTE PTR [rbx], 0xff
    rcl BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === RCL r16, 1 ===
    rcl si, 1
    rcl bx, 1
    rcl cx, 1
    rcl di, 1
    rcl dx, 1
    rcl ax, 1

// === RCL m16, 1 ===
    rcl WORD PTR [rbx], 1
    rcl WORD PTR [rax + rbx*1 + 0x10], 1
    rcl WORD PTR [rax + rbx*4 + 0x100], 1
    rcl WORD PTR [rax], 1
    rcl WORD PTR [rip + 0x100], 1
    rcl WORD PTR [rip + 0x1000], 1

// === RCL r16, CL ===
    rcl cx, cl
    rcl dx, cl
    rcl si, cl
    rcl ax, cl
    rcl bx, cl
    rcl di, cl

// === RCL m16, CL ===
    rcl WORD PTR [rax + rbx*4 + 0x100], cl
    rcl WORD PTR [rax], cl
    rcl WORD PTR [rip + 0x100], cl
    rcl WORD PTR [rbx], cl
    rcl WORD PTR [rax + rbx*1 + 0x10], cl
    rcl WORD PTR [rip + 0x1000], cl

// === RCL r16, imm8 ===
    rcl si, 0xff
    rcl bx, 0xff
    rcl cx, 0xff
    rcl di, 0xff
    rcl dx, 0xff
    rcl ax, 0xff

// === RCL m16, imm8 ===
    rcl WORD PTR [rbx], 0xff
    rcl WORD PTR [rip + 0x100], 0xff
    rcl WORD PTR [rip + 0x1000], 0xff
    rcl WORD PTR [rax + rbx*1 + 0x10], 0xff
    rcl WORD PTR [rax], 0xff
    rcl WORD PTR [rax + rbx*4 + 0x100], 0xff

// === RCL r32, 1 ===
    rcl eax, 1
    rcl esi, 1
    rcl ecx, 1
    rcl edi, 1
    rcl edx, 1
    rcl ebx, 1

// === RCL m32, 1 ===
    rcl DWORD PTR [rbx], 1
    rcl DWORD PTR [rax + rbx*1 + 0x10], 1
    rcl DWORD PTR [rax], 1
    rcl DWORD PTR [rax + rbx*4 + 0x100], 1
    rcl DWORD PTR [rip + 0x1000], 1
    rcl DWORD PTR [rip + 0x100], 1

// === RCL r64, 1 ===
    rcl r10, 1
    rcl rax, 1
    rcl r11, 1
    rcl r9, 1
    rcl r8, 1
    rcl rdi, 1
    rcl r13, 1
    rcl rcx, 1
    rcl r12, 1
    rcl rbx, 1

// === RCL m64, 1 ===
    rcl QWORD PTR [rax + rbx*1 + 0x10], 1
    rcl QWORD PTR [rax + rbx*4 + 0x100], 1
    rcl QWORD PTR [rbx], 1
    rcl QWORD PTR [rip + 0x1000], 1
    rcl QWORD PTR [rip + 0x100], 1
    rcl QWORD PTR [rax], 1

// === RCL r32, CL ===
    rcl eax, cl
    rcl esi, cl
    rcl ecx, cl
    rcl ebx, cl
    rcl edx, cl
    rcl edi, cl

// === RCL m32, CL ===
    rcl DWORD PTR [rax + rbx*4 + 0x100], cl
    rcl DWORD PTR [rip + 0x100], cl
    rcl DWORD PTR [rax + rbx*1 + 0x10], cl
    rcl DWORD PTR [rip + 0x1000], cl
    rcl DWORD PTR [rax], cl
    rcl DWORD PTR [rbx], cl

// === RCL r64, CL ===
    rcl r10, cl
    rcl rdi, cl
    rcl rcx, cl
    rcl r9, cl
    rcl rsi, cl
    rcl rax, cl
    rcl r8, cl
    rcl rdx, cl
    rcl r12, cl
    rcl r13, cl

// === RCL m64, CL ===
    rcl QWORD PTR [rax + rbx*4 + 0x100], cl
    rcl QWORD PTR [rip + 0x100], cl
    rcl QWORD PTR [rbx], cl
    rcl QWORD PTR [rax + rbx*1 + 0x10], cl
    rcl QWORD PTR [rip + 0x1000], cl
    rcl QWORD PTR [rax], cl

// === RCL r32, imm8 ===
    rcl ecx, 0xff
    rcl edi, 0xff
    rcl esi, 0xff
    rcl eax, 0xff
    rcl edx, 0xff
    rcl ebx, 0xff

// === RCL m32, imm8 ===
    rcl DWORD PTR [rbx], 0xff
    rcl DWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcl DWORD PTR [rax], 0xff
    rcl DWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcl DWORD PTR [rip + 0x100], 0xff
    rcl DWORD PTR [rip + 0x1000], 0xff

// === RCL r64, imm8 ===
    rcl rdx, 0xff
    rcl rbx, 0xff
    rcl r13, 0xff
    rcl rcx, 0xff
    rcl r10, 0xff
    rcl rax, 0xff
    rcl rdi, 0xff
    rcl r11, 0xff
    rcl rsi, 0xff
    rcl r9, 0xff

// === RCL m64, imm8 ===
    rcl QWORD PTR [rip + 0x100], 0xff
    rcl QWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcl QWORD PTR [rip + 0x1000], 0xff
    rcl QWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcl QWORD PTR [rbx], 0xff
    rcl QWORD PTR [rax], 0xff

// === RCR r8, 1 ===
    rcr dl, 1
    rcr bl, 1
    rcr cl, 1
    rcr al, 1

// === RCR m8, 1 ===
    rcr BYTE PTR [rax + rbx*1 + 0x10], 1
    rcr BYTE PTR [rbx], 1
    rcr BYTE PTR [rip + 0x100], 1
    rcr BYTE PTR [rax + rbx*4 + 0x100], 1
    rcr BYTE PTR [rax], 1
    rcr BYTE PTR [rip + 0x1000], 1

// === RCR r8, CL ===
    rcr cl, cl
    rcr al, cl
    rcr bl, cl
    rcr dl, cl

// === RCR m8, CL ===
    rcr BYTE PTR [rax + rbx*1 + 0x10], cl
    rcr BYTE PTR [rip + 0x100], cl
    rcr BYTE PTR [rax + rbx*4 + 0x100], cl
    rcr BYTE PTR [rip + 0x1000], cl
    rcr BYTE PTR [rax], cl
    rcr BYTE PTR [rbx], cl

// === RCR r8, imm8 ===
    rcr bl, 0xff
    rcr dl, 0xff
    rcr al, 0xff
    rcr cl, 0xff

// === RCR m8, imm8 ===
    rcr BYTE PTR [rax], 0xff
    rcr BYTE PTR [rip + 0x100], 0xff
    rcr BYTE PTR [rax + rbx*4 + 0x100], 0xff
    rcr BYTE PTR [rbx], 0xff
    rcr BYTE PTR [rip + 0x1000], 0xff
    rcr BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === RCR r16, 1 ===
    rcr dx, 1
    rcr ax, 1
    rcr si, 1
    rcr di, 1
    rcr cx, 1
    rcr bx, 1

// === RCR m16, 1 ===
    rcr WORD PTR [rax + rbx*4 + 0x100], 1
    rcr WORD PTR [rip + 0x100], 1
    rcr WORD PTR [rbx], 1
    rcr WORD PTR [rax + rbx*1 + 0x10], 1
    rcr WORD PTR [rax], 1
    rcr WORD PTR [rip + 0x1000], 1

// === RCR r16, CL ===
    rcr di, cl
    rcr si, cl
    rcr ax, cl
    rcr dx, cl
    rcr cx, cl
    rcr bx, cl

// === RCR m16, CL ===
    rcr WORD PTR [rax + rbx*4 + 0x100], cl
    rcr WORD PTR [rax + rbx*1 + 0x10], cl
    rcr WORD PTR [rax], cl
    rcr WORD PTR [rip + 0x1000], cl
    rcr WORD PTR [rip + 0x100], cl
    rcr WORD PTR [rbx], cl

// === RCR r16, imm8 ===
    rcr cx, 0xff
    rcr ax, 0xff
    rcr si, 0xff
    rcr dx, 0xff
    rcr di, 0xff
    rcr bx, 0xff

// === RCR m16, imm8 ===
    rcr WORD PTR [rax + rbx*4 + 0x100], 0xff
    rcr WORD PTR [rip + 0x100], 0xff
    rcr WORD PTR [rip + 0x1000], 0xff
    rcr WORD PTR [rax], 0xff
    rcr WORD PTR [rbx], 0xff
    rcr WORD PTR [rax + rbx*1 + 0x10], 0xff

// === RCR r32, 1 ===
    rcr ecx, 1
    rcr edi, 1
    rcr ebx, 1
    rcr esi, 1
    rcr edx, 1
    rcr eax, 1

// === RCR m32, 1 ===
    rcr DWORD PTR [rip + 0x1000], 1
    rcr DWORD PTR [rax], 1
    rcr DWORD PTR [rax + rbx*1 + 0x10], 1
    rcr DWORD PTR [rbx], 1
    rcr DWORD PTR [rip + 0x100], 1
    rcr DWORD PTR [rax + rbx*4 + 0x100], 1

// === RCR r64, 1 ===
    rcr rdx, 1
    rcr r13, 1
    rcr r8, 1
    rcr rbx, 1
    rcr rcx, 1
    rcr rdi, 1
    rcr r11, 1
    rcr rax, 1
    rcr r9, 1
    rcr r10, 1

// === RCR m64, 1 ===
    rcr QWORD PTR [rax + rbx*4 + 0x100], 1
    rcr QWORD PTR [rip + 0x100], 1
    rcr QWORD PTR [rax], 1
    rcr QWORD PTR [rax + rbx*1 + 0x10], 1
    rcr QWORD PTR [rip + 0x1000], 1
    rcr QWORD PTR [rbx], 1

// === RCR r32, CL ===
    rcr eax, cl
    rcr ecx, cl
    rcr esi, cl
    rcr ebx, cl
    rcr edx, cl
    rcr edi, cl

// === RCR m32, CL ===
    rcr DWORD PTR [rbx], cl
    rcr DWORD PTR [rip + 0x1000], cl
    rcr DWORD PTR [rip + 0x100], cl
    rcr DWORD PTR [rax + rbx*4 + 0x100], cl
    rcr DWORD PTR [rax], cl
    rcr DWORD PTR [rax + rbx*1 + 0x10], cl

// === RCR r64, CL ===
    rcr r10, cl
    rcr rdi, cl
    rcr r11, cl
    rcr r9, cl
    rcr rdx, cl
    rcr rax, cl
    rcr r12, cl
    rcr rbx, cl
    rcr rsi, cl
    rcr r8, cl

// === RCR m64, CL ===
    rcr QWORD PTR [rax + rbx*1 + 0x10], cl
    rcr QWORD PTR [rip + 0x1000], cl
    rcr QWORD PTR [rax + rbx*4 + 0x100], cl
    rcr QWORD PTR [rbx], cl
    rcr QWORD PTR [rip + 0x100], cl
    rcr QWORD PTR [rax], cl

// === RCR r32, imm8 ===
    rcr eax, 0xff
    rcr edi, 0xff
    rcr ebx, 0xff
    rcr esi, 0xff
    rcr edx, 0xff
    rcr ecx, 0xff

// === RCR m32, imm8 ===
    rcr DWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcr DWORD PTR [rip + 0x100], 0xff
    rcr DWORD PTR [rax], 0xff
    rcr DWORD PTR [rbx], 0xff
    rcr DWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcr DWORD PTR [rip + 0x1000], 0xff

// === RCR r64, imm8 ===
    rcr rbx, 0xff
    rcr rdi, 0xff
    rcr rcx, 0xff
    rcr rsi, 0xff
    rcr r8, 0xff
    rcr rax, 0xff
    rcr r11, 0xff
    rcr r9, 0xff
    rcr r13, 0xff
    rcr r12, 0xff

// === RCR m64, imm8 ===
    rcr QWORD PTR [rbx], 0xff
    rcr QWORD PTR [rip + 0x100], 0xff
    rcr QWORD PTR [rip + 0x1000], 0xff
    rcr QWORD PTR [rax], 0xff
    rcr QWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcr QWORD PTR [rax + rbx*1 + 0x10], 0xff

// === ROL r8, 1 ===
    rol cl, 1
    rol al, 1
    rol dl, 1
    rol bl, 1

// === ROL m8, 1 ===
    rol BYTE PTR [rax], 1
    rol BYTE PTR [rip + 0x100], 1
    rol BYTE PTR [rax + rbx*1 + 0x10], 1
    rol BYTE PTR [rip + 0x1000], 1
    rol BYTE PTR [rbx], 1
    rol BYTE PTR [rax + rbx*4 + 0x100], 1

// === ROL r8, CL ===
    rol bl, cl
    rol al, cl
    rol cl, cl
    rol dl, cl

// === ROL m8, CL ===
    rol BYTE PTR [rip + 0x100], cl
    rol BYTE PTR [rax + rbx*1 + 0x10], cl
    rol BYTE PTR [rax], cl
    rol BYTE PTR [rip + 0x1000], cl
    rol BYTE PTR [rbx], cl
    rol BYTE PTR [rax + rbx*4 + 0x100], cl

// === ROL r8, imm8 ===
    rol dl, 0xff
    rol cl, 0xff
    rol al, 0xff
    rol bl, 0xff

// === ROL m8, imm8 ===
    rol BYTE PTR [rip + 0x1000], 0xff
    rol BYTE PTR [rax + rbx*1 + 0x10], 0xff
    rol BYTE PTR [rax], 0xff
    rol BYTE PTR [rip + 0x100], 0xff
    rol BYTE PTR [rax + rbx*4 + 0x100], 0xff
    rol BYTE PTR [rbx], 0xff

// === ROL r16, 1 ===
    rol dx, 1
    rol bx, 1
    rol cx, 1
    rol ax, 1
    rol di, 1
    rol si, 1

// === ROL m16, 1 ===
    rol WORD PTR [rip + 0x100], 1
    rol WORD PTR [rax], 1
    rol WORD PTR [rbx], 1
    rol WORD PTR [rax + rbx*4 + 0x100], 1
    rol WORD PTR [rip + 0x1000], 1
    rol WORD PTR [rax + rbx*1 + 0x10], 1

// === ROL r16, CL ===
    rol dx, cl
    rol cx, cl
    rol si, cl
    rol di, cl
    rol ax, cl
    rol bx, cl

// === ROL m16, CL ===
    rol WORD PTR [rbx], cl
    rol WORD PTR [rax], cl
    rol WORD PTR [rax + rbx*4 + 0x100], cl
    rol WORD PTR [rip + 0x100], cl
    rol WORD PTR [rax + rbx*1 + 0x10], cl
    rol WORD PTR [rip + 0x1000], cl

// === ROL r16, imm8 ===
    rol dx, 0xff
    rol di, 0xff
    rol ax, 0xff
    rol cx, 0xff
    rol bx, 0xff
    rol si, 0xff

// === ROL m16, imm8 ===
    rol WORD PTR [rip + 0x100], 0xff
    rol WORD PTR [rax + rbx*4 + 0x100], 0xff
    rol WORD PTR [rip + 0x1000], 0xff
    rol WORD PTR [rax], 0xff
    rol WORD PTR [rax + rbx*1 + 0x10], 0xff
    rol WORD PTR [rbx], 0xff

// === ROL r32, 1 ===
    rol edi, 1
    rol edx, 1
    rol ecx, 1
    rol ebx, 1
    rol eax, 1
    rol esi, 1

// === ROL m32, 1 ===
    rol DWORD PTR [rip + 0x1000], 1
    rol DWORD PTR [rax + rbx*4 + 0x100], 1
    rol DWORD PTR [rax], 1
    rol DWORD PTR [rax + rbx*1 + 0x10], 1
    rol DWORD PTR [rip + 0x100], 1
    rol DWORD PTR [rbx], 1

// === ROL r64, 1 ===
    rol rdi, 1
    rol rax, 1
    rol r9, 1
    rol rcx, 1
    rol r13, 1
    rol r10, 1
    rol rbx, 1
    rol rsi, 1
    rol r12, 1
    rol rdx, 1

// === ROL m64, 1 ===
    rol QWORD PTR [rbx], 1
    rol QWORD PTR [rax], 1
    rol QWORD PTR [rip + 0x100], 1
    rol QWORD PTR [rax + rbx*1 + 0x10], 1
    rol QWORD PTR [rax + rbx*4 + 0x100], 1
    rol QWORD PTR [rip + 0x1000], 1

// === ROL r32, CL ===
    rol eax, cl
    rol ecx, cl
    rol ebx, cl
    rol edx, cl
    rol edi, cl
    rol esi, cl

// === ROL m32, CL ===
    rol DWORD PTR [rax], cl
    rol DWORD PTR [rax + rbx*4 + 0x100], cl
    rol DWORD PTR [rip + 0x100], cl
    rol DWORD PTR [rip + 0x1000], cl
    rol DWORD PTR [rax + rbx*1 + 0x10], cl
    rol DWORD PTR [rbx], cl

// === ROL r64, CL ===
    rol rdi, cl
    rol rdx, cl
    rol r13, cl
    rol r10, cl
    rol r12, cl
    rol rcx, cl
    rol rax, cl
    rol r9, cl
    rol rsi, cl
    rol rbx, cl

// === ROL m64, CL ===
    rol QWORD PTR [rip + 0x100], cl
    rol QWORD PTR [rax], cl
    rol QWORD PTR [rbx], cl
    rol QWORD PTR [rax + rbx*4 + 0x100], cl
    rol QWORD PTR [rax + rbx*1 + 0x10], cl
    rol QWORD PTR [rip + 0x1000], cl

// === ROL r32, imm8 ===
    rol ecx, 0xff
    rol esi, 0xff
    rol edi, 0xff
    rol ebx, 0xff
    rol eax, 0xff
    rol edx, 0xff

// === ROL m32, imm8 ===
    rol DWORD PTR [rip + 0x1000], 0xff
    rol DWORD PTR [rax + rbx*4 + 0x100], 0xff
    rol DWORD PTR [rbx], 0xff
    rol DWORD PTR [rax], 0xff
    rol DWORD PTR [rax + rbx*1 + 0x10], 0xff
    rol DWORD PTR [rip + 0x100], 0xff

// === ROL r64, imm8 ===
    rol rdx, 0xff
    rol rsi, 0xff
    rol rbx, 0xff
    rol r8, 0xff
    rol r12, 0xff
    rol rdi, 0xff
    rol r10, 0xff
    rol r11, 0xff
    rol r13, 0xff
    rol rax, 0xff

// === ROL m64, imm8 ===
    rol QWORD PTR [rip + 0x100], 0xff
    rol QWORD PTR [rip + 0x1000], 0xff
    rol QWORD PTR [rax + rbx*1 + 0x10], 0xff
    rol QWORD PTR [rax + rbx*4 + 0x100], 0xff
    rol QWORD PTR [rbx], 0xff
    rol QWORD PTR [rax], 0xff

// === ROR r8, 1 ===
    ror dl, 1
    ror al, 1
    ror bl, 1
    ror cl, 1

// === ROR m8, 1 ===
    ror BYTE PTR [rax + rbx*4 + 0x100], 1
    ror BYTE PTR [rbx], 1
    ror BYTE PTR [rax + rbx*1 + 0x10], 1
    ror BYTE PTR [rax], 1
    ror BYTE PTR [rip + 0x100], 1
    ror BYTE PTR [rip + 0x1000], 1

// === ROR r8, CL ===
    ror bl, cl
    ror al, cl
    ror dl, cl
    ror cl, cl

// === ROR m8, CL ===
    ror BYTE PTR [rax], cl
    ror BYTE PTR [rax + rbx*4 + 0x100], cl
    ror BYTE PTR [rbx], cl
    ror BYTE PTR [rip + 0x1000], cl
    ror BYTE PTR [rax + rbx*1 + 0x10], cl
    ror BYTE PTR [rip + 0x100], cl

// === ROR r8, imm8 ===
    ror dl, 0xff
    ror al, 0xff
    ror bl, 0xff
    ror cl, 0xff

// === ROR m8, imm8 ===
    ror BYTE PTR [rbx], 0xff
    ror BYTE PTR [rip + 0x100], 0xff
    ror BYTE PTR [rip + 0x1000], 0xff
    ror BYTE PTR [rax + rbx*4 + 0x100], 0xff
    ror BYTE PTR [rax], 0xff
    ror BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === ROR r16, 1 ===
    ror di, 1
    ror cx, 1
    ror dx, 1
    ror ax, 1
    ror bx, 1
    ror si, 1

// === ROR m16, 1 ===
    ror WORD PTR [rip + 0x100], 1
    ror WORD PTR [rip + 0x1000], 1
    ror WORD PTR [rax + rbx*4 + 0x100], 1
    ror WORD PTR [rax + rbx*1 + 0x10], 1
    ror WORD PTR [rbx], 1
    ror WORD PTR [rax], 1

// === ROR r16, CL ===
    ror ax, cl
    ror bx, cl
    ror si, cl
    ror cx, cl
    ror dx, cl
    ror di, cl

// === ROR m16, CL ===
    ror WORD PTR [rip + 0x1000], cl
    ror WORD PTR [rip + 0x100], cl
    ror WORD PTR [rax], cl
    ror WORD PTR [rax + rbx*4 + 0x100], cl
    ror WORD PTR [rax + rbx*1 + 0x10], cl
    ror WORD PTR [rbx], cl

// === ROR r16, imm8 ===
    ror di, 0xff
    ror bx, 0xff
    ror dx, 0xff
    ror si, 0xff
    ror ax, 0xff
    ror cx, 0xff

// === ROR m16, imm8 ===
    ror WORD PTR [rax], 0xff
    ror WORD PTR [rip + 0x100], 0xff
    ror WORD PTR [rax + rbx*1 + 0x10], 0xff
    ror WORD PTR [rax + rbx*4 + 0x100], 0xff
    ror WORD PTR [rip + 0x1000], 0xff
    ror WORD PTR [rbx], 0xff

// === ROR r32, 1 ===
    ror edi, 1
    ror eax, 1
    ror ebx, 1
    ror ecx, 1
    ror esi, 1
    ror edx, 1

// === ROR m32, 1 ===
    ror DWORD PTR [rax + rbx*1 + 0x10], 1
    ror DWORD PTR [rip + 0x1000], 1
    ror DWORD PTR [rip + 0x100], 1
    ror DWORD PTR [rax], 1
    ror DWORD PTR [rax + rbx*4 + 0x100], 1
    ror DWORD PTR [rbx], 1

// === ROR r64, 1 ===
    ror rdx, 1
    ror rbx, 1
    ror rdi, 1
    ror r12, 1
    ror rax, 1
    ror r10, 1
    ror r11, 1
    ror rsi, 1
    ror r8, 1
    ror r13, 1

// === ROR m64, 1 ===
    ror QWORD PTR [rip + 0x100], 1
    ror QWORD PTR [rax], 1
    ror QWORD PTR [rax + rbx*1 + 0x10], 1
    ror QWORD PTR [rbx], 1
    ror QWORD PTR [rip + 0x1000], 1
    ror QWORD PTR [rax + rbx*4 + 0x100], 1

// === ROR r32, CL ===
    ror ebx, cl
    ror edi, cl
    ror esi, cl
    ror eax, cl
    ror ecx, cl
    ror edx, cl

// === ROR m32, CL ===
    ror DWORD PTR [rip + 0x100], cl
    ror DWORD PTR [rip + 0x1000], cl
    ror DWORD PTR [rax], cl
    ror DWORD PTR [rbx], cl
    ror DWORD PTR [rax + rbx*1 + 0x10], cl
    ror DWORD PTR [rax + rbx*4 + 0x100], cl

// === ROR r64, CL ===
    ror rcx, cl
    ror rax, cl
    ror r8, cl
    ror rdi, cl
    ror r13, cl
    ror rsi, cl
    ror r11, cl
    ror r9, cl
    ror r10, cl
    ror rbx, cl

// === ROR m64, CL ===
    ror QWORD PTR [rbx], cl
    ror QWORD PTR [rax + rbx*1 + 0x10], cl
    ror QWORD PTR [rax], cl
    ror QWORD PTR [rip + 0x1000], cl
    ror QWORD PTR [rax + rbx*4 + 0x100], cl
    ror QWORD PTR [rip + 0x100], cl

// === ROR r32, imm8 ===
    ror edi, 0xff
    ror ecx, 0xff
    ror edx, 0xff
    ror ebx, 0xff
    ror eax, 0xff
    ror esi, 0xff

// === ROR m32, imm8 ===
    ror DWORD PTR [rax], 0xff
    ror DWORD PTR [rip + 0x1000], 0xff
    ror DWORD PTR [rbx], 0xff
    ror DWORD PTR [rip + 0x100], 0xff
    ror DWORD PTR [rax + rbx*4 + 0x100], 0xff
    ror DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === ROR r64, imm8 ===
    ror r9, 0xff
    ror r12, 0xff
    ror r10, 0xff
    ror r13, 0xff
    ror rcx, 0xff
    ror r11, 0xff
    ror rbx, 0xff
    ror r8, 0xff
    ror rax, 0xff
    ror rdx, 0xff

// === ROR m64, imm8 ===
    ror QWORD PTR [rax], 0xff
    ror QWORD PTR [rip + 0x100], 0xff
    ror QWORD PTR [rax + rbx*1 + 0x10], 0xff
    ror QWORD PTR [rax + rbx*4 + 0x100], 0xff
    ror QWORD PTR [rip + 0x1000], 0xff
    ror QWORD PTR [rbx], 0xff

// === RDMSR ===
    rdmsr

// === RDPKRU ===
    rdpkru

// === RDPMC ===
    rdpmc

// === RDTSC ===
    rdtsc

// === RDTSCP ===
    rdtscp

// === REP INS m8, DX ===
    rep insb

// === REP INS m16, DX ===
    rep insw

// === REP INS m32, DX ===
    rep insd

// === REP LODS AL ===
    rep lodsb

// === REP LODS AX ===
    rep lodsw

// === REP LODS EAX ===
    rep lodsd

// === REP LODS RAX ===
    rep lodsq

// === REP MOVS m8, m8 ===
    rep movsb

// === REP MOVS m16, m16 ===
    rep movsw

// === REP MOVS m32, m32 ===
    rep movsd

// === REP MOVS m64, m64 ===
    rep movsq

// === REP OUTS DX, m8 ===
    rep outsb

// === REP OUTS DX, m16 ===
    rep outsw

// === REP OUTS DX, m32 ===
    rep outsd

// === REP STOS m8 ===
    rep stosb

// === REP STOS m16 ===
    rep stosw

// === REP STOS m32 ===
    rep stosd

// === REP STOS m64 ===
    rep stosq

// === REPE CMPS m8, m8 ===
    repe cmpsb

// === REPE CMPS m16, m16 ===
    repe cmpsw

// === REPE CMPS m32, m32 ===
    repe cmpsd

// === REPE CMPS m64, m64 ===
    repe cmpsq

// === REPE SCAS m8 ===
    repe scasb

// === REPE SCAS m16 ===
    repe scasw

// === REPE SCAS m32 ===
    repe scasd

// === REPE SCAS m64 ===
    repe scasq

// === REPNE CMPS m8, m8 ===
    repne cmpsb

// === REPNE CMPS m16, m16 ===
    repne cmpsw

// === REPNE CMPS m32, m32 ===
    repne cmpsd

// === REPNE CMPS m64, m64 ===
    repne cmpsq

// === REPNE SCAS m8 ===
    repne scasb

// === REPNE SCAS m16 ===
    repne scasw

// === REPNE SCAS m32 ===
    repne scasd

// === REPNE SCAS m64 ===
    repne scasq

// === RET ===
    ret

// === RET imm16 ===
    ret 0xffff

// === RSM ===
    rsm

// === SAHF ===
    sahf

// === SAL r8, 1 ===
    sal bl, 1
    sal dl, 1
    sal cl, 1
    sal al, 1

// === SAL m8, 1 ===
    sal BYTE PTR [rax + rbx*1 + 0x10], 1
    sal BYTE PTR [rax + rbx*4 + 0x100], 1
    sal BYTE PTR [rbx], 1
    sal BYTE PTR [rip + 0x100], 1
    sal BYTE PTR [rax], 1
    sal BYTE PTR [rip + 0x1000], 1

// === SAL r8, CL ===
    sal al, cl
    sal dl, cl
    sal cl, cl
    sal bl, cl

// === SAL m8, CL ===
    sal BYTE PTR [rax + rbx*4 + 0x100], cl
    sal BYTE PTR [rax], cl
    sal BYTE PTR [rbx], cl
    sal BYTE PTR [rip + 0x100], cl
    sal BYTE PTR [rip + 0x1000], cl
    sal BYTE PTR [rax + rbx*1 + 0x10], cl

// === SAL r8, imm8 ===
    sal cl, 0xff
    sal bl, 0xff
    sal al, 0xff
    sal dl, 0xff

// === SAL m8, imm8 ===
    sal BYTE PTR [rip + 0x100], 0xff
    sal BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sal BYTE PTR [rax], 0xff
    sal BYTE PTR [rbx], 0xff
    sal BYTE PTR [rax + rbx*1 + 0x10], 0xff
    sal BYTE PTR [rip + 0x1000], 0xff

// === SAL r16, 1 ===
    sal dx, 1
    sal bx, 1
    sal ax, 1
    sal cx, 1
    sal si, 1
    sal di, 1

// === SAL m16, 1 ===
    sal WORD PTR [rax + rbx*1 + 0x10], 1
    sal WORD PTR [rip + 0x1000], 1
    sal WORD PTR [rbx], 1
    sal WORD PTR [rax], 1
    sal WORD PTR [rip + 0x100], 1
    sal WORD PTR [rax + rbx*4 + 0x100], 1

// === SAL r16, CL ===
    sal si, cl
    sal dx, cl
    sal cx, cl
    sal ax, cl
    sal bx, cl
    sal di, cl

// === SAL m16, CL ===
    sal WORD PTR [rax], cl
    sal WORD PTR [rip + 0x100], cl
    sal WORD PTR [rax + rbx*1 + 0x10], cl
    sal WORD PTR [rip + 0x1000], cl
    sal WORD PTR [rbx], cl
    sal WORD PTR [rax + rbx*4 + 0x100], cl

// === SAL r16, imm8 ===
    sal ax, 0xff
    sal si, 0xff
    sal cx, 0xff
    sal bx, 0xff
    sal di, 0xff
    sal dx, 0xff

// === SAL m16, imm8 ===
    sal WORD PTR [rax], 0xff
    sal WORD PTR [rax + rbx*4 + 0x100], 0xff
    sal WORD PTR [rip + 0x1000], 0xff
    sal WORD PTR [rax + rbx*1 + 0x10], 0xff
    sal WORD PTR [rip + 0x100], 0xff
    sal WORD PTR [rbx], 0xff

// === SAL r32, 1 ===
    sal eax, 1
    sal esi, 1
    sal edx, 1
    sal ebx, 1
    sal edi, 1
    sal ecx, 1

// === SAL m32, 1 ===
    sal DWORD PTR [rax + rbx*4 + 0x100], 1
    sal DWORD PTR [rax + rbx*1 + 0x10], 1
    sal DWORD PTR [rax], 1
    sal DWORD PTR [rip + 0x1000], 1
    sal DWORD PTR [rbx], 1
    sal DWORD PTR [rip + 0x100], 1

// === SAL r64, 1 ===
    sal r10, 1
    sal rdi, 1
    sal r11, 1
    sal r12, 1
    sal rdx, 1
    sal rbx, 1
    sal r9, 1
    sal rcx, 1
    sal rax, 1
    sal r8, 1

// === SAL m64, 1 ===
    sal QWORD PTR [rbx], 1
    sal QWORD PTR [rip + 0x1000], 1
    sal QWORD PTR [rax], 1
    sal QWORD PTR [rip + 0x100], 1
    sal QWORD PTR [rax + rbx*4 + 0x100], 1
    sal QWORD PTR [rax + rbx*1 + 0x10], 1

// === SAL r32, CL ===
    sal edi, cl
    sal eax, cl
    sal esi, cl
    sal ecx, cl
    sal edx, cl
    sal ebx, cl

// === SAL m32, CL ===
    sal DWORD PTR [rbx], cl
    sal DWORD PTR [rax], cl
    sal DWORD PTR [rax + rbx*1 + 0x10], cl
    sal DWORD PTR [rip + 0x1000], cl
    sal DWORD PTR [rax + rbx*4 + 0x100], cl
    sal DWORD PTR [rip + 0x100], cl

// === SAL r64, CL ===
    sal rbx, cl
    sal rax, cl
    sal rsi, cl
    sal r11, cl
    sal rcx, cl
    sal rdi, cl
    sal r12, cl
    sal r8, cl
    sal r9, cl
    sal r10, cl

// === SAL m64, CL ===
    sal QWORD PTR [rax + rbx*4 + 0x100], cl
    sal QWORD PTR [rip + 0x100], cl
    sal QWORD PTR [rax + rbx*1 + 0x10], cl
    sal QWORD PTR [rip + 0x1000], cl
    sal QWORD PTR [rbx], cl
    sal QWORD PTR [rax], cl

// === SAL r32, imm8 ===
    sal esi, 0xff
    sal ecx, 0xff
    sal ebx, 0xff
    sal edi, 0xff
    sal eax, 0xff
    sal edx, 0xff

// === SAL m32, imm8 ===
    sal DWORD PTR [rax + rbx*1 + 0x10], 0xff
    sal DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sal DWORD PTR [rip + 0x100], 0xff
    sal DWORD PTR [rbx], 0xff
    sal DWORD PTR [rax], 0xff
    sal DWORD PTR [rip + 0x1000], 0xff

// === SAL r64, imm8 ===
    sal r13, 0xff
    sal r12, 0xff
    sal r9, 0xff
    sal rsi, 0xff
    sal r11, 0xff
    sal r8, 0xff
    sal rax, 0xff
    sal rbx, 0xff
    sal rdi, 0xff
    sal r10, 0xff

// === SAL m64, imm8 ===
    sal QWORD PTR [rbx], 0xff
    sal QWORD PTR [rip + 0x100], 0xff
    sal QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sal QWORD PTR [rip + 0x1000], 0xff
    sal QWORD PTR [rax], 0xff
    sal QWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SAR r8, 1 ===
    sar al, 1
    sar cl, 1
    sar bl, 1
    sar dl, 1

// === SAR m8, 1 ===
    sar BYTE PTR [rbx], 1
    sar BYTE PTR [rax], 1
    sar BYTE PTR [rax + rbx*4 + 0x100], 1
    sar BYTE PTR [rip + 0x100], 1
    sar BYTE PTR [rip + 0x1000], 1
    sar BYTE PTR [rax + rbx*1 + 0x10], 1

// === SAR r8, CL ===
    sar dl, cl
    sar bl, cl
    sar al, cl
    sar cl, cl

// === SAR m8, CL ===
    sar BYTE PTR [rip + 0x100], cl
    sar BYTE PTR [rip + 0x1000], cl
    sar BYTE PTR [rbx], cl
    sar BYTE PTR [rax], cl
    sar BYTE PTR [rax + rbx*4 + 0x100], cl
    sar BYTE PTR [rax + rbx*1 + 0x10], cl

// === SAR r8, imm8 ===
    sar dl, 0xff
    sar al, 0xff
    sar cl, 0xff
    sar bl, 0xff

// === SAR m8, imm8 ===
    sar BYTE PTR [rip + 0x1000], 0xff
    sar BYTE PTR [rbx], 0xff
    sar BYTE PTR [rax + rbx*1 + 0x10], 0xff
    sar BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sar BYTE PTR [rax], 0xff
    sar BYTE PTR [rip + 0x100], 0xff

// === SAR r16,1 ===
    sar di, 1
    sar bx, 1
    sar ax, 1
    sar cx, 1
    sar dx, 1
    sar si, 1

// === SAR m16,1 ===
    sar WORD PTR [rip + 0x1000], 1
    sar WORD PTR [rax], 1
    sar WORD PTR [rbx], 1
    sar WORD PTR [rax + rbx*1 + 0x10], 1
    sar WORD PTR [rip + 0x100], 1
    sar WORD PTR [rax + rbx*4 + 0x100], 1

// === SAR r16, CL ===
    sar ax, cl
    sar di, cl
    sar bx, cl
    sar dx, cl
    sar cx, cl
    sar si, cl

// === SAR m16, CL ===
    sar WORD PTR [rax + rbx*4 + 0x100], cl
    sar WORD PTR [rip + 0x100], cl
    sar WORD PTR [rax + rbx*1 + 0x10], cl
    sar WORD PTR [rbx], cl
    sar WORD PTR [rip + 0x1000], cl
    sar WORD PTR [rax], cl

// === SAR r16, imm8 ===
    sar cx, 0xff
    sar dx, 0xff
    sar di, 0xff
    sar si, 0xff
    sar ax, 0xff
    sar bx, 0xff

// === SAR m16, imm8 ===
    sar WORD PTR [rip + 0x100], 0xff
    sar WORD PTR [rax], 0xff
    sar WORD PTR [rax + rbx*1 + 0x10], 0xff
    sar WORD PTR [rbx], 0xff
    sar WORD PTR [rax + rbx*4 + 0x100], 0xff
    sar WORD PTR [rip + 0x1000], 0xff

// === SAR r32, 1 ===
    sar ebx, 1
    sar edi, 1
    sar esi, 1
    sar eax, 1
    sar ecx, 1
    sar edx, 1

// === SAR m32, 1 ===
    sar DWORD PTR [rip + 0x100], 1
    sar DWORD PTR [rip + 0x1000], 1
    sar DWORD PTR [rax + rbx*4 + 0x100], 1
    sar DWORD PTR [rax], 1
    sar DWORD PTR [rbx], 1
    sar DWORD PTR [rax + rbx*1 + 0x10], 1

// === SAR r64, 1 ===
    sar rbx, 1
    sar rax, 1
    sar r8, 1
    sar rdx, 1
    sar rcx, 1
    sar r11, 1
    sar r9, 1
    sar r12, 1
    sar rsi, 1
    sar rdi, 1

// === SAR m64, 1 ===
    sar QWORD PTR [rbx], 1
    sar QWORD PTR [rip + 0x100], 1
    sar QWORD PTR [rax], 1
    sar QWORD PTR [rax + rbx*4 + 0x100], 1
    sar QWORD PTR [rax + rbx*1 + 0x10], 1
    sar QWORD PTR [rip + 0x1000], 1

// === SAR r32, CL ===
    sar ebx, cl
    sar edx, cl
    sar edi, cl
    sar ecx, cl
    sar eax, cl
    sar esi, cl

// === SAR m32, CL ===
    sar DWORD PTR [rbx], cl
    sar DWORD PTR [rax], cl
    sar DWORD PTR [rax + rbx*1 + 0x10], cl
    sar DWORD PTR [rax + rbx*4 + 0x100], cl
    sar DWORD PTR [rip + 0x100], cl
    sar DWORD PTR [rip + 0x1000], cl

// === SAR r64, CL ===
    sar r11, cl
    sar rbx, cl
    sar rax, cl
    sar rdi, cl
    sar r10, cl
    sar rdx, cl
    sar r12, cl
    sar r8, cl
    sar rsi, cl
    sar rcx, cl

// === SAR m64, CL ===
    sar QWORD PTR [rax], cl
    sar QWORD PTR [rax + rbx*1 + 0x10], cl
    sar QWORD PTR [rip + 0x1000], cl
    sar QWORD PTR [rip + 0x100], cl
    sar QWORD PTR [rax + rbx*4 + 0x100], cl
    sar QWORD PTR [rbx], cl

// === SAR r32, imm8 ===
    sar edi, 0xff
    sar esi, 0xff
    sar eax, 0xff
    sar edx, 0xff
    sar ecx, 0xff
    sar ebx, 0xff

// === SAR m32, imm8 ===
    sar DWORD PTR [rax], 0xff
    sar DWORD PTR [rax + rbx*1 + 0x10], 0xff
    sar DWORD PTR [rip + 0x1000], 0xff
    sar DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sar DWORD PTR [rbx], 0xff
    sar DWORD PTR [rip + 0x100], 0xff

// === SAR r64, imm8 ===
    sar r12, 0xff
    sar rax, 0xff
    sar rdi, 0xff
    sar rbx, 0xff
    sar r9, 0xff
    sar rsi, 0xff
    sar rcx, 0xff
    sar r13, 0xff
    sar rdx, 0xff
    sar r10, 0xff

// === SAR m64, imm8 ===
    sar QWORD PTR [rip + 0x1000], 0xff
    sar QWORD PTR [rbx], 0xff
    sar QWORD PTR [rip + 0x100], 0xff
    sar QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sar QWORD PTR [rax + rbx*1 + 0x10], 0xff
    sar QWORD PTR [rax], 0xff

// === SHL r8, 1 ===
    shl bl, 1
    shl dl, 1
    shl cl, 1
    shl al, 1

// === SHL m8, 1 ===
    shl BYTE PTR [rax], 1
    shl BYTE PTR [rbx], 1
    shl BYTE PTR [rax + rbx*1 + 0x10], 1
    shl BYTE PTR [rip + 0x100], 1
    shl BYTE PTR [rip + 0x1000], 1
    shl BYTE PTR [rax + rbx*4 + 0x100], 1

// === SHL r8, CL ===
    shl al, cl
    shl dl, cl
    shl cl, cl
    shl bl, cl

// === SHL m8, CL ===
    shl BYTE PTR [rip + 0x1000], cl
    shl BYTE PTR [rbx], cl
    shl BYTE PTR [rax + rbx*1 + 0x10], cl
    shl BYTE PTR [rip + 0x100], cl
    shl BYTE PTR [rax + rbx*4 + 0x100], cl
    shl BYTE PTR [rax], cl

// === SHL r8, imm8 ===
    shl dl, 0xff
    shl cl, 0xff
    shl bl, 0xff
    shl al, 0xff

// === SHL m8, imm8 ===
    shl BYTE PTR [rax], 0xff
    shl BYTE PTR [rax + rbx*1 + 0x10], 0xff
    shl BYTE PTR [rax + rbx*4 + 0x100], 0xff
    shl BYTE PTR [rip + 0x1000], 0xff
    shl BYTE PTR [rip + 0x100], 0xff
    shl BYTE PTR [rbx], 0xff

// === SHL r16,1 ===
    shl ax, 1
    shl di, 1
    shl dx, 1
    shl bx, 1
    shl si, 1
    shl cx, 1

// === SHL m16,1 ===
    shl WORD PTR [rax + rbx*1 + 0x10], 1
    shl WORD PTR [rip + 0x100], 1
    shl WORD PTR [rax], 1
    shl WORD PTR [rbx], 1
    shl WORD PTR [rax + rbx*4 + 0x100], 1
    shl WORD PTR [rip + 0x1000], 1

// === SHL r16, CL ===
    shl dx, cl
    shl si, cl
    shl cx, cl
    shl ax, cl
    shl di, cl
    shl bx, cl

// === SHL m16, CL ===
    shl WORD PTR [rip + 0x100], cl
    shl WORD PTR [rax + rbx*1 + 0x10], cl
    shl WORD PTR [rip + 0x1000], cl
    shl WORD PTR [rbx], cl
    shl WORD PTR [rax + rbx*4 + 0x100], cl
    shl WORD PTR [rax], cl

// === SHL r16, imm8 ===
    shl bx, 0xff
    shl si, 0xff
    shl ax, 0xff
    shl cx, 0xff
    shl dx, 0xff
    shl di, 0xff

// === SHL m16, imm8 ===
    shl WORD PTR [rax + rbx*4 + 0x100], 0xff
    shl WORD PTR [rbx], 0xff
    shl WORD PTR [rip + 0x100], 0xff
    shl WORD PTR [rip + 0x1000], 0xff
    shl WORD PTR [rax + rbx*1 + 0x10], 0xff
    shl WORD PTR [rax], 0xff

// === SHL r32,1 ===
    shl eax, 1
    shl ebx, 1
    shl edx, 1
    shl ecx, 1
    shl edi, 1
    shl esi, 1

// === SHL m32,1 ===
    shl DWORD PTR [rip + 0x1000], 1
    shl DWORD PTR [rax], 1
    shl DWORD PTR [rax + rbx*4 + 0x100], 1
    shl DWORD PTR [rip + 0x100], 1
    shl DWORD PTR [rbx], 1
    shl DWORD PTR [rax + rbx*1 + 0x10], 1

// === SHL r64,1 ===
    shl r8, 1
    shl r12, 1
    shl r11, 1
    shl r10, 1
    shl rdx, 1
    shl rbx, 1
    shl r9, 1
    shl rsi, 1
    shl rdi, 1
    shl rcx, 1

// === SHL m64,1 ===
    shl QWORD PTR [rax], 1
    shl QWORD PTR [rbx], 1
    shl QWORD PTR [rip + 0x100], 1
    shl QWORD PTR [rax + rbx*1 + 0x10], 1
    shl QWORD PTR [rax + rbx*4 + 0x100], 1
    shl QWORD PTR [rip + 0x1000], 1

// === SHL r32, CL ===
    shl ecx, cl
    shl eax, cl
    shl edi, cl
    shl ebx, cl
    shl edx, cl
    shl esi, cl

// === SHL m32, CL ===
    shl DWORD PTR [rax], cl
    shl DWORD PTR [rax + rbx*4 + 0x100], cl
    shl DWORD PTR [rip + 0x1000], cl
    shl DWORD PTR [rip + 0x100], cl
    shl DWORD PTR [rax + rbx*1 + 0x10], cl
    shl DWORD PTR [rbx], cl

// === SHL r64, CL ===
    shl rax, cl
    shl rdi, cl
    shl r9, cl
    shl rcx, cl
    shl r11, cl
    shl rbx, cl
    shl r10, cl
    shl r12, cl
    shl r13, cl
    shl rsi, cl

// === SHL m64, CL ===
    shl QWORD PTR [rax + rbx*4 + 0x100], cl
    shl QWORD PTR [rbx], cl
    shl QWORD PTR [rip + 0x100], cl
    shl QWORD PTR [rax], cl
    shl QWORD PTR [rax + rbx*1 + 0x10], cl
    shl QWORD PTR [rip + 0x1000], cl

// === SHL r32, imm8 ===
    shl edi, 0xff
    shl ecx, 0xff
    shl ebx, 0xff
    shl esi, 0xff
    shl edx, 0xff
    shl eax, 0xff

// === SHL m32, imm8 ===
    shl DWORD PTR [rax + rbx*4 + 0x100], 0xff
    shl DWORD PTR [rip + 0x1000], 0xff
    shl DWORD PTR [rax], 0xff
    shl DWORD PTR [rax + rbx*1 + 0x10], 0xff
    shl DWORD PTR [rbx], 0xff
    shl DWORD PTR [rip + 0x100], 0xff

// === SHL r64, imm8 ===
    shl r10, 0xff
    shl r13, 0xff
    shl rbx, 0xff
    shl r12, 0xff
    shl rsi, 0xff
    shl r11, 0xff
    shl r8, 0xff
    shl rax, 0xff
    shl r9, 0xff
    shl rdi, 0xff

// === SHL m64, imm8 ===
    shl QWORD PTR [rax], 0xff
    shl QWORD PTR [rip + 0x1000], 0xff
    shl QWORD PTR [rip + 0x100], 0xff
    shl QWORD PTR [rbx], 0xff
    shl QWORD PTR [rax + rbx*4 + 0x100], 0xff
    shl QWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SHR r8, ===
    shr cl
    shr al
    shr bl
    shr dl

// === SHR m8, ===
    shr BYTE PTR [rax + rbx*1 + 0x10]
    shr BYTE PTR [rax + rbx*4 + 0x100]
    shr BYTE PTR [rax]
    shr BYTE PTR [rip + 0x1000]
    shr BYTE PTR [rbx]
    shr BYTE PTR [rip + 0x100]

// === SHR r8, CL ===
    shr dl, cl
    shr cl, cl
    shr bl, cl
    shr al, cl

// === SHR m8, CL ===
    shr BYTE PTR [rax + rbx*4 + 0x100], cl
    shr BYTE PTR [rax + rbx*1 + 0x10], cl
    shr BYTE PTR [rax], cl
    shr BYTE PTR [rbx], cl
    shr BYTE PTR [rip + 0x100], cl
    shr BYTE PTR [rip + 0x1000], cl

// === SHR r8, imm8 ===
    shr al, 0xff
    shr bl, 0xff
    shr cl, 0xff
    shr dl, 0xff

// === SHR m8, imm8 ===
    shr BYTE PTR [rbx], 0xff
    shr BYTE PTR [rax + rbx*1 + 0x10], 0xff
    shr BYTE PTR [rip + 0x100], 0xff
    shr BYTE PTR [rax + rbx*4 + 0x100], 0xff
    shr BYTE PTR [rax], 0xff
    shr BYTE PTR [rip + 0x1000], 0xff

// === SHR r16, 1 ===
    shr bx, 1
    shr di, 1
    shr ax, 1
    shr cx, 1
    shr si, 1
    shr dx, 1

// === SHR m16, 1 ===
    shr WORD PTR [rip + 0x1000], 1
    shr WORD PTR [rax + rbx*1 + 0x10], 1
    shr WORD PTR [rip + 0x100], 1
    shr WORD PTR [rax + rbx*4 + 0x100], 1
    shr WORD PTR [rbx], 1
    shr WORD PTR [rax], 1

// === SHR r16, CL ===
    shr di, cl
    shr bx, cl
    shr dx, cl
    shr ax, cl
    shr si, cl
    shr cx, cl

// === SHR m16, CL ===
    shr WORD PTR [rax + rbx*4 + 0x100], cl
    shr WORD PTR [rbx], cl
    shr WORD PTR [rip + 0x100], cl
    shr WORD PTR [rax], cl
    shr WORD PTR [rax + rbx*1 + 0x10], cl
    shr WORD PTR [rip + 0x1000], cl

// === SHR r16, imm8 ===
    shr bx, 0xff
    shr dx, 0xff
    shr ax, 0xff
    shr si, 0xff
    shr di, 0xff
    shr cx, 0xff

// === SHR m16, imm8 ===
    shr WORD PTR [rax + rbx*1 + 0x10], 0xff
    shr WORD PTR [rbx], 0xff
    shr WORD PTR [rax], 0xff
    shr WORD PTR [rax + rbx*4 + 0x100], 0xff
    shr WORD PTR [rip + 0x1000], 0xff
    shr WORD PTR [rip + 0x100], 0xff

// === SHR r32, 1 ===
    shr ecx, 1
    shr esi, 1
    shr edx, 1
    shr ebx, 1
    shr edi, 1
    shr eax, 1

// === SHR m32, 1 ===
    shr DWORD PTR [rip + 0x1000], 1
    shr DWORD PTR [rip + 0x100], 1
    shr DWORD PTR [rax + rbx*1 + 0x10], 1
    shr DWORD PTR [rbx], 1
    shr DWORD PTR [rax], 1
    shr DWORD PTR [rax + rbx*4 + 0x100], 1

// === SHR r64, 1 ===
    shr rdi, 1
    shr r10, 1
    shr rax, 1
    shr rdx, 1
    shr r9, 1
    shr r11, 1
    shr r8, 1
    shr rsi, 1
    shr r12, 1
    shr rbx, 1

// === SHR m64, 1 ===
    shr QWORD PTR [rbx], 1
    shr QWORD PTR [rax + rbx*1 + 0x10], 1
    shr QWORD PTR [rip + 0x1000], 1
    shr QWORD PTR [rax], 1
    shr QWORD PTR [rip + 0x100], 1
    shr QWORD PTR [rax + rbx*4 + 0x100], 1

// === SHR r32, CL ===
    shr edx, cl
    shr edi, cl
    shr eax, cl
    shr ecx, cl
    shr esi, cl
    shr ebx, cl

// === SHR m32, CL ===
    shr DWORD PTR [rbx], cl
    shr DWORD PTR [rip + 0x100], cl
    shr DWORD PTR [rax + rbx*4 + 0x100], cl
    shr DWORD PTR [rip + 0x1000], cl
    shr DWORD PTR [rax], cl
    shr DWORD PTR [rax + rbx*1 + 0x10], cl

// === SHR r64, CL ===
    shr rcx, cl
    shr r11, cl
    shr r9, cl
    shr rbx, cl
    shr rdi, cl
    shr rdx, cl
    shr r10, cl
    shr rax, cl
    shr r13, cl
    shr rsi, cl

// === SHR m64, CL ===
    shr QWORD PTR [rip + 0x100], cl
    shr QWORD PTR [rip + 0x1000], cl
    shr QWORD PTR [rax], cl
    shr QWORD PTR [rax + rbx*1 + 0x10], cl
    shr QWORD PTR [rax + rbx*4 + 0x100], cl
    shr QWORD PTR [rbx], cl

// === SHR r32, imm8 ===
    shr edi, 0xff
    shr edx, 0xff
    shr ebx, 0xff
    shr esi, 0xff
    shr ecx, 0xff
    shr eax, 0xff

// === SHR m32, imm8 ===
    shr DWORD PTR [rip + 0x100], 0xff
    shr DWORD PTR [rax], 0xff
    shr DWORD PTR [rax + rbx*4 + 0x100], 0xff
    shr DWORD PTR [rbx], 0xff
    shr DWORD PTR [rax + rbx*1 + 0x10], 0xff
    shr DWORD PTR [rip + 0x1000], 0xff

// === SHR r64, imm8 ===
    shr rax, 0xff
    shr rdi, 0xff
    shr r12, 0xff
    shr rbx, 0xff
    shr r9, 0xff
    shr rcx, 0xff
    shr r11, 0xff
    shr rsi, 0xff
    shr rdx, 0xff
    shr r8, 0xff

// === SHR m64, imm8 ===
    shr QWORD PTR [rax + rbx*4 + 0x100], 0xff
    shr QWORD PTR [rip + 0x1000], 0xff
    shr QWORD PTR [rax + rbx*1 + 0x10], 0xff
    shr QWORD PTR [rax], 0xff
    shr QWORD PTR [rbx], 0xff
    shr QWORD PTR [rip + 0x100], 0xff

// === SBB AL, imm8 ===
    sbb al, 0xff

// === SBB AX, imm16 ===
    sbb ax, 0xffff

// === SBB EAX, imm32 ===
    sbb eax, 0xffffffff

// === SBB RAX, imm32 ===
    sbb rax, 0x7fffffff
    sbb rax, -1

// === SBB r8, imm8 ===
    sbb cl, 0xff
    sbb bl, 0xff
    sbb al, 0xff
    sbb dl, 0xff

// === SBB m8, imm8 ===
    sbb BYTE PTR [rip + 0x100], 0xff
    sbb BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sbb BYTE PTR [rax], 0xff
    sbb BYTE PTR [rip + 0x1000], 0xff
    sbb BYTE PTR [rbx], 0xff
    sbb BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === SBB r16, imm16 ===
    sbb ax, 0xffff
    sbb di, 0xffff
    sbb cx, 0xffff
    sbb bx, 0xffff
    sbb dx, 0xffff
    sbb si, 0xffff

// === SBB m16, imm16 ===
    sbb WORD PTR [rbx], 0xffff
    sbb WORD PTR [rax], 0xffff
    sbb WORD PTR [rip + 0x1000], 0xffff
    sbb WORD PTR [rax + rbx*4 + 0x100], 0xffff
    sbb WORD PTR [rip + 0x100], 0xffff
    sbb WORD PTR [rax + rbx*1 + 0x10], 0xffff

// === SBB r32, imm32 ===
    sbb edx, 0xffffffff
    sbb ecx, 0xffffffff
    sbb esi, 0xffffffff
    sbb eax, 0xffffffff
    sbb ebx, 0xffffffff
    sbb edi, 0xffffffff

// === SBB m32, imm32 ===
    sbb DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    sbb DWORD PTR [rbx], 0xffffffff
    sbb DWORD PTR [rax], 0xffffffff
    sbb DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    sbb DWORD PTR [rip + 0x1000], 0xffffffff
    sbb DWORD PTR [rip + 0x100], 0xffffffff

// === SBB r64, imm32 ===
    sbb r12, -1
    sbb rcx, 0x7fffffff
    sbb r10, -1
    sbb r9, 0x7fffffff
    sbb rsi, -1
    sbb rdi, -1
    sbb rdx, 0x7fffffff
    sbb r9, -1
    sbb r8, 0x7fffffff
    sbb rax, 0x7fffffff

// === SBB m64, imm32 ===
    sbb QWORD PTR [rip + 0x1000], 0x7fffffff
    sbb QWORD PTR [rax + rbx*1 + 0x10], -1
    sbb QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    sbb QWORD PTR [rbx], 0x7fffffff
    sbb QWORD PTR [rax], 0x7fffffff
    sbb QWORD PTR [rbx], -1
    sbb QWORD PTR [rip + 0x1000], -1
    sbb QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    sbb QWORD PTR [rip + 0x100], -1
    sbb QWORD PTR [rip + 0x100], 0x7fffffff

// === SBB r16, imm8 ===
    sbb ax, 0xff
    sbb di, 0xff
    sbb si, 0xff
    sbb cx, 0xff
    sbb bx, 0xff
    sbb dx, 0xff

// === SBB m16, imm8 ===
    sbb WORD PTR [rbx], 0xff
    sbb WORD PTR [rax], 0xff
    sbb WORD PTR [rax + rbx*1 + 0x10], 0xff
    sbb WORD PTR [rip + 0x1000], 0xff
    sbb WORD PTR [rax + rbx*4 + 0x100], 0xff
    sbb WORD PTR [rip + 0x100], 0xff

// === SBB r32, imm8 ===
    sbb ecx, 0xff
    sbb ebx, 0xff
    sbb edx, 0xff
    sbb eax, 0xff
    sbb esi, 0xff
    sbb edi, 0xff

// === SBB m32, imm8 ===
    sbb DWORD PTR [rip + 0x1000], 0xff
    sbb DWORD PTR [rbx], 0xff
    sbb DWORD PTR [rax], 0xff
    sbb DWORD PTR [rax + rbx*1 + 0x10], 0xff
    sbb DWORD PTR [rip + 0x100], 0xff
    sbb DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === SBB r64, imm8 ===
    sbb r11, 0xff
    sbb r10, 0xff
    sbb rdi, 0xff
    sbb rsi, 0xff
    sbb rbx, 0xff
    sbb rdx, 0xff
    sbb r8, 0xff
    sbb rax, 0xff
    sbb r13, 0xff
    sbb r12, 0xff

// === SBB m64, imm8 ===
    sbb QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sbb QWORD PTR [rax], 0xff
    sbb QWORD PTR [rbx], 0xff
    sbb QWORD PTR [rip + 0x100], 0xff
    sbb QWORD PTR [rax + rbx*1 + 0x10], 0xff
    sbb QWORD PTR [rip + 0x1000], 0xff

// === SBB r8, r8 ===
    sbb cl, al
    sbb al, cl
    sbb dl, al
    sbb bl, cl
    sbb dl, dl
    sbb cl, cl
    sbb dl, cl
    sbb bl, al
    sbb cl, dl
    sbb bl, dl

// === SBB m8, r8 ===
    sbb BYTE PTR [rbx], dl
    sbb BYTE PTR [rbx], bl
    sbb BYTE PTR [rbx], al
    sbb BYTE PTR [rip + 0x100], bl
    sbb BYTE PTR [rax + rbx*4 + 0x100], dl
    sbb BYTE PTR [rip + 0x1000], al
    sbb BYTE PTR [rax], bl
    sbb BYTE PTR [rax + rbx*1 + 0x10], bl
    sbb BYTE PTR [rax + rbx*4 + 0x100], bl
    sbb BYTE PTR [rip + 0x100], al

// === SBB r16, r16 ===
    sbb dx, ax
    sbb si, di
    sbb cx, di
    sbb dx, cx
    sbb di, ax
    sbb cx, cx
    sbb ax, ax
    sbb dx, di
    sbb ax, si
    sbb si, ax

// === SBB m16, r16 ===
    sbb WORD PTR [rbx], si
    sbb WORD PTR [rax + rbx*4 + 0x100], bx
    sbb WORD PTR [rip + 0x1000], si
    sbb WORD PTR [rax + rbx*4 + 0x100], di
    sbb WORD PTR [rip + 0x1000], cx
    sbb WORD PTR [rip + 0x100], si
    sbb WORD PTR [rax + rbx*4 + 0x100], si
    sbb WORD PTR [rip + 0x100], ax
    sbb WORD PTR [rax + rbx*1 + 0x10], ax
    sbb WORD PTR [rbx], bx

// === SBB r32, r32 ===
    sbb ebx, esi
    sbb esi, edx
    sbb edi, edx
    sbb eax, ebx
    sbb esi, esi
    sbb ebx, ebx
    sbb ebx, ecx
    sbb ecx, eax
    sbb ebx, edi
    sbb ecx, esi

// === SBB m32, r32 ===
    sbb DWORD PTR [rax], eax
    sbb DWORD PTR [rip + 0x1000], edx
    sbb DWORD PTR [rip + 0x1000], edi
    sbb DWORD PTR [rax + rbx*1 + 0x10], edx
    sbb DWORD PTR [rax + rbx*1 + 0x10], eax
    sbb DWORD PTR [rip + 0x1000], eax
    sbb DWORD PTR [rbx], esi
    sbb DWORD PTR [rbx], eax
    sbb DWORD PTR [rip + 0x100], eax
    sbb DWORD PTR [rip + 0x1000], ebx

// === SBB r64, r64 ===
    sbb r11, rbx
    sbb rax, rax
    sbb r8, r12
    sbb rsi, r13
    sbb r10, rdi
    sbb rbx, rdi
    sbb rcx, r12
    sbb rsi, r8
    sbb rbx, r9
    sbb rax, r12

// === SBB m64, r64 ===
    sbb QWORD PTR [rax + rbx*1 + 0x10], r8
    sbb QWORD PTR [rax], r11
    sbb QWORD PTR [rax + rbx*1 + 0x10], rbx
    sbb QWORD PTR [rax + rbx*1 + 0x10], r10
    sbb QWORD PTR [rax + rbx*1 + 0x10], r13
    sbb QWORD PTR [rbx], r13
    sbb QWORD PTR [rax + rbx*1 + 0x10], rcx
    sbb QWORD PTR [rip + 0x100], rbx
    sbb QWORD PTR [rax], rdx
    sbb QWORD PTR [rbx], rbx

// === SBB r8, m8 ===
    sbb dl, BYTE PTR [rax + rbx*1 + 0x10]
    sbb bl, BYTE PTR [rax]
    sbb al, BYTE PTR [rax]
    sbb dl, BYTE PTR [rip + 0x1000]
    sbb cl, BYTE PTR [rax]
    sbb cl, BYTE PTR [rip + 0x100]
    sbb bl, BYTE PTR [rax + rbx*4 + 0x100]
    sbb al, BYTE PTR [rip + 0x1000]
    sbb dl, BYTE PTR [rax + rbx*4 + 0x100]
    sbb al, BYTE PTR [rax + rbx*4 + 0x100]

// === SBB r16, m16 ===
    sbb bx, WORD PTR [rax + rbx*1 + 0x10]
    sbb dx, WORD PTR [rax]
    sbb cx, WORD PTR [rax + rbx*4 + 0x100]
    sbb bx, WORD PTR [rip + 0x1000]
    sbb di, WORD PTR [rax]
    sbb di, WORD PTR [rax + rbx*1 + 0x10]
    sbb si, WORD PTR [rbx]
    sbb dx, WORD PTR [rax + rbx*4 + 0x100]
    sbb cx, WORD PTR [rax]
    sbb ax, WORD PTR [rip + 0x100]

// === SBB r32, m32 ===
    sbb ebx, DWORD PTR [rbx]
    sbb eax, DWORD PTR [rax + rbx*4 + 0x100]
    sbb edi, DWORD PTR [rbx]
    sbb eax, DWORD PTR [rip + 0x100]
    sbb esi, DWORD PTR [rip + 0x100]
    sbb ebx, DWORD PTR [rip + 0x1000]
    sbb eax, DWORD PTR [rax + rbx*1 + 0x10]
    sbb edx, DWORD PTR [rbx]
    sbb edi, DWORD PTR [rax + rbx*4 + 0x100]
    sbb ecx, DWORD PTR [rax]

// === SBB r64, m64 ===
    sbb rdi, QWORD PTR [rax + rbx*1 + 0x10]
    sbb r13, QWORD PTR [rax + rbx*4 + 0x100]
    sbb r9, QWORD PTR [rax + rbx*1 + 0x10]
    sbb r12, QWORD PTR [rax + rbx*1 + 0x10]
    sbb rsi, QWORD PTR [rip + 0x100]
    sbb rdi, QWORD PTR [rip + 0x100]
    sbb rax, QWORD PTR [rax + rbx*1 + 0x10]
    sbb rax, QWORD PTR [rax]
    sbb r12, QWORD PTR [rax + rbx*4 + 0x100]
    sbb r9, QWORD PTR [rip + 0x100]

// === SCAS m8 ===
    scas BYTE PTR [rdi]

// === SCAS m16 ===
    scas WORD PTR [rdi]

// === SCAS m32 ===
    scas DWORD PTR [rdi]

// === SCAS m64 ===
    scas QWORD PTR [rdi]

// === SCASB ===
    scasb

// === SCASW ===
    scasw

// === SCASD ===
    scasd

// === SCASQ ===
    scasq

// === SETA r8 ===
    seta dl
    seta cl
    seta al
    seta bl

// === SETA m8 ===
    seta BYTE PTR [rax + rbx*4 + 0x100]
    seta BYTE PTR [rip + 0x100]
    seta BYTE PTR [rip + 0x1000]
    seta BYTE PTR [rbx]
    seta BYTE PTR [rax + rbx*1 + 0x10]
    seta BYTE PTR [rax]

// === SETAE r8 ===
    setae dl
    setae al
    setae cl
    setae bl

// === SETAE m8 ===
    setae BYTE PTR [rax + rbx*1 + 0x10]
    setae BYTE PTR [rip + 0x1000]
    setae BYTE PTR [rbx]
    setae BYTE PTR [rax + rbx*4 + 0x100]
    setae BYTE PTR [rip + 0x100]
    setae BYTE PTR [rax]

// === SETB r8 ===
    setb al
    setb cl
    setb dl
    setb bl

// === SETB m8 ===
    setb BYTE PTR [rax + rbx*4 + 0x100]
    setb BYTE PTR [rax]
    setb BYTE PTR [rbx]
    setb BYTE PTR [rax + rbx*1 + 0x10]
    setb BYTE PTR [rip + 0x1000]
    setb BYTE PTR [rip + 0x100]

// === SETBE r8 ===
    setbe cl
    setbe al
    setbe dl
    setbe bl

// === SETBE m8 ===
    setbe BYTE PTR [rax + rbx*1 + 0x10]
    setbe BYTE PTR [rbx]
    setbe BYTE PTR [rip + 0x100]
    setbe BYTE PTR [rax + rbx*4 + 0x100]
    setbe BYTE PTR [rax]
    setbe BYTE PTR [rip + 0x1000]

// === SETC r8 ===
    setc cl
    setc dl
    setc al
    setc bl

// === SETC m8 ===
    setc BYTE PTR [rbx]
    setc BYTE PTR [rip + 0x1000]
    setc BYTE PTR [rax + rbx*4 + 0x100]
    setc BYTE PTR [rip + 0x100]
    setc BYTE PTR [rax]
    setc BYTE PTR [rax + rbx*1 + 0x10]

// === SETE r8 ===
    sete cl
    sete dl
    sete bl
    sete al

// === SETE m8 ===
    sete BYTE PTR [rax]
    sete BYTE PTR [rip + 0x1000]
    sete BYTE PTR [rax + rbx*1 + 0x10]
    sete BYTE PTR [rbx]
    sete BYTE PTR [rax + rbx*4 + 0x100]
    sete BYTE PTR [rip + 0x100]

// === SETG r8 ===
    setg bl
    setg dl
    setg al
    setg cl

// === SETG m8 ===
    setg BYTE PTR [rip + 0x100]
    setg BYTE PTR [rax + rbx*1 + 0x10]
    setg BYTE PTR [rip + 0x1000]
    setg BYTE PTR [rax + rbx*4 + 0x100]
    setg BYTE PTR [rax]
    setg BYTE PTR [rbx]

// === SETGE r8 ===
    setge cl
    setge al
    setge bl
    setge dl

// === SETGE m8 ===
    setge BYTE PTR [rbx]
    setge BYTE PTR [rip + 0x1000]
    setge BYTE PTR [rax + rbx*1 + 0x10]
    setge BYTE PTR [rax]
    setge BYTE PTR [rip + 0x100]
    setge BYTE PTR [rax + rbx*4 + 0x100]

// === SETL r8 ===
    setl cl
    setl al
    setl bl
    setl dl

// === SETL m8 ===
    setl BYTE PTR [rax]
    setl BYTE PTR [rbx]
    setl BYTE PTR [rax + rbx*4 + 0x100]
    setl BYTE PTR [rip + 0x100]
    setl BYTE PTR [rip + 0x1000]
    setl BYTE PTR [rax + rbx*1 + 0x10]

// === SETLE r8 ===
    setle dl
    setle cl
    setle bl
    setle al

// === SETLE m8 ===
    setle BYTE PTR [rbx]
    setle BYTE PTR [rax + rbx*4 + 0x100]
    setle BYTE PTR [rip + 0x1000]
    setle BYTE PTR [rip + 0x100]
    setle BYTE PTR [rax + rbx*1 + 0x10]
    setle BYTE PTR [rax]

// === SETNA r8 ===
    setna al
    setna bl
    setna cl
    setna dl

// === SETNA m8 ===
    setna BYTE PTR [rbx]
    setna BYTE PTR [rax + rbx*4 + 0x100]
    setna BYTE PTR [rax]
    setna BYTE PTR [rax + rbx*1 + 0x10]
    setna BYTE PTR [rip + 0x100]
    setna BYTE PTR [rip + 0x1000]

// === SETNAE r8 ===
    setnae bl
    setnae al
    setnae cl
    setnae dl

// === SETNAE m8 ===
    setnae BYTE PTR [rip + 0x1000]
    setnae BYTE PTR [rax + rbx*4 + 0x100]
    setnae BYTE PTR [rax]
    setnae BYTE PTR [rax + rbx*1 + 0x10]
    setnae BYTE PTR [rip + 0x100]
    setnae BYTE PTR [rbx]

// === SETNB r8 ===
    setnb dl
    setnb bl
    setnb al
    setnb cl

// === SETNB m8 ===
    setnb BYTE PTR [rbx]
    setnb BYTE PTR [rip + 0x1000]
    setnb BYTE PTR [rax]
    setnb BYTE PTR [rip + 0x100]
    setnb BYTE PTR [rax + rbx*1 + 0x10]
    setnb BYTE PTR [rax + rbx*4 + 0x100]

// === SETNBE r8 ===
    setnbe dl
    setnbe al
    setnbe cl
    setnbe bl

// === SETNBE m8 ===
    setnbe BYTE PTR [rip + 0x100]
    setnbe BYTE PTR [rip + 0x1000]
    setnbe BYTE PTR [rax + rbx*1 + 0x10]
    setnbe BYTE PTR [rax]
    setnbe BYTE PTR [rbx]
    setnbe BYTE PTR [rax + rbx*4 + 0x100]

// === SETNC r8 ===
    setnc al
    setnc dl
    setnc cl
    setnc bl

// === SETNC m8 ===
    setnc BYTE PTR [rax]
    setnc BYTE PTR [rip + 0x1000]
    setnc BYTE PTR [rip + 0x100]
    setnc BYTE PTR [rbx]
    setnc BYTE PTR [rax + rbx*4 + 0x100]
    setnc BYTE PTR [rax + rbx*1 + 0x10]

// === SETNE r8 ===
    setne bl
    setne al
    setne cl
    setne dl

// === SETNE m8 ===
    setne BYTE PTR [rip + 0x1000]
    setne BYTE PTR [rip + 0x100]
    setne BYTE PTR [rax + rbx*1 + 0x10]
    setne BYTE PTR [rbx]
    setne BYTE PTR [rax]
    setne BYTE PTR [rax + rbx*4 + 0x100]

// === SETNG r8 ===
    setng al
    setng bl
    setng cl
    setng dl

// === SETNG m8 ===
    setng BYTE PTR [rip + 0x1000]
    setng BYTE PTR [rax + rbx*4 + 0x100]
    setng BYTE PTR [rax]
    setng BYTE PTR [rip + 0x100]
    setng BYTE PTR [rax + rbx*1 + 0x10]
    setng BYTE PTR [rbx]

// === SETNGE r8 ===
    setnge cl
    setnge al
    setnge bl
    setnge dl

// === SETNGE m8 ===
    setnge BYTE PTR [rip + 0x1000]
    setnge BYTE PTR [rax + rbx*4 + 0x100]
    setnge BYTE PTR [rax + rbx*1 + 0x10]
    setnge BYTE PTR [rip + 0x100]
    setnge BYTE PTR [rbx]
    setnge BYTE PTR [rax]

// === SETNL r8 ===
    setnl dl
    setnl bl
    setnl al
    setnl cl

// === SETNL m8 ===
    setnl BYTE PTR [rip + 0x1000]
    setnl BYTE PTR [rip + 0x100]
    setnl BYTE PTR [rbx]
    setnl BYTE PTR [rax]
    setnl BYTE PTR [rax + rbx*4 + 0x100]
    setnl BYTE PTR [rax + rbx*1 + 0x10]

// === SETNLE r8 ===
    setnle cl
    setnle al
    setnle bl
    setnle dl

// === SETNLE m8 ===
    setnle BYTE PTR [rip + 0x100]
    setnle BYTE PTR [rbx]
    setnle BYTE PTR [rax]
    setnle BYTE PTR [rip + 0x1000]
    setnle BYTE PTR [rax + rbx*1 + 0x10]
    setnle BYTE PTR [rax + rbx*4 + 0x100]

// === SETNO r8 ===
    setno bl
    setno cl
    setno al
    setno dl

// === SETNO m8 ===
    setno BYTE PTR [rax]
    setno BYTE PTR [rbx]
    setno BYTE PTR [rip + 0x100]
    setno BYTE PTR [rax + rbx*4 + 0x100]
    setno BYTE PTR [rip + 0x1000]
    setno BYTE PTR [rax + rbx*1 + 0x10]

// === SETNP r8 ===
    setnp al
    setnp bl
    setnp dl
    setnp cl

// === SETNP m8 ===
    setnp BYTE PTR [rax + rbx*1 + 0x10]
    setnp BYTE PTR [rip + 0x100]
    setnp BYTE PTR [rip + 0x1000]
    setnp BYTE PTR [rax + rbx*4 + 0x100]
    setnp BYTE PTR [rbx]
    setnp BYTE PTR [rax]

// === SETNS r8 ===
    setns al
    setns cl
    setns dl
    setns bl

// === SETNS m8 ===
    setns BYTE PTR [rbx]
    setns BYTE PTR [rax]
    setns BYTE PTR [rax + rbx*4 + 0x100]
    setns BYTE PTR [rip + 0x1000]
    setns BYTE PTR [rip + 0x100]
    setns BYTE PTR [rax + rbx*1 + 0x10]

// === SETNZ r8 ===
    setnz al
    setnz bl
    setnz cl
    setnz dl

// === SETNZ m8 ===
    setnz BYTE PTR [rbx]
    setnz BYTE PTR [rip + 0x1000]
    setnz BYTE PTR [rax + rbx*4 + 0x100]
    setnz BYTE PTR [rax + rbx*1 + 0x10]
    setnz BYTE PTR [rip + 0x100]
    setnz BYTE PTR [rax]

// === SETO r8 ===
    seto dl
    seto cl
    seto bl
    seto al

// === SETO m8 ===
    seto BYTE PTR [rip + 0x1000]
    seto BYTE PTR [rax + rbx*1 + 0x10]
    seto BYTE PTR [rbx]
    seto BYTE PTR [rax]
    seto BYTE PTR [rax + rbx*4 + 0x100]
    seto BYTE PTR [rip + 0x100]

// === SETP r8 ===
    setp al
    setp cl
    setp dl
    setp bl

// === SETP m8 ===
    setp BYTE PTR [rax]
    setp BYTE PTR [rip + 0x1000]
    setp BYTE PTR [rax + rbx*1 + 0x10]
    setp BYTE PTR [rip + 0x100]
    setp BYTE PTR [rbx]
    setp BYTE PTR [rax + rbx*4 + 0x100]

// === SETPE r8 ===
    setpe cl
    setpe dl
    setpe bl
    setpe al

// === SETPE m8 ===
    setpe BYTE PTR [rax]
    setpe BYTE PTR [rbx]
    setpe BYTE PTR [rip + 0x1000]
    setpe BYTE PTR [rax + rbx*1 + 0x10]
    setpe BYTE PTR [rax + rbx*4 + 0x100]
    setpe BYTE PTR [rip + 0x100]

// === SETPO r8 ===
    setpo al
    setpo bl
    setpo cl
    setpo dl

// === SETPO m8 ===
    setpo BYTE PTR [rax + rbx*1 + 0x10]
    setpo BYTE PTR [rax + rbx*4 + 0x100]
    setpo BYTE PTR [rip + 0x1000]
    setpo BYTE PTR [rbx]
    setpo BYTE PTR [rax]
    setpo BYTE PTR [rip + 0x100]

// === SETS r8 ===
    sets bl
    sets cl
    sets dl
    sets al

// === SETS m8 ===
    sets BYTE PTR [rax]
    sets BYTE PTR [rip + 0x1000]
    sets BYTE PTR [rax + rbx*4 + 0x100]
    sets BYTE PTR [rip + 0x100]
    sets BYTE PTR [rax + rbx*1 + 0x10]
    sets BYTE PTR [rbx]

// === SETZ r8 ===
    setz bl
    setz cl
    setz al
    setz dl

// === SETZ m8 ===
    setz BYTE PTR [rax + rbx*4 + 0x100]
    setz BYTE PTR [rbx]
    setz BYTE PTR [rax]
    setz BYTE PTR [rip + 0x1000]
    setz BYTE PTR [rip + 0x100]
    setz BYTE PTR [rax + rbx*1 + 0x10]

// === SFENCE ===
    sfence

// === SGDT m ===
    sgdt [rax]
    sgdt [rbx]
    sgdt [rip + 0x100]

// === SHLD r16, r16, imm8 ===
    shld dx, ax, 0xff
    shld di, ax, 0xff
    shld bx, di, 0xff
    shld dx, bx, 0xff
    shld bx, cx, 0xff
    shld si, di, 0xff
    shld cx, di, 0xff
    shld cx, cx, 0xff
    shld si, bx, 0xff
    shld cx, dx, 0xff

// === SHLD m16, r16, imm8 ===
    shld WORD PTR [rip + 0x100], bx, 0xff
    shld WORD PTR [rax + rbx*1 + 0x10], ax, 0xff
    shld WORD PTR [rip + 0x1000], di, 0xff
    shld WORD PTR [rip + 0x1000], dx, 0xff
    shld WORD PTR [rip + 0x1000], si, 0xff
    shld WORD PTR [rbx], bx, 0xff
    shld WORD PTR [rax + rbx*1 + 0x10], dx, 0xff
    shld WORD PTR [rax + rbx*4 + 0x100], ax, 0xff
    shld WORD PTR [rip + 0x100], cx, 0xff
    shld WORD PTR [rax + rbx*1 + 0x10], bx, 0xff

// === SHLD r16, r16, CL ===
    shld ax, cx, cl
    shld si, dx, cl
    shld dx, si, cl
    shld di, si, cl
    shld bx, bx, cl
    shld cx, ax, cl
    shld cx, cx, cl
    shld dx, bx, cl
    shld di, dx, cl
    shld bx, dx, cl

// === SHLD m16, r16, CL ===
    shld WORD PTR [rax + rbx*4 + 0x100], dx, cl
    shld WORD PTR [rax + rbx*4 + 0x100], ax, cl
    shld WORD PTR [rbx], dx, cl
    shld WORD PTR [rax], cx, cl
    shld WORD PTR [rax + rbx*1 + 0x10], cx, cl
    shld WORD PTR [rax], bx, cl
    shld WORD PTR [rip + 0x1000], si, cl
    shld WORD PTR [rbx], bx, cl
    shld WORD PTR [rip + 0x1000], di, cl
    shld WORD PTR [rax + rbx*1 + 0x10], di, cl

// === SHLD r32, r32, imm8 ===
    shld edi, esi, 0xff
    shld edi, eax, 0xff
    shld ecx, edx, 0xff
    shld edx, edx, 0xff
    shld esi, edx, 0xff
    shld ecx, esi, 0xff
    shld ebx, edi, 0xff
    shld eax, edi, 0xff
    shld eax, edx, 0xff
    shld edi, edx, 0xff

// === SHLD m32, r32, imm8 ===
    shld DWORD PTR [rbx], esi, 0xff
    shld DWORD PTR [rbx], edx, 0xff
    shld DWORD PTR [rax], ebx, 0xff
    shld DWORD PTR [rip + 0x100], esi, 0xff
    shld DWORD PTR [rax + rbx*1 + 0x10], ebx, 0xff
    shld DWORD PTR [rip + 0x100], ecx, 0xff
    shld DWORD PTR [rax + rbx*4 + 0x100], eax, 0xff
    shld DWORD PTR [rip + 0x1000], eax, 0xff
    shld DWORD PTR [rip + 0x1000], edx, 0xff
    shld DWORD PTR [rax], eax, 0xff

// === SHLD r64, r64, imm8 ===
    shld r9, r9, 0xff
    shld r11, rdi, 0xff
    shld r9, r12, 0xff
    shld rax, r12, 0xff
    shld r13, rcx, 0xff
    shld r9, rsi, 0xff
    shld rdx, rdi, 0xff
    shld rbx, r13, 0xff
    shld r11, r9, 0xff
    shld r9, r11, 0xff

// === SHLD m64, r64, imm8 ===
    shld QWORD PTR [rax + rbx*1 + 0x10], rsi, 0xff
    shld QWORD PTR [rax + rbx*4 + 0x100], rdi, 0xff
    shld QWORD PTR [rip + 0x1000], r12, 0xff
    shld QWORD PTR [rax + rbx*4 + 0x100], r9, 0xff
    shld QWORD PTR [rbx], rbx, 0xff
    shld QWORD PTR [rax], rcx, 0xff
    shld QWORD PTR [rbx], r8, 0xff
    shld QWORD PTR [rip + 0x100], r8, 0xff
    shld QWORD PTR [rax], r8, 0xff
    shld QWORD PTR [rip + 0x1000], r11, 0xff

// === SHLD r32, r32, CL ===
    shld ebx, esi, cl
    shld edi, ecx, cl
    shld esi, eax, cl
    shld edi, ebx, cl
    shld ebx, ebx, cl
    shld edx, esi, cl
    shld eax, edi, cl
    shld eax, edx, cl
    shld edx, ebx, cl
    shld esi, ebx, cl

// === SHLD m32, r32, CL ===
    shld DWORD PTR [rax + rbx*4 + 0x100], eax, cl
    shld DWORD PTR [rip + 0x1000], eax, cl
    shld DWORD PTR [rip + 0x1000], ebx, cl
    shld DWORD PTR [rax + rbx*4 + 0x100], edi, cl
    shld DWORD PTR [rax + rbx*4 + 0x100], ebx, cl
    shld DWORD PTR [rip + 0x100], ecx, cl
    shld DWORD PTR [rax + rbx*4 + 0x100], edx, cl
    shld DWORD PTR [rax], edi, cl
    shld DWORD PTR [rip + 0x100], esi, cl
    shld DWORD PTR [rip + 0x100], edx, cl

// === SHLD r64, r64, CL ===
    shld r8, r9, cl
    shld r11, rdx, cl
    shld rdi, r8, cl
    shld rbx, r12, cl
    shld r10, rbx, cl
    shld rsi, rcx, cl
    shld r13, rdx, cl
    shld rsi, rdx, cl
    shld rsi, rax, cl
    shld rsi, rsi, cl

// === SHLD m64, r64, CL ===
    shld QWORD PTR [rip + 0x1000], rcx, cl
    shld QWORD PTR [rax + rbx*1 + 0x10], rdx, cl
    shld QWORD PTR [rax + rbx*4 + 0x100], r9, cl
    shld QWORD PTR [rbx], rdx, cl
    shld QWORD PTR [rax + rbx*4 + 0x100], r11, cl
    shld QWORD PTR [rip + 0x1000], rax, cl
    shld QWORD PTR [rax], r11, cl
    shld QWORD PTR [rip + 0x1000], r12, cl
    shld QWORD PTR [rip + 0x1000], r11, cl
    shld QWORD PTR [rip + 0x100], rax, cl

// === SHRD r16, r16, imm8 ===
    shrd ax, dx, 0xff
    shrd dx, di, 0xff
    shrd di, cx, 0xff
    shrd di, si, 0xff
    shrd cx, ax, 0xff
    shrd cx, dx, 0xff
    shrd bx, bx, 0xff
    shrd di, dx, 0xff
    shrd dx, ax, 0xff
    shrd dx, dx, 0xff

// === SHRD m16, r16, imm8 ===
    shrd WORD PTR [rip + 0x1000], cx, 0xff
    shrd WORD PTR [rbx], si, 0xff
    shrd WORD PTR [rax], ax, 0xff
    shrd WORD PTR [rax + rbx*1 + 0x10], cx, 0xff
    shrd WORD PTR [rip + 0x100], dx, 0xff
    shrd WORD PTR [rax + rbx*4 + 0x100], ax, 0xff
    shrd WORD PTR [rbx], cx, 0xff
    shrd WORD PTR [rax + rbx*1 + 0x10], bx, 0xff
    shrd WORD PTR [rip + 0x1000], si, 0xff
    shrd WORD PTR [rax], si, 0xff

// === SHRD r16, r16, CL ===
    shrd dx, cx, cl
    shrd cx, di, cl
    shrd dx, di, cl
    shrd dx, bx, cl
    shrd si, cx, cl
    shrd si, bx, cl
    shrd di, si, cl
    shrd cx, si, cl
    shrd cx, cx, cl
    shrd cx, ax, cl

// === SHRD m16, r16, CL ===
    shrd WORD PTR [rip + 0x100], si, cl
    shrd WORD PTR [rip + 0x100], di, cl
    shrd WORD PTR [rax + rbx*1 + 0x10], si, cl
    shrd WORD PTR [rip + 0x1000], ax, cl
    shrd WORD PTR [rax + rbx*1 + 0x10], di, cl
    shrd WORD PTR [rip + 0x1000], di, cl
    shrd WORD PTR [rax], cx, cl
    shrd WORD PTR [rax + rbx*4 + 0x100], si, cl
    shrd WORD PTR [rbx], si, cl
    shrd WORD PTR [rax + rbx*4 + 0x100], cx, cl

// === SHRD r32, r32, imm8 ===
    shrd ecx, eax, 0xff
    shrd ebx, esi, 0xff
    shrd ebx, eax, 0xff
    shrd esi, edx, 0xff
    shrd ecx, esi, 0xff
    shrd esi, eax, 0xff
    shrd esi, ecx, 0xff
    shrd ecx, ebx, 0xff
    shrd edi, esi, 0xff
    shrd ecx, edx, 0xff

// === SHRD m32, r32, imm8 ===
    shrd DWORD PTR [rax + rbx*4 + 0x100], edi, 0xff
    shrd DWORD PTR [rip + 0x1000], ebx, 0xff
    shrd DWORD PTR [rip + 0x1000], edi, 0xff
    shrd DWORD PTR [rax + rbx*4 + 0x100], eax, 0xff
    shrd DWORD PTR [rbx], edi, 0xff
    shrd DWORD PTR [rbx], ebx, 0xff
    shrd DWORD PTR [rip + 0x1000], edx, 0xff
    shrd DWORD PTR [rbx], ecx, 0xff
    shrd DWORD PTR [rax], esi, 0xff
    shrd DWORD PTR [rax], edi, 0xff

// === SHRD r64, r64, imm8 ===
    shrd rbx, rbx, 0xff
    shrd rbx, rcx, 0xff
    shrd r9, rdx, 0xff
    shrd r11, r9, 0xff
    shrd r10, rcx, 0xff
    shrd rax, r8, 0xff
    shrd r10, rdx, 0xff
    shrd r12, r8, 0xff
    shrd r9, rcx, 0xff
    shrd rax, rdx, 0xff

// === SHRD m64, r64, imm8 ===
    shrd QWORD PTR [rax + rbx*4 + 0x100], rbx, 0xff
    shrd QWORD PTR [rip + 0x100], rdx, 0xff
    shrd QWORD PTR [rax], r13, 0xff
    shrd QWORD PTR [rip + 0x1000], rcx, 0xff
    shrd QWORD PTR [rax + rbx*4 + 0x100], r9, 0xff
    shrd QWORD PTR [rbx], rdx, 0xff
    shrd QWORD PTR [rax + rbx*4 + 0x100], r12, 0xff
    shrd QWORD PTR [rbx], rcx, 0xff
    shrd QWORD PTR [rip + 0x100], rax, 0xff
    shrd QWORD PTR [rip + 0x100], rdi, 0xff

// === SHRD r32, r32, CL ===
    shrd ebx, esi, cl
    shrd ebx, ecx, cl
    shrd esi, edx, cl
    shrd ebx, eax, cl
    shrd esi, ebx, cl
    shrd edi, eax, cl
    shrd edi, edx, cl
    shrd edi, ebx, cl
    shrd edi, ecx, cl
    shrd eax, ebx, cl

// === SHRD m32, r32, CL ===
    shrd DWORD PTR [rax + rbx*4 + 0x100], esi, cl
    shrd DWORD PTR [rax + rbx*1 + 0x10], edi, cl
    shrd DWORD PTR [rbx], ebx, cl
    shrd DWORD PTR [rip + 0x100], ecx, cl
    shrd DWORD PTR [rip + 0x100], edx, cl
    shrd DWORD PTR [rbx], ecx, cl
    shrd DWORD PTR [rbx], eax, cl
    shrd DWORD PTR [rax], esi, cl
    shrd DWORD PTR [rbx], edi, cl
    shrd DWORD PTR [rax + rbx*1 + 0x10], edx, cl

// === SHRD r64, r64, CL ===
    shrd rdi, rax, cl
    shrd r10, rdi, cl
    shrd r13, r13, cl
    shrd rdi, r8, cl
    shrd rcx, r8, cl
    shrd r10, r13, cl
    shrd r13, rdi, cl
    shrd rdi, rdx, cl
    shrd rcx, rdi, cl
    shrd r11, r10, cl

// === SHRD m64, r64, CL ===
    shrd QWORD PTR [rax + rbx*1 + 0x10], rcx, cl
    shrd QWORD PTR [rip + 0x1000], rbx, cl
    shrd QWORD PTR [rax + rbx*4 + 0x100], r10, cl
    shrd QWORD PTR [rbx], rbx, cl
    shrd QWORD PTR [rbx], rax, cl
    shrd QWORD PTR [rip + 0x100], rax, cl
    shrd QWORD PTR [rax], rbx, cl
    shrd QWORD PTR [rip + 0x1000], rcx, cl
    shrd QWORD PTR [rax + rbx*4 + 0x100], rdi, cl
    shrd QWORD PTR [rip + 0x100], rdi, cl

// === SIDT m ===
    sidt [rax]
    sidt [rbx]
    sidt [rip + 0x100]

// === SLDT r16 ===
    sldt bx
    sldt dx
    sldt cx
    sldt ax
    sldt si
    sldt di

// === SLDT m16 ===
    sldt WORD PTR [rip + 0x1000]
    sldt WORD PTR [rax + rbx*1 + 0x10]
    sldt WORD PTR [rbx]
    sldt WORD PTR [rax]
    sldt WORD PTR [rax + rbx*4 + 0x100]
    sldt WORD PTR [rip + 0x100]

// === SMSW r16 ===
    smsw bx
    smsw dx
    smsw cx
    smsw di
    smsw ax
    smsw si

// === SMSW m16 ===
    smsw WORD PTR [rip + 0x100]
    smsw WORD PTR [rax + rbx*4 + 0x100]
    smsw WORD PTR [rip + 0x1000]
    smsw WORD PTR [rax]
    smsw WORD PTR [rbx]
    smsw WORD PTR [rax + rbx*1 + 0x10]

// === SMSW r32/m16 ===
    smsw eax
    smsw ecx
    smsw esi
    smsw edi
    smsw WORD PTR [rax + rbx*1 + 0x10]
    smsw WORD PTR [rip + 0x100]
    smsw WORD PTR [rax]
    smsw WORD PTR [rbx]
    smsw WORD PTR [rax + rbx*4 + 0x100]
    smsw ebx

// === SMSW r64/m16 ===
    smsw rcx
    smsw WORD PTR [rax + rbx*1 + 0x10]
    smsw r11
    smsw WORD PTR [rax]
    smsw rsi
    smsw WORD PTR [rip + 0x1000]
    smsw rax
    smsw rdx
    smsw WORD PTR [rip + 0x100]
    smsw WORD PTR [rax + rbx*4 + 0x100]

// === STC ===
    stc

// === STD ===
    std

// === STI ===
    sti

// === STOS m8 ===
    stos BYTE PTR [rdi]

// === STOS m16 ===
    stos WORD PTR [rdi]

// === STOS m32 ===
    stos DWORD PTR [rdi]

// === STOS m64 ===
    stos QWORD PTR [rdi]

// === STOSB ===
    stosb

// === STOSW ===
    stosw

// === STOSD ===
    stosd

// === STOSQ ===
    stosq

// === STR r16 ===
    str cx
    str dx
    str ax
    str di
    str si
    str bx

// === STR m16 ===
    str WORD PTR [rax + rbx*1 + 0x10]
    str WORD PTR [rax + rbx*4 + 0x100]
    str WORD PTR [rip + 0x100]
    str WORD PTR [rip + 0x1000]
    str WORD PTR [rbx]
    str WORD PTR [rax]

// === SUB AL, imm8 ===
    sub al, 0xff

// === SUB AX, imm16 ===
    sub ax, 0xffff

// === SUB EAX, imm32 ===
    sub eax, 0xffffffff

// === SUB RAX, imm32 ===
    sub rax, 0x7fffffff
    sub rax, -1

// === SUB r8, imm8 ===
    sub dl, 0xff
    sub bl, 0xff
    sub al, 0xff
    sub cl, 0xff

// === SUB m8, imm8 ===
    sub BYTE PTR [rip + 0x100], 0xff
    sub BYTE PTR [rbx], 0xff
    sub BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sub BYTE PTR [rip + 0x1000], 0xff
    sub BYTE PTR [rax], 0xff
    sub BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === SUB r16, imm16 ===
    sub ax, 0xffff
    sub si, 0xffff
    sub cx, 0xffff
    sub bx, 0xffff
    sub di, 0xffff
    sub dx, 0xffff

// === SUB m16, imm16 ===
    sub WORD PTR [rax], 0xffff
    sub WORD PTR [rip + 0x100], 0xffff
    sub WORD PTR [rbx], 0xffff
    sub WORD PTR [rip + 0x1000], 0xffff
    sub WORD PTR [rax + rbx*1 + 0x10], 0xffff
    sub WORD PTR [rax + rbx*4 + 0x100], 0xffff

// === SUB r32, imm32 ===
    sub ebx, 0xffffffff
    sub ecx, 0xffffffff
    sub edx, 0xffffffff
    sub eax, 0xffffffff
    sub edi, 0xffffffff
    sub esi, 0xffffffff

// === SUB m32, imm32 ===
    sub DWORD PTR [rip + 0x1000], 0xffffffff
    sub DWORD PTR [rax], 0xffffffff
    sub DWORD PTR [rip + 0x100], 0xffffffff
    sub DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    sub DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    sub DWORD PTR [rbx], 0xffffffff

// === SUB r64, imm32 ===
    sub rax, -1
    sub rbx, 0x7fffffff
    sub r12, -1
    sub rsi, -1
    sub r12, 0x7fffffff
    sub r9, -1
    sub rdi, 0x7fffffff
    sub r10, -1
    sub r11, -1
    sub r13, -1

// === SUB m64, imm32 ===
    sub QWORD PTR [rip + 0x1000], 0x7fffffff
    sub QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    sub QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    sub QWORD PTR [rip + 0x1000], -1
    sub QWORD PTR [rbx], 0x7fffffff
    sub QWORD PTR [rax + rbx*1 + 0x10], -1
    sub QWORD PTR [rip + 0x100], -1
    sub QWORD PTR [rax + rbx*4 + 0x100], -1
    sub QWORD PTR [rbx], -1
    sub QWORD PTR [rip + 0x100], 0x7fffffff

// === SUB r16, imm8 ===
    sub di, 0xff
    sub dx, 0xff
    sub bx, 0xff
    sub ax, 0xff
    sub si, 0xff
    sub cx, 0xff

// === SUB m16, imm8 ===
    sub WORD PTR [rbx], 0xff
    sub WORD PTR [rip + 0x1000], 0xff
    sub WORD PTR [rax], 0xff
    sub WORD PTR [rax + rbx*1 + 0x10], 0xff
    sub WORD PTR [rax + rbx*4 + 0x100], 0xff
    sub WORD PTR [rip + 0x100], 0xff

// === SUB r32, imm8 ===
    sub eax, 0xff
    sub ecx, 0xff
    sub edx, 0xff
    sub esi, 0xff
    sub edi, 0xff
    sub ebx, 0xff

// === SUB m32, imm8 ===
    sub DWORD PTR [rax], 0xff
    sub DWORD PTR [rip + 0x100], 0xff
    sub DWORD PTR [rbx], 0xff
    sub DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sub DWORD PTR [rip + 0x1000], 0xff
    sub DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SUB r64, imm8 ===
    sub r8, 0xff
    sub r13, 0xff
    sub r9, 0xff
    sub rdx, 0xff
    sub rbx, 0xff
    sub r12, 0xff
    sub r11, 0xff
    sub rdi, 0xff
    sub r10, 0xff
    sub rax, 0xff

// === SUB m64, imm8 ===
    sub QWORD PTR [rax + rbx*1 + 0x10], 0xff
    sub QWORD PTR [rbx], 0xff
    sub QWORD PTR [rip + 0x1000], 0xff
    sub QWORD PTR [rip + 0x100], 0xff
    sub QWORD PTR [rax], 0xff
    sub QWORD PTR [rax + rbx*4 + 0x100], 0xff

// === SUB r8, r8 ===
    sub al, dl
    sub bl, cl
    sub cl, bl
    sub cl, dl
    sub bl, bl
    sub cl, al
    sub al, bl
    sub bl, al
    sub bl, dl
    sub al, cl

// === SUB m8, r8 ===
    sub BYTE PTR [rip + 0x1000], dl
    sub BYTE PTR [rbx], bl
    sub BYTE PTR [rax], cl
    sub BYTE PTR [rax], dl
    sub BYTE PTR [rip + 0x100], bl
    sub BYTE PTR [rbx], al
    sub BYTE PTR [rax + rbx*4 + 0x100], al
    sub BYTE PTR [rip + 0x100], cl
    sub BYTE PTR [rax + rbx*1 + 0x10], al
    sub BYTE PTR [rax + rbx*1 + 0x10], cl

// === SUB r16, r16 ===
    sub di, cx
    sub dx, dx
    sub cx, ax
    sub di, di
    sub dx, si
    sub cx, dx
    sub bx, cx
    sub di, bx
    sub ax, si
    sub cx, cx

// === SUB m16, r16 ===
    sub WORD PTR [rip + 0x1000], dx
    sub WORD PTR [rip + 0x1000], cx
    sub WORD PTR [rax], ax
    sub WORD PTR [rax + rbx*1 + 0x10], cx
    sub WORD PTR [rbx], si
    sub WORD PTR [rax], bx
    sub WORD PTR [rax], dx
    sub WORD PTR [rax + rbx*4 + 0x100], cx
    sub WORD PTR [rax + rbx*1 + 0x10], ax
    sub WORD PTR [rip + 0x100], cx

// === SUB r32, r32 ===
    sub edi, eax
    sub edx, edx
    sub edi, ebx
    sub eax, edx
    sub edi, ecx
    sub ecx, edx
    sub eax, esi
    sub edi, edx
    sub edx, ebx
    sub ebx, eax

// === SUB m32, r32 ===
    sub DWORD PTR [rip + 0x100], ebx
    sub DWORD PTR [rax + rbx*1 + 0x10], esi
    sub DWORD PTR [rbx], eax
    sub DWORD PTR [rip + 0x1000], esi
    sub DWORD PTR [rax + rbx*4 + 0x100], eax
    sub DWORD PTR [rip + 0x100], eax
    sub DWORD PTR [rbx], ecx
    sub DWORD PTR [rax], edx
    sub DWORD PTR [rax + rbx*4 + 0x100], edi
    sub DWORD PTR [rax + rbx*4 + 0x100], ebx

// === SUB r64, r64 ===
    sub rax, r11
    sub r12, rax
    sub rdi, r12
    sub r10, rcx
    sub r11, r12
    sub r13, rdi
    sub r8, rax
    sub rsi, rsi
    sub rdi, rax
    sub rsi, r12

// === SUB m64, r64 ===
    sub QWORD PTR [rip + 0x1000], r11
    sub QWORD PTR [rax + rbx*1 + 0x10], rbx
    sub QWORD PTR [rax], r8
    sub QWORD PTR [rip + 0x100], r11
    sub QWORD PTR [rax + rbx*4 + 0x100], r10
    sub QWORD PTR [rax + rbx*4 + 0x100], r8
    sub QWORD PTR [rax], r11
    sub QWORD PTR [rbx], rsi
    sub QWORD PTR [rax + rbx*4 + 0x100], r13
    sub QWORD PTR [rax + rbx*4 + 0x100], rdi

// === SUB r8, m8 ===
    sub cl, BYTE PTR [rax + rbx*1 + 0x10]
    sub bl, BYTE PTR [rax + rbx*1 + 0x10]
    sub al, BYTE PTR [rip + 0x100]
    sub dl, BYTE PTR [rip + 0x1000]
    sub dl, BYTE PTR [rax]
    sub dl, BYTE PTR [rip + 0x100]
    sub bl, BYTE PTR [rbx]
    sub cl, BYTE PTR [rbx]
    sub dl, BYTE PTR [rax + rbx*4 + 0x100]
    sub cl, BYTE PTR [rax]

// === SUB r16, m16 ===
    sub dx, WORD PTR [rip + 0x1000]
    sub cx, WORD PTR [rip + 0x1000]
    sub cx, WORD PTR [rbx]
    sub ax, WORD PTR [rip + 0x100]
    sub dx, WORD PTR [rax + rbx*1 + 0x10]
    sub bx, WORD PTR [rax]
    sub ax, WORD PTR [rip + 0x1000]
    sub di, WORD PTR [rax + rbx*4 + 0x100]
    sub si, WORD PTR [rip + 0x1000]
    sub di, WORD PTR [rax]

// === SUB r32, m32 ===
    sub ecx, DWORD PTR [rip + 0x1000]
    sub edx, DWORD PTR [rax + rbx*4 + 0x100]
    sub esi, DWORD PTR [rax + rbx*1 + 0x10]
    sub ecx, DWORD PTR [rax + rbx*4 + 0x100]
    sub edi, DWORD PTR [rbx]
    sub ebx, DWORD PTR [rip + 0x100]
    sub edx, DWORD PTR [rbx]
    sub eax, DWORD PTR [rip + 0x100]
    sub edi, DWORD PTR [rip + 0x100]
    sub eax, DWORD PTR [rax]

// === SUB r64, m64 ===
    sub rcx, QWORD PTR [rip + 0x1000]
    sub rbx, QWORD PTR [rax]
    sub r13, QWORD PTR [rbx]
    sub r11, QWORD PTR [rip + 0x100]
    sub r9, QWORD PTR [rax]
    sub rax, QWORD PTR [rax]
    sub rsi, QWORD PTR [rip + 0x100]
    sub rbx, QWORD PTR [rip + 0x100]
    sub r10, QWORD PTR [rax]
    sub r13, QWORD PTR [rip + 0x1000]

// === SWAPGS ===
    swapgs

// === SYSCALL ===
    syscall

// === SYSENTER ===
    sysenter

// === sysexitq ===
    sysexitq

// === sysretq ===
    sysretq

// === TEST AL, imm8 ===
    test al, 0xff

// === TEST AX, imm16 ===
    test ax, 0xffff

// === TEST EAX, imm32 ===
    test eax, 0xffffffff

// === TEST RAX, imm32 ===
    test rax, 0x7fffffff
    test rax, -1

// === TEST r8, imm8 ===
    test al, 0xff
    test dl, 0xff
    test bl, 0xff
    test cl, 0xff

// === TEST m8, imm8 ===
    test BYTE PTR [rbx], 0xff
    test BYTE PTR [rax], 0xff
    test BYTE PTR [rax + rbx*1 + 0x10], 0xff
    test BYTE PTR [rax + rbx*4 + 0x100], 0xff
    test BYTE PTR [rip + 0x100], 0xff
    test BYTE PTR [rip + 0x1000], 0xff

// === TEST r16, imm16 ===
    test si, 0xffff
    test cx, 0xffff
    test di, 0xffff
    test ax, 0xffff
    test dx, 0xffff
    test bx, 0xffff

// === TEST m16, imm16 ===
    test WORD PTR [rip + 0x100], 0xffff
    test WORD PTR [rip + 0x1000], 0xffff
    test WORD PTR [rax + rbx*4 + 0x100], 0xffff
    test WORD PTR [rbx], 0xffff
    test WORD PTR [rax + rbx*1 + 0x10], 0xffff
    test WORD PTR [rax], 0xffff

// === TEST r32, imm32 ===
    test ecx, 0xffffffff
    test eax, 0xffffffff
    test ebx, 0xffffffff
    test esi, 0xffffffff
    test edx, 0xffffffff
    test edi, 0xffffffff

// === TEST m32, imm32 ===
    test DWORD PTR [rbx], 0xffffffff
    test DWORD PTR [rax], 0xffffffff
    test DWORD PTR [rip + 0x100], 0xffffffff
    test DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    test DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    test DWORD PTR [rip + 0x1000], 0xffffffff

// === TEST r64, imm32 ===
    test rax, 0x7fffffff
    test rsi, 0x7fffffff
    test rcx, 0x7fffffff
    test rax, -1
    test r9, 0x7fffffff
    test r10, -1
    test rcx, -1
    test rsi, -1
    test r8, -1
    test r11, 0x7fffffff

// === TEST m64, imm32 ===
    test QWORD PTR [rax], 0x7fffffff
    test QWORD PTR [rip + 0x1000], -1
    test QWORD PTR [rax + rbx*1 + 0x10], -1
    test QWORD PTR [rax], -1
    test QWORD PTR [rip + 0x100], 0x7fffffff
    test QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    test QWORD PTR [rax + rbx*4 + 0x100], -1
    test QWORD PTR [rbx], -1
    test QWORD PTR [rip + 0x100], -1
    test QWORD PTR [rip + 0x1000], 0x7fffffff

// === TEST r8, r8 ===
    test bl, cl
    test cl, bl
    test bl, bl
    test cl, al
    test bl, dl
    test dl, cl
    test bl, al
    test cl, cl
    test dl, al
    test al, bl

// === TEST m8, r8 ===
    test BYTE PTR [rbx], bl
    test BYTE PTR [rax + rbx*4 + 0x100], al
    test BYTE PTR [rip + 0x100], al
    test BYTE PTR [rip + 0x100], dl
    test BYTE PTR [rax], cl
    test BYTE PTR [rax], dl
    test BYTE PTR [rax], bl
    test BYTE PTR [rbx], al
    test BYTE PTR [rax], al
    test BYTE PTR [rax + rbx*1 + 0x10], al

// === TEST r16, r16 ===
    test cx, ax
    test di, di
    test dx, cx
    test cx, di
    test cx, si
    test dx, ax
    test ax, ax
    test di, si
    test di, ax
    test bx, cx

// === TEST m16, r16 ===
    test WORD PTR [rbx], bx
    test WORD PTR [rax + rbx*4 + 0x100], ax
    test WORD PTR [rip + 0x100], ax
    test WORD PTR [rip + 0x1000], bx
    test WORD PTR [rax], bx
    test WORD PTR [rax], si
    test WORD PTR [rbx], si
    test WORD PTR [rbx], di
    test WORD PTR [rip + 0x100], bx
    test WORD PTR [rax + rbx*4 + 0x100], bx

// === TEST r32, r32 ===
    test edx, edx
    test edi, eax
    test ecx, edx
    test eax, edi
    test eax, ebx
    test eax, edx
    test esi, edi
    test ebx, edx
    test ebx, ebx
    test esi, ecx

// === TEST m32, r32 ===
    test DWORD PTR [rax + rbx*1 + 0x10], eax
    test DWORD PTR [rip + 0x100], edi
    test DWORD PTR [rax + rbx*1 + 0x10], esi
    test DWORD PTR [rbx], esi
    test DWORD PTR [rip + 0x1000], ecx
    test DWORD PTR [rip + 0x1000], ebx
    test DWORD PTR [rax], edx
    test DWORD PTR [rip + 0x100], eax
    test DWORD PTR [rax + rbx*4 + 0x100], ecx
    test DWORD PTR [rip + 0x1000], esi

// === TEST r64, r64 ===
    test rcx, r11
    test r10, rdi
    test r12, rdx
    test r9, rcx
    test rdx, r11
    test rdx, r13
    test rsi, rdx
    test rsi, r9
    test rax, r12
    test rcx, rax

// === TEST m64, r64 ===
    test QWORD PTR [rax], r13
    test QWORD PTR [rax], rsi
    test QWORD PTR [rax + rbx*4 + 0x100], rdx
    test QWORD PTR [rip + 0x1000], rdx
    test QWORD PTR [rip + 0x100], rdi
    test QWORD PTR [rax + rbx*4 + 0x100], r12
    test QWORD PTR [rbx], rsi
    test QWORD PTR [rbx], r12
    test QWORD PTR [rax + rbx*4 + 0x100], r8
    test QWORD PTR [rbx], r13

// === UD1 r32, r32 ===
    ud1 eax, esi
    ud1 esi, esi
    ud1 esi, ebx
    ud1 edx, esi
    ud1 ecx, esi
    ud1 edx, ecx
    ud1 ebx, edx
    ud1 esi, edi
    ud1 edi, ebx
    ud1 eax, edx

// === UD1 r32, m32 ===
    ud1 esi, DWORD PTR [rax]
    ud1 edi, DWORD PTR [rip + 0x1000]
    ud1 edx, DWORD PTR [rbx]
    ud1 eax, DWORD PTR [rip + 0x100]
    ud1 ebx, DWORD PTR [rax + rbx*4 + 0x100]
    ud1 ebx, DWORD PTR [rip + 0x100]
    ud1 edi, DWORD PTR [rax + rbx*4 + 0x100]
    ud1 ebx, DWORD PTR [rax]
    ud1 ebx, DWORD PTR [rip + 0x1000]
    ud1 eax, DWORD PTR [rax + rbx*4 + 0x100]

// === UD2 ===
    ud2

// === WAIT ===
    wait

// === FWAIT ===
    fwait

// === WBINVD ===
    wbinvd

// === WRMSR ===
    wrmsr

// === XADD r8, r8 ===
    xadd bl, al
    xadd dl, bl
    xadd bl, bl
    xadd bl, cl
    xadd dl, dl
    xadd al, dl
    xadd al, bl
    xadd al, cl
    xadd cl, bl
    xadd dl, cl

// === XADD m8, r8 ===
    xadd BYTE PTR [rax + rbx*4 + 0x100], al
    xadd BYTE PTR [rax + rbx*1 + 0x10], al
    xadd BYTE PTR [rax + rbx*4 + 0x100], dl
    xadd BYTE PTR [rax], al
    xadd BYTE PTR [rax], dl
    xadd BYTE PTR [rbx], dl
    xadd BYTE PTR [rax], bl
    xadd BYTE PTR [rip + 0x100], cl
    xadd BYTE PTR [rbx], cl
    xadd BYTE PTR [rax + rbx*1 + 0x10], cl

// === XADD r16, r16 ===
    xadd cx, ax
    xadd si, bx
    xadd cx, bx
    xadd bx, si
    xadd si, cx
    xadd ax, ax
    xadd dx, dx
    xadd di, ax
    xadd di, cx
    xadd dx, si

// === XADD m16, r16 ===
    xadd WORD PTR [rax + rbx*4 + 0x100], bx
    xadd WORD PTR [rbx], si
    xadd WORD PTR [rax + rbx*4 + 0x100], dx
    xadd WORD PTR [rip + 0x1000], bx
    xadd WORD PTR [rax + rbx*1 + 0x10], bx
    xadd WORD PTR [rip + 0x1000], di
    xadd WORD PTR [rax + rbx*4 + 0x100], si
    xadd WORD PTR [rax], di
    xadd WORD PTR [rip + 0x100], di
    xadd WORD PTR [rax + rbx*1 + 0x10], di

// === XADD r32, r32 ===
    xadd esi, edx
    xadd edx, esi
    xadd eax, edi
    xadd edx, edi
    xadd eax, ecx
    xadd ebx, edi
    xadd esi, eax
    xadd esi, ecx
    xadd edi, ebx
    xadd ecx, esi

// === XADD m32, r32 ===
    xadd DWORD PTR [rbx], edx
    xadd DWORD PTR [rbx], ebx
    xadd DWORD PTR [rax + rbx*4 + 0x100], esi
    xadd DWORD PTR [rip + 0x100], edx
    xadd DWORD PTR [rip + 0x100], ecx
    xadd DWORD PTR [rax + rbx*1 + 0x10], edx
    xadd DWORD PTR [rax + rbx*4 + 0x100], ebx
    xadd DWORD PTR [rip + 0x1000], edx
    xadd DWORD PTR [rip + 0x1000], ecx
    xadd DWORD PTR [rax + rbx*1 + 0x10], edi

// === XADD r64, r64 ===
    xadd r9, r12
    xadd rsi, r11
    xadd rbx, r11
    xadd r11, r11
    xadd rdx, r9
    xadd rax, rcx
    xadd r11, rax
    xadd r11, r9
    xadd rbx, r12
    xadd rdi, rdx

// === XADD m64, r64 ===
    xadd QWORD PTR [rax], rsi
    xadd QWORD PTR [rax + rbx*1 + 0x10], r11
    xadd QWORD PTR [rip + 0x1000], r9
    xadd QWORD PTR [rip + 0x1000], r12
    xadd QWORD PTR [rax + rbx*1 + 0x10], r13
    xadd QWORD PTR [rbx], r10
    xadd QWORD PTR [rip + 0x1000], rcx
    xadd QWORD PTR [rip + 0x1000], r13
    xadd QWORD PTR [rax], rcx
    xadd QWORD PTR [rip + 0x1000], r11

// === XCHG AX, r16 ===
    xchg ax, ax
    xchg ax, di
    xchg ax, dx
    xchg ax, bx
    xchg ax, cx
    xchg ax, si

// === XCHG r16, AX ===
    xchg cx, ax
    xchg di, ax
    xchg bx, ax
    xchg dx, ax
    xchg si, ax
    xchg ax, ax

// === XCHG EAX, r32 ===
    xchg eax, edx
    xchg eax, esi
    xchg eax, eax
    xchg eax, edi
    xchg eax, ecx
    xchg eax, ebx

// === XCHG RAX, r64 ===
    xchg rax, r9
    xchg rax, r10
    xchg rax, r12
    xchg rax, rbx
    xchg rax, rsi
    xchg rax, rax
    xchg rax, r8
    xchg rax, rcx
    xchg rax, rdx
    xchg rax, r13

// === XCHG r32, EAX ===
    xchg edx, eax
    xchg edi, eax
    xchg esi, eax
    xchg eax, eax
    xchg ebx, eax
    xchg ecx, eax

// === XCHG r64, RAX ===
    xchg r9, rax
    xchg rbx, rax
    xchg r8, rax
    xchg r10, rax
    xchg r13, rax
    xchg r11, rax
    xchg rdi, rax
    xchg rax, rax
    xchg r12, rax
    xchg rsi, rax

// === XCHG r8, r8 ===
    xchg dl, dl
    xchg cl, al
    xchg cl, bl
    xchg dl, al
    xchg dl, bl
    xchg al, bl
    xchg bl, al
    xchg bl, cl
    xchg al, dl
    xchg dl, cl

// === XCHG m8, r8 ===
    xchg BYTE PTR [rax], dl
    xchg BYTE PTR [rax + rbx*1 + 0x10], bl
    xchg BYTE PTR [rbx], bl
    xchg BYTE PTR [rax + rbx*4 + 0x100], cl
    xchg BYTE PTR [rip + 0x1000], cl
    xchg BYTE PTR [rax + rbx*4 + 0x100], bl
    xchg BYTE PTR [rip + 0x100], dl
    xchg BYTE PTR [rax], cl
    xchg BYTE PTR [rbx], al
    xchg BYTE PTR [rax + rbx*1 + 0x10], dl

// === XCHG r8, m8 ===
    xchg dl, BYTE PTR [rbx]
    xchg bl, BYTE PTR [rax]
    xchg cl, BYTE PTR [rip + 0x100]
    xchg bl, BYTE PTR [rip + 0x100]
    xchg al, BYTE PTR [rip + 0x1000]
    xchg al, BYTE PTR [rip + 0x100]
    xchg al, BYTE PTR [rax + rbx*1 + 0x10]
    xchg dl, BYTE PTR [rax]
    xchg bl, BYTE PTR [rax + rbx*1 + 0x10]
    xchg bl, BYTE PTR [rip + 0x1000]

// === XCHG r16, r16 ===
    xchg si, si
    xchg di, ax
    xchg ax, cx
    xchg si, bx
    xchg cx, bx
    xchg bx, ax
    xchg si, dx
    xchg cx, cx
    xchg bx, di
    xchg di, di

// === XCHG m16, r16 ===
    xchg WORD PTR [rax + rbx*4 + 0x100], si
    xchg WORD PTR [rip + 0x100], ax
    xchg WORD PTR [rip + 0x100], bx
    xchg WORD PTR [rax + rbx*4 + 0x100], bx
    xchg WORD PTR [rax + rbx*1 + 0x10], si
    xchg WORD PTR [rax + rbx*4 + 0x100], di
    xchg WORD PTR [rax + rbx*1 + 0x10], bx
    xchg WORD PTR [rax], dx
    xchg WORD PTR [rbx], si
    xchg WORD PTR [rax + rbx*4 + 0x100], dx

// === XCHG r16, m16 ===
    xchg ax, WORD PTR [rax + rbx*1 + 0x10]
    xchg cx, WORD PTR [rbx]
    xchg di, WORD PTR [rax + rbx*1 + 0x10]
    xchg dx, WORD PTR [rax + rbx*1 + 0x10]
    xchg dx, WORD PTR [rax + rbx*4 + 0x100]
    xchg di, WORD PTR [rax]
    xchg di, WORD PTR [rax + rbx*4 + 0x100]
    xchg si, WORD PTR [rax]
    xchg bx, WORD PTR [rip + 0x100]
    xchg cx, WORD PTR [rip + 0x100]

// === XCHG r32, r32 ===
    xchg edx, eax
    xchg ecx, ebx
    xchg edx, esi
    xchg edi, ebx
    xchg edx, ecx
    xchg esi, esi
    xchg edi, ecx
    xchg edx, ebx
    xchg ebx, esi
    xchg edx, edi

// === XCHG m32, r32 ===
    xchg DWORD PTR [rbx], ebx
    xchg DWORD PTR [rax], ebx
    xchg DWORD PTR [rax + rbx*1 + 0x10], esi
    xchg DWORD PTR [rip + 0x100], esi
    xchg DWORD PTR [rip + 0x100], edi
    xchg DWORD PTR [rip + 0x1000], esi
    xchg DWORD PTR [rax + rbx*4 + 0x100], edx
    xchg DWORD PTR [rbx], esi
    xchg DWORD PTR [rax + rbx*1 + 0x10], ebx
    xchg DWORD PTR [rax + rbx*1 + 0x10], ecx

// === XCHG r64, r64 ===
    xchg r8, r8
    xchg rsi, rcx
    xchg r9, rbx
    xchg r13, rsi
    xchg rbx, rcx
    xchg r11, rcx
    xchg r10, rsi
    xchg r8, r12
    xchg rdx, rcx
    xchg r11, rsi

// === XCHG m64, r64 ===
    xchg QWORD PTR [rax + rbx*1 + 0x10], r8
    xchg QWORD PTR [rip + 0x1000], rbx
    xchg QWORD PTR [rax], rbx
    xchg QWORD PTR [rip + 0x100], r12
    xchg QWORD PTR [rbx], rbx
    xchg QWORD PTR [rax], r12
    xchg QWORD PTR [rip + 0x100], rdx
    xchg QWORD PTR [rax + rbx*4 + 0x100], r13
    xchg QWORD PTR [rip + 0x1000], rax
    xchg QWORD PTR [rip + 0x1000], r9

// === XCHG r32, m32 ===
    xchg ecx, DWORD PTR [rip + 0x1000]
    xchg edi, DWORD PTR [rax + rbx*1 + 0x10]
    xchg esi, DWORD PTR [rax + rbx*1 + 0x10]
    xchg ebx, DWORD PTR [rax + rbx*4 + 0x100]
    xchg edx, DWORD PTR [rbx]
    xchg edx, DWORD PTR [rax + rbx*1 + 0x10]
    xchg edx, DWORD PTR [rip + 0x100]
    xchg ebx, DWORD PTR [rbx]
    xchg edx, DWORD PTR [rax]
    xchg edi, DWORD PTR [rip + 0x1000]

// === XCHG r64, m64 ===
    xchg r11, QWORD PTR [rax + rbx*1 + 0x10]
    xchg rax, QWORD PTR [rax + rbx*4 + 0x100]
    xchg r10, QWORD PTR [rbx]
    xchg r8, QWORD PTR [rax]
    xchg r10, QWORD PTR [rax + rbx*1 + 0x10]
    xchg rax, QWORD PTR [rax]
    xchg rdx, QWORD PTR [rip + 0x100]
    xchg rdi, QWORD PTR [rbx]
    xchg rdx, QWORD PTR [rax + rbx*4 + 0x100]
    xchg rcx, QWORD PTR [rax + rbx*4 + 0x100]

// === XGETBV ===
    xgetbv

// === XLAT m8 ===
    xlat BYTE PTR [rbx]

// === XLATB ===
    xlatb

// === XOR AL, imm8 ===
    xor al, 0xff

// === XOR AX, imm16 ===
    xor ax, 0xffff

// === XOR EAX, imm32 ===
    xor eax, 0xffffffff

// === XOR RAX, imm32 ===
    xor rax, -1
    xor rax, 0x7fffffff

// === XOR r8, imm8 ===
    xor cl, 0xff
    xor al, 0xff
    xor dl, 0xff
    xor bl, 0xff

// === XOR m8, imm8 ===
    xor BYTE PTR [rip + 0x1000], 0xff
    xor BYTE PTR [rax], 0xff
    xor BYTE PTR [rbx], 0xff
    xor BYTE PTR [rax + rbx*4 + 0x100], 0xff
    xor BYTE PTR [rip + 0x100], 0xff
    xor BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === XOR r16, imm16 ===
    xor bx, 0xffff
    xor si, 0xffff
    xor dx, 0xffff
    xor ax, 0xffff
    xor cx, 0xffff
    xor di, 0xffff

// === XOR m16, imm16 ===
    xor WORD PTR [rax], 0xffff
    xor WORD PTR [rbx], 0xffff
    xor WORD PTR [rip + 0x100], 0xffff
    xor WORD PTR [rax + rbx*1 + 0x10], 0xffff
    xor WORD PTR [rip + 0x1000], 0xffff
    xor WORD PTR [rax + rbx*4 + 0x100], 0xffff

// === XOR r32, imm32 ===
    xor esi, 0xffffffff
    xor ebx, 0xffffffff
    xor eax, 0xffffffff
    xor ecx, 0xffffffff
    xor edi, 0xffffffff
    xor edx, 0xffffffff

// === XOR m32, imm32 ===
    xor DWORD PTR [rax], 0xffffffff
    xor DWORD PTR [rbx], 0xffffffff
    xor DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    xor DWORD PTR [rip + 0x100], 0xffffffff
    xor DWORD PTR [rip + 0x1000], 0xffffffff
    xor DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === XOR r64, imm32 ===
    xor r13, -1
    xor r8, -1
    xor rdx, 0x7fffffff
    xor rbx, -1
    xor rcx, 0x7fffffff
    xor r12, -1
    xor rax, -1
    xor rsi, -1
    xor r13, 0x7fffffff
    xor r12, 0x7fffffff

// === XOR m64, imm32 ===
    xor QWORD PTR [rip + 0x100], 0x7fffffff
    xor QWORD PTR [rip + 0x100], -1
    xor QWORD PTR [rax], 0x7fffffff
    xor QWORD PTR [rax + rbx*4 + 0x100], -1
    xor QWORD PTR [rax], -1
    xor QWORD PTR [rax + rbx*1 + 0x10], -1
    xor QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    xor QWORD PTR [rbx], 0x7fffffff
    xor QWORD PTR [rbx], -1
    xor QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff

// === XOR r16, imm8 ===
    xor di, 0xff
    xor ax, 0xff
    xor si, 0xff
    xor dx, 0xff
    xor bx, 0xff
    xor cx, 0xff

// === XOR m16, imm8 ===
    xor WORD PTR [rax], 0xff
    xor WORD PTR [rbx], 0xff
    xor WORD PTR [rax + rbx*1 + 0x10], 0xff
    xor WORD PTR [rip + 0x1000], 0xff
    xor WORD PTR [rip + 0x100], 0xff
    xor WORD PTR [rax + rbx*4 + 0x100], 0xff

// === XOR r32, imm8 ===
    xor edx, 0xff
    xor ebx, 0xff
    xor ecx, 0xff
    xor edi, 0xff
    xor esi, 0xff
    xor eax, 0xff

// === XOR m32, imm8 ===
    xor DWORD PTR [rax + rbx*1 + 0x10], 0xff
    xor DWORD PTR [rax], 0xff
    xor DWORD PTR [rip + 0x100], 0xff
    xor DWORD PTR [rbx], 0xff
    xor DWORD PTR [rip + 0x1000], 0xff
    xor DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === XOR r64, imm8 ===
    xor r12, 0xff
    xor rsi, 0xff
    xor r11, 0xff
    xor rax, 0xff
    xor r13, 0xff
    xor rdi, 0xff
    xor rdx, 0xff
    xor rbx, 0xff
    xor rcx, 0xff
    xor r8, 0xff

// === XOR m64, imm8 ===
    xor QWORD PTR [rip + 0x1000], 0xff
    xor QWORD PTR [rax + rbx*4 + 0x100], 0xff
    xor QWORD PTR [rip + 0x100], 0xff
    xor QWORD PTR [rax + rbx*1 + 0x10], 0xff
    xor QWORD PTR [rax], 0xff
    xor QWORD PTR [rbx], 0xff

// === XOR r8, r8 ===
    xor dl, bl
    xor cl, bl
    xor bl, dl
    xor cl, al
    xor bl, cl
    xor dl, al
    xor cl, dl
    xor al, al
    xor bl, bl
    xor dl, dl

// === XOR m8, r8 ===
    xor BYTE PTR [rip + 0x100], dl
    xor BYTE PTR [rax], bl
    xor BYTE PTR [rax], dl
    xor BYTE PTR [rip + 0x1000], bl
    xor BYTE PTR [rax], cl
    xor BYTE PTR [rip + 0x100], al
    xor BYTE PTR [rip + 0x100], bl
    xor BYTE PTR [rbx], dl
    xor BYTE PTR [rax + rbx*4 + 0x100], al
    xor BYTE PTR [rip + 0x1000], dl

// === XOR r16, r16 ===
    xor ax, si
    xor dx, dx
    xor cx, ax
    xor di, bx
    xor dx, si
    xor dx, cx
    xor si, cx
    xor bx, bx
    xor bx, cx
    xor di, si

// === XOR m16, r16 ===
    xor WORD PTR [rax], dx
    xor WORD PTR [rip + 0x100], si
    xor WORD PTR [rax + rbx*1 + 0x10], di
    xor WORD PTR [rip + 0x100], ax
    xor WORD PTR [rax + rbx*1 + 0x10], bx
    xor WORD PTR [rbx], ax
    xor WORD PTR [rax + rbx*4 + 0x100], di
    xor WORD PTR [rax + rbx*1 + 0x10], ax
    xor WORD PTR [rip + 0x1000], ax
    xor WORD PTR [rax], si

// === XOR r32, r32 ===
    xor eax, ecx
    xor ebx, esi
    xor esi, ebx
    xor edx, esi
    xor ecx, esi
    xor eax, edx
    xor ecx, edi
    xor edi, esi
    xor edi, edi
    xor ebx, ebx

// === XOR m32, r32 ===
    xor DWORD PTR [rip + 0x100], edx
    xor DWORD PTR [rbx], edx
    xor DWORD PTR [rax + rbx*1 + 0x10], edi
    xor DWORD PTR [rip + 0x1000], eax
    xor DWORD PTR [rip + 0x1000], ecx
    xor DWORD PTR [rax], ecx
    xor DWORD PTR [rbx], esi
    xor DWORD PTR [rip + 0x1000], edx
    xor DWORD PTR [rax + rbx*4 + 0x100], ebx
    xor DWORD PTR [rax + rbx*1 + 0x10], esi

// === XOR r64, r64 ===
    xor r8, r9
    xor rcx, r9
    xor r12, r9
    xor r12, r11
    xor rbx, r13
    xor rdi, r12
    xor r13, r12
    xor rbx, rsi
    xor r9, r13
    xor rdx, rcx

// === XOR m64, r64 ===
    xor QWORD PTR [rip + 0x100], rdi
    xor QWORD PTR [rax + rbx*4 + 0x100], rdi
    xor QWORD PTR [rax + rbx*1 + 0x10], rax
    xor QWORD PTR [rip + 0x100], r12
    xor QWORD PTR [rax + rbx*1 + 0x10], r12
    xor QWORD PTR [rax], r8
    xor QWORD PTR [rax + rbx*1 + 0x10], r9
    xor QWORD PTR [rbx], r11
    xor QWORD PTR [rax + rbx*1 + 0x10], r8
    xor QWORD PTR [rbx], rbx

// === XOR r8, m8 ===
    xor al, BYTE PTR [rax + rbx*4 + 0x100]
    xor dl, BYTE PTR [rbx]
    xor cl, BYTE PTR [rip + 0x1000]
    xor bl, BYTE PTR [rax + rbx*1 + 0x10]
    xor bl, BYTE PTR [rax]
    xor dl, BYTE PTR [rax + rbx*1 + 0x10]
    xor al, BYTE PTR [rbx]
    xor cl, BYTE PTR [rax]
    xor al, BYTE PTR [rip + 0x1000]
    xor al, BYTE PTR [rax + rbx*1 + 0x10]

// === XOR r16, m16 ===
    xor di, WORD PTR [rax]
    xor si, WORD PTR [rip + 0x1000]
    xor dx, WORD PTR [rax + rbx*4 + 0x100]
    xor dx, WORD PTR [rax + rbx*1 + 0x10]
    xor si, WORD PTR [rip + 0x100]
    xor dx, WORD PTR [rip + 0x100]
    xor si, WORD PTR [rax + rbx*1 + 0x10]
    xor si, WORD PTR [rbx]
    xor di, WORD PTR [rbx]
    xor cx, WORD PTR [rip + 0x1000]

// === XOR r32, m32 ===
    xor edx, DWORD PTR [rax + rbx*4 + 0x100]
    xor ecx, DWORD PTR [rbx]
    xor ebx, DWORD PTR [rbx]
    xor esi, DWORD PTR [rax + rbx*1 + 0x10]
    xor eax, DWORD PTR [rax + rbx*4 + 0x100]
    xor esi, DWORD PTR [rip + 0x100]
    xor ecx, DWORD PTR [rax]
    xor ebx, DWORD PTR [rax + rbx*1 + 0x10]
    xor ebx, DWORD PTR [rip + 0x100]
    xor eax, DWORD PTR [rbx]

// === XOR r64, m64 ===
    xor r10, QWORD PTR [rip + 0x1000]
    xor r10, QWORD PTR [rax + rbx*1 + 0x10]
    xor rdi, QWORD PTR [rip + 0x100]
    xor rcx, QWORD PTR [rax + rbx*4 + 0x100]
    xor r13, QWORD PTR [rax + rbx*4 + 0x100]
    xor rsi, QWORD PTR [rax]
    xor r12, QWORD PTR [rip + 0x1000]
    xor r11, QWORD PTR [rax + rbx*1 + 0x10]
    xor rsi, QWORD PTR [rip + 0x1000]
    xor r10, QWORD PTR [rax + rbx*4 + 0x100]

// === XSETBV ===
    xsetbv
