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
    adc dl, BYTE PTR [rip + 0x100]
    adc cl, BYTE PTR [rax + rbx*4 + 0x100]
    adc cl, BYTE PTR [rip + 0x100]
    adc al, BYTE PTR [rbx]
    adc al, BYTE PTR [rip + 0x1000]
    adc bl, BYTE PTR [rbx]
    adc al, BYTE PTR [rax + rbx*4 + 0x100]
    adc al, BYTE PTR [rax]
    adc dl, BYTE PTR [rax + rbx*4 + 0x100]
    adc bl, BYTE PTR [rip + 0x1000]

// === ADC r16, m16 ===
    adc bx, WORD PTR [rbx]
    adc bx, WORD PTR [rip + 0x1000]
    adc cx, WORD PTR [rip + 0x100]
    adc dx, WORD PTR [rax + rbx*4 + 0x100]
    adc si, WORD PTR [rip + 0x1000]
    adc ax, WORD PTR [rip + 0x100]
    adc dx, WORD PTR [rip + 0x100]
    adc ax, WORD PTR [rip + 0x1000]
    adc cx, WORD PTR [rax + rbx*1 + 0x10]
    adc dx, WORD PTR [rax]

// === ADC r32, m32 ===
    adc esi, DWORD PTR [rbx]
    adc ebx, DWORD PTR [rax]
    adc esi, DWORD PTR [rax]
    adc esi, DWORD PTR [rax + rbx*1 + 0x10]
    adc esi, DWORD PTR [rip + 0x100]
    adc ebx, DWORD PTR [rax + rbx*4 + 0x100]
    adc edi, DWORD PTR [rip + 0x1000]
    adc ebx, DWORD PTR [rax + rbx*1 + 0x10]
    adc eax, DWORD PTR [rbx]
    adc edi, DWORD PTR [rax + rbx*4 + 0x100]

// === ADC r64, m64 ===
    adc r9, QWORD PTR [rbx]
    adc rcx, QWORD PTR [rip + 0x1000]
    adc rax, QWORD PTR [rax]
    adc r12, QWORD PTR [rax + rbx*1 + 0x10]
    adc rsi, QWORD PTR [rbx]
    adc r8, QWORD PTR [rax + rbx*1 + 0x10]
    adc rdi, QWORD PTR [rip + 0x100]
    adc r9, QWORD PTR [rax]
    adc rbx, QWORD PTR [rip + 0x1000]
    adc rax, QWORD PTR [rip + 0x100]

// === ADD AL, imm8 ===
    add al, 0xff

// === ADD AX, imm16 ===
    add ax, 0xffff

// === ADD EAX, imm32 ===
    add eax, 0xffffffff

// === ADD RAX, imm32 ===
    add rax, 0x7fffffff
    add rax, -1

// === ADD r8, imm8 ===
    add cl, 0xff
    add dl, 0xff
    add al, 0xff
    add bl, 0xff

// === ADD m8, imm8 ===
    add BYTE PTR [rax + rbx*1 + 0x10], 0xff
    add BYTE PTR [rax + rbx*4 + 0x100], 0xff
    add BYTE PTR [rbx], 0xff
    add BYTE PTR [rip + 0x1000], 0xff
    add BYTE PTR [rip + 0x100], 0xff
    add BYTE PTR [rax], 0xff

// === ADD r16, imm16 ===
    add cx, 0xffff
    add si, 0xffff
    add ax, 0xffff
    add dx, 0xffff
    add di, 0xffff
    add bx, 0xffff

// === ADD m16, imm16 ===
    add WORD PTR [rbx], 0xffff
    add WORD PTR [rax], 0xffff
    add WORD PTR [rip + 0x1000], 0xffff
    add WORD PTR [rip + 0x100], 0xffff
    add WORD PTR [rax + rbx*1 + 0x10], 0xffff
    add WORD PTR [rax + rbx*4 + 0x100], 0xffff

// === ADD r32, imm32 ===
    add eax, 0xffffffff
    add ebx, 0xffffffff
    add esi, 0xffffffff
    add ecx, 0xffffffff
    add edi, 0xffffffff
    add edx, 0xffffffff

// === ADD m32, imm32 ===
    add DWORD PTR [rip + 0x1000], 0xffffffff
    add DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    add DWORD PTR [rax], 0xffffffff
    add DWORD PTR [rbx], 0xffffffff
    add DWORD PTR [rip + 0x100], 0xffffffff
    add DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === ADD r64, imm32 ===
    add r9, -1
    add rcx, 0x7fffffff
    add r12, 0x7fffffff
    add rsi, 0x7fffffff
    add r10, 0x7fffffff
    add r13, -1
    add rbx, -1
    add r11, 0x7fffffff
    add rbx, 0x7fffffff
    add rsi, -1

// === ADD m64, imm32 ===
    add QWORD PTR [rbx], 0x7fffffff
    add QWORD PTR [rax], -1
    add QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    add QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    add QWORD PTR [rbx], -1
    add QWORD PTR [rax + rbx*4 + 0x100], -1
    add QWORD PTR [rip + 0x1000], -1
    add QWORD PTR [rax + rbx*1 + 0x10], -1
    add QWORD PTR [rip + 0x100], 0x7fffffff
    add QWORD PTR [rax], 0x7fffffff

// === ADD r16, imm8 ===
    add si, 0xff
    add bx, 0xff
    add ax, 0xff
    add cx, 0xff
    add dx, 0xff
    add di, 0xff

// === ADD m16, imm8 ===
    add WORD PTR [rip + 0x1000], 0xff
    add WORD PTR [rip + 0x100], 0xff
    add WORD PTR [rax], 0xff
    add WORD PTR [rbx], 0xff
    add WORD PTR [rax + rbx*1 + 0x10], 0xff
    add WORD PTR [rax + rbx*4 + 0x100], 0xff

// === ADD r32, imm8 ===
    add esi, 0xff
    add edx, 0xff
    add ecx, 0xff
    add eax, 0xff
    add ebx, 0xff
    add edi, 0xff

// === ADD m32, imm8 ===
    add DWORD PTR [rip + 0x1000], 0xff
    add DWORD PTR [rax], 0xff
    add DWORD PTR [rax + rbx*1 + 0x10], 0xff
    add DWORD PTR [rax + rbx*4 + 0x100], 0xff
    add DWORD PTR [rbx], 0xff
    add DWORD PTR [rip + 0x100], 0xff

// === ADD r64, imm8 ===
    add r12, 0xff
    add rcx, 0xff
    add r8, 0xff
    add rsi, 0xff
    add r13, 0xff
    add r10, 0xff
    add r11, 0xff
    add r9, 0xff
    add rdx, 0xff
    add rax, 0xff

// === ADD m64, imm8 ===
    add QWORD PTR [rax + rbx*4 + 0x100], 0xff
    add QWORD PTR [rbx], 0xff
    add QWORD PTR [rax], 0xff
    add QWORD PTR [rax + rbx*1 + 0x10], 0xff
    add QWORD PTR [rip + 0x100], 0xff
    add QWORD PTR [rip + 0x1000], 0xff

// === ADD r8, r8 ===
    add dl, dl
    add al, bl
    add al, cl
    add cl, bl
    add cl, al
    add cl, dl
    add bl, al
    add dl, bl
    add cl, cl
    add dl, al

// === ADD m8, r8 ===
    add BYTE PTR [rip + 0x1000], bl
    add BYTE PTR [rax], cl
    add BYTE PTR [rax + rbx*1 + 0x10], cl
    add BYTE PTR [rip + 0x100], bl
    add BYTE PTR [rax], bl
    add BYTE PTR [rax + rbx*4 + 0x100], al
    add BYTE PTR [rax + rbx*1 + 0x10], bl
    add BYTE PTR [rax + rbx*1 + 0x10], al
    add BYTE PTR [rip + 0x100], dl
    add BYTE PTR [rax + rbx*4 + 0x100], dl

// === ADD r16, r16 ===
    add si, cx
    add ax, bx
    add dx, si
    add dx, di
    add ax, cx
    add di, si
    add cx, bx
    add si, si
    add di, dx
    add dx, ax

// === ADD m16, r16 ===
    add WORD PTR [rax + rbx*4 + 0x100], cx
    add WORD PTR [rax], ax
    add WORD PTR [rax + rbx*4 + 0x100], dx
    add WORD PTR [rax + rbx*1 + 0x10], ax
    add WORD PTR [rip + 0x100], di
    add WORD PTR [rax + rbx*1 + 0x10], cx
    add WORD PTR [rip + 0x1000], cx
    add WORD PTR [rax], si
    add WORD PTR [rax + rbx*1 + 0x10], bx
    add WORD PTR [rax + rbx*4 + 0x100], ax

// === ADD r32, r32 ===
    add edx, ecx
    add ecx, edi
    add eax, esi
    add eax, ecx
    add edi, eax
    add esi, edi
    add edx, ebx
    add ebx, eax
    add esi, eax
    add ebx, edi

// === ADD m32, r32 ===
    add DWORD PTR [rbx], edi
    add DWORD PTR [rax + rbx*4 + 0x100], edx
    add DWORD PTR [rax + rbx*1 + 0x10], ecx
    add DWORD PTR [rax + rbx*4 + 0x100], edi
    add DWORD PTR [rip + 0x100], ebx
    add DWORD PTR [rip + 0x1000], esi
    add DWORD PTR [rip + 0x100], edx
    add DWORD PTR [rax], eax
    add DWORD PTR [rax], ebx
    add DWORD PTR [rip + 0x100], edi

// === ADD r64, r64 ===
    add r12, rbx
    add r8, r10
    add r13, rbx
    add rdi, r12
    add r13, rsi
    add r8, r8
    add rax, rcx
    add r13, r12
    add r8, rbx
    add rdx, r11

// === ADD m64, r64 ===
    add QWORD PTR [rax + rbx*1 + 0x10], rsi
    add QWORD PTR [rip + 0x100], r10
    add QWORD PTR [rip + 0x100], rdx
    add QWORD PTR [rip + 0x1000], rax
    add QWORD PTR [rax + rbx*1 + 0x10], r11
    add QWORD PTR [rax + rbx*4 + 0x100], rdx
    add QWORD PTR [rax + rbx*4 + 0x100], rsi
    add QWORD PTR [rip + 0x1000], r13
    add QWORD PTR [rbx], rsi
    add QWORD PTR [rip + 0x100], r12

// === ADD r8, m8 ===
    add al, BYTE PTR [rip + 0x100]
    add bl, BYTE PTR [rbx]
    add dl, BYTE PTR [rax + rbx*1 + 0x10]
    add al, BYTE PTR [rax + rbx*4 + 0x100]
    add cl, BYTE PTR [rax]
    add bl, BYTE PTR [rip + 0x1000]
    add cl, BYTE PTR [rax + rbx*1 + 0x10]
    add dl, BYTE PTR [rax + rbx*4 + 0x100]
    add dl, BYTE PTR [rax]
    add cl, BYTE PTR [rbx]

// === ADD r16, m16 ===
    add ax, WORD PTR [rip + 0x1000]
    add cx, WORD PTR [rbx]
    add ax, WORD PTR [rip + 0x100]
    add cx, WORD PTR [rip + 0x1000]
    add di, WORD PTR [rip + 0x100]
    add dx, WORD PTR [rip + 0x100]
    add dx, WORD PTR [rip + 0x1000]
    add si, WORD PTR [rax + rbx*1 + 0x10]
    add si, WORD PTR [rax + rbx*4 + 0x100]
    add ax, WORD PTR [rax + rbx*1 + 0x10]

// === ADD r32, m32 ===
    add ecx, DWORD PTR [rax + rbx*1 + 0x10]
    add ecx, DWORD PTR [rax + rbx*4 + 0x100]
    add ebx, DWORD PTR [rax + rbx*4 + 0x100]
    add edi, DWORD PTR [rax + rbx*4 + 0x100]
    add ebx, DWORD PTR [rip + 0x100]
    add edi, DWORD PTR [rbx]
    add eax, DWORD PTR [rip + 0x1000]
    add esi, DWORD PTR [rax]
    add esi, DWORD PTR [rax + rbx*1 + 0x10]
    add eax, DWORD PTR [rbx]

// === ADD r64, m64 ===
    add r13, QWORD PTR [rip + 0x100]
    add rdi, QWORD PTR [rax + rbx*1 + 0x10]
    add rsi, QWORD PTR [rax + rbx*1 + 0x10]
    add r9, QWORD PTR [rip + 0x1000]
    add r9, QWORD PTR [rax]
    add rcx, QWORD PTR [rip + 0x100]
    add r11, QWORD PTR [rbx]
    add r11, QWORD PTR [rax + rbx*1 + 0x10]
    add r11, QWORD PTR [rax + rbx*4 + 0x100]
    add r8, QWORD PTR [rax]

// === AND AL, imm8 ===
    and al, 0xff

// === AND AX, imm16 ===
    and ax, 0xffff

// === AND EAX, imm32 ===
    and eax, 0xffffffff

// === AND RAX, imm32 ===
    and rax, -1
    and rax, 0x7fffffff

// === AND r8 , imm8 ===
    and al, 0xff
    and bl, 0xff
    and dl, 0xff
    and cl, 0xff

// === AND m8 , imm8 ===
    and BYTE PTR [rip + 0x100], 0xff
    and BYTE PTR [rbx], 0xff
    and BYTE PTR [rip + 0x1000], 0xff
    and BYTE PTR [rax + rbx*4 + 0x100], 0xff
    and BYTE PTR [rax], 0xff
    and BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === AND r16, imm16 ===
    and di, 0xffff
    and ax, 0xffff
    and cx, 0xffff
    and bx, 0xffff
    and si, 0xffff
    and dx, 0xffff

// === AND m16, imm16 ===
    and WORD PTR [rax + rbx*4 + 0x100], 0xffff
    and WORD PTR [rax], 0xffff
    and WORD PTR [rax + rbx*1 + 0x10], 0xffff
    and WORD PTR [rbx], 0xffff
    and WORD PTR [rip + 0x100], 0xffff
    and WORD PTR [rip + 0x1000], 0xffff

// === AND r32, imm32 ===
    and edx, 0xffffffff
    and esi, 0xffffffff
    and eax, 0xffffffff
    and ecx, 0xffffffff
    and edi, 0xffffffff
    and ebx, 0xffffffff

// === AND m32, imm32 ===
    and DWORD PTR [rax], 0xffffffff
    and DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    and DWORD PTR [rip + 0x1000], 0xffffffff
    and DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    and DWORD PTR [rip + 0x100], 0xffffffff
    and DWORD PTR [rbx], 0xffffffff

// === AND r64, imm32 ===
    and rbx, -1
    and rax, -1
    and rcx, -1
    and r13, 0x7fffffff
    and rdi, 0x7fffffff
    and r9, -1
    and r8, -1
    and r10, 0x7fffffff
    and rbx, 0x7fffffff
    and r8, 0x7fffffff

// === AND m64, imm32 ===
    and QWORD PTR [rax], 0x7fffffff
    and QWORD PTR [rax + rbx*1 + 0x10], -1
    and QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    and QWORD PTR [rax], -1
    and QWORD PTR [rbx], -1
    and QWORD PTR [rip + 0x1000], 0x7fffffff
    and QWORD PTR [rip + 0x100], 0x7fffffff
    and QWORD PTR [rax + rbx*4 + 0x100], -1
    and QWORD PTR [rip + 0x100], -1
    and QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff

// === AND r16, imm8 ===
    and ax, 0xff
    and cx, 0xff
    and si, 0xff
    and bx, 0xff
    and dx, 0xff
    and di, 0xff

// === AND m16, imm8 ===
    and WORD PTR [rip + 0x100], 0xff
    and WORD PTR [rbx], 0xff
    and WORD PTR [rax], 0xff
    and WORD PTR [rip + 0x1000], 0xff
    and WORD PTR [rax + rbx*1 + 0x10], 0xff
    and WORD PTR [rax + rbx*4 + 0x100], 0xff

// === AND r32, imm8 ===
    and esi, 0xff
    and edi, 0xff
    and eax, 0xff
    and ebx, 0xff
    and edx, 0xff
    and ecx, 0xff

// === AND m32, imm8 ===
    and DWORD PTR [rbx], 0xff
    and DWORD PTR [rip + 0x1000], 0xff
    and DWORD PTR [rax], 0xff
    and DWORD PTR [rip + 0x100], 0xff
    and DWORD PTR [rax + rbx*4 + 0x100], 0xff
    and DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === AND r64, imm8 ===
    and rdi, 0xff
    and r11, 0xff
    and rbx, 0xff
    and r13, 0xff
    and rax, 0xff
    and r12, 0xff
    and rdx, 0xff
    and r8, 0xff
    and rcx, 0xff
    and r10, 0xff

// === AND m64, imm8 ===
    and QWORD PTR [rbx], 0xff
    and QWORD PTR [rax + rbx*1 + 0x10], 0xff
    and QWORD PTR [rax + rbx*4 + 0x100], 0xff
    and QWORD PTR [rip + 0x1000], 0xff
    and QWORD PTR [rax], 0xff
    and QWORD PTR [rip + 0x100], 0xff

// === AND r16, r16 ===
    and dx, si
    and cx, ax
    and si, cx
    and si, dx
    and ax, si
    and si, ax
    and cx, si
    and bx, dx
    and bx, cx
    and si, bx

// === AND m16, r16 ===
    and WORD PTR [rax + rbx*4 + 0x100], si
    and WORD PTR [rip + 0x1000], si
    and WORD PTR [rip + 0x100], si
    and WORD PTR [rax + rbx*4 + 0x100], bx
    and WORD PTR [rax + rbx*4 + 0x100], ax
    and WORD PTR [rip + 0x100], bx
    and WORD PTR [rip + 0x100], dx
    and WORD PTR [rip + 0x100], di
    and WORD PTR [rip + 0x100], ax
    and WORD PTR [rip + 0x1000], di

// === AND r32, r32 ===
    and edi, edx
    and esi, eax
    and ecx, eax
    and ecx, esi
    and edx, ebx
    and ecx, edx
    and eax, esi
    and edx, edx
    and eax, edi
    and esi, ebx

// === AND m32, r32 ===
    and DWORD PTR [rbx], eax
    and DWORD PTR [rax], ebx
    and DWORD PTR [rax + rbx*4 + 0x100], edi
    and DWORD PTR [rax + rbx*1 + 0x10], edx
    and DWORD PTR [rip + 0x1000], esi
    and DWORD PTR [rip + 0x100], esi
    and DWORD PTR [rbx], edx
    and DWORD PTR [rax], ecx
    and DWORD PTR [rax], esi
    and DWORD PTR [rax + rbx*1 + 0x10], ebx

// === AND r64, r64 ===
    and rbx, r9
    and rdi, rdi
    and r10, rdi
    and r9, r9
    and rsi, r13
    and rbx, r12
    and r13, rcx
    and r9, rsi
    and r8, r11
    and rcx, rbx

// === AND m64, r64 ===
    and QWORD PTR [rax], r10
    and QWORD PTR [rip + 0x1000], r12
    and QWORD PTR [rip + 0x100], rcx
    and QWORD PTR [rax + rbx*1 + 0x10], rbx
    and QWORD PTR [rip + 0x100], r13
    and QWORD PTR [rip + 0x100], r8
    and QWORD PTR [rbx], r8
    and QWORD PTR [rax + rbx*1 + 0x10], rcx
    and QWORD PTR [rbx], rcx
    and QWORD PTR [rip + 0x100], r9

// === AND r16, m16 ===
    and cx, WORD PTR [rip + 0x100]
    and si, WORD PTR [rax]
    and dx, WORD PTR [rax]
    and di, WORD PTR [rax + rbx*1 + 0x10]
    and di, WORD PTR [rip + 0x1000]
    and cx, WORD PTR [rax + rbx*1 + 0x10]
    and bx, WORD PTR [rax]
    and si, WORD PTR [rax + rbx*1 + 0x10]
    and cx, WORD PTR [rax + rbx*4 + 0x100]
    and ax, WORD PTR [rax + rbx*1 + 0x10]

// === AND r32, m32 ===
    and edx, DWORD PTR [rip + 0x100]
    and ebx, DWORD PTR [rax]
    and esi, DWORD PTR [rbx]
    and ebx, DWORD PTR [rax + rbx*1 + 0x10]
    and edx, DWORD PTR [rax]
    and edi, DWORD PTR [rip + 0x100]
    and eax, DWORD PTR [rip + 0x1000]
    and eax, DWORD PTR [rax]
    and edi, DWORD PTR [rax + rbx*4 + 0x100]
    and ebx, DWORD PTR [rip + 0x1000]

// === AND r64, m64 ===
    and rdi, QWORD PTR [rax + rbx*4 + 0x100]
    and rsi, QWORD PTR [rax]
    and r9, QWORD PTR [rbx]
    and rdx, QWORD PTR [rbx]
    and rsi, QWORD PTR [rax + rbx*4 + 0x100]
    and rcx, QWORD PTR [rip + 0x100]
    and r11, QWORD PTR [rax + rbx*1 + 0x10]
    and r13, QWORD PTR [rax + rbx*1 + 0x10]
    and rax, QWORD PTR [rax]
    and rbx, QWORD PTR [rax + rbx*4 + 0x100]

// === BSF r16, r16 ===
    bsf si, di
    bsf si, bx
    bsf bx, di
    bsf cx, di
    bsf dx, bx
    bsf ax, bx
    bsf dx, ax
    bsf dx, si
    bsf cx, ax
    bsf ax, cx

// === BSF r16, m16 ===
    bsf si, WORD PTR [rip + 0x1000]
    bsf di, WORD PTR [rax]
    bsf ax, WORD PTR [rax]
    bsf si, WORD PTR [rax + rbx*1 + 0x10]
    bsf ax, WORD PTR [rip + 0x100]
    bsf bx, WORD PTR [rax + rbx*4 + 0x100]
    bsf ax, WORD PTR [rip + 0x1000]
    bsf ax, WORD PTR [rax + rbx*1 + 0x10]
    bsf cx, WORD PTR [rbx]
    bsf dx, WORD PTR [rax]

// === BSF r32, r32 ===
    bsf esi, ebx
    bsf ebx, eax
    bsf eax, edx
    bsf esi, ecx
    bsf edi, eax
    bsf ecx, edi
    bsf esi, esi
    bsf ecx, esi
    bsf edi, ecx
    bsf ebx, edi

// === BSF r32, m32 ===
    bsf ebx, DWORD PTR [rip + 0x100]
    bsf esi, DWORD PTR [rax + rbx*4 + 0x100]
    bsf edx, DWORD PTR [rip + 0x100]
    bsf esi, DWORD PTR [rip + 0x100]
    bsf ebx, DWORD PTR [rax + rbx*4 + 0x100]
    bsf ecx, DWORD PTR [rbx]
    bsf esi, DWORD PTR [rax + rbx*1 + 0x10]
    bsf ecx, DWORD PTR [rax + rbx*4 + 0x100]
    bsf eax, DWORD PTR [rax + rbx*4 + 0x100]
    bsf edi, DWORD PTR [rax]

// === BSF r64, r64 ===
    bsf r11, r13
    bsf r10, rcx
    bsf r9, rdx
    bsf rsi, r10
    bsf rbx, rdx
    bsf r13, rbx
    bsf rax, rsi
    bsf rdi, rax
    bsf rcx, rdi
    bsf r10, r12

// === BSF r64, m64 ===
    bsf r11, QWORD PTR [rax + rbx*4 + 0x100]
    bsf rdx, QWORD PTR [rip + 0x1000]
    bsf rcx, QWORD PTR [rax]
    bsf r9, QWORD PTR [rax + rbx*1 + 0x10]
    bsf rdi, QWORD PTR [rax + rbx*4 + 0x100]
    bsf rsi, QWORD PTR [rip + 0x100]
    bsf rdx, QWORD PTR [rax + rbx*1 + 0x10]
    bsf rcx, QWORD PTR [rax + rbx*4 + 0x100]
    bsf r10, QWORD PTR [rax]
    bsf r8, QWORD PTR [rax + rbx*1 + 0x10]

// === BSR r16, r16 ===
    bsr si, dx
    bsr ax, di
    bsr dx, dx
    bsr bx, si
    bsr si, bx
    bsr di, cx
    bsr cx, si
    bsr si, cx
    bsr bx, cx
    bsr bx, dx

// === BSR r16, m16 ===
    bsr di, WORD PTR [rax + rbx*1 + 0x10]
    bsr dx, WORD PTR [rbx]
    bsr si, WORD PTR [rax]
    bsr cx, WORD PTR [rax + rbx*1 + 0x10]
    bsr ax, WORD PTR [rax + rbx*4 + 0x100]
    bsr dx, WORD PTR [rax + rbx*1 + 0x10]
    bsr di, WORD PTR [rax]
    bsr dx, WORD PTR [rip + 0x100]
    bsr ax, WORD PTR [rax + rbx*1 + 0x10]
    bsr bx, WORD PTR [rip + 0x100]

// === BSR r32, r32 ===
    bsr ebx, edi
    bsr eax, esi
    bsr ecx, ecx
    bsr eax, eax
    bsr edx, edi
    bsr edi, ecx
    bsr edi, eax
    bsr edi, esi
    bsr eax, ebx
    bsr eax, edx

// === BSR r32, m32 ===
    bsr esi, DWORD PTR [rax + rbx*4 + 0x100]
    bsr eax, DWORD PTR [rip + 0x100]
    bsr edi, DWORD PTR [rax]
    bsr ebx, DWORD PTR [rax + rbx*1 + 0x10]
    bsr ecx, DWORD PTR [rip + 0x1000]
    bsr edx, DWORD PTR [rip + 0x1000]
    bsr edx, DWORD PTR [rax]
    bsr edi, DWORD PTR [rip + 0x1000]
    bsr ebx, DWORD PTR [rbx]
    bsr esi, DWORD PTR [rax + rbx*1 + 0x10]

// === BSR r64, r64 ===
    bsr rdx, rdi
    bsr rsi, r13
    bsr rbx, r12
    bsr rcx, rax
    bsr rcx, rcx
    bsr r9, rdi
    bsr r11, rdi
    bsr rax, rax
    bsr rcx, r8
    bsr r13, rax

// === BSR r64, m64 ===
    bsr rbx, QWORD PTR [rax + rbx*1 + 0x10]
    bsr rdx, QWORD PTR [rip + 0x1000]
    bsr rcx, QWORD PTR [rax + rbx*1 + 0x10]
    bsr r12, QWORD PTR [rip + 0x1000]
    bsr r12, QWORD PTR [rip + 0x100]
    bsr rsi, QWORD PTR [rax + rbx*4 + 0x100]
    bsr rdi, QWORD PTR [rax]
    bsr r9, QWORD PTR [rax + rbx*1 + 0x10]
    bsr rax, QWORD PTR [rax + rbx*4 + 0x100]
    bsr rbx, QWORD PTR [rax + rbx*4 + 0x100]

// === BSWAP r32 ===
    bswap edi
    bswap ebx
    bswap edx
    bswap esi
    bswap eax
    bswap ecx

// === BSWAP r64 ===
    bswap r13
    bswap r11
    bswap r8
    bswap rsi
    bswap rcx
    bswap rax
    bswap rdx
    bswap r12
    bswap r9
    bswap rdi

// === BT r16, r16 ===
    bt cx, si
    bt bx, ax
    bt cx, dx
    bt dx, ax
    bt di, si
    bt ax, cx
    bt bx, bx
    bt ax, bx
    bt bx, dx
    bt di, bx

// === BT m16, r16 ===
    bt WORD PTR [rax], di
    bt WORD PTR [rip + 0x100], di
    bt WORD PTR [rip + 0x1000], bx
    bt WORD PTR [rax], cx
    bt WORD PTR [rip + 0x100], ax
    bt WORD PTR [rip + 0x100], si
    bt WORD PTR [rax + rbx*4 + 0x100], di
    bt WORD PTR [rax + rbx*1 + 0x10], si
    bt WORD PTR [rax], dx
    bt WORD PTR [rax], ax

// === BT r32, r32 ===
    bt esi, edx
    bt ebx, esi
    bt ecx, ecx
    bt esi, esi
    bt eax, edi
    bt esi, ecx
    bt esi, edi
    bt edx, edi
    bt edx, ebx
    bt edi, edi

// === BT m32, r32 ===
    bt DWORD PTR [rax], edx
    bt DWORD PTR [rip + 0x100], esi
    bt DWORD PTR [rax], edi
    bt DWORD PTR [rax], ecx
    bt DWORD PTR [rbx], edx
    bt DWORD PTR [rip + 0x100], edi
    bt DWORD PTR [rip + 0x100], ebx
    bt DWORD PTR [rax], esi
    bt DWORD PTR [rax + rbx*4 + 0x100], esi
    bt DWORD PTR [rbx], esi

// === BT r64, r64 ===
    bt r11, r9
    bt rcx, r10
    bt rsi, rdi
    bt rsi, rax
    bt r12, rbx
    bt r10, rcx
    bt rcx, r13
    bt r9, rcx
    bt rax, rax
    bt rdx, r11

// === BT m64, r64 ===
    bt QWORD PTR [rax + rbx*1 + 0x10], r10
    bt QWORD PTR [rbx], r12
    bt QWORD PTR [rbx], rcx
    bt QWORD PTR [rip + 0x1000], rcx
    bt QWORD PTR [rax], rsi
    bt QWORD PTR [rax + rbx*1 + 0x10], r9
    bt QWORD PTR [rax + rbx*1 + 0x10], r12
    bt QWORD PTR [rbx], r13
    bt QWORD PTR [rip + 0x100], r13
    bt QWORD PTR [rax], rbx

// === BT r16, imm8 ===
    bt dx, 0xff
    bt si, 0xff
    bt di, 0xff
    bt bx, 0xff
    bt ax, 0xff
    bt cx, 0xff

// === BT m16, imm8 ===
    bt WORD PTR [rbx], 0xff
    bt WORD PTR [rip + 0x100], 0xff
    bt WORD PTR [rip + 0x1000], 0xff
    bt WORD PTR [rax], 0xff
    bt WORD PTR [rax + rbx*1 + 0x10], 0xff
    bt WORD PTR [rax + rbx*4 + 0x100], 0xff

// === BT r32, imm8 ===
    bt ebx, 0xff
    bt edi, 0xff
    bt eax, 0xff
    bt ecx, 0xff
    bt esi, 0xff
    bt edx, 0xff

// === BT m32, imm8 ===
    bt DWORD PTR [rip + 0x100], 0xff
    bt DWORD PTR [rbx], 0xff
    bt DWORD PTR [rax], 0xff
    bt DWORD PTR [rax + rbx*1 + 0x10], 0xff
    bt DWORD PTR [rip + 0x1000], 0xff
    bt DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === BT r64, imm8 ===
    bt r10, 0xff
    bt r8, 0xff
    bt rax, 0xff
    bt r9, 0xff
    bt r13, 0xff
    bt r12, 0xff
    bt rbx, 0xff
    bt r11, 0xff
    bt rcx, 0xff
    bt rsi, 0xff

// === BT m64, imm8 ===
    bt QWORD PTR [rax + rbx*1 + 0x10], 0xff
    bt QWORD PTR [rbx], 0xff
    bt QWORD PTR [rax + rbx*4 + 0x100], 0xff
    bt QWORD PTR [rip + 0x100], 0xff
    bt QWORD PTR [rip + 0x1000], 0xff
    bt QWORD PTR [rax], 0xff

// === BTC r16, r16 ===
    btc ax, cx
    btc di, si
    btc dx, bx
    btc dx, dx
    btc bx, dx
    btc ax, bx
    btc di, cx
    btc si, di
    btc si, dx
    btc si, bx

// === BTC m16, r16 ===
    btc WORD PTR [rbx], cx
    btc WORD PTR [rbx], si
    btc WORD PTR [rax], di
    btc WORD PTR [rax + rbx*1 + 0x10], si
    btc WORD PTR [rax + rbx*1 + 0x10], dx
    btc WORD PTR [rax], cx
    btc WORD PTR [rip + 0x1000], cx
    btc WORD PTR [rax + rbx*4 + 0x100], di
    btc WORD PTR [rbx], ax
    btc WORD PTR [rax + rbx*4 + 0x100], dx

// === BTC r32, r32 ===
    btc ebx, esi
    btc edx, esi
    btc ebx, ecx
    btc ecx, eax
    btc eax, edx
    btc ecx, ebx
    btc edx, edi
    btc esi, eax
    btc edi, ebx
    btc esi, ebx

// === BTC m32, r32 ===
    btc DWORD PTR [rax + rbx*4 + 0x100], edx
    btc DWORD PTR [rbx], edx
    btc DWORD PTR [rax], ebx
    btc DWORD PTR [rip + 0x100], esi
    btc DWORD PTR [rax + rbx*4 + 0x100], edi
    btc DWORD PTR [rax], ecx
    btc DWORD PTR [rbx], ecx
    btc DWORD PTR [rbx], esi
    btc DWORD PTR [rax], edx
    btc DWORD PTR [rax + rbx*1 + 0x10], ecx

// === BTC r64, r64 ===
    btc rbx, r13
    btc r12, r8
    btc rbx, rax
    btc rbx, r11
    btc r13, r9
    btc rdi, r12
    btc rdx, rdi
    btc r10, r12
    btc rsi, r8
    btc rsi, rax

// === BTC m64, r64 ===
    btc QWORD PTR [rax + rbx*1 + 0x10], rbx
    btc QWORD PTR [rax], rdx
    btc QWORD PTR [rip + 0x1000], r10
    btc QWORD PTR [rip + 0x100], rax
    btc QWORD PTR [rbx], r9
    btc QWORD PTR [rbx], rax
    btc QWORD PTR [rax + rbx*1 + 0x10], rcx
    btc QWORD PTR [rax + rbx*4 + 0x100], r8
    btc QWORD PTR [rbx], r8
    btc QWORD PTR [rbx], r10

// === BTC r16, imm8 ===
    btc ax, 0xff
    btc di, 0xff
    btc dx, 0xff
    btc si, 0xff
    btc bx, 0xff
    btc cx, 0xff

// === BTC m16, imm8 ===
    btc WORD PTR [rip + 0x100], 0xff
    btc WORD PTR [rbx], 0xff
    btc WORD PTR [rip + 0x1000], 0xff
    btc WORD PTR [rax + rbx*4 + 0x100], 0xff
    btc WORD PTR [rax], 0xff
    btc WORD PTR [rax + rbx*1 + 0x10], 0xff

// === BTC r32, imm8 ===
    btc esi, 0xff
    btc edi, 0xff
    btc eax, 0xff
    btc ebx, 0xff
    btc ecx, 0xff
    btc edx, 0xff

// === BTC m32, imm8 ===
    btc DWORD PTR [rbx], 0xff
    btc DWORD PTR [rax], 0xff
    btc DWORD PTR [rax + rbx*1 + 0x10], 0xff
    btc DWORD PTR [rip + 0x100], 0xff
    btc DWORD PTR [rax + rbx*4 + 0x100], 0xff
    btc DWORD PTR [rip + 0x1000], 0xff

// === BTC r64, imm8 ===
    btc rdx, 0xff
    btc rcx, 0xff
    btc rbx, 0xff
    btc rsi, 0xff
    btc r11, 0xff
    btc rax, 0xff
    btc r8, 0xff
    btc r13, 0xff
    btc rdi, 0xff
    btc r9, 0xff

// === BTC m64, imm8 ===
    btc QWORD PTR [rip + 0x1000], 0xff
    btc QWORD PTR [rax], 0xff
    btc QWORD PTR [rip + 0x100], 0xff
    btc QWORD PTR [rbx], 0xff
    btc QWORD PTR [rax + rbx*1 + 0x10], 0xff
    btc QWORD PTR [rax + rbx*4 + 0x100], 0xff

// === BTR r16, r16 ===
    btr dx, di
    btr cx, di
    btr bx, di
    btr ax, cx
    btr di, si
    btr si, ax
    btr ax, dx
    btr di, cx
    btr si, di
    btr di, bx

// === BTR m16, r16 ===
    btr WORD PTR [rip + 0x1000], si
    btr WORD PTR [rax], cx
    btr WORD PTR [rax], bx
    btr WORD PTR [rax + rbx*4 + 0x100], ax
    btr WORD PTR [rax], dx
    btr WORD PTR [rax], si
    btr WORD PTR [rbx], dx
    btr WORD PTR [rip + 0x1000], cx
    btr WORD PTR [rip + 0x1000], ax
    btr WORD PTR [rax + rbx*4 + 0x100], bx

// === BTR r32, r32 ===
    btr edx, ebx
    btr esi, ebx
    btr esi, edx
    btr edi, ecx
    btr ecx, esi
    btr ecx, eax
    btr edi, eax
    btr esi, esi
    btr edi, esi
    btr ebx, edi

// === BTR m32, r32 ===
    btr DWORD PTR [rip + 0x1000], edx
    btr DWORD PTR [rip + 0x1000], ecx
    btr DWORD PTR [rax], eax
    btr DWORD PTR [rax + rbx*4 + 0x100], esi
    btr DWORD PTR [rax], edx
    btr DWORD PTR [rip + 0x100], edi
    btr DWORD PTR [rax], edi
    btr DWORD PTR [rip + 0x100], edx
    btr DWORD PTR [rax], ebx
    btr DWORD PTR [rax + rbx*4 + 0x100], edx

// === BTR r64, r64 ===
    btr r8, rcx
    btr rax, r10
    btr rcx, rax
    btr rdx, r11
    btr rbx, r9
    btr rax, r12
    btr rcx, r8
    btr rdx, r12
    btr rsi, rsi
    btr rsi, rdx

// === BTR m64, r64 ===
    btr QWORD PTR [rax + rbx*1 + 0x10], r11
    btr QWORD PTR [rax + rbx*4 + 0x100], r12
    btr QWORD PTR [rip + 0x1000], rcx
    btr QWORD PTR [rip + 0x1000], rsi
    btr QWORD PTR [rax + rbx*1 + 0x10], r10
    btr QWORD PTR [rip + 0x1000], r9
    btr QWORD PTR [rax], rbx
    btr QWORD PTR [rbx], rax
    btr QWORD PTR [rip + 0x1000], r13
    btr QWORD PTR [rax + rbx*1 + 0x10], r12

// === BTR r16, imm8 ===
    btr di, 0xff
    btr cx, 0xff
    btr bx, 0xff
    btr si, 0xff
    btr dx, 0xff
    btr ax, 0xff

// === BTR m16, imm8 ===
    btr WORD PTR [rax + rbx*1 + 0x10], 0xff
    btr WORD PTR [rbx], 0xff
    btr WORD PTR [rax], 0xff
    btr WORD PTR [rip + 0x100], 0xff
    btr WORD PTR [rax + rbx*4 + 0x100], 0xff
    btr WORD PTR [rip + 0x1000], 0xff

// === BTR r32, imm8 ===
    btr edi, 0xff
    btr ecx, 0xff
    btr eax, 0xff
    btr ebx, 0xff
    btr esi, 0xff
    btr edx, 0xff

// === BTR m32, imm8 ===
    btr DWORD PTR [rip + 0x1000], 0xff
    btr DWORD PTR [rbx], 0xff
    btr DWORD PTR [rip + 0x100], 0xff
    btr DWORD PTR [rax], 0xff
    btr DWORD PTR [rax + rbx*4 + 0x100], 0xff
    btr DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === BTR r64, imm8 ===
    btr r12, 0xff
    btr r13, 0xff
    btr r11, 0xff
    btr rbx, 0xff
    btr r8, 0xff
    btr r9, 0xff
    btr rax, 0xff
    btr rdi, 0xff
    btr rdx, 0xff
    btr rcx, 0xff

// === BTR m64, imm8 ===
    btr QWORD PTR [rbx], 0xff
    btr QWORD PTR [rax + rbx*1 + 0x10], 0xff
    btr QWORD PTR [rax], 0xff
    btr QWORD PTR [rip + 0x1000], 0xff
    btr QWORD PTR [rax + rbx*4 + 0x100], 0xff
    btr QWORD PTR [rip + 0x100], 0xff

// === BTS r16, r16 ===
    bts si, di
    bts bx, si
    bts si, si
    bts di, ax
    bts dx, ax
    bts cx, bx
    bts di, si
    bts ax, ax
    bts dx, si
    bts di, bx

// === BTS m16, r16 ===
    bts WORD PTR [rip + 0x1000], dx
    bts WORD PTR [rax], ax
    bts WORD PTR [rbx], ax
    bts WORD PTR [rax + rbx*4 + 0x100], bx
    bts WORD PTR [rax + rbx*4 + 0x100], ax
    bts WORD PTR [rax + rbx*4 + 0x100], di
    bts WORD PTR [rax], cx
    bts WORD PTR [rip + 0x100], si
    bts WORD PTR [rax + rbx*4 + 0x100], dx
    bts WORD PTR [rip + 0x100], di

// === BTS r32, r32 ===
    bts eax, esi
    bts ebx, edx
    bts edi, ecx
    bts esi, ebx
    bts eax, ebx
    bts eax, ecx
    bts edx, ebx
    bts esi, ecx
    bts edx, edx
    bts ebx, ecx

// === BTS m32, r32 ===
    bts DWORD PTR [rip + 0x1000], ecx
    bts DWORD PTR [rbx], edi
    bts DWORD PTR [rip + 0x100], edi
    bts DWORD PTR [rbx], edx
    bts DWORD PTR [rax + rbx*1 + 0x10], edx
    bts DWORD PTR [rbx], ebx
    bts DWORD PTR [rip + 0x100], eax
    bts DWORD PTR [rax + rbx*4 + 0x100], ebx
    bts DWORD PTR [rip + 0x1000], esi
    bts DWORD PTR [rax + rbx*1 + 0x10], eax

// === BTS r64, r64 ===
    bts rdx, r8
    bts r11, rsi
    bts r10, r12
    bts rbx, r12
    bts rbx, rcx
    bts r12, r8
    bts r13, r8
    bts r13, rsi
    bts r11, r9
    bts rbx, r11

// === BTS m64, r64 ===
    bts QWORD PTR [rax + rbx*4 + 0x100], r9
    bts QWORD PTR [rip + 0x1000], rax
    bts QWORD PTR [rax + rbx*4 + 0x100], r12
    bts QWORD PTR [rip + 0x100], rdx
    bts QWORD PTR [rbx], rdi
    bts QWORD PTR [rbx], r11
    bts QWORD PTR [rax], rax
    bts QWORD PTR [rax], r8
    bts QWORD PTR [rax], rcx
    bts QWORD PTR [rax + rbx*1 + 0x10], r11

// === BTS r16, imm8 ===
    bts ax, 0xff
    bts dx, 0xff
    bts si, 0xff
    bts di, 0xff
    bts bx, 0xff
    bts cx, 0xff

// === BTS m16, imm8 ===
    bts WORD PTR [rax], 0xff
    bts WORD PTR [rax + rbx*4 + 0x100], 0xff
    bts WORD PTR [rbx], 0xff
    bts WORD PTR [rax + rbx*1 + 0x10], 0xff
    bts WORD PTR [rip + 0x1000], 0xff
    bts WORD PTR [rip + 0x100], 0xff

// === BTS r32, imm8 ===
    bts esi, 0xff
    bts ecx, 0xff
    bts eax, 0xff
    bts edi, 0xff
    bts edx, 0xff
    bts ebx, 0xff

// === BTS m32, imm8 ===
    bts DWORD PTR [rip + 0x100], 0xff
    bts DWORD PTR [rip + 0x1000], 0xff
    bts DWORD PTR [rbx], 0xff
    bts DWORD PTR [rax + rbx*1 + 0x10], 0xff
    bts DWORD PTR [rax + rbx*4 + 0x100], 0xff
    bts DWORD PTR [rax], 0xff

// === BTS r64, imm8 ===
    bts r10, 0xff
    bts rdx, 0xff
    bts r12, 0xff
    bts rsi, 0xff
    bts rdi, 0xff
    bts r8, 0xff
    bts rax, 0xff
    bts r9, 0xff
    bts r11, 0xff
    bts r13, 0xff

// === BTS m64, imm8 ===
    bts QWORD PTR [rip + 0x100], 0xff
    bts QWORD PTR [rax + rbx*1 + 0x10], 0xff
    bts QWORD PTR [rip + 0x1000], 0xff
    bts QWORD PTR [rax + rbx*4 + 0x100], 0xff
    bts QWORD PTR [rbx], 0xff
    bts QWORD PTR [rax], 0xff

// === CALL rel32 ===
    call .

// === CALL r64 ===
    call r10
    call r11
    call r12
    call rbx
    call rax
    call r8
    call r9
    call rdx
    call r13
    call rdi

// === CALL m64 ===
    call QWORD PTR [rax + rbx*4 + 0x100]
    call QWORD PTR [rbx]
    call QWORD PTR [rax]
    call QWORD PTR [rip + 0x100]
    call QWORD PTR [rax + rbx*1 + 0x10]
    call QWORD PTR [rip + 0x1000]

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
    cmova ax, bx
    cmova bx, si
    cmova dx, bx
    cmova dx, dx
    cmova ax, dx
    cmova di, bx
    cmova di, cx
    cmova ax, di
    cmova bx, cx
    cmova bx, di

// === CMOVA r16, m16 ===
    cmova bx, WORD PTR [rip + 0x1000]
    cmova cx, WORD PTR [rax]
    cmova di, WORD PTR [rip + 0x100]
    cmova si, WORD PTR [rip + 0x1000]
    cmova bx, WORD PTR [rax]
    cmova dx, WORD PTR [rip + 0x1000]
    cmova bx, WORD PTR [rbx]
    cmova di, WORD PTR [rbx]
    cmova dx, WORD PTR [rax + rbx*1 + 0x10]
    cmova ax, WORD PTR [rip + 0x100]

// === CMOVA r32, r32 ===
    cmova eax, edi
    cmova ecx, ecx
    cmova ecx, ebx
    cmova ecx, esi
    cmova edi, edi
    cmova eax, ebx
    cmova edi, ecx
    cmova ebx, ecx
    cmova esi, ecx
    cmova edx, edx

// === CMOVA r32, m32 ===
    cmova ecx, DWORD PTR [rip + 0x1000]
    cmova eax, DWORD PTR [rax]
    cmova edi, DWORD PTR [rip + 0x1000]
    cmova esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmova edi, DWORD PTR [rax]
    cmova ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmova ecx, DWORD PTR [rax]
    cmova esi, DWORD PTR [rip + 0x100]
    cmova ecx, DWORD PTR [rbx]
    cmova esi, DWORD PTR [rip + 0x1000]

// === CMOVA r64, r64 ===
    cmova rbx, rdx
    cmova r9, rax
    cmova rdi, rsi
    cmova r12, rcx
    cmova rsi, rdi
    cmova rbx, r12
    cmova r12, r11
    cmova rax, r10
    cmova rcx, r8
    cmova rbx, rax

// === CMOVA r64, m64 ===
    cmova r12, QWORD PTR [rbx]
    cmova rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmova rdi, QWORD PTR [rip + 0x100]
    cmova rsi, QWORD PTR [rbx]
    cmova r13, QWORD PTR [rip + 0x100]
    cmova r11, QWORD PTR [rbx]
    cmova rax, QWORD PTR [rip + 0x1000]
    cmova rcx, QWORD PTR [rbx]
    cmova r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmova r13, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVAE r16, r16 ===
    cmovae dx, si
    cmovae di, dx
    cmovae si, bx
    cmovae bx, si
    cmovae cx, bx
    cmovae dx, ax
    cmovae si, cx
    cmovae ax, ax
    cmovae di, si
    cmovae di, ax

// === CMOVAE r16, m16 ===
    cmovae si, WORD PTR [rbx]
    cmovae cx, WORD PTR [rbx]
    cmovae cx, WORD PTR [rip + 0x1000]
    cmovae di, WORD PTR [rbx]
    cmovae cx, WORD PTR [rax]
    cmovae dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovae si, WORD PTR [rip + 0x1000]
    cmovae bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovae dx, WORD PTR [rbx]
    cmovae di, WORD PTR [rip + 0x100]

// === CMOVAE r32, r32 ===
    cmovae esi, esi
    cmovae ebx, ebx
    cmovae ecx, ebx
    cmovae edx, ecx
    cmovae eax, edi
    cmovae esi, edx
    cmovae edx, esi
    cmovae ecx, edi
    cmovae eax, esi
    cmovae edi, esi

// === CMOVAE r32, m32 ===
    cmovae ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovae esi, DWORD PTR [rbx]
    cmovae esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovae ecx, DWORD PTR [rax]
    cmovae edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovae ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovae eax, DWORD PTR [rip + 0x100]
    cmovae ecx, DWORD PTR [rbx]
    cmovae esi, DWORD PTR [rip + 0x1000]
    cmovae esi, DWORD PTR [rip + 0x100]

// === CMOVAE r64, r64 ===
    cmovae rdi, r11
    cmovae rsi, r9
    cmovae r12, rax
    cmovae rdx, r11
    cmovae r8, r11
    cmovae r8, rsi
    cmovae rdi, rdx
    cmovae rbx, r9
    cmovae r8, rdi
    cmovae rax, rsi

// === CMOVAE r64, m64 ===
    cmovae r9, QWORD PTR [rax]
    cmovae r10, QWORD PTR [rip + 0x100]
    cmovae rdx, QWORD PTR [rax]
    cmovae rax, QWORD PTR [rip + 0x100]
    cmovae r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmovae rsi, QWORD PTR [rbx]
    cmovae r9, QWORD PTR [rbx]
    cmovae rsi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovae r13, QWORD PTR [rip + 0x1000]
    cmovae r11, QWORD PTR [rip + 0x1000]

// === CMOVB r16, r16 ===
    cmovb dx, di
    cmovb dx, si
    cmovb dx, dx
    cmovb si, si
    cmovb si, cx
    cmovb dx, ax
    cmovb ax, dx
    cmovb di, di
    cmovb si, ax
    cmovb ax, cx

// === CMOVB r16, m16 ===
    cmovb si, WORD PTR [rax + rbx*4 + 0x100]
    cmovb ax, WORD PTR [rax]
    cmovb ax, WORD PTR [rbx]
    cmovb si, WORD PTR [rax + rbx*1 + 0x10]
    cmovb di, WORD PTR [rax + rbx*4 + 0x100]
    cmovb ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovb dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovb cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovb dx, WORD PTR [rip + 0x1000]
    cmovb cx, WORD PTR [rax]

// === CMOVB r32, r32 ===
    cmovb edi, ecx
    cmovb eax, esi
    cmovb edi, esi
    cmovb edx, eax
    cmovb edi, eax
    cmovb edx, edx
    cmovb ecx, esi
    cmovb edi, edi
    cmovb ebx, ebx
    cmovb ecx, edi

// === CMOVB r32, m32 ===
    cmovb ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovb esi, DWORD PTR [rip + 0x1000]
    cmovb edx, DWORD PTR [rip + 0x100]
    cmovb esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovb eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovb ecx, DWORD PTR [rax]
    cmovb edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovb edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovb edi, DWORD PTR [rip + 0x100]
    cmovb ebx, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVB r64, r64 ===
    cmovb rdi, rsi
    cmovb rax, rcx
    cmovb r13, r13
    cmovb rsi, rcx
    cmovb r10, r8
    cmovb rbx, r9
    cmovb r13, r10
    cmovb r11, rcx
    cmovb rdi, r9
    cmovb rbx, rsi

// === CMOVB r64, m64 ===
    cmovb rax, QWORD PTR [rbx]
    cmovb rdi, QWORD PTR [rax]
    cmovb r12, QWORD PTR [rbx]
    cmovb r10, QWORD PTR [rax + rbx*1 + 0x10]
    cmovb r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovb r8, QWORD PTR [rip + 0x1000]
    cmovb rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovb rsi, QWORD PTR [rip + 0x100]
    cmovb rbx, QWORD PTR [rip + 0x1000]
    cmovb r8, QWORD PTR [rbx]

// === CMOVBE r16, r16 ===
    cmovbe si, di
    cmovbe cx, si
    cmovbe bx, di
    cmovbe dx, si
    cmovbe ax, di
    cmovbe dx, bx
    cmovbe cx, bx
    cmovbe ax, ax
    cmovbe ax, bx
    cmovbe si, dx

// === CMOVBE r16, m16 ===
    cmovbe si, WORD PTR [rax + rbx*1 + 0x10]
    cmovbe ax, WORD PTR [rip + 0x100]
    cmovbe di, WORD PTR [rbx]
    cmovbe ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovbe di, WORD PTR [rip + 0x100]
    cmovbe cx, WORD PTR [rbx]
    cmovbe di, WORD PTR [rax + rbx*4 + 0x100]
    cmovbe dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovbe si, WORD PTR [rax + rbx*4 + 0x100]
    cmovbe dx, WORD PTR [rax]

// === CMOVBE r32, r32 ===
    cmovbe ebx, edx
    cmovbe ecx, edx
    cmovbe ebx, eax
    cmovbe ebx, edi
    cmovbe edx, ebx
    cmovbe ecx, ecx
    cmovbe edi, ecx
    cmovbe esi, ecx
    cmovbe edx, esi
    cmovbe esi, edx

// === CMOVBE r32, m32 ===
    cmovbe edi, DWORD PTR [rip + 0x1000]
    cmovbe edi, DWORD PTR [rbx]
    cmovbe ebx, DWORD PTR [rax]
    cmovbe esi, DWORD PTR [rax]
    cmovbe ebx, DWORD PTR [rbx]
    cmovbe ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovbe edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovbe eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovbe edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovbe ecx, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVBE r64, r64 ===
    cmovbe r9, r9
    cmovbe r8, rcx
    cmovbe r12, r8
    cmovbe rcx, r8
    cmovbe rdx, r8
    cmovbe r9, r10
    cmovbe rdi, r13
    cmovbe rax, r10
    cmovbe r11, r10
    cmovbe r11, r9

// === CMOVBE r64, m64 ===
    cmovbe r9, QWORD PTR [rax + rbx*1 + 0x10]
    cmovbe r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmovbe r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovbe r12, QWORD PTR [rbx]
    cmovbe rsi, QWORD PTR [rip + 0x100]
    cmovbe r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovbe rcx, QWORD PTR [rip + 0x100]
    cmovbe rdi, QWORD PTR [rbx]
    cmovbe r9, QWORD PTR [rip + 0x1000]
    cmovbe rax, QWORD PTR [rbx]

// === CMOVC r16, r16 ===
    cmovc dx, dx
    cmovc si, dx
    cmovc cx, ax
    cmovc cx, bx
    cmovc ax, dx
    cmovc cx, si
    cmovc dx, cx
    cmovc bx, cx
    cmovc ax, ax
    cmovc cx, dx

// === CMOVC r16, m16 ===
    cmovc bx, WORD PTR [rip + 0x1000]
    cmovc bx, WORD PTR [rax]
    cmovc si, WORD PTR [rip + 0x100]
    cmovc ax, WORD PTR [rax]
    cmovc di, WORD PTR [rip + 0x1000]
    cmovc ax, WORD PTR [rip + 0x100]
    cmovc cx, WORD PTR [rip + 0x1000]
    cmovc ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovc cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovc si, WORD PTR [rbx]

// === CMOVC r32, r32 ===
    cmovc ebx, edi
    cmovc ecx, edi
    cmovc ecx, ecx
    cmovc ebx, esi
    cmovc edi, edx
    cmovc ecx, ebx
    cmovc ebx, edx
    cmovc edx, eax
    cmovc edi, edi
    cmovc edi, eax

// === CMOVC r32, m32 ===
    cmovc eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovc edx, DWORD PTR [rax]
    cmovc esi, DWORD PTR [rip + 0x1000]
    cmovc eax, DWORD PTR [rax]
    cmovc eax, DWORD PTR [rip + 0x1000]
    cmovc ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovc ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovc esi, DWORD PTR [rip + 0x100]
    cmovc edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovc ecx, DWORD PTR [rax]

// === CMOVC r64, r64 ===
    cmovc rbx, r10
    cmovc rbx, r12
    cmovc rdi, r10
    cmovc rdx, r13
    cmovc r9, rsi
    cmovc r8, r8
    cmovc rbx, rsi
    cmovc r13, rsi
    cmovc r9, r9
    cmovc r8, rbx

// === CMOVC r64, m64 ===
    cmovc r10, QWORD PTR [rip + 0x1000]
    cmovc r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovc r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovc r12, QWORD PTR [rax]
    cmovc rsi, QWORD PTR [rip + 0x1000]
    cmovc r9, QWORD PTR [rip + 0x1000]
    cmovc r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovc r8, QWORD PTR [rip + 0x1000]
    cmovc r10, QWORD PTR [rbx]
    cmovc r13, QWORD PTR [rip + 0x100]

// === CMOVE r16, r16 ===
    cmove ax, di
    cmove cx, di
    cmove bx, cx
    cmove dx, cx
    cmove si, si
    cmove cx, ax
    cmove si, di
    cmove si, ax
    cmove bx, di
    cmove bx, ax

// === CMOVE r16, m16 ===
    cmove di, WORD PTR [rbx]
    cmove si, WORD PTR [rip + 0x1000]
    cmove bx, WORD PTR [rax + rbx*4 + 0x100]
    cmove dx, WORD PTR [rax + rbx*1 + 0x10]
    cmove ax, WORD PTR [rax + rbx*1 + 0x10]
    cmove cx, WORD PTR [rax + rbx*4 + 0x100]
    cmove si, WORD PTR [rip + 0x100]
    cmove dx, WORD PTR [rbx]
    cmove bx, WORD PTR [rax]
    cmove cx, WORD PTR [rax]

// === CMOVE r32, r32 ===
    cmove ecx, eax
    cmove ebx, eax
    cmove esi, edx
    cmove edx, eax
    cmove ecx, edx
    cmove ebx, ebx
    cmove esi, esi
    cmove eax, ecx
    cmove edx, edi
    cmove edi, esi

// === CMOVE r32, m32 ===
    cmove ecx, DWORD PTR [rbx]
    cmove ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmove ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmove ebx, DWORD PTR [rax]
    cmove ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmove esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmove ecx, DWORD PTR [rax]
    cmove eax, DWORD PTR [rip + 0x1000]
    cmove edi, DWORD PTR [rbx]
    cmove esi, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVE r64, r64 ===
    cmove r12, rdx
    cmove rdi, rbx
    cmove r10, r13
    cmove r12, r13
    cmove r8, r8
    cmove rsi, r9
    cmove r9, rsi
    cmove rbx, rdx
    cmove r10, r12
    cmove rdx, rax

// === CMOVE r64, m64 ===
    cmove rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmove r10, QWORD PTR [rax + rbx*1 + 0x10]
    cmove rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmove r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmove r10, QWORD PTR [rax]
    cmove rdi, QWORD PTR [rbx]
    cmove r11, QWORD PTR [rip + 0x100]
    cmove r12, QWORD PTR [rbx]
    cmove r13, QWORD PTR [rax]
    cmove r9, QWORD PTR [rip + 0x100]

// === CMOVG r16, r16 ===
    cmovg si, cx
    cmovg cx, si
    cmovg si, ax
    cmovg si, si
    cmovg cx, di
    cmovg di, ax
    cmovg bx, si
    cmovg dx, cx
    cmovg ax, dx
    cmovg si, bx

// === CMOVG r16, m16 ===
    cmovg bx, WORD PTR [rip + 0x100]
    cmovg bx, WORD PTR [rax]
    cmovg si, WORD PTR [rbx]
    cmovg cx, WORD PTR [rip + 0x100]
    cmovg si, WORD PTR [rax]
    cmovg si, WORD PTR [rip + 0x1000]
    cmovg ax, WORD PTR [rip + 0x1000]
    cmovg ax, WORD PTR [rbx]
    cmovg cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovg bx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVG r32, r32 ===
    cmovg ebx, edi
    cmovg esi, ebx
    cmovg ecx, ebx
    cmovg eax, edi
    cmovg esi, ecx
    cmovg esi, edx
    cmovg edi, ebx
    cmovg eax, esi
    cmovg edi, eax
    cmovg ebx, eax

// === CMOVG r32, m32 ===
    cmovg esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovg ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovg ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovg eax, DWORD PTR [rax]
    cmovg ecx, DWORD PTR [rip + 0x1000]
    cmovg edx, DWORD PTR [rax]
    cmovg ebx, DWORD PTR [rbx]
    cmovg eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovg edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovg ecx, DWORD PTR [rbx]

// === CMOVG r64, r64 ===
    cmovg rax, rbx
    cmovg rdi, rdx
    cmovg rax, rdx
    cmovg rax, rsi
    cmovg rsi, rax
    cmovg r9, r9
    cmovg r10, rbx
    cmovg r12, r13
    cmovg rbx, rax
    cmovg r11, r13

// === CMOVG r64, m64 ===
    cmovg r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovg r11, QWORD PTR [rip + 0x100]
    cmovg rsi, QWORD PTR [rip + 0x1000]
    cmovg rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovg r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovg r13, QWORD PTR [rip + 0x1000]
    cmovg r8, QWORD PTR [rbx]
    cmovg r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovg rbx, QWORD PTR [rip + 0x100]
    cmovg r13, QWORD PTR [rbx]

// === CMOVGE r16, r16 ===
    cmovge si, si
    cmovge ax, bx
    cmovge dx, si
    cmovge si, cx
    cmovge cx, bx
    cmovge ax, dx
    cmovge cx, di
    cmovge ax, si
    cmovge di, ax
    cmovge ax, di

// === CMOVGE r16, m16 ===
    cmovge di, WORD PTR [rax + rbx*4 + 0x100]
    cmovge di, WORD PTR [rip + 0x100]
    cmovge ax, WORD PTR [rax]
    cmovge ax, WORD PTR [rip + 0x1000]
    cmovge di, WORD PTR [rbx]
    cmovge bx, WORD PTR [rip + 0x1000]
    cmovge cx, WORD PTR [rbx]
    cmovge di, WORD PTR [rax]
    cmovge dx, WORD PTR [rip + 0x100]
    cmovge bx, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVGE r32, r32 ===
    cmovge esi, ebx
    cmovge ebx, edi
    cmovge eax, edi
    cmovge edx, ecx
    cmovge edi, edx
    cmovge edx, esi
    cmovge esi, edx
    cmovge ebx, eax
    cmovge edi, ecx
    cmovge edi, eax

// === CMOVGE r32, m32 ===
    cmovge edi, DWORD PTR [rax]
    cmovge eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovge esi, DWORD PTR [rbx]
    cmovge ebx, DWORD PTR [rip + 0x1000]
    cmovge edi, DWORD PTR [rip + 0x1000]
    cmovge edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovge edx, DWORD PTR [rbx]
    cmovge ebx, DWORD PTR [rip + 0x100]
    cmovge edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovge eax, DWORD PTR [rip + 0x1000]

// === CMOVGE r64, r64 ===
    cmovge rdx, rcx
    cmovge rcx, rax
    cmovge rax, r12
    cmovge r12, r9
    cmovge rsi, r10
    cmovge rdi, r11
    cmovge r9, r13
    cmovge rcx, rsi
    cmovge rdx, r10
    cmovge r9, rbx

// === CMOVGE r64, m64 ===
    cmovge rcx, QWORD PTR [rip + 0x100]
    cmovge rdi, QWORD PTR [rax]
    cmovge rsi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovge rcx, QWORD PTR [rip + 0x1000]
    cmovge rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovge r12, QWORD PTR [rip + 0x100]
    cmovge r12, QWORD PTR [rax]
    cmovge r13, QWORD PTR [rbx]
    cmovge r8, QWORD PTR [rax]
    cmovge rsi, QWORD PTR [rip + 0x100]

// === CMOVL r16, r16 ===
    cmovl ax, bx
    cmovl bx, cx
    cmovl ax, dx
    cmovl cx, cx
    cmovl dx, cx
    cmovl dx, dx
    cmovl di, si
    cmovl cx, ax
    cmovl ax, cx
    cmovl ax, di

// === CMOVL r16, m16 ===
    cmovl si, WORD PTR [rip + 0x1000]
    cmovl si, WORD PTR [rip + 0x100]
    cmovl cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovl dx, WORD PTR [rip + 0x1000]
    cmovl cx, WORD PTR [rbx]
    cmovl ax, WORD PTR [rax]
    cmovl dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovl di, WORD PTR [rax + rbx*1 + 0x10]
    cmovl dx, WORD PTR [rbx]
    cmovl bx, WORD PTR [rip + 0x100]

// === CMOVL r32, r32 ===
    cmovl esi, edx
    cmovl esi, esi
    cmovl edi, edx
    cmovl ecx, edx
    cmovl edi, esi
    cmovl esi, ebx
    cmovl eax, ebx
    cmovl edx, edi
    cmovl eax, edx
    cmovl edi, ebx

// === CMOVL r32, m32 ===
    cmovl ebx, DWORD PTR [rip + 0x100]
    cmovl eax, DWORD PTR [rax]
    cmovl eax, DWORD PTR [rip + 0x1000]
    cmovl edx, DWORD PTR [rax]
    cmovl ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovl esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovl edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovl eax, DWORD PTR [rip + 0x100]
    cmovl esi, DWORD PTR [rax]
    cmovl eax, DWORD PTR [rbx]

// === CMOVL r64, r64 ===
    cmovl rdi, rbx
    cmovl r13, r13
    cmovl rsi, r10
    cmovl r11, rdi
    cmovl r13, rdx
    cmovl r10, rcx
    cmovl r13, r11
    cmovl rsi, rsi
    cmovl rbx, r11
    cmovl r13, rbx

// === CMOVL r64, m64 ===
    cmovl rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovl r11, QWORD PTR [rip + 0x1000]
    cmovl rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovl rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovl r9, QWORD PTR [rbx]
    cmovl r10, QWORD PTR [rbx]
    cmovl r11, QWORD PTR [rax + rbx*1 + 0x10]
    cmovl rbx, QWORD PTR [rip + 0x1000]
    cmovl r8, QWORD PTR [rax + rbx*4 + 0x100]
    cmovl rdx, QWORD PTR [rip + 0x1000]

// === CMOVLE r16, r16 ===
    cmovle ax, si
    cmovle cx, di
    cmovle bx, bx
    cmovle di, di
    cmovle dx, dx
    cmovle cx, si
    cmovle si, dx
    cmovle di, si
    cmovle di, dx
    cmovle cx, dx

// === CMOVLE r16, m16 ===
    cmovle di, WORD PTR [rip + 0x1000]
    cmovle bx, WORD PTR [rip + 0x100]
    cmovle bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovle si, WORD PTR [rip + 0x1000]
    cmovle bx, WORD PTR [rbx]
    cmovle si, WORD PTR [rbx]
    cmovle di, WORD PTR [rip + 0x100]
    cmovle ax, WORD PTR [rax]
    cmovle cx, WORD PTR [rbx]
    cmovle ax, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVLE r32, r32 ===
    cmovle esi, esi
    cmovle ecx, edx
    cmovle esi, edi
    cmovle ecx, edi
    cmovle edx, edx
    cmovle edx, edi
    cmovle edx, esi
    cmovle eax, esi
    cmovle edx, ecx
    cmovle ecx, esi

// === CMOVLE r32, m32 ===
    cmovle ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovle ecx, DWORD PTR [rip + 0x1000]
    cmovle ecx, DWORD PTR [rip + 0x100]
    cmovle edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovle ebx, DWORD PTR [rax]
    cmovle ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovle edi, DWORD PTR [rbx]
    cmovle eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovle ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovle edi, DWORD PTR [rip + 0x1000]

// === CMOVLE r64, r64 ===
    cmovle rdi, r11
    cmovle r12, rcx
    cmovle r10, r13
    cmovle r11, r9
    cmovle rsi, r10
    cmovle r13, r9
    cmovle rsi, rbx
    cmovle r12, rbx
    cmovle r13, r12
    cmovle r8, r12

// === CMOVLE r64, m64 ===
    cmovle rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovle r9, QWORD PTR [rax + rbx*1 + 0x10]
    cmovle rbx, QWORD PTR [rip + 0x1000]
    cmovle r12, QWORD PTR [rax]
    cmovle r11, QWORD PTR [rip + 0x100]
    cmovle r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovle rsi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovle rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovle r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovle rdi, QWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNA r16, r16 ===
    cmovna ax, cx
    cmovna di, dx
    cmovna cx, ax
    cmovna si, dx
    cmovna dx, si
    cmovna bx, di
    cmovna ax, ax
    cmovna si, bx
    cmovna cx, di
    cmovna dx, bx

// === CMOVNA r16, m16 ===
    cmovna ax, WORD PTR [rax]
    cmovna di, WORD PTR [rax + rbx*1 + 0x10]
    cmovna si, WORD PTR [rax + rbx*4 + 0x100]
    cmovna di, WORD PTR [rip + 0x1000]
    cmovna bx, WORD PTR [rbx]
    cmovna cx, WORD PTR [rbx]
    cmovna bx, WORD PTR [rip + 0x100]
    cmovna cx, WORD PTR [rip + 0x100]
    cmovna di, WORD PTR [rbx]
    cmovna cx, WORD PTR [rip + 0x1000]

// === CMOVNA r32, r32 ===
    cmovna esi, ebx
    cmovna edx, edx
    cmovna edx, esi
    cmovna eax, esi
    cmovna edi, esi
    cmovna ecx, edx
    cmovna edi, edi
    cmovna eax, eax
    cmovna eax, ecx
    cmovna eax, ebx

// === CMOVNA r32, m32 ===
    cmovna ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovna esi, DWORD PTR [rax]
    cmovna eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovna ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovna edi, DWORD PTR [rbx]
    cmovna ecx, DWORD PTR [rip + 0x100]
    cmovna edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovna edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovna ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovna ecx, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNA r64, r64 ===
    cmovna rax, rdi
    cmovna rdx, r11
    cmovna rcx, r8
    cmovna rax, r11
    cmovna r8, r9
    cmovna rsi, r13
    cmovna r8, r12
    cmovna r13, rcx
    cmovna r9, rcx
    cmovna rax, r12

// === CMOVNA r64, m64 ===
    cmovna rdi, QWORD PTR [rip + 0x1000]
    cmovna rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovna r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovna r11, QWORD PTR [rip + 0x100]
    cmovna rbx, QWORD PTR [rax]
    cmovna r11, QWORD PTR [rip + 0x1000]
    cmovna rcx, QWORD PTR [rip + 0x1000]
    cmovna r10, QWORD PTR [rax + rbx*1 + 0x10]
    cmovna r8, QWORD PTR [rax + rbx*4 + 0x100]
    cmovna r13, QWORD PTR [rip + 0x1000]

// === CMOVNAE r16, r16 ===
    cmovnae di, bx
    cmovnae si, cx
    cmovnae di, ax
    cmovnae bx, ax
    cmovnae cx, cx
    cmovnae di, di
    cmovnae si, bx
    cmovnae ax, di
    cmovnae dx, dx
    cmovnae ax, bx

// === CMOVNAE r16, m16 ===
    cmovnae dx, WORD PTR [rbx]
    cmovnae dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnae bx, WORD PTR [rip + 0x100]
    cmovnae cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnae dx, WORD PTR [rip + 0x1000]
    cmovnae si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnae cx, WORD PTR [rip + 0x1000]
    cmovnae dx, WORD PTR [rax]
    cmovnae dx, WORD PTR [rip + 0x100]
    cmovnae si, WORD PTR [rax]

// === CMOVNAE r32, r32 ===
    cmovnae edx, ecx
    cmovnae eax, edi
    cmovnae esi, edi
    cmovnae esi, eax
    cmovnae esi, esi
    cmovnae eax, edx
    cmovnae ecx, eax
    cmovnae ebx, esi
    cmovnae edi, edi
    cmovnae ecx, ecx

// === CMOVNAE r32, m32 ===
    cmovnae eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnae esi, DWORD PTR [rbx]
    cmovnae ecx, DWORD PTR [rbx]
    cmovnae edi, DWORD PTR [rax]
    cmovnae edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnae esi, DWORD PTR [rip + 0x100]
    cmovnae ebx, DWORD PTR [rip + 0x100]
    cmovnae edi, DWORD PTR [rbx]
    cmovnae esi, DWORD PTR [rip + 0x1000]
    cmovnae ecx, DWORD PTR [rip + 0x1000]

// === CMOVNAE r64, r64 ===
    cmovnae r11, r9
    cmovnae rsi, r9
    cmovnae r9, r8
    cmovnae rdi, r8
    cmovnae rdi, r11
    cmovnae rax, r9
    cmovnae rax, rdi
    cmovnae rdi, rsi
    cmovnae r13, r11
    cmovnae rsi, r12

// === CMOVNAE r64, m64 ===
    cmovnae r13, QWORD PTR [rbx]
    cmovnae r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnae rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnae r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnae r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnae rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnae r8, QWORD PTR [rip + 0x100]
    cmovnae rcx, QWORD PTR [rbx]
    cmovnae r13, QWORD PTR [rax]
    cmovnae r11, QWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNB r16, r16 ===
    cmovnb si, ax
    cmovnb dx, dx
    cmovnb di, bx
    cmovnb cx, ax
    cmovnb cx, bx
    cmovnb cx, si
    cmovnb ax, ax
    cmovnb di, ax
    cmovnb cx, di
    cmovnb cx, dx

// === CMOVNB r16, m16 ===
    cmovnb dx, WORD PTR [rbx]
    cmovnb cx, WORD PTR [rip + 0x100]
    cmovnb cx, WORD PTR [rbx]
    cmovnb di, WORD PTR [rax]
    cmovnb di, WORD PTR [rax + rbx*1 + 0x10]
    cmovnb di, WORD PTR [rip + 0x100]
    cmovnb bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnb cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnb si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnb dx, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVNB r32, r32 ===
    cmovnb eax, ebx
    cmovnb ecx, ecx
    cmovnb edi, edi
    cmovnb edi, edx
    cmovnb ecx, eax
    cmovnb edx, esi
    cmovnb ecx, edi
    cmovnb ecx, edx
    cmovnb ebx, esi
    cmovnb edi, ecx

// === CMOVNB r32, m32 ===
    cmovnb ebx, DWORD PTR [rbx]
    cmovnb ebx, DWORD PTR [rip + 0x100]
    cmovnb ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnb ecx, DWORD PTR [rip + 0x100]
    cmovnb eax, DWORD PTR [rip + 0x1000]
    cmovnb edi, DWORD PTR [rip + 0x100]
    cmovnb ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnb edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnb eax, DWORD PTR [rbx]
    cmovnb esi, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNB r64, r64 ===
    cmovnb r12, r12
    cmovnb rbx, rdx
    cmovnb r8, rcx
    cmovnb rdx, rdx
    cmovnb r13, r13
    cmovnb rsi, r9
    cmovnb rax, rsi
    cmovnb rax, r9
    cmovnb rbx, rsi
    cmovnb r8, r11

// === CMOVNB r64, m64 ===
    cmovnb r9, QWORD PTR [rip + 0x1000]
    cmovnb r13, QWORD PTR [rax]
    cmovnb rsi, QWORD PTR [rip + 0x1000]
    cmovnb r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnb r13, QWORD PTR [rip + 0x1000]
    cmovnb rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnb rbx, QWORD PTR [rip + 0x100]
    cmovnb rdi, QWORD PTR [rip + 0x1000]
    cmovnb rdi, QWORD PTR [rip + 0x100]
    cmovnb rdi, QWORD PTR [rax]

// === CMOVNBE r16, r16 ===
    cmovnbe si, di
    cmovnbe bx, dx
    cmovnbe cx, cx
    cmovnbe di, dx
    cmovnbe ax, ax
    cmovnbe dx, ax
    cmovnbe bx, si
    cmovnbe dx, cx
    cmovnbe ax, di
    cmovnbe dx, di

// === CMOVNBE r16, m16 ===
    cmovnbe ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnbe dx, WORD PTR [rip + 0x100]
    cmovnbe di, WORD PTR [rax + rbx*1 + 0x10]
    cmovnbe si, WORD PTR [rax]
    cmovnbe dx, WORD PTR [rip + 0x1000]
    cmovnbe si, WORD PTR [rbx]
    cmovnbe si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnbe cx, WORD PTR [rip + 0x1000]
    cmovnbe di, WORD PTR [rbx]
    cmovnbe ax, WORD PTR [rip + 0x1000]

// === CMOVNBE r32, r32 ===
    cmovnbe ecx, esi
    cmovnbe ebx, edi
    cmovnbe esi, esi
    cmovnbe edx, edx
    cmovnbe edx, edi
    cmovnbe ebx, ecx
    cmovnbe ebx, edx
    cmovnbe edx, ebx
    cmovnbe ecx, edi
    cmovnbe edx, eax

// === CMOVNBE r32, m32 ===
    cmovnbe edx, DWORD PTR [rax]
    cmovnbe edx, DWORD PTR [rbx]
    cmovnbe ebx, DWORD PTR [rip + 0x100]
    cmovnbe esi, DWORD PTR [rbx]
    cmovnbe ecx, DWORD PTR [rax]
    cmovnbe ebx, DWORD PTR [rbx]
    cmovnbe eax, DWORD PTR [rax]
    cmovnbe ecx, DWORD PTR [rbx]
    cmovnbe eax, DWORD PTR [rip + 0x100]
    cmovnbe edx, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVNBE r64, r64 ===
    cmovnbe rcx, r9
    cmovnbe r12, rsi
    cmovnbe r11, rdx
    cmovnbe r8, r8
    cmovnbe r12, rdx
    cmovnbe rdi, r9
    cmovnbe r13, r13
    cmovnbe r11, r8
    cmovnbe r9, rbx
    cmovnbe r13, rsi

// === CMOVNBE r64, m64 ===
    cmovnbe r10, QWORD PTR [rax]
    cmovnbe rdx, QWORD PTR [rip + 0x1000]
    cmovnbe r12, QWORD PTR [rax]
    cmovnbe r9, QWORD PTR [rip + 0x1000]
    cmovnbe r13, QWORD PTR [rbx]
    cmovnbe rdi, QWORD PTR [rip + 0x1000]
    cmovnbe r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnbe r10, QWORD PTR [rbx]
    cmovnbe r8, QWORD PTR [rax]
    cmovnbe rdi, QWORD PTR [rbx]

// === CMOVNC r16, r16 ===
    cmovnc di, dx
    cmovnc bx, di
    cmovnc dx, si
    cmovnc cx, di
    cmovnc ax, bx
    cmovnc si, si
    cmovnc dx, dx
    cmovnc si, ax
    cmovnc di, bx
    cmovnc bx, bx

// === CMOVNC r16, m16 ===
    cmovnc ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovnc di, WORD PTR [rip + 0x1000]
    cmovnc bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnc bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnc ax, WORD PTR [rax]
    cmovnc si, WORD PTR [rax + rbx*4 + 0x100]
    cmovnc di, WORD PTR [rip + 0x100]
    cmovnc si, WORD PTR [rbx]
    cmovnc cx, WORD PTR [rip + 0x100]
    cmovnc cx, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVNC r32, r32 ===
    cmovnc ecx, edx
    cmovnc ecx, edi
    cmovnc edi, ecx
    cmovnc edx, ecx
    cmovnc edi, ebx
    cmovnc ebx, ecx
    cmovnc ecx, ecx
    cmovnc eax, eax
    cmovnc esi, eax
    cmovnc edi, esi

// === CMOVNC r32, m32 ===
    cmovnc edi, DWORD PTR [rip + 0x1000]
    cmovnc ecx, DWORD PTR [rax]
    cmovnc ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnc edx, DWORD PTR [rbx]
    cmovnc esi, DWORD PTR [rax]
    cmovnc edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnc ebx, DWORD PTR [rax]
    cmovnc ebx, DWORD PTR [rip + 0x100]
    cmovnc edi, DWORD PTR [rip + 0x100]
    cmovnc edi, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNC r64, r64 ===
    cmovnc r10, rsi
    cmovnc rbx, r10
    cmovnc rsi, r9
    cmovnc rbx, rsi
    cmovnc r8, r12
    cmovnc rcx, rcx
    cmovnc rax, rbx
    cmovnc rsi, r12
    cmovnc r10, rdx
    cmovnc rdx, rdx

// === CMOVNC r64, m64 ===
    cmovnc rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnc rax, QWORD PTR [rax]
    cmovnc rbx, QWORD PTR [rbx]
    cmovnc r9, QWORD PTR [rbx]
    cmovnc r10, QWORD PTR [rbx]
    cmovnc r8, QWORD PTR [rax]
    cmovnc rdx, QWORD PTR [rax]
    cmovnc r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnc r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnc r9, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNE r16, r16 ===
    cmovne ax, di
    cmovne si, ax
    cmovne dx, di
    cmovne di, dx
    cmovne dx, ax
    cmovne si, bx
    cmovne dx, dx
    cmovne bx, di
    cmovne si, cx
    cmovne ax, dx

// === CMOVNE r16, m16 ===
    cmovne dx, WORD PTR [rip + 0x1000]
    cmovne ax, WORD PTR [rip + 0x1000]
    cmovne dx, WORD PTR [rbx]
    cmovne ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovne bx, WORD PTR [rax]
    cmovne cx, WORD PTR [rip + 0x100]
    cmovne si, WORD PTR [rip + 0x100]
    cmovne dx, WORD PTR [rip + 0x100]
    cmovne cx, WORD PTR [rax]
    cmovne si, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVNE r32, r32 ===
    cmovne esi, ebx
    cmovne eax, ebx
    cmovne edi, ebx
    cmovne edx, ecx
    cmovne edi, ecx
    cmovne esi, edx
    cmovne eax, esi
    cmovne esi, eax
    cmovne edx, eax
    cmovne ecx, edi

// === CMOVNE r32, m32 ===
    cmovne edi, DWORD PTR [rbx]
    cmovne esi, DWORD PTR [rip + 0x1000]
    cmovne eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovne ecx, DWORD PTR [rip + 0x100]
    cmovne eax, DWORD PTR [rip + 0x100]
    cmovne edi, DWORD PTR [rip + 0x1000]
    cmovne edx, DWORD PTR [rip + 0x1000]
    cmovne eax, DWORD PTR [rbx]
    cmovne ecx, DWORD PTR [rbx]
    cmovne ecx, DWORD PTR [rip + 0x1000]

// === CMOVNE r64, r64 ===
    cmovne rbx, r13
    cmovne r11, r9
    cmovne r12, rax
    cmovne rbx, r10
    cmovne rdi, r10
    cmovne r11, rbx
    cmovne rdx, r8
    cmovne r10, rcx
    cmovne r11, r8
    cmovne r9, rax

// === CMOVNE r64, m64 ===
    cmovne r9, QWORD PTR [rax + rbx*1 + 0x10]
    cmovne rcx, QWORD PTR [rax]
    cmovne rdi, QWORD PTR [rbx]
    cmovne rbx, QWORD PTR [rip + 0x100]
    cmovne rdx, QWORD PTR [rip + 0x1000]
    cmovne r8, QWORD PTR [rip + 0x1000]
    cmovne rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovne rcx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovne rax, QWORD PTR [rbx]
    cmovne r8, QWORD PTR [rip + 0x100]

// === CMOVNG r16, r16 ===
    cmovng di, ax
    cmovng si, di
    cmovng si, dx
    cmovng cx, cx
    cmovng si, ax
    cmovng bx, si
    cmovng bx, bx
    cmovng cx, si
    cmovng cx, bx
    cmovng di, si

// === CMOVNG r16, m16 ===
    cmovng di, WORD PTR [rax]
    cmovng ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovng cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovng bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovng cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovng si, WORD PTR [rbx]
    cmovng di, WORD PTR [rip + 0x1000]
    cmovng cx, WORD PTR [rax]
    cmovng ax, WORD PTR [rbx]
    cmovng bx, WORD PTR [rax]

// === CMOVNG r32, r32 ===
    cmovng esi, ecx
    cmovng ecx, esi
    cmovng edi, esi
    cmovng edi, edx
    cmovng esi, esi
    cmovng eax, ebx
    cmovng edx, eax
    cmovng edx, edx
    cmovng eax, edx
    cmovng edi, eax

// === CMOVNG r32, m32 ===
    cmovng ebx, DWORD PTR [rax]
    cmovng ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng eax, DWORD PTR [rip + 0x100]
    cmovng ecx, DWORD PTR [rax]
    cmovng ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovng edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovng eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovng ecx, DWORD PTR [rip + 0x100]

// === CMOVNG r64, r64 ===
    cmovng rdx, r12
    cmovng r12, r10
    cmovng r11, rdi
    cmovng rdx, rdx
    cmovng r9, r8
    cmovng r10, rsi
    cmovng rbx, r10
    cmovng r9, r9
    cmovng r12, r8
    cmovng rax, rax

// === CMOVNG r64, m64 ===
    cmovng r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovng rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovng rdi, QWORD PTR [rip + 0x1000]
    cmovng r13, QWORD PTR [rip + 0x100]
    cmovng r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovng r12, QWORD PTR [rip + 0x1000]
    cmovng r12, QWORD PTR [rbx]
    cmovng rbx, QWORD PTR [rip + 0x1000]
    cmovng r9, QWORD PTR [rbx]
    cmovng rax, QWORD PTR [rbx]

// === CMOVNGE r16, r16 ===
    cmovnge bx, bx
    cmovnge cx, si
    cmovnge dx, di
    cmovnge di, di
    cmovnge dx, cx
    cmovnge cx, ax
    cmovnge ax, cx
    cmovnge si, cx
    cmovnge si, ax
    cmovnge di, dx

// === CMOVNGE r16, m16 ===
    cmovnge di, WORD PTR [rbx]
    cmovnge ax, WORD PTR [rip + 0x100]
    cmovnge ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovnge dx, WORD PTR [rax]
    cmovnge cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnge bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnge ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnge si, WORD PTR [rip + 0x100]
    cmovnge cx, WORD PTR [rip + 0x100]
    cmovnge di, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVNGE r32, r32 ===
    cmovnge edx, edx
    cmovnge eax, eax
    cmovnge edx, esi
    cmovnge ecx, edx
    cmovnge ecx, ecx
    cmovnge edi, edi
    cmovnge ebx, esi
    cmovnge esi, edx
    cmovnge ebx, ebx
    cmovnge edx, edi

// === CMOVNGE r32, m32 ===
    cmovnge esi, DWORD PTR [rbx]
    cmovnge ecx, DWORD PTR [rip + 0x100]
    cmovnge ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnge edi, DWORD PTR [rax]
    cmovnge ebx, DWORD PTR [rip + 0x100]
    cmovnge eax, DWORD PTR [rip + 0x100]
    cmovnge esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnge edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnge eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnge edx, DWORD PTR [rip + 0x1000]

// === CMOVNGE r64, r64 ===
    cmovnge r11, r13
    cmovnge r11, rcx
    cmovnge r12, r13
    cmovnge r8, rbx
    cmovnge rdx, r10
    cmovnge rcx, r8
    cmovnge r10, r9
    cmovnge rax, r11
    cmovnge r9, r9
    cmovnge r11, rdi

// === CMOVNGE r64, m64 ===
    cmovnge r9, QWORD PTR [rax]
    cmovnge r12, QWORD PTR [rbx]
    cmovnge r11, QWORD PTR [rip + 0x100]
    cmovnge r8, QWORD PTR [rbx]
    cmovnge r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnge r11, QWORD PTR [rbx]
    cmovnge r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnge rbx, QWORD PTR [rip + 0x1000]
    cmovnge rbx, QWORD PTR [rax]
    cmovnge r9, QWORD PTR [rbx]

// === CMOVNL r16, r16 ===
    cmovnl cx, ax
    cmovnl bx, si
    cmovnl si, dx
    cmovnl bx, bx
    cmovnl di, ax
    cmovnl dx, si
    cmovnl di, bx
    cmovnl cx, bx
    cmovnl bx, di
    cmovnl bx, ax

// === CMOVNL r16, m16 ===
    cmovnl bx, WORD PTR [rbx]
    cmovnl si, WORD PTR [rip + 0x100]
    cmovnl bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnl cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovnl ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnl di, WORD PTR [rax]
    cmovnl dx, WORD PTR [rip + 0x100]
    cmovnl cx, WORD PTR [rip + 0x1000]
    cmovnl bx, WORD PTR [rip + 0x1000]
    cmovnl si, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVNL r32, r32 ===
    cmovnl edi, ebx
    cmovnl ebx, ecx
    cmovnl edx, esi
    cmovnl edx, ecx
    cmovnl ebx, esi
    cmovnl ecx, eax
    cmovnl ecx, ebx
    cmovnl edx, edi
    cmovnl eax, eax
    cmovnl ecx, esi

// === CMOVNL r32, m32 ===
    cmovnl esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl ecx, DWORD PTR [rip + 0x100]
    cmovnl edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl ebx, DWORD PTR [rax]
    cmovnl eax, DWORD PTR [rip + 0x100]
    cmovnl edi, DWORD PTR [rip + 0x100]
    cmovnl eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnl ebx, DWORD PTR [rip + 0x100]

// === CMOVNL r64, r64 ===
    cmovnl rax, rdi
    cmovnl rdx, r9
    cmovnl r8, rsi
    cmovnl rcx, rdi
    cmovnl rdi, rax
    cmovnl r9, r10
    cmovnl r8, r10
    cmovnl r10, r12
    cmovnl r8, rax
    cmovnl r12, rcx

// === CMOVNL r64, m64 ===
    cmovnl rax, QWORD PTR [rbx]
    cmovnl r13, QWORD PTR [rip + 0x100]
    cmovnl rcx, QWORD PTR [rbx]
    cmovnl rbx, QWORD PTR [rbx]
    cmovnl rbx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnl rax, QWORD PTR [rax]
    cmovnl r11, QWORD PTR [rip + 0x1000]
    cmovnl rdi, QWORD PTR [rip + 0x100]
    cmovnl r8, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnl rdx, QWORD PTR [rip + 0x100]

// === CMOVNLE r16, r16 ===
    cmovnle si, di
    cmovnle bx, si
    cmovnle dx, si
    cmovnle si, dx
    cmovnle dx, bx
    cmovnle di, ax
    cmovnle cx, bx
    cmovnle cx, si
    cmovnle cx, dx
    cmovnle ax, dx

// === CMOVNLE r16, m16 ===
    cmovnle di, WORD PTR [rip + 0x100]
    cmovnle dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnle cx, WORD PTR [rax]
    cmovnle dx, WORD PTR [rax]
    cmovnle bx, WORD PTR [rbx]
    cmovnle bx, WORD PTR [rip + 0x100]
    cmovnle si, WORD PTR [rip + 0x100]
    cmovnle ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnle ax, WORD PTR [rax]
    cmovnle di, WORD PTR [rax]

// === CMOVNLE r32, r32 ===
    cmovnle ebx, esi
    cmovnle edx, ecx
    cmovnle ecx, edi
    cmovnle eax, ebx
    cmovnle edi, ebx
    cmovnle edi, edi
    cmovnle edi, eax
    cmovnle eax, edi
    cmovnle ecx, ecx
    cmovnle ecx, eax

// === CMOVNLE r32, m32 ===
    cmovnle edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnle esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnle esi, DWORD PTR [rbx]
    cmovnle edi, DWORD PTR [rip + 0x1000]
    cmovnle eax, DWORD PTR [rax]
    cmovnle ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnle edx, DWORD PTR [rbx]
    cmovnle ecx, DWORD PTR [rbx]
    cmovnle edx, DWORD PTR [rip + 0x1000]
    cmovnle edi, DWORD PTR [rip + 0x100]

// === CMOVNLE r64, r64 ===
    cmovnle r9, rsi
    cmovnle rsi, rcx
    cmovnle rax, rdx
    cmovnle r13, r8
    cmovnle rax, r9
    cmovnle r10, rdi
    cmovnle rsi, r13
    cmovnle r10, rdx
    cmovnle rdx, rax
    cmovnle r11, rdi

// === CMOVNLE r64, m64 ===
    cmovnle r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnle rcx, QWORD PTR [rbx]
    cmovnle r13, QWORD PTR [rip + 0x100]
    cmovnle rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnle r10, QWORD PTR [rip + 0x1000]
    cmovnle r12, QWORD PTR [rax]
    cmovnle r8, QWORD PTR [rax]
    cmovnle rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnle rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnle r11, QWORD PTR [rbx]

// === CMOVNO r16, r16 ===
    cmovno bx, bx
    cmovno dx, dx
    cmovno ax, cx
    cmovno di, di
    cmovno si, cx
    cmovno si, di
    cmovno ax, si
    cmovno di, dx
    cmovno ax, ax
    cmovno cx, ax

// === CMOVNO r16, m16 ===
    cmovno di, WORD PTR [rax]
    cmovno si, WORD PTR [rax + rbx*4 + 0x100]
    cmovno dx, WORD PTR [rip + 0x100]
    cmovno dx, WORD PTR [rip + 0x1000]
    cmovno bx, WORD PTR [rax]
    cmovno si, WORD PTR [rbx]
    cmovno cx, WORD PTR [rax]
    cmovno ax, WORD PTR [rax]
    cmovno si, WORD PTR [rip + 0x1000]
    cmovno di, WORD PTR [rax + rbx*1 + 0x10]

// === CMOVNO r32, r32 ===
    cmovno ebx, ebx
    cmovno ebx, edi
    cmovno ebx, esi
    cmovno edx, eax
    cmovno ecx, esi
    cmovno edi, ebx
    cmovno edx, esi
    cmovno eax, ecx
    cmovno esi, edi
    cmovno ecx, ecx

// === CMOVNO r32, m32 ===
    cmovno eax, DWORD PTR [rax]
    cmovno edx, DWORD PTR [rbx]
    cmovno esi, DWORD PTR [rip + 0x1000]
    cmovno edx, DWORD PTR [rax]
    cmovno ecx, DWORD PTR [rip + 0x100]
    cmovno ebx, DWORD PTR [rax]
    cmovno edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovno edi, DWORD PTR [rax]
    cmovno ecx, DWORD PTR [rbx]
    cmovno esi, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNO r64, r64 ===
    cmovno rcx, r8
    cmovno rcx, rdi
    cmovno r11, rbx
    cmovno r10, r10
    cmovno rdx, r13
    cmovno rbx, rcx
    cmovno rsi, r12
    cmovno r11, r9
    cmovno r13, r9
    cmovno rdx, r12

// === CMOVNO r64, m64 ===
    cmovno r8, QWORD PTR [rip + 0x1000]
    cmovno r9, QWORD PTR [rax + rbx*4 + 0x100]
    cmovno rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovno rsi, QWORD PTR [rbx]
    cmovno r12, QWORD PTR [rax + rbx*1 + 0x10]
    cmovno rdx, QWORD PTR [rip + 0x1000]
    cmovno rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovno r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovno r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovno rcx, QWORD PTR [rip + 0x100]

// === CMOVNP r16, r16 ===
    cmovnp dx, cx
    cmovnp dx, ax
    cmovnp cx, dx
    cmovnp di, cx
    cmovnp bx, si
    cmovnp di, di
    cmovnp ax, bx
    cmovnp si, si
    cmovnp cx, si
    cmovnp di, ax

// === CMOVNP r16, m16 ===
    cmovnp di, WORD PTR [rax + rbx*1 + 0x10]
    cmovnp bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnp dx, WORD PTR [rip + 0x100]
    cmovnp dx, WORD PTR [rax]
    cmovnp di, WORD PTR [rax]
    cmovnp si, WORD PTR [rax + rbx*1 + 0x10]
    cmovnp ax, WORD PTR [rip + 0x100]
    cmovnp ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnp dx, WORD PTR [rbx]
    cmovnp dx, WORD PTR [rax + rbx*4 + 0x100]

// === CMOVNP r32, r32 ===
    cmovnp ebx, ecx
    cmovnp ebx, edx
    cmovnp edx, edi
    cmovnp edi, ebx
    cmovnp ecx, esi
    cmovnp ebx, eax
    cmovnp esi, ebx
    cmovnp eax, esi
    cmovnp eax, edi
    cmovnp ecx, edi

// === CMOVNP r32, m32 ===
    cmovnp eax, DWORD PTR [rax]
    cmovnp edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnp ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnp ebx, DWORD PTR [rax]
    cmovnp edi, DWORD PTR [rax]
    cmovnp edx, DWORD PTR [rbx]
    cmovnp ecx, DWORD PTR [rax]
    cmovnp ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnp esi, DWORD PTR [rax]
    cmovnp eax, DWORD PTR [rip + 0x1000]

// === CMOVNP r64, r64 ===
    cmovnp rbx, r10
    cmovnp rsi, rcx
    cmovnp r11, rdx
    cmovnp rdx, rdi
    cmovnp r11, r10
    cmovnp r13, rsi
    cmovnp r9, rsi
    cmovnp rcx, rcx
    cmovnp r12, rdx
    cmovnp r12, rdi

// === CMOVNP r64, m64 ===
    cmovnp r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnp r12, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnp r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnp r9, QWORD PTR [rax]
    cmovnp rdi, QWORD PTR [rbx]
    cmovnp r11, QWORD PTR [rax]
    cmovnp rcx, QWORD PTR [rbx]
    cmovnp r8, QWORD PTR [rbx]
    cmovnp r13, QWORD PTR [rax + rbx*1 + 0x10]
    cmovnp r9, QWORD PTR [rip + 0x1000]

// === CMOVNS r16, r16 ===
    cmovns bx, dx
    cmovns cx, ax
    cmovns ax, di
    cmovns bx, bx
    cmovns si, si
    cmovns ax, si
    cmovns di, ax
    cmovns dx, cx
    cmovns dx, dx
    cmovns cx, cx

// === CMOVNS r16, m16 ===
    cmovns bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovns si, WORD PTR [rax + rbx*4 + 0x100]
    cmovns bx, WORD PTR [rip + 0x1000]
    cmovns di, WORD PTR [rax + rbx*1 + 0x10]
    cmovns cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovns di, WORD PTR [rax]
    cmovns bx, WORD PTR [rax]
    cmovns dx, WORD PTR [rip + 0x100]
    cmovns di, WORD PTR [rip + 0x1000]
    cmovns ax, WORD PTR [rip + 0x1000]

// === CMOVNS r32, r32 ===
    cmovns edx, edx
    cmovns ecx, ecx
    cmovns esi, ebx
    cmovns ecx, ebx
    cmovns edi, esi
    cmovns edx, esi
    cmovns eax, ecx
    cmovns edi, edi
    cmovns edi, ecx
    cmovns ebx, esi

// === CMOVNS r32, m32 ===
    cmovns edx, DWORD PTR [rip + 0x100]
    cmovns edi, DWORD PTR [rbx]
    cmovns ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovns ebx, DWORD PTR [rbx]
    cmovns esi, DWORD PTR [rax]
    cmovns eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovns ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovns ecx, DWORD PTR [rbx]
    cmovns edi, DWORD PTR [rip + 0x1000]
    cmovns ebx, DWORD PTR [rax]

// === CMOVNS r64, r64 ===
    cmovns rcx, rdx
    cmovns r8, rsi
    cmovns rbx, rcx
    cmovns rcx, rsi
    cmovns r9, rsi
    cmovns rax, r12
    cmovns r11, r10
    cmovns rdi, rdx
    cmovns r13, r9
    cmovns rcx, rax

// === CMOVNS r64, m64 ===
    cmovns rdx, QWORD PTR [rbx]
    cmovns rdi, QWORD PTR [rax]
    cmovns r8, QWORD PTR [rax]
    cmovns rcx, QWORD PTR [rbx]
    cmovns rcx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovns rbx, QWORD PTR [rax]
    cmovns r9, QWORD PTR [rip + 0x1000]
    cmovns rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovns rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovns r10, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVNZ r16, r16 ===
    cmovnz ax, si
    cmovnz cx, di
    cmovnz di, ax
    cmovnz cx, bx
    cmovnz bx, di
    cmovnz di, di
    cmovnz cx, cx
    cmovnz dx, cx
    cmovnz ax, ax
    cmovnz si, si

// === CMOVNZ r16, m16 ===
    cmovnz bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovnz cx, WORD PTR [rax]
    cmovnz bx, WORD PTR [rip + 0x100]
    cmovnz ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovnz si, WORD PTR [rax]
    cmovnz bx, WORD PTR [rip + 0x1000]
    cmovnz cx, WORD PTR [rip + 0x1000]
    cmovnz di, WORD PTR [rbx]
    cmovnz di, WORD PTR [rip + 0x1000]
    cmovnz cx, WORD PTR [rip + 0x100]

// === CMOVNZ r32, r32 ===
    cmovnz ecx, eax
    cmovnz esi, edi
    cmovnz edx, eax
    cmovnz ecx, edi
    cmovnz edx, ecx
    cmovnz ecx, edx
    cmovnz eax, edx
    cmovnz edx, ebx
    cmovnz ebx, esi
    cmovnz edi, edi

// === CMOVNZ r32, m32 ===
    cmovnz ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnz edx, DWORD PTR [rbx]
    cmovnz eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnz eax, DWORD PTR [rip + 0x1000]
    cmovnz edi, DWORD PTR [rip + 0x100]
    cmovnz edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovnz edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovnz ebx, DWORD PTR [rax]
    cmovnz edx, DWORD PTR [rax]
    cmovnz ecx, DWORD PTR [rax]

// === CMOVNZ r64, r64 ===
    cmovnz rsi, rcx
    cmovnz rax, rdi
    cmovnz r11, r10
    cmovnz r12, r8
    cmovnz r10, rdi
    cmovnz r12, r12
    cmovnz r8, r11
    cmovnz r9, r9
    cmovnz rbx, rsi
    cmovnz rdx, r12

// === CMOVNZ r64, m64 ===
    cmovnz rdx, QWORD PTR [rip + 0x1000]
    cmovnz r8, QWORD PTR [rax]
    cmovnz r10, QWORD PTR [rax]
    cmovnz r13, QWORD PTR [rip + 0x100]
    cmovnz rax, QWORD PTR [rax]
    cmovnz rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovnz r13, QWORD PTR [rax]
    cmovnz rax, QWORD PTR [rip + 0x1000]
    cmovnz rdx, QWORD PTR [rip + 0x100]
    cmovnz rcx, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVO r16, r16 ===
    cmovo si, si
    cmovo ax, si
    cmovo si, bx
    cmovo ax, cx
    cmovo dx, di
    cmovo ax, dx
    cmovo bx, si
    cmovo si, ax
    cmovo dx, si
    cmovo si, di

// === CMOVO r16, m16 ===
    cmovo cx, WORD PTR [rax]
    cmovo si, WORD PTR [rip + 0x1000]
    cmovo cx, WORD PTR [rax + rbx*4 + 0x100]
    cmovo si, WORD PTR [rax]
    cmovo cx, WORD PTR [rip + 0x1000]
    cmovo ax, WORD PTR [rip + 0x1000]
    cmovo si, WORD PTR [rax + rbx*4 + 0x100]
    cmovo si, WORD PTR [rip + 0x100]
    cmovo bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovo dx, WORD PTR [rbx]

// === CMOVO r32, r32 ===
    cmovo esi, eax
    cmovo eax, edx
    cmovo ebx, edi
    cmovo edx, ebx
    cmovo eax, edi
    cmovo edi, esi
    cmovo edi, ecx
    cmovo edi, ebx
    cmovo ecx, edx
    cmovo ecx, eax

// === CMOVO r32, m32 ===
    cmovo edx, DWORD PTR [rip + 0x100]
    cmovo ebx, DWORD PTR [rip + 0x1000]
    cmovo edi, DWORD PTR [rip + 0x1000]
    cmovo eax, DWORD PTR [rip + 0x100]
    cmovo ebx, DWORD PTR [rax]
    cmovo esi, DWORD PTR [rip + 0x100]
    cmovo edi, DWORD PTR [rip + 0x100]
    cmovo ecx, DWORD PTR [rax]
    cmovo edi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovo ecx, DWORD PTR [rax + rbx*1 + 0x10]

// === CMOVO r64, r64 ===
    cmovo r11, r10
    cmovo rdx, r8
    cmovo r9, rbx
    cmovo rsi, r8
    cmovo r9, rsi
    cmovo r11, rax
    cmovo r8, r8
    cmovo r10, r10
    cmovo r13, r8
    cmovo r9, rdi

// === CMOVO r64, m64 ===
    cmovo rbx, QWORD PTR [rip + 0x100]
    cmovo rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovo rbx, QWORD PTR [rax]
    cmovo r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovo rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovo r12, QWORD PTR [rip + 0x100]
    cmovo rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovo rdx, QWORD PTR [rax]
    cmovo r10, QWORD PTR [rax]
    cmovo r12, QWORD PTR [rip + 0x1000]

// === CMOVP r16, r16 ===
    cmovp dx, bx
    cmovp si, bx
    cmovp ax, di
    cmovp ax, bx
    cmovp cx, si
    cmovp cx, dx
    cmovp cx, bx
    cmovp bx, dx
    cmovp di, dx
    cmovp bx, ax

// === CMOVP r16, m16 ===
    cmovp dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovp di, WORD PTR [rip + 0x100]
    cmovp dx, WORD PTR [rax]
    cmovp si, WORD PTR [rbx]
    cmovp cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovp si, WORD PTR [rax + rbx*4 + 0x100]
    cmovp di, WORD PTR [rbx]
    cmovp ax, WORD PTR [rax]
    cmovp bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovp di, WORD PTR [rax]

// === CMOVP r32, r32 ===
    cmovp ebx, ecx
    cmovp ecx, ecx
    cmovp ecx, eax
    cmovp edi, eax
    cmovp esi, eax
    cmovp esi, edi
    cmovp edi, esi
    cmovp esi, esi
    cmovp ebx, esi
    cmovp edx, edx

// === CMOVP r32, m32 ===
    cmovp edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovp ebx, DWORD PTR [rip + 0x100]
    cmovp esi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovp ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovp edx, DWORD PTR [rax]
    cmovp edx, DWORD PTR [rbx]
    cmovp eax, DWORD PTR [rbx]
    cmovp ecx, DWORD PTR [rbx]
    cmovp esi, DWORD PTR [rbx]
    cmovp edi, DWORD PTR [rax]

// === CMOVP r64, r64 ===
    cmovp rax, rax
    cmovp r11, rbx
    cmovp rsi, rdx
    cmovp rdi, rcx
    cmovp r11, rsi
    cmovp r11, rdx
    cmovp rax, r9
    cmovp r13, r13
    cmovp rsi, rbx
    cmovp r9, r11

// === CMOVP r64, m64 ===
    cmovp r11, QWORD PTR [rip + 0x1000]
    cmovp r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovp r8, QWORD PTR [rbx]
    cmovp r10, QWORD PTR [rip + 0x100]
    cmovp r9, QWORD PTR [rip + 0x1000]
    cmovp rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovp rbx, QWORD PTR [rip + 0x100]
    cmovp r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmovp rcx, QWORD PTR [rbx]

// === CMOVPE r16, r16 ===
    cmovpe cx, bx
    cmovpe dx, cx
    cmovpe di, dx
    cmovpe ax, ax
    cmovpe bx, bx
    cmovpe bx, ax
    cmovpe cx, ax
    cmovpe cx, dx
    cmovpe dx, ax
    cmovpe bx, cx

// === CMOVPE r16, m16 ===
    cmovpe ax, WORD PTR [rip + 0x1000]
    cmovpe cx, WORD PTR [rip + 0x100]
    cmovpe si, WORD PTR [rip + 0x1000]
    cmovpe ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovpe ax, WORD PTR [rip + 0x100]
    cmovpe di, WORD PTR [rbx]
    cmovpe si, WORD PTR [rax]
    cmovpe cx, WORD PTR [rax]
    cmovpe dx, WORD PTR [rax + rbx*4 + 0x100]
    cmovpe dx, WORD PTR [rax]

// === CMOVPE r32, r32 ===
    cmovpe edi, esi
    cmovpe eax, ebx
    cmovpe ebx, esi
    cmovpe ebx, edx
    cmovpe esi, esi
    cmovpe ecx, ecx
    cmovpe edx, edi
    cmovpe esi, eax
    cmovpe edx, ebx
    cmovpe edx, eax

// === CMOVPE r32, m32 ===
    cmovpe ecx, DWORD PTR [rbx]
    cmovpe edx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpe esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpe ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpe ebx, DWORD PTR [rax]
    cmovpe ebx, DWORD PTR [rbx]
    cmovpe ecx, DWORD PTR [rip + 0x1000]
    cmovpe esi, DWORD PTR [rbx]
    cmovpe ecx, DWORD PTR [rip + 0x100]
    cmovpe esi, DWORD PTR [rax + rbx*4 + 0x100]

// === CMOVPE r64, r64 ===
    cmovpe rdx, r13
    cmovpe rbx, rdx
    cmovpe r9, rdx
    cmovpe r9, rbx
    cmovpe rsi, rdi
    cmovpe rax, rdx
    cmovpe rbx, rbx
    cmovpe r10, rax
    cmovpe r13, rcx
    cmovpe r8, r12

// === CMOVPE r64, m64 ===
    cmovpe r8, QWORD PTR [rip + 0x1000]
    cmovpe r11, QWORD PTR [rax]
    cmovpe rsi, QWORD PTR [rax]
    cmovpe r11, QWORD PTR [rbx]
    cmovpe r12, QWORD PTR [rip + 0x100]
    cmovpe r8, QWORD PTR [rax]
    cmovpe rax, QWORD PTR [rax + rbx*1 + 0x10]
    cmovpe r9, QWORD PTR [rax]
    cmovpe r10, QWORD PTR [rip + 0x100]
    cmovpe r13, QWORD PTR [rax]

// === CMOVPO r16, r16 ===
    cmovpo ax, si
    cmovpo si, bx
    cmovpo di, cx
    cmovpo dx, di
    cmovpo di, si
    cmovpo bx, cx
    cmovpo di, dx
    cmovpo dx, si
    cmovpo si, di
    cmovpo ax, ax

// === CMOVPO r16, m16 ===
    cmovpo bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovpo ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovpo ax, WORD PTR [rbx]
    cmovpo ax, WORD PTR [rip + 0x100]
    cmovpo ax, WORD PTR [rax]
    cmovpo si, WORD PTR [rip + 0x1000]
    cmovpo ax, WORD PTR [rip + 0x1000]
    cmovpo di, WORD PTR [rbx]
    cmovpo di, WORD PTR [rax]
    cmovpo dx, WORD PTR [rip + 0x100]

// === CMOVPO r32, r32 ===
    cmovpo edi, eax
    cmovpo ecx, ecx
    cmovpo edx, eax
    cmovpo esi, ecx
    cmovpo esi, edi
    cmovpo ecx, eax
    cmovpo edx, edx
    cmovpo eax, ecx
    cmovpo edi, esi
    cmovpo edx, esi

// === CMOVPO r32, m32 ===
    cmovpo ebx, DWORD PTR [rax]
    cmovpo eax, DWORD PTR [rbx]
    cmovpo eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpo ecx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpo ecx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovpo edx, DWORD PTR [rbx]
    cmovpo ebx, DWORD PTR [rax + rbx*4 + 0x100]
    cmovpo ecx, DWORD PTR [rip + 0x1000]
    cmovpo edx, DWORD PTR [rip + 0x100]
    cmovpo ecx, DWORD PTR [rax]

// === CMOVPO r64, r64 ===
    cmovpo r9, r13
    cmovpo rsi, rax
    cmovpo rdx, rdx
    cmovpo r9, rsi
    cmovpo rsi, r11
    cmovpo r12, r11
    cmovpo r11, r10
    cmovpo r9, rax
    cmovpo r11, rdx
    cmovpo rdx, r11

// === CMOVPO r64, m64 ===
    cmovpo rbx, QWORD PTR [rip + 0x1000]
    cmovpo rdx, QWORD PTR [rax + rbx*4 + 0x100]
    cmovpo r13, QWORD PTR [rip + 0x100]
    cmovpo rsi, QWORD PTR [rax]
    cmovpo rcx, QWORD PTR [rip + 0x1000]
    cmovpo r8, QWORD PTR [rax + rbx*1 + 0x10]
    cmovpo rbx, QWORD PTR [rax]
    cmovpo r8, QWORD PTR [rax]
    cmovpo rdx, QWORD PTR [rbx]
    cmovpo r8, QWORD PTR [rax + rbx*4 + 0x100]

// === CMOVS r16, r16 ===
    cmovs cx, bx
    cmovs ax, di
    cmovs di, si
    cmovs ax, cx
    cmovs dx, dx
    cmovs bx, ax
    cmovs di, ax
    cmovs ax, ax
    cmovs si, si
    cmovs dx, di

// === CMOVS r16, m16 ===
    cmovs cx, WORD PTR [rax + rbx*1 + 0x10]
    cmovs dx, WORD PTR [rax]
    cmovs bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovs bx, WORD PTR [rax + rbx*4 + 0x100]
    cmovs ax, WORD PTR [rax + rbx*4 + 0x100]
    cmovs cx, WORD PTR [rax]
    cmovs ax, WORD PTR [rax + rbx*1 + 0x10]
    cmovs dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovs si, WORD PTR [rax + rbx*4 + 0x100]
    cmovs dx, WORD PTR [rip + 0x100]

// === CMOVS r32, r32 ===
    cmovs ecx, esi
    cmovs edx, edi
    cmovs edi, esi
    cmovs esi, esi
    cmovs eax, edx
    cmovs eax, edi
    cmovs ebx, edx
    cmovs eax, eax
    cmovs edx, eax
    cmovs edx, ebx

// === CMOVS r32, m32 ===
    cmovs edi, DWORD PTR [rax + rbx*4 + 0x100]
    cmovs ecx, DWORD PTR [rip + 0x100]
    cmovs ebx, DWORD PTR [rbx]
    cmovs eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovs esi, DWORD PTR [rax]
    cmovs eax, DWORD PTR [rax]
    cmovs edx, DWORD PTR [rax]
    cmovs esi, DWORD PTR [rip + 0x1000]
    cmovs eax, DWORD PTR [rax + rbx*1 + 0x10]
    cmovs ebx, DWORD PTR [rax]

// === CMOVS r64, r64 ===
    cmovs rsi, rsi
    cmovs rsi, rbx
    cmovs rdi, rdi
    cmovs r11, r8
    cmovs r9, rsi
    cmovs rdx, rdx
    cmovs rdx, r12
    cmovs r12, r10
    cmovs rsi, r12
    cmovs r11, r13

// === CMOVS r64, m64 ===
    cmovs r8, QWORD PTR [rip + 0x1000]
    cmovs rdi, QWORD PTR [rax + rbx*1 + 0x10]
    cmovs rcx, QWORD PTR [rbx]
    cmovs r11, QWORD PTR [rax]
    cmovs r9, QWORD PTR [rip + 0x1000]
    cmovs rax, QWORD PTR [rbx]
    cmovs r13, QWORD PTR [rbx]
    cmovs rdi, QWORD PTR [rbx]
    cmovs rax, QWORD PTR [rax]
    cmovs rsi, QWORD PTR [rip + 0x100]

// === CMOVZ r16, r16 ===
    cmovz di, si
    cmovz si, bx
    cmovz dx, di
    cmovz dx, cx
    cmovz bx, di
    cmovz ax, di
    cmovz si, dx
    cmovz di, dx
    cmovz bx, ax
    cmovz dx, bx

// === CMOVZ r16, m16 ===
    cmovz si, WORD PTR [rax + rbx*1 + 0x10]
    cmovz dx, WORD PTR [rip + 0x1000]
    cmovz bx, WORD PTR [rax + rbx*1 + 0x10]
    cmovz si, WORD PTR [rax + rbx*4 + 0x100]
    cmovz di, WORD PTR [rip + 0x1000]
    cmovz bx, WORD PTR [rbx]
    cmovz di, WORD PTR [rip + 0x100]
    cmovz cx, WORD PTR [rip + 0x100]
    cmovz dx, WORD PTR [rax + rbx*1 + 0x10]
    cmovz di, WORD PTR [rbx]

// === CMOVZ r32, r32 ===
    cmovz esi, ebx
    cmovz edx, edi
    cmovz edx, esi
    cmovz eax, ecx
    cmovz edi, eax
    cmovz ebx, ecx
    cmovz eax, edx
    cmovz esi, edx
    cmovz edx, eax
    cmovz ecx, ecx

// === CMOVZ r32, m32 ===
    cmovz esi, DWORD PTR [rip + 0x1000]
    cmovz eax, DWORD PTR [rax + rbx*4 + 0x100]
    cmovz ebx, DWORD PTR [rax + rbx*1 + 0x10]
    cmovz edx, DWORD PTR [rip + 0x100]
    cmovz ebx, DWORD PTR [rax]
    cmovz edi, DWORD PTR [rax]
    cmovz edx, DWORD PTR [rbx]
    cmovz ecx, DWORD PTR [rax]
    cmovz edx, DWORD PTR [rip + 0x1000]
    cmovz esi, DWORD PTR [rip + 0x100]

// === CMOVZ r64, r64 ===
    cmovz r11, rdx
    cmovz rdi, rsi
    cmovz r8, rsi
    cmovz r8, rdx
    cmovz r11, r10
    cmovz r13, r11
    cmovz r9, rax
    cmovz rbx, rsi
    cmovz r12, r12
    cmovz r12, rdi

// === CMOVZ r64, m64 ===
    cmovz rdi, QWORD PTR [rax + rbx*4 + 0x100]
    cmovz rax, QWORD PTR [rbx]
    cmovz r11, QWORD PTR [rip + 0x1000]
    cmovz rdx, QWORD PTR [rax + rbx*1 + 0x10]
    cmovz r12, QWORD PTR [rbx]
    cmovz r9, QWORD PTR [rip + 0x1000]
    cmovz rbx, QWORD PTR [rip + 0x1000]
    cmovz r10, QWORD PTR [rax + rbx*4 + 0x100]
    cmovz r8, QWORD PTR [rip + 0x1000]
    cmovz r11, QWORD PTR [rbx]

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
    cmp al, 0xff
    cmp dl, 0xff

// === CMP m8, imm8 ===
    cmp BYTE PTR [rip + 0x1000], 0xff
    cmp BYTE PTR [rip + 0x100], 0xff
    cmp BYTE PTR [rax + rbx*1 + 0x10], 0xff
    cmp BYTE PTR [rax + rbx*4 + 0x100], 0xff
    cmp BYTE PTR [rbx], 0xff
    cmp BYTE PTR [rax], 0xff

// === CMP r16, imm16 ===
    cmp dx, 0xffff
    cmp di, 0xffff
    cmp si, 0xffff
    cmp bx, 0xffff
    cmp cx, 0xffff
    cmp ax, 0xffff

// === CMP m16, imm16 ===
    cmp WORD PTR [rip + 0x100], 0xffff
    cmp WORD PTR [rax + rbx*4 + 0x100], 0xffff
    cmp WORD PTR [rax], 0xffff
    cmp WORD PTR [rax + rbx*1 + 0x10], 0xffff
    cmp WORD PTR [rbx], 0xffff
    cmp WORD PTR [rip + 0x1000], 0xffff

// === CMP r32, imm32 ===
    cmp edi, 0xffffffff
    cmp eax, 0xffffffff
    cmp esi, 0xffffffff
    cmp ecx, 0xffffffff
    cmp ebx, 0xffffffff
    cmp edx, 0xffffffff

// === CMP m32, imm32 ===
    cmp DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    cmp DWORD PTR [rax], 0xffffffff
    cmp DWORD PTR [rip + 0x1000], 0xffffffff
    cmp DWORD PTR [rip + 0x100], 0xffffffff
    cmp DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    cmp DWORD PTR [rbx], 0xffffffff

// === CMP r64, imm32 ===
    cmp rbx, 0x7fffffff
    cmp rdi, 0x7fffffff
    cmp rcx, 0x7fffffff
    cmp rcx, -1
    cmp rsi, 0x7fffffff
    cmp rax, 0x7fffffff
    cmp r12, 0x7fffffff
    cmp r13, 0x7fffffff
    cmp r11, -1
    cmp rdx, -1

// === CMP m64, imm32 ===
    cmp QWORD PTR [rip + 0x100], 0x7fffffff
    cmp QWORD PTR [rbx], 0x7fffffff
    cmp QWORD PTR [rip + 0x1000], 0x7fffffff
    cmp QWORD PTR [rip + 0x100], -1
    cmp QWORD PTR [rax + rbx*1 + 0x10], -1
    cmp QWORD PTR [rax + rbx*4 + 0x100], -1
    cmp QWORD PTR [rbx], -1
    cmp QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    cmp QWORD PTR [rax], -1
    cmp QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff

// === CMP r16, imm8 ===
    cmp di, 0xff
    cmp dx, 0xff
    cmp si, 0xff
    cmp cx, 0xff
    cmp bx, 0xff
    cmp ax, 0xff

// === CMP m16, imm8 ===
    cmp WORD PTR [rax], 0xff
    cmp WORD PTR [rax + rbx*4 + 0x100], 0xff
    cmp WORD PTR [rax + rbx*1 + 0x10], 0xff
    cmp WORD PTR [rip + 0x100], 0xff
    cmp WORD PTR [rbx], 0xff
    cmp WORD PTR [rip + 0x1000], 0xff

// === CMP r32, imm8 ===
    cmp eax, 0xff
    cmp ecx, 0xff
    cmp edx, 0xff
    cmp edi, 0xff
    cmp ebx, 0xff
    cmp esi, 0xff

// === CMP m32, imm8 ===
    cmp DWORD PTR [rax], 0xff
    cmp DWORD PTR [rax + rbx*4 + 0x100], 0xff
    cmp DWORD PTR [rax + rbx*1 + 0x10], 0xff
    cmp DWORD PTR [rip + 0x1000], 0xff
    cmp DWORD PTR [rbx], 0xff
    cmp DWORD PTR [rip + 0x100], 0xff

// === CMP r64, imm8 ===
    cmp rsi, 0xff
    cmp rcx, 0xff
    cmp rbx, 0xff
    cmp rdi, 0xff
    cmp r10, 0xff
    cmp r9, 0xff
    cmp rax, 0xff
    cmp rdx, 0xff
    cmp r12, 0xff
    cmp r13, 0xff

// === CMP m64, imm8 ===
    cmp QWORD PTR [rbx], 0xff
    cmp QWORD PTR [rax], 0xff
    cmp QWORD PTR [rax + rbx*1 + 0x10], 0xff
    cmp QWORD PTR [rip + 0x1000], 0xff
    cmp QWORD PTR [rax + rbx*4 + 0x100], 0xff
    cmp QWORD PTR [rip + 0x100], 0xff

// === CMP r8, r8 ===
    cmp bl, al
    cmp cl, cl
    cmp cl, al
    cmp dl, bl
    cmp dl, al
    cmp bl, dl
    cmp al, bl
    cmp al, dl
    cmp cl, dl
    cmp al, cl

// === CMP m8, r8 ===
    cmp BYTE PTR [rax], al
    cmp BYTE PTR [rax + rbx*4 + 0x100], bl
    cmp BYTE PTR [rax + rbx*4 + 0x100], dl
    cmp BYTE PTR [rip + 0x100], bl
    cmp BYTE PTR [rax + rbx*1 + 0x10], dl
    cmp BYTE PTR [rip + 0x1000], dl
    cmp BYTE PTR [rax], dl
    cmp BYTE PTR [rip + 0x100], al
    cmp BYTE PTR [rbx], cl
    cmp BYTE PTR [rip + 0x100], dl

// === CMP r16, r16 ===
    cmp di, dx
    cmp bx, dx
    cmp bx, si
    cmp dx, cx
    cmp ax, si
    cmp ax, cx
    cmp di, bx
    cmp bx, di
    cmp si, cx
    cmp di, cx

// === CMP m16, r16 ===
    cmp WORD PTR [rax], di
    cmp WORD PTR [rip + 0x1000], cx
    cmp WORD PTR [rax + rbx*4 + 0x100], bx
    cmp WORD PTR [rax], dx
    cmp WORD PTR [rax + rbx*4 + 0x100], cx
    cmp WORD PTR [rip + 0x1000], bx
    cmp WORD PTR [rax + rbx*1 + 0x10], si
    cmp WORD PTR [rbx], si
    cmp WORD PTR [rax + rbx*1 + 0x10], ax
    cmp WORD PTR [rax + rbx*4 + 0x100], di

// === CMP r32, r32 ===
    cmp edx, edx
    cmp ecx, eax
    cmp edx, esi
    cmp edi, esi
    cmp edi, edi
    cmp esi, edi
    cmp edi, ecx
    cmp esi, ecx
    cmp edx, ecx
    cmp esi, eax

// === CMP m32, r32 ===
    cmp DWORD PTR [rax], eax
    cmp DWORD PTR [rax + rbx*4 + 0x100], edi
    cmp DWORD PTR [rax + rbx*4 + 0x100], edx
    cmp DWORD PTR [rip + 0x1000], ebx
    cmp DWORD PTR [rax + rbx*4 + 0x100], ecx
    cmp DWORD PTR [rax], esi
    cmp DWORD PTR [rax + rbx*4 + 0x100], esi
    cmp DWORD PTR [rbx], edi
    cmp DWORD PTR [rip + 0x100], edx
    cmp DWORD PTR [rip + 0x100], esi

// === CMP r64,r64 ===
    cmp rdi, rdx
    cmp r9, r9
    cmp rax, rbx
    cmp rcx, rsi
    cmp r11, rdx
    cmp rbx, r8
    cmp r13, rsi
    cmp rdi, r12
    cmp r12, r11
    cmp r10, rcx

// === CMP m64,r64 ===
    cmp QWORD PTR [rax + rbx*1 + 0x10], rdx
    cmp QWORD PTR [rax + rbx*4 + 0x100], r10
    cmp QWORD PTR [rax], rsi
    cmp QWORD PTR [rax + rbx*4 + 0x100], rax
    cmp QWORD PTR [rax + rbx*1 + 0x10], rax
    cmp QWORD PTR [rax + rbx*4 + 0x100], r12
    cmp QWORD PTR [rip + 0x100], rdx
    cmp QWORD PTR [rax + rbx*4 + 0x100], rdi
    cmp QWORD PTR [rax], r10
    cmp QWORD PTR [rax + rbx*4 + 0x100], r11

// === CMP r8, m8 ===
    cmp cl, BYTE PTR [rax + rbx*4 + 0x100]
    cmp cl, BYTE PTR [rax]
    cmp cl, BYTE PTR [rip + 0x1000]
    cmp cl, BYTE PTR [rax + rbx*1 + 0x10]
    cmp bl, BYTE PTR [rax]
    cmp bl, BYTE PTR [rax + rbx*4 + 0x100]
    cmp cl, BYTE PTR [rbx]
    cmp al, BYTE PTR [rax]
    cmp dl, BYTE PTR [rax + rbx*4 + 0x100]
    cmp dl, BYTE PTR [rip + 0x100]

// === CMP r16, m16 ===
    cmp ax, WORD PTR [rax + rbx*1 + 0x10]
    cmp bx, WORD PTR [rbx]
    cmp di, WORD PTR [rax + rbx*1 + 0x10]
    cmp bx, WORD PTR [rax + rbx*1 + 0x10]
    cmp dx, WORD PTR [rax + rbx*4 + 0x100]
    cmp ax, WORD PTR [rax]
    cmp si, WORD PTR [rip + 0x100]
    cmp di, WORD PTR [rax]
    cmp cx, WORD PTR [rax + rbx*4 + 0x100]
    cmp si, WORD PTR [rbx]

// === CMP r32, m32 ===
    cmp edx, DWORD PTR [rip + 0x1000]
    cmp esi, DWORD PTR [rax]
    cmp edi, DWORD PTR [rbx]
    cmp eax, DWORD PTR [rbx]
    cmp ecx, DWORD PTR [rax]
    cmp ebx, DWORD PTR [rip + 0x1000]
    cmp edx, DWORD PTR [rax + rbx*1 + 0x10]
    cmp ebx, DWORD PTR [rip + 0x100]
    cmp esi, DWORD PTR [rax + rbx*1 + 0x10]
    cmp esi, DWORD PTR [rip + 0x1000]

// === CMP r64, m64 ===
    cmp r11, QWORD PTR [rax + rbx*4 + 0x100]
    cmp r13, QWORD PTR [rax + rbx*4 + 0x100]
    cmp rax, QWORD PTR [rip + 0x1000]
    cmp r9, QWORD PTR [rax]
    cmp r8, QWORD PTR [rax]
    cmp rax, QWORD PTR [rax + rbx*4 + 0x100]
    cmp rsi, QWORD PTR [rax + rbx*4 + 0x100]
    cmp rbx, QWORD PTR [rax + rbx*1 + 0x10]
    cmp rdx, QWORD PTR [rbx]
    cmp rax, QWORD PTR [rax + rbx*1 + 0x10]

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
    cmpxchg cl, dl
    cmpxchg al, al
    cmpxchg dl, al
    cmpxchg al, bl
    cmpxchg bl, al
    cmpxchg cl, al
    cmpxchg bl, dl
    cmpxchg dl, bl

// === CMPXCHG m8, r8 ===
    cmpxchg BYTE PTR [rax + rbx*1 + 0x10], cl
    cmpxchg BYTE PTR [rax + rbx*4 + 0x100], dl
    cmpxchg BYTE PTR [rip + 0x1000], cl
    cmpxchg BYTE PTR [rbx], bl
    cmpxchg BYTE PTR [rax], dl
    cmpxchg BYTE PTR [rip + 0x1000], al
    cmpxchg BYTE PTR [rax + rbx*4 + 0x100], bl
    cmpxchg BYTE PTR [rip + 0x100], al
    cmpxchg BYTE PTR [rax + rbx*1 + 0x10], dl
    cmpxchg BYTE PTR [rip + 0x1000], bl

// === CMPXCHG r16, r16 ===
    cmpxchg ax, di
    cmpxchg cx, cx
    cmpxchg dx, di
    cmpxchg dx, ax
    cmpxchg dx, dx
    cmpxchg si, si
    cmpxchg cx, ax
    cmpxchg si, bx
    cmpxchg bx, dx
    cmpxchg cx, dx

// === CMPXCHG m16, r16 ===
    cmpxchg WORD PTR [rip + 0x1000], ax
    cmpxchg WORD PTR [rax + rbx*1 + 0x10], si
    cmpxchg WORD PTR [rax + rbx*1 + 0x10], cx
    cmpxchg WORD PTR [rax], di
    cmpxchg WORD PTR [rax + rbx*4 + 0x100], ax
    cmpxchg WORD PTR [rax], bx
    cmpxchg WORD PTR [rbx], si
    cmpxchg WORD PTR [rax + rbx*1 + 0x10], dx
    cmpxchg WORD PTR [rbx], bx
    cmpxchg WORD PTR [rbx], cx

// === CMPXCHG r32, r32 ===
    cmpxchg ecx, eax
    cmpxchg esi, ebx
    cmpxchg ecx, edx
    cmpxchg esi, edx
    cmpxchg eax, esi
    cmpxchg ebx, eax
    cmpxchg ebx, edi
    cmpxchg edi, edx
    cmpxchg edi, ecx
    cmpxchg esi, edi

// === CMPXCHG m32, r32 ===
    cmpxchg DWORD PTR [rax + rbx*4 + 0x100], esi
    cmpxchg DWORD PTR [rax + rbx*1 + 0x10], esi
    cmpxchg DWORD PTR [rip + 0x100], edi
    cmpxchg DWORD PTR [rip + 0x100], edx
    cmpxchg DWORD PTR [rip + 0x1000], ebx
    cmpxchg DWORD PTR [rax], esi
    cmpxchg DWORD PTR [rax + rbx*4 + 0x100], ebx
    cmpxchg DWORD PTR [rax], ecx
    cmpxchg DWORD PTR [rbx], edx
    cmpxchg DWORD PTR [rip + 0x1000], eax

// === CMPXCHG r64, r64 ===
    cmpxchg rsi, r13
    cmpxchg rdx, r8
    cmpxchg r11, rcx
    cmpxchg rcx, rdi
    cmpxchg r11, r13
    cmpxchg rbx, r8
    cmpxchg rsi, rcx
    cmpxchg rdx, rax
    cmpxchg rbx, rcx
    cmpxchg r9, rsi

// === CMPXCHG m64, r64 ===
    cmpxchg QWORD PTR [rax + rbx*4 + 0x100], r11
    cmpxchg QWORD PTR [rip + 0x1000], rax
    cmpxchg QWORD PTR [rax], r9
    cmpxchg QWORD PTR [rax + rbx*4 + 0x100], rdx
    cmpxchg QWORD PTR [rax], r11
    cmpxchg QWORD PTR [rip + 0x100], r8
    cmpxchg QWORD PTR [rbx], r9
    cmpxchg QWORD PTR [rip + 0x1000], r12
    cmpxchg QWORD PTR [rax], r10
    cmpxchg QWORD PTR [rax + rbx*1 + 0x10], r12

// === CRC32 r32, r8 ===
    crc32 ecx, cl
    crc32 edx, al
    crc32 edx, cl
    crc32 ebx, cl
    crc32 eax, bl
    crc32 ebx, dl
    crc32 edx, bl
    crc32 ecx, bl
    crc32 esi, dl
    crc32 eax, al

// === CRC32 r32, m8 ===
    crc32 ecx, BYTE PTR [rax]
    crc32 edi, BYTE PTR [rax]
    crc32 ebx, BYTE PTR [rip + 0x1000]
    crc32 ebx, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 ebx, BYTE PTR [rax]
    crc32 ebx, BYTE PTR [rbx]
    crc32 ecx, BYTE PTR [rip + 0x100]
    crc32 edx, BYTE PTR [rax + rbx*1 + 0x10]
    crc32 edi, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 ecx, BYTE PTR [rbx]

// === CRC32 r32, r16 ===
    crc32 edi, di
    crc32 ebx, cx
    crc32 edx, ax
    crc32 eax, si
    crc32 esi, di
    crc32 ebx, ax
    crc32 ebx, si
    crc32 eax, di
    crc32 edx, di
    crc32 esi, cx

// === CRC32 r32, m16 ===
    crc32 esi, WORD PTR [rip + 0x1000]
    crc32 edx, WORD PTR [rbx]
    crc32 edi, WORD PTR [rax]
    crc32 esi, WORD PTR [rax + rbx*1 + 0x10]
    crc32 ebx, WORD PTR [rip + 0x1000]
    crc32 eax, WORD PTR [rip + 0x1000]
    crc32 ebx, WORD PTR [rip + 0x100]
    crc32 eax, WORD PTR [rax + rbx*4 + 0x100]
    crc32 edx, WORD PTR [rip + 0x100]
    crc32 eax, WORD PTR [rbx]

// === CRC32 r32, r32 ===
    crc32 edi, edx
    crc32 edx, edx
    crc32 edx, ebx
    crc32 edx, edi
    crc32 edi, esi
    crc32 ecx, edx
    crc32 ebx, esi
    crc32 eax, edi
    crc32 ebx, ebx
    crc32 edx, ecx

// === CRC32 r32, m32 ===
    crc32 esi, DWORD PTR [rip + 0x100]
    crc32 ecx, DWORD PTR [rax + rbx*1 + 0x10]
    crc32 eax, DWORD PTR [rbx]
    crc32 ebx, DWORD PTR [rip + 0x1000]
    crc32 edx, DWORD PTR [rip + 0x100]
    crc32 eax, DWORD PTR [rip + 0x1000]
    crc32 edi, DWORD PTR [rip + 0x100]
    crc32 ecx, DWORD PTR [rax]
    crc32 ebx, DWORD PTR [rax + rbx*4 + 0x100]
    crc32 ecx, DWORD PTR [rbx]

// === CRC32 r64, r8 ===
    crc32 rdi, cl
    crc32 r12, al
    crc32 r12, cl
    crc32 rcx, dl
    crc32 r13, dl
    crc32 rcx, bl
    crc32 r8, bl
    crc32 rbx, dl
    crc32 rax, cl
    crc32 rax, dl

// === CRC32 r64, m8 ===
    crc32 r8, BYTE PTR [rip + 0x100]
    crc32 r9, BYTE PTR [rip + 0x100]
    crc32 rax, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 rbx, BYTE PTR [rbx]
    crc32 r13, BYTE PTR [rax + rbx*4 + 0x100]
    crc32 rdi, BYTE PTR [rbx]
    crc32 rsi, BYTE PTR [rip + 0x100]
    crc32 r11, BYTE PTR [rax]
    crc32 r10, BYTE PTR [rax + rbx*1 + 0x10]
    crc32 rcx, BYTE PTR [rip + 0x1000]

// === CRC32 r64, r64 ===
    crc32 r11, r10
    crc32 rdx, r10
    crc32 r10, rcx
    crc32 rax, r13
    crc32 rbx, rdi
    crc32 rbx, rsi
    crc32 r11, r9
    crc32 r9, r9
    crc32 r8, rsi
    crc32 r11, rbx

// === CRC32 r64, m64 ===
    crc32 rdx, QWORD PTR [rax + rbx*4 + 0x100]
    crc32 r13, QWORD PTR [rax]
    crc32 r8, QWORD PTR [rax + rbx*1 + 0x10]
    crc32 r9, QWORD PTR [rax + rbx*4 + 0x100]
    crc32 rdi, QWORD PTR [rbx]
    crc32 r10, QWORD PTR [rbx]
    crc32 rcx, QWORD PTR [rip + 0x1000]
    crc32 r8, QWORD PTR [rax]
    crc32 r11, QWORD PTR [rip + 0x1000]
    crc32 rdi, QWORD PTR [rip + 0x1000]

// === CWD ===
    cwd

// === CDQ ===
    cdq

// === CQO ===
    cqo

// === DEC r8 ===
    dec dl
    dec al
    dec cl
    dec bl

// === DEC m8 ===
    dec BYTE PTR [rip + 0x1000]
    dec BYTE PTR [rip + 0x100]
    dec BYTE PTR [rax + rbx*1 + 0x10]
    dec BYTE PTR [rax]
    dec BYTE PTR [rbx]
    dec BYTE PTR [rax + rbx*4 + 0x100]

// === DEC r16 ===
    dec dx
    dec cx
    dec si
    dec ax
    dec bx
    dec di

// === DEC m16 ===
    dec WORD PTR [rbx]
    dec WORD PTR [rip + 0x100]
    dec WORD PTR [rip + 0x1000]
    dec WORD PTR [rax + rbx*1 + 0x10]
    dec WORD PTR [rax + rbx*4 + 0x100]
    dec WORD PTR [rax]

// === DEC r32 ===
    dec esi
    dec edi
    dec ebx
    dec ecx
    dec eax
    dec edx

// === DEC m32 ===
    dec DWORD PTR [rbx]
    dec DWORD PTR [rax + rbx*1 + 0x10]
    dec DWORD PTR [rip + 0x100]
    dec DWORD PTR [rip + 0x1000]
    dec DWORD PTR [rax]
    dec DWORD PTR [rax + rbx*4 + 0x100]

// === DEC r64 ===
    dec r13
    dec rcx
    dec r10
    dec rbx
    dec r11
    dec r9
    dec r12
    dec rdi
    dec rsi
    dec r8

// === DEC m64 ===
    dec QWORD PTR [rax]
    dec QWORD PTR [rip + 0x1000]
    dec QWORD PTR [rip + 0x100]
    dec QWORD PTR [rax + rbx*1 + 0x10]
    dec QWORD PTR [rbx]
    dec QWORD PTR [rax + rbx*4 + 0x100]

// === DIV r8 ===
    div al
    div bl
    div cl
    div dl

// === DIV m8 ===
    div BYTE PTR [rax + rbx*1 + 0x10]
    div BYTE PTR [rip + 0x1000]
    div BYTE PTR [rip + 0x100]
    div BYTE PTR [rax]
    div BYTE PTR [rbx]
    div BYTE PTR [rax + rbx*4 + 0x100]

// === DIV r16 ===
    div dx
    div si
    div bx
    div cx
    div di
    div ax

// === DIV m16 ===
    div WORD PTR [rax + rbx*1 + 0x10]
    div WORD PTR [rip + 0x1000]
    div WORD PTR [rip + 0x100]
    div WORD PTR [rax + rbx*4 + 0x100]
    div WORD PTR [rax]
    div WORD PTR [rbx]

// === DIV r32 ===
    div ebx
    div edx
    div ecx
    div edi
    div esi
    div eax

// === DIV m32 ===
    div DWORD PTR [rbx]
    div DWORD PTR [rip + 0x100]
    div DWORD PTR [rax + rbx*1 + 0x10]
    div DWORD PTR [rip + 0x1000]
    div DWORD PTR [rax + rbx*4 + 0x100]
    div DWORD PTR [rax]

// === DIV r64 ===
    div r9
    div r10
    div r13
    div r8
    div rdx
    div r12
    div rsi
    div rdi
    div r11
    div rcx

// === DIV m64 ===
    div QWORD PTR [rbx]
    div QWORD PTR [rip + 0x1000]
    div QWORD PTR [rax + rbx*4 + 0x100]
    div QWORD PTR [rip + 0x100]
    div QWORD PTR [rax]
    div QWORD PTR [rax + rbx*1 + 0x10]

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
    fadd DWORD PTR [rbx]
    fadd DWORD PTR [rax + rbx*4 + 0x100]
    fadd DWORD PTR [rip + 0x1000]
    fadd DWORD PTR [rax]
    fadd DWORD PTR [rip + 0x100]
    fadd DWORD PTR [rax + rbx*1 + 0x10]

// === FADD m64fp ===
    fadd QWORD PTR [rip + 0x100]
    fadd QWORD PTR [rax]
    fadd QWORD PTR [rax + rbx*1 + 0x10]
    fadd QWORD PTR [rip + 0x1000]
    fadd QWORD PTR [rbx]
    fadd QWORD PTR [rax + rbx*4 + 0x100]

// === FADD ST(0), ST(i) ===
    fadd st(0), st(0)
    fadd st(0), st(1)
    fadd st(0), st(3)
    fadd st(0), st(2)

// === FADD ST(i), ST(0) ===
    fadd st(2), st(0)
    fadd st(3), st(0)
    fadd st(0), st(0)
    fadd st(1), st(0)

// === FADDP ST(i), ST(0) ===
    faddp st(1), st(0)
    faddp st(0), st(0)
    faddp st(2), st(0)
    faddp st(3), st(0)

// === FADDP ===
    faddp

// === FIADD m32int ===
    fiadd DWORD PTR [rip + 0x100]
    fiadd DWORD PTR [rax]
    fiadd DWORD PTR [rax + rbx*4 + 0x100]
    fiadd DWORD PTR [rax + rbx*1 + 0x10]
    fiadd DWORD PTR [rip + 0x1000]
    fiadd DWORD PTR [rbx]

// === FIADD m16int ===
    fiadd WORD PTR [rbx]
    fiadd WORD PTR [rip + 0x1000]
    fiadd WORD PTR [rax + rbx*1 + 0x10]
    fiadd WORD PTR [rax]
    fiadd WORD PTR [rip + 0x100]
    fiadd WORD PTR [rax + rbx*4 + 0x100]

// === FCHS ===
    fchs

// === FCLEX ===
    fclex

// === FNCLEX ===
    fnclex

// === FCMOVB ST(0), ST(i) ===
    fcmovb st(0), st(2)
    fcmovb st(0), st(1)
    fcmovb st(0), st(3)
    fcmovb st(0), st(0)

// === FCMOVE ST(0), ST(i) ===
    fcmove st(0), st(1)
    fcmove st(0), st(2)
    fcmove st(0), st(3)
    fcmove st(0), st(0)

// === FCMOVBE ST(0), ST(i) ===
    fcmovbe st(0), st(1)
    fcmovbe st(0), st(2)
    fcmovbe st(0), st(3)
    fcmovbe st(0), st(0)

// === FCMOVU ST(0), ST(i) ===
    fcmovu st(0), st(3)
    fcmovu st(0), st(1)
    fcmovu st(0), st(2)
    fcmovu st(0), st(0)

// === FCMOVNB ST(0), ST(i) ===
    fcmovnb st(0), st(2)
    fcmovnb st(0), st(1)
    fcmovnb st(0), st(3)
    fcmovnb st(0), st(0)

// === FCMOVNE ST(0), ST(i) ===
    fcmovne st(0), st(1)
    fcmovne st(0), st(2)
    fcmovne st(0), st(3)
    fcmovne st(0), st(0)

// === FCMOVNBE ST(0), ST(i) ===
    fcmovnbe st(0), st(3)
    fcmovnbe st(0), st(0)
    fcmovnbe st(0), st(2)
    fcmovnbe st(0), st(1)

// === FCMOVNU ST(0), ST(i) ===
    fcmovnu st(0), st(3)
    fcmovnu st(0), st(2)
    fcmovnu st(0), st(0)
    fcmovnu st(0), st(1)

// === FCOM m32fp ===
    fcom DWORD PTR [rip + 0x100]
    fcom DWORD PTR [rax + rbx*4 + 0x100]
    fcom DWORD PTR [rip + 0x1000]
    fcom DWORD PTR [rax]
    fcom DWORD PTR [rax + rbx*1 + 0x10]
    fcom DWORD PTR [rbx]

// === FCOM m64fp ===
    fcom QWORD PTR [rip + 0x1000]
    fcom QWORD PTR [rax + rbx*1 + 0x10]
    fcom QWORD PTR [rax]
    fcom QWORD PTR [rax + rbx*4 + 0x100]
    fcom QWORD PTR [rbx]
    fcom QWORD PTR [rip + 0x100]

// === FCOM ST(i) ===
    fcom st(0)
    fcom st(1)
    fcom st(2)
    fcom st(3)

// === FCOM ===
    fcom

// === FCOMP m32fp ===
    fcomp DWORD PTR [rax + rbx*1 + 0x10]
    fcomp DWORD PTR [rip + 0x100]
    fcomp DWORD PTR [rax]
    fcomp DWORD PTR [rbx]
    fcomp DWORD PTR [rip + 0x1000]
    fcomp DWORD PTR [rax + rbx*4 + 0x100]

// === FCOMP m64fp ===
    fcomp QWORD PTR [rax]
    fcomp QWORD PTR [rbx]
    fcomp QWORD PTR [rax + rbx*4 + 0x100]
    fcomp QWORD PTR [rax + rbx*1 + 0x10]
    fcomp QWORD PTR [rip + 0x100]
    fcomp QWORD PTR [rip + 0x1000]

// === FCOMP ST(i) ===
    fcomp st(2)
    fcomp st(1)
    fcomp st(3)
    fcomp st(0)

// === FCOMP ===
    fcomp

// === FCOMPP ===
    fcompp

// === FCOMI ST, ST(i) ===
    fcomi st(0), st(2)
    fcomi st(0), st(1)
    fcomi st(0), st(3)
    fcomi st(0), st(0)

// === FCOMIP ST, ST(i) ===
    fcomip st(0), st(1)
    fcomip st(0), st(0)
    fcomip st(0), st(2)
    fcomip st(0), st(3)

// === FUCOMI ST, ST(i) ===
    fucomi st(0), st(2)
    fucomi st(0), st(1)
    fucomi st(0), st(3)
    fucomi st(0), st(0)

// === FUCOMIP ST, ST(i) ===
    fucomip st(0), st(2)
    fucomip st(0), st(1)
    fucomip st(0), st(3)
    fucomip st(0), st(0)

// === FCOS ===
    fcos

// === FDECSTP ===
    fdecstp

// === FDIV m32fp ===
    fdiv DWORD PTR [rip + 0x1000]
    fdiv DWORD PTR [rax + rbx*1 + 0x10]
    fdiv DWORD PTR [rbx]
    fdiv DWORD PTR [rip + 0x100]
    fdiv DWORD PTR [rax]
    fdiv DWORD PTR [rax + rbx*4 + 0x100]

// === FDIV m64fp ===
    fdiv QWORD PTR [rip + 0x1000]
    fdiv QWORD PTR [rbx]
    fdiv QWORD PTR [rip + 0x100]
    fdiv QWORD PTR [rax]
    fdiv QWORD PTR [rax + rbx*1 + 0x10]
    fdiv QWORD PTR [rax + rbx*4 + 0x100]

// === FDIV ST(0), ST(i) ===
    fdiv st(0), st(2)
    fdiv st(0), st(0)
    fdiv st(0), st(1)
    fdiv st(0), st(3)

// === FDIV ST(i), ST(0) ===
    fdiv st(1), st(0)
    fdiv st(2), st(0)
    fdiv st(3), st(0)
    fdiv st(0), st(0)

// === FDIVP ST(i), ST(0) ===
    fdivp st(0), st(0)
    fdivp st(1), st(0)
    fdivp st(3), st(0)
    fdivp st(2), st(0)

// === FDIVP ===
    fdivp

// === FIDIV m32int ===
    fidiv DWORD PTR [rax + rbx*4 + 0x100]
    fidiv DWORD PTR [rbx]
    fidiv DWORD PTR [rip + 0x100]
    fidiv DWORD PTR [rax]
    fidiv DWORD PTR [rip + 0x1000]
    fidiv DWORD PTR [rax + rbx*1 + 0x10]

// === FIDIV m16int ===
    fidiv WORD PTR [rip + 0x100]
    fidiv WORD PTR [rax]
    fidiv WORD PTR [rip + 0x1000]
    fidiv WORD PTR [rax + rbx*1 + 0x10]
    fidiv WORD PTR [rbx]
    fidiv WORD PTR [rax + rbx*4 + 0x100]

// === FDIVR m32fp ===
    fdivr DWORD PTR [rip + 0x1000]
    fdivr DWORD PTR [rbx]
    fdivr DWORD PTR [rax]
    fdivr DWORD PTR [rax + rbx*1 + 0x10]
    fdivr DWORD PTR [rip + 0x100]
    fdivr DWORD PTR [rax + rbx*4 + 0x100]

// === FDIVR m64fp ===
    fdivr QWORD PTR [rax + rbx*1 + 0x10]
    fdivr QWORD PTR [rip + 0x1000]
    fdivr QWORD PTR [rbx]
    fdivr QWORD PTR [rax]
    fdivr QWORD PTR [rax + rbx*4 + 0x100]
    fdivr QWORD PTR [rip + 0x100]

// === FDIVR ST(0), ST(i) ===
    fdivr st(0), st(2)
    fdivr st(0), st(0)
    fdivr st(0), st(3)
    fdivr st(0), st(1)

// === FDIVR ST(i), ST(0) ===
    fdivr st(2), st(0)
    fdivr st(3), st(0)
    fdivr st(0), st(0)
    fdivr st(1), st(0)

// === FDIVRP ST(i), ST(0) ===
    fdivrp st(3), st(0)
    fdivrp st(2), st(0)
    fdivrp st(1), st(0)
    fdivrp st(0), st(0)

// === FDIVRP ===
    fdivrp

// === FIDIVR m32int ===
    fidivr DWORD PTR [rax + rbx*1 + 0x10]
    fidivr DWORD PTR [rax]
    fidivr DWORD PTR [rbx]
    fidivr DWORD PTR [rip + 0x1000]
    fidivr DWORD PTR [rip + 0x100]
    fidivr DWORD PTR [rax + rbx*4 + 0x100]

// === FIDIVR m16int ===
    fidivr WORD PTR [rip + 0x1000]
    fidivr WORD PTR [rbx]
    fidivr WORD PTR [rax + rbx*1 + 0x10]
    fidivr WORD PTR [rax + rbx*4 + 0x100]
    fidivr WORD PTR [rax]
    fidivr WORD PTR [rip + 0x100]

// === FFREE ST(i) ===
    ffree st(0)
    ffree st(3)
    ffree st(2)
    ffree st(1)

// === FICOM m16int ===
    ficom WORD PTR [rip + 0x100]
    ficom WORD PTR [rax + rbx*4 + 0x100]
    ficom WORD PTR [rax + rbx*1 + 0x10]
    ficom WORD PTR [rax]
    ficom WORD PTR [rbx]
    ficom WORD PTR [rip + 0x1000]

// === FICOM m32int ===
    ficom DWORD PTR [rip + 0x1000]
    ficom DWORD PTR [rip + 0x100]
    ficom DWORD PTR [rbx]
    ficom DWORD PTR [rax]
    ficom DWORD PTR [rax + rbx*4 + 0x100]
    ficom DWORD PTR [rax + rbx*1 + 0x10]

// === FICOMP m16int ===
    ficomp WORD PTR [rax]
    ficomp WORD PTR [rip + 0x100]
    ficomp WORD PTR [rip + 0x1000]
    ficomp WORD PTR [rax + rbx*4 + 0x100]
    ficomp WORD PTR [rbx]
    ficomp WORD PTR [rax + rbx*1 + 0x10]

// === FICOMP m32int ===
    ficomp DWORD PTR [rip + 0x100]
    ficomp DWORD PTR [rbx]
    ficomp DWORD PTR [rax + rbx*4 + 0x100]
    ficomp DWORD PTR [rip + 0x1000]
    ficomp DWORD PTR [rax + rbx*1 + 0x10]
    ficomp DWORD PTR [rax]

// === FILD m16int ===
    fild WORD PTR [rip + 0x100]
    fild WORD PTR [rbx]
    fild WORD PTR [rax + rbx*1 + 0x10]
    fild WORD PTR [rip + 0x1000]
    fild WORD PTR [rax]
    fild WORD PTR [rax + rbx*4 + 0x100]

// === FILD m32int ===
    fild DWORD PTR [rip + 0x1000]
    fild DWORD PTR [rax + rbx*4 + 0x100]
    fild DWORD PTR [rax + rbx*1 + 0x10]
    fild DWORD PTR [rbx]
    fild DWORD PTR [rip + 0x100]
    fild DWORD PTR [rax]

// === FILD m64int ===
    fild QWORD PTR [rax + rbx*1 + 0x10]
    fild QWORD PTR [rax + rbx*4 + 0x100]
    fild QWORD PTR [rip + 0x100]
    fild QWORD PTR [rip + 0x1000]
    fild QWORD PTR [rax]
    fild QWORD PTR [rbx]

// === FINCSTP ===
    fincstp

// === FINIT ===
    finit

// === FNINIT ===
    fninit

// === FIST m16int ===
    fist WORD PTR [rip + 0x1000]
    fist WORD PTR [rax]
    fist WORD PTR [rax + rbx*1 + 0x10]
    fist WORD PTR [rax + rbx*4 + 0x100]
    fist WORD PTR [rip + 0x100]
    fist WORD PTR [rbx]

// === FIST m32int ===
    fist DWORD PTR [rax]
    fist DWORD PTR [rax + rbx*4 + 0x100]
    fist DWORD PTR [rip + 0x100]
    fist DWORD PTR [rax + rbx*1 + 0x10]
    fist DWORD PTR [rbx]
    fist DWORD PTR [rip + 0x1000]

// === FISTP m16int ===
    fistp WORD PTR [rip + 0x1000]
    fistp WORD PTR [rax + rbx*4 + 0x100]
    fistp WORD PTR [rax + rbx*1 + 0x10]
    fistp WORD PTR [rip + 0x100]
    fistp WORD PTR [rax]
    fistp WORD PTR [rbx]

// === FISTP m32int ===
    fistp DWORD PTR [rbx]
    fistp DWORD PTR [rax + rbx*1 + 0x10]
    fistp DWORD PTR [rax]
    fistp DWORD PTR [rip + 0x1000]
    fistp DWORD PTR [rax + rbx*4 + 0x100]
    fistp DWORD PTR [rip + 0x100]

// === FISTP m64int ===
    fistp QWORD PTR [rbx]
    fistp QWORD PTR [rip + 0x100]
    fistp QWORD PTR [rax + rbx*4 + 0x100]
    fistp QWORD PTR [rip + 0x1000]
    fistp QWORD PTR [rax + rbx*1 + 0x10]
    fistp QWORD PTR [rax]

// === FISTTP m16int ===
    fisttp WORD PTR [rax]
    fisttp WORD PTR [rbx]
    fisttp WORD PTR [rax + rbx*1 + 0x10]
    fisttp WORD PTR [rax + rbx*4 + 0x100]
    fisttp WORD PTR [rip + 0x1000]
    fisttp WORD PTR [rip + 0x100]

// === FISTTP m32int ===
    fisttp DWORD PTR [rax]
    fisttp DWORD PTR [rip + 0x1000]
    fisttp DWORD PTR [rbx]
    fisttp DWORD PTR [rax + rbx*4 + 0x100]
    fisttp DWORD PTR [rip + 0x100]
    fisttp DWORD PTR [rax + rbx*1 + 0x10]

// === FISTTP m64int ===
    fisttp QWORD PTR [rax + rbx*4 + 0x100]
    fisttp QWORD PTR [rip + 0x1000]
    fisttp QWORD PTR [rax + rbx*1 + 0x10]
    fisttp QWORD PTR [rax]
    fisttp QWORD PTR [rbx]
    fisttp QWORD PTR [rip + 0x100]

// === FLD m32fp ===
    fld DWORD PTR [rax + rbx*4 + 0x100]
    fld DWORD PTR [rax]
    fld DWORD PTR [rip + 0x1000]
    fld DWORD PTR [rip + 0x100]
    fld DWORD PTR [rbx]
    fld DWORD PTR [rax + rbx*1 + 0x10]

// === FLD m64fp ===
    fld QWORD PTR [rax + rbx*4 + 0x100]
    fld QWORD PTR [rbx]
    fld QWORD PTR [rax]
    fld QWORD PTR [rax + rbx*1 + 0x10]
    fld QWORD PTR [rip + 0x1000]
    fld QWORD PTR [rip + 0x100]

// === FLD m80fp ===
    fld TBYTE PTR [rip + 0x100]
    fld TBYTE PTR [rip + 0x1000]
    fld TBYTE PTR [rbx]
    fld TBYTE PTR [rax + rbx*1 + 0x10]
    fld TBYTE PTR [rax + rbx*4 + 0x100]
    fld TBYTE PTR [rax]

// === FLD ST(i) ===
    fld st(0)
    fld st(3)
    fld st(2)
    fld st(1)

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

// === FMUL m32fp ===
    fmul DWORD PTR [rax + rbx*1 + 0x10]
    fmul DWORD PTR [rip + 0x100]
    fmul DWORD PTR [rax]
    fmul DWORD PTR [rbx]
    fmul DWORD PTR [rax + rbx*4 + 0x100]
    fmul DWORD PTR [rip + 0x1000]

// === FMUL m64fp ===
    fmul QWORD PTR [rip + 0x100]
    fmul QWORD PTR [rax + rbx*4 + 0x100]
    fmul QWORD PTR [rip + 0x1000]
    fmul QWORD PTR [rbx]
    fmul QWORD PTR [rax]
    fmul QWORD PTR [rax + rbx*1 + 0x10]

// === FMUL ST(0), ST(i) ===
    fmul st(0), st(0)
    fmul st(0), st(1)
    fmul st(0), st(2)
    fmul st(0), st(3)

// === FMUL ST(i), ST(0) ===
    fmul st(1), st(0)
    fmul st(3), st(0)
    fmul st(0), st(0)
    fmul st(2), st(0)

// === FMULP ST(i), ST(0) ===
    fmulp st(3), st(0)
    fmulp st(0), st(0)
    fmulp st(1), st(0)
    fmulp st(2), st(0)

// === FMULP ===
    fmulp

// === FIMUL m32int ===
    fimul DWORD PTR [rax]
    fimul DWORD PTR [rip + 0x100]
    fimul DWORD PTR [rax + rbx*1 + 0x10]
    fimul DWORD PTR [rax + rbx*4 + 0x100]
    fimul DWORD PTR [rbx]
    fimul DWORD PTR [rip + 0x1000]

// === FIMUL m16int ===
    fimul WORD PTR [rip + 0x1000]
    fimul WORD PTR [rax + rbx*4 + 0x100]
    fimul WORD PTR [rip + 0x100]
    fimul WORD PTR [rbx]
    fimul WORD PTR [rax]
    fimul WORD PTR [rax + rbx*1 + 0x10]

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

// === FSCALE ===
    fscale

// === FSIN ===
    fsin

// === FSINCOS ===
    fsincos

// === FSQRT ===
    fsqrt

// === FST m32fp ===
    fst DWORD PTR [rax + rbx*1 + 0x10]
    fst DWORD PTR [rbx]
    fst DWORD PTR [rip + 0x100]
    fst DWORD PTR [rax + rbx*4 + 0x100]
    fst DWORD PTR [rip + 0x1000]
    fst DWORD PTR [rax]

// === FST m64fp ===
    fst QWORD PTR [rip + 0x100]
    fst QWORD PTR [rbx]
    fst QWORD PTR [rax + rbx*4 + 0x100]
    fst QWORD PTR [rax + rbx*1 + 0x10]
    fst QWORD PTR [rip + 0x1000]
    fst QWORD PTR [rax]

// === FST ST(i) ===
    fst st(1)
    fst st(0)
    fst st(2)
    fst st(3)

// === FSTP m32fp ===
    fstp DWORD PTR [rbx]
    fstp DWORD PTR [rip + 0x100]
    fstp DWORD PTR [rax]
    fstp DWORD PTR [rax + rbx*1 + 0x10]
    fstp DWORD PTR [rip + 0x1000]
    fstp DWORD PTR [rax + rbx*4 + 0x100]

// === FSTP m64fp ===
    fstp QWORD PTR [rip + 0x100]
    fstp QWORD PTR [rip + 0x1000]
    fstp QWORD PTR [rax + rbx*1 + 0x10]
    fstp QWORD PTR [rax]
    fstp QWORD PTR [rax + rbx*4 + 0x100]
    fstp QWORD PTR [rbx]

// === FSTP m80fp ===
    fstp TBYTE PTR [rax + rbx*1 + 0x10]
    fstp TBYTE PTR [rip + 0x100]
    fstp TBYTE PTR [rax + rbx*4 + 0x100]
    fstp TBYTE PTR [rbx]
    fstp TBYTE PTR [rip + 0x1000]
    fstp TBYTE PTR [rax]

// === FSTP ST(i) ===
    fstp st(0)
    fstp st(1)
    fstp st(3)
    fstp st(2)

// === FSTSW AX ===
    fstsw ax

// === FNSTSW AX ===
    fnstsw ax

// === FSUB m32fp ===
    fsub DWORD PTR [rbx]
    fsub DWORD PTR [rax + rbx*4 + 0x100]
    fsub DWORD PTR [rax]
    fsub DWORD PTR [rax + rbx*1 + 0x10]
    fsub DWORD PTR [rip + 0x1000]
    fsub DWORD PTR [rip + 0x100]

// === FSUB m64fp ===
    fsub QWORD PTR [rax]
    fsub QWORD PTR [rax + rbx*1 + 0x10]
    fsub QWORD PTR [rip + 0x1000]
    fsub QWORD PTR [rip + 0x100]
    fsub QWORD PTR [rax + rbx*4 + 0x100]
    fsub QWORD PTR [rbx]

// === FSUB ST(0), ST(i) ===
    fsub st(0), st(3)
    fsub st(0), st(1)
    fsub st(0), st(0)
    fsub st(0), st(2)

// === FSUB ST(i), ST(0) ===
    fsub st(0), st(0)
    fsub st(1), st(0)
    fsub st(2), st(0)
    fsub st(3), st(0)

// === FSUBP ST(i), ST(0) ===
    fsubp st(3), st(0)
    fsubp st(2), st(0)
    fsubp st(0), st(0)
    fsubp st(1), st(0)

// === FSUBP ===
    fsubp

// === FISUB m32int ===
    fisub DWORD PTR [rax]
    fisub DWORD PTR [rip + 0x1000]
    fisub DWORD PTR [rax + rbx*4 + 0x100]
    fisub DWORD PTR [rbx]
    fisub DWORD PTR [rax + rbx*1 + 0x10]
    fisub DWORD PTR [rip + 0x100]

// === FISUB m16int ===
    fisub WORD PTR [rip + 0x1000]
    fisub WORD PTR [rax + rbx*4 + 0x100]
    fisub WORD PTR [rax + rbx*1 + 0x10]
    fisub WORD PTR [rip + 0x100]
    fisub WORD PTR [rax]
    fisub WORD PTR [rbx]

// === FSUBR m32fp ===
    fsubr DWORD PTR [rbx]
    fsubr DWORD PTR [rax + rbx*1 + 0x10]
    fsubr DWORD PTR [rax + rbx*4 + 0x100]
    fsubr DWORD PTR [rip + 0x100]
    fsubr DWORD PTR [rax]
    fsubr DWORD PTR [rip + 0x1000]

// === FSUBR m64fp ===
    fsubr QWORD PTR [rax + rbx*4 + 0x100]
    fsubr QWORD PTR [rax]
    fsubr QWORD PTR [rip + 0x100]
    fsubr QWORD PTR [rax + rbx*1 + 0x10]
    fsubr QWORD PTR [rip + 0x1000]
    fsubr QWORD PTR [rbx]

// === FSUBR ST(0), ST(i) ===
    fsubr st(0), st(2)
    fsubr st(0), st(0)
    fsubr st(0), st(1)
    fsubr st(0), st(3)

// === FSUBR ST(i), ST(0) ===
    fsubr st(3), st(0)
    fsubr st(1), st(0)
    fsubr st(2), st(0)
    fsubr st(0), st(0)

// === FSUBRP ST(i), ST(0) ===
    fsubrp st(2), st(0)
    fsubrp st(3), st(0)
    fsubrp st(1), st(0)
    fsubrp st(0), st(0)

// === FSUBRP ===
    fsubrp

// === FISUBR m32int ===
    fisubr DWORD PTR [rax + rbx*1 + 0x10]
    fisubr DWORD PTR [rbx]
    fisubr DWORD PTR [rip + 0x1000]
    fisubr DWORD PTR [rax + rbx*4 + 0x100]
    fisubr DWORD PTR [rip + 0x100]
    fisubr DWORD PTR [rax]

// === FISUBR m16int ===
    fisubr WORD PTR [rip + 0x100]
    fisubr WORD PTR [rax + rbx*4 + 0x100]
    fisubr WORD PTR [rax + rbx*1 + 0x10]
    fisubr WORD PTR [rbx]
    fisubr WORD PTR [rax]
    fisubr WORD PTR [rip + 0x1000]

// === FTST ===
    ftst

// === FUCOM ST(i) ===
    fucom st(1)
    fucom st(0)
    fucom st(2)
    fucom st(3)

// === FUCOM ===
    fucom

// === FUCOMP ST(i) ===
    fucomp st(2)
    fucomp st(0)
    fucomp st(1)
    fucomp st(3)

// === FUCOMP ===
    fucomp

// === FUCOMPP ===
    fucompp

// === FXAM ===
    fxam

// === FXCH ST(i) ===
    fxch st(0)
    fxch st(3)
    fxch st(1)
    fxch st(2)

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
    idiv dl
    idiv bl
    idiv cl

// === IDIV m8 ===
    idiv BYTE PTR [rip + 0x100]
    idiv BYTE PTR [rbx]
    idiv BYTE PTR [rax + rbx*4 + 0x100]
    idiv BYTE PTR [rip + 0x1000]
    idiv BYTE PTR [rax]
    idiv BYTE PTR [rax + rbx*1 + 0x10]

// === IDIV r16 ===
    idiv bx
    idiv di
    idiv cx
    idiv ax
    idiv dx
    idiv si

// === IDIV m16 ===
    idiv WORD PTR [rax]
    idiv WORD PTR [rip + 0x1000]
    idiv WORD PTR [rip + 0x100]
    idiv WORD PTR [rax + rbx*4 + 0x100]
    idiv WORD PTR [rax + rbx*1 + 0x10]
    idiv WORD PTR [rbx]

// === IDIV r32 ===
    idiv ebx
    idiv edx
    idiv esi
    idiv eax
    idiv ecx
    idiv edi

// === IDIV m32 ===
    idiv DWORD PTR [rax]
    idiv DWORD PTR [rip + 0x100]
    idiv DWORD PTR [rbx]
    idiv DWORD PTR [rip + 0x1000]
    idiv DWORD PTR [rax + rbx*4 + 0x100]
    idiv DWORD PTR [rax + rbx*1 + 0x10]

// === IDIV r64 ===
    idiv r8
    idiv rdi
    idiv r13
    idiv r11
    idiv rbx
    idiv r9
    idiv rsi
    idiv rdx
    idiv rax
    idiv r12

// === IDIV m64 ===
    idiv QWORD PTR [rip + 0x1000]
    idiv QWORD PTR [rax + rbx*1 + 0x10]
    idiv QWORD PTR [rip + 0x100]
    idiv QWORD PTR [rbx]
    idiv QWORD PTR [rax]
    idiv QWORD PTR [rax + rbx*4 + 0x100]

// === IMUL r8 ===
    imul al
    imul dl
    imul bl
    imul cl

// === IMUL m8 ===
    imul BYTE PTR [rip + 0x100]
    imul BYTE PTR [rip + 0x1000]
    imul BYTE PTR [rbx]
    imul BYTE PTR [rax + rbx*1 + 0x10]
    imul BYTE PTR [rax]
    imul BYTE PTR [rax + rbx*4 + 0x100]

// === IMUL r16 ===
    imul bx
    imul dx
    imul si
    imul cx
    imul ax
    imul di

// === IMUL m16 ===
    imul WORD PTR [rax + rbx*1 + 0x10]
    imul WORD PTR [rax + rbx*4 + 0x100]
    imul WORD PTR [rip + 0x1000]
    imul WORD PTR [rip + 0x100]
    imul WORD PTR [rax]
    imul WORD PTR [rbx]

// === IMUL r32 ===
    imul eax
    imul edx
    imul ebx
    imul edi
    imul ecx
    imul esi

// === IMUL m32 ===
    imul DWORD PTR [rip + 0x100]
    imul DWORD PTR [rax + rbx*1 + 0x10]
    imul DWORD PTR [rip + 0x1000]
    imul DWORD PTR [rax + rbx*4 + 0x100]
    imul DWORD PTR [rbx]
    imul DWORD PTR [rax]

// === IMUL r64 ===
    imul rbx
    imul r11
    imul r10
    imul r9
    imul r13
    imul rdx
    imul rcx
    imul r12
    imul rdi
    imul rsi

// === IMUL m64 ===
    imul QWORD PTR [rax]
    imul QWORD PTR [rbx]
    imul QWORD PTR [rip + 0x100]
    imul QWORD PTR [rax + rbx*4 + 0x100]
    imul QWORD PTR [rax + rbx*1 + 0x10]
    imul QWORD PTR [rip + 0x1000]

// === IMUL r16, r16 ===
    imul bx, si
    imul ax, dx
    imul dx, di
    imul cx, ax
    imul si, si
    imul cx, dx
    imul si, dx
    imul cx, di
    imul bx, ax
    imul di, di

// === IMUL r16, m16 ===
    imul ax, WORD PTR [rax + rbx*1 + 0x10]
    imul di, WORD PTR [rax + rbx*1 + 0x10]
    imul cx, WORD PTR [rip + 0x1000]
    imul ax, WORD PTR [rax + rbx*4 + 0x100]
    imul cx, WORD PTR [rbx]
    imul di, WORD PTR [rbx]
    imul di, WORD PTR [rip + 0x1000]
    imul si, WORD PTR [rip + 0x100]
    imul bx, WORD PTR [rip + 0x100]
    imul si, WORD PTR [rbx]

// === IMUL r32, r32 ===
    imul edx, edx
    imul eax, eax
    imul esi, edx
    imul ecx, eax
    imul esi, esi
    imul edx, esi
    imul ebx, esi
    imul edi, edi
    imul edx, edi
    imul ecx, edx

// === IMUL r32, m32 ===
    imul eax, DWORD PTR [rip + 0x100]
    imul edi, DWORD PTR [rip + 0x100]
    imul esi, DWORD PTR [rax + rbx*4 + 0x100]
    imul ebx, DWORD PTR [rip + 0x1000]
    imul edi, DWORD PTR [rbx]
    imul eax, DWORD PTR [rip + 0x1000]
    imul edx, DWORD PTR [rax + rbx*1 + 0x10]
    imul edi, DWORD PTR [rax + rbx*1 + 0x10]
    imul edx, DWORD PTR [rip + 0x100]
    imul edx, DWORD PTR [rip + 0x1000]

// === IMUL r64, r64 ===
    imul rbx, r8
    imul rdi, r10
    imul rsi, rbx
    imul r13, rdx
    imul rax, rax
    imul r13, r11
    imul rdx, rcx
    imul rcx, rax
    imul r8, rsi
    imul r8, rcx

// === IMUL r64, m64 ===
    imul rax, QWORD PTR [rax + rbx*4 + 0x100]
    imul r12, QWORD PTR [rax + rbx*4 + 0x100]
    imul r9, QWORD PTR [rbx]
    imul r11, QWORD PTR [rip + 0x100]
    imul rdx, QWORD PTR [rax + rbx*4 + 0x100]
    imul rbx, QWORD PTR [rip + 0x100]
    imul r12, QWORD PTR [rax + rbx*1 + 0x10]
    imul r13, QWORD PTR [rax]
    imul rcx, QWORD PTR [rip + 0x100]
    imul r13, QWORD PTR [rip + 0x1000]

// === IMUL r16, r16, imm8 ===
    imul di, bx, 0xff
    imul bx, di, 0xff
    imul bx, dx, 0xff
    imul si, di, 0xff
    imul si, ax, 0xff
    imul ax, cx, 0xff
    imul di, dx, 0xff
    imul di, si, 0xff
    imul bx, si, 0xff
    imul cx, dx, 0xff

// === IMUL r16, m16, imm8 ===
    imul dx, WORD PTR [rbx], 0xff
    imul si, WORD PTR [rax], 0xff
    imul bx, WORD PTR [rax], 0xff
    imul di, WORD PTR [rbx], 0xff
    imul cx, WORD PTR [rbx], 0xff
    imul ax, WORD PTR [rax], 0xff
    imul di, WORD PTR [rax], 0xff
    imul bx, WORD PTR [rbx], 0xff
    imul ax, WORD PTR [rip + 0x1000], 0xff
    imul cx, WORD PTR [rip + 0x1000], 0xff

// === IMUL r32, r32, imm8 ===
    imul edi, edi, 0xff
    imul ecx, ebx, 0xff
    imul eax, eax, 0xff
    imul edx, edi, 0xff
    imul edi, ecx, 0xff
    imul eax, esi, 0xff
    imul eax, ecx, 0xff
    imul esi, ecx, 0xff
    imul eax, edi, 0xff
    imul ecx, eax, 0xff

// === IMUL r32, m32, imm8 ===
    imul eax, DWORD PTR [rbx], 0xff
    imul edi, DWORD PTR [rax + rbx*1 + 0x10], 0xff
    imul eax, DWORD PTR [rax], 0xff
    imul esi, DWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul eax, DWORD PTR [rip + 0x100], 0xff
    imul edx, DWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul ebx, DWORD PTR [rip + 0x100], 0xff
    imul esi, DWORD PTR [rax], 0xff
    imul esi, DWORD PTR [rip + 0x100], 0xff
    imul ecx, DWORD PTR [rip + 0x100], 0xff

// === IMUL r64, r64, imm8 ===
    imul r9, rbx, 0xff
    imul rax, rsi, 0xff
    imul rbx, rsi, 0xff
    imul rsi, r8, 0xff
    imul r9, rdi, 0xff
    imul rbx, rax, 0xff
    imul r10, rdx, 0xff
    imul r10, r13, 0xff
    imul rdi, r11, 0xff
    imul rcx, r9, 0xff

// === IMUL r64, m64, imm8 ===
    imul rdx, QWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul rsi, QWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul rdi, QWORD PTR [rbx], 0xff
    imul r12, QWORD PTR [rbx], 0xff
    imul r9, QWORD PTR [rax + rbx*1 + 0x10], 0xff
    imul r11, QWORD PTR [rax], 0xff
    imul r10, QWORD PTR [rbx], 0xff
    imul r13, QWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul r12, QWORD PTR [rax + rbx*4 + 0x100], 0xff
    imul rax, QWORD PTR [rip + 0x1000], 0xff

// === IMUL r16, r16, imm16 ===
    imul si, cx, 0xffff
    imul ax, si, 0xffff
    imul cx, dx, 0xffff
    imul ax, dx, 0xffff
    imul dx, dx, 0xffff
    imul bx, dx, 0xffff
    imul ax, di, 0xffff
    imul ax, ax, 0xffff
    imul bx, ax, 0xffff
    imul di, di, 0xffff

// === IMUL r16, m16, imm16 ===
    imul bx, WORD PTR [rip + 0x100], 0xffff
    imul si, WORD PTR [rbx], 0xffff
    imul cx, WORD PTR [rip + 0x100], 0xffff
    imul si, WORD PTR [rax], 0xffff
    imul di, WORD PTR [rax + rbx*4 + 0x100], 0xffff
    imul ax, WORD PTR [rax + rbx*4 + 0x100], 0xffff
    imul ax, WORD PTR [rip + 0x100], 0xffff
    imul bx, WORD PTR [rax + rbx*1 + 0x10], 0xffff
    imul cx, WORD PTR [rax + rbx*1 + 0x10], 0xffff
    imul si, WORD PTR [rax + rbx*1 + 0x10], 0xffff

// === IMUL r32, r32, imm32 ===
    imul edx, edi, 0xffffffff
    imul edx, edx, 0xffffffff
    imul edx, ebx, 0xffffffff
    imul eax, esi, 0xffffffff
    imul edi, ebx, 0xffffffff
    imul ebx, ecx, 0xffffffff
    imul eax, ecx, 0xffffffff
    imul ebx, esi, 0xffffffff
    imul edi, edx, 0xffffffff
    imul eax, edx, 0xffffffff

// === IMUL r32, m32, imm32 ===
    imul eax, DWORD PTR [rax], 0xffffffff
    imul edi, DWORD PTR [rip + 0x1000], 0xffffffff
    imul esi, DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    imul esi, DWORD PTR [rbx], 0xffffffff
    imul esi, DWORD PTR [rax], 0xffffffff
    imul edx, DWORD PTR [rbx], 0xffffffff
    imul esi, DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    imul eax, DWORD PTR [rip + 0x100], 0xffffffff
    imul edx, DWORD PTR [rip + 0x1000], 0xffffffff
    imul edi, DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff

// === IMUL r64, r64, imm32 ===
    imul rdi, rax, -1
    imul r10, r11, 0x7fffffff
    imul rcx, rdi, -1
    imul r13, rcx, -1
    imul rdx, r9, -1
    imul rax, r9, 0x7fffffff
    imul rsi, rbx, 0x7fffffff
    imul rcx, rsi, 0x7fffffff
    imul r8, r12, 0x7fffffff
    imul r9, r9, 0x7fffffff

// === IMUL r64, m64, imm32 ===
    imul rdx, QWORD PTR [rax + rbx*4 + 0x100], -1
    imul rdx, QWORD PTR [rax], 0x7fffffff
    imul rdi, QWORD PTR [rbx], 0x7fffffff
    imul rax, QWORD PTR [rax], 0x7fffffff
    imul rdi, QWORD PTR [rax], -1
    imul rsi, QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    imul rsi, QWORD PTR [rip + 0x100], -1
    imul r13, QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    imul rcx, QWORD PTR [rbx], 0x7fffffff
    imul r13, QWORD PTR [rax + rbx*1 + 0x10], -1

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
    inc al
    inc cl
    inc dl
    inc bl

// === INC m8 ===
    inc BYTE PTR [rbx]
    inc BYTE PTR [rip + 0x100]
    inc BYTE PTR [rax + rbx*4 + 0x100]
    inc BYTE PTR [rax + rbx*1 + 0x10]
    inc BYTE PTR [rip + 0x1000]
    inc BYTE PTR [rax]

// === INC r16 ===
    inc cx
    inc di
    inc si
    inc ax
    inc dx
    inc bx

// === INC m16 ===
    inc WORD PTR [rbx]
    inc WORD PTR [rax]
    inc WORD PTR [rax + rbx*4 + 0x100]
    inc WORD PTR [rax + rbx*1 + 0x10]
    inc WORD PTR [rip + 0x100]
    inc WORD PTR [rip + 0x1000]

// === INC r32 ===
    inc edi
    inc edx
    inc esi
    inc ebx
    inc eax
    inc ecx

// === INC m32 ===
    inc DWORD PTR [rip + 0x100]
    inc DWORD PTR [rip + 0x1000]
    inc DWORD PTR [rax + rbx*4 + 0x100]
    inc DWORD PTR [rbx]
    inc DWORD PTR [rax]
    inc DWORD PTR [rax + rbx*1 + 0x10]

// === INC r64 ===
    inc r12
    inc rdi
    inc r11
    inc r13
    inc rdx
    inc rcx
    inc rsi
    inc r10
    inc rax
    inc rbx

// === INC m64 ===
    inc QWORD PTR [rip + 0x1000]
    inc QWORD PTR [rax + rbx*4 + 0x100]
    inc QWORD PTR [rax]
    inc QWORD PTR [rbx]
    inc QWORD PTR [rip + 0x100]
    inc QWORD PTR [rax + rbx*1 + 0x10]

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
    invlpg QWORD PTR [rax]
    invlpg QWORD PTR [rip + 0x100]
    invlpg QWORD PTR [rax + rbx*1 + 0x10]
    invlpg QWORD PTR [rbx]
    invlpg QWORD PTR [rip + 0x1000]
    invlpg QWORD PTR [rax + rbx*4 + 0x100]

// === IRETQ ===
    iretq

// === JA rel8 ===
    ja .

// === JAE rel8 ===
    jae .

// === JB rel8 ===
    jb .

// === JBE rel8 ===
    jbe .

// === JC rel8 ===
    jc .

// === JRCXZ rel8 ===
    jrcxz .

// === JE rel8 ===
    je .

// === JG rel8 ===
    jg .

// === JGE rel8 ===
    jge .

// === JL rel8 ===
    jl .

// === JLE rel8 ===
    jle .

// === JNA rel8 ===
    jna .

// === JNAE rel8 ===
    jnae .

// === JNB rel8 ===
    jnb .

// === JNBE rel8 ===
    jnbe .

// === JNC rel8 ===
    jnc .

// === JNE rel8 ===
    jne .

// === JNG rel8 ===
    jng .

// === JNGE rel8 ===
    jnge .

// === JNL rel8 ===
    jnl .

// === JNLE rel8 ===
    jnle .

// === JNO rel8 ===
    jno .

// === JNP rel8 ===
    jnp .

// === JNS rel8 ===
    jns .

// === JNZ rel8 ===
    jnz .

// === JO rel8 ===
    jo .

// === JP rel8 ===
    jp .

// === JPE rel8 ===
    jpe .

// === JPO rel8 ===
    jpo .

// === JS rel8 ===
    js .

// === JZ rel8 ===
    jz .

// === JA rel32 ===
    ja .

// === JAE rel32 ===
    jae .

// === JB rel32 ===
    jb .

// === JBE rel32 ===
    jbe .

// === JC rel32 ===
    jc .

// === JE rel32 ===
    je .

// === JZ rel32 ===
    jz .

// === JG rel32 ===
    jg .

// === JGE rel32 ===
    jge .

// === JL rel32 ===
    jl .

// === JLE rel32 ===
    jle .

// === JNA rel32 ===
    jna .

// === JNAE rel32 ===
    jnae .

// === JNB rel32 ===
    jnb .

// === JNBE rel32 ===
    jnbe .

// === JNC rel32 ===
    jnc .

// === JNE rel32 ===
    jne .

// === JNG rel32 ===
    jng .

// === JNGE rel32 ===
    jnge .

// === JNL rel32 ===
    jnl .

// === JNLE rel32 ===
    jnle .

// === JNO rel32 ===
    jno .

// === JNP rel32 ===
    jnp .

// === JNS rel32 ===
    jns .

// === JNZ rel32 ===
    jnz .

// === JO rel32 ===
    jo .

// === JP rel32 ===
    jp .

// === JPE rel32 ===
    jpe .

// === JPO rel32 ===
    jpo .

// === JS rel32 ===
    js .

// === JMP rel8 ===
    jmp .

// === JMP rel32 ===
    jmp .

// === JMP r64 ===
    jmp rdi
    jmp rax
    jmp rsi
    jmp r9
    jmp r13
    jmp rcx
    jmp rdx
    jmp r10
    jmp r11
    jmp rbx

// === JMP m64 ===
    jmp QWORD PTR [rip + 0x1000]
    jmp QWORD PTR [rbx]
    jmp QWORD PTR [rax + rbx*4 + 0x100]
    jmp QWORD PTR [rax + rbx*1 + 0x10]
    jmp QWORD PTR [rip + 0x100]
    jmp QWORD PTR [rax]

// === LAHF ===
    lahf

// === LAR r16, r16/m16 ===
    lar ax, WORD PTR [rax + rbx*1 + 0x10]
    lar si, WORD PTR [rax]
    lar ax, WORD PTR [rax + rbx*4 + 0x100]
    lar dx, WORD PTR [rax + rbx*4 + 0x100]
    lar bx, WORD PTR [rip + 0x1000]
    lar bx, WORD PTR [rbx]
    lar cx, WORD PTR [rip + 0x100]
    lar ax, WORD PTR [rbx]
    lar dx, WORD PTR [rip + 0x1000]
    lar dx, WORD PTR [rip + 0x100]

// === LAR r32, r32/m16 ===
    lar edi, WORD PTR [rip + 0x100]
    lar ecx, WORD PTR [rax + rbx*1 + 0x10]
    lar eax, WORD PTR [rax + rbx*1 + 0x10]
    lar ecx, WORD PTR [rip + 0x1000]
    lar esi, WORD PTR [rax + rbx*1 + 0x10]
    lar ebx, WORD PTR [rip + 0x1000]
    lar ebx, WORD PTR [rbx]
    lar esi, WORD PTR [rip + 0x1000]
    lar edx, WORD PTR [rax + rbx*4 + 0x100]
    lar ecx, WORD PTR [rbx]

// === LSS r16,m16:16 ===
    lss bx, DWORD PTR [rax]
    lss cx, DWORD PTR [rip + 0x1000]
    lss si, DWORD PTR [rax + rbx*1 + 0x10]
    lss si, DWORD PTR [rbx]
    lss dx, DWORD PTR [rax + rbx*4 + 0x100]
    lss cx, DWORD PTR [rax]
    lss di, DWORD PTR [rip + 0x100]
    lss di, DWORD PTR [rbx]
    lss di, DWORD PTR [rax + rbx*4 + 0x100]
    lss bx, DWORD PTR [rbx]

// === LSS r32,m16:32 ===
    lss esi, FWORD PTR [rax + rbx*4 + 0x100]
    lss ebx, FWORD PTR [rip + 0x100]
    lss eax, FWORD PTR [rip + 0x1000]
    lss ecx, FWORD PTR [rax]
    lss ebx, FWORD PTR [rip + 0x1000]
    lss ebx, FWORD PTR [rax + rbx*4 + 0x100]
    lss esi, FWORD PTR [rax]
    lss ecx, FWORD PTR [rax + rbx*4 + 0x100]
    lss edi, FWORD PTR [rip + 0x1000]
    lss ebx, FWORD PTR [rax + rbx*1 + 0x10]

// === LSS r64,m16:64 ===
    lss rdi, TBYTE PTR [rax]
    lss r8, TBYTE PTR [rip + 0x1000]
    lss r8, TBYTE PTR [rax + rbx*4 + 0x100]
    lss r12, TBYTE PTR [rip + 0x1000]
    lss rdi, TBYTE PTR [rax + rbx*1 + 0x10]
    lss rax, TBYTE PTR [rax + rbx*4 + 0x100]
    lss r11, TBYTE PTR [rax]
    lss rdx, TBYTE PTR [rip + 0x1000]
    lss r9, TBYTE PTR [rax]
    lss rdi, TBYTE PTR [rax + rbx*4 + 0x100]

// === LFS r16,m16:16 ===
    lfs di, DWORD PTR [rax]
    lfs ax, DWORD PTR [rbx]
    lfs bx, DWORD PTR [rax + rbx*4 + 0x100]
    lfs di, DWORD PTR [rip + 0x1000]
    lfs bx, DWORD PTR [rbx]
    lfs cx, DWORD PTR [rax + rbx*4 + 0x100]
    lfs dx, DWORD PTR [rbx]
    lfs di, DWORD PTR [rax + rbx*1 + 0x10]
    lfs dx, DWORD PTR [rip + 0x100]
    lfs di, DWORD PTR [rax + rbx*4 + 0x100]

// === LFS r32,m16:32 ===
    lfs esi, FWORD PTR [rax + rbx*1 + 0x10]
    lfs ecx, FWORD PTR [rax + rbx*1 + 0x10]
    lfs edx, FWORD PTR [rax + rbx*1 + 0x10]
    lfs ecx, FWORD PTR [rbx]
    lfs eax, FWORD PTR [rax]
    lfs ebx, FWORD PTR [rbx]
    lfs ebx, FWORD PTR [rax]
    lfs ecx, FWORD PTR [rax + rbx*4 + 0x100]
    lfs edi, FWORD PTR [rbx]
    lfs edx, FWORD PTR [rax]

// === LFS r64,m16:64 ===
    lfs r13, TBYTE PTR [rip + 0x100]
    lfs rsi, TBYTE PTR [rax]
    lfs rcx, TBYTE PTR [rip + 0x1000]
    lfs rax, TBYTE PTR [rax + rbx*4 + 0x100]
    lfs rbx, TBYTE PTR [rbx]
    lfs r9, TBYTE PTR [rax + rbx*4 + 0x100]
    lfs r9, TBYTE PTR [rax]
    lfs r11, TBYTE PTR [rax]
    lfs rax, TBYTE PTR [rax]
    lfs r8, TBYTE PTR [rax + rbx*1 + 0x10]

// === LGS r16,m16:16 ===
    lgs di, DWORD PTR [rax + rbx*4 + 0x100]
    lgs ax, DWORD PTR [rip + 0x100]
    lgs bx, DWORD PTR [rip + 0x1000]
    lgs di, DWORD PTR [rip + 0x100]
    lgs bx, DWORD PTR [rax]
    lgs bx, DWORD PTR [rax + rbx*4 + 0x100]
    lgs cx, DWORD PTR [rip + 0x1000]
    lgs dx, DWORD PTR [rax + rbx*1 + 0x10]
    lgs cx, DWORD PTR [rbx]
    lgs si, DWORD PTR [rbx]

// === LGS r32,m16:32 ===
    lgs edi, FWORD PTR [rip + 0x1000]
    lgs ebx, FWORD PTR [rax + rbx*4 + 0x100]
    lgs edx, FWORD PTR [rax + rbx*4 + 0x100]
    lgs ebx, FWORD PTR [rbx]
    lgs edi, FWORD PTR [rax]
    lgs esi, FWORD PTR [rbx]
    lgs eax, FWORD PTR [rip + 0x100]
    lgs ecx, FWORD PTR [rip + 0x100]
    lgs ecx, FWORD PTR [rax]
    lgs eax, FWORD PTR [rax + rbx*4 + 0x100]

// === LGS r64,m16:64 ===
    lgs rax, TBYTE PTR [rip + 0x100]
    lgs r13, TBYTE PTR [rip + 0x100]
    lgs r8, TBYTE PTR [rip + 0x1000]
    lgs rcx, TBYTE PTR [rax]
    lgs r8, TBYTE PTR [rax + rbx*1 + 0x10]
    lgs r11, TBYTE PTR [rax + rbx*1 + 0x10]
    lgs rcx, TBYTE PTR [rax + rbx*4 + 0x100]
    lgs r10, TBYTE PTR [rax]
    lgs r10, TBYTE PTR [rip + 0x1000]
    lgs rdx, TBYTE PTR [rbx]

// === LEA r16,m ===
    lea cx, QWORD PTR [rbx]
    lea cx, QWORD PTR [rax + rbx*1 + 0x10]
    lea si, QWORD PTR [rax + rbx*1 + 0x10]
    lea bx, QWORD PTR [rax]
    lea dx, QWORD PTR [rbx]
    lea dx, QWORD PTR [rip + 0x100]
    lea cx, QWORD PTR [rip + 0x1000]
    lea di, QWORD PTR [rip + 0x1000]
    lea cx, QWORD PTR [rax + rbx*4 + 0x100]
    lea dx, QWORD PTR [rip + 0x1000]

// === LEA r32,m ===
    lea eax, QWORD PTR [rip + 0x100]
    lea ebx, QWORD PTR [rax]
    lea eax, QWORD PTR [rbx]
    lea ecx, QWORD PTR [rip + 0x100]
    lea ecx, QWORD PTR [rax + rbx*1 + 0x10]
    lea eax, QWORD PTR [rax + rbx*4 + 0x100]
    lea eax, QWORD PTR [rip + 0x1000]
    lea ecx, QWORD PTR [rbx]
    lea esi, QWORD PTR [rax + rbx*4 + 0x100]
    lea esi, QWORD PTR [rax]

// === LEA r64,m ===
    lea r9, QWORD PTR [rip + 0x1000]
    lea r10, QWORD PTR [rbx]
    lea rbx, QWORD PTR [rax + rbx*1 + 0x10]
    lea rcx, QWORD PTR [rbx]
    lea rsi, QWORD PTR [rip + 0x100]
    lea r11, QWORD PTR [rbx]
    lea r12, QWORD PTR [rip + 0x1000]
    lea r12, QWORD PTR [rax + rbx*4 + 0x100]
    lea r13, QWORD PTR [rbx]
    lea r8, QWORD PTR [rip + 0x100]

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
    lkgs si
    lkgs cx
    lkgs ax
    lkgs di
    lkgs bx
    lkgs dx

// === LKGS m16 ===
    lkgs WORD PTR [rip + 0x1000]
    lkgs WORD PTR [rax + rbx*1 + 0x10]
    lkgs WORD PTR [rbx]
    lkgs WORD PTR [rip + 0x100]
    lkgs WORD PTR [rax + rbx*4 + 0x100]
    lkgs WORD PTR [rax]

// === LLDT r16 ===
    lldt cx
    lldt bx
    lldt ax
    lldt si
    lldt di
    lldt dx

// === LLDT m16 ===
    lldt WORD PTR [rax]
    lldt WORD PTR [rax + rbx*4 + 0x100]
    lldt WORD PTR [rax + rbx*1 + 0x10]
    lldt WORD PTR [rbx]
    lldt WORD PTR [rip + 0x100]
    lldt WORD PTR [rip + 0x1000]

// === LMSW r16 ===
    lmsw dx
    lmsw cx
    lmsw ax
    lmsw bx
    lmsw si
    lmsw di

// === LMSW m16 ===
    lmsw WORD PTR [rbx]
    lmsw WORD PTR [rip + 0x100]
    lmsw WORD PTR [rax + rbx*4 + 0x100]
    lmsw WORD PTR [rax]
    lmsw WORD PTR [rip + 0x1000]
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
    loop .

// === LOOPE rel8 ===
    loope .

// === LOOPNE rel8 ===
    loopne .

// === LSL r16, r16/m16 ===
    lsl ax, WORD PTR [rip + 0x100]
    lsl di, WORD PTR [rax]
    lsl si, WORD PTR [rax]
    lsl di, WORD PTR [rax + rbx*4 + 0x100]
    lsl bx, WORD PTR [rax + rbx*4 + 0x100]
    lsl ax, WORD PTR [rbx]
    lsl bx, WORD PTR [rip + 0x100]
    lsl dx, WORD PTR [rip + 0x100]
    lsl di, WORD PTR [rip + 0x1000]
    lsl dx, WORD PTR [rax]

// === LSL r32, r32/m16 ===
    lsl ecx, WORD PTR [rax + rbx*1 + 0x10]
    lsl eax, WORD PTR [rip + 0x1000]
    lsl esi, WORD PTR [rip + 0x1000]
    lsl esi, WORD PTR [rip + 0x100]
    lsl edx, WORD PTR [rax + rbx*1 + 0x10]
    lsl edx, WORD PTR [rax]
    lsl esi, WORD PTR [rax + rbx*1 + 0x10]
    lsl eax, WORD PTR [rax + rbx*4 + 0x100]
    lsl edi, WORD PTR [rax + rbx*4 + 0x100]
    lsl ebx, WORD PTR [rax]

// === LSL r64, r32/m16 ===
    lsl rsi, WORD PTR [rbx]
    lsl r12, WORD PTR [rax + rbx*4 + 0x100]
    lsl r10, WORD PTR [rip + 0x100]
    lsl rbx, WORD PTR [rip + 0x1000]
    lsl rdi, WORD PTR [rip + 0x100]
    lsl rbx, WORD PTR [rax + rbx*1 + 0x10]
    lsl rbx, WORD PTR [rax]
    lsl r10, WORD PTR [rip + 0x1000]
    lsl r10, WORD PTR [rbx]
    lsl r8, WORD PTR [rax + rbx*1 + 0x10]

// === LTR r16 ===
    ltr bx
    ltr di
    ltr cx
    ltr dx
    ltr si
    ltr ax

// === LTR m16 ===
    ltr WORD PTR [rax]
    ltr WORD PTR [rax + rbx*1 + 0x10]
    ltr WORD PTR [rax + rbx*4 + 0x100]
    ltr WORD PTR [rip + 0x1000]
    ltr WORD PTR [rip + 0x100]
    ltr WORD PTR [rbx]

// === MONITOR ===
    monitor

// === MOV r8, r8 ===
    mov al, dl
    mov bl, cl
    mov bl, al
    mov bl, dl
    mov dl, cl
    mov bl, bl
    mov dl, dl
    mov cl, cl
    mov cl, dl
    mov al, al

// === MOV m8, r8 ===
    mov BYTE PTR [rax + rbx*4 + 0x100], cl
    mov BYTE PTR [rax + rbx*4 + 0x100], dl
    mov BYTE PTR [rip + 0x1000], dl
    mov BYTE PTR [rbx], dl
    mov BYTE PTR [rip + 0x100], cl
    mov BYTE PTR [rip + 0x100], dl
    mov BYTE PTR [rip + 0x100], bl
    mov BYTE PTR [rbx], cl
    mov BYTE PTR [rax], al
    mov BYTE PTR [rip + 0x1000], al

// === MOV r16, r16 ===
    mov bx, ax
    mov bx, si
    mov cx, ax
    mov ax, dx
    mov dx, bx
    mov dx, cx
    mov di, si
    mov dx, dx
    mov bx, di
    mov di, bx

// === MOV m16, r16 ===
    mov WORD PTR [rax], bx
    mov WORD PTR [rax], cx
    mov WORD PTR [rax + rbx*1 + 0x10], cx
    mov WORD PTR [rbx], bx
    mov WORD PTR [rip + 0x100], si
    mov WORD PTR [rip + 0x100], bx
    mov WORD PTR [rip + 0x1000], cx
    mov WORD PTR [rip + 0x1000], dx
    mov WORD PTR [rax + rbx*1 + 0x10], si
    mov WORD PTR [rax + rbx*1 + 0x10], bx

// === MOV r32, r32 ===
    mov edx, ecx
    mov eax, ebx
    mov edi, edx
    mov edi, esi
    mov eax, edx
    mov edi, ebx
    mov edi, edi
    mov eax, esi
    mov ebx, ebx
    mov eax, ecx

// === MOV m32, r32 ===
    mov DWORD PTR [rip + 0x100], esi
    mov DWORD PTR [rax + rbx*1 + 0x10], edi
    mov DWORD PTR [rip + 0x1000], ecx
    mov DWORD PTR [rbx], ebx
    mov DWORD PTR [rax], ecx
    mov DWORD PTR [rip + 0x1000], eax
    mov DWORD PTR [rbx], ecx
    mov DWORD PTR [rax + rbx*4 + 0x100], esi
    mov DWORD PTR [rax + rbx*4 + 0x100], ebx
    mov DWORD PTR [rax + rbx*4 + 0x100], eax

// === MOV r64, r64 ===
    mov rax, r11
    mov r11, r11
    mov r8, rsi
    mov rbx, rcx
    mov rsi, r11
    mov rdi, r8
    mov r10, r10
    mov r12, rbx
    mov r11, rbx
    mov rbx, rbx

// === MOV m64, r64 ===
    mov QWORD PTR [rbx], r11
    mov QWORD PTR [rax], r11
    mov QWORD PTR [rax + rbx*4 + 0x100], rsi
    mov QWORD PTR [rbx], r8
    mov QWORD PTR [rip + 0x100], rsi
    mov QWORD PTR [rax], rbx
    mov QWORD PTR [rax], r9
    mov QWORD PTR [rip + 0x1000], rcx
    mov QWORD PTR [rbx], rsi
    mov QWORD PTR [rip + 0x1000], r8

// === MOV r8, m8 ===
    mov bl, BYTE PTR [rax]
    mov cl, BYTE PTR [rip + 0x100]
    mov al, BYTE PTR [rip + 0x100]
    mov al, BYTE PTR [rax]
    mov cl, BYTE PTR [rax]
    mov al, BYTE PTR [rbx]
    mov bl, BYTE PTR [rbx]
    mov dl, BYTE PTR [rax + rbx*4 + 0x100]
    mov cl, BYTE PTR [rip + 0x1000]
    mov bl, BYTE PTR [rip + 0x1000]

// === MOV r16, m16 ===
    mov ax, WORD PTR [rax + rbx*4 + 0x100]
    mov ax, WORD PTR [rip + 0x100]
    mov cx, WORD PTR [rax + rbx*4 + 0x100]
    mov di, WORD PTR [rax + rbx*4 + 0x100]
    mov ax, WORD PTR [rax + rbx*1 + 0x10]
    mov si, WORD PTR [rip + 0x1000]
    mov si, WORD PTR [rax]
    mov cx, WORD PTR [rip + 0x1000]
    mov bx, WORD PTR [rbx]
    mov ax, WORD PTR [rip + 0x1000]

// === MOV r32, m32 ===
    mov eax, DWORD PTR [rax]
    mov edi, DWORD PTR [rax + rbx*4 + 0x100]
    mov edi, DWORD PTR [rbx]
    mov edi, DWORD PTR [rax + rbx*1 + 0x10]
    mov ecx, DWORD PTR [rip + 0x100]
    mov ebx, DWORD PTR [rax]
    mov eax, DWORD PTR [rax + rbx*4 + 0x100]
    mov ebx, DWORD PTR [rip + 0x100]
    mov esi, DWORD PTR [rip + 0x100]
    mov edi, DWORD PTR [rax]

// === MOV r64, m64 ===
    mov r8, QWORD PTR [rip + 0x100]
    mov rsi, QWORD PTR [rax]
    mov rsi, QWORD PTR [rip + 0x100]
    mov r8, QWORD PTR [rbx]
    mov r13, QWORD PTR [rax + rbx*4 + 0x100]
    mov rdi, QWORD PTR [rip + 0x1000]
    mov rax, QWORD PTR [rip + 0x100]
    mov r13, QWORD PTR [rip + 0x100]
    mov rcx, QWORD PTR [rip + 0x100]
    mov rax, QWORD PTR [rbx]

// === MOV r16, Sreg ===
    mov ax, cs
    mov si, fs
    mov ax, gs
    mov di, cs
    mov dx, fs
    mov cx, ss
    mov si, es
    mov dx, ds
    mov cx, es
    mov bx, gs

// === MOV m16, Sreg ===
    mov WORD PTR [rax], ss
    mov WORD PTR [rax], gs
    mov WORD PTR [rax], es
    mov WORD PTR [rbx], gs
    mov WORD PTR [rip + 0x100], es
    mov WORD PTR [rax + rbx*4 + 0x100], es
    mov WORD PTR [rax], ds
    mov WORD PTR [rax + rbx*4 + 0x100], gs
    mov WORD PTR [rax + rbx*4 + 0x100], ds
    mov WORD PTR [rax + rbx*1 + 0x10], es

// === MOV r16/r32/m16, Sreg ===
    mov WORD PTR [rip + 0x100], cs
    mov WORD PTR [rax + rbx*1 + 0x10], ds
    mov WORD PTR [rax], ds
    mov WORD PTR [rbx], ss
    mov WORD PTR [rax + rbx*1 + 0x10], es
    mov WORD PTR [rip + 0x100], gs
    mov WORD PTR [rip + 0x100], ds
    mov WORD PTR [rax + rbx*4 + 0x100], es
    mov WORD PTR [rax + rbx*4 + 0x100], ss
    mov WORD PTR [rip + 0x1000], fs

// === MOV r64/m16, Sreg ===
    mov WORD PTR [rbx], ss
    mov WORD PTR [rax], fs
    mov WORD PTR [rip + 0x1000], fs
    mov WORD PTR [rip + 0x100], es
    mov WORD PTR [rax + rbx*1 + 0x10], es
    mov WORD PTR [rax + rbx*4 + 0x100], fs
    mov WORD PTR [rax], es
    mov WORD PTR [rip + 0x100], fs
    mov WORD PTR [rip + 0x100], gs
    mov WORD PTR [rax + rbx*4 + 0x100], ds

// === MOV Sreg, r16 ===
    mov gs, ax
    mov ds, si
    mov fs, cx
    mov cs, si
    mov ds, ax
    mov gs, cx
    mov ss, si
    mov ss, ax
    mov es, si
    mov gs, dx

// === MOV Sreg, m16 ===
    mov ds, WORD PTR [rax]
    mov gs, WORD PTR [rip + 0x100]
    mov fs, WORD PTR [rip + 0x1000]
    mov cs, WORD PTR [rip + 0x1000]
    mov gs, WORD PTR [rax + rbx*4 + 0x100]
    mov gs, WORD PTR [rip + 0x1000]
    mov ds, WORD PTR [rbx]
    mov es, WORD PTR [rax]
    mov ss, WORD PTR [rax]
    mov gs, WORD PTR [rax + rbx*1 + 0x10]

// === MOV Sreg, r64 ===
    mov gs, r8
    mov cs, rdi
    mov ss, rax
    mov es, rdi
    mov gs, rbx
    mov es, r12
    mov fs, r11
    mov ss, r12
    mov cs, rcx
    mov ds, rdi

// === MOV Sreg, m64 ===
    mov cs, WORD PTR [rax + rbx*1 + 0x10]
    mov fs, WORD PTR [rax + rbx*1 + 0x10]
    mov ds, WORD PTR [rip + 0x100]
    mov cs, WORD PTR [rip + 0x100]
    mov gs, WORD PTR [rip + 0x1000]
    mov gs, WORD PTR [rax + rbx*1 + 0x10]
    mov gs, WORD PTR [rax]
    mov ss, WORD PTR [rax]
    mov es, WORD PTR [rax]
    mov fs, WORD PTR [rip + 0x100]

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
    mov al, 0xff
    mov cl, 0xff
    mov bl, 0xff
    mov dl, 0xff

// === MOV r16, imm16 ===
    mov bx, 0xffff
    mov si, 0xffff
    mov dx, 0xffff
    mov cx, 0xffff
    mov ax, 0xffff
    mov di, 0xffff

// === MOV r32, imm32 ===
    mov edi, 0xffffffff
    mov ebx, 0xffffffff
    mov ecx, 0xffffffff
    mov eax, 0xffffffff
    mov esi, 0xffffffff
    mov edx, 0xffffffff

// === MOV r64, imm64 ===
    mov rdx, 0x7fffffffffffffff
    mov rcx, 0x7fffffffffffffff
    mov rsi, 0x7fffffffffffffff
    mov rbx, 0x7fffffffffffffff
    mov r13, 0x7fffffffffffffff
    mov r9, 0x7fffffffffffffff
    mov r12, 0x7fffffffffffffff
    mov r11, 0x7fffffffffffffff
    mov rax, 0x7fffffffffffffff
    mov r10, 0x7fffffffffffffff

// === MOV m8, imm8 ===
    mov BYTE PTR [rax + rbx*1 + 0x10], 0xff
    mov BYTE PTR [rbx], 0xff
    mov BYTE PTR [rip + 0x1000], 0xff
    mov BYTE PTR [rax + rbx*4 + 0x100], 0xff
    mov BYTE PTR [rip + 0x100], 0xff
    mov BYTE PTR [rax], 0xff

// === MOV m16, imm16 ===
    mov WORD PTR [rip + 0x1000], 0xffff
    mov WORD PTR [rax + rbx*4 + 0x100], 0xffff
    mov WORD PTR [rax], 0xffff
    mov WORD PTR [rbx], 0xffff
    mov WORD PTR [rax + rbx*1 + 0x10], 0xffff
    mov WORD PTR [rip + 0x100], 0xffff

// === MOV m32, imm32 ===
    mov DWORD PTR [rip + 0x1000], 0xffffffff
    mov DWORD PTR [rax], 0xffffffff
    mov DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    mov DWORD PTR [rbx], 0xffffffff
    mov DWORD PTR [rip + 0x100], 0xffffffff
    mov DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === MOV r64, imm32 ===
    mov r13, 0x7fffffff
    mov r8, 0x7fffffff
    mov r8, -1
    mov rsi, 0x7fffffff
    mov rdx, 0x7fffffff
    mov r9, -1
    mov rdi, -1
    mov r13, -1
    mov r12, 0x7fffffff
    mov rdx, -1

// === MOV m64, imm32 ===
    mov QWORD PTR [rax], 0x7fffffff
    mov QWORD PTR [rax], -1
    mov QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    mov QWORD PTR [rip + 0x100], -1
    mov QWORD PTR [rax + rbx*1 + 0x10], -1
    mov QWORD PTR [rbx], 0x7fffffff
    mov QWORD PTR [rip + 0x1000], 0x7fffffff
    mov QWORD PTR [rip + 0x1000], -1
    mov QWORD PTR [rip + 0x100], 0x7fffffff
    mov QWORD PTR [rbx], -1

// === MOVDQ2Q mm, xmm ===
    movdq2q mm3, xmm0
    movdq2q mm2, xmm2
    movdq2q mm3, xmm3
    movdq2q mm3, xmm1
    movdq2q mm2, xmm3
    movdq2q mm1, xmm1
    movdq2q mm0, xmm1
    movdq2q mm0, xmm2
    movdq2q mm1, xmm3
    movdq2q mm1, xmm0

// === MOVNTQ m64, mm ===
    movntq QWORD PTR [rbx], mm2
    movntq QWORD PTR [rax + rbx*4 + 0x100], mm1
    movntq QWORD PTR [rbx], mm1
    movntq QWORD PTR [rax], mm1
    movntq QWORD PTR [rbx], mm3
    movntq QWORD PTR [rip + 0x100], mm0
    movntq QWORD PTR [rax], mm3
    movntq QWORD PTR [rip + 0x1000], mm0
    movntq QWORD PTR [rax + rbx*1 + 0x10], mm2
    movntq QWORD PTR [rip + 0x1000], mm3

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
    movsx si, al
    movsx dx, dl
    movsx dx, bl
    movsx di, al
    movsx bx, al
    movsx di, cl
    movsx cx, bl
    movsx bx, cl
    movsx ax, cl
    movsx cx, al

// === MOVSX r16, m8 ===
    movsx dx, BYTE PTR [rax + rbx*1 + 0x10]
    movsx dx, BYTE PTR [rbx]
    movsx di, BYTE PTR [rax]
    movsx di, BYTE PTR [rip + 0x1000]
    movsx si, BYTE PTR [rax + rbx*1 + 0x10]
    movsx si, BYTE PTR [rax + rbx*4 + 0x100]
    movsx dx, BYTE PTR [rax]
    movsx bx, BYTE PTR [rip + 0x1000]
    movsx bx, BYTE PTR [rax]
    movsx di, BYTE PTR [rax + rbx*1 + 0x10]

// === MOVSX r32, r8 ===
    movsx edx, al
    movsx ecx, al
    movsx esi, dl
    movsx esi, cl
    movsx ebx, bl
    movsx ebx, dl
    movsx eax, cl
    movsx ecx, dl
    movsx edx, cl
    movsx edi, cl

// === MOVSX r32, m8 ===
    movsx esi, BYTE PTR [rax + rbx*1 + 0x10]
    movsx edx, BYTE PTR [rbx]
    movsx eax, BYTE PTR [rbx]
    movsx ecx, BYTE PTR [rax + rbx*4 + 0x100]
    movsx ebx, BYTE PTR [rbx]
    movsx ecx, BYTE PTR [rax]
    movsx ecx, BYTE PTR [rbx]
    movsx ebx, BYTE PTR [rip + 0x100]
    movsx esi, BYTE PTR [rip + 0x1000]
    movsx eax, BYTE PTR [rip + 0x1000]

// === MOVSX r64, r8 ===
    movsx rcx, bl
    movsx rdi, cl
    movsx r8, bl
    movsx rdi, al
    movsx r11, cl
    movsx r9, cl
    movsx rax, al
    movsx rbx, bl
    movsx rdx, al
    movsx r9, bl

// === MOVSX r64, m8 ===
    movsx rcx, BYTE PTR [rip + 0x1000]
    movsx rcx, BYTE PTR [rax]
    movsx rbx, BYTE PTR [rax]
    movsx r12, BYTE PTR [rip + 0x1000]
    movsx rdx, BYTE PTR [rbx]
    movsx r10, BYTE PTR [rbx]
    movsx rdx, BYTE PTR [rip + 0x100]
    movsx r9, BYTE PTR [rax + rbx*1 + 0x10]
    movsx r9, BYTE PTR [rbx]
    movsx r13, BYTE PTR [rip + 0x100]

// === MOVSX r32, r16 ===
    movsx ecx, dx
    movsx edi, cx
    movsx edx, di
    movsx esi, di
    movsx edi, ax
    movsx ebx, di
    movsx eax, dx
    movsx ebx, ax
    movsx edx, ax
    movsx eax, bx

// === MOVSX r32, m16 ===
    movsx esi, WORD PTR [rbx]
    movsx ecx, WORD PTR [rip + 0x100]
    movsx edx, WORD PTR [rip + 0x1000]
    movsx eax, WORD PTR [rax + rbx*4 + 0x100]
    movsx edi, WORD PTR [rip + 0x1000]
    movsx edi, WORD PTR [rax + rbx*1 + 0x10]
    movsx edi, WORD PTR [rip + 0x100]
    movsx ebx, WORD PTR [rax]
    movsx ebx, WORD PTR [rbx]
    movsx esi, WORD PTR [rax]

// === MOVSX r64, r16 ===
    movsx rcx, cx
    movsx r13, si
    movsx r9, si
    movsx rbx, di
    movsx r12, ax
    movsx rcx, dx
    movsx rax, dx
    movsx rcx, bx
    movsx r8, ax
    movsx r12, dx

// === MOVSX r64, m16 ===
    movsx r13, WORD PTR [rax]
    movsx rsi, WORD PTR [rip + 0x1000]
    movsx rcx, WORD PTR [rax + rbx*1 + 0x10]
    movsx rdi, WORD PTR [rip + 0x100]
    movsx r8, WORD PTR [rax + rbx*1 + 0x10]
    movsx rbx, WORD PTR [rax + rbx*1 + 0x10]
    movsx rdi, WORD PTR [rip + 0x1000]
    movsx r10, WORD PTR [rbx]
    movsx rdx, WORD PTR [rax]
    movsx rdx, WORD PTR [rip + 0x1000]

// === MOVSXD r64, r32 ===
    movsxd r10, ecx
    movsxd rcx, esi
    movsxd r9, ebx
    movsxd rdx, ebx
    movsxd rax, edx
    movsxd r9, ecx
    movsxd rdx, ecx
    movsxd r8, ecx
    movsxd rax, ebx
    movsxd rdx, eax

// === MOVSXD r64, m32 ===
    movsxd rdi, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd r12, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd r13, DWORD PTR [rax]
    movsxd rcx, DWORD PTR [rax]
    movsxd rcx, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd rcx, DWORD PTR [rip + 0x100]
    movsxd rdx, DWORD PTR [rax + rbx*1 + 0x10]
    movsxd r12, DWORD PTR [rip + 0x100]
    movsxd r8, DWORD PTR [rax]
    movsxd rax, DWORD PTR [rip + 0x1000]

// === MOVZX r16, r8 ===
    movzx dx, al
    movzx di, al
    movzx cx, al
    movzx bx, cl
    movzx dx, bl
    movzx cx, bl
    movzx si, al
    movzx ax, al
    movzx di, cl
    movzx bx, al

// === MOVZX r16, m8 ===
    movzx dx, BYTE PTR [rax + rbx*4 + 0x100]
    movzx di, BYTE PTR [rax + rbx*1 + 0x10]
    movzx di, BYTE PTR [rip + 0x1000]
    movzx si, BYTE PTR [rax]
    movzx dx, BYTE PTR [rbx]
    movzx ax, BYTE PTR [rax + rbx*4 + 0x100]
    movzx ax, BYTE PTR [rip + 0x100]
    movzx di, BYTE PTR [rip + 0x100]
    movzx cx, BYTE PTR [rax]
    movzx cx, BYTE PTR [rbx]

// === MOVZX r32, r8 ===
    movzx edi, al
    movzx edx, dl
    movzx edi, dl
    movzx ecx, bl
    movzx edi, bl
    movzx ecx, dl
    movzx ecx, al
    movzx eax, bl
    movzx ebx, al
    movzx edx, cl

// === MOVZX r32, m8 ===
    movzx esi, BYTE PTR [rax + rbx*4 + 0x100]
    movzx ebx, BYTE PTR [rax + rbx*4 + 0x100]
    movzx esi, BYTE PTR [rax + rbx*1 + 0x10]
    movzx ecx, BYTE PTR [rip + 0x1000]
    movzx esi, BYTE PTR [rbx]
    movzx eax, BYTE PTR [rax + rbx*1 + 0x10]
    movzx eax, BYTE PTR [rip + 0x1000]
    movzx edx, BYTE PTR [rip + 0x1000]
    movzx ecx, BYTE PTR [rip + 0x100]
    movzx edx, BYTE PTR [rax]

// === MOVZX r64, r8 ===
    movzx rax, cl
    movzx r9, al
    movzx rsi, cl
    movzx r12, bl
    movzx r12, dl
    movzx rbx, al
    movzx r9, bl
    movzx rsi, dl
    movzx rax, al
    movzx rdx, bl

// === MOVZX r64, m8 ===
    movzx rbx, BYTE PTR [rax + rbx*4 + 0x100]
    movzx rax, BYTE PTR [rax + rbx*4 + 0x100]
    movzx rdi, BYTE PTR [rip + 0x100]
    movzx r11, BYTE PTR [rax]
    movzx rbx, BYTE PTR [rax]
    movzx rax, BYTE PTR [rip + 0x1000]
    movzx r13, BYTE PTR [rax]
    movzx rbx, BYTE PTR [rbx]
    movzx r13, BYTE PTR [rip + 0x100]
    movzx rdx, BYTE PTR [rip + 0x1000]

// === MOVZX r32, r16 ===
    movzx edx, ax
    movzx ebx, cx
    movzx edi, dx
    movzx ebx, ax
    movzx ebx, di
    movzx esi, bx
    movzx ecx, dx
    movzx eax, cx
    movzx esi, si
    movzx edi, cx

// === MOVZX r32, m16 ===
    movzx eax, WORD PTR [rax]
    movzx ecx, WORD PTR [rax + rbx*1 + 0x10]
    movzx eax, WORD PTR [rbx]
    movzx eax, WORD PTR [rax + rbx*4 + 0x100]
    movzx ecx, WORD PTR [rip + 0x100]
    movzx edi, WORD PTR [rax + rbx*4 + 0x100]
    movzx eax, WORD PTR [rax + rbx*1 + 0x10]
    movzx ebx, WORD PTR [rbx]
    movzx edi, WORD PTR [rbx]
    movzx ebx, WORD PTR [rax + rbx*4 + 0x100]

// === MOVZX r64, r16 ===
    movzx rbx, di
    movzx rdx, bx
    movzx rax, si
    movzx rax, cx
    movzx r8, dx
    movzx r13, ax
    movzx rcx, si
    movzx r8, bx
    movzx rbx, ax
    movzx rdi, dx

// === MOVZX r64, m16 ===
    movzx r11, WORD PTR [rax + rbx*4 + 0x100]
    movzx rbx, WORD PTR [rip + 0x1000]
    movzx r9, WORD PTR [rip + 0x1000]
    movzx rbx, WORD PTR [rax + rbx*4 + 0x100]
    movzx rcx, WORD PTR [rax + rbx*4 + 0x100]
    movzx r9, WORD PTR [rip + 0x100]
    movzx rcx, WORD PTR [rax]
    movzx rsi, WORD PTR [rax + rbx*1 + 0x10]
    movzx r12, WORD PTR [rax + rbx*4 + 0x100]
    movzx rsi, WORD PTR [rip + 0x1000]

// === MUL r8 ===
    mul bl
    mul dl
    mul al
    mul cl

// === MUL m8 ===
    mul BYTE PTR [rax + rbx*1 + 0x10]
    mul BYTE PTR [rbx]
    mul BYTE PTR [rax + rbx*4 + 0x100]
    mul BYTE PTR [rax]
    mul BYTE PTR [rip + 0x100]
    mul BYTE PTR [rip + 0x1000]

// === MUL r16 ===
    mul di
    mul ax
    mul cx
    mul si
    mul dx
    mul bx

// === MUL m16 ===
    mul WORD PTR [rax + rbx*4 + 0x100]
    mul WORD PTR [rip + 0x1000]
    mul WORD PTR [rbx]
    mul WORD PTR [rax]
    mul WORD PTR [rax + rbx*1 + 0x10]
    mul WORD PTR [rip + 0x100]

// === MUL r32 ===
    mul ecx
    mul ebx
    mul esi
    mul eax
    mul edx
    mul edi

// === MUL m32 ===
    mul DWORD PTR [rax + rbx*4 + 0x100]
    mul DWORD PTR [rax + rbx*1 + 0x10]
    mul DWORD PTR [rax]
    mul DWORD PTR [rbx]
    mul DWORD PTR [rip + 0x1000]
    mul DWORD PTR [rip + 0x100]

// === MUL r64 ===
    mul r10
    mul rsi
    mul r11
    mul rdx
    mul rbx
    mul rdi
    mul r9
    mul rax
    mul r12
    mul r13

// === MUL m64 ===
    mul QWORD PTR [rbx]
    mul QWORD PTR [rax + rbx*1 + 0x10]
    mul QWORD PTR [rax + rbx*4 + 0x100]
    mul QWORD PTR [rip + 0x100]
    mul QWORD PTR [rip + 0x1000]
    mul QWORD PTR [rax]

// === MWAIT ===
    mwait

// === NEG r8 ===
    neg bl
    neg dl
    neg cl
    neg al

// === NEG m8 ===
    neg BYTE PTR [rax + rbx*1 + 0x10]
    neg BYTE PTR [rbx]
    neg BYTE PTR [rax + rbx*4 + 0x100]
    neg BYTE PTR [rax]
    neg BYTE PTR [rip + 0x100]
    neg BYTE PTR [rip + 0x1000]

// === NEG r16 ===
    neg bx
    neg di
    neg cx
    neg dx
    neg si
    neg ax

// === NEG m16 ===
    neg WORD PTR [rax + rbx*1 + 0x10]
    neg WORD PTR [rax]
    neg WORD PTR [rip + 0x1000]
    neg WORD PTR [rbx]
    neg WORD PTR [rip + 0x100]
    neg WORD PTR [rax + rbx*4 + 0x100]

// === NEG r32 ===
    neg esi
    neg eax
    neg ecx
    neg ebx
    neg edx
    neg edi

// === NEG m32 ===
    neg DWORD PTR [rax + rbx*1 + 0x10]
    neg DWORD PTR [rip + 0x1000]
    neg DWORD PTR [rbx]
    neg DWORD PTR [rax + rbx*4 + 0x100]
    neg DWORD PTR [rax]
    neg DWORD PTR [rip + 0x100]

// === NEG r64 ===
    neg rax
    neg r9
    neg r13
    neg rbx
    neg r12
    neg rcx
    neg r10
    neg rdx
    neg rsi
    neg rdi

// === NEG m64 ===
    neg QWORD PTR [rax + rbx*1 + 0x10]
    neg QWORD PTR [rip + 0x100]
    neg QWORD PTR [rax + rbx*4 + 0x100]
    neg QWORD PTR [rax]
    neg QWORD PTR [rip + 0x1000]
    neg QWORD PTR [rbx]

// === NOP ===
    nop

// === NOP r16 ===
    nop dx
    nop ax
    nop bx
    nop cx
    nop di
    nop si

// === NOP m16 ===
    nop WORD PTR [rbx]
    nop WORD PTR [rax]
    nop WORD PTR [rax + rbx*4 + 0x100]
    nop WORD PTR [rip + 0x100]
    nop WORD PTR [rip + 0x1000]
    nop WORD PTR [rax + rbx*1 + 0x10]

// === NOP r32 ===
    nop ebx
    nop edx
    nop ecx
    nop eax
    nop edi
    nop esi

// === NOP m32 ===
    nop DWORD PTR [rax]
    nop DWORD PTR [rip + 0x100]
    nop DWORD PTR [rax + rbx*1 + 0x10]
    nop DWORD PTR [rbx]
    nop DWORD PTR [rax + rbx*4 + 0x100]
    nop DWORD PTR [rip + 0x1000]

// === NOT r8 ===
    not bl
    not dl
    not al
    not cl

// === NOT m8 ===
    not BYTE PTR [rax]
    not BYTE PTR [rip + 0x1000]
    not BYTE PTR [rax + rbx*4 + 0x100]
    not BYTE PTR [rbx]
    not BYTE PTR [rax + rbx*1 + 0x10]
    not BYTE PTR [rip + 0x100]

// === NOT r16 ===
    not dx
    not si
    not cx
    not ax
    not bx
    not di

// === NOT m16 ===
    not WORD PTR [rbx]
    not WORD PTR [rip + 0x100]
    not WORD PTR [rax]
    not WORD PTR [rax + rbx*4 + 0x100]
    not WORD PTR [rip + 0x1000]
    not WORD PTR [rax + rbx*1 + 0x10]

// === NOT r32 ===
    not esi
    not eax
    not edi
    not edx
    not ecx
    not ebx

// === NOT m32 ===
    not DWORD PTR [rip + 0x1000]
    not DWORD PTR [rax + rbx*4 + 0x100]
    not DWORD PTR [rax + rbx*1 + 0x10]
    not DWORD PTR [rip + 0x100]
    not DWORD PTR [rbx]
    not DWORD PTR [rax]

// === NOT r64 ===
    not rdi
    not r12
    not rdx
    not r9
    not r13
    not r10
    not rcx
    not r11
    not rbx
    not rax

// === NOT m64 ===
    not QWORD PTR [rax + rbx*4 + 0x100]
    not QWORD PTR [rip + 0x1000]
    not QWORD PTR [rax]
    not QWORD PTR [rbx]
    not QWORD PTR [rip + 0x100]
    not QWORD PTR [rax + rbx*1 + 0x10]

// === OR AL, imm8 ===
    or al, 0xff

// === OR AX, imm16 ===
    or ax, 0xffff

// === OR EAX, imm32 ===
    or eax, 0xffffffff

// === OR RAX, imm32 ===
    or rax, -1
    or rax, 0x7fffffff

// === OR r8, imm8 ===
    or cl, 0xff
    or bl, 0xff
    or dl, 0xff
    or al, 0xff

// === OR m8, imm8 ===
    or BYTE PTR [rip + 0x100], 0xff
    or BYTE PTR [rax + rbx*4 + 0x100], 0xff
    or BYTE PTR [rax + rbx*1 + 0x10], 0xff
    or BYTE PTR [rip + 0x1000], 0xff
    or BYTE PTR [rax], 0xff
    or BYTE PTR [rbx], 0xff

// === OR r16, imm16 ===
    or dx, 0xffff
    or ax, 0xffff
    or cx, 0xffff
    or bx, 0xffff
    or si, 0xffff
    or di, 0xffff

// === OR m16, imm16 ===
    or WORD PTR [rbx], 0xffff
    or WORD PTR [rip + 0x100], 0xffff
    or WORD PTR [rip + 0x1000], 0xffff
    or WORD PTR [rax], 0xffff
    or WORD PTR [rax + rbx*4 + 0x100], 0xffff
    or WORD PTR [rax + rbx*1 + 0x10], 0xffff

// === OR r32, imm32 ===
    or ecx, 0xffffffff
    or esi, 0xffffffff
    or eax, 0xffffffff
    or ebx, 0xffffffff
    or edx, 0xffffffff
    or edi, 0xffffffff

// === OR m32, imm32 ===
    or DWORD PTR [rax], 0xffffffff
    or DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    or DWORD PTR [rbx], 0xffffffff
    or DWORD PTR [rip + 0x1000], 0xffffffff
    or DWORD PTR [rip + 0x100], 0xffffffff
    or DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff

// === OR r64, imm32 ===
    or rdx, 0x7fffffff
    or rax, 0x7fffffff
    or r12, 0x7fffffff
    or r11, 0x7fffffff
    or r8, -1
    or rsi, 0x7fffffff
    or rbx, -1
    or r8, 0x7fffffff
    or r9, 0x7fffffff
    or r11, -1

// === OR m64, imm32 ===
    or QWORD PTR [rbx], 0x7fffffff
    or QWORD PTR [rip + 0x100], -1
    or QWORD PTR [rbx], -1
    or QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    or QWORD PTR [rax], -1
    or QWORD PTR [rip + 0x1000], 0x7fffffff
    or QWORD PTR [rax + rbx*4 + 0x100], -1
    or QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    or QWORD PTR [rip + 0x1000], -1
    or QWORD PTR [rax], 0x7fffffff

// === OR r16, imm8 ===
    or dx, 0xff
    or cx, 0xff
    or bx, 0xff
    or si, 0xff
    or di, 0xff
    or ax, 0xff

// === OR m16, imm8 ===
    or WORD PTR [rax + rbx*1 + 0x10], 0xff
    or WORD PTR [rax + rbx*4 + 0x100], 0xff
    or WORD PTR [rbx], 0xff
    or WORD PTR [rip + 0x100], 0xff
    or WORD PTR [rip + 0x1000], 0xff
    or WORD PTR [rax], 0xff

// === OR r32, imm8 ===
    or ebx, 0xff
    or eax, 0xff
    or edx, 0xff
    or edi, 0xff
    or esi, 0xff
    or ecx, 0xff

// === OR m32, imm8 ===
    or DWORD PTR [rax + rbx*1 + 0x10], 0xff
    or DWORD PTR [rax], 0xff
    or DWORD PTR [rax + rbx*4 + 0x100], 0xff
    or DWORD PTR [rip + 0x1000], 0xff
    or DWORD PTR [rbx], 0xff
    or DWORD PTR [rip + 0x100], 0xff

// === OR r64, imm8 ===
    or r12, 0xff
    or r10, 0xff
    or rdi, 0xff
    or r9, 0xff
    or rcx, 0xff
    or rbx, 0xff
    or rsi, 0xff
    or r8, 0xff
    or r13, 0xff
    or r11, 0xff

// === OR m64, imm8 ===
    or QWORD PTR [rax + rbx*1 + 0x10], 0xff
    or QWORD PTR [rax], 0xff
    or QWORD PTR [rax + rbx*4 + 0x100], 0xff
    or QWORD PTR [rip + 0x100], 0xff
    or QWORD PTR [rip + 0x1000], 0xff
    or QWORD PTR [rbx], 0xff

// === OR r8, r8 ===
    or dl, al
    or cl, bl
    or cl, al
    or bl, cl
    or al, al
    or bl, bl
    or cl, dl
    or dl, dl
    or dl, bl
    or al, cl

// === OR m8, r8 ===
    or BYTE PTR [rbx], cl
    or BYTE PTR [rax + rbx*4 + 0x100], bl
    or BYTE PTR [rax], cl
    or BYTE PTR [rax + rbx*4 + 0x100], al
    or BYTE PTR [rip + 0x1000], cl
    or BYTE PTR [rax], al
    or BYTE PTR [rbx], dl
    or BYTE PTR [rax + rbx*4 + 0x100], cl
    or BYTE PTR [rip + 0x100], bl
    or BYTE PTR [rip + 0x100], dl

// === OR r16, r16 ===
    or si, ax
    or bx, dx
    or ax, ax
    or ax, si
    or si, di
    or dx, bx
    or ax, di
    or di, si
    or si, cx
    or di, di

// === OR m16, r16 ===
    or WORD PTR [rip + 0x100], di
    or WORD PTR [rip + 0x100], cx
    or WORD PTR [rax], si
    or WORD PTR [rax + rbx*4 + 0x100], dx
    or WORD PTR [rax + rbx*4 + 0x100], cx
    or WORD PTR [rax + rbx*1 + 0x10], ax
    or WORD PTR [rbx], cx
    or WORD PTR [rip + 0x1000], si
    or WORD PTR [rip + 0x100], si
    or WORD PTR [rbx], dx

// === OR r32, r32 ===
    or edi, ebx
    or ebx, ebx
    or edx, edx
    or edx, edi
    or edi, esi
    or edi, edx
    or esi, esi
    or edx, ebx
    or eax, edi
    or esi, edi

// === OR m32, r32 ===
    or DWORD PTR [rax + rbx*1 + 0x10], edx
    or DWORD PTR [rax], edi
    or DWORD PTR [rax], eax
    or DWORD PTR [rax + rbx*4 + 0x100], edi
    or DWORD PTR [rax + rbx*1 + 0x10], eax
    or DWORD PTR [rip + 0x1000], edi
    or DWORD PTR [rip + 0x100], ebx
    or DWORD PTR [rax + rbx*1 + 0x10], edi
    or DWORD PTR [rax + rbx*4 + 0x100], ebx
    or DWORD PTR [rip + 0x1000], edx

// === OR r64, r64 ===
    or r11, r8
    or r9, r9
    or rsi, rdi
    or r8, rdi
    or r12, r10
    or r11, r11
    or r8, rax
    or rdx, r13
    or r12, rdx
    or rdi, r8

// === OR m64, r64 ===
    or QWORD PTR [rbx], rsi
    or QWORD PTR [rip + 0x100], rdx
    or QWORD PTR [rax + rbx*4 + 0x100], r11
    or QWORD PTR [rip + 0x1000], rdi
    or QWORD PTR [rbx], rdx
    or QWORD PTR [rbx], r8
    or QWORD PTR [rip + 0x100], r13
    or QWORD PTR [rip + 0x100], r9
    or QWORD PTR [rip + 0x1000], rbx
    or QWORD PTR [rax + rbx*4 + 0x100], rsi

// === OR r8, m8 ===
    or dl, BYTE PTR [rax]
    or cl, BYTE PTR [rbx]
    or dl, BYTE PTR [rax + rbx*4 + 0x100]
    or al, BYTE PTR [rax + rbx*4 + 0x100]
    or bl, BYTE PTR [rbx]
    or bl, BYTE PTR [rax + rbx*4 + 0x100]
    or al, BYTE PTR [rax + rbx*1 + 0x10]
    or bl, BYTE PTR [rax]
    or dl, BYTE PTR [rip + 0x100]
    or al, BYTE PTR [rip + 0x1000]

// === OR r16, m16 ===
    or bx, WORD PTR [rax + rbx*4 + 0x100]
    or cx, WORD PTR [rbx]
    or bx, WORD PTR [rip + 0x1000]
    or ax, WORD PTR [rip + 0x1000]
    or di, WORD PTR [rip + 0x100]
    or bx, WORD PTR [rax]
    or ax, WORD PTR [rax]
    or di, WORD PTR [rax + rbx*1 + 0x10]
    or dx, WORD PTR [rip + 0x100]
    or bx, WORD PTR [rbx]

// === OR r32, m32 ===
    or esi, DWORD PTR [rip + 0x100]
    or eax, DWORD PTR [rip + 0x1000]
    or esi, DWORD PTR [rip + 0x1000]
    or ecx, DWORD PTR [rax]
    or eax, DWORD PTR [rbx]
    or ecx, DWORD PTR [rbx]
    or eax, DWORD PTR [rax + rbx*4 + 0x100]
    or edi, DWORD PTR [rax + rbx*1 + 0x10]
    or edx, DWORD PTR [rax + rbx*1 + 0x10]
    or eax, DWORD PTR [rip + 0x100]

// === OR r64, m64 ===
    or r8, QWORD PTR [rip + 0x1000]
    or r10, QWORD PTR [rax + rbx*1 + 0x10]
    or rcx, QWORD PTR [rax + rbx*1 + 0x10]
    or r8, QWORD PTR [rbx]
    or r9, QWORD PTR [rip + 0x1000]
    or r11, QWORD PTR [rip + 0x100]
    or r9, QWORD PTR [rbx]
    or r10, QWORD PTR [rip + 0x100]
    or rax, QWORD PTR [rax + rbx*1 + 0x10]
    or rcx, QWORD PTR [rip + 0x100]

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
    pop si
    pop bx
    pop cx
    pop dx
    pop di
    pop ax

// === POP m16 ===
    pop WORD PTR [rip + 0x1000]
    pop WORD PTR [rax + rbx*4 + 0x100]
    pop WORD PTR [rip + 0x100]
    pop WORD PTR [rax + rbx*1 + 0x10]
    pop WORD PTR [rbx]
    pop WORD PTR [rax]

// === POP r64 ===
    pop rax
    pop rdi
    pop r11
    pop rsi
    pop rcx
    pop rbx
    pop r8
    pop r9
    pop r12
    pop r13

// === POP m64 ===
    pop QWORD PTR [rip + 0x100]
    pop QWORD PTR [rax + rbx*1 + 0x10]
    pop QWORD PTR [rbx]
    pop QWORD PTR [rax]
    pop QWORD PTR [rip + 0x1000]
    pop QWORD PTR [rax + rbx*4 + 0x100]

// === POP FS ===
    pop fs

// === POP GS ===
    pop gs

// === POPCNT r16, r16 ===
    popcnt bx, bx
    popcnt dx, cx
    popcnt dx, bx
    popcnt cx, bx
    popcnt bx, di
    popcnt di, si
    popcnt bx, si
    popcnt bx, cx
    popcnt si, cx
    popcnt di, bx

// === POPCNT r16, m16 ===
    popcnt si, WORD PTR [rax + rbx*4 + 0x100]
    popcnt dx, WORD PTR [rax]
    popcnt bx, WORD PTR [rbx]
    popcnt si, WORD PTR [rip + 0x100]
    popcnt ax, WORD PTR [rax + rbx*1 + 0x10]
    popcnt ax, WORD PTR [rbx]
    popcnt di, WORD PTR [rax + rbx*1 + 0x10]
    popcnt bx, WORD PTR [rip + 0x1000]
    popcnt di, WORD PTR [rbx]
    popcnt di, WORD PTR [rip + 0x100]

// === POPCNT r32, r32 ===
    popcnt ecx, ebx
    popcnt esi, esi
    popcnt edx, edx
    popcnt esi, ecx
    popcnt edi, ecx
    popcnt esi, edi
    popcnt eax, ebx
    popcnt ebx, ecx
    popcnt ebx, ebx
    popcnt edi, edx

// === POPCNT r32, m32 ===
    popcnt ecx, DWORD PTR [rax + rbx*4 + 0x100]
    popcnt eax, DWORD PTR [rax + rbx*4 + 0x100]
    popcnt edi, DWORD PTR [rax + rbx*4 + 0x100]
    popcnt ebx, DWORD PTR [rax]
    popcnt edi, DWORD PTR [rbx]
    popcnt ebx, DWORD PTR [rax + rbx*4 + 0x100]
    popcnt ebx, DWORD PTR [rbx]
    popcnt esi, DWORD PTR [rip + 0x1000]
    popcnt ecx, DWORD PTR [rip + 0x1000]
    popcnt edi, DWORD PTR [rax]

// === POPCNT r64, r64 ===
    popcnt r13, r10
    popcnt rcx, r8
    popcnt rax, rsi
    popcnt r12, r10
    popcnt rdi, r11
    popcnt r13, rbx
    popcnt r12, rdx
    popcnt rbx, rdx
    popcnt rax, rdx
    popcnt r10, r10

// === POPCNT r64, m64 ===
    popcnt r11, QWORD PTR [rip + 0x100]
    popcnt r8, QWORD PTR [rax + rbx*1 + 0x10]
    popcnt rdi, QWORD PTR [rip + 0x100]
    popcnt r11, QWORD PTR [rax + rbx*4 + 0x100]
    popcnt r8, QWORD PTR [rax + rbx*4 + 0x100]
    popcnt r11, QWORD PTR [rax]
    popcnt rax, QWORD PTR [rax + rbx*4 + 0x100]
    popcnt rcx, QWORD PTR [rax]
    popcnt rdx, QWORD PTR [rax + rbx*4 + 0x100]
    popcnt rsi, QWORD PTR [rax + rbx*4 + 0x100]

// === POPF ===
    popf

// === POPFQ ===
    popfq

// === PUSH r16 ===
    push ax
    push si
    push di
    push dx
    push bx
    push cx

// === PUSH m16 ===
    push WORD PTR [rax + rbx*4 + 0x100]
    push WORD PTR [rip + 0x100]
    push WORD PTR [rip + 0x1000]
    push WORD PTR [rax]
    push WORD PTR [rax + rbx*1 + 0x10]
    push WORD PTR [rbx]

// === PUSH r64 ===
    push rdx
    push rbx
    push r13
    push r8
    push rsi
    push rdi
    push r10
    push r12
    push r9
    push r11

// === PUSH m64 ===
    push QWORD PTR [rip + 0x100]
    push QWORD PTR [rbx]
    push QWORD PTR [rax + rbx*1 + 0x10]
    push QWORD PTR [rax]
    push QWORD PTR [rax + rbx*4 + 0x100]
    push QWORD PTR [rip + 0x1000]

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
    rcl dl, 1
    rcl bl, 1
    rcl al, 1
    rcl cl, 1

// === RCL m8, 1 ===
    rcl BYTE PTR [rip + 0x1000], 1
    rcl BYTE PTR [rip + 0x100], 1
    rcl BYTE PTR [rbx], 1
    rcl BYTE PTR [rax], 1
    rcl BYTE PTR [rax + rbx*4 + 0x100], 1
    rcl BYTE PTR [rax + rbx*1 + 0x10], 1

// === RCL r8, CL ===
    rcl al, cl
    rcl dl, cl
    rcl bl, cl
    rcl cl, cl

// === RCL m8, CL ===
    rcl BYTE PTR [rax + rbx*1 + 0x10], cl
    rcl BYTE PTR [rbx], cl
    rcl BYTE PTR [rip + 0x1000], cl
    rcl BYTE PTR [rip + 0x100], cl
    rcl BYTE PTR [rax + rbx*4 + 0x100], cl
    rcl BYTE PTR [rax], cl

// === RCL r8, imm8 ===
    rcl cl, 0xff
    rcl bl, 0xff
    rcl al, 0xff
    rcl dl, 0xff

// === RCL m8, imm8 ===
    rcl BYTE PTR [rax + rbx*1 + 0x10], 0xff
    rcl BYTE PTR [rax], 0xff
    rcl BYTE PTR [rbx], 0xff
    rcl BYTE PTR [rax + rbx*4 + 0x100], 0xff
    rcl BYTE PTR [rip + 0x1000], 0xff
    rcl BYTE PTR [rip + 0x100], 0xff

// === RCL r16, 1 ===
    rcl dx, 1
    rcl ax, 1
    rcl si, 1
    rcl bx, 1
    rcl di, 1
    rcl cx, 1

// === RCL m16, 1 ===
    rcl WORD PTR [rax + rbx*1 + 0x10], 1
    rcl WORD PTR [rax], 1
    rcl WORD PTR [rbx], 1
    rcl WORD PTR [rip + 0x1000], 1
    rcl WORD PTR [rax + rbx*4 + 0x100], 1
    rcl WORD PTR [rip + 0x100], 1

// === RCL r16, CL ===
    rcl cx, cl
    rcl ax, cl
    rcl bx, cl
    rcl di, cl
    rcl si, cl
    rcl dx, cl

// === RCL m16, CL ===
    rcl WORD PTR [rip + 0x1000], cl
    rcl WORD PTR [rax + rbx*1 + 0x10], cl
    rcl WORD PTR [rip + 0x100], cl
    rcl WORD PTR [rax + rbx*4 + 0x100], cl
    rcl WORD PTR [rbx], cl
    rcl WORD PTR [rax], cl

// === RCL r16, imm8 ===
    rcl di, 0xff
    rcl cx, 0xff
    rcl bx, 0xff
    rcl si, 0xff
    rcl dx, 0xff
    rcl ax, 0xff

// === RCL m16, imm8 ===
    rcl WORD PTR [rbx], 0xff
    rcl WORD PTR [rax + rbx*4 + 0x100], 0xff
    rcl WORD PTR [rax + rbx*1 + 0x10], 0xff
    rcl WORD PTR [rip + 0x100], 0xff
    rcl WORD PTR [rax], 0xff
    rcl WORD PTR [rip + 0x1000], 0xff

// === RCL r32, 1 ===
    rcl eax, 1
    rcl esi, 1
    rcl ebx, 1
    rcl edi, 1
    rcl ecx, 1
    rcl edx, 1

// === RCL m32, 1 ===
    rcl DWORD PTR [rip + 0x100], 1
    rcl DWORD PTR [rax], 1
    rcl DWORD PTR [rbx], 1
    rcl DWORD PTR [rax + rbx*4 + 0x100], 1
    rcl DWORD PTR [rip + 0x1000], 1
    rcl DWORD PTR [rax + rbx*1 + 0x10], 1

// === RCL r64, 1 ===
    rcl rdi, 1
    rcl rcx, 1
    rcl r10, 1
    rcl r8, 1
    rcl rbx, 1
    rcl r12, 1
    rcl rsi, 1
    rcl r13, 1
    rcl r9, 1
    rcl r11, 1

// === RCL m64, 1 ===
    rcl QWORD PTR [rip + 0x100], 1
    rcl QWORD PTR [rax + rbx*1 + 0x10], 1
    rcl QWORD PTR [rax], 1
    rcl QWORD PTR [rbx], 1
    rcl QWORD PTR [rax + rbx*4 + 0x100], 1
    rcl QWORD PTR [rip + 0x1000], 1

// === RCL r32, CL ===
    rcl edx, cl
    rcl esi, cl
    rcl ecx, cl
    rcl eax, cl
    rcl ebx, cl
    rcl edi, cl

// === RCL m32, CL ===
    rcl DWORD PTR [rax], cl
    rcl DWORD PTR [rip + 0x1000], cl
    rcl DWORD PTR [rax + rbx*4 + 0x100], cl
    rcl DWORD PTR [rbx], cl
    rcl DWORD PTR [rax + rbx*1 + 0x10], cl
    rcl DWORD PTR [rip + 0x100], cl

// === RCL r64, CL ===
    rcl r10, cl
    rcl rax, cl
    rcl rdi, cl
    rcl r13, cl
    rcl r11, cl
    rcl rdx, cl
    rcl rbx, cl
    rcl rcx, cl
    rcl r9, cl
    rcl r12, cl

// === RCL m64, CL ===
    rcl QWORD PTR [rip + 0x100], cl
    rcl QWORD PTR [rip + 0x1000], cl
    rcl QWORD PTR [rax + rbx*1 + 0x10], cl
    rcl QWORD PTR [rax], cl
    rcl QWORD PTR [rbx], cl
    rcl QWORD PTR [rax + rbx*4 + 0x100], cl

// === RCL r32, imm8 ===
    rcl ecx, 0xff
    rcl esi, 0xff
    rcl ebx, 0xff
    rcl eax, 0xff
    rcl edx, 0xff
    rcl edi, 0xff

// === RCL m32, imm8 ===
    rcl DWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcl DWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcl DWORD PTR [rbx], 0xff
    rcl DWORD PTR [rip + 0x100], 0xff
    rcl DWORD PTR [rax], 0xff
    rcl DWORD PTR [rip + 0x1000], 0xff

// === RCL r64, imm8 ===
    rcl r11, 0xff
    rcl r9, 0xff
    rcl rdi, 0xff
    rcl rdx, 0xff
    rcl r10, 0xff
    rcl rax, 0xff
    rcl rcx, 0xff
    rcl r12, 0xff
    rcl rbx, 0xff
    rcl r8, 0xff

// === RCL m64, imm8 ===
    rcl QWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcl QWORD PTR [rip + 0x100], 0xff
    rcl QWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcl QWORD PTR [rip + 0x1000], 0xff
    rcl QWORD PTR [rax], 0xff
    rcl QWORD PTR [rbx], 0xff

// === RCR r8, 1 ===
    rcr dl, 1
    rcr cl, 1
    rcr al, 1
    rcr bl, 1

// === RCR m8, 1 ===
    rcr BYTE PTR [rip + 0x1000], 1
    rcr BYTE PTR [rbx], 1
    rcr BYTE PTR [rax + rbx*4 + 0x100], 1
    rcr BYTE PTR [rip + 0x100], 1
    rcr BYTE PTR [rax + rbx*1 + 0x10], 1
    rcr BYTE PTR [rax], 1

// === RCR r8, CL ===
    rcr dl, cl
    rcr al, cl
    rcr cl, cl
    rcr bl, cl

// === RCR m8, CL ===
    rcr BYTE PTR [rax], cl
    rcr BYTE PTR [rax + rbx*1 + 0x10], cl
    rcr BYTE PTR [rax + rbx*4 + 0x100], cl
    rcr BYTE PTR [rbx], cl
    rcr BYTE PTR [rip + 0x100], cl
    rcr BYTE PTR [rip + 0x1000], cl

// === RCR r8, imm8 ===
    rcr dl, 0xff
    rcr al, 0xff
    rcr bl, 0xff
    rcr cl, 0xff

// === RCR m8, imm8 ===
    rcr BYTE PTR [rbx], 0xff
    rcr BYTE PTR [rax], 0xff
    rcr BYTE PTR [rip + 0x100], 0xff
    rcr BYTE PTR [rip + 0x1000], 0xff
    rcr BYTE PTR [rax + rbx*4 + 0x100], 0xff
    rcr BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === RCR r16, 1 ===
    rcr di, 1
    rcr dx, 1
    rcr si, 1
    rcr ax, 1
    rcr cx, 1
    rcr bx, 1

// === RCR m16, 1 ===
    rcr WORD PTR [rax + rbx*4 + 0x100], 1
    rcr WORD PTR [rax], 1
    rcr WORD PTR [rax + rbx*1 + 0x10], 1
    rcr WORD PTR [rbx], 1
    rcr WORD PTR [rip + 0x100], 1
    rcr WORD PTR [rip + 0x1000], 1

// === RCR r16, CL ===
    rcr dx, cl
    rcr di, cl
    rcr si, cl
    rcr bx, cl
    rcr cx, cl
    rcr ax, cl

// === RCR m16, CL ===
    rcr WORD PTR [rax + rbx*4 + 0x100], cl
    rcr WORD PTR [rbx], cl
    rcr WORD PTR [rip + 0x1000], cl
    rcr WORD PTR [rip + 0x100], cl
    rcr WORD PTR [rax + rbx*1 + 0x10], cl
    rcr WORD PTR [rax], cl

// === RCR r16, imm8 ===
    rcr di, 0xff
    rcr cx, 0xff
    rcr bx, 0xff
    rcr si, 0xff
    rcr ax, 0xff
    rcr dx, 0xff

// === RCR m16, imm8 ===
    rcr WORD PTR [rip + 0x1000], 0xff
    rcr WORD PTR [rip + 0x100], 0xff
    rcr WORD PTR [rax + rbx*1 + 0x10], 0xff
    rcr WORD PTR [rax + rbx*4 + 0x100], 0xff
    rcr WORD PTR [rax], 0xff
    rcr WORD PTR [rbx], 0xff

// === RCR r32, 1 ===
    rcr ebx, 1
    rcr esi, 1
    rcr edi, 1
    rcr edx, 1
    rcr ecx, 1
    rcr eax, 1

// === RCR m32, 1 ===
    rcr DWORD PTR [rip + 0x1000], 1
    rcr DWORD PTR [rip + 0x100], 1
    rcr DWORD PTR [rbx], 1
    rcr DWORD PTR [rax + rbx*4 + 0x100], 1
    rcr DWORD PTR [rax], 1
    rcr DWORD PTR [rax + rbx*1 + 0x10], 1

// === RCR r64, 1 ===
    rcr r9, 1
    rcr r13, 1
    rcr r8, 1
    rcr r12, 1
    rcr r10, 1
    rcr rdx, 1
    rcr rsi, 1
    rcr rdi, 1
    rcr r11, 1
    rcr rax, 1

// === RCR m64, 1 ===
    rcr QWORD PTR [rip + 0x100], 1
    rcr QWORD PTR [rip + 0x1000], 1
    rcr QWORD PTR [rax + rbx*4 + 0x100], 1
    rcr QWORD PTR [rax], 1
    rcr QWORD PTR [rax + rbx*1 + 0x10], 1
    rcr QWORD PTR [rbx], 1

// === RCR r32, CL ===
    rcr ebx, cl
    rcr ecx, cl
    rcr esi, cl
    rcr eax, cl
    rcr edx, cl
    rcr edi, cl

// === RCR m32, CL ===
    rcr DWORD PTR [rax + rbx*4 + 0x100], cl
    rcr DWORD PTR [rbx], cl
    rcr DWORD PTR [rax + rbx*1 + 0x10], cl
    rcr DWORD PTR [rip + 0x1000], cl
    rcr DWORD PTR [rax], cl
    rcr DWORD PTR [rip + 0x100], cl

// === RCR r64, CL ===
    rcr rax, cl
    rcr rbx, cl
    rcr r8, cl
    rcr r13, cl
    rcr rsi, cl
    rcr r12, cl
    rcr rcx, cl
    rcr r11, cl
    rcr rdi, cl
    rcr rdx, cl

// === RCR m64, CL ===
    rcr QWORD PTR [rax + rbx*1 + 0x10], cl
    rcr QWORD PTR [rip + 0x1000], cl
    rcr QWORD PTR [rax + rbx*4 + 0x100], cl
    rcr QWORD PTR [rax], cl
    rcr QWORD PTR [rip + 0x100], cl
    rcr QWORD PTR [rbx], cl

// === RCR r32, imm8 ===
    rcr eax, 0xff
    rcr ecx, 0xff
    rcr edi, 0xff
    rcr edx, 0xff
    rcr esi, 0xff
    rcr ebx, 0xff

// === RCR m32, imm8 ===
    rcr DWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcr DWORD PTR [rip + 0x1000], 0xff
    rcr DWORD PTR [rip + 0x100], 0xff
    rcr DWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcr DWORD PTR [rax], 0xff
    rcr DWORD PTR [rbx], 0xff

// === RCR r64, imm8 ===
    rcr rcx, 0xff
    rcr r8, 0xff
    rcr rax, 0xff
    rcr r10, 0xff
    rcr r12, 0xff
    rcr rbx, 0xff
    rcr r13, 0xff
    rcr rdi, 0xff
    rcr rdx, 0xff
    rcr rsi, 0xff

// === RCR m64, imm8 ===
    rcr QWORD PTR [rip + 0x100], 0xff
    rcr QWORD PTR [rip + 0x1000], 0xff
    rcr QWORD PTR [rax], 0xff
    rcr QWORD PTR [rax + rbx*4 + 0x100], 0xff
    rcr QWORD PTR [rax + rbx*1 + 0x10], 0xff
    rcr QWORD PTR [rbx], 0xff

// === ROL r8, 1 ===
    rol cl, 1
    rol bl, 1
    rol al, 1
    rol dl, 1

// === ROL m8, 1 ===
    rol BYTE PTR [rip + 0x1000], 1
    rol BYTE PTR [rax], 1
    rol BYTE PTR [rax + rbx*4 + 0x100], 1
    rol BYTE PTR [rip + 0x100], 1
    rol BYTE PTR [rbx], 1
    rol BYTE PTR [rax + rbx*1 + 0x10], 1

// === ROL r8, CL ===
    rol al, cl
    rol dl, cl
    rol cl, cl
    rol bl, cl

// === ROL m8, CL ===
    rol BYTE PTR [rax + rbx*1 + 0x10], cl
    rol BYTE PTR [rax], cl
    rol BYTE PTR [rip + 0x1000], cl
    rol BYTE PTR [rbx], cl
    rol BYTE PTR [rip + 0x100], cl
    rol BYTE PTR [rax + rbx*4 + 0x100], cl

// === ROL r8, imm8 ===
    rol al, 0xff
    rol dl, 0xff
    rol bl, 0xff
    rol cl, 0xff

// === ROL m8, imm8 ===
    rol BYTE PTR [rax + rbx*4 + 0x100], 0xff
    rol BYTE PTR [rip + 0x100], 0xff
    rol BYTE PTR [rax], 0xff
    rol BYTE PTR [rip + 0x1000], 0xff
    rol BYTE PTR [rbx], 0xff
    rol BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === ROL r16, 1 ===
    rol di, 1
    rol cx, 1
    rol si, 1
    rol bx, 1
    rol dx, 1
    rol ax, 1

// === ROL m16, 1 ===
    rol WORD PTR [rip + 0x1000], 1
    rol WORD PTR [rax + rbx*4 + 0x100], 1
    rol WORD PTR [rax + rbx*1 + 0x10], 1
    rol WORD PTR [rip + 0x100], 1
    rol WORD PTR [rax], 1
    rol WORD PTR [rbx], 1

// === ROL r16, CL ===
    rol cx, cl
    rol dx, cl
    rol bx, cl
    rol di, cl
    rol si, cl
    rol ax, cl

// === ROL m16, CL ===
    rol WORD PTR [rbx], cl
    rol WORD PTR [rip + 0x1000], cl
    rol WORD PTR [rip + 0x100], cl
    rol WORD PTR [rax], cl
    rol WORD PTR [rax + rbx*4 + 0x100], cl
    rol WORD PTR [rax + rbx*1 + 0x10], cl

// === ROL r16, imm8 ===
    rol ax, 0xff
    rol dx, 0xff
    rol bx, 0xff
    rol cx, 0xff
    rol si, 0xff
    rol di, 0xff

// === ROL m16, imm8 ===
    rol WORD PTR [rbx], 0xff
    rol WORD PTR [rax + rbx*1 + 0x10], 0xff
    rol WORD PTR [rax + rbx*4 + 0x100], 0xff
    rol WORD PTR [rax], 0xff
    rol WORD PTR [rip + 0x100], 0xff
    rol WORD PTR [rip + 0x1000], 0xff

// === ROL r32, 1 ===
    rol ebx, 1
    rol eax, 1
    rol esi, 1
    rol edx, 1
    rol ecx, 1
    rol edi, 1

// === ROL m32, 1 ===
    rol DWORD PTR [rax + rbx*4 + 0x100], 1
    rol DWORD PTR [rax], 1
    rol DWORD PTR [rax + rbx*1 + 0x10], 1
    rol DWORD PTR [rip + 0x1000], 1
    rol DWORD PTR [rbx], 1
    rol DWORD PTR [rip + 0x100], 1

// === ROL r64, 1 ===
    rol r9, 1
    rol rdi, 1
    rol rax, 1
    rol r10, 1
    rol rbx, 1
    rol rcx, 1
    rol r11, 1
    rol r12, 1
    rol r8, 1
    rol rdx, 1

// === ROL m64, 1 ===
    rol QWORD PTR [rax + rbx*4 + 0x100], 1
    rol QWORD PTR [rip + 0x100], 1
    rol QWORD PTR [rax], 1
    rol QWORD PTR [rbx], 1
    rol QWORD PTR [rax + rbx*1 + 0x10], 1
    rol QWORD PTR [rip + 0x1000], 1

// === ROL r32, CL ===
    rol edx, cl
    rol esi, cl
    rol eax, cl
    rol ecx, cl
    rol ebx, cl
    rol edi, cl

// === ROL m32, CL ===
    rol DWORD PTR [rax], cl
    rol DWORD PTR [rax + rbx*4 + 0x100], cl
    rol DWORD PTR [rip + 0x100], cl
    rol DWORD PTR [rip + 0x1000], cl
    rol DWORD PTR [rbx], cl
    rol DWORD PTR [rax + rbx*1 + 0x10], cl

// === ROL r64, CL ===
    rol r8, cl
    rol rax, cl
    rol r10, cl
    rol rbx, cl
    rol r12, cl
    rol rdx, cl
    rol rdi, cl
    rol r13, cl
    rol rsi, cl
    rol rcx, cl

// === ROL m64, CL ===
    rol QWORD PTR [rip + 0x100], cl
    rol QWORD PTR [rax], cl
    rol QWORD PTR [rip + 0x1000], cl
    rol QWORD PTR [rbx], cl
    rol QWORD PTR [rax + rbx*4 + 0x100], cl
    rol QWORD PTR [rax + rbx*1 + 0x10], cl

// === ROL r32, imm8 ===
    rol edx, 0xff
    rol eax, 0xff
    rol esi, 0xff
    rol ecx, 0xff
    rol ebx, 0xff
    rol edi, 0xff

// === ROL m32, imm8 ===
    rol DWORD PTR [rip + 0x1000], 0xff
    rol DWORD PTR [rax], 0xff
    rol DWORD PTR [rax + rbx*1 + 0x10], 0xff
    rol DWORD PTR [rbx], 0xff
    rol DWORD PTR [rip + 0x100], 0xff
    rol DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === ROL r64, imm8 ===
    rol r10, 0xff
    rol r11, 0xff
    rol rdi, 0xff
    rol rbx, 0xff
    rol rcx, 0xff
    rol r12, 0xff
    rol r13, 0xff
    rol rsi, 0xff
    rol rdx, 0xff
    rol rax, 0xff

// === ROL m64, imm8 ===
    rol QWORD PTR [rax], 0xff
    rol QWORD PTR [rip + 0x100], 0xff
    rol QWORD PTR [rip + 0x1000], 0xff
    rol QWORD PTR [rax + rbx*1 + 0x10], 0xff
    rol QWORD PTR [rbx], 0xff
    rol QWORD PTR [rax + rbx*4 + 0x100], 0xff

// === ROR r8, 1 ===
    ror bl, 1
    ror al, 1
    ror cl, 1
    ror dl, 1

// === ROR m8, 1 ===
    ror BYTE PTR [rbx], 1
    ror BYTE PTR [rax + rbx*4 + 0x100], 1
    ror BYTE PTR [rax], 1
    ror BYTE PTR [rip + 0x1000], 1
    ror BYTE PTR [rip + 0x100], 1
    ror BYTE PTR [rax + rbx*1 + 0x10], 1

// === ROR r8, CL ===
    ror cl, cl
    ror al, cl
    ror bl, cl
    ror dl, cl

// === ROR m8, CL ===
    ror BYTE PTR [rax + rbx*4 + 0x100], cl
    ror BYTE PTR [rbx], cl
    ror BYTE PTR [rax], cl
    ror BYTE PTR [rax + rbx*1 + 0x10], cl
    ror BYTE PTR [rip + 0x1000], cl
    ror BYTE PTR [rip + 0x100], cl

// === ROR r8, imm8 ===
    ror al, 0xff
    ror bl, 0xff
    ror cl, 0xff
    ror dl, 0xff

// === ROR m8, imm8 ===
    ror BYTE PTR [rip + 0x100], 0xff
    ror BYTE PTR [rax + rbx*4 + 0x100], 0xff
    ror BYTE PTR [rbx], 0xff
    ror BYTE PTR [rax + rbx*1 + 0x10], 0xff
    ror BYTE PTR [rax], 0xff
    ror BYTE PTR [rip + 0x1000], 0xff

// === ROR r16, 1 ===
    ror bx, 1
    ror di, 1
    ror cx, 1
    ror ax, 1
    ror dx, 1
    ror si, 1

// === ROR m16, 1 ===
    ror WORD PTR [rax], 1
    ror WORD PTR [rip + 0x1000], 1
    ror WORD PTR [rbx], 1
    ror WORD PTR [rax + rbx*1 + 0x10], 1
    ror WORD PTR [rip + 0x100], 1
    ror WORD PTR [rax + rbx*4 + 0x100], 1

// === ROR r16, CL ===
    ror bx, cl
    ror si, cl
    ror ax, cl
    ror di, cl
    ror dx, cl
    ror cx, cl

// === ROR m16, CL ===
    ror WORD PTR [rip + 0x100], cl
    ror WORD PTR [rip + 0x1000], cl
    ror WORD PTR [rax], cl
    ror WORD PTR [rax + rbx*1 + 0x10], cl
    ror WORD PTR [rax + rbx*4 + 0x100], cl
    ror WORD PTR [rbx], cl

// === ROR r16, imm8 ===
    ror si, 0xff
    ror ax, 0xff
    ror di, 0xff
    ror bx, 0xff
    ror dx, 0xff
    ror cx, 0xff

// === ROR m16, imm8 ===
    ror WORD PTR [rax + rbx*1 + 0x10], 0xff
    ror WORD PTR [rip + 0x1000], 0xff
    ror WORD PTR [rax + rbx*4 + 0x100], 0xff
    ror WORD PTR [rbx], 0xff
    ror WORD PTR [rax], 0xff
    ror WORD PTR [rip + 0x100], 0xff

// === ROR r32, 1 ===
    ror ecx, 1
    ror edx, 1
    ror ebx, 1
    ror esi, 1
    ror eax, 1
    ror edi, 1

// === ROR m32, 1 ===
    ror DWORD PTR [rax], 1
    ror DWORD PTR [rax + rbx*4 + 0x100], 1
    ror DWORD PTR [rbx], 1
    ror DWORD PTR [rip + 0x1000], 1
    ror DWORD PTR [rax + rbx*1 + 0x10], 1
    ror DWORD PTR [rip + 0x100], 1

// === ROR r64, 1 ===
    ror r9, 1
    ror rcx, 1
    ror rdi, 1
    ror rbx, 1
    ror r13, 1
    ror r12, 1
    ror rax, 1
    ror r11, 1
    ror rdx, 1
    ror r8, 1

// === ROR m64, 1 ===
    ror QWORD PTR [rax + rbx*4 + 0x100], 1
    ror QWORD PTR [rax + rbx*1 + 0x10], 1
    ror QWORD PTR [rax], 1
    ror QWORD PTR [rip + 0x100], 1
    ror QWORD PTR [rbx], 1
    ror QWORD PTR [rip + 0x1000], 1

// === ROR r32, CL ===
    ror edx, cl
    ror edi, cl
    ror ecx, cl
    ror esi, cl
    ror eax, cl
    ror ebx, cl

// === ROR m32, CL ===
    ror DWORD PTR [rax + rbx*1 + 0x10], cl
    ror DWORD PTR [rbx], cl
    ror DWORD PTR [rax], cl
    ror DWORD PTR [rip + 0x100], cl
    ror DWORD PTR [rip + 0x1000], cl
    ror DWORD PTR [rax + rbx*4 + 0x100], cl

// === ROR r64, CL ===
    ror rsi, cl
    ror rax, cl
    ror rdi, cl
    ror r8, cl
    ror rcx, cl
    ror r9, cl
    ror rdx, cl
    ror r13, cl
    ror r10, cl
    ror r12, cl

// === ROR m64, CL ===
    ror QWORD PTR [rip + 0x1000], cl
    ror QWORD PTR [rip + 0x100], cl
    ror QWORD PTR [rax], cl
    ror QWORD PTR [rax + rbx*1 + 0x10], cl
    ror QWORD PTR [rax + rbx*4 + 0x100], cl
    ror QWORD PTR [rbx], cl

// === ROR r32, imm8 ===
    ror ecx, 0xff
    ror esi, 0xff
    ror ebx, 0xff
    ror edi, 0xff
    ror eax, 0xff
    ror edx, 0xff

// === ROR m32, imm8 ===
    ror DWORD PTR [rax + rbx*1 + 0x10], 0xff
    ror DWORD PTR [rax], 0xff
    ror DWORD PTR [rip + 0x1000], 0xff
    ror DWORD PTR [rip + 0x100], 0xff
    ror DWORD PTR [rbx], 0xff
    ror DWORD PTR [rax + rbx*4 + 0x100], 0xff

// === ROR r64, imm8 ===
    ror r8, 0xff
    ror rax, 0xff
    ror r11, 0xff
    ror rbx, 0xff
    ror rsi, 0xff
    ror r13, 0xff
    ror r10, 0xff
    ror rcx, 0xff
    ror rdx, 0xff
    ror rdi, 0xff

// === ROR m64, imm8 ===
    ror QWORD PTR [rbx], 0xff
    ror QWORD PTR [rip + 0x100], 0xff
    ror QWORD PTR [rip + 0x1000], 0xff
    ror QWORD PTR [rax + rbx*1 + 0x10], 0xff
    ror QWORD PTR [rax], 0xff
    ror QWORD PTR [rax + rbx*4 + 0x100], 0xff

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

// === RET ===
    ret

// === RET imm16 ===
    ret 0xffff

// === RSM ===
    rsm

// === SAHF ===
    sahf

// === SAL r8, 1 ===
    sal cl, 1
    sal bl, 1
    sal al, 1
    sal dl, 1

// === SAL m8, 1 ===
    sal BYTE PTR [rip + 0x100], 1
    sal BYTE PTR [rax], 1
    sal BYTE PTR [rip + 0x1000], 1
    sal BYTE PTR [rax + rbx*1 + 0x10], 1
    sal BYTE PTR [rbx], 1
    sal BYTE PTR [rax + rbx*4 + 0x100], 1

// === SAL r8, CL ===
    sal cl, cl
    sal al, cl
    sal dl, cl
    sal bl, cl

// === SAL m8, CL ===
    sal BYTE PTR [rip + 0x1000], cl
    sal BYTE PTR [rax], cl
    sal BYTE PTR [rax + rbx*4 + 0x100], cl
    sal BYTE PTR [rax + rbx*1 + 0x10], cl
    sal BYTE PTR [rip + 0x100], cl
    sal BYTE PTR [rbx], cl

// === SAL r8, imm8 ===
    sal al, 0xff
    sal dl, 0xff
    sal bl, 0xff
    sal cl, 0xff

// === SAL m8, imm8 ===
    sal BYTE PTR [rbx], 0xff
    sal BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sal BYTE PTR [rip + 0x100], 0xff
    sal BYTE PTR [rax], 0xff
    sal BYTE PTR [rax + rbx*1 + 0x10], 0xff
    sal BYTE PTR [rip + 0x1000], 0xff

// === SAL r16, 1 ===
    sal ax, 1
    sal bx, 1
    sal di, 1
    sal cx, 1
    sal si, 1
    sal dx, 1

// === SAL m16, 1 ===
    sal WORD PTR [rax + rbx*1 + 0x10], 1
    sal WORD PTR [rbx], 1
    sal WORD PTR [rip + 0x1000], 1
    sal WORD PTR [rax], 1
    sal WORD PTR [rax + rbx*4 + 0x100], 1
    sal WORD PTR [rip + 0x100], 1

// === SAL r16, CL ===
    sal si, cl
    sal cx, cl
    sal bx, cl
    sal di, cl
    sal ax, cl
    sal dx, cl

// === SAL m16, CL ===
    sal WORD PTR [rip + 0x100], cl
    sal WORD PTR [rip + 0x1000], cl
    sal WORD PTR [rbx], cl
    sal WORD PTR [rax], cl
    sal WORD PTR [rax + rbx*4 + 0x100], cl
    sal WORD PTR [rax + rbx*1 + 0x10], cl

// === SAL r16, imm8 ===
    sal cx, 0xff
    sal dx, 0xff
    sal di, 0xff
    sal ax, 0xff
    sal bx, 0xff
    sal si, 0xff

// === SAL m16, imm8 ===
    sal WORD PTR [rax + rbx*1 + 0x10], 0xff
    sal WORD PTR [rax], 0xff
    sal WORD PTR [rbx], 0xff
    sal WORD PTR [rip + 0x100], 0xff
    sal WORD PTR [rip + 0x1000], 0xff
    sal WORD PTR [rax + rbx*4 + 0x100], 0xff

// === SAL r32, 1 ===
    sal eax, 1
    sal ebx, 1
    sal esi, 1
    sal edi, 1
    sal ecx, 1
    sal edx, 1

// === SAL m32, 1 ===
    sal DWORD PTR [rax], 1
    sal DWORD PTR [rip + 0x1000], 1
    sal DWORD PTR [rax + rbx*1 + 0x10], 1
    sal DWORD PTR [rip + 0x100], 1
    sal DWORD PTR [rbx], 1
    sal DWORD PTR [rax + rbx*4 + 0x100], 1

// === SAL r64, 1 ===
    sal rdi, 1
    sal rsi, 1
    sal rdx, 1
    sal r10, 1
    sal rbx, 1
    sal r13, 1
    sal rcx, 1
    sal r9, 1
    sal r12, 1
    sal rax, 1

// === SAL m64, 1 ===
    sal QWORD PTR [rax], 1
    sal QWORD PTR [rax + rbx*1 + 0x10], 1
    sal QWORD PTR [rbx], 1
    sal QWORD PTR [rax + rbx*4 + 0x100], 1
    sal QWORD PTR [rip + 0x1000], 1
    sal QWORD PTR [rip + 0x100], 1

// === SAL r32, CL ===
    sal ecx, cl
    sal esi, cl
    sal eax, cl
    sal edi, cl
    sal edx, cl
    sal ebx, cl

// === SAL m32, CL ===
    sal DWORD PTR [rbx], cl
    sal DWORD PTR [rax + rbx*1 + 0x10], cl
    sal DWORD PTR [rax], cl
    sal DWORD PTR [rax + rbx*4 + 0x100], cl
    sal DWORD PTR [rip + 0x1000], cl
    sal DWORD PTR [rip + 0x100], cl

// === SAL r64, CL ===
    sal r13, cl
    sal r12, cl
    sal r8, cl
    sal rbx, cl
    sal rax, cl
    sal rcx, cl
    sal r9, cl
    sal rdx, cl
    sal rdi, cl
    sal r10, cl

// === SAL m64, CL ===
    sal QWORD PTR [rax + rbx*4 + 0x100], cl
    sal QWORD PTR [rbx], cl
    sal QWORD PTR [rax + rbx*1 + 0x10], cl
    sal QWORD PTR [rax], cl
    sal QWORD PTR [rip + 0x1000], cl
    sal QWORD PTR [rip + 0x100], cl

// === SAL r32, imm8 ===
    sal ecx, 0xff
    sal edx, 0xff
    sal esi, 0xff
    sal ebx, 0xff
    sal edi, 0xff
    sal eax, 0xff

// === SAL m32, imm8 ===
    sal DWORD PTR [rax + rbx*1 + 0x10], 0xff
    sal DWORD PTR [rip + 0x100], 0xff
    sal DWORD PTR [rip + 0x1000], 0xff
    sal DWORD PTR [rbx], 0xff
    sal DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sal DWORD PTR [rax], 0xff

// === SAL r64, imm8 ===
    sal rdx, 0xff
    sal rsi, 0xff
    sal r9, 0xff
    sal rax, 0xff
    sal rbx, 0xff
    sal r11, 0xff
    sal rcx, 0xff
    sal r13, 0xff
    sal r8, 0xff
    sal rdi, 0xff

// === SAL m64, imm8 ===
    sal QWORD PTR [rip + 0x100], 0xff
    sal QWORD PTR [rip + 0x1000], 0xff
    sal QWORD PTR [rbx], 0xff
    sal QWORD PTR [rax], 0xff
    sal QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sal QWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SAR r8, 1 ===
    sar al, 1
    sar cl, 1
    sar dl, 1
    sar bl, 1

// === SAR m8, 1 ===
    sar BYTE PTR [rbx], 1
    sar BYTE PTR [rax], 1
    sar BYTE PTR [rax + rbx*4 + 0x100], 1
    sar BYTE PTR [rip + 0x100], 1
    sar BYTE PTR [rax + rbx*1 + 0x10], 1
    sar BYTE PTR [rip + 0x1000], 1

// === SAR r8, CL ===
    sar cl, cl
    sar bl, cl
    sar dl, cl
    sar al, cl

// === SAR m8, CL ===
    sar BYTE PTR [rip + 0x100], cl
    sar BYTE PTR [rbx], cl
    sar BYTE PTR [rax + rbx*1 + 0x10], cl
    sar BYTE PTR [rax], cl
    sar BYTE PTR [rax + rbx*4 + 0x100], cl
    sar BYTE PTR [rip + 0x1000], cl

// === SAR r8, imm8 ===
    sar al, 0xff
    sar bl, 0xff
    sar dl, 0xff
    sar cl, 0xff

// === SAR m8, imm8 ===
    sar BYTE PTR [rax], 0xff
    sar BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sar BYTE PTR [rbx], 0xff
    sar BYTE PTR [rip + 0x1000], 0xff
    sar BYTE PTR [rip + 0x100], 0xff
    sar BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === SAR r16,1 ===
    sar dx, 1
    sar si, 1
    sar di, 1
    sar bx, 1
    sar cx, 1
    sar ax, 1

// === SAR m16,1 ===
    sar WORD PTR [rax + rbx*4 + 0x100], 1
    sar WORD PTR [rax], 1
    sar WORD PTR [rax + rbx*1 + 0x10], 1
    sar WORD PTR [rbx], 1
    sar WORD PTR [rip + 0x100], 1
    sar WORD PTR [rip + 0x1000], 1

// === SAR r16, CL ===
    sar si, cl
    sar di, cl
    sar cx, cl
    sar dx, cl
    sar ax, cl
    sar bx, cl

// === SAR m16, CL ===
    sar WORD PTR [rax], cl
    sar WORD PTR [rip + 0x1000], cl
    sar WORD PTR [rax + rbx*4 + 0x100], cl
    sar WORD PTR [rip + 0x100], cl
    sar WORD PTR [rax + rbx*1 + 0x10], cl
    sar WORD PTR [rbx], cl

// === SAR r16, imm8 ===
    sar si, 0xff
    sar cx, 0xff
    sar ax, 0xff
    sar bx, 0xff
    sar di, 0xff
    sar dx, 0xff

// === SAR m16, imm8 ===
    sar WORD PTR [rax + rbx*4 + 0x100], 0xff
    sar WORD PTR [rbx], 0xff
    sar WORD PTR [rax + rbx*1 + 0x10], 0xff
    sar WORD PTR [rax], 0xff
    sar WORD PTR [rip + 0x1000], 0xff
    sar WORD PTR [rip + 0x100], 0xff

// === SAR r32, 1 ===
    sar eax, 1
    sar ebx, 1
    sar esi, 1
    sar edi, 1
    sar ecx, 1
    sar edx, 1

// === SAR m32, 1 ===
    sar DWORD PTR [rbx], 1
    sar DWORD PTR [rax + rbx*4 + 0x100], 1
    sar DWORD PTR [rip + 0x1000], 1
    sar DWORD PTR [rip + 0x100], 1
    sar DWORD PTR [rax], 1
    sar DWORD PTR [rax + rbx*1 + 0x10], 1

// === SAR r64, 1 ===
    sar rax, 1
    sar r8, 1
    sar r9, 1
    sar r10, 1
    sar rbx, 1
    sar r13, 1
    sar rsi, 1
    sar rdi, 1
    sar rdx, 1
    sar rcx, 1

// === SAR m64, 1 ===
    sar QWORD PTR [rbx], 1
    sar QWORD PTR [rip + 0x100], 1
    sar QWORD PTR [rax + rbx*1 + 0x10], 1
    sar QWORD PTR [rax], 1
    sar QWORD PTR [rip + 0x1000], 1
    sar QWORD PTR [rax + rbx*4 + 0x100], 1

// === SAR r32, CL ===
    sar eax, cl
    sar ebx, cl
    sar edi, cl
    sar edx, cl
    sar esi, cl
    sar ecx, cl

// === SAR m32, CL ===
    sar DWORD PTR [rip + 0x100], cl
    sar DWORD PTR [rax + rbx*1 + 0x10], cl
    sar DWORD PTR [rbx], cl
    sar DWORD PTR [rax + rbx*4 + 0x100], cl
    sar DWORD PTR [rip + 0x1000], cl
    sar DWORD PTR [rax], cl

// === SAR r64, CL ===
    sar rdi, cl
    sar r10, cl
    sar rdx, cl
    sar rax, cl
    sar rsi, cl
    sar r9, cl
    sar r12, cl
    sar rbx, cl
    sar r13, cl
    sar rcx, cl

// === SAR m64, CL ===
    sar QWORD PTR [rip + 0x1000], cl
    sar QWORD PTR [rbx], cl
    sar QWORD PTR [rax + rbx*1 + 0x10], cl
    sar QWORD PTR [rax], cl
    sar QWORD PTR [rip + 0x100], cl
    sar QWORD PTR [rax + rbx*4 + 0x100], cl

// === SAR r32, imm8 ===
    sar ecx, 0xff
    sar esi, 0xff
    sar ebx, 0xff
    sar eax, 0xff
    sar edx, 0xff
    sar edi, 0xff

// === SAR m32, imm8 ===
    sar DWORD PTR [rax], 0xff
    sar DWORD PTR [rip + 0x1000], 0xff
    sar DWORD PTR [rbx], 0xff
    sar DWORD PTR [rip + 0x100], 0xff
    sar DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sar DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SAR r64, imm8 ===
    sar rsi, 0xff
    sar rdx, 0xff
    sar rcx, 0xff
    sar rdi, 0xff
    sar r9, 0xff
    sar r12, 0xff
    sar r13, 0xff
    sar rax, 0xff
    sar rbx, 0xff
    sar r10, 0xff

// === SAR m64, imm8 ===
    sar QWORD PTR [rax], 0xff
    sar QWORD PTR [rbx], 0xff
    sar QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sar QWORD PTR [rip + 0x100], 0xff
    sar QWORD PTR [rax + rbx*1 + 0x10], 0xff
    sar QWORD PTR [rip + 0x1000], 0xff

// === SHL r8, 1 ===
    shl al, 1
    shl cl, 1
    shl bl, 1
    shl dl, 1

// === SHL m8, 1 ===
    shl BYTE PTR [rax + rbx*1 + 0x10], 1
    shl BYTE PTR [rbx], 1
    shl BYTE PTR [rip + 0x1000], 1
    shl BYTE PTR [rax], 1
    shl BYTE PTR [rip + 0x100], 1
    shl BYTE PTR [rax + rbx*4 + 0x100], 1

// === SHL r8, CL ===
    shl dl, cl
    shl bl, cl
    shl al, cl
    shl cl, cl

// === SHL m8, CL ===
    shl BYTE PTR [rbx], cl
    shl BYTE PTR [rax + rbx*4 + 0x100], cl
    shl BYTE PTR [rax], cl
    shl BYTE PTR [rip + 0x1000], cl
    shl BYTE PTR [rax + rbx*1 + 0x10], cl
    shl BYTE PTR [rip + 0x100], cl

// === SHL r8, imm8 ===
    shl dl, 0xff
    shl cl, 0xff
    shl bl, 0xff
    shl al, 0xff

// === SHL m8, imm8 ===
    shl BYTE PTR [rip + 0x100], 0xff
    shl BYTE PTR [rax + rbx*4 + 0x100], 0xff
    shl BYTE PTR [rax + rbx*1 + 0x10], 0xff
    shl BYTE PTR [rax], 0xff
    shl BYTE PTR [rbx], 0xff
    shl BYTE PTR [rip + 0x1000], 0xff

// === SHL r16,1 ===
    shl bx, 1
    shl dx, 1
    shl si, 1
    shl ax, 1
    shl cx, 1
    shl di, 1

// === SHL m16,1 ===
    shl WORD PTR [rax + rbx*1 + 0x10], 1
    shl WORD PTR [rip + 0x1000], 1
    shl WORD PTR [rax + rbx*4 + 0x100], 1
    shl WORD PTR [rip + 0x100], 1
    shl WORD PTR [rbx], 1
    shl WORD PTR [rax], 1

// === SHL r16, CL ===
    shl bx, cl
    shl si, cl
    shl ax, cl
    shl cx, cl
    shl di, cl
    shl dx, cl

// === SHL m16, CL ===
    shl WORD PTR [rbx], cl
    shl WORD PTR [rax + rbx*1 + 0x10], cl
    shl WORD PTR [rax + rbx*4 + 0x100], cl
    shl WORD PTR [rip + 0x1000], cl
    shl WORD PTR [rax], cl
    shl WORD PTR [rip + 0x100], cl

// === SHL r16, imm8 ===
    shl bx, 0xff
    shl di, 0xff
    shl dx, 0xff
    shl cx, 0xff
    shl si, 0xff
    shl ax, 0xff

// === SHL m16, imm8 ===
    shl WORD PTR [rip + 0x100], 0xff
    shl WORD PTR [rip + 0x1000], 0xff
    shl WORD PTR [rax + rbx*4 + 0x100], 0xff
    shl WORD PTR [rax], 0xff
    shl WORD PTR [rax + rbx*1 + 0x10], 0xff
    shl WORD PTR [rbx], 0xff

// === SHL r32,1 ===
    shl esi, 1
    shl edx, 1
    shl ecx, 1
    shl eax, 1
    shl ebx, 1
    shl edi, 1

// === SHL m32,1 ===
    shl DWORD PTR [rbx], 1
    shl DWORD PTR [rax], 1
    shl DWORD PTR [rax + rbx*4 + 0x100], 1
    shl DWORD PTR [rip + 0x1000], 1
    shl DWORD PTR [rax + rbx*1 + 0x10], 1
    shl DWORD PTR [rip + 0x100], 1

// === SHL r64,1 ===
    shl rdi, 1
    shl rcx, 1
    shl r11, 1
    shl rdx, 1
    shl r13, 1
    shl r8, 1
    shl r10, 1
    shl rax, 1
    shl r9, 1
    shl r12, 1

// === SHL m64,1 ===
    shl QWORD PTR [rip + 0x100], 1
    shl QWORD PTR [rbx], 1
    shl QWORD PTR [rax + rbx*1 + 0x10], 1
    shl QWORD PTR [rax], 1
    shl QWORD PTR [rip + 0x1000], 1
    shl QWORD PTR [rax + rbx*4 + 0x100], 1

// === SHL r32, CL ===
    shl edi, cl
    shl esi, cl
    shl ecx, cl
    shl edx, cl
    shl ebx, cl
    shl eax, cl

// === SHL m32, CL ===
    shl DWORD PTR [rax + rbx*1 + 0x10], cl
    shl DWORD PTR [rip + 0x1000], cl
    shl DWORD PTR [rax + rbx*4 + 0x100], cl
    shl DWORD PTR [rax], cl
    shl DWORD PTR [rip + 0x100], cl
    shl DWORD PTR [rbx], cl

// === SHL r64, CL ===
    shl r13, cl
    shl r9, cl
    shl r8, cl
    shl r12, cl
    shl rbx, cl
    shl rdx, cl
    shl rdi, cl
    shl r11, cl
    shl r10, cl
    shl rcx, cl

// === SHL m64, CL ===
    shl QWORD PTR [rip + 0x100], cl
    shl QWORD PTR [rax + rbx*4 + 0x100], cl
    shl QWORD PTR [rax], cl
    shl QWORD PTR [rbx], cl
    shl QWORD PTR [rip + 0x1000], cl
    shl QWORD PTR [rax + rbx*1 + 0x10], cl

// === SHL r32, imm8 ===
    shl esi, 0xff
    shl ebx, 0xff
    shl ecx, 0xff
    shl eax, 0xff
    shl edx, 0xff
    shl edi, 0xff

// === SHL m32, imm8 ===
    shl DWORD PTR [rip + 0x1000], 0xff
    shl DWORD PTR [rax], 0xff
    shl DWORD PTR [rax + rbx*4 + 0x100], 0xff
    shl DWORD PTR [rbx], 0xff
    shl DWORD PTR [rip + 0x100], 0xff
    shl DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SHL r64, imm8 ===
    shl r11, 0xff
    shl r9, 0xff
    shl rdi, 0xff
    shl r8, 0xff
    shl rsi, 0xff
    shl r10, 0xff
    shl rax, 0xff
    shl rdx, 0xff
    shl rbx, 0xff
    shl rcx, 0xff

// === SHL m64, imm8 ===
    shl QWORD PTR [rip + 0x100], 0xff
    shl QWORD PTR [rax], 0xff
    shl QWORD PTR [rax + rbx*4 + 0x100], 0xff
    shl QWORD PTR [rax + rbx*1 + 0x10], 0xff
    shl QWORD PTR [rip + 0x1000], 0xff
    shl QWORD PTR [rbx], 0xff

// === SHR r8, ===
    shr bl
    shr cl
    shr dl
    shr al

// === SHR m8, ===
    shr BYTE PTR [rbx]
    shr BYTE PTR [rip + 0x100]
    shr BYTE PTR [rax]
    shr BYTE PTR [rax + rbx*4 + 0x100]
    shr BYTE PTR [rip + 0x1000]
    shr BYTE PTR [rax + rbx*1 + 0x10]

// === SHR r8, CL ===
    shr cl, cl
    shr bl, cl
    shr al, cl
    shr dl, cl

// === SHR m8, CL ===
    shr BYTE PTR [rip + 0x100], cl
    shr BYTE PTR [rax + rbx*4 + 0x100], cl
    shr BYTE PTR [rax], cl
    shr BYTE PTR [rip + 0x1000], cl
    shr BYTE PTR [rax + rbx*1 + 0x10], cl
    shr BYTE PTR [rbx], cl

// === SHR r8, imm8 ===
    shr cl, 0xff
    shr dl, 0xff
    shr al, 0xff
    shr bl, 0xff

// === SHR m8, imm8 ===
    shr BYTE PTR [rax + rbx*4 + 0x100], 0xff
    shr BYTE PTR [rax + rbx*1 + 0x10], 0xff
    shr BYTE PTR [rip + 0x1000], 0xff
    shr BYTE PTR [rip + 0x100], 0xff
    shr BYTE PTR [rax], 0xff
    shr BYTE PTR [rbx], 0xff

// === SHR r16, 1 ===
    shr si, 1
    shr ax, 1
    shr dx, 1
    shr di, 1
    shr bx, 1
    shr cx, 1

// === SHR m16, 1 ===
    shr WORD PTR [rax], 1
    shr WORD PTR [rax + rbx*4 + 0x100], 1
    shr WORD PTR [rbx], 1
    shr WORD PTR [rip + 0x1000], 1
    shr WORD PTR [rip + 0x100], 1
    shr WORD PTR [rax + rbx*1 + 0x10], 1

// === SHR r16, CL ===
    shr ax, cl
    shr dx, cl
    shr si, cl
    shr cx, cl
    shr di, cl
    shr bx, cl

// === SHR m16, CL ===
    shr WORD PTR [rax], cl
    shr WORD PTR [rbx], cl
    shr WORD PTR [rax + rbx*1 + 0x10], cl
    shr WORD PTR [rip + 0x100], cl
    shr WORD PTR [rip + 0x1000], cl
    shr WORD PTR [rax + rbx*4 + 0x100], cl

// === SHR r16, imm8 ===
    shr ax, 0xff
    shr dx, 0xff
    shr di, 0xff
    shr cx, 0xff
    shr bx, 0xff
    shr si, 0xff

// === SHR m16, imm8 ===
    shr WORD PTR [rax + rbx*1 + 0x10], 0xff
    shr WORD PTR [rax], 0xff
    shr WORD PTR [rax + rbx*4 + 0x100], 0xff
    shr WORD PTR [rip + 0x100], 0xff
    shr WORD PTR [rip + 0x1000], 0xff
    shr WORD PTR [rbx], 0xff

// === SHR r32, 1 ===
    shr ecx, 1
    shr edx, 1
    shr ebx, 1
    shr edi, 1
    shr esi, 1
    shr eax, 1

// === SHR m32, 1 ===
    shr DWORD PTR [rip + 0x100], 1
    shr DWORD PTR [rax + rbx*4 + 0x100], 1
    shr DWORD PTR [rax], 1
    shr DWORD PTR [rax + rbx*1 + 0x10], 1
    shr DWORD PTR [rip + 0x1000], 1
    shr DWORD PTR [rbx], 1

// === SHR r64, 1 ===
    shr r13, 1
    shr rbx, 1
    shr rdi, 1
    shr rcx, 1
    shr rsi, 1
    shr r8, 1
    shr rdx, 1
    shr r11, 1
    shr r10, 1
    shr r9, 1

// === SHR m64, 1 ===
    shr QWORD PTR [rbx], 1
    shr QWORD PTR [rip + 0x100], 1
    shr QWORD PTR [rax], 1
    shr QWORD PTR [rip + 0x1000], 1
    shr QWORD PTR [rax + rbx*1 + 0x10], 1
    shr QWORD PTR [rax + rbx*4 + 0x100], 1

// === SHR r32, CL ===
    shr esi, cl
    shr edx, cl
    shr ecx, cl
    shr ebx, cl
    shr edi, cl
    shr eax, cl

// === SHR m32, CL ===
    shr DWORD PTR [rbx], cl
    shr DWORD PTR [rip + 0x100], cl
    shr DWORD PTR [rax + rbx*1 + 0x10], cl
    shr DWORD PTR [rip + 0x1000], cl
    shr DWORD PTR [rax + rbx*4 + 0x100], cl
    shr DWORD PTR [rax], cl

// === SHR r64, CL ===
    shr r11, cl
    shr r12, cl
    shr rdi, cl
    shr rsi, cl
    shr rcx, cl
    shr r13, cl
    shr rax, cl
    shr r9, cl
    shr rdx, cl
    shr r8, cl

// === SHR m64, CL ===
    shr QWORD PTR [rax + rbx*1 + 0x10], cl
    shr QWORD PTR [rip + 0x100], cl
    shr QWORD PTR [rax], cl
    shr QWORD PTR [rip + 0x1000], cl
    shr QWORD PTR [rbx], cl
    shr QWORD PTR [rax + rbx*4 + 0x100], cl

// === SHR r32, imm8 ===
    shr esi, 0xff
    shr ebx, 0xff
    shr edi, 0xff
    shr ecx, 0xff
    shr eax, 0xff
    shr edx, 0xff

// === SHR m32, imm8 ===
    shr DWORD PTR [rax + rbx*4 + 0x100], 0xff
    shr DWORD PTR [rip + 0x100], 0xff
    shr DWORD PTR [rbx], 0xff
    shr DWORD PTR [rax], 0xff
    shr DWORD PTR [rax + rbx*1 + 0x10], 0xff
    shr DWORD PTR [rip + 0x1000], 0xff

// === SHR r64, imm8 ===
    shr r8, 0xff
    shr rsi, 0xff
    shr r9, 0xff
    shr r11, 0xff
    shr r10, 0xff
    shr rcx, 0xff
    shr r13, 0xff
    shr rax, 0xff
    shr rbx, 0xff
    shr rdi, 0xff

// === SHR m64, imm8 ===
    shr QWORD PTR [rax + rbx*4 + 0x100], 0xff
    shr QWORD PTR [rbx], 0xff
    shr QWORD PTR [rip + 0x100], 0xff
    shr QWORD PTR [rip + 0x1000], 0xff
    shr QWORD PTR [rax + rbx*1 + 0x10], 0xff
    shr QWORD PTR [rax], 0xff

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
    sbb al, 0xff
    sbb bl, 0xff
    sbb cl, 0xff
    sbb dl, 0xff

// === SBB m8, imm8 ===
    sbb BYTE PTR [rbx], 0xff
    sbb BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sbb BYTE PTR [rax + rbx*1 + 0x10], 0xff
    sbb BYTE PTR [rip + 0x100], 0xff
    sbb BYTE PTR [rax], 0xff
    sbb BYTE PTR [rip + 0x1000], 0xff

// === SBB r16, imm16 ===
    sbb dx, 0xffff
    sbb si, 0xffff
    sbb di, 0xffff
    sbb bx, 0xffff
    sbb ax, 0xffff
    sbb cx, 0xffff

// === SBB m16, imm16 ===
    sbb WORD PTR [rax + rbx*1 + 0x10], 0xffff
    sbb WORD PTR [rip + 0x1000], 0xffff
    sbb WORD PTR [rip + 0x100], 0xffff
    sbb WORD PTR [rbx], 0xffff
    sbb WORD PTR [rax + rbx*4 + 0x100], 0xffff
    sbb WORD PTR [rax], 0xffff

// === SBB r32, imm32 ===
    sbb ebx, 0xffffffff
    sbb ecx, 0xffffffff
    sbb eax, 0xffffffff
    sbb edx, 0xffffffff
    sbb edi, 0xffffffff
    sbb esi, 0xffffffff

// === SBB m32, imm32 ===
    sbb DWORD PTR [rax], 0xffffffff
    sbb DWORD PTR [rip + 0x100], 0xffffffff
    sbb DWORD PTR [rip + 0x1000], 0xffffffff
    sbb DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    sbb DWORD PTR [rbx], 0xffffffff
    sbb DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === SBB r64, imm32 ===
    sbb r11, 0x7fffffff
    sbb rsi, -1
    sbb rcx, -1
    sbb r9, -1
    sbb r8, 0x7fffffff
    sbb rdx, 0x7fffffff
    sbb r12, 0x7fffffff
    sbb rcx, 0x7fffffff
    sbb r8, -1
    sbb rdi, -1

// === SBB m64, imm32 ===
    sbb QWORD PTR [rbx], -1
    sbb QWORD PTR [rax], 0x7fffffff
    sbb QWORD PTR [rax + rbx*1 + 0x10], -1
    sbb QWORD PTR [rip + 0x1000], 0x7fffffff
    sbb QWORD PTR [rax], -1
    sbb QWORD PTR [rip + 0x1000], -1
    sbb QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    sbb QWORD PTR [rip + 0x100], -1
    sbb QWORD PTR [rip + 0x100], 0x7fffffff
    sbb QWORD PTR [rax + rbx*4 + 0x100], -1

// === SBB r16, imm8 ===
    sbb di, 0xff
    sbb bx, 0xff
    sbb cx, 0xff
    sbb si, 0xff
    sbb dx, 0xff
    sbb ax, 0xff

// === SBB m16, imm8 ===
    sbb WORD PTR [rax + rbx*4 + 0x100], 0xff
    sbb WORD PTR [rip + 0x1000], 0xff
    sbb WORD PTR [rip + 0x100], 0xff
    sbb WORD PTR [rax + rbx*1 + 0x10], 0xff
    sbb WORD PTR [rax], 0xff
    sbb WORD PTR [rbx], 0xff

// === SBB r32, imm8 ===
    sbb esi, 0xff
    sbb eax, 0xff
    sbb edx, 0xff
    sbb ecx, 0xff
    sbb edi, 0xff
    sbb ebx, 0xff

// === SBB m32, imm8 ===
    sbb DWORD PTR [rax + rbx*1 + 0x10], 0xff
    sbb DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sbb DWORD PTR [rip + 0x1000], 0xff
    sbb DWORD PTR [rbx], 0xff
    sbb DWORD PTR [rax], 0xff
    sbb DWORD PTR [rip + 0x100], 0xff

// === SBB r64, imm8 ===
    sbb r12, 0xff
    sbb rdi, 0xff
    sbb r8, 0xff
    sbb rsi, 0xff
    sbb r13, 0xff
    sbb rdx, 0xff
    sbb rcx, 0xff
    sbb r9, 0xff
    sbb r11, 0xff
    sbb rbx, 0xff

// === SBB m64, imm8 ===
    sbb QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sbb QWORD PTR [rbx], 0xff
    sbb QWORD PTR [rax + rbx*1 + 0x10], 0xff
    sbb QWORD PTR [rip + 0x100], 0xff
    sbb QWORD PTR [rax], 0xff
    sbb QWORD PTR [rip + 0x1000], 0xff

// === SBB r8, r8 ===
    sbb dl, dl
    sbb al, bl
    sbb al, al
    sbb bl, dl
    sbb al, cl
    sbb cl, bl
    sbb dl, bl
    sbb cl, dl
    sbb bl, al
    sbb bl, cl

// === SBB m8, r8 ===
    sbb BYTE PTR [rip + 0x1000], cl
    sbb BYTE PTR [rax + rbx*1 + 0x10], cl
    sbb BYTE PTR [rbx], cl
    sbb BYTE PTR [rip + 0x1000], al
    sbb BYTE PTR [rax + rbx*4 + 0x100], dl
    sbb BYTE PTR [rax + rbx*4 + 0x100], al
    sbb BYTE PTR [rax + rbx*1 + 0x10], dl
    sbb BYTE PTR [rip + 0x100], al
    sbb BYTE PTR [rip + 0x100], dl
    sbb BYTE PTR [rax], dl

// === SBB r16, r16 ===
    sbb di, dx
    sbb si, dx
    sbb ax, bx
    sbb si, si
    sbb di, si
    sbb di, cx
    sbb dx, dx
    sbb dx, si
    sbb ax, di
    sbb cx, cx

// === SBB m16, r16 ===
    sbb WORD PTR [rip + 0x1000], cx
    sbb WORD PTR [rax + rbx*1 + 0x10], bx
    sbb WORD PTR [rax + rbx*4 + 0x100], si
    sbb WORD PTR [rax + rbx*1 + 0x10], di
    sbb WORD PTR [rbx], dx
    sbb WORD PTR [rip + 0x1000], si
    sbb WORD PTR [rbx], bx
    sbb WORD PTR [rbx], si
    sbb WORD PTR [rip + 0x1000], ax
    sbb WORD PTR [rbx], di

// === SBB r32, r32 ===
    sbb edi, edi
    sbb edi, eax
    sbb ebx, ecx
    sbb ebx, esi
    sbb eax, esi
    sbb edi, ecx
    sbb eax, eax
    sbb edi, edx
    sbb ecx, edx
    sbb edx, ecx

// === SBB m32, r32 ===
    sbb DWORD PTR [rbx], esi
    sbb DWORD PTR [rax + rbx*1 + 0x10], edx
    sbb DWORD PTR [rax], ecx
    sbb DWORD PTR [rax + rbx*1 + 0x10], ebx
    sbb DWORD PTR [rip + 0x100], esi
    sbb DWORD PTR [rbx], edi
    sbb DWORD PTR [rax + rbx*4 + 0x100], esi
    sbb DWORD PTR [rip + 0x100], ecx
    sbb DWORD PTR [rax + rbx*4 + 0x100], eax
    sbb DWORD PTR [rax + rbx*1 + 0x10], ecx

// === SBB r64, r64 ===
    sbb rax, rax
    sbb r12, r10
    sbb rsi, r13
    sbb rdi, r13
    sbb rdx, rcx
    sbb r13, r13
    sbb rbx, r9
    sbb rdx, r10
    sbb r8, rax
    sbb rdx, rdx

// === SBB m64, r64 ===
    sbb QWORD PTR [rip + 0x1000], r13
    sbb QWORD PTR [rip + 0x1000], rsi
    sbb QWORD PTR [rax + rbx*1 + 0x10], rsi
    sbb QWORD PTR [rbx], r8
    sbb QWORD PTR [rip + 0x100], r11
    sbb QWORD PTR [rbx], rcx
    sbb QWORD PTR [rax + rbx*1 + 0x10], r12
    sbb QWORD PTR [rbx], rdi
    sbb QWORD PTR [rip + 0x1000], rcx
    sbb QWORD PTR [rbx], r13

// === SBB r8, m8 ===
    sbb dl, BYTE PTR [rax + rbx*4 + 0x100]
    sbb cl, BYTE PTR [rax + rbx*1 + 0x10]
    sbb bl, BYTE PTR [rip + 0x1000]
    sbb al, BYTE PTR [rbx]
    sbb dl, BYTE PTR [rbx]
    sbb cl, BYTE PTR [rax + rbx*4 + 0x100]
    sbb al, BYTE PTR [rip + 0x100]
    sbb al, BYTE PTR [rax]
    sbb al, BYTE PTR [rax + rbx*1 + 0x10]
    sbb bl, BYTE PTR [rip + 0x100]

// === SBB r16, m16 ===
    sbb di, WORD PTR [rip + 0x100]
    sbb cx, WORD PTR [rax + rbx*1 + 0x10]
    sbb si, WORD PTR [rbx]
    sbb si, WORD PTR [rax + rbx*1 + 0x10]
    sbb ax, WORD PTR [rip + 0x1000]
    sbb dx, WORD PTR [rbx]
    sbb bx, WORD PTR [rax + rbx*4 + 0x100]
    sbb bx, WORD PTR [rbx]
    sbb si, WORD PTR [rax]
    sbb cx, WORD PTR [rax + rbx*4 + 0x100]

// === SBB r32, m32 ===
    sbb esi, DWORD PTR [rax + rbx*4 + 0x100]
    sbb eax, DWORD PTR [rip + 0x100]
    sbb ecx, DWORD PTR [rip + 0x1000]
    sbb esi, DWORD PTR [rip + 0x1000]
    sbb edi, DWORD PTR [rax + rbx*1 + 0x10]
    sbb edx, DWORD PTR [rax + rbx*4 + 0x100]
    sbb ecx, DWORD PTR [rip + 0x100]
    sbb edi, DWORD PTR [rip + 0x100]
    sbb edx, DWORD PTR [rax + rbx*1 + 0x10]
    sbb eax, DWORD PTR [rax + rbx*1 + 0x10]

// === SBB r64, m64 ===
    sbb r12, QWORD PTR [rip + 0x100]
    sbb rdx, QWORD PTR [rax]
    sbb rsi, QWORD PTR [rax + rbx*1 + 0x10]
    sbb r10, QWORD PTR [rax]
    sbb rdx, QWORD PTR [rip + 0x1000]
    sbb rsi, QWORD PTR [rip + 0x1000]
    sbb rdi, QWORD PTR [rip + 0x1000]
    sbb r9, QWORD PTR [rip + 0x100]
    sbb r13, QWORD PTR [rax]
    sbb rbx, QWORD PTR [rip + 0x1000]

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
    seta bl
    seta cl
    seta al
    seta dl

// === SETA m8 ===
    seta BYTE PTR [rip + 0x1000]
    seta BYTE PTR [rax + rbx*1 + 0x10]
    seta BYTE PTR [rax + rbx*4 + 0x100]
    seta BYTE PTR [rbx]
    seta BYTE PTR [rip + 0x100]
    seta BYTE PTR [rax]

// === SETAE r8 ===
    setae dl
    setae al
    setae cl
    setae bl

// === SETAE m8 ===
    setae BYTE PTR [rax + rbx*1 + 0x10]
    setae BYTE PTR [rip + 0x100]
    setae BYTE PTR [rip + 0x1000]
    setae BYTE PTR [rax]
    setae BYTE PTR [rbx]
    setae BYTE PTR [rax + rbx*4 + 0x100]

// === SETB r8 ===
    setb bl
    setb al
    setb cl
    setb dl

// === SETB m8 ===
    setb BYTE PTR [rax + rbx*1 + 0x10]
    setb BYTE PTR [rax]
    setb BYTE PTR [rip + 0x100]
    setb BYTE PTR [rip + 0x1000]
    setb BYTE PTR [rbx]
    setb BYTE PTR [rax + rbx*4 + 0x100]

// === SETBE r8 ===
    setbe al
    setbe dl
    setbe bl
    setbe cl

// === SETBE m8 ===
    setbe BYTE PTR [rax + rbx*4 + 0x100]
    setbe BYTE PTR [rax]
    setbe BYTE PTR [rip + 0x1000]
    setbe BYTE PTR [rax + rbx*1 + 0x10]
    setbe BYTE PTR [rbx]
    setbe BYTE PTR [rip + 0x100]

// === SETC r8 ===
    setc al
    setc bl
    setc cl
    setc dl

// === SETC m8 ===
    setc BYTE PTR [rip + 0x1000]
    setc BYTE PTR [rbx]
    setc BYTE PTR [rax + rbx*4 + 0x100]
    setc BYTE PTR [rip + 0x100]
    setc BYTE PTR [rax + rbx*1 + 0x10]
    setc BYTE PTR [rax]

// === SETE r8 ===
    sete bl
    sete cl
    sete dl
    sete al

// === SETE m8 ===
    sete BYTE PTR [rax + rbx*1 + 0x10]
    sete BYTE PTR [rax + rbx*4 + 0x100]
    sete BYTE PTR [rax]
    sete BYTE PTR [rip + 0x1000]
    sete BYTE PTR [rip + 0x100]
    sete BYTE PTR [rbx]

// === SETG r8 ===
    setg dl
    setg bl
    setg al
    setg cl

// === SETG m8 ===
    setg BYTE PTR [rip + 0x1000]
    setg BYTE PTR [rax + rbx*1 + 0x10]
    setg BYTE PTR [rbx]
    setg BYTE PTR [rax]
    setg BYTE PTR [rip + 0x100]
    setg BYTE PTR [rax + rbx*4 + 0x100]

// === SETGE r8 ===
    setge bl
    setge dl
    setge cl
    setge al

// === SETGE m8 ===
    setge BYTE PTR [rax]
    setge BYTE PTR [rbx]
    setge BYTE PTR [rax + rbx*4 + 0x100]
    setge BYTE PTR [rip + 0x1000]
    setge BYTE PTR [rip + 0x100]
    setge BYTE PTR [rax + rbx*1 + 0x10]

// === SETL r8 ===
    setl bl
    setl dl
    setl al
    setl cl

// === SETL m8 ===
    setl BYTE PTR [rax]
    setl BYTE PTR [rip + 0x100]
    setl BYTE PTR [rax + rbx*1 + 0x10]
    setl BYTE PTR [rax + rbx*4 + 0x100]
    setl BYTE PTR [rip + 0x1000]
    setl BYTE PTR [rbx]

// === SETLE r8 ===
    setle al
    setle cl
    setle bl
    setle dl

// === SETLE m8 ===
    setle BYTE PTR [rax + rbx*4 + 0x100]
    setle BYTE PTR [rax + rbx*1 + 0x10]
    setle BYTE PTR [rax]
    setle BYTE PTR [rbx]
    setle BYTE PTR [rip + 0x100]
    setle BYTE PTR [rip + 0x1000]

// === SETNA r8 ===
    setna al
    setna bl
    setna cl
    setna dl

// === SETNA m8 ===
    setna BYTE PTR [rax]
    setna BYTE PTR [rip + 0x100]
    setna BYTE PTR [rip + 0x1000]
    setna BYTE PTR [rax + rbx*1 + 0x10]
    setna BYTE PTR [rax + rbx*4 + 0x100]
    setna BYTE PTR [rbx]

// === SETNAE r8 ===
    setnae bl
    setnae al
    setnae cl
    setnae dl

// === SETNAE m8 ===
    setnae BYTE PTR [rip + 0x100]
    setnae BYTE PTR [rip + 0x1000]
    setnae BYTE PTR [rax]
    setnae BYTE PTR [rbx]
    setnae BYTE PTR [rax + rbx*4 + 0x100]
    setnae BYTE PTR [rax + rbx*1 + 0x10]

// === SETNB r8 ===
    setnb cl
    setnb al
    setnb bl
    setnb dl

// === SETNB m8 ===
    setnb BYTE PTR [rbx]
    setnb BYTE PTR [rax]
    setnb BYTE PTR [rip + 0x1000]
    setnb BYTE PTR [rip + 0x100]
    setnb BYTE PTR [rax + rbx*1 + 0x10]
    setnb BYTE PTR [rax + rbx*4 + 0x100]

// === SETNBE r8 ===
    setnbe cl
    setnbe bl
    setnbe al
    setnbe dl

// === SETNBE m8 ===
    setnbe BYTE PTR [rax + rbx*1 + 0x10]
    setnbe BYTE PTR [rip + 0x100]
    setnbe BYTE PTR [rip + 0x1000]
    setnbe BYTE PTR [rax]
    setnbe BYTE PTR [rax + rbx*4 + 0x100]
    setnbe BYTE PTR [rbx]

// === SETNC r8 ===
    setnc dl
    setnc cl
    setnc bl
    setnc al

// === SETNC m8 ===
    setnc BYTE PTR [rip + 0x1000]
    setnc BYTE PTR [rax + rbx*1 + 0x10]
    setnc BYTE PTR [rbx]
    setnc BYTE PTR [rax + rbx*4 + 0x100]
    setnc BYTE PTR [rax]
    setnc BYTE PTR [rip + 0x100]

// === SETNE r8 ===
    setne bl
    setne dl
    setne cl
    setne al

// === SETNE m8 ===
    setne BYTE PTR [rax + rbx*1 + 0x10]
    setne BYTE PTR [rax + rbx*4 + 0x100]
    setne BYTE PTR [rip + 0x100]
    setne BYTE PTR [rax]
    setne BYTE PTR [rip + 0x1000]
    setne BYTE PTR [rbx]

// === SETNG r8 ===
    setng dl
    setng al
    setng cl
    setng bl

// === SETNG m8 ===
    setng BYTE PTR [rbx]
    setng BYTE PTR [rip + 0x1000]
    setng BYTE PTR [rax]
    setng BYTE PTR [rax + rbx*4 + 0x100]
    setng BYTE PTR [rax + rbx*1 + 0x10]
    setng BYTE PTR [rip + 0x100]

// === SETNGE r8 ===
    setnge al
    setnge dl
    setnge bl
    setnge cl

// === SETNGE m8 ===
    setnge BYTE PTR [rax]
    setnge BYTE PTR [rax + rbx*4 + 0x100]
    setnge BYTE PTR [rip + 0x1000]
    setnge BYTE PTR [rbx]
    setnge BYTE PTR [rax + rbx*1 + 0x10]
    setnge BYTE PTR [rip + 0x100]

// === SETNL r8 ===
    setnl dl
    setnl bl
    setnl cl
    setnl al

// === SETNL m8 ===
    setnl BYTE PTR [rax + rbx*1 + 0x10]
    setnl BYTE PTR [rax]
    setnl BYTE PTR [rip + 0x1000]
    setnl BYTE PTR [rbx]
    setnl BYTE PTR [rip + 0x100]
    setnl BYTE PTR [rax + rbx*4 + 0x100]

// === SETNLE r8 ===
    setnle cl
    setnle dl
    setnle bl
    setnle al

// === SETNLE m8 ===
    setnle BYTE PTR [rax + rbx*1 + 0x10]
    setnle BYTE PTR [rip + 0x100]
    setnle BYTE PTR [rax + rbx*4 + 0x100]
    setnle BYTE PTR [rbx]
    setnle BYTE PTR [rip + 0x1000]
    setnle BYTE PTR [rax]

// === SETNO r8 ===
    setno cl
    setno bl
    setno dl
    setno al

// === SETNO m8 ===
    setno BYTE PTR [rip + 0x1000]
    setno BYTE PTR [rax + rbx*4 + 0x100]
    setno BYTE PTR [rax]
    setno BYTE PTR [rbx]
    setno BYTE PTR [rax + rbx*1 + 0x10]
    setno BYTE PTR [rip + 0x100]

// === SETNP r8 ===
    setnp dl
    setnp cl
    setnp bl
    setnp al

// === SETNP m8 ===
    setnp BYTE PTR [rax + rbx*1 + 0x10]
    setnp BYTE PTR [rip + 0x100]
    setnp BYTE PTR [rax]
    setnp BYTE PTR [rip + 0x1000]
    setnp BYTE PTR [rax + rbx*4 + 0x100]
    setnp BYTE PTR [rbx]

// === SETNS r8 ===
    setns dl
    setns cl
    setns bl
    setns al

// === SETNS m8 ===
    setns BYTE PTR [rip + 0x1000]
    setns BYTE PTR [rip + 0x100]
    setns BYTE PTR [rbx]
    setns BYTE PTR [rax + rbx*1 + 0x10]
    setns BYTE PTR [rax + rbx*4 + 0x100]
    setns BYTE PTR [rax]

// === SETNZ r8 ===
    setnz bl
    setnz cl
    setnz al
    setnz dl

// === SETNZ m8 ===
    setnz BYTE PTR [rip + 0x1000]
    setnz BYTE PTR [rbx]
    setnz BYTE PTR [rax]
    setnz BYTE PTR [rip + 0x100]
    setnz BYTE PTR [rax + rbx*1 + 0x10]
    setnz BYTE PTR [rax + rbx*4 + 0x100]

// === SETO r8 ===
    seto dl
    seto cl
    seto bl
    seto al

// === SETO m8 ===
    seto BYTE PTR [rax + rbx*1 + 0x10]
    seto BYTE PTR [rax + rbx*4 + 0x100]
    seto BYTE PTR [rax]
    seto BYTE PTR [rip + 0x1000]
    seto BYTE PTR [rbx]
    seto BYTE PTR [rip + 0x100]

// === SETP r8 ===
    setp dl
    setp al
    setp cl
    setp bl

// === SETP m8 ===
    setp BYTE PTR [rax + rbx*4 + 0x100]
    setp BYTE PTR [rbx]
    setp BYTE PTR [rip + 0x1000]
    setp BYTE PTR [rax]
    setp BYTE PTR [rax + rbx*1 + 0x10]
    setp BYTE PTR [rip + 0x100]

// === SETPE r8 ===
    setpe al
    setpe cl
    setpe dl
    setpe bl

// === SETPE m8 ===
    setpe BYTE PTR [rax + rbx*1 + 0x10]
    setpe BYTE PTR [rip + 0x1000]
    setpe BYTE PTR [rbx]
    setpe BYTE PTR [rip + 0x100]
    setpe BYTE PTR [rax]
    setpe BYTE PTR [rax + rbx*4 + 0x100]

// === SETPO r8 ===
    setpo bl
    setpo cl
    setpo al
    setpo dl

// === SETPO m8 ===
    setpo BYTE PTR [rip + 0x100]
    setpo BYTE PTR [rip + 0x1000]
    setpo BYTE PTR [rax]
    setpo BYTE PTR [rax + rbx*4 + 0x100]
    setpo BYTE PTR [rbx]
    setpo BYTE PTR [rax + rbx*1 + 0x10]

// === SETS r8 ===
    sets al
    sets cl
    sets bl
    sets dl

// === SETS m8 ===
    sets BYTE PTR [rax + rbx*1 + 0x10]
    sets BYTE PTR [rbx]
    sets BYTE PTR [rip + 0x1000]
    sets BYTE PTR [rip + 0x100]
    sets BYTE PTR [rax]
    sets BYTE PTR [rax + rbx*4 + 0x100]

// === SETZ r8 ===
    setz dl
    setz bl
    setz al
    setz cl

// === SETZ m8 ===
    setz BYTE PTR [rax + rbx*4 + 0x100]
    setz BYTE PTR [rax]
    setz BYTE PTR [rip + 0x100]
    setz BYTE PTR [rbx]
    setz BYTE PTR [rax + rbx*1 + 0x10]
    setz BYTE PTR [rip + 0x1000]

// === SFENCE ===
    sfence

// === SHLD r16, r16, imm8 ===
    shld cx, si, 0xff
    shld dx, si, 0xff
    shld cx, cx, 0xff
    shld dx, dx, 0xff
    shld ax, bx, 0xff
    shld cx, dx, 0xff
    shld ax, si, 0xff
    shld si, cx, 0xff
    shld ax, cx, 0xff
    shld dx, ax, 0xff

// === SHLD m16, r16, imm8 ===
    shld WORD PTR [rip + 0x100], bx, 0xff
    shld WORD PTR [rip + 0x100], cx, 0xff
    shld WORD PTR [rip + 0x100], si, 0xff
    shld WORD PTR [rbx], cx, 0xff
    shld WORD PTR [rip + 0x1000], ax, 0xff
    shld WORD PTR [rip + 0x1000], cx, 0xff
    shld WORD PTR [rax + rbx*1 + 0x10], dx, 0xff
    shld WORD PTR [rax + rbx*1 + 0x10], di, 0xff
    shld WORD PTR [rax + rbx*4 + 0x100], cx, 0xff
    shld WORD PTR [rip + 0x1000], bx, 0xff

// === SHLD r16, r16, CL ===
    shld si, di, cl
    shld ax, si, cl
    shld di, cx, cl
    shld cx, cx, cl
    shld bx, ax, cl
    shld di, ax, cl
    shld dx, bx, cl
    shld bx, di, cl
    shld di, di, cl
    shld ax, di, cl

// === SHLD m16, r16, CL ===
    shld WORD PTR [rip + 0x1000], di, cl
    shld WORD PTR [rax + rbx*1 + 0x10], cx, cl
    shld WORD PTR [rax + rbx*1 + 0x10], dx, cl
    shld WORD PTR [rip + 0x100], dx, cl
    shld WORD PTR [rax + rbx*4 + 0x100], ax, cl
    shld WORD PTR [rax], di, cl
    shld WORD PTR [rax + rbx*4 + 0x100], bx, cl
    shld WORD PTR [rax + rbx*1 + 0x10], bx, cl
    shld WORD PTR [rip + 0x100], ax, cl
    shld WORD PTR [rax], ax, cl

// === SHLD r32, r32, imm8 ===
    shld ecx, edx, 0xff
    shld ecx, ecx, 0xff
    shld edx, eax, 0xff
    shld ebx, esi, 0xff
    shld esi, edi, 0xff
    shld esi, edx, 0xff
    shld edi, ebx, 0xff
    shld eax, edx, 0xff
    shld edx, edx, 0xff
    shld esi, ecx, 0xff

// === SHLD m32, r32, imm8 ===
    shld DWORD PTR [rax + rbx*1 + 0x10], ecx, 0xff
    shld DWORD PTR [rax], edx, 0xff
    shld DWORD PTR [rip + 0x1000], ebx, 0xff
    shld DWORD PTR [rip + 0x1000], edx, 0xff
    shld DWORD PTR [rax + rbx*1 + 0x10], ebx, 0xff
    shld DWORD PTR [rbx], ebx, 0xff
    shld DWORD PTR [rbx], ecx, 0xff
    shld DWORD PTR [rax + rbx*1 + 0x10], eax, 0xff
    shld DWORD PTR [rax], eax, 0xff
    shld DWORD PTR [rbx], edi, 0xff

// === SHLD r64, r64, imm8 ===
    shld rsi, rbx, 0xff
    shld r13, rsi, 0xff
    shld rbx, r9, 0xff
    shld r11, rdx, 0xff
    shld r8, rdx, 0xff
    shld rcx, rax, 0xff
    shld r10, rax, 0xff
    shld r11, r8, 0xff
    shld r10, rsi, 0xff
    shld rax, rdx, 0xff

// === SHLD m64, r64, imm8 ===
    shld QWORD PTR [rax + rbx*4 + 0x100], r8, 0xff
    shld QWORD PTR [rax + rbx*1 + 0x10], rcx, 0xff
    shld QWORD PTR [rax + rbx*4 + 0x100], r13, 0xff
    shld QWORD PTR [rbx], rax, 0xff
    shld QWORD PTR [rbx], r9, 0xff
    shld QWORD PTR [rax + rbx*1 + 0x10], rbx, 0xff
    shld QWORD PTR [rip + 0x1000], r12, 0xff
    shld QWORD PTR [rip + 0x1000], rdi, 0xff
    shld QWORD PTR [rax + rbx*1 + 0x10], r13, 0xff
    shld QWORD PTR [rip + 0x100], rbx, 0xff

// === SHLD r32, r32, CL ===
    shld edi, ebx, cl
    shld edx, edi, cl
    shld ebx, esi, cl
    shld ecx, ecx, cl
    shld edx, eax, cl
    shld esi, edi, cl
    shld ebx, eax, cl
    shld edi, edx, cl
    shld ecx, eax, cl
    shld ecx, edi, cl

// === SHLD m32, r32, CL ===
    shld DWORD PTR [rip + 0x1000], esi, cl
    shld DWORD PTR [rbx], edx, cl
    shld DWORD PTR [rax + rbx*1 + 0x10], ebx, cl
    shld DWORD PTR [rbx], ecx, cl
    shld DWORD PTR [rip + 0x100], ecx, cl
    shld DWORD PTR [rax + rbx*4 + 0x100], ecx, cl
    shld DWORD PTR [rax + rbx*4 + 0x100], edi, cl
    shld DWORD PTR [rip + 0x100], esi, cl
    shld DWORD PTR [rax + rbx*4 + 0x100], ebx, cl
    shld DWORD PTR [rax + rbx*1 + 0x10], ecx, cl

// === SHLD r64, r64, CL ===
    shld r13, r8, cl
    shld r11, rcx, cl
    shld rbx, r13, cl
    shld r9, rax, cl
    shld rsi, r13, cl
    shld r13, rdi, cl
    shld rcx, rcx, cl
    shld rcx, rax, cl
    shld rbx, r10, cl
    shld rbx, r9, cl

// === SHLD m64, r64, CL ===
    shld QWORD PTR [rip + 0x1000], rcx, cl
    shld QWORD PTR [rax], rax, cl
    shld QWORD PTR [rax + rbx*4 + 0x100], r8, cl
    shld QWORD PTR [rip + 0x1000], rdx, cl
    shld QWORD PTR [rip + 0x100], rdx, cl
    shld QWORD PTR [rbx], r12, cl
    shld QWORD PTR [rbx], r9, cl
    shld QWORD PTR [rip + 0x100], r8, cl
    shld QWORD PTR [rax + rbx*1 + 0x10], rax, cl
    shld QWORD PTR [rax + rbx*4 + 0x100], rbx, cl

// === SHRD r16, r16, imm8 ===
    shrd cx, dx, 0xff
    shrd si, si, 0xff
    shrd ax, dx, 0xff
    shrd dx, cx, 0xff
    shrd cx, di, 0xff
    shrd bx, dx, 0xff
    shrd ax, di, 0xff
    shrd bx, di, 0xff
    shrd cx, si, 0xff
    shrd dx, dx, 0xff

// === SHRD m16, r16, imm8 ===
    shrd WORD PTR [rax], bx, 0xff
    shrd WORD PTR [rax + rbx*1 + 0x10], dx, 0xff
    shrd WORD PTR [rip + 0x100], di, 0xff
    shrd WORD PTR [rip + 0x1000], si, 0xff
    shrd WORD PTR [rip + 0x100], dx, 0xff
    shrd WORD PTR [rbx], di, 0xff
    shrd WORD PTR [rax], di, 0xff
    shrd WORD PTR [rax], ax, 0xff
    shrd WORD PTR [rip + 0x100], si, 0xff
    shrd WORD PTR [rip + 0x100], ax, 0xff

// === SHRD r16, r16, CL ===
    shrd si, bx, cl
    shrd bx, cx, cl
    shrd si, si, cl
    shrd dx, si, cl
    shrd ax, dx, cl
    shrd cx, bx, cl
    shrd ax, cx, cl
    shrd di, cx, cl
    shrd si, cx, cl
    shrd dx, di, cl

// === SHRD m16, r16, CL ===
    shrd WORD PTR [rbx], ax, cl
    shrd WORD PTR [rax], si, cl
    shrd WORD PTR [rax + rbx*1 + 0x10], cx, cl
    shrd WORD PTR [rip + 0x100], si, cl
    shrd WORD PTR [rip + 0x100], dx, cl
    shrd WORD PTR [rax + rbx*1 + 0x10], si, cl
    shrd WORD PTR [rip + 0x1000], dx, cl
    shrd WORD PTR [rax + rbx*1 + 0x10], di, cl
    shrd WORD PTR [rbx], cx, cl
    shrd WORD PTR [rax], dx, cl

// === SHRD r32, r32, imm8 ===
    shrd ecx, edx, 0xff
    shrd edx, ebx, 0xff
    shrd edx, edx, 0xff
    shrd ecx, edi, 0xff
    shrd esi, ecx, 0xff
    shrd ebx, edx, 0xff
    shrd edi, ebx, 0xff
    shrd esi, eax, 0xff
    shrd eax, ebx, 0xff
    shrd eax, eax, 0xff

// === SHRD m32, r32, imm8 ===
    shrd DWORD PTR [rip + 0x100], edi, 0xff
    shrd DWORD PTR [rax + rbx*4 + 0x100], edx, 0xff
    shrd DWORD PTR [rax + rbx*4 + 0x100], esi, 0xff
    shrd DWORD PTR [rbx], edi, 0xff
    shrd DWORD PTR [rip + 0x1000], ecx, 0xff
    shrd DWORD PTR [rax + rbx*1 + 0x10], esi, 0xff
    shrd DWORD PTR [rax], edx, 0xff
    shrd DWORD PTR [rax + rbx*1 + 0x10], edx, 0xff
    shrd DWORD PTR [rax + rbx*4 + 0x100], edi, 0xff
    shrd DWORD PTR [rip + 0x1000], ebx, 0xff

// === SHRD r64, r64, imm8 ===
    shrd r13, r9, 0xff
    shrd r12, rsi, 0xff
    shrd rax, rsi, 0xff
    shrd r8, rdx, 0xff
    shrd rbx, rax, 0xff
    shrd r13, r11, 0xff
    shrd r13, r12, 0xff
    shrd rcx, r11, 0xff
    shrd r8, r11, 0xff
    shrd rax, r12, 0xff

// === SHRD m64, r64, imm8 ===
    shrd QWORD PTR [rax + rbx*1 + 0x10], rdx, 0xff
    shrd QWORD PTR [rip + 0x100], r11, 0xff
    shrd QWORD PTR [rax + rbx*1 + 0x10], rbx, 0xff
    shrd QWORD PTR [rip + 0x100], rdi, 0xff
    shrd QWORD PTR [rax], rax, 0xff
    shrd QWORD PTR [rax + rbx*1 + 0x10], r9, 0xff
    shrd QWORD PTR [rip + 0x1000], rbx, 0xff
    shrd QWORD PTR [rax], r9, 0xff
    shrd QWORD PTR [rip + 0x100], rax, 0xff
    shrd QWORD PTR [rax + rbx*4 + 0x100], r13, 0xff

// === SHRD r32, r32, CL ===
    shrd esi, ebx, cl
    shrd ecx, ebx, cl
    shrd ebx, esi, cl
    shrd ebx, edi, cl
    shrd edx, ebx, cl
    shrd edi, edx, cl
    shrd esi, edi, cl
    shrd esi, eax, cl
    shrd edx, edi, cl
    shrd ecx, ecx, cl

// === SHRD m32, r32, CL ===
    shrd DWORD PTR [rax + rbx*1 + 0x10], edx, cl
    shrd DWORD PTR [rip + 0x1000], eax, cl
    shrd DWORD PTR [rip + 0x100], edx, cl
    shrd DWORD PTR [rbx], edx, cl
    shrd DWORD PTR [rip + 0x1000], esi, cl
    shrd DWORD PTR [rbx], eax, cl
    shrd DWORD PTR [rax + rbx*4 + 0x100], esi, cl
    shrd DWORD PTR [rbx], esi, cl
    shrd DWORD PTR [rax + rbx*4 + 0x100], eax, cl
    shrd DWORD PTR [rax], ecx, cl

// === SHRD r64, r64, CL ===
    shrd rdx, rdx, cl
    shrd rdx, r10, cl
    shrd r12, rax, cl
    shrd r9, rdi, cl
    shrd r12, r13, cl
    shrd r8, r8, cl
    shrd r10, r8, cl
    shrd r11, rbx, cl
    shrd rsi, r11, cl
    shrd rax, r12, cl

// === SHRD m64, r64, CL ===
    shrd QWORD PTR [rax], rdi, cl
    shrd QWORD PTR [rip + 0x100], r12, cl
    shrd QWORD PTR [rip + 0x1000], rdi, cl
    shrd QWORD PTR [rax], r8, cl
    shrd QWORD PTR [rip + 0x100], r10, cl
    shrd QWORD PTR [rbx], r10, cl
    shrd QWORD PTR [rip + 0x100], r8, cl
    shrd QWORD PTR [rax + rbx*1 + 0x10], r10, cl
    shrd QWORD PTR [rax + rbx*4 + 0x100], r11, cl
    shrd QWORD PTR [rbx], rsi, cl

// === SLDT r16 ===
    sldt si
    sldt bx
    sldt cx
    sldt ax
    sldt di
    sldt dx

// === SLDT m16 ===
    sldt WORD PTR [rbx]
    sldt WORD PTR [rip + 0x1000]
    sldt WORD PTR [rax]
    sldt WORD PTR [rax + rbx*4 + 0x100]
    sldt WORD PTR [rax + rbx*1 + 0x10]
    sldt WORD PTR [rip + 0x100]

// === SMSW r16 ===
    smsw di
    smsw si
    smsw bx
    smsw ax
    smsw dx
    smsw cx

// === SMSW m16 ===
    smsw WORD PTR [rax + rbx*1 + 0x10]
    smsw WORD PTR [rax + rbx*4 + 0x100]
    smsw WORD PTR [rip + 0x100]
    smsw WORD PTR [rax]
    smsw WORD PTR [rbx]
    smsw WORD PTR [rip + 0x1000]

// === SMSW r32/m16 ===
    smsw WORD PTR [rip + 0x100]
    smsw WORD PTR [rip + 0x1000]
    smsw WORD PTR [rbx]
    smsw WORD PTR [rax]
    smsw WORD PTR [rax + rbx*1 + 0x10]
    smsw WORD PTR [rax + rbx*4 + 0x100]

// === SMSW r64/m16 ===
    smsw WORD PTR [rbx]
    smsw WORD PTR [rax + rbx*1 + 0x10]
    smsw WORD PTR [rip + 0x1000]
    smsw WORD PTR [rax]
    smsw WORD PTR [rax + rbx*4 + 0x100]
    smsw WORD PTR [rip + 0x100]

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
    str si
    str bx
    str dx
    str cx
    str ax
    str di

// === STR m16 ===
    str WORD PTR [rip + 0x1000]
    str WORD PTR [rax + rbx*4 + 0x100]
    str WORD PTR [rip + 0x100]
    str WORD PTR [rax + rbx*1 + 0x10]
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
    sub cl, 0xff
    sub bl, 0xff
    sub al, 0xff
    sub dl, 0xff

// === SUB m8, imm8 ===
    sub BYTE PTR [rip + 0x1000], 0xff
    sub BYTE PTR [rbx], 0xff
    sub BYTE PTR [rax], 0xff
    sub BYTE PTR [rax + rbx*1 + 0x10], 0xff
    sub BYTE PTR [rax + rbx*4 + 0x100], 0xff
    sub BYTE PTR [rip + 0x100], 0xff

// === SUB r16, imm16 ===
    sub di, 0xffff
    sub bx, 0xffff
    sub dx, 0xffff
    sub cx, 0xffff
    sub si, 0xffff
    sub ax, 0xffff

// === SUB m16, imm16 ===
    sub WORD PTR [rbx], 0xffff
    sub WORD PTR [rip + 0x1000], 0xffff
    sub WORD PTR [rip + 0x100], 0xffff
    sub WORD PTR [rax + rbx*1 + 0x10], 0xffff
    sub WORD PTR [rax], 0xffff
    sub WORD PTR [rax + rbx*4 + 0x100], 0xffff

// === SUB r32, imm32 ===
    sub edx, 0xffffffff
    sub esi, 0xffffffff
    sub ebx, 0xffffffff
    sub edi, 0xffffffff
    sub ecx, 0xffffffff
    sub eax, 0xffffffff

// === SUB m32, imm32 ===
    sub DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    sub DWORD PTR [rbx], 0xffffffff
    sub DWORD PTR [rip + 0x1000], 0xffffffff
    sub DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    sub DWORD PTR [rip + 0x100], 0xffffffff
    sub DWORD PTR [rax], 0xffffffff

// === SUB r64, imm32 ===
    sub r11, 0x7fffffff
    sub rdi, 0x7fffffff
    sub rsi, -1
    sub r13, -1
    sub r9, -1
    sub r11, -1
    sub r13, 0x7fffffff
    sub rax, -1
    sub rax, 0x7fffffff
    sub rdi, -1

// === SUB m64, imm32 ===
    sub QWORD PTR [rax], 0x7fffffff
    sub QWORD PTR [rip + 0x100], -1
    sub QWORD PTR [rip + 0x1000], 0x7fffffff
    sub QWORD PTR [rax + rbx*1 + 0x10], -1
    sub QWORD PTR [rax], -1
    sub QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    sub QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    sub QWORD PTR [rip + 0x100], 0x7fffffff
    sub QWORD PTR [rbx], -1
    sub QWORD PTR [rbx], 0x7fffffff

// === SUB r16, imm8 ===
    sub dx, 0xff
    sub bx, 0xff
    sub ax, 0xff
    sub di, 0xff
    sub cx, 0xff
    sub si, 0xff

// === SUB m16, imm8 ===
    sub WORD PTR [rax + rbx*4 + 0x100], 0xff
    sub WORD PTR [rax], 0xff
    sub WORD PTR [rip + 0x100], 0xff
    sub WORD PTR [rax + rbx*1 + 0x10], 0xff
    sub WORD PTR [rbx], 0xff
    sub WORD PTR [rip + 0x1000], 0xff

// === SUB r32, imm8 ===
    sub ebx, 0xff
    sub eax, 0xff
    sub edx, 0xff
    sub edi, 0xff
    sub esi, 0xff
    sub ecx, 0xff

// === SUB m32, imm8 ===
    sub DWORD PTR [rip + 0x1000], 0xff
    sub DWORD PTR [rip + 0x100], 0xff
    sub DWORD PTR [rax + rbx*4 + 0x100], 0xff
    sub DWORD PTR [rbx], 0xff
    sub DWORD PTR [rax], 0xff
    sub DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SUB r64, imm8 ===
    sub r10, 0xff
    sub r12, 0xff
    sub rsi, 0xff
    sub rdi, 0xff
    sub r9, 0xff
    sub rdx, 0xff
    sub rax, 0xff
    sub r11, 0xff
    sub r8, 0xff
    sub rbx, 0xff

// === SUB m64, imm8 ===
    sub QWORD PTR [rip + 0x1000], 0xff
    sub QWORD PTR [rax + rbx*4 + 0x100], 0xff
    sub QWORD PTR [rbx], 0xff
    sub QWORD PTR [rax], 0xff
    sub QWORD PTR [rip + 0x100], 0xff
    sub QWORD PTR [rax + rbx*1 + 0x10], 0xff

// === SUB r8, r8 ===
    sub cl, cl
    sub dl, cl
    sub bl, al
    sub bl, cl
    sub al, al
    sub al, dl
    sub al, cl
    sub dl, al
    sub cl, bl
    sub cl, dl

// === SUB m8, r8 ===
    sub BYTE PTR [rip + 0x1000], dl
    sub BYTE PTR [rax], al
    sub BYTE PTR [rip + 0x100], cl
    sub BYTE PTR [rbx], al
    sub BYTE PTR [rax], bl
    sub BYTE PTR [rax + rbx*1 + 0x10], dl
    sub BYTE PTR [rip + 0x100], dl
    sub BYTE PTR [rax + rbx*4 + 0x100], bl
    sub BYTE PTR [rax + rbx*1 + 0x10], cl
    sub BYTE PTR [rip + 0x1000], al

// === SUB r16, r16 ===
    sub bx, di
    sub di, si
    sub si, cx
    sub dx, cx
    sub di, dx
    sub bx, si
    sub bx, ax
    sub di, cx
    sub cx, cx
    sub ax, bx

// === SUB m16, r16 ===
    sub WORD PTR [rbx], bx
    sub WORD PTR [rax + rbx*1 + 0x10], di
    sub WORD PTR [rip + 0x100], ax
    sub WORD PTR [rbx], ax
    sub WORD PTR [rax], si
    sub WORD PTR [rax + rbx*1 + 0x10], si
    sub WORD PTR [rip + 0x100], dx
    sub WORD PTR [rip + 0x1000], dx
    sub WORD PTR [rip + 0x1000], cx
    sub WORD PTR [rip + 0x1000], di

// === SUB r32, r32 ===
    sub ebx, edi
    sub esi, edx
    sub eax, ecx
    sub edx, esi
    sub ecx, edi
    sub edx, ebx
    sub esi, edi
    sub esi, esi
    sub ecx, ebx
    sub ebx, ebx

// === SUB m32, r32 ===
    sub DWORD PTR [rip + 0x1000], ebx
    sub DWORD PTR [rip + 0x1000], edi
    sub DWORD PTR [rbx], edx
    sub DWORD PTR [rax], ebx
    sub DWORD PTR [rax + rbx*1 + 0x10], eax
    sub DWORD PTR [rip + 0x100], ecx
    sub DWORD PTR [rax + rbx*4 + 0x100], ebx
    sub DWORD PTR [rip + 0x100], esi
    sub DWORD PTR [rax + rbx*1 + 0x10], ebx
    sub DWORD PTR [rax], esi

// === SUB r64, r64 ===
    sub rsi, r13
    sub rbx, r8
    sub r11, r13
    sub r9, rcx
    sub rdx, r9
    sub r12, rdi
    sub rcx, r10
    sub r12, r11
    sub r13, r9
    sub r9, r12

// === SUB m64, r64 ===
    sub QWORD PTR [rax + rbx*1 + 0x10], rax
    sub QWORD PTR [rax], r8
    sub QWORD PTR [rax], r11
    sub QWORD PTR [rip + 0x100], rdi
    sub QWORD PTR [rip + 0x100], rbx
    sub QWORD PTR [rip + 0x1000], rbx
    sub QWORD PTR [rip + 0x100], r12
    sub QWORD PTR [rax + rbx*4 + 0x100], rcx
    sub QWORD PTR [rbx], rbx
    sub QWORD PTR [rax + rbx*1 + 0x10], rbx

// === SUB r8, m8 ===
    sub al, BYTE PTR [rax + rbx*1 + 0x10]
    sub al, BYTE PTR [rax + rbx*4 + 0x100]
    sub dl, BYTE PTR [rip + 0x1000]
    sub cl, BYTE PTR [rax + rbx*1 + 0x10]
    sub al, BYTE PTR [rip + 0x100]
    sub bl, BYTE PTR [rax + rbx*1 + 0x10]
    sub cl, BYTE PTR [rbx]
    sub al, BYTE PTR [rbx]
    sub dl, BYTE PTR [rax]
    sub bl, BYTE PTR [rip + 0x100]

// === SUB r16, m16 ===
    sub di, WORD PTR [rax + rbx*1 + 0x10]
    sub ax, WORD PTR [rip + 0x100]
    sub si, WORD PTR [rbx]
    sub bx, WORD PTR [rbx]
    sub si, WORD PTR [rip + 0x100]
    sub bx, WORD PTR [rax + rbx*4 + 0x100]
    sub di, WORD PTR [rax]
    sub cx, WORD PTR [rbx]
    sub dx, WORD PTR [rax]
    sub dx, WORD PTR [rip + 0x100]

// === SUB r32, m32 ===
    sub edx, DWORD PTR [rax + rbx*4 + 0x100]
    sub ecx, DWORD PTR [rax + rbx*1 + 0x10]
    sub edi, DWORD PTR [rbx]
    sub esi, DWORD PTR [rax]
    sub ecx, DWORD PTR [rip + 0x1000]
    sub eax, DWORD PTR [rax + rbx*4 + 0x100]
    sub eax, DWORD PTR [rip + 0x1000]
    sub esi, DWORD PTR [rbx]
    sub ebx, DWORD PTR [rax]
    sub edi, DWORD PTR [rax + rbx*4 + 0x100]

// === SUB r64, m64 ===
    sub r9, QWORD PTR [rax + rbx*4 + 0x100]
    sub rcx, QWORD PTR [rax + rbx*4 + 0x100]
    sub rdx, QWORD PTR [rip + 0x100]
    sub rax, QWORD PTR [rax]
    sub rax, QWORD PTR [rax + rbx*4 + 0x100]
    sub rdi, QWORD PTR [rax]
    sub rdx, QWORD PTR [rax + rbx*1 + 0x10]
    sub r13, QWORD PTR [rax + rbx*4 + 0x100]
    sub r13, QWORD PTR [rbx]
    sub r10, QWORD PTR [rax + rbx*1 + 0x10]

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
    test rax, -1
    test rax, 0x7fffffff

// === TEST r8, imm8 ===
    test al, 0xff
    test cl, 0xff
    test dl, 0xff
    test bl, 0xff

// === TEST m8, imm8 ===
    test BYTE PTR [rip + 0x100], 0xff
    test BYTE PTR [rax], 0xff
    test BYTE PTR [rax + rbx*4 + 0x100], 0xff
    test BYTE PTR [rbx], 0xff
    test BYTE PTR [rip + 0x1000], 0xff
    test BYTE PTR [rax + rbx*1 + 0x10], 0xff

// === TEST r16, imm16 ===
    test cx, 0xffff
    test si, 0xffff
    test di, 0xffff
    test ax, 0xffff
    test dx, 0xffff
    test bx, 0xffff

// === TEST m16, imm16 ===
    test WORD PTR [rax + rbx*4 + 0x100], 0xffff
    test WORD PTR [rip + 0x1000], 0xffff
    test WORD PTR [rip + 0x100], 0xffff
    test WORD PTR [rax + rbx*1 + 0x10], 0xffff
    test WORD PTR [rbx], 0xffff
    test WORD PTR [rax], 0xffff

// === TEST r32, imm32 ===
    test edx, 0xffffffff
    test edi, 0xffffffff
    test esi, 0xffffffff
    test eax, 0xffffffff
    test ecx, 0xffffffff
    test ebx, 0xffffffff

// === TEST m32, imm32 ===
    test DWORD PTR [rip + 0x1000], 0xffffffff
    test DWORD PTR [rip + 0x100], 0xffffffff
    test DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff
    test DWORD PTR [rbx], 0xffffffff
    test DWORD PTR [rax], 0xffffffff
    test DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff

// === TEST r64, imm32 ===
    test r13, 0x7fffffff
    test r12, 0x7fffffff
    test rdi, 0x7fffffff
    test rdx, -1
    test rbx, -1
    test rax, -1
    test rax, 0x7fffffff
    test r11, -1
    test rsi, 0x7fffffff
    test rsi, -1

// === TEST m64, imm32 ===
    test QWORD PTR [rax], 0x7fffffff
    test QWORD PTR [rbx], -1
    test QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    test QWORD PTR [rip + 0x100], 0x7fffffff
    test QWORD PTR [rax + rbx*4 + 0x100], -1
    test QWORD PTR [rip + 0x100], -1
    test QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    test QWORD PTR [rax + rbx*1 + 0x10], -1
    test QWORD PTR [rip + 0x1000], -1
    test QWORD PTR [rip + 0x1000], 0x7fffffff

// === TEST r8, r8 ===
    test cl, bl
    test dl, al
    test cl, al
    test cl, cl
    test cl, dl
    test bl, al
    test bl, bl
    test al, dl
    test bl, dl
    test al, al

// === TEST m8, r8 ===
    test BYTE PTR [rax + rbx*1 + 0x10], al
    test BYTE PTR [rbx], al
    test BYTE PTR [rip + 0x1000], bl
    test BYTE PTR [rax + rbx*4 + 0x100], cl
    test BYTE PTR [rip + 0x1000], cl
    test BYTE PTR [rax + rbx*4 + 0x100], dl
    test BYTE PTR [rax + rbx*4 + 0x100], bl
    test BYTE PTR [rax + rbx*4 + 0x100], al
    test BYTE PTR [rax], cl
    test BYTE PTR [rip + 0x100], bl

// === TEST r16, r16 ===
    test cx, si
    test cx, ax
    test si, di
    test dx, si
    test ax, si
    test dx, ax
    test cx, cx
    test ax, bx
    test di, di
    test di, cx

// === TEST m16, r16 ===
    test WORD PTR [rip + 0x1000], bx
    test WORD PTR [rip + 0x100], ax
    test WORD PTR [rax + rbx*1 + 0x10], dx
    test WORD PTR [rip + 0x100], cx
    test WORD PTR [rbx], si
    test WORD PTR [rax + rbx*1 + 0x10], ax
    test WORD PTR [rax], ax
    test WORD PTR [rip + 0x100], di
    test WORD PTR [rax + rbx*4 + 0x100], bx
    test WORD PTR [rbx], dx

// === TEST r32, r32 ===
    test edx, edi
    test edi, edi
    test ecx, ebx
    test eax, edx
    test eax, esi
    test ebx, ecx
    test eax, ebx
    test esi, edi
    test ecx, edx
    test ebx, ebx

// === TEST m32, r32 ===
    test DWORD PTR [rip + 0x100], esi
    test DWORD PTR [rax + rbx*4 + 0x100], eax
    test DWORD PTR [rbx], edi
    test DWORD PTR [rbx], ecx
    test DWORD PTR [rip + 0x1000], eax
    test DWORD PTR [rip + 0x100], ebx
    test DWORD PTR [rax], edx
    test DWORD PTR [rip + 0x1000], ecx
    test DWORD PTR [rax + rbx*4 + 0x100], ebx
    test DWORD PTR [rax + rbx*1 + 0x10], edi

// === TEST r64, r64 ===
    test rdi, rcx
    test rbx, rcx
    test rsi, r9
    test r12, rcx
    test rdx, r8
    test r11, rsi
    test r13, r13
    test r13, r12
    test rdi, r12
    test r10, rax

// === TEST m64, r64 ===
    test QWORD PTR [rax + rbx*1 + 0x10], rdi
    test QWORD PTR [rax + rbx*1 + 0x10], rdx
    test QWORD PTR [rax + rbx*4 + 0x100], r10
    test QWORD PTR [rax + rbx*4 + 0x100], rsi
    test QWORD PTR [rip + 0x1000], rdi
    test QWORD PTR [rax + rbx*1 + 0x10], r8
    test QWORD PTR [rax + rbx*4 + 0x100], rax
    test QWORD PTR [rip + 0x100], rbx
    test QWORD PTR [rax], r10
    test QWORD PTR [rip + 0x100], r8

// === UD1 r32, r32 ===
    ud1 ecx, esi
    ud1 esi, eax
    ud1 edi, esi
    ud1 esi, ebx
    ud1 edi, ebx
    ud1 ebx, eax
    ud1 ebx, ecx
    ud1 eax, ecx
    ud1 ecx, ecx
    ud1 esi, edi

// === UD1 r32, m32 ===
    ud1 esi, DWORD PTR [rax]
    ud1 edi, DWORD PTR [rip + 0x1000]
    ud1 edi, DWORD PTR [rip + 0x100]
    ud1 eax, DWORD PTR [rbx]
    ud1 esi, DWORD PTR [rax + rbx*4 + 0x100]
    ud1 ecx, DWORD PTR [rax + rbx*1 + 0x10]
    ud1 ebx, DWORD PTR [rax + rbx*4 + 0x100]
    ud1 edi, DWORD PTR [rax]
    ud1 ecx, DWORD PTR [rip + 0x100]
    ud1 ebx, DWORD PTR [rip + 0x1000]

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
    xadd cl, al
    xadd dl, al
    xadd dl, bl
    xadd bl, al
    xadd dl, dl
    xadd bl, bl
    xadd dl, cl
    xadd bl, dl
    xadd cl, dl
    xadd al, bl

// === XADD m8, r8 ===
    xadd BYTE PTR [rax], cl
    xadd BYTE PTR [rax], al
    xadd BYTE PTR [rip + 0x1000], dl
    xadd BYTE PTR [rip + 0x1000], cl
    xadd BYTE PTR [rip + 0x1000], bl
    xadd BYTE PTR [rip + 0x100], al
    xadd BYTE PTR [rax + rbx*1 + 0x10], al
    xadd BYTE PTR [rax + rbx*4 + 0x100], bl
    xadd BYTE PTR [rax + rbx*4 + 0x100], cl
    xadd BYTE PTR [rbx], al

// === XADD r16, r16 ===
    xadd di, di
    xadd si, di
    xadd di, si
    xadd si, cx
    xadd cx, di
    xadd dx, di
    xadd ax, ax
    xadd si, bx
    xadd ax, si
    xadd si, dx

// === XADD m16, r16 ===
    xadd WORD PTR [rip + 0x100], cx
    xadd WORD PTR [rbx], dx
    xadd WORD PTR [rax + rbx*1 + 0x10], si
    xadd WORD PTR [rax + rbx*1 + 0x10], bx
    xadd WORD PTR [rbx], di
    xadd WORD PTR [rax + rbx*4 + 0x100], di
    xadd WORD PTR [rax], dx
    xadd WORD PTR [rax + rbx*1 + 0x10], di
    xadd WORD PTR [rbx], si
    xadd WORD PTR [rip + 0x100], di

// === XADD r32, r32 ===
    xadd eax, edi
    xadd eax, eax
    xadd ecx, esi
    xadd edx, esi
    xadd eax, ebx
    xadd eax, esi
    xadd ebx, edx
    xadd edi, ebx
    xadd esi, edx
    xadd edi, ecx

// === XADD m32, r32 ===
    xadd DWORD PTR [rbx], ebx
    xadd DWORD PTR [rip + 0x1000], eax
    xadd DWORD PTR [rip + 0x1000], ebx
    xadd DWORD PTR [rax + rbx*4 + 0x100], ebx
    xadd DWORD PTR [rax], eax
    xadd DWORD PTR [rip + 0x100], esi
    xadd DWORD PTR [rip + 0x1000], ecx
    xadd DWORD PTR [rax + rbx*1 + 0x10], edi
    xadd DWORD PTR [rax], edi
    xadd DWORD PTR [rax + rbx*4 + 0x100], ecx

// === XADD r64, r64 ===
    xadd rsi, r13
    xadd rdi, r11
    xadd r9, rax
    xadd r11, r12
    xadd r8, r9
    xadd r13, r9
    xadd rbx, rsi
    xadd rsi, r12
    xadd rcx, r12
    xadd rdi, r12

// === XADD m64, r64 ===
    xadd QWORD PTR [rip + 0x1000], r9
    xadd QWORD PTR [rax], rsi
    xadd QWORD PTR [rip + 0x1000], r12
    xadd QWORD PTR [rip + 0x100], rsi
    xadd QWORD PTR [rip + 0x100], r11
    xadd QWORD PTR [rbx], rax
    xadd QWORD PTR [rip + 0x100], r13
    xadd QWORD PTR [rax + rbx*4 + 0x100], r9
    xadd QWORD PTR [rip + 0x100], r10
    xadd QWORD PTR [rax], rdi

// === XCHG AX, r16 ===
    xchg ax, di
    xchg ax, cx
    xchg ax, ax
    xchg ax, si
    xchg ax, bx
    xchg ax, dx

// === XCHG r16, AX ===
    xchg dx, ax
    xchg bx, ax
    xchg si, ax
    xchg ax, ax
    xchg cx, ax
    xchg di, ax

// === XCHG EAX, r32 ===
    xchg eax, ecx
    xchg eax, esi
    xchg eax, ebx
    xchg eax, edi
    xchg eax, eax
    xchg eax, edx

// === XCHG RAX, r64 ===
    xchg rax, r11
    xchg rax, r13
    xchg rax, r12
    xchg rax, r8
    xchg rax, rdx
    xchg rax, rsi
    xchg rax, rdi
    xchg rax, rax
    xchg rax, r10
    xchg rax, rbx

// === XCHG r32, EAX ===
    xchg ecx, eax
    xchg esi, eax
    xchg edx, eax
    xchg eax, eax
    xchg edi, eax
    xchg ebx, eax

// === XCHG r64, RAX ===
    xchg r8, rax
    xchg r9, rax
    xchg r13, rax
    xchg r10, rax
    xchg rdx, rax
    xchg rbx, rax
    xchg r12, rax
    xchg rdi, rax
    xchg rax, rax
    xchg rsi, rax

// === XCHG r8, r8 ===
    xchg bl, cl
    xchg al, bl
    xchg al, al
    xchg cl, bl
    xchg cl, cl
    xchg dl, dl
    xchg dl, cl
    xchg dl, al
    xchg bl, al
    xchg bl, bl

// === XCHG m8, r8 ===
    xchg BYTE PTR [rip + 0x1000], dl
    xchg BYTE PTR [rax + rbx*4 + 0x100], dl
    xchg BYTE PTR [rbx], bl
    xchg BYTE PTR [rax], al
    xchg BYTE PTR [rbx], cl
    xchg BYTE PTR [rip + 0x1000], al
    xchg BYTE PTR [rip + 0x100], cl
    xchg BYTE PTR [rax], cl
    xchg BYTE PTR [rip + 0x100], dl
    xchg BYTE PTR [rip + 0x1000], cl

// === XCHG r8, m8 ===
    xchg cl, BYTE PTR [rbx]
    xchg cl, BYTE PTR [rip + 0x100]
    xchg dl, BYTE PTR [rax + rbx*4 + 0x100]
    xchg cl, BYTE PTR [rax]
    xchg dl, BYTE PTR [rbx]
    xchg bl, BYTE PTR [rax]
    xchg dl, BYTE PTR [rip + 0x100]
    xchg cl, BYTE PTR [rip + 0x1000]
    xchg bl, BYTE PTR [rax + rbx*4 + 0x100]
    xchg al, BYTE PTR [rbx]

// === XCHG r16, r16 ===
    xchg bx, si
    xchg cx, si
    xchg bx, ax
    xchg di, dx
    xchg dx, bx
    xchg dx, si
    xchg ax, si
    xchg di, cx
    xchg si, bx
    xchg bx, di

// === XCHG m16, r16 ===
    xchg WORD PTR [rip + 0x1000], ax
    xchg WORD PTR [rax + rbx*1 + 0x10], dx
    xchg WORD PTR [rip + 0x1000], di
    xchg WORD PTR [rbx], di
    xchg WORD PTR [rax + rbx*4 + 0x100], dx
    xchg WORD PTR [rbx], bx
    xchg WORD PTR [rax], ax
    xchg WORD PTR [rax + rbx*1 + 0x10], ax
    xchg WORD PTR [rax], di
    xchg WORD PTR [rip + 0x1000], si

// === XCHG r16, m16 ===
    xchg di, WORD PTR [rax + rbx*1 + 0x10]
    xchg di, WORD PTR [rip + 0x1000]
    xchg dx, WORD PTR [rax]
    xchg si, WORD PTR [rip + 0x1000]
    xchg ax, WORD PTR [rip + 0x1000]
    xchg bx, WORD PTR [rip + 0x100]
    xchg cx, WORD PTR [rax]
    xchg ax, WORD PTR [rax + rbx*1 + 0x10]
    xchg ax, WORD PTR [rax]
    xchg cx, WORD PTR [rip + 0x100]

// === XCHG r32, r32 ===
    xchg eax, ebx
    xchg eax, edx
    xchg ecx, edx
    xchg edx, ebx
    xchg edx, eax
    xchg ecx, edi
    xchg ebx, edi
    xchg ecx, esi
    xchg edi, ecx
    xchg eax, eax

// === XCHG m32, r32 ===
    xchg DWORD PTR [rip + 0x1000], esi
    xchg DWORD PTR [rbx], edi
    xchg DWORD PTR [rax + rbx*4 + 0x100], ecx
    xchg DWORD PTR [rip + 0x1000], ebx
    xchg DWORD PTR [rbx], esi
    xchg DWORD PTR [rax + rbx*4 + 0x100], ebx
    xchg DWORD PTR [rax + rbx*1 + 0x10], ebx
    xchg DWORD PTR [rip + 0x100], ecx
    xchg DWORD PTR [rax], ecx
    xchg DWORD PTR [rip + 0x1000], edx

// === XCHG r64, r64 ===
    xchg rbx, r12
    xchg r8, rax
    xchg rdi, rax
    xchg rax, rcx
    xchg rbx, r13
    xchg rdx, rsi
    xchg rdi, rbx
    xchg r9, rdx
    xchg rbx, rsi
    xchg rdi, r10

// === XCHG m64, r64 ===
    xchg QWORD PTR [rbx], r10
    xchg QWORD PTR [rbx], rdx
    xchg QWORD PTR [rip + 0x1000], rdx
    xchg QWORD PTR [rbx], rcx
    xchg QWORD PTR [rip + 0x100], r13
    xchg QWORD PTR [rax + rbx*4 + 0x100], r11
    xchg QWORD PTR [rax + rbx*1 + 0x10], rbx
    xchg QWORD PTR [rbx], r11
    xchg QWORD PTR [rax], rax
    xchg QWORD PTR [rax], rdx

// === XCHG r32, m32 ===
    xchg edi, DWORD PTR [rip + 0x1000]
    xchg ecx, DWORD PTR [rip + 0x100]
    xchg ebx, DWORD PTR [rbx]
    xchg esi, DWORD PTR [rax]
    xchg esi, DWORD PTR [rip + 0x1000]
    xchg eax, DWORD PTR [rip + 0x1000]
    xchg edx, DWORD PTR [rip + 0x1000]
    xchg edi, DWORD PTR [rax + rbx*1 + 0x10]
    xchg edi, DWORD PTR [rax + rbx*4 + 0x100]
    xchg ebx, DWORD PTR [rax]

// === XCHG r64, m64 ===
    xchg r9, QWORD PTR [rax + rbx*1 + 0x10]
    xchg rdx, QWORD PTR [rax + rbx*1 + 0x10]
    xchg r9, QWORD PTR [rip + 0x1000]
    xchg r11, QWORD PTR [rip + 0x100]
    xchg r8, QWORD PTR [rbx]
    xchg rbx, QWORD PTR [rip + 0x1000]
    xchg rcx, QWORD PTR [rip + 0x100]
    xchg r9, QWORD PTR [rax + rbx*4 + 0x100]
    xchg rax, QWORD PTR [rax + rbx*4 + 0x100]
    xchg r8, QWORD PTR [rax]

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
    xor rax, 0x7fffffff
    xor rax, -1

// === XOR r8, imm8 ===
    xor al, 0xff
    xor cl, 0xff
    xor bl, 0xff
    xor dl, 0xff

// === XOR m8, imm8 ===
    xor BYTE PTR [rip + 0x1000], 0xff
    xor BYTE PTR [rip + 0x100], 0xff
    xor BYTE PTR [rax + rbx*1 + 0x10], 0xff
    xor BYTE PTR [rax], 0xff
    xor BYTE PTR [rax + rbx*4 + 0x100], 0xff
    xor BYTE PTR [rbx], 0xff

// === XOR r16, imm16 ===
    xor ax, 0xffff
    xor dx, 0xffff
    xor si, 0xffff
    xor bx, 0xffff
    xor cx, 0xffff
    xor di, 0xffff

// === XOR m16, imm16 ===
    xor WORD PTR [rax], 0xffff
    xor WORD PTR [rbx], 0xffff
    xor WORD PTR [rip + 0x100], 0xffff
    xor WORD PTR [rax + rbx*1 + 0x10], 0xffff
    xor WORD PTR [rax + rbx*4 + 0x100], 0xffff
    xor WORD PTR [rip + 0x1000], 0xffff

// === XOR r32, imm32 ===
    xor esi, 0xffffffff
    xor edi, 0xffffffff
    xor edx, 0xffffffff
    xor eax, 0xffffffff
    xor ebx, 0xffffffff
    xor ecx, 0xffffffff

// === XOR m32, imm32 ===
    xor DWORD PTR [rax + rbx*4 + 0x100], 0xffffffff
    xor DWORD PTR [rbx], 0xffffffff
    xor DWORD PTR [rax], 0xffffffff
    xor DWORD PTR [rip + 0x1000], 0xffffffff
    xor DWORD PTR [rip + 0x100], 0xffffffff
    xor DWORD PTR [rax + rbx*1 + 0x10], 0xffffffff

// === XOR r64, imm32 ===
    xor r13, -1
    xor rcx, -1
    xor rsi, -1
    xor rax, 0x7fffffff
    xor r12, 0x7fffffff
    xor r13, 0x7fffffff
    xor r11, -1
    xor rsi, 0x7fffffff
    xor r9, -1
    xor r8, 0x7fffffff

// === XOR m64, imm32 ===
    xor QWORD PTR [rax], -1
    xor QWORD PTR [rip + 0x1000], 0x7fffffff
    xor QWORD PTR [rax + rbx*4 + 0x100], -1
    xor QWORD PTR [rbx], 0x7fffffff
    xor QWORD PTR [rip + 0x1000], -1
    xor QWORD PTR [rax], 0x7fffffff
    xor QWORD PTR [rax + rbx*1 + 0x10], 0x7fffffff
    xor QWORD PTR [rax + rbx*4 + 0x100], 0x7fffffff
    xor QWORD PTR [rax + rbx*1 + 0x10], -1
    xor QWORD PTR [rip + 0x100], -1

// === XOR r16, imm8 ===
    xor bx, 0xff
    xor di, 0xff
    xor ax, 0xff
    xor si, 0xff
    xor cx, 0xff
    xor dx, 0xff

// === XOR m16, imm8 ===
    xor WORD PTR [rax], 0xff
    xor WORD PTR [rax + rbx*4 + 0x100], 0xff
    xor WORD PTR [rax + rbx*1 + 0x10], 0xff
    xor WORD PTR [rbx], 0xff
    xor WORD PTR [rip + 0x1000], 0xff
    xor WORD PTR [rip + 0x100], 0xff

// === XOR r32, imm8 ===
    xor edx, 0xff
    xor edi, 0xff
    xor ebx, 0xff
    xor ecx, 0xff
    xor esi, 0xff
    xor eax, 0xff

// === XOR m32, imm8 ===
    xor DWORD PTR [rbx], 0xff
    xor DWORD PTR [rax + rbx*4 + 0x100], 0xff
    xor DWORD PTR [rip + 0x1000], 0xff
    xor DWORD PTR [rip + 0x100], 0xff
    xor DWORD PTR [rax], 0xff
    xor DWORD PTR [rax + rbx*1 + 0x10], 0xff

// === XOR r64, imm8 ===
    xor rsi, 0xff
    xor rax, 0xff
    xor rdx, 0xff
    xor r9, 0xff
    xor r8, 0xff
    xor rcx, 0xff
    xor r12, 0xff
    xor r11, 0xff
    xor rdi, 0xff
    xor r10, 0xff

// === XOR m64, imm8 ===
    xor QWORD PTR [rbx], 0xff
    xor QWORD PTR [rip + 0x100], 0xff
    xor QWORD PTR [rax + rbx*1 + 0x10], 0xff
    xor QWORD PTR [rip + 0x1000], 0xff
    xor QWORD PTR [rax + rbx*4 + 0x100], 0xff
    xor QWORD PTR [rax], 0xff

// === XOR r8, r8 ===
    xor cl, dl
    xor bl, dl
    xor bl, bl
    xor cl, bl
    xor dl, bl
    xor al, bl
    xor dl, dl
    xor bl, al
    xor cl, cl
    xor dl, al

// === XOR m8, r8 ===
    xor BYTE PTR [rax], al
    xor BYTE PTR [rbx], al
    xor BYTE PTR [rip + 0x1000], cl
    xor BYTE PTR [rip + 0x1000], al
    xor BYTE PTR [rip + 0x1000], bl
    xor BYTE PTR [rax + rbx*4 + 0x100], al
    xor BYTE PTR [rax + rbx*1 + 0x10], dl
    xor BYTE PTR [rip + 0x100], dl
    xor BYTE PTR [rax + rbx*1 + 0x10], cl
    xor BYTE PTR [rbx], dl

// === XOR r16, r16 ===
    xor di, si
    xor di, cx
    xor ax, bx
    xor ax, cx
    xor di, ax
    xor bx, ax
    xor cx, cx
    xor dx, dx
    xor cx, bx
    xor si, bx

// === XOR m16, r16 ===
    xor WORD PTR [rax + rbx*1 + 0x10], di
    xor WORD PTR [rip + 0x100], si
    xor WORD PTR [rax], cx
    xor WORD PTR [rip + 0x100], dx
    xor WORD PTR [rax + rbx*1 + 0x10], bx
    xor WORD PTR [rbx], cx
    xor WORD PTR [rbx], bx
    xor WORD PTR [rax], ax
    xor WORD PTR [rip + 0x1000], cx
    xor WORD PTR [rax + rbx*4 + 0x100], dx

// === XOR r32, r32 ===
    xor eax, edi
    xor esi, esi
    xor ebx, ebx
    xor ebx, esi
    xor esi, edi
    xor ebx, edx
    xor ebx, edi
    xor eax, eax
    xor ecx, edi
    xor edx, esi

// === XOR m32, r32 ===
    xor DWORD PTR [rbx], edx
    xor DWORD PTR [rip + 0x100], ebx
    xor DWORD PTR [rip + 0x1000], ecx
    xor DWORD PTR [rip + 0x100], ecx
    xor DWORD PTR [rip + 0x100], edx
    xor DWORD PTR [rax + rbx*4 + 0x100], esi
    xor DWORD PTR [rax + rbx*4 + 0x100], edi
    xor DWORD PTR [rbx], eax
    xor DWORD PTR [rip + 0x100], eax
    xor DWORD PTR [rip + 0x1000], edx

// === XOR r64, r64 ===
    xor rdx, rsi
    xor rbx, r9
    xor r10, rax
    xor r9, rcx
    xor r9, r10
    xor r13, rax
    xor r13, r10
    xor rax, r12
    xor r8, rcx
    xor r12, r11

// === XOR m64, r64 ===
    xor QWORD PTR [rax], r11
    xor QWORD PTR [rax + rbx*1 + 0x10], rdi
    xor QWORD PTR [rax], r12
    xor QWORD PTR [rax + rbx*1 + 0x10], r9
    xor QWORD PTR [rax], r13
    xor QWORD PTR [rbx], r13
    xor QWORD PTR [rbx], rdx
    xor QWORD PTR [rbx], rsi
    xor QWORD PTR [rip + 0x100], r12
    xor QWORD PTR [rip + 0x100], r9

// === XOR r8, m8 ===
    xor cl, BYTE PTR [rip + 0x1000]
    xor bl, BYTE PTR [rax + rbx*1 + 0x10]
    xor al, BYTE PTR [rip + 0x100]
    xor dl, BYTE PTR [rbx]
    xor bl, BYTE PTR [rax]
    xor cl, BYTE PTR [rbx]
    xor cl, BYTE PTR [rax]
    xor dl, BYTE PTR [rip + 0x1000]
    xor cl, BYTE PTR [rax + rbx*4 + 0x100]
    xor dl, BYTE PTR [rax]

// === XOR r16, m16 ===
    xor ax, WORD PTR [rip + 0x1000]
    xor ax, WORD PTR [rbx]
    xor ax, WORD PTR [rip + 0x100]
    xor dx, WORD PTR [rip + 0x100]
    xor bx, WORD PTR [rax + rbx*4 + 0x100]
    xor cx, WORD PTR [rip + 0x100]
    xor dx, WORD PTR [rax + rbx*1 + 0x10]
    xor dx, WORD PTR [rip + 0x1000]
    xor ax, WORD PTR [rax + rbx*4 + 0x100]
    xor cx, WORD PTR [rbx]

// === XOR r32, m32 ===
    xor ebx, DWORD PTR [rip + 0x100]
    xor edi, DWORD PTR [rax + rbx*4 + 0x100]
    xor eax, DWORD PTR [rip + 0x100]
    xor esi, DWORD PTR [rip + 0x1000]
    xor esi, DWORD PTR [rax + rbx*1 + 0x10]
    xor edi, DWORD PTR [rip + 0x1000]
    xor esi, DWORD PTR [rip + 0x100]
    xor edx, DWORD PTR [rip + 0x100]
    xor eax, DWORD PTR [rax + rbx*1 + 0x10]
    xor eax, DWORD PTR [rax + rbx*4 + 0x100]

// === XOR r64, m64 ===
    xor r12, QWORD PTR [rax + rbx*4 + 0x100]
    xor rsi, QWORD PTR [rax]
    xor r8, QWORD PTR [rip + 0x100]
    xor r9, QWORD PTR [rax + rbx*1 + 0x10]
    xor r12, QWORD PTR [rax]
    xor r9, QWORD PTR [rax]
    xor rax, QWORD PTR [rip + 0x100]
    xor rdx, QWORD PTR [rax + rbx*1 + 0x10]
    xor r13, QWORD PTR [rax]
    xor rcx, QWORD PTR [rax + rbx*4 + 0x100]

// === XSETBV ===
    xsetbv
