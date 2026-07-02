.intel_syntax noprefix
// Stage3 axis A (addressing forms A1-A8: disp8/disp32/SIB/RIP/abs/r13)

    adc BYTE PTR [rax], 0x1
    adc BYTE PTR [rax+0x7f], 0x1
    adc BYTE PTR [rax+0x80], 0x1
    adc BYTE PTR [rax+rbx*4], 0x1
    adc BYTE PTR [rbx*8+0x10], 0x1
    adc BYTE PTR [rip+0x100], 0x1
    adc BYTE PTR [0x1000], 0x1
    adc BYTE PTR [r13], 0x1
    adc WORD PTR [rax], 0x1
    adc WORD PTR [rax+0x7f], 0x1
    adc WORD PTR [rax+0x80], 0x1
    adc WORD PTR [rax+rbx*4], 0x1
    adc WORD PTR [rbx*8+0x10], 0x1
    adc WORD PTR [rip+0x100], 0x1
    adc WORD PTR [0x1000], 0x1
    adc WORD PTR [r13], 0x1
    adc DWORD PTR [rax], 0x1
    adc DWORD PTR [rax+0x7f], 0x1
    adc DWORD PTR [rax+0x80], 0x1
    adc DWORD PTR [rax+rbx*4], 0x1
    adc DWORD PTR [rbx*8+0x10], 0x1
    adc DWORD PTR [rip+0x100], 0x1
    adc DWORD PTR [0x1000], 0x1
    adc DWORD PTR [r13], 0x1
    adc QWORD PTR [rax], 0x1
    adc QWORD PTR [rax+0x7f], 0x1
    adc QWORD PTR [rax+0x80], 0x1
    adc QWORD PTR [rax+rbx*4], 0x1
    adc QWORD PTR [rbx*8+0x10], 0x1
    adc QWORD PTR [rip+0x100], 0x1
    adc QWORD PTR [0x1000], 0x1
    adc QWORD PTR [r13], 0x1
    adc BYTE PTR [rax], al
    adc BYTE PTR [rax+0x7f], al
    adc BYTE PTR [rax+0x80], al
    adc BYTE PTR [rax+rbx*4], al
    adc BYTE PTR [rbx*8+0x10], al
    adc BYTE PTR [rip+0x100], al
    adc BYTE PTR [0x1000], al
    adc BYTE PTR [r13], al
    adc WORD PTR [rax], ax
    adc WORD PTR [rax+0x7f], ax
    adc WORD PTR [rax+0x80], ax
    adc WORD PTR [rax+rbx*4], ax
    adc WORD PTR [rbx*8+0x10], ax
    adc WORD PTR [rip+0x100], ax
    adc WORD PTR [0x1000], ax
    adc WORD PTR [r13], ax
    adc DWORD PTR [rax], eax
    adc DWORD PTR [rax+0x7f], eax
    adc DWORD PTR [rax+0x80], eax
    adc DWORD PTR [rax+rbx*4], eax
    adc DWORD PTR [rbx*8+0x10], eax
    adc DWORD PTR [rip+0x100], eax
    adc DWORD PTR [0x1000], eax
    adc DWORD PTR [r13], eax
    adc QWORD PTR [rax], rax
    adc QWORD PTR [rax+0x7f], rax
    adc QWORD PTR [rax+0x80], rax
    adc QWORD PTR [rax+rbx*4], rax
    adc QWORD PTR [rbx*8+0x10], rax
    adc QWORD PTR [rip+0x100], rax
    adc QWORD PTR [0x1000], rax
    adc QWORD PTR [r13], rax
    adc al, BYTE PTR [rax]
    adc al, BYTE PTR [rax+0x7f]
    adc al, BYTE PTR [rax+0x80]
    adc al, BYTE PTR [rax+rbx*4]
    adc al, BYTE PTR [rbx*8+0x10]
    adc al, BYTE PTR [rip+0x100]
    adc al, BYTE PTR [0x1000]
    adc al, BYTE PTR [r13]
    adc ax, WORD PTR [rax]
    adc ax, WORD PTR [rax+0x7f]
    adc ax, WORD PTR [rax+0x80]
    adc ax, WORD PTR [rax+rbx*4]
    adc ax, WORD PTR [rbx*8+0x10]
    adc ax, WORD PTR [rip+0x100]
    adc ax, WORD PTR [0x1000]
    adc ax, WORD PTR [r13]
    adc eax, DWORD PTR [rax]
    adc eax, DWORD PTR [rax+0x7f]
    adc eax, DWORD PTR [rax+0x80]
    adc eax, DWORD PTR [rax+rbx*4]
    adc eax, DWORD PTR [rbx*8+0x10]
    adc eax, DWORD PTR [rip+0x100]
    adc eax, DWORD PTR [0x1000]
    adc eax, DWORD PTR [r13]
    adc rax, QWORD PTR [rax]
    adc rax, QWORD PTR [rax+0x7f]
    adc rax, QWORD PTR [rax+0x80]
    adc rax, QWORD PTR [rax+rbx*4]
    adc rax, QWORD PTR [rbx*8+0x10]
    adc rax, QWORD PTR [rip+0x100]
    adc rax, QWORD PTR [0x1000]
    adc rax, QWORD PTR [r13]
    adcx eax, DWORD PTR [rax]
    adcx eax, DWORD PTR [rax+0x7f]
    adcx eax, DWORD PTR [rax+0x80]
    adcx eax, DWORD PTR [rax+rbx*4]
    adcx eax, DWORD PTR [rbx*8+0x10]
    adcx eax, DWORD PTR [rip+0x100]
    adcx eax, DWORD PTR [0x1000]
    adcx eax, DWORD PTR [r13]
    adcx rax, QWORD PTR [rax]
    adcx rax, QWORD PTR [rax+0x7f]
    adcx rax, QWORD PTR [rax+0x80]
    adcx rax, QWORD PTR [rax+rbx*4]
    adcx rax, QWORD PTR [rbx*8+0x10]
    adcx rax, QWORD PTR [rip+0x100]
    adcx rax, QWORD PTR [0x1000]
    adcx rax, QWORD PTR [r13]
    add BYTE PTR [rax], 0x1
    add BYTE PTR [rax+0x7f], 0x1
    add BYTE PTR [rax+0x80], 0x1
    add BYTE PTR [rax+rbx*4], 0x1
    add BYTE PTR [rbx*8+0x10], 0x1
    add BYTE PTR [rip+0x100], 0x1
    add BYTE PTR [0x1000], 0x1
    add BYTE PTR [r13], 0x1
    add WORD PTR [rax], 0x1
    add WORD PTR [rax+0x7f], 0x1
    add WORD PTR [rax+0x80], 0x1
    add WORD PTR [rax+rbx*4], 0x1
    add WORD PTR [rbx*8+0x10], 0x1
    add WORD PTR [rip+0x100], 0x1
    add WORD PTR [0x1000], 0x1
    add WORD PTR [r13], 0x1
    add DWORD PTR [rax], 0x1
    add DWORD PTR [rax+0x7f], 0x1
    add DWORD PTR [rax+0x80], 0x1
    add DWORD PTR [rax+rbx*4], 0x1
    add DWORD PTR [rbx*8+0x10], 0x1
    add DWORD PTR [rip+0x100], 0x1
    add DWORD PTR [0x1000], 0x1
    add DWORD PTR [r13], 0x1
    add QWORD PTR [rax], 0x1
    add QWORD PTR [rax+0x7f], 0x1
    add QWORD PTR [rax+0x80], 0x1
    add QWORD PTR [rax+rbx*4], 0x1
    add QWORD PTR [rbx*8+0x10], 0x1
    add QWORD PTR [rip+0x100], 0x1
    add QWORD PTR [0x1000], 0x1
    add QWORD PTR [r13], 0x1
    add BYTE PTR [rax], al
    add BYTE PTR [rax+0x7f], al
    add BYTE PTR [rax+0x80], al
    add BYTE PTR [rax+rbx*4], al
    add BYTE PTR [rbx*8+0x10], al
    add BYTE PTR [rip+0x100], al
    add BYTE PTR [0x1000], al
    add BYTE PTR [r13], al
    add WORD PTR [rax], ax
    add WORD PTR [rax+0x7f], ax
    add WORD PTR [rax+0x80], ax
    add WORD PTR [rax+rbx*4], ax
    add WORD PTR [rbx*8+0x10], ax
    add WORD PTR [rip+0x100], ax
    add WORD PTR [0x1000], ax
    add WORD PTR [r13], ax
    add DWORD PTR [rax], eax
    add DWORD PTR [rax+0x7f], eax
    add DWORD PTR [rax+0x80], eax
    add DWORD PTR [rax+rbx*4], eax
    add DWORD PTR [rbx*8+0x10], eax
    add DWORD PTR [rip+0x100], eax
    add DWORD PTR [0x1000], eax
    add DWORD PTR [r13], eax
    add QWORD PTR [rax], rax
    add QWORD PTR [rax+0x7f], rax
    add QWORD PTR [rax+0x80], rax
    add QWORD PTR [rax+rbx*4], rax
    add QWORD PTR [rbx*8+0x10], rax
    add QWORD PTR [rip+0x100], rax
    add QWORD PTR [0x1000], rax
    add QWORD PTR [r13], rax
    add al, BYTE PTR [rax]
    add al, BYTE PTR [rax+0x7f]
    add al, BYTE PTR [rax+0x80]
    add al, BYTE PTR [rax+rbx*4]
    add al, BYTE PTR [rbx*8+0x10]
    add al, BYTE PTR [rip+0x100]
    add al, BYTE PTR [0x1000]
    add al, BYTE PTR [r13]
    add ax, WORD PTR [rax]
    add ax, WORD PTR [rax+0x7f]
    add ax, WORD PTR [rax+0x80]
    add ax, WORD PTR [rax+rbx*4]
    add ax, WORD PTR [rbx*8+0x10]
    add ax, WORD PTR [rip+0x100]
    add ax, WORD PTR [0x1000]
    add ax, WORD PTR [r13]
    add eax, DWORD PTR [rax]
    add eax, DWORD PTR [rax+0x7f]
    add eax, DWORD PTR [rax+0x80]
    add eax, DWORD PTR [rax+rbx*4]
    add eax, DWORD PTR [rbx*8+0x10]
    add eax, DWORD PTR [rip+0x100]
    add eax, DWORD PTR [0x1000]
    add eax, DWORD PTR [r13]
    add rax, QWORD PTR [rax]
    add rax, QWORD PTR [rax+0x7f]
    add rax, QWORD PTR [rax+0x80]
    add rax, QWORD PTR [rax+rbx*4]
    add rax, QWORD PTR [rbx*8+0x10]
    add rax, QWORD PTR [rip+0x100]
    add rax, QWORD PTR [0x1000]
    add rax, QWORD PTR [r13]
    addpd xmm1, [rax]
    addpd xmm1, [rax+0x7f]
    addpd xmm1, [rax+0x80]
    addpd xmm1, [rax+rbx*4]
    addpd xmm1, [rbx*8+0x10]
    addpd xmm1, [rip+0x100]
    addpd xmm1, [0x1000]
    addpd xmm1, [r13]
    vaddpd xmm1, xmm2, [rax]
    vaddpd xmm1, xmm2, [rax+0x7f]
    vaddpd xmm1, xmm2, [rax+0x80]
    vaddpd xmm1, xmm2, [rax+rbx*4]
    vaddpd xmm1, xmm2, [rbx*8+0x10]
    vaddpd xmm1, xmm2, [rip+0x100]
    vaddpd xmm1, xmm2, [0x1000]
    vaddpd xmm1, xmm2, [r13]
    vaddpd ymm1, ymm2, [rax]
    vaddpd ymm1, ymm2, [rax+0x7f]
    vaddpd ymm1, ymm2, [rax+0x80]
    vaddpd ymm1, ymm2, [rax+rbx*4]
    vaddpd ymm1, ymm2, [rbx*8+0x10]
    vaddpd ymm1, ymm2, [rip+0x100]
    vaddpd ymm1, ymm2, [0x1000]
    vaddpd ymm1, ymm2, [r13]
    addps xmm1, [rax]
    addps xmm1, [rax+0x7f]
    addps xmm1, [rax+0x80]
    addps xmm1, [rax+rbx*4]
    addps xmm1, [rbx*8+0x10]
    addps xmm1, [rip+0x100]
    addps xmm1, [0x1000]
    addps xmm1, [r13]
    vaddps xmm1, xmm2, [rax]
    vaddps xmm1, xmm2, [rax+0x7f]
    vaddps xmm1, xmm2, [rax+0x80]
    vaddps xmm1, xmm2, [rax+rbx*4]
    vaddps xmm1, xmm2, [rbx*8+0x10]
    vaddps xmm1, xmm2, [rip+0x100]
    vaddps xmm1, xmm2, [0x1000]
    vaddps xmm1, xmm2, [r13]
    vaddps ymm1, ymm2, [rax]
    vaddps ymm1, ymm2, [rax+0x7f]
    vaddps ymm1, ymm2, [rax+0x80]
    vaddps ymm1, ymm2, [rax+rbx*4]
    vaddps ymm1, ymm2, [rbx*8+0x10]
    vaddps ymm1, ymm2, [rip+0x100]
    vaddps ymm1, ymm2, [0x1000]
    vaddps ymm1, ymm2, [r13]
    addsd xmm1, QWORD PTR [rax]
    addsd xmm1, QWORD PTR [rax+0x7f]
    addsd xmm1, QWORD PTR [rax+0x80]
    addsd xmm1, QWORD PTR [rax+rbx*4]
    addsd xmm1, QWORD PTR [rbx*8+0x10]
    addsd xmm1, QWORD PTR [rip+0x100]
    addsd xmm1, QWORD PTR [0x1000]
    addsd xmm1, QWORD PTR [r13]
    vaddsd xmm1, xmm2, QWORD PTR [rax]
    vaddsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vaddsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vaddsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vaddsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vaddsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vaddsd xmm1, xmm2, QWORD PTR [0x1000]
    vaddsd xmm1, xmm2, QWORD PTR [r13]
    addss xmm1, DWORD PTR [rax]
    addss xmm1, DWORD PTR [rax+0x7f]
    addss xmm1, DWORD PTR [rax+0x80]
    addss xmm1, DWORD PTR [rax+rbx*4]
    addss xmm1, DWORD PTR [rbx*8+0x10]
    addss xmm1, DWORD PTR [rip+0x100]
    addss xmm1, DWORD PTR [0x1000]
    addss xmm1, DWORD PTR [r13]
    vaddss xmm1, xmm2, DWORD PTR [rax]
    vaddss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vaddss xmm1, xmm2, DWORD PTR [rax+0x80]
    vaddss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vaddss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vaddss xmm1, xmm2, DWORD PTR [rip+0x100]
    vaddss xmm1, xmm2, DWORD PTR [0x1000]
    vaddss xmm1, xmm2, DWORD PTR [r13]
    addsubpd xmm1, [rax]
    addsubpd xmm1, [rax+0x7f]
    addsubpd xmm1, [rax+0x80]
    addsubpd xmm1, [rax+rbx*4]
    addsubpd xmm1, [rbx*8+0x10]
    addsubpd xmm1, [rip+0x100]
    addsubpd xmm1, [0x1000]
    addsubpd xmm1, [r13]
    vaddsubpd xmm1, xmm2, [rax]
    vaddsubpd xmm1, xmm2, [rax+0x7f]
    vaddsubpd xmm1, xmm2, [rax+0x80]
    vaddsubpd xmm1, xmm2, [rax+rbx*4]
    vaddsubpd xmm1, xmm2, [rbx*8+0x10]
    vaddsubpd xmm1, xmm2, [rip+0x100]
    vaddsubpd xmm1, xmm2, [0x1000]
    vaddsubpd xmm1, xmm2, [r13]
    vaddsubpd ymm1, ymm2, [rax]
    vaddsubpd ymm1, ymm2, [rax+0x7f]
    vaddsubpd ymm1, ymm2, [rax+0x80]
    vaddsubpd ymm1, ymm2, [rax+rbx*4]
    vaddsubpd ymm1, ymm2, [rbx*8+0x10]
    vaddsubpd ymm1, ymm2, [rip+0x100]
    vaddsubpd ymm1, ymm2, [0x1000]
    vaddsubpd ymm1, ymm2, [r13]
    addsubps xmm1, [rax]
    addsubps xmm1, [rax+0x7f]
    addsubps xmm1, [rax+0x80]
    addsubps xmm1, [rax+rbx*4]
    addsubps xmm1, [rbx*8+0x10]
    addsubps xmm1, [rip+0x100]
    addsubps xmm1, [0x1000]
    addsubps xmm1, [r13]
    vaddsubps xmm1, xmm2, [rax]
    vaddsubps xmm1, xmm2, [rax+0x7f]
    vaddsubps xmm1, xmm2, [rax+0x80]
    vaddsubps xmm1, xmm2, [rax+rbx*4]
    vaddsubps xmm1, xmm2, [rbx*8+0x10]
    vaddsubps xmm1, xmm2, [rip+0x100]
    vaddsubps xmm1, xmm2, [0x1000]
    vaddsubps xmm1, xmm2, [r13]
    vaddsubps ymm1, ymm2, [rax]
    vaddsubps ymm1, ymm2, [rax+0x7f]
    vaddsubps ymm1, ymm2, [rax+0x80]
    vaddsubps ymm1, ymm2, [rax+rbx*4]
    vaddsubps ymm1, ymm2, [rbx*8+0x10]
    vaddsubps ymm1, ymm2, [rip+0x100]
    vaddsubps ymm1, ymm2, [0x1000]
    vaddsubps ymm1, ymm2, [r13]
    adox eax, DWORD PTR [rax]
    adox eax, DWORD PTR [rax+0x7f]
    adox eax, DWORD PTR [rax+0x80]
    adox eax, DWORD PTR [rax+rbx*4]
    adox eax, DWORD PTR [rbx*8+0x10]
    adox eax, DWORD PTR [rip+0x100]
    adox eax, DWORD PTR [0x1000]
    adox eax, DWORD PTR [r13]
    adox rax, QWORD PTR [rax]
    adox rax, QWORD PTR [rax+0x7f]
    adox rax, QWORD PTR [rax+0x80]
    adox rax, QWORD PTR [rax+rbx*4]
    adox rax, QWORD PTR [rbx*8+0x10]
    adox rax, QWORD PTR [rip+0x100]
    adox rax, QWORD PTR [0x1000]
    adox rax, QWORD PTR [r13]
    aesdec xmm1, [rax]
    aesdec xmm1, [rax+0x7f]
    aesdec xmm1, [rax+0x80]
    aesdec xmm1, [rax+rbx*4]
    aesdec xmm1, [rbx*8+0x10]
    aesdec xmm1, [rip+0x100]
    aesdec xmm1, [0x1000]
    aesdec xmm1, [r13]
    vaesdec xmm1, xmm2, [rax]
    vaesdec xmm1, xmm2, [rax+0x7f]
    vaesdec xmm1, xmm2, [rax+0x80]
    vaesdec xmm1, xmm2, [rax+rbx*4]
    vaesdec xmm1, xmm2, [rbx*8+0x10]
    vaesdec xmm1, xmm2, [rip+0x100]
    vaesdec xmm1, xmm2, [0x1000]
    vaesdec xmm1, xmm2, [r13]
    vaesdec ymm1, ymm2, [rax]
    vaesdec ymm1, ymm2, [rax+0x7f]
    vaesdec ymm1, ymm2, [rax+0x80]
    vaesdec ymm1, ymm2, [rax+rbx*4]
    vaesdec ymm1, ymm2, [rbx*8+0x10]
    vaesdec ymm1, ymm2, [rip+0x100]
    vaesdec ymm1, ymm2, [0x1000]
    vaesdec ymm1, ymm2, [r13]
    aesdec128kl xmm0, [rax]
    aesdec128kl xmm0, [rax+0x7f]
    aesdec128kl xmm0, [rax+0x80]
    aesdec128kl xmm0, [rax+rbx*4]
    aesdec128kl xmm0, [rbx*8+0x10]
    aesdec128kl xmm0, [rip+0x100]
    aesdec128kl xmm0, [0x1000]
    aesdec128kl xmm0, [r13]
    aesdec256kl xmm0, [rax]
    aesdec256kl xmm0, [rax+0x7f]
    aesdec256kl xmm0, [rax+0x80]
    aesdec256kl xmm0, [rax+rbx*4]
    aesdec256kl xmm0, [rbx*8+0x10]
    aesdec256kl xmm0, [rip+0x100]
    aesdec256kl xmm0, [0x1000]
    aesdec256kl xmm0, [r13]
    aesdeclast xmm1, [rax]
    aesdeclast xmm1, [rax+0x7f]
    aesdeclast xmm1, [rax+0x80]
    aesdeclast xmm1, [rax+rbx*4]
    aesdeclast xmm1, [rbx*8+0x10]
    aesdeclast xmm1, [rip+0x100]
    aesdeclast xmm1, [0x1000]
    aesdeclast xmm1, [r13]
    vaesdeclast xmm1, xmm2, [rax]
    vaesdeclast xmm1, xmm2, [rax+0x7f]
    vaesdeclast xmm1, xmm2, [rax+0x80]
    vaesdeclast xmm1, xmm2, [rax+rbx*4]
    vaesdeclast xmm1, xmm2, [rbx*8+0x10]
    vaesdeclast xmm1, xmm2, [rip+0x100]
    vaesdeclast xmm1, xmm2, [0x1000]
    vaesdeclast xmm1, xmm2, [r13]
    vaesdeclast ymm1, ymm2, [rax]
    vaesdeclast ymm1, ymm2, [rax+0x7f]
    vaesdeclast ymm1, ymm2, [rax+0x80]
    vaesdeclast ymm1, ymm2, [rax+rbx*4]
    vaesdeclast ymm1, ymm2, [rbx*8+0x10]
    vaesdeclast ymm1, ymm2, [rip+0x100]
    vaesdeclast ymm1, ymm2, [0x1000]
    vaesdeclast ymm1, ymm2, [r13]
    aesdecwide128kl [rax]
    aesdecwide128kl [rax+0x7f]
    aesdecwide128kl [rax+0x80]
    aesdecwide128kl [rax+rbx*4]
    aesdecwide128kl [rbx*8+0x10]
    aesdecwide128kl [rip+0x100]
    aesdecwide128kl [0x1000]
    aesdecwide128kl [r13]
    aesdecwide256kl [rax]
    aesdecwide256kl [rax+0x7f]
    aesdecwide256kl [rax+0x80]
    aesdecwide256kl [rax+rbx*4]
    aesdecwide256kl [rbx*8+0x10]
    aesdecwide256kl [rip+0x100]
    aesdecwide256kl [0x1000]
    aesdecwide256kl [r13]
    aesenc xmm1, [rax]
    aesenc xmm1, [rax+0x7f]
    aesenc xmm1, [rax+0x80]
    aesenc xmm1, [rax+rbx*4]
    aesenc xmm1, [rbx*8+0x10]
    aesenc xmm1, [rip+0x100]
    aesenc xmm1, [0x1000]
    aesenc xmm1, [r13]
    vaesenc xmm1, xmm2, [rax]
    vaesenc xmm1, xmm2, [rax+0x7f]
    vaesenc xmm1, xmm2, [rax+0x80]
    vaesenc xmm1, xmm2, [rax+rbx*4]
    vaesenc xmm1, xmm2, [rbx*8+0x10]
    vaesenc xmm1, xmm2, [rip+0x100]
    vaesenc xmm1, xmm2, [0x1000]
    vaesenc xmm1, xmm2, [r13]
    vaesenc ymm1, ymm2, [rax]
    vaesenc ymm1, ymm2, [rax+0x7f]
    vaesenc ymm1, ymm2, [rax+0x80]
    vaesenc ymm1, ymm2, [rax+rbx*4]
    vaesenc ymm1, ymm2, [rbx*8+0x10]
    vaesenc ymm1, ymm2, [rip+0x100]
    vaesenc ymm1, ymm2, [0x1000]
    vaesenc ymm1, ymm2, [r13]
    aesenc128kl xmm0, [rax]
    aesenc128kl xmm0, [rax+0x7f]
    aesenc128kl xmm0, [rax+0x80]
    aesenc128kl xmm0, [rax+rbx*4]
    aesenc128kl xmm0, [rbx*8+0x10]
    aesenc128kl xmm0, [rip+0x100]
    aesenc128kl xmm0, [0x1000]
    aesenc128kl xmm0, [r13]
    aesenc256kl xmm0, [rax]
    aesenc256kl xmm0, [rax+0x7f]
    aesenc256kl xmm0, [rax+0x80]
    aesenc256kl xmm0, [rax+rbx*4]
    aesenc256kl xmm0, [rbx*8+0x10]
    aesenc256kl xmm0, [rip+0x100]
    aesenc256kl xmm0, [0x1000]
    aesenc256kl xmm0, [r13]
    aesenclast xmm1, [rax]
    aesenclast xmm1, [rax+0x7f]
    aesenclast xmm1, [rax+0x80]
    aesenclast xmm1, [rax+rbx*4]
    aesenclast xmm1, [rbx*8+0x10]
    aesenclast xmm1, [rip+0x100]
    aesenclast xmm1, [0x1000]
    aesenclast xmm1, [r13]
    vaesenclast xmm1, xmm2, [rax]
    vaesenclast xmm1, xmm2, [rax+0x7f]
    vaesenclast xmm1, xmm2, [rax+0x80]
    vaesenclast xmm1, xmm2, [rax+rbx*4]
    vaesenclast xmm1, xmm2, [rbx*8+0x10]
    vaesenclast xmm1, xmm2, [rip+0x100]
    vaesenclast xmm1, xmm2, [0x1000]
    vaesenclast xmm1, xmm2, [r13]
    vaesenclast ymm1, ymm2, [rax]
    vaesenclast ymm1, ymm2, [rax+0x7f]
    vaesenclast ymm1, ymm2, [rax+0x80]
    vaesenclast ymm1, ymm2, [rax+rbx*4]
    vaesenclast ymm1, ymm2, [rbx*8+0x10]
    vaesenclast ymm1, ymm2, [rip+0x100]
    vaesenclast ymm1, ymm2, [0x1000]
    vaesenclast ymm1, ymm2, [r13]
    aesencwide128kl [rax]
    aesencwide128kl [rax+0x7f]
    aesencwide128kl [rax+0x80]
    aesencwide128kl [rax+rbx*4]
    aesencwide128kl [rbx*8+0x10]
    aesencwide128kl [rip+0x100]
    aesencwide128kl [0x1000]
    aesencwide128kl [r13]
    aesencwide256kl [rax]
    aesencwide256kl [rax+0x7f]
    aesencwide256kl [rax+0x80]
    aesencwide256kl [rax+rbx*4]
    aesencwide256kl [rbx*8+0x10]
    aesencwide256kl [rip+0x100]
    aesencwide256kl [0x1000]
    aesencwide256kl [r13]
    aesimc xmm1, [rax]
    aesimc xmm1, [rax+0x7f]
    aesimc xmm1, [rax+0x80]
    aesimc xmm1, [rax+rbx*4]
    aesimc xmm1, [rbx*8+0x10]
    aesimc xmm1, [rip+0x100]
    aesimc xmm1, [0x1000]
    aesimc xmm1, [r13]
    vaesimc xmm1, [rax]
    vaesimc xmm1, [rax+0x7f]
    vaesimc xmm1, [rax+0x80]
    vaesimc xmm1, [rax+rbx*4]
    vaesimc xmm1, [rbx*8+0x10]
    vaesimc xmm1, [rip+0x100]
    vaesimc xmm1, [0x1000]
    vaesimc xmm1, [r13]
    aeskeygenassist xmm1, [rax], 0x1
    aeskeygenassist xmm1, [rax+0x7f], 0x1
    aeskeygenassist xmm1, [rax+0x80], 0x1
    aeskeygenassist xmm1, [rax+rbx*4], 0x1
    aeskeygenassist xmm1, [rbx*8+0x10], 0x1
    aeskeygenassist xmm1, [rip+0x100], 0x1
    aeskeygenassist xmm1, [0x1000], 0x1
    aeskeygenassist xmm1, [r13], 0x1
    vaeskeygenassist xmm1, [rax], 0x1
    vaeskeygenassist xmm1, [rax+0x7f], 0x1
    vaeskeygenassist xmm1, [rax+0x80], 0x1
    vaeskeygenassist xmm1, [rax+rbx*4], 0x1
    vaeskeygenassist xmm1, [rbx*8+0x10], 0x1
    vaeskeygenassist xmm1, [rip+0x100], 0x1
    vaeskeygenassist xmm1, [0x1000], 0x1
    vaeskeygenassist xmm1, [r13], 0x1
    and BYTE PTR [rax], 0x1
    and BYTE PTR [rax+0x7f], 0x1
    and BYTE PTR [rax+0x80], 0x1
    and BYTE PTR [rax+rbx*4], 0x1
    and BYTE PTR [rbx*8+0x10], 0x1
    and BYTE PTR [rip+0x100], 0x1
    and BYTE PTR [0x1000], 0x1
    and BYTE PTR [r13], 0x1
    and WORD PTR [rax], 0x1
    and WORD PTR [rax+0x7f], 0x1
    and WORD PTR [rax+0x80], 0x1
    and WORD PTR [rax+rbx*4], 0x1
    and WORD PTR [rbx*8+0x10], 0x1
    and WORD PTR [rip+0x100], 0x1
    and WORD PTR [0x1000], 0x1
    and WORD PTR [r13], 0x1
    and DWORD PTR [rax], 0x1
    and DWORD PTR [rax+0x7f], 0x1
    and DWORD PTR [rax+0x80], 0x1
    and DWORD PTR [rax+rbx*4], 0x1
    and DWORD PTR [rbx*8+0x10], 0x1
    and DWORD PTR [rip+0x100], 0x1
    and DWORD PTR [0x1000], 0x1
    and DWORD PTR [r13], 0x1
    and QWORD PTR [rax], 0x1
    and QWORD PTR [rax+0x7f], 0x1
    and QWORD PTR [rax+0x80], 0x1
    and QWORD PTR [rax+rbx*4], 0x1
    and QWORD PTR [rbx*8+0x10], 0x1
    and QWORD PTR [rip+0x100], 0x1
    and QWORD PTR [0x1000], 0x1
    and QWORD PTR [r13], 0x1
    and WORD PTR [rax], ax
    and WORD PTR [rax+0x7f], ax
    and WORD PTR [rax+0x80], ax
    and WORD PTR [rax+rbx*4], ax
    and WORD PTR [rbx*8+0x10], ax
    and WORD PTR [rip+0x100], ax
    and WORD PTR [0x1000], ax
    and WORD PTR [r13], ax
    and DWORD PTR [rax], eax
    and DWORD PTR [rax+0x7f], eax
    and DWORD PTR [rax+0x80], eax
    and DWORD PTR [rax+rbx*4], eax
    and DWORD PTR [rbx*8+0x10], eax
    and DWORD PTR [rip+0x100], eax
    and DWORD PTR [0x1000], eax
    and DWORD PTR [r13], eax
    and QWORD PTR [rax], rax
    and QWORD PTR [rax+0x7f], rax
    and QWORD PTR [rax+0x80], rax
    and QWORD PTR [rax+rbx*4], rax
    and QWORD PTR [rbx*8+0x10], rax
    and QWORD PTR [rip+0x100], rax
    and QWORD PTR [0x1000], rax
    and QWORD PTR [r13], rax
    and ax, WORD PTR [rax]
    and ax, WORD PTR [rax+0x7f]
    and ax, WORD PTR [rax+0x80]
    and ax, WORD PTR [rax+rbx*4]
    and ax, WORD PTR [rbx*8+0x10]
    and ax, WORD PTR [rip+0x100]
    and ax, WORD PTR [0x1000]
    and ax, WORD PTR [r13]
    and eax, DWORD PTR [rax]
    and eax, DWORD PTR [rax+0x7f]
    and eax, DWORD PTR [rax+0x80]
    and eax, DWORD PTR [rax+rbx*4]
    and eax, DWORD PTR [rbx*8+0x10]
    and eax, DWORD PTR [rip+0x100]
    and eax, DWORD PTR [0x1000]
    and eax, DWORD PTR [r13]
    and rax, QWORD PTR [rax]
    and rax, QWORD PTR [rax+0x7f]
    and rax, QWORD PTR [rax+0x80]
    and rax, QWORD PTR [rax+rbx*4]
    and rax, QWORD PTR [rbx*8+0x10]
    and rax, QWORD PTR [rip+0x100]
    and rax, QWORD PTR [0x1000]
    and rax, QWORD PTR [r13]
    andn eax, eax, DWORD PTR [rax]
    andn eax, eax, DWORD PTR [rax+0x7f]
    andn eax, eax, DWORD PTR [rax+0x80]
    andn eax, eax, DWORD PTR [rax+rbx*4]
    andn eax, eax, DWORD PTR [rbx*8+0x10]
    andn eax, eax, DWORD PTR [rip+0x100]
    andn eax, eax, DWORD PTR [0x1000]
    andn eax, eax, DWORD PTR [r13]
    andnpd xmm1, [rax]
    andnpd xmm1, [rax+0x7f]
    andnpd xmm1, [rax+0x80]
    andnpd xmm1, [rax+rbx*4]
    andnpd xmm1, [rbx*8+0x10]
    andnpd xmm1, [rip+0x100]
    andnpd xmm1, [0x1000]
    andnpd xmm1, [r13]
    vandnpd xmm1, xmm2, [rax]
    vandnpd xmm1, xmm2, [rax+0x7f]
    vandnpd xmm1, xmm2, [rax+0x80]
    vandnpd xmm1, xmm2, [rax+rbx*4]
    vandnpd xmm1, xmm2, [rbx*8+0x10]
    vandnpd xmm1, xmm2, [rip+0x100]
    vandnpd xmm1, xmm2, [0x1000]
    vandnpd xmm1, xmm2, [r13]
    vandnpd ymm1, ymm2, [rax]
    vandnpd ymm1, ymm2, [rax+0x7f]
    vandnpd ymm1, ymm2, [rax+0x80]
    vandnpd ymm1, ymm2, [rax+rbx*4]
    vandnpd ymm1, ymm2, [rbx*8+0x10]
    vandnpd ymm1, ymm2, [rip+0x100]
    vandnpd ymm1, ymm2, [0x1000]
    vandnpd ymm1, ymm2, [r13]
    andnps xmm1, [rax]
    andnps xmm1, [rax+0x7f]
    andnps xmm1, [rax+0x80]
    andnps xmm1, [rax+rbx*4]
    andnps xmm1, [rbx*8+0x10]
    andnps xmm1, [rip+0x100]
    andnps xmm1, [0x1000]
    andnps xmm1, [r13]
    vandnps xmm1, xmm2, [rax]
    vandnps xmm1, xmm2, [rax+0x7f]
    vandnps xmm1, xmm2, [rax+0x80]
    vandnps xmm1, xmm2, [rax+rbx*4]
    vandnps xmm1, xmm2, [rbx*8+0x10]
    vandnps xmm1, xmm2, [rip+0x100]
    vandnps xmm1, xmm2, [0x1000]
    vandnps xmm1, xmm2, [r13]
    vandnps ymm1, ymm2, [rax]
    vandnps ymm1, ymm2, [rax+0x7f]
    vandnps ymm1, ymm2, [rax+0x80]
    vandnps ymm1, ymm2, [rax+rbx*4]
    vandnps ymm1, ymm2, [rbx*8+0x10]
    vandnps ymm1, ymm2, [rip+0x100]
    vandnps ymm1, ymm2, [0x1000]
    vandnps ymm1, ymm2, [r13]
    andpd xmm1, [rax]
    andpd xmm1, [rax+0x7f]
    andpd xmm1, [rax+0x80]
    andpd xmm1, [rax+rbx*4]
    andpd xmm1, [rbx*8+0x10]
    andpd xmm1, [rip+0x100]
    andpd xmm1, [0x1000]
    andpd xmm1, [r13]
    vandpd xmm1, xmm2, [rax]
    vandpd xmm1, xmm2, [rax+0x7f]
    vandpd xmm1, xmm2, [rax+0x80]
    vandpd xmm1, xmm2, [rax+rbx*4]
    vandpd xmm1, xmm2, [rbx*8+0x10]
    vandpd xmm1, xmm2, [rip+0x100]
    vandpd xmm1, xmm2, [0x1000]
    vandpd xmm1, xmm2, [r13]
    vandpd ymm1, ymm2, [rax]
    vandpd ymm1, ymm2, [rax+0x7f]
    vandpd ymm1, ymm2, [rax+0x80]
    vandpd ymm1, ymm2, [rax+rbx*4]
    vandpd ymm1, ymm2, [rbx*8+0x10]
    vandpd ymm1, ymm2, [rip+0x100]
    vandpd ymm1, ymm2, [0x1000]
    vandpd ymm1, ymm2, [r13]
    andps xmm1, [rax]
    andps xmm1, [rax+0x7f]
    andps xmm1, [rax+0x80]
    andps xmm1, [rax+rbx*4]
    andps xmm1, [rbx*8+0x10]
    andps xmm1, [rip+0x100]
    andps xmm1, [0x1000]
    andps xmm1, [r13]
    vandps xmm1, xmm2, [rax]
    vandps xmm1, xmm2, [rax+0x7f]
    vandps xmm1, xmm2, [rax+0x80]
    vandps xmm1, xmm2, [rax+rbx*4]
    vandps xmm1, xmm2, [rbx*8+0x10]
    vandps xmm1, xmm2, [rip+0x100]
    vandps xmm1, xmm2, [0x1000]
    vandps xmm1, xmm2, [r13]
    vandps ymm1, ymm2, [rax]
    vandps ymm1, ymm2, [rax+0x7f]
    vandps ymm1, ymm2, [rax+0x80]
    vandps ymm1, ymm2, [rax+rbx*4]
    vandps ymm1, ymm2, [rbx*8+0x10]
    vandps ymm1, ymm2, [rip+0x100]
    vandps ymm1, ymm2, [0x1000]
    vandps ymm1, ymm2, [r13]
    arpl WORD PTR [rax], ax
    arpl WORD PTR [rax+0x7f], ax
    arpl WORD PTR [rax+0x80], ax
    arpl WORD PTR [rax+rbx*4], ax
    arpl WORD PTR [rbx*8+0x10], ax
    arpl WORD PTR [rip+0x100], ax
    arpl WORD PTR [0x1000], ax
    arpl WORD PTR [r13], ax
    bextr eax, DWORD PTR [rax], eax
    bextr eax, DWORD PTR [rax+0x7f], eax
    bextr eax, DWORD PTR [rax+0x80], eax
    bextr eax, DWORD PTR [rax+rbx*4], eax
    bextr eax, DWORD PTR [rbx*8+0x10], eax
    bextr eax, DWORD PTR [rip+0x100], eax
    bextr eax, DWORD PTR [0x1000], eax
    bextr eax, DWORD PTR [r13], eax
    bextr rax, QWORD PTR [rax], rax
    bextr rax, QWORD PTR [rax+0x7f], rax
    bextr rax, QWORD PTR [rax+0x80], rax
    bextr rax, QWORD PTR [rax+rbx*4], rax
    bextr rax, QWORD PTR [rbx*8+0x10], rax
    bextr rax, QWORD PTR [rip+0x100], rax
    bextr rax, QWORD PTR [0x1000], rax
    bextr rax, QWORD PTR [r13], rax
    blendpd xmm1, [rax], 0x1
    blendpd xmm1, [rax+0x7f], 0x1
    blendpd xmm1, [rax+0x80], 0x1
    blendpd xmm1, [rax+rbx*4], 0x1
    blendpd xmm1, [rbx*8+0x10], 0x1
    blendpd xmm1, [rip+0x100], 0x1
    blendpd xmm1, [0x1000], 0x1
    blendpd xmm1, [r13], 0x1
    vblendpd xmm1, xmm2, [rax], 0x1
    vblendpd xmm1, xmm2, [rax+0x7f], 0x1
    vblendpd xmm1, xmm2, [rax+0x80], 0x1
    vblendpd xmm1, xmm2, [rax+rbx*4], 0x1
    vblendpd xmm1, xmm2, [rbx*8+0x10], 0x1
    vblendpd xmm1, xmm2, [rip+0x100], 0x1
    vblendpd xmm1, xmm2, [0x1000], 0x1
    vblendpd xmm1, xmm2, [r13], 0x1
    vblendpd ymm1, ymm2, [rax], 0x1
    vblendpd ymm1, ymm2, [rax+0x7f], 0x1
    vblendpd ymm1, ymm2, [rax+0x80], 0x1
    vblendpd ymm1, ymm2, [rax+rbx*4], 0x1
    vblendpd ymm1, ymm2, [rbx*8+0x10], 0x1
    vblendpd ymm1, ymm2, [rip+0x100], 0x1
    vblendpd ymm1, ymm2, [0x1000], 0x1
    vblendpd ymm1, ymm2, [r13], 0x1
    blendps xmm1, [rax], 0x1
    blendps xmm1, [rax+0x7f], 0x1
    blendps xmm1, [rax+0x80], 0x1
    blendps xmm1, [rax+rbx*4], 0x1
    blendps xmm1, [rbx*8+0x10], 0x1
    blendps xmm1, [rip+0x100], 0x1
    blendps xmm1, [0x1000], 0x1
    blendps xmm1, [r13], 0x1
    vblendps xmm1, xmm2, [rax], 0x1
    vblendps xmm1, xmm2, [rax+0x7f], 0x1
    vblendps xmm1, xmm2, [rax+0x80], 0x1
    vblendps xmm1, xmm2, [rax+rbx*4], 0x1
    vblendps xmm1, xmm2, [rbx*8+0x10], 0x1
    vblendps xmm1, xmm2, [rip+0x100], 0x1
    vblendps xmm1, xmm2, [0x1000], 0x1
    vblendps xmm1, xmm2, [r13], 0x1
    vblendps ymm1, ymm2, [rax], 0x1
    vblendps ymm1, ymm2, [rax+0x7f], 0x1
    vblendps ymm1, ymm2, [rax+0x80], 0x1
    vblendps ymm1, ymm2, [rax+rbx*4], 0x1
    vblendps ymm1, ymm2, [rbx*8+0x10], 0x1
    vblendps ymm1, ymm2, [rip+0x100], 0x1
    vblendps ymm1, ymm2, [0x1000], 0x1
    vblendps ymm1, ymm2, [r13], 0x1
    blendvpd xmm1, [rax]
    blendvpd xmm1, [rax+0x7f]
    blendvpd xmm1, [rax+0x80]
    blendvpd xmm1, [rax+rbx*4]
    blendvpd xmm1, [rbx*8+0x10]
    blendvpd xmm1, [rip+0x100]
    blendvpd xmm1, [0x1000]
    blendvpd xmm1, [r13]
    vblendvpd xmm1, xmm2, [rax], xmm4
    vblendvpd xmm1, xmm2, [rax+0x7f], xmm4
    vblendvpd xmm1, xmm2, [rax+0x80], xmm4
    vblendvpd xmm1, xmm2, [rax+rbx*4], xmm4
    vblendvpd xmm1, xmm2, [rbx*8+0x10], xmm4
    vblendvpd xmm1, xmm2, [rip+0x100], xmm4
    vblendvpd xmm1, xmm2, [0x1000], xmm4
    vblendvpd xmm1, xmm2, [r13], xmm4
    vblendvpd ymm1, ymm2, [rax], ymm4
    vblendvpd ymm1, ymm2, [rax+0x7f], ymm4
    vblendvpd ymm1, ymm2, [rax+0x80], ymm4
    vblendvpd ymm1, ymm2, [rax+rbx*4], ymm4
    vblendvpd ymm1, ymm2, [rbx*8+0x10], ymm4
    vblendvpd ymm1, ymm2, [rip+0x100], ymm4
    vblendvpd ymm1, ymm2, [0x1000], ymm4
    vblendvpd ymm1, ymm2, [r13], ymm4
    blendvps xmm1, [rax]
    blendvps xmm1, [rax+0x7f]
    blendvps xmm1, [rax+0x80]
    blendvps xmm1, [rax+rbx*4]
    blendvps xmm1, [rbx*8+0x10]
    blendvps xmm1, [rip+0x100]
    blendvps xmm1, [0x1000]
    blendvps xmm1, [r13]
    vblendvps xmm1, xmm2, [rax], xmm4
    vblendvps xmm1, xmm2, [rax+0x7f], xmm4
    vblendvps xmm1, xmm2, [rax+0x80], xmm4
    vblendvps xmm1, xmm2, [rax+rbx*4], xmm4
    vblendvps xmm1, xmm2, [rbx*8+0x10], xmm4
    vblendvps xmm1, xmm2, [rip+0x100], xmm4
    vblendvps xmm1, xmm2, [0x1000], xmm4
    vblendvps xmm1, xmm2, [r13], xmm4
    vblendvps ymm1, ymm2, [rax], ymm4
    vblendvps ymm1, ymm2, [rax+0x7f], ymm4
    vblendvps ymm1, ymm2, [rax+0x80], ymm4
    vblendvps ymm1, ymm2, [rax+rbx*4], ymm4
    vblendvps ymm1, ymm2, [rbx*8+0x10], ymm4
    vblendvps ymm1, ymm2, [rip+0x100], ymm4
    vblendvps ymm1, ymm2, [0x1000], ymm4
    vblendvps ymm1, ymm2, [r13], ymm4
    blsi eax, DWORD PTR [rax]
    blsi eax, DWORD PTR [rax+0x7f]
    blsi eax, DWORD PTR [rax+0x80]
    blsi eax, DWORD PTR [rax+rbx*4]
    blsi eax, DWORD PTR [rbx*8+0x10]
    blsi eax, DWORD PTR [rip+0x100]
    blsi eax, DWORD PTR [0x1000]
    blsi eax, DWORD PTR [r13]
    blsi rax, QWORD PTR [rax]
    blsi rax, QWORD PTR [rax+0x7f]
    blsi rax, QWORD PTR [rax+0x80]
    blsi rax, QWORD PTR [rax+rbx*4]
    blsi rax, QWORD PTR [rbx*8+0x10]
    blsi rax, QWORD PTR [rip+0x100]
    blsi rax, QWORD PTR [0x1000]
    blsi rax, QWORD PTR [r13]
    blsmsk eax, DWORD PTR [rax]
    blsmsk eax, DWORD PTR [rax+0x7f]
    blsmsk eax, DWORD PTR [rax+0x80]
    blsmsk eax, DWORD PTR [rax+rbx*4]
    blsmsk eax, DWORD PTR [rbx*8+0x10]
    blsmsk eax, DWORD PTR [rip+0x100]
    blsmsk eax, DWORD PTR [0x1000]
    blsmsk eax, DWORD PTR [r13]
    blsmsk rax, QWORD PTR [rax]
    blsmsk rax, QWORD PTR [rax+0x7f]
    blsmsk rax, QWORD PTR [rax+0x80]
    blsmsk rax, QWORD PTR [rax+rbx*4]
    blsmsk rax, QWORD PTR [rbx*8+0x10]
    blsmsk rax, QWORD PTR [rip+0x100]
    blsmsk rax, QWORD PTR [0x1000]
    blsmsk rax, QWORD PTR [r13]
    blsr eax, DWORD PTR [rax]
    blsr eax, DWORD PTR [rax+0x7f]
    blsr eax, DWORD PTR [rax+0x80]
    blsr eax, DWORD PTR [rax+rbx*4]
    blsr eax, DWORD PTR [rbx*8+0x10]
    blsr eax, DWORD PTR [rip+0x100]
    blsr eax, DWORD PTR [0x1000]
    blsr eax, DWORD PTR [r13]
    blsr rax, QWORD PTR [rax]
    blsr rax, QWORD PTR [rax+0x7f]
    blsr rax, QWORD PTR [rax+0x80]
    blsr rax, QWORD PTR [rax+rbx*4]
    blsr rax, QWORD PTR [rbx*8+0x10]
    blsr rax, QWORD PTR [rip+0x100]
    blsr rax, QWORD PTR [0x1000]
    blsr rax, QWORD PTR [r13]
    bndcl bnd0, DWORD PTR [rax]
    bndcl bnd0, DWORD PTR [rax+0x7f]
    bndcl bnd0, DWORD PTR [rax+0x80]
    bndcl bnd0, DWORD PTR [rax+rbx*4]
    bndcl bnd0, DWORD PTR [rbx*8+0x10]
    bndcl bnd0, DWORD PTR [rip+0x100]
    bndcl bnd0, DWORD PTR [0x1000]
    bndcl bnd0, DWORD PTR [r13]
    bndcl bnd0, QWORD PTR [rax]
    bndcl bnd0, QWORD PTR [rax+0x7f]
    bndcl bnd0, QWORD PTR [rax+0x80]
    bndcl bnd0, QWORD PTR [rax+rbx*4]
    bndcl bnd0, QWORD PTR [rbx*8+0x10]
    bndcl bnd0, QWORD PTR [rip+0x100]
    bndcl bnd0, QWORD PTR [0x1000]
    bndcl bnd0, QWORD PTR [r13]
    bndcu bnd0, DWORD PTR [rax]
    bndcu bnd0, DWORD PTR [rax+0x7f]
    bndcu bnd0, DWORD PTR [rax+0x80]
    bndcu bnd0, DWORD PTR [rax+rbx*4]
    bndcu bnd0, DWORD PTR [rbx*8+0x10]
    bndcu bnd0, DWORD PTR [rip+0x100]
    bndcu bnd0, DWORD PTR [0x1000]
    bndcu bnd0, DWORD PTR [r13]
    bndcu bnd0, QWORD PTR [rax]
    bndcu bnd0, QWORD PTR [rax+0x7f]
    bndcu bnd0, QWORD PTR [rax+0x80]
    bndcu bnd0, QWORD PTR [rax+rbx*4]
    bndcu bnd0, QWORD PTR [rbx*8+0x10]
    bndcu bnd0, QWORD PTR [rip+0x100]
    bndcu bnd0, QWORD PTR [0x1000]
    bndcu bnd0, QWORD PTR [r13]
    bndcn bnd0, DWORD PTR [rax]
    bndcn bnd0, DWORD PTR [rax+0x7f]
    bndcn bnd0, DWORD PTR [rax+0x80]
    bndcn bnd0, DWORD PTR [rax+rbx*4]
    bndcn bnd0, DWORD PTR [rbx*8+0x10]
    bndcn bnd0, DWORD PTR [rip+0x100]
    bndcn bnd0, DWORD PTR [0x1000]
    bndcn bnd0, DWORD PTR [r13]
    bndcn bnd0, QWORD PTR [rax]
    bndcn bnd0, QWORD PTR [rax+0x7f]
    bndcn bnd0, QWORD PTR [rax+0x80]
    bndcn bnd0, QWORD PTR [rax+rbx*4]
    bndcn bnd0, QWORD PTR [rbx*8+0x10]
    bndcn bnd0, QWORD PTR [rip+0x100]
    bndcn bnd0, QWORD PTR [0x1000]
    bndcn bnd0, QWORD PTR [r13]
    bndmk bnd0, DWORD PTR [rax]
    bndmk bnd0, DWORD PTR [rax+0x7f]
    bndmk bnd0, DWORD PTR [rax+0x80]
    bndmk bnd0, DWORD PTR [rax+rbx*4]
    bndmk bnd0, DWORD PTR [rbx*8+0x10]
    bndmk bnd0, DWORD PTR [rip+0x100]
    bndmk bnd0, DWORD PTR [0x1000]
    bndmk bnd0, DWORD PTR [r13]
    bndmk bnd0, QWORD PTR [rax]
    bndmk bnd0, QWORD PTR [rax+0x7f]
    bndmk bnd0, QWORD PTR [rax+0x80]
    bndmk bnd0, QWORD PTR [rax+rbx*4]
    bndmk bnd0, QWORD PTR [rbx*8+0x10]
    bndmk bnd0, QWORD PTR [rip+0x100]
    bndmk bnd0, QWORD PTR [0x1000]
    bndmk bnd0, QWORD PTR [r13]
    bndmov bnd1, QWORD PTR [rax]
    bndmov bnd1, QWORD PTR [rax+0x7f]
    bndmov bnd1, QWORD PTR [rax+0x80]
    bndmov bnd1, QWORD PTR [rax+rbx*4]
    bndmov bnd1, QWORD PTR [rbx*8+0x10]
    bndmov bnd1, QWORD PTR [rip+0x100]
    bndmov bnd1, QWORD PTR [0x1000]
    bndmov bnd1, QWORD PTR [r13]
    bndmov bnd1, [rax]
    bndmov bnd1, [rax+0x7f]
    bndmov bnd1, [rax+0x80]
    bndmov bnd1, [rax+rbx*4]
    bndmov bnd1, [rbx*8+0x10]
    bndmov bnd1, [rip+0x100]
    bndmov bnd1, [0x1000]
    bndmov bnd1, [r13]
    bndmov QWORD PTR [rax], bnd2
    bndmov QWORD PTR [rax+0x7f], bnd2
    bndmov QWORD PTR [rax+0x80], bnd2
    bndmov QWORD PTR [rax+rbx*4], bnd2
    bndmov QWORD PTR [rbx*8+0x10], bnd2
    bndmov QWORD PTR [rip+0x100], bnd2
    bndmov QWORD PTR [0x1000], bnd2
    bndmov QWORD PTR [r13], bnd2
    bndmov [rax], bnd2
    bndmov [rax+0x7f], bnd2
    bndmov [rax+0x80], bnd2
    bndmov [rax+rbx*4], bnd2
    bndmov [rbx*8+0x10], bnd2
    bndmov [rip+0x100], bnd2
    bndmov [0x1000], bnd2
    bndmov [r13], bnd2
    bsf ax, WORD PTR [rax]
    bsf ax, WORD PTR [rax+0x7f]
    bsf ax, WORD PTR [rax+0x80]
    bsf ax, WORD PTR [rax+rbx*4]
    bsf ax, WORD PTR [rbx*8+0x10]
    bsf ax, WORD PTR [rip+0x100]
    bsf ax, WORD PTR [0x1000]
    bsf ax, WORD PTR [r13]
    bsf eax, DWORD PTR [rax]
    bsf eax, DWORD PTR [rax+0x7f]
    bsf eax, DWORD PTR [rax+0x80]
    bsf eax, DWORD PTR [rax+rbx*4]
    bsf eax, DWORD PTR [rbx*8+0x10]
    bsf eax, DWORD PTR [rip+0x100]
    bsf eax, DWORD PTR [0x1000]
    bsf eax, DWORD PTR [r13]
    bsf rax, QWORD PTR [rax]
    bsf rax, QWORD PTR [rax+0x7f]
    bsf rax, QWORD PTR [rax+0x80]
    bsf rax, QWORD PTR [rax+rbx*4]
    bsf rax, QWORD PTR [rbx*8+0x10]
    bsf rax, QWORD PTR [rip+0x100]
    bsf rax, QWORD PTR [0x1000]
    bsf rax, QWORD PTR [r13]
    bsr ax, WORD PTR [rax]
    bsr ax, WORD PTR [rax+0x7f]
    bsr ax, WORD PTR [rax+0x80]
    bsr ax, WORD PTR [rax+rbx*4]
    bsr ax, WORD PTR [rbx*8+0x10]
    bsr ax, WORD PTR [rip+0x100]
    bsr ax, WORD PTR [0x1000]
    bsr ax, WORD PTR [r13]
    bsr eax, DWORD PTR [rax]
    bsr eax, DWORD PTR [rax+0x7f]
    bsr eax, DWORD PTR [rax+0x80]
    bsr eax, DWORD PTR [rax+rbx*4]
    bsr eax, DWORD PTR [rbx*8+0x10]
    bsr eax, DWORD PTR [rip+0x100]
    bsr eax, DWORD PTR [0x1000]
    bsr eax, DWORD PTR [r13]
    bsr rax, QWORD PTR [rax]
    bsr rax, QWORD PTR [rax+0x7f]
    bsr rax, QWORD PTR [rax+0x80]
    bsr rax, QWORD PTR [rax+rbx*4]
    bsr rax, QWORD PTR [rbx*8+0x10]
    bsr rax, QWORD PTR [rip+0x100]
    bsr rax, QWORD PTR [0x1000]
    bsr rax, QWORD PTR [r13]
    bt WORD PTR [rax], ax
    bt WORD PTR [rax+0x7f], ax
    bt WORD PTR [rax+0x80], ax
    bt WORD PTR [rax+rbx*4], ax
    bt WORD PTR [rbx*8+0x10], ax
    bt WORD PTR [rip+0x100], ax
    bt WORD PTR [0x1000], ax
    bt WORD PTR [r13], ax
    bt DWORD PTR [rax], eax
    bt DWORD PTR [rax+0x7f], eax
    bt DWORD PTR [rax+0x80], eax
    bt DWORD PTR [rax+rbx*4], eax
    bt DWORD PTR [rbx*8+0x10], eax
    bt DWORD PTR [rip+0x100], eax
    bt DWORD PTR [0x1000], eax
    bt DWORD PTR [r13], eax
    bt QWORD PTR [rax], rax
    bt QWORD PTR [rax+0x7f], rax
    bt QWORD PTR [rax+0x80], rax
    bt QWORD PTR [rax+rbx*4], rax
    bt QWORD PTR [rbx*8+0x10], rax
    bt QWORD PTR [rip+0x100], rax
    bt QWORD PTR [0x1000], rax
    bt QWORD PTR [r13], rax
    bt WORD PTR [rax], 0x1
    bt WORD PTR [rax+0x7f], 0x1
    bt WORD PTR [rax+0x80], 0x1
    bt WORD PTR [rax+rbx*4], 0x1
    bt WORD PTR [rbx*8+0x10], 0x1
    bt WORD PTR [rip+0x100], 0x1
    bt WORD PTR [0x1000], 0x1
    bt WORD PTR [r13], 0x1
    bt DWORD PTR [rax], 0x1
    bt DWORD PTR [rax+0x7f], 0x1
    bt DWORD PTR [rax+0x80], 0x1
    bt DWORD PTR [rax+rbx*4], 0x1
    bt DWORD PTR [rbx*8+0x10], 0x1
    bt DWORD PTR [rip+0x100], 0x1
    bt DWORD PTR [0x1000], 0x1
    bt DWORD PTR [r13], 0x1
    bt QWORD PTR [rax], 0x1
    bt QWORD PTR [rax+0x7f], 0x1
    bt QWORD PTR [rax+0x80], 0x1
    bt QWORD PTR [rax+rbx*4], 0x1
    bt QWORD PTR [rbx*8+0x10], 0x1
    bt QWORD PTR [rip+0x100], 0x1
    bt QWORD PTR [0x1000], 0x1
    bt QWORD PTR [r13], 0x1
    btc WORD PTR [rax], ax
    btc WORD PTR [rax+0x7f], ax
    btc WORD PTR [rax+0x80], ax
    btc WORD PTR [rax+rbx*4], ax
    btc WORD PTR [rbx*8+0x10], ax
    btc WORD PTR [rip+0x100], ax
    btc WORD PTR [0x1000], ax
    btc WORD PTR [r13], ax
    btc DWORD PTR [rax], eax
    btc DWORD PTR [rax+0x7f], eax
    btc DWORD PTR [rax+0x80], eax
    btc DWORD PTR [rax+rbx*4], eax
    btc DWORD PTR [rbx*8+0x10], eax
    btc DWORD PTR [rip+0x100], eax
    btc DWORD PTR [0x1000], eax
    btc DWORD PTR [r13], eax
    btc QWORD PTR [rax], rax
    btc QWORD PTR [rax+0x7f], rax
    btc QWORD PTR [rax+0x80], rax
    btc QWORD PTR [rax+rbx*4], rax
    btc QWORD PTR [rbx*8+0x10], rax
    btc QWORD PTR [rip+0x100], rax
    btc QWORD PTR [0x1000], rax
    btc QWORD PTR [r13], rax
    btc WORD PTR [rax], 0x1
    btc WORD PTR [rax+0x7f], 0x1
    btc WORD PTR [rax+0x80], 0x1
    btc WORD PTR [rax+rbx*4], 0x1
    btc WORD PTR [rbx*8+0x10], 0x1
    btc WORD PTR [rip+0x100], 0x1
    btc WORD PTR [0x1000], 0x1
    btc WORD PTR [r13], 0x1
    btc DWORD PTR [rax], 0x1
    btc DWORD PTR [rax+0x7f], 0x1
    btc DWORD PTR [rax+0x80], 0x1
    btc DWORD PTR [rax+rbx*4], 0x1
    btc DWORD PTR [rbx*8+0x10], 0x1
    btc DWORD PTR [rip+0x100], 0x1
    btc DWORD PTR [0x1000], 0x1
    btc DWORD PTR [r13], 0x1
    btc QWORD PTR [rax], 0x1
    btc QWORD PTR [rax+0x7f], 0x1
    btc QWORD PTR [rax+0x80], 0x1
    btc QWORD PTR [rax+rbx*4], 0x1
    btc QWORD PTR [rbx*8+0x10], 0x1
    btc QWORD PTR [rip+0x100], 0x1
    btc QWORD PTR [0x1000], 0x1
    btc QWORD PTR [r13], 0x1
    btr WORD PTR [rax], ax
    btr WORD PTR [rax+0x7f], ax
    btr WORD PTR [rax+0x80], ax
    btr WORD PTR [rax+rbx*4], ax
    btr WORD PTR [rbx*8+0x10], ax
    btr WORD PTR [rip+0x100], ax
    btr WORD PTR [0x1000], ax
    btr WORD PTR [r13], ax
    btr DWORD PTR [rax], eax
    btr DWORD PTR [rax+0x7f], eax
    btr DWORD PTR [rax+0x80], eax
    btr DWORD PTR [rax+rbx*4], eax
    btr DWORD PTR [rbx*8+0x10], eax
    btr DWORD PTR [rip+0x100], eax
    btr DWORD PTR [0x1000], eax
    btr DWORD PTR [r13], eax
    btr QWORD PTR [rax], rax
    btr QWORD PTR [rax+0x7f], rax
    btr QWORD PTR [rax+0x80], rax
    btr QWORD PTR [rax+rbx*4], rax
    btr QWORD PTR [rbx*8+0x10], rax
    btr QWORD PTR [rip+0x100], rax
    btr QWORD PTR [0x1000], rax
    btr QWORD PTR [r13], rax
    btr WORD PTR [rax], 0x1
    btr WORD PTR [rax+0x7f], 0x1
    btr WORD PTR [rax+0x80], 0x1
    btr WORD PTR [rax+rbx*4], 0x1
    btr WORD PTR [rbx*8+0x10], 0x1
    btr WORD PTR [rip+0x100], 0x1
    btr WORD PTR [0x1000], 0x1
    btr WORD PTR [r13], 0x1
    btr DWORD PTR [rax], 0x1
    btr DWORD PTR [rax+0x7f], 0x1
    btr DWORD PTR [rax+0x80], 0x1
    btr DWORD PTR [rax+rbx*4], 0x1
    btr DWORD PTR [rbx*8+0x10], 0x1
    btr DWORD PTR [rip+0x100], 0x1
    btr DWORD PTR [0x1000], 0x1
    btr DWORD PTR [r13], 0x1
    btr QWORD PTR [rax], 0x1
    btr QWORD PTR [rax+0x7f], 0x1
    btr QWORD PTR [rax+0x80], 0x1
    btr QWORD PTR [rax+rbx*4], 0x1
    btr QWORD PTR [rbx*8+0x10], 0x1
    btr QWORD PTR [rip+0x100], 0x1
    btr QWORD PTR [0x1000], 0x1
    btr QWORD PTR [r13], 0x1
    bts WORD PTR [rax], ax
    bts WORD PTR [rax+0x7f], ax
    bts WORD PTR [rax+0x80], ax
    bts WORD PTR [rax+rbx*4], ax
    bts WORD PTR [rbx*8+0x10], ax
    bts WORD PTR [rip+0x100], ax
    bts WORD PTR [0x1000], ax
    bts WORD PTR [r13], ax
    bts DWORD PTR [rax], eax
    bts DWORD PTR [rax+0x7f], eax
    bts DWORD PTR [rax+0x80], eax
    bts DWORD PTR [rax+rbx*4], eax
    bts DWORD PTR [rbx*8+0x10], eax
    bts DWORD PTR [rip+0x100], eax
    bts DWORD PTR [0x1000], eax
    bts DWORD PTR [r13], eax
    bts QWORD PTR [rax], rax
    bts QWORD PTR [rax+0x7f], rax
    bts QWORD PTR [rax+0x80], rax
    bts QWORD PTR [rax+rbx*4], rax
    bts QWORD PTR [rbx*8+0x10], rax
    bts QWORD PTR [rip+0x100], rax
    bts QWORD PTR [0x1000], rax
    bts QWORD PTR [r13], rax
    bts WORD PTR [rax], 0x1
    bts WORD PTR [rax+0x7f], 0x1
    bts WORD PTR [rax+0x80], 0x1
    bts WORD PTR [rax+rbx*4], 0x1
    bts WORD PTR [rbx*8+0x10], 0x1
    bts WORD PTR [rip+0x100], 0x1
    bts WORD PTR [0x1000], 0x1
    bts WORD PTR [r13], 0x1
    bts DWORD PTR [rax], 0x1
    bts DWORD PTR [rax+0x7f], 0x1
    bts DWORD PTR [rax+0x80], 0x1
    bts DWORD PTR [rax+rbx*4], 0x1
    bts DWORD PTR [rbx*8+0x10], 0x1
    bts DWORD PTR [rip+0x100], 0x1
    bts DWORD PTR [0x1000], 0x1
    bts DWORD PTR [r13], 0x1
    bts QWORD PTR [rax], 0x1
    bts QWORD PTR [rax+0x7f], 0x1
    bts QWORD PTR [rax+0x80], 0x1
    bts QWORD PTR [rax+rbx*4], 0x1
    bts QWORD PTR [rbx*8+0x10], 0x1
    bts QWORD PTR [rip+0x100], 0x1
    bts QWORD PTR [0x1000], 0x1
    bts QWORD PTR [r13], 0x1
    bzhi eax, DWORD PTR [rax], eax
    bzhi eax, DWORD PTR [rax+0x7f], eax
    bzhi eax, DWORD PTR [rax+0x80], eax
    bzhi eax, DWORD PTR [rax+rbx*4], eax
    bzhi eax, DWORD PTR [rbx*8+0x10], eax
    bzhi eax, DWORD PTR [rip+0x100], eax
    bzhi eax, DWORD PTR [0x1000], eax
    bzhi eax, DWORD PTR [r13], eax
    bzhi rax, QWORD PTR [rax], rax
    bzhi rax, QWORD PTR [rax+0x7f], rax
    bzhi rax, QWORD PTR [rax+0x80], rax
    bzhi rax, QWORD PTR [rax+rbx*4], rax
    bzhi rax, QWORD PTR [rbx*8+0x10], rax
    bzhi rax, QWORD PTR [rip+0x100], rax
    bzhi rax, QWORD PTR [0x1000], rax
    bzhi rax, QWORD PTR [r13], rax
    call WORD PTR [rax]
    call WORD PTR [rax+0x7f]
    call WORD PTR [rax+0x80]
    call WORD PTR [rax+rbx*4]
    call WORD PTR [rbx*8+0x10]
    call WORD PTR [rip+0x100]
    call WORD PTR [0x1000]
    call WORD PTR [r13]
    call DWORD PTR [rax]
    call DWORD PTR [rax+0x7f]
    call DWORD PTR [rax+0x80]
    call DWORD PTR [rax+rbx*4]
    call DWORD PTR [rbx*8+0x10]
    call DWORD PTR [rip+0x100]
    call DWORD PTR [0x1000]
    call DWORD PTR [r13]
    call QWORD PTR [rax]
    call QWORD PTR [rax+0x7f]
    call QWORD PTR [rax+0x80]
    call QWORD PTR [rax+rbx*4]
    call QWORD PTR [rbx*8+0x10]
    call QWORD PTR [rip+0x100]
    call QWORD PTR [0x1000]
    call QWORD PTR [r13]
    call FWORD PTR [rax]
    call FWORD PTR [rax+0x7f]
    call FWORD PTR [rax+0x80]
    call FWORD PTR [rax+rbx*4]
    call FWORD PTR [rbx*8+0x10]
    call FWORD PTR [rip+0x100]
    call FWORD PTR [0x1000]
    call FWORD PTR [r13]
    call TBYTE PTR [rax]
    call TBYTE PTR [rax+0x7f]
    call TBYTE PTR [rax+0x80]
    call TBYTE PTR [rax+rbx*4]
    call TBYTE PTR [rbx*8+0x10]
    call TBYTE PTR [rip+0x100]
    call TBYTE PTR [0x1000]
    call TBYTE PTR [r13]
    cldemote BYTE PTR [rax]
    cldemote BYTE PTR [rax+0x7f]
    cldemote BYTE PTR [rax+0x80]
    cldemote BYTE PTR [rax+rbx*4]
    cldemote BYTE PTR [rbx*8+0x10]
    cldemote BYTE PTR [rip+0x100]
    cldemote BYTE PTR [0x1000]
    cldemote BYTE PTR [r13]
    clflush BYTE PTR [rax]
    clflush BYTE PTR [rax+0x7f]
    clflush BYTE PTR [rax+0x80]
    clflush BYTE PTR [rax+rbx*4]
    clflush BYTE PTR [rbx*8+0x10]
    clflush BYTE PTR [rip+0x100]
    clflush BYTE PTR [0x1000]
    clflush BYTE PTR [r13]
    clflushopt BYTE PTR [rax]
    clflushopt BYTE PTR [rax+0x7f]
    clflushopt BYTE PTR [rax+0x80]
    clflushopt BYTE PTR [rax+rbx*4]
    clflushopt BYTE PTR [rbx*8+0x10]
    clflushopt BYTE PTR [rip+0x100]
    clflushopt BYTE PTR [0x1000]
    clflushopt BYTE PTR [r13]
    clrssbsy QWORD PTR [rax]
    clrssbsy QWORD PTR [rax+0x7f]
    clrssbsy QWORD PTR [rax+0x80]
    clrssbsy QWORD PTR [rax+rbx*4]
    clrssbsy QWORD PTR [rbx*8+0x10]
    clrssbsy QWORD PTR [rip+0x100]
    clrssbsy QWORD PTR [0x1000]
    clrssbsy QWORD PTR [r13]
    clwb BYTE PTR [rax]
    clwb BYTE PTR [rax+0x7f]
    clwb BYTE PTR [rax+0x80]
    clwb BYTE PTR [rax+rbx*4]
    clwb BYTE PTR [rbx*8+0x10]
    clwb BYTE PTR [rip+0x100]
    clwb BYTE PTR [0x1000]
    clwb BYTE PTR [r13]
    cmova ax, WORD PTR [rax]
    cmova ax, WORD PTR [rax+0x7f]
    cmova ax, WORD PTR [rax+0x80]
    cmova ax, WORD PTR [rax+rbx*4]
    cmova ax, WORD PTR [rbx*8+0x10]
    cmova ax, WORD PTR [rip+0x100]
    cmova ax, WORD PTR [0x1000]
    cmova ax, WORD PTR [r13]
    cmova eax, DWORD PTR [rax]
    cmova eax, DWORD PTR [rax+0x7f]
    cmova eax, DWORD PTR [rax+0x80]
    cmova eax, DWORD PTR [rax+rbx*4]
    cmova eax, DWORD PTR [rbx*8+0x10]
    cmova eax, DWORD PTR [rip+0x100]
    cmova eax, DWORD PTR [0x1000]
    cmova eax, DWORD PTR [r13]
    cmova rax, QWORD PTR [rax]
    cmova rax, QWORD PTR [rax+0x7f]
    cmova rax, QWORD PTR [rax+0x80]
    cmova rax, QWORD PTR [rax+rbx*4]
    cmova rax, QWORD PTR [rbx*8+0x10]
    cmova rax, QWORD PTR [rip+0x100]
    cmova rax, QWORD PTR [0x1000]
    cmova rax, QWORD PTR [r13]
    cmovae ax, WORD PTR [rax]
    cmovae ax, WORD PTR [rax+0x7f]
    cmovae ax, WORD PTR [rax+0x80]
    cmovae ax, WORD PTR [rax+rbx*4]
    cmovae ax, WORD PTR [rbx*8+0x10]
    cmovae ax, WORD PTR [rip+0x100]
    cmovae ax, WORD PTR [0x1000]
    cmovae ax, WORD PTR [r13]
    cmovae eax, DWORD PTR [rax]
    cmovae eax, DWORD PTR [rax+0x7f]
    cmovae eax, DWORD PTR [rax+0x80]
    cmovae eax, DWORD PTR [rax+rbx*4]
    cmovae eax, DWORD PTR [rbx*8+0x10]
    cmovae eax, DWORD PTR [rip+0x100]
    cmovae eax, DWORD PTR [0x1000]
    cmovae eax, DWORD PTR [r13]
    cmovae rax, QWORD PTR [rax]
    cmovae rax, QWORD PTR [rax+0x7f]
    cmovae rax, QWORD PTR [rax+0x80]
    cmovae rax, QWORD PTR [rax+rbx*4]
    cmovae rax, QWORD PTR [rbx*8+0x10]
    cmovae rax, QWORD PTR [rip+0x100]
    cmovae rax, QWORD PTR [0x1000]
    cmovae rax, QWORD PTR [r13]
    cmovb ax, WORD PTR [rax]
    cmovb ax, WORD PTR [rax+0x7f]
    cmovb ax, WORD PTR [rax+0x80]
    cmovb ax, WORD PTR [rax+rbx*4]
    cmovb ax, WORD PTR [rbx*8+0x10]
    cmovb ax, WORD PTR [rip+0x100]
    cmovb ax, WORD PTR [0x1000]
    cmovb ax, WORD PTR [r13]
    cmovb eax, DWORD PTR [rax]
    cmovb eax, DWORD PTR [rax+0x7f]
    cmovb eax, DWORD PTR [rax+0x80]
    cmovb eax, DWORD PTR [rax+rbx*4]
    cmovb eax, DWORD PTR [rbx*8+0x10]
    cmovb eax, DWORD PTR [rip+0x100]
    cmovb eax, DWORD PTR [0x1000]
    cmovb eax, DWORD PTR [r13]
    cmovb rax, QWORD PTR [rax]
    cmovb rax, QWORD PTR [rax+0x7f]
    cmovb rax, QWORD PTR [rax+0x80]
    cmovb rax, QWORD PTR [rax+rbx*4]
    cmovb rax, QWORD PTR [rbx*8+0x10]
    cmovb rax, QWORD PTR [rip+0x100]
    cmovb rax, QWORD PTR [0x1000]
    cmovb rax, QWORD PTR [r13]
    cmovbe ax, WORD PTR [rax]
    cmovbe ax, WORD PTR [rax+0x7f]
    cmovbe ax, WORD PTR [rax+0x80]
    cmovbe ax, WORD PTR [rax+rbx*4]
    cmovbe ax, WORD PTR [rbx*8+0x10]
    cmovbe ax, WORD PTR [rip+0x100]
    cmovbe ax, WORD PTR [0x1000]
    cmovbe ax, WORD PTR [r13]
    cmovbe eax, DWORD PTR [rax]
    cmovbe eax, DWORD PTR [rax+0x7f]
    cmovbe eax, DWORD PTR [rax+0x80]
    cmovbe eax, DWORD PTR [rax+rbx*4]
    cmovbe eax, DWORD PTR [rbx*8+0x10]
    cmovbe eax, DWORD PTR [rip+0x100]
    cmovbe eax, DWORD PTR [0x1000]
    cmovbe eax, DWORD PTR [r13]
    cmovbe rax, QWORD PTR [rax]
    cmovbe rax, QWORD PTR [rax+0x7f]
    cmovbe rax, QWORD PTR [rax+0x80]
    cmovbe rax, QWORD PTR [rax+rbx*4]
    cmovbe rax, QWORD PTR [rbx*8+0x10]
    cmovbe rax, QWORD PTR [rip+0x100]
    cmovbe rax, QWORD PTR [0x1000]
    cmovbe rax, QWORD PTR [r13]
    cmovc ax, WORD PTR [rax]
    cmovc ax, WORD PTR [rax+0x7f]
    cmovc ax, WORD PTR [rax+0x80]
    cmovc ax, WORD PTR [rax+rbx*4]
    cmovc ax, WORD PTR [rbx*8+0x10]
    cmovc ax, WORD PTR [rip+0x100]
    cmovc ax, WORD PTR [0x1000]
    cmovc ax, WORD PTR [r13]
    cmovc eax, DWORD PTR [rax]
    cmovc eax, DWORD PTR [rax+0x7f]
    cmovc eax, DWORD PTR [rax+0x80]
    cmovc eax, DWORD PTR [rax+rbx*4]
    cmovc eax, DWORD PTR [rbx*8+0x10]
    cmovc eax, DWORD PTR [rip+0x100]
    cmovc eax, DWORD PTR [0x1000]
    cmovc eax, DWORD PTR [r13]
    cmovc rax, QWORD PTR [rax]
    cmovc rax, QWORD PTR [rax+0x7f]
    cmovc rax, QWORD PTR [rax+0x80]
    cmovc rax, QWORD PTR [rax+rbx*4]
    cmovc rax, QWORD PTR [rbx*8+0x10]
    cmovc rax, QWORD PTR [rip+0x100]
    cmovc rax, QWORD PTR [0x1000]
    cmovc rax, QWORD PTR [r13]
    cmove ax, WORD PTR [rax]
    cmove ax, WORD PTR [rax+0x7f]
    cmove ax, WORD PTR [rax+0x80]
    cmove ax, WORD PTR [rax+rbx*4]
    cmove ax, WORD PTR [rbx*8+0x10]
    cmove ax, WORD PTR [rip+0x100]
    cmove ax, WORD PTR [0x1000]
    cmove ax, WORD PTR [r13]
    cmove eax, DWORD PTR [rax]
    cmove eax, DWORD PTR [rax+0x7f]
    cmove eax, DWORD PTR [rax+0x80]
    cmove eax, DWORD PTR [rax+rbx*4]
    cmove eax, DWORD PTR [rbx*8+0x10]
    cmove eax, DWORD PTR [rip+0x100]
    cmove eax, DWORD PTR [0x1000]
    cmove eax, DWORD PTR [r13]
    cmove rax, QWORD PTR [rax]
    cmove rax, QWORD PTR [rax+0x7f]
    cmove rax, QWORD PTR [rax+0x80]
    cmove rax, QWORD PTR [rax+rbx*4]
    cmove rax, QWORD PTR [rbx*8+0x10]
    cmove rax, QWORD PTR [rip+0x100]
    cmove rax, QWORD PTR [0x1000]
    cmove rax, QWORD PTR [r13]
    cmovg ax, WORD PTR [rax]
    cmovg ax, WORD PTR [rax+0x7f]
    cmovg ax, WORD PTR [rax+0x80]
    cmovg ax, WORD PTR [rax+rbx*4]
    cmovg ax, WORD PTR [rbx*8+0x10]
    cmovg ax, WORD PTR [rip+0x100]
    cmovg ax, WORD PTR [0x1000]
    cmovg ax, WORD PTR [r13]
    cmovg eax, DWORD PTR [rax]
    cmovg eax, DWORD PTR [rax+0x7f]
    cmovg eax, DWORD PTR [rax+0x80]
    cmovg eax, DWORD PTR [rax+rbx*4]
    cmovg eax, DWORD PTR [rbx*8+0x10]
    cmovg eax, DWORD PTR [rip+0x100]
    cmovg eax, DWORD PTR [0x1000]
    cmovg eax, DWORD PTR [r13]
    cmovg rax, QWORD PTR [rax]
    cmovg rax, QWORD PTR [rax+0x7f]
    cmovg rax, QWORD PTR [rax+0x80]
    cmovg rax, QWORD PTR [rax+rbx*4]
    cmovg rax, QWORD PTR [rbx*8+0x10]
    cmovg rax, QWORD PTR [rip+0x100]
    cmovg rax, QWORD PTR [0x1000]
    cmovg rax, QWORD PTR [r13]
    cmovge ax, WORD PTR [rax]
    cmovge ax, WORD PTR [rax+0x7f]
    cmovge ax, WORD PTR [rax+0x80]
    cmovge ax, WORD PTR [rax+rbx*4]
    cmovge ax, WORD PTR [rbx*8+0x10]
    cmovge ax, WORD PTR [rip+0x100]
    cmovge ax, WORD PTR [0x1000]
    cmovge ax, WORD PTR [r13]
    cmovge eax, DWORD PTR [rax]
    cmovge eax, DWORD PTR [rax+0x7f]
    cmovge eax, DWORD PTR [rax+0x80]
    cmovge eax, DWORD PTR [rax+rbx*4]
    cmovge eax, DWORD PTR [rbx*8+0x10]
    cmovge eax, DWORD PTR [rip+0x100]
    cmovge eax, DWORD PTR [0x1000]
    cmovge eax, DWORD PTR [r13]
    cmovge rax, QWORD PTR [rax]
    cmovge rax, QWORD PTR [rax+0x7f]
    cmovge rax, QWORD PTR [rax+0x80]
    cmovge rax, QWORD PTR [rax+rbx*4]
    cmovge rax, QWORD PTR [rbx*8+0x10]
    cmovge rax, QWORD PTR [rip+0x100]
    cmovge rax, QWORD PTR [0x1000]
    cmovge rax, QWORD PTR [r13]
    cmovl ax, WORD PTR [rax]
    cmovl ax, WORD PTR [rax+0x7f]
    cmovl ax, WORD PTR [rax+0x80]
    cmovl ax, WORD PTR [rax+rbx*4]
    cmovl ax, WORD PTR [rbx*8+0x10]
    cmovl ax, WORD PTR [rip+0x100]
    cmovl ax, WORD PTR [0x1000]
    cmovl ax, WORD PTR [r13]
    cmovl eax, DWORD PTR [rax]
    cmovl eax, DWORD PTR [rax+0x7f]
    cmovl eax, DWORD PTR [rax+0x80]
    cmovl eax, DWORD PTR [rax+rbx*4]
    cmovl eax, DWORD PTR [rbx*8+0x10]
    cmovl eax, DWORD PTR [rip+0x100]
    cmovl eax, DWORD PTR [0x1000]
    cmovl eax, DWORD PTR [r13]
    cmovl rax, QWORD PTR [rax]
    cmovl rax, QWORD PTR [rax+0x7f]
    cmovl rax, QWORD PTR [rax+0x80]
    cmovl rax, QWORD PTR [rax+rbx*4]
    cmovl rax, QWORD PTR [rbx*8+0x10]
    cmovl rax, QWORD PTR [rip+0x100]
    cmovl rax, QWORD PTR [0x1000]
    cmovl rax, QWORD PTR [r13]
    cmovle ax, WORD PTR [rax]
    cmovle ax, WORD PTR [rax+0x7f]
    cmovle ax, WORD PTR [rax+0x80]
    cmovle ax, WORD PTR [rax+rbx*4]
    cmovle ax, WORD PTR [rbx*8+0x10]
    cmovle ax, WORD PTR [rip+0x100]
    cmovle ax, WORD PTR [0x1000]
    cmovle ax, WORD PTR [r13]
    cmovle eax, DWORD PTR [rax]
    cmovle eax, DWORD PTR [rax+0x7f]
    cmovle eax, DWORD PTR [rax+0x80]
    cmovle eax, DWORD PTR [rax+rbx*4]
    cmovle eax, DWORD PTR [rbx*8+0x10]
    cmovle eax, DWORD PTR [rip+0x100]
    cmovle eax, DWORD PTR [0x1000]
    cmovle eax, DWORD PTR [r13]
    cmovle rax, QWORD PTR [rax]
    cmovle rax, QWORD PTR [rax+0x7f]
    cmovle rax, QWORD PTR [rax+0x80]
    cmovle rax, QWORD PTR [rax+rbx*4]
    cmovle rax, QWORD PTR [rbx*8+0x10]
    cmovle rax, QWORD PTR [rip+0x100]
    cmovle rax, QWORD PTR [0x1000]
    cmovle rax, QWORD PTR [r13]
    cmovna ax, WORD PTR [rax]
    cmovna ax, WORD PTR [rax+0x7f]
    cmovna ax, WORD PTR [rax+0x80]
    cmovna ax, WORD PTR [rax+rbx*4]
    cmovna ax, WORD PTR [rbx*8+0x10]
    cmovna ax, WORD PTR [rip+0x100]
    cmovna ax, WORD PTR [0x1000]
    cmovna ax, WORD PTR [r13]
    cmovna eax, DWORD PTR [rax]
    cmovna eax, DWORD PTR [rax+0x7f]
    cmovna eax, DWORD PTR [rax+0x80]
    cmovna eax, DWORD PTR [rax+rbx*4]
    cmovna eax, DWORD PTR [rbx*8+0x10]
    cmovna eax, DWORD PTR [rip+0x100]
    cmovna eax, DWORD PTR [0x1000]
    cmovna eax, DWORD PTR [r13]
    cmovna rax, QWORD PTR [rax]
    cmovna rax, QWORD PTR [rax+0x7f]
    cmovna rax, QWORD PTR [rax+0x80]
    cmovna rax, QWORD PTR [rax+rbx*4]
    cmovna rax, QWORD PTR [rbx*8+0x10]
    cmovna rax, QWORD PTR [rip+0x100]
    cmovna rax, QWORD PTR [0x1000]
    cmovna rax, QWORD PTR [r13]
    cmovnae ax, WORD PTR [rax]
    cmovnae ax, WORD PTR [rax+0x7f]
    cmovnae ax, WORD PTR [rax+0x80]
    cmovnae ax, WORD PTR [rax+rbx*4]
    cmovnae ax, WORD PTR [rbx*8+0x10]
    cmovnae ax, WORD PTR [rip+0x100]
    cmovnae ax, WORD PTR [0x1000]
    cmovnae ax, WORD PTR [r13]
    cmovnae eax, DWORD PTR [rax]
    cmovnae eax, DWORD PTR [rax+0x7f]
    cmovnae eax, DWORD PTR [rax+0x80]
    cmovnae eax, DWORD PTR [rax+rbx*4]
    cmovnae eax, DWORD PTR [rbx*8+0x10]
    cmovnae eax, DWORD PTR [rip+0x100]
    cmovnae eax, DWORD PTR [0x1000]
    cmovnae eax, DWORD PTR [r13]
    cmovnae rax, QWORD PTR [rax]
    cmovnae rax, QWORD PTR [rax+0x7f]
    cmovnae rax, QWORD PTR [rax+0x80]
    cmovnae rax, QWORD PTR [rax+rbx*4]
    cmovnae rax, QWORD PTR [rbx*8+0x10]
    cmovnae rax, QWORD PTR [rip+0x100]
    cmovnae rax, QWORD PTR [0x1000]
    cmovnae rax, QWORD PTR [r13]
    cmovnb ax, WORD PTR [rax]
    cmovnb ax, WORD PTR [rax+0x7f]
    cmovnb ax, WORD PTR [rax+0x80]
    cmovnb ax, WORD PTR [rax+rbx*4]
    cmovnb ax, WORD PTR [rbx*8+0x10]
    cmovnb ax, WORD PTR [rip+0x100]
    cmovnb ax, WORD PTR [0x1000]
    cmovnb ax, WORD PTR [r13]
    cmovnb eax, DWORD PTR [rax]
    cmovnb eax, DWORD PTR [rax+0x7f]
    cmovnb eax, DWORD PTR [rax+0x80]
    cmovnb eax, DWORD PTR [rax+rbx*4]
    cmovnb eax, DWORD PTR [rbx*8+0x10]
    cmovnb eax, DWORD PTR [rip+0x100]
    cmovnb eax, DWORD PTR [0x1000]
    cmovnb eax, DWORD PTR [r13]
    cmovnb rax, QWORD PTR [rax]
    cmovnb rax, QWORD PTR [rax+0x7f]
    cmovnb rax, QWORD PTR [rax+0x80]
    cmovnb rax, QWORD PTR [rax+rbx*4]
    cmovnb rax, QWORD PTR [rbx*8+0x10]
    cmovnb rax, QWORD PTR [rip+0x100]
    cmovnb rax, QWORD PTR [0x1000]
    cmovnb rax, QWORD PTR [r13]
    cmovnbe ax, WORD PTR [rax]
    cmovnbe ax, WORD PTR [rax+0x7f]
    cmovnbe ax, WORD PTR [rax+0x80]
    cmovnbe ax, WORD PTR [rax+rbx*4]
    cmovnbe ax, WORD PTR [rbx*8+0x10]
    cmovnbe ax, WORD PTR [rip+0x100]
    cmovnbe ax, WORD PTR [0x1000]
    cmovnbe ax, WORD PTR [r13]
    cmovnbe eax, DWORD PTR [rax]
    cmovnbe eax, DWORD PTR [rax+0x7f]
    cmovnbe eax, DWORD PTR [rax+0x80]
    cmovnbe eax, DWORD PTR [rax+rbx*4]
    cmovnbe eax, DWORD PTR [rbx*8+0x10]
    cmovnbe eax, DWORD PTR [rip+0x100]
    cmovnbe eax, DWORD PTR [0x1000]
    cmovnbe eax, DWORD PTR [r13]
    cmovnbe rax, QWORD PTR [rax]
    cmovnbe rax, QWORD PTR [rax+0x7f]
    cmovnbe rax, QWORD PTR [rax+0x80]
    cmovnbe rax, QWORD PTR [rax+rbx*4]
    cmovnbe rax, QWORD PTR [rbx*8+0x10]
    cmovnbe rax, QWORD PTR [rip+0x100]
    cmovnbe rax, QWORD PTR [0x1000]
    cmovnbe rax, QWORD PTR [r13]
    cmovnc ax, WORD PTR [rax]
    cmovnc ax, WORD PTR [rax+0x7f]
    cmovnc ax, WORD PTR [rax+0x80]
    cmovnc ax, WORD PTR [rax+rbx*4]
    cmovnc ax, WORD PTR [rbx*8+0x10]
    cmovnc ax, WORD PTR [rip+0x100]
    cmovnc ax, WORD PTR [0x1000]
    cmovnc ax, WORD PTR [r13]
    cmovnc eax, DWORD PTR [rax]
    cmovnc eax, DWORD PTR [rax+0x7f]
    cmovnc eax, DWORD PTR [rax+0x80]
    cmovnc eax, DWORD PTR [rax+rbx*4]
    cmovnc eax, DWORD PTR [rbx*8+0x10]
    cmovnc eax, DWORD PTR [rip+0x100]
    cmovnc eax, DWORD PTR [0x1000]
    cmovnc eax, DWORD PTR [r13]
    cmovnc rax, QWORD PTR [rax]
    cmovnc rax, QWORD PTR [rax+0x7f]
    cmovnc rax, QWORD PTR [rax+0x80]
    cmovnc rax, QWORD PTR [rax+rbx*4]
    cmovnc rax, QWORD PTR [rbx*8+0x10]
    cmovnc rax, QWORD PTR [rip+0x100]
    cmovnc rax, QWORD PTR [0x1000]
    cmovnc rax, QWORD PTR [r13]
    cmovne ax, WORD PTR [rax]
    cmovne ax, WORD PTR [rax+0x7f]
    cmovne ax, WORD PTR [rax+0x80]
    cmovne ax, WORD PTR [rax+rbx*4]
    cmovne ax, WORD PTR [rbx*8+0x10]
    cmovne ax, WORD PTR [rip+0x100]
    cmovne ax, WORD PTR [0x1000]
    cmovne ax, WORD PTR [r13]
    cmovne eax, DWORD PTR [rax]
    cmovne eax, DWORD PTR [rax+0x7f]
    cmovne eax, DWORD PTR [rax+0x80]
    cmovne eax, DWORD PTR [rax+rbx*4]
    cmovne eax, DWORD PTR [rbx*8+0x10]
    cmovne eax, DWORD PTR [rip+0x100]
    cmovne eax, DWORD PTR [0x1000]
    cmovne eax, DWORD PTR [r13]
    cmovne rax, QWORD PTR [rax]
    cmovne rax, QWORD PTR [rax+0x7f]
    cmovne rax, QWORD PTR [rax+0x80]
    cmovne rax, QWORD PTR [rax+rbx*4]
    cmovne rax, QWORD PTR [rbx*8+0x10]
    cmovne rax, QWORD PTR [rip+0x100]
    cmovne rax, QWORD PTR [0x1000]
    cmovne rax, QWORD PTR [r13]
    cmovng ax, WORD PTR [rax]
    cmovng ax, WORD PTR [rax+0x7f]
    cmovng ax, WORD PTR [rax+0x80]
    cmovng ax, WORD PTR [rax+rbx*4]
    cmovng ax, WORD PTR [rbx*8+0x10]
    cmovng ax, WORD PTR [rip+0x100]
    cmovng ax, WORD PTR [0x1000]
    cmovng ax, WORD PTR [r13]
    cmovng eax, DWORD PTR [rax]
    cmovng eax, DWORD PTR [rax+0x7f]
    cmovng eax, DWORD PTR [rax+0x80]
    cmovng eax, DWORD PTR [rax+rbx*4]
    cmovng eax, DWORD PTR [rbx*8+0x10]
    cmovng eax, DWORD PTR [rip+0x100]
    cmovng eax, DWORD PTR [0x1000]
    cmovng eax, DWORD PTR [r13]
    cmovng rax, QWORD PTR [rax]
    cmovng rax, QWORD PTR [rax+0x7f]
    cmovng rax, QWORD PTR [rax+0x80]
    cmovng rax, QWORD PTR [rax+rbx*4]
    cmovng rax, QWORD PTR [rbx*8+0x10]
    cmovng rax, QWORD PTR [rip+0x100]
    cmovng rax, QWORD PTR [0x1000]
    cmovng rax, QWORD PTR [r13]
    cmovnge ax, WORD PTR [rax]
    cmovnge ax, WORD PTR [rax+0x7f]
    cmovnge ax, WORD PTR [rax+0x80]
    cmovnge ax, WORD PTR [rax+rbx*4]
    cmovnge ax, WORD PTR [rbx*8+0x10]
    cmovnge ax, WORD PTR [rip+0x100]
    cmovnge ax, WORD PTR [0x1000]
    cmovnge ax, WORD PTR [r13]
    cmovnge eax, DWORD PTR [rax]
    cmovnge eax, DWORD PTR [rax+0x7f]
    cmovnge eax, DWORD PTR [rax+0x80]
    cmovnge eax, DWORD PTR [rax+rbx*4]
    cmovnge eax, DWORD PTR [rbx*8+0x10]
    cmovnge eax, DWORD PTR [rip+0x100]
    cmovnge eax, DWORD PTR [0x1000]
    cmovnge eax, DWORD PTR [r13]
    cmovnge rax, QWORD PTR [rax]
    cmovnge rax, QWORD PTR [rax+0x7f]
    cmovnge rax, QWORD PTR [rax+0x80]
    cmovnge rax, QWORD PTR [rax+rbx*4]
    cmovnge rax, QWORD PTR [rbx*8+0x10]
    cmovnge rax, QWORD PTR [rip+0x100]
    cmovnge rax, QWORD PTR [0x1000]
    cmovnge rax, QWORD PTR [r13]
    cmovnl ax, WORD PTR [rax]
    cmovnl ax, WORD PTR [rax+0x7f]
    cmovnl ax, WORD PTR [rax+0x80]
    cmovnl ax, WORD PTR [rax+rbx*4]
    cmovnl ax, WORD PTR [rbx*8+0x10]
    cmovnl ax, WORD PTR [rip+0x100]
    cmovnl ax, WORD PTR [0x1000]
    cmovnl ax, WORD PTR [r13]
    cmovnl eax, DWORD PTR [rax]
    cmovnl eax, DWORD PTR [rax+0x7f]
    cmovnl eax, DWORD PTR [rax+0x80]
    cmovnl eax, DWORD PTR [rax+rbx*4]
    cmovnl eax, DWORD PTR [rbx*8+0x10]
    cmovnl eax, DWORD PTR [rip+0x100]
    cmovnl eax, DWORD PTR [0x1000]
    cmovnl eax, DWORD PTR [r13]
    cmovnl rax, QWORD PTR [rax]
    cmovnl rax, QWORD PTR [rax+0x7f]
    cmovnl rax, QWORD PTR [rax+0x80]
    cmovnl rax, QWORD PTR [rax+rbx*4]
    cmovnl rax, QWORD PTR [rbx*8+0x10]
    cmovnl rax, QWORD PTR [rip+0x100]
    cmovnl rax, QWORD PTR [0x1000]
    cmovnl rax, QWORD PTR [r13]
    cmovnle ax, WORD PTR [rax]
    cmovnle ax, WORD PTR [rax+0x7f]
    cmovnle ax, WORD PTR [rax+0x80]
    cmovnle ax, WORD PTR [rax+rbx*4]
    cmovnle ax, WORD PTR [rbx*8+0x10]
    cmovnle ax, WORD PTR [rip+0x100]
    cmovnle ax, WORD PTR [0x1000]
    cmovnle ax, WORD PTR [r13]
    cmovnle eax, DWORD PTR [rax]
    cmovnle eax, DWORD PTR [rax+0x7f]
    cmovnle eax, DWORD PTR [rax+0x80]
    cmovnle eax, DWORD PTR [rax+rbx*4]
    cmovnle eax, DWORD PTR [rbx*8+0x10]
    cmovnle eax, DWORD PTR [rip+0x100]
    cmovnle eax, DWORD PTR [0x1000]
    cmovnle eax, DWORD PTR [r13]
    cmovnle rax, QWORD PTR [rax]
    cmovnle rax, QWORD PTR [rax+0x7f]
    cmovnle rax, QWORD PTR [rax+0x80]
    cmovnle rax, QWORD PTR [rax+rbx*4]
    cmovnle rax, QWORD PTR [rbx*8+0x10]
    cmovnle rax, QWORD PTR [rip+0x100]
    cmovnle rax, QWORD PTR [0x1000]
    cmovnle rax, QWORD PTR [r13]
    cmovno ax, WORD PTR [rax]
    cmovno ax, WORD PTR [rax+0x7f]
    cmovno ax, WORD PTR [rax+0x80]
    cmovno ax, WORD PTR [rax+rbx*4]
    cmovno ax, WORD PTR [rbx*8+0x10]
    cmovno ax, WORD PTR [rip+0x100]
    cmovno ax, WORD PTR [0x1000]
    cmovno ax, WORD PTR [r13]
    cmovno eax, DWORD PTR [rax]
    cmovno eax, DWORD PTR [rax+0x7f]
    cmovno eax, DWORD PTR [rax+0x80]
    cmovno eax, DWORD PTR [rax+rbx*4]
    cmovno eax, DWORD PTR [rbx*8+0x10]
    cmovno eax, DWORD PTR [rip+0x100]
    cmovno eax, DWORD PTR [0x1000]
    cmovno eax, DWORD PTR [r13]
    cmovno rax, QWORD PTR [rax]
    cmovno rax, QWORD PTR [rax+0x7f]
    cmovno rax, QWORD PTR [rax+0x80]
    cmovno rax, QWORD PTR [rax+rbx*4]
    cmovno rax, QWORD PTR [rbx*8+0x10]
    cmovno rax, QWORD PTR [rip+0x100]
    cmovno rax, QWORD PTR [0x1000]
    cmovno rax, QWORD PTR [r13]
    cmovnp ax, WORD PTR [rax]
    cmovnp ax, WORD PTR [rax+0x7f]
    cmovnp ax, WORD PTR [rax+0x80]
    cmovnp ax, WORD PTR [rax+rbx*4]
    cmovnp ax, WORD PTR [rbx*8+0x10]
    cmovnp ax, WORD PTR [rip+0x100]
    cmovnp ax, WORD PTR [0x1000]
    cmovnp ax, WORD PTR [r13]
    cmovnp eax, DWORD PTR [rax]
    cmovnp eax, DWORD PTR [rax+0x7f]
    cmovnp eax, DWORD PTR [rax+0x80]
    cmovnp eax, DWORD PTR [rax+rbx*4]
    cmovnp eax, DWORD PTR [rbx*8+0x10]
    cmovnp eax, DWORD PTR [rip+0x100]
    cmovnp eax, DWORD PTR [0x1000]
    cmovnp eax, DWORD PTR [r13]
    cmovnp rax, QWORD PTR [rax]
    cmovnp rax, QWORD PTR [rax+0x7f]
    cmovnp rax, QWORD PTR [rax+0x80]
    cmovnp rax, QWORD PTR [rax+rbx*4]
    cmovnp rax, QWORD PTR [rbx*8+0x10]
    cmovnp rax, QWORD PTR [rip+0x100]
    cmovnp rax, QWORD PTR [0x1000]
    cmovnp rax, QWORD PTR [r13]
    cmovns ax, WORD PTR [rax]
    cmovns ax, WORD PTR [rax+0x7f]
    cmovns ax, WORD PTR [rax+0x80]
    cmovns ax, WORD PTR [rax+rbx*4]
    cmovns ax, WORD PTR [rbx*8+0x10]
    cmovns ax, WORD PTR [rip+0x100]
    cmovns ax, WORD PTR [0x1000]
    cmovns ax, WORD PTR [r13]
    cmovns eax, DWORD PTR [rax]
    cmovns eax, DWORD PTR [rax+0x7f]
    cmovns eax, DWORD PTR [rax+0x80]
    cmovns eax, DWORD PTR [rax+rbx*4]
    cmovns eax, DWORD PTR [rbx*8+0x10]
    cmovns eax, DWORD PTR [rip+0x100]
    cmovns eax, DWORD PTR [0x1000]
    cmovns eax, DWORD PTR [r13]
    cmovns rax, QWORD PTR [rax]
    cmovns rax, QWORD PTR [rax+0x7f]
    cmovns rax, QWORD PTR [rax+0x80]
    cmovns rax, QWORD PTR [rax+rbx*4]
    cmovns rax, QWORD PTR [rbx*8+0x10]
    cmovns rax, QWORD PTR [rip+0x100]
    cmovns rax, QWORD PTR [0x1000]
    cmovns rax, QWORD PTR [r13]
    cmovnz ax, WORD PTR [rax]
    cmovnz ax, WORD PTR [rax+0x7f]
    cmovnz ax, WORD PTR [rax+0x80]
    cmovnz ax, WORD PTR [rax+rbx*4]
    cmovnz ax, WORD PTR [rbx*8+0x10]
    cmovnz ax, WORD PTR [rip+0x100]
    cmovnz ax, WORD PTR [0x1000]
    cmovnz ax, WORD PTR [r13]
    cmovnz eax, DWORD PTR [rax]
    cmovnz eax, DWORD PTR [rax+0x7f]
    cmovnz eax, DWORD PTR [rax+0x80]
    cmovnz eax, DWORD PTR [rax+rbx*4]
    cmovnz eax, DWORD PTR [rbx*8+0x10]
    cmovnz eax, DWORD PTR [rip+0x100]
    cmovnz eax, DWORD PTR [0x1000]
    cmovnz eax, DWORD PTR [r13]
    cmovnz rax, QWORD PTR [rax]
    cmovnz rax, QWORD PTR [rax+0x7f]
    cmovnz rax, QWORD PTR [rax+0x80]
    cmovnz rax, QWORD PTR [rax+rbx*4]
    cmovnz rax, QWORD PTR [rbx*8+0x10]
    cmovnz rax, QWORD PTR [rip+0x100]
    cmovnz rax, QWORD PTR [0x1000]
    cmovnz rax, QWORD PTR [r13]
    cmovo ax, WORD PTR [rax]
    cmovo ax, WORD PTR [rax+0x7f]
    cmovo ax, WORD PTR [rax+0x80]
    cmovo ax, WORD PTR [rax+rbx*4]
    cmovo ax, WORD PTR [rbx*8+0x10]
    cmovo ax, WORD PTR [rip+0x100]
    cmovo ax, WORD PTR [0x1000]
    cmovo ax, WORD PTR [r13]
    cmovo eax, DWORD PTR [rax]
    cmovo eax, DWORD PTR [rax+0x7f]
    cmovo eax, DWORD PTR [rax+0x80]
    cmovo eax, DWORD PTR [rax+rbx*4]
    cmovo eax, DWORD PTR [rbx*8+0x10]
    cmovo eax, DWORD PTR [rip+0x100]
    cmovo eax, DWORD PTR [0x1000]
    cmovo eax, DWORD PTR [r13]
    cmovo rax, QWORD PTR [rax]
    cmovo rax, QWORD PTR [rax+0x7f]
    cmovo rax, QWORD PTR [rax+0x80]
    cmovo rax, QWORD PTR [rax+rbx*4]
    cmovo rax, QWORD PTR [rbx*8+0x10]
    cmovo rax, QWORD PTR [rip+0x100]
    cmovo rax, QWORD PTR [0x1000]
    cmovo rax, QWORD PTR [r13]
    cmovp ax, WORD PTR [rax]
    cmovp ax, WORD PTR [rax+0x7f]
    cmovp ax, WORD PTR [rax+0x80]
    cmovp ax, WORD PTR [rax+rbx*4]
    cmovp ax, WORD PTR [rbx*8+0x10]
    cmovp ax, WORD PTR [rip+0x100]
    cmovp ax, WORD PTR [0x1000]
    cmovp ax, WORD PTR [r13]
    cmovp eax, DWORD PTR [rax]
    cmovp eax, DWORD PTR [rax+0x7f]
    cmovp eax, DWORD PTR [rax+0x80]
    cmovp eax, DWORD PTR [rax+rbx*4]
    cmovp eax, DWORD PTR [rbx*8+0x10]
    cmovp eax, DWORD PTR [rip+0x100]
    cmovp eax, DWORD PTR [0x1000]
    cmovp eax, DWORD PTR [r13]
    cmovp rax, QWORD PTR [rax]
    cmovp rax, QWORD PTR [rax+0x7f]
    cmovp rax, QWORD PTR [rax+0x80]
    cmovp rax, QWORD PTR [rax+rbx*4]
    cmovp rax, QWORD PTR [rbx*8+0x10]
    cmovp rax, QWORD PTR [rip+0x100]
    cmovp rax, QWORD PTR [0x1000]
    cmovp rax, QWORD PTR [r13]
    cmovpe ax, WORD PTR [rax]
    cmovpe ax, WORD PTR [rax+0x7f]
    cmovpe ax, WORD PTR [rax+0x80]
    cmovpe ax, WORD PTR [rax+rbx*4]
    cmovpe ax, WORD PTR [rbx*8+0x10]
    cmovpe ax, WORD PTR [rip+0x100]
    cmovpe ax, WORD PTR [0x1000]
    cmovpe ax, WORD PTR [r13]
    cmovpe eax, DWORD PTR [rax]
    cmovpe eax, DWORD PTR [rax+0x7f]
    cmovpe eax, DWORD PTR [rax+0x80]
    cmovpe eax, DWORD PTR [rax+rbx*4]
    cmovpe eax, DWORD PTR [rbx*8+0x10]
    cmovpe eax, DWORD PTR [rip+0x100]
    cmovpe eax, DWORD PTR [0x1000]
    cmovpe eax, DWORD PTR [r13]
    cmovpe rax, QWORD PTR [rax]
    cmovpe rax, QWORD PTR [rax+0x7f]
    cmovpe rax, QWORD PTR [rax+0x80]
    cmovpe rax, QWORD PTR [rax+rbx*4]
    cmovpe rax, QWORD PTR [rbx*8+0x10]
    cmovpe rax, QWORD PTR [rip+0x100]
    cmovpe rax, QWORD PTR [0x1000]
    cmovpe rax, QWORD PTR [r13]
    cmovpo ax, WORD PTR [rax]
    cmovpo ax, WORD PTR [rax+0x7f]
    cmovpo ax, WORD PTR [rax+0x80]
    cmovpo ax, WORD PTR [rax+rbx*4]
    cmovpo ax, WORD PTR [rbx*8+0x10]
    cmovpo ax, WORD PTR [rip+0x100]
    cmovpo ax, WORD PTR [0x1000]
    cmovpo ax, WORD PTR [r13]
    cmovpo eax, DWORD PTR [rax]
    cmovpo eax, DWORD PTR [rax+0x7f]
    cmovpo eax, DWORD PTR [rax+0x80]
    cmovpo eax, DWORD PTR [rax+rbx*4]
    cmovpo eax, DWORD PTR [rbx*8+0x10]
    cmovpo eax, DWORD PTR [rip+0x100]
    cmovpo eax, DWORD PTR [0x1000]
    cmovpo eax, DWORD PTR [r13]
    cmovpo rax, QWORD PTR [rax]
    cmovpo rax, QWORD PTR [rax+0x7f]
    cmovpo rax, QWORD PTR [rax+0x80]
    cmovpo rax, QWORD PTR [rax+rbx*4]
    cmovpo rax, QWORD PTR [rbx*8+0x10]
    cmovpo rax, QWORD PTR [rip+0x100]
    cmovpo rax, QWORD PTR [0x1000]
    cmovpo rax, QWORD PTR [r13]
    cmovs ax, WORD PTR [rax]
    cmovs ax, WORD PTR [rax+0x7f]
    cmovs ax, WORD PTR [rax+0x80]
    cmovs ax, WORD PTR [rax+rbx*4]
    cmovs ax, WORD PTR [rbx*8+0x10]
    cmovs ax, WORD PTR [rip+0x100]
    cmovs ax, WORD PTR [0x1000]
    cmovs ax, WORD PTR [r13]
    cmovs eax, DWORD PTR [rax]
    cmovs eax, DWORD PTR [rax+0x7f]
    cmovs eax, DWORD PTR [rax+0x80]
    cmovs eax, DWORD PTR [rax+rbx*4]
    cmovs eax, DWORD PTR [rbx*8+0x10]
    cmovs eax, DWORD PTR [rip+0x100]
    cmovs eax, DWORD PTR [0x1000]
    cmovs eax, DWORD PTR [r13]
    cmovs rax, QWORD PTR [rax]
    cmovs rax, QWORD PTR [rax+0x7f]
    cmovs rax, QWORD PTR [rax+0x80]
    cmovs rax, QWORD PTR [rax+rbx*4]
    cmovs rax, QWORD PTR [rbx*8+0x10]
    cmovs rax, QWORD PTR [rip+0x100]
    cmovs rax, QWORD PTR [0x1000]
    cmovs rax, QWORD PTR [r13]
    cmovz ax, WORD PTR [rax]
    cmovz ax, WORD PTR [rax+0x7f]
    cmovz ax, WORD PTR [rax+0x80]
    cmovz ax, WORD PTR [rax+rbx*4]
    cmovz ax, WORD PTR [rbx*8+0x10]
    cmovz ax, WORD PTR [rip+0x100]
    cmovz ax, WORD PTR [0x1000]
    cmovz ax, WORD PTR [r13]
    cmovz eax, DWORD PTR [rax]
    cmovz eax, DWORD PTR [rax+0x7f]
    cmovz eax, DWORD PTR [rax+0x80]
    cmovz eax, DWORD PTR [rax+rbx*4]
    cmovz eax, DWORD PTR [rbx*8+0x10]
    cmovz eax, DWORD PTR [rip+0x100]
    cmovz eax, DWORD PTR [0x1000]
    cmovz eax, DWORD PTR [r13]
    cmovz rax, QWORD PTR [rax]
    cmovz rax, QWORD PTR [rax+0x7f]
    cmovz rax, QWORD PTR [rax+0x80]
    cmovz rax, QWORD PTR [rax+rbx*4]
    cmovz rax, QWORD PTR [rbx*8+0x10]
    cmovz rax, QWORD PTR [rip+0x100]
    cmovz rax, QWORD PTR [0x1000]
    cmovz rax, QWORD PTR [r13]
    cmp BYTE PTR [rax], 0x1
    cmp BYTE PTR [rax+0x7f], 0x1
    cmp BYTE PTR [rax+0x80], 0x1
    cmp BYTE PTR [rax+rbx*4], 0x1
    cmp BYTE PTR [rbx*8+0x10], 0x1
    cmp BYTE PTR [rip+0x100], 0x1
    cmp BYTE PTR [0x1000], 0x1
    cmp BYTE PTR [r13], 0x1
    cmp WORD PTR [rax], 0x1
    cmp WORD PTR [rax+0x7f], 0x1
    cmp WORD PTR [rax+0x80], 0x1
    cmp WORD PTR [rax+rbx*4], 0x1
    cmp WORD PTR [rbx*8+0x10], 0x1
    cmp WORD PTR [rip+0x100], 0x1
    cmp WORD PTR [0x1000], 0x1
    cmp WORD PTR [r13], 0x1
    cmp DWORD PTR [rax], 0x1
    cmp DWORD PTR [rax+0x7f], 0x1
    cmp DWORD PTR [rax+0x80], 0x1
    cmp DWORD PTR [rax+rbx*4], 0x1
    cmp DWORD PTR [rbx*8+0x10], 0x1
    cmp DWORD PTR [rip+0x100], 0x1
    cmp DWORD PTR [0x1000], 0x1
    cmp DWORD PTR [r13], 0x1
    cmp QWORD PTR [rax], 0x1
    cmp QWORD PTR [rax+0x7f], 0x1
    cmp QWORD PTR [rax+0x80], 0x1
    cmp QWORD PTR [rax+rbx*4], 0x1
    cmp QWORD PTR [rbx*8+0x10], 0x1
    cmp QWORD PTR [rip+0x100], 0x1
    cmp QWORD PTR [0x1000], 0x1
    cmp QWORD PTR [r13], 0x1
    cmp BYTE PTR [rax], al
    cmp BYTE PTR [rax+0x7f], al
    cmp BYTE PTR [rax+0x80], al
    cmp BYTE PTR [rax+rbx*4], al
    cmp BYTE PTR [rbx*8+0x10], al
    cmp BYTE PTR [rip+0x100], al
    cmp BYTE PTR [0x1000], al
    cmp BYTE PTR [r13], al
    cmp WORD PTR [rax], ax
    cmp WORD PTR [rax+0x7f], ax
    cmp WORD PTR [rax+0x80], ax
    cmp WORD PTR [rax+rbx*4], ax
    cmp WORD PTR [rbx*8+0x10], ax
    cmp WORD PTR [rip+0x100], ax
    cmp WORD PTR [0x1000], ax
    cmp WORD PTR [r13], ax
    cmp DWORD PTR [rax], eax
    cmp DWORD PTR [rax+0x7f], eax
    cmp DWORD PTR [rax+0x80], eax
    cmp DWORD PTR [rax+rbx*4], eax
    cmp DWORD PTR [rbx*8+0x10], eax
    cmp DWORD PTR [rip+0x100], eax
    cmp DWORD PTR [0x1000], eax
    cmp DWORD PTR [r13], eax
    cmp QWORD PTR [rax], rax
    cmp QWORD PTR [rax+0x7f], rax
    cmp QWORD PTR [rax+0x80], rax
    cmp QWORD PTR [rax+rbx*4], rax
    cmp QWORD PTR [rbx*8+0x10], rax
    cmp QWORD PTR [rip+0x100], rax
    cmp QWORD PTR [0x1000], rax
    cmp QWORD PTR [r13], rax
    cmp al, BYTE PTR [rax]
    cmp al, BYTE PTR [rax+0x7f]
    cmp al, BYTE PTR [rax+0x80]
    cmp al, BYTE PTR [rax+rbx*4]
    cmp al, BYTE PTR [rbx*8+0x10]
    cmp al, BYTE PTR [rip+0x100]
    cmp al, BYTE PTR [0x1000]
    cmp al, BYTE PTR [r13]
    cmp ax, WORD PTR [rax]
    cmp ax, WORD PTR [rax+0x7f]
    cmp ax, WORD PTR [rax+0x80]
    cmp ax, WORD PTR [rax+rbx*4]
    cmp ax, WORD PTR [rbx*8+0x10]
    cmp ax, WORD PTR [rip+0x100]
    cmp ax, WORD PTR [0x1000]
    cmp ax, WORD PTR [r13]
    cmp eax, DWORD PTR [rax]
    cmp eax, DWORD PTR [rax+0x7f]
    cmp eax, DWORD PTR [rax+0x80]
    cmp eax, DWORD PTR [rax+rbx*4]
    cmp eax, DWORD PTR [rbx*8+0x10]
    cmp eax, DWORD PTR [rip+0x100]
    cmp eax, DWORD PTR [0x1000]
    cmp eax, DWORD PTR [r13]
    cmp rax, QWORD PTR [rax]
    cmp rax, QWORD PTR [rax+0x7f]
    cmp rax, QWORD PTR [rax+0x80]
    cmp rax, QWORD PTR [rax+rbx*4]
    cmp rax, QWORD PTR [rbx*8+0x10]
    cmp rax, QWORD PTR [rip+0x100]
    cmp rax, QWORD PTR [0x1000]
    cmp rax, QWORD PTR [r13]
    cmpbexadd DWORD PTR [rax], eax, eax
    cmpbexadd DWORD PTR [rax+0x7f], eax, eax
    cmpbexadd DWORD PTR [rax+0x80], eax, eax
    cmpbexadd DWORD PTR [rax+rbx*4], eax, eax
    cmpbexadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpbexadd DWORD PTR [rip+0x100], eax, eax
    cmpbexadd DWORD PTR [0x1000], eax, eax
    cmpbexadd DWORD PTR [r13], eax, eax
    cmpbexadd QWORD PTR [rax], rax, rax
    cmpbexadd QWORD PTR [rax+0x7f], rax, rax
    cmpbexadd QWORD PTR [rax+0x80], rax, rax
    cmpbexadd QWORD PTR [rax+rbx*4], rax, rax
    cmpbexadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpbexadd QWORD PTR [rip+0x100], rax, rax
    cmpbexadd QWORD PTR [0x1000], rax, rax
    cmpbexadd QWORD PTR [r13], rax, rax
    cmpbxadd DWORD PTR [rax], eax, eax
    cmpbxadd DWORD PTR [rax+0x7f], eax, eax
    cmpbxadd DWORD PTR [rax+0x80], eax, eax
    cmpbxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpbxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpbxadd DWORD PTR [rip+0x100], eax, eax
    cmpbxadd DWORD PTR [0x1000], eax, eax
    cmpbxadd DWORD PTR [r13], eax, eax
    cmpbxadd QWORD PTR [rax], rax, rax
    cmpbxadd QWORD PTR [rax+0x7f], rax, rax
    cmpbxadd QWORD PTR [rax+0x80], rax, rax
    cmpbxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpbxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpbxadd QWORD PTR [rip+0x100], rax, rax
    cmpbxadd QWORD PTR [0x1000], rax, rax
    cmpbxadd QWORD PTR [r13], rax, rax
    cmplexadd DWORD PTR [rax], eax, eax
    cmplexadd DWORD PTR [rax+0x7f], eax, eax
    cmplexadd DWORD PTR [rax+0x80], eax, eax
    cmplexadd DWORD PTR [rax+rbx*4], eax, eax
    cmplexadd DWORD PTR [rbx*8+0x10], eax, eax
    cmplexadd DWORD PTR [rip+0x100], eax, eax
    cmplexadd DWORD PTR [0x1000], eax, eax
    cmplexadd DWORD PTR [r13], eax, eax
    cmplexadd QWORD PTR [rax], rax, rax
    cmplexadd QWORD PTR [rax+0x7f], rax, rax
    cmplexadd QWORD PTR [rax+0x80], rax, rax
    cmplexadd QWORD PTR [rax+rbx*4], rax, rax
    cmplexadd QWORD PTR [rbx*8+0x10], rax, rax
    cmplexadd QWORD PTR [rip+0x100], rax, rax
    cmplexadd QWORD PTR [0x1000], rax, rax
    cmplexadd QWORD PTR [r13], rax, rax
    cmplxadd DWORD PTR [rax], eax, eax
    cmplxadd DWORD PTR [rax+0x7f], eax, eax
    cmplxadd DWORD PTR [rax+0x80], eax, eax
    cmplxadd DWORD PTR [rax+rbx*4], eax, eax
    cmplxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmplxadd DWORD PTR [rip+0x100], eax, eax
    cmplxadd DWORD PTR [0x1000], eax, eax
    cmplxadd DWORD PTR [r13], eax, eax
    cmplxadd QWORD PTR [rax], rax, rax
    cmplxadd QWORD PTR [rax+0x7f], rax, rax
    cmplxadd QWORD PTR [rax+0x80], rax, rax
    cmplxadd QWORD PTR [rax+rbx*4], rax, rax
    cmplxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmplxadd QWORD PTR [rip+0x100], rax, rax
    cmplxadd QWORD PTR [0x1000], rax, rax
    cmplxadd QWORD PTR [r13], rax, rax
    cmpnbexadd DWORD PTR [rax], eax, eax
    cmpnbexadd DWORD PTR [rax+0x7f], eax, eax
    cmpnbexadd DWORD PTR [rax+0x80], eax, eax
    cmpnbexadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnbexadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnbexadd DWORD PTR [rip+0x100], eax, eax
    cmpnbexadd DWORD PTR [0x1000], eax, eax
    cmpnbexadd DWORD PTR [r13], eax, eax
    cmpnbexadd QWORD PTR [rax], rax, rax
    cmpnbexadd QWORD PTR [rax+0x7f], rax, rax
    cmpnbexadd QWORD PTR [rax+0x80], rax, rax
    cmpnbexadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnbexadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnbexadd QWORD PTR [rip+0x100], rax, rax
    cmpnbexadd QWORD PTR [0x1000], rax, rax
    cmpnbexadd QWORD PTR [r13], rax, rax
    cmpnbxadd DWORD PTR [rax], eax, eax
    cmpnbxadd DWORD PTR [rax+0x7f], eax, eax
    cmpnbxadd DWORD PTR [rax+0x80], eax, eax
    cmpnbxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnbxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnbxadd DWORD PTR [rip+0x100], eax, eax
    cmpnbxadd DWORD PTR [0x1000], eax, eax
    cmpnbxadd DWORD PTR [r13], eax, eax
    cmpnbxadd QWORD PTR [rax], rax, rax
    cmpnbxadd QWORD PTR [rax+0x7f], rax, rax
    cmpnbxadd QWORD PTR [rax+0x80], rax, rax
    cmpnbxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnbxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnbxadd QWORD PTR [rip+0x100], rax, rax
    cmpnbxadd QWORD PTR [0x1000], rax, rax
    cmpnbxadd QWORD PTR [r13], rax, rax
    cmpnlexadd DWORD PTR [rax], eax, eax
    cmpnlexadd DWORD PTR [rax+0x7f], eax, eax
    cmpnlexadd DWORD PTR [rax+0x80], eax, eax
    cmpnlexadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnlexadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnlexadd DWORD PTR [rip+0x100], eax, eax
    cmpnlexadd DWORD PTR [0x1000], eax, eax
    cmpnlexadd DWORD PTR [r13], eax, eax
    cmpnlexadd QWORD PTR [rax], rax, rax
    cmpnlexadd QWORD PTR [rax+0x7f], rax, rax
    cmpnlexadd QWORD PTR [rax+0x80], rax, rax
    cmpnlexadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnlexadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnlexadd QWORD PTR [rip+0x100], rax, rax
    cmpnlexadd QWORD PTR [0x1000], rax, rax
    cmpnlexadd QWORD PTR [r13], rax, rax
    cmpnlxadd DWORD PTR [rax], eax, eax
    cmpnlxadd DWORD PTR [rax+0x7f], eax, eax
    cmpnlxadd DWORD PTR [rax+0x80], eax, eax
    cmpnlxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnlxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnlxadd DWORD PTR [rip+0x100], eax, eax
    cmpnlxadd DWORD PTR [0x1000], eax, eax
    cmpnlxadd DWORD PTR [r13], eax, eax
    cmpnlxadd QWORD PTR [rax], rax, rax
    cmpnlxadd QWORD PTR [rax+0x7f], rax, rax
    cmpnlxadd QWORD PTR [rax+0x80], rax, rax
    cmpnlxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnlxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnlxadd QWORD PTR [rip+0x100], rax, rax
    cmpnlxadd QWORD PTR [0x1000], rax, rax
    cmpnlxadd QWORD PTR [r13], rax, rax
    cmpnoxadd DWORD PTR [rax], eax, eax
    cmpnoxadd DWORD PTR [rax+0x7f], eax, eax
    cmpnoxadd DWORD PTR [rax+0x80], eax, eax
    cmpnoxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnoxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnoxadd DWORD PTR [rip+0x100], eax, eax
    cmpnoxadd DWORD PTR [0x1000], eax, eax
    cmpnoxadd DWORD PTR [r13], eax, eax
    cmpnoxadd QWORD PTR [rax], rax, rax
    cmpnoxadd QWORD PTR [rax+0x7f], rax, rax
    cmpnoxadd QWORD PTR [rax+0x80], rax, rax
    cmpnoxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnoxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnoxadd QWORD PTR [rip+0x100], rax, rax
    cmpnoxadd QWORD PTR [0x1000], rax, rax
    cmpnoxadd QWORD PTR [r13], rax, rax
    cmpnpxadd DWORD PTR [rax], eax, eax
    cmpnpxadd DWORD PTR [rax+0x7f], eax, eax
    cmpnpxadd DWORD PTR [rax+0x80], eax, eax
    cmpnpxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnpxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnpxadd DWORD PTR [rip+0x100], eax, eax
    cmpnpxadd DWORD PTR [0x1000], eax, eax
    cmpnpxadd DWORD PTR [r13], eax, eax
    cmpnpxadd QWORD PTR [rax], rax, rax
    cmpnpxadd QWORD PTR [rax+0x7f], rax, rax
    cmpnpxadd QWORD PTR [rax+0x80], rax, rax
    cmpnpxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnpxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnpxadd QWORD PTR [rip+0x100], rax, rax
    cmpnpxadd QWORD PTR [0x1000], rax, rax
    cmpnpxadd QWORD PTR [r13], rax, rax
    cmpnsxadd DWORD PTR [rax], eax, eax
    cmpnsxadd DWORD PTR [rax+0x7f], eax, eax
    cmpnsxadd DWORD PTR [rax+0x80], eax, eax
    cmpnsxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnsxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnsxadd DWORD PTR [rip+0x100], eax, eax
    cmpnsxadd DWORD PTR [0x1000], eax, eax
    cmpnsxadd DWORD PTR [r13], eax, eax
    cmpnsxadd QWORD PTR [rax], rax, rax
    cmpnsxadd QWORD PTR [rax+0x7f], rax, rax
    cmpnsxadd QWORD PTR [rax+0x80], rax, rax
    cmpnsxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnsxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnsxadd QWORD PTR [rip+0x100], rax, rax
    cmpnsxadd QWORD PTR [0x1000], rax, rax
    cmpnsxadd QWORD PTR [r13], rax, rax
    cmpnzxadd DWORD PTR [rax], eax, eax
    cmpnzxadd DWORD PTR [rax+0x7f], eax, eax
    cmpnzxadd DWORD PTR [rax+0x80], eax, eax
    cmpnzxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpnzxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpnzxadd DWORD PTR [rip+0x100], eax, eax
    cmpnzxadd DWORD PTR [0x1000], eax, eax
    cmpnzxadd DWORD PTR [r13], eax, eax
    cmpnzxadd QWORD PTR [rax], rax, rax
    cmpnzxadd QWORD PTR [rax+0x7f], rax, rax
    cmpnzxadd QWORD PTR [rax+0x80], rax, rax
    cmpnzxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpnzxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpnzxadd QWORD PTR [rip+0x100], rax, rax
    cmpnzxadd QWORD PTR [0x1000], rax, rax
    cmpnzxadd QWORD PTR [r13], rax, rax
    cmpoxadd DWORD PTR [rax], eax, eax
    cmpoxadd DWORD PTR [rax+0x7f], eax, eax
    cmpoxadd DWORD PTR [rax+0x80], eax, eax
    cmpoxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpoxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpoxadd DWORD PTR [rip+0x100], eax, eax
    cmpoxadd DWORD PTR [0x1000], eax, eax
    cmpoxadd DWORD PTR [r13], eax, eax
    cmpoxadd QWORD PTR [rax], rax, rax
    cmpoxadd QWORD PTR [rax+0x7f], rax, rax
    cmpoxadd QWORD PTR [rax+0x80], rax, rax
    cmpoxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpoxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpoxadd QWORD PTR [rip+0x100], rax, rax
    cmpoxadd QWORD PTR [0x1000], rax, rax
    cmpoxadd QWORD PTR [r13], rax, rax
    cmppxadd DWORD PTR [rax], eax, eax
    cmppxadd DWORD PTR [rax+0x7f], eax, eax
    cmppxadd DWORD PTR [rax+0x80], eax, eax
    cmppxadd DWORD PTR [rax+rbx*4], eax, eax
    cmppxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmppxadd DWORD PTR [rip+0x100], eax, eax
    cmppxadd DWORD PTR [0x1000], eax, eax
    cmppxadd DWORD PTR [r13], eax, eax
    cmppxadd QWORD PTR [rax], rax, rax
    cmppxadd QWORD PTR [rax+0x7f], rax, rax
    cmppxadd QWORD PTR [rax+0x80], rax, rax
    cmppxadd QWORD PTR [rax+rbx*4], rax, rax
    cmppxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmppxadd QWORD PTR [rip+0x100], rax, rax
    cmppxadd QWORD PTR [0x1000], rax, rax
    cmppxadd QWORD PTR [r13], rax, rax
    cmpsxadd DWORD PTR [rax], eax, eax
    cmpsxadd DWORD PTR [rax+0x7f], eax, eax
    cmpsxadd DWORD PTR [rax+0x80], eax, eax
    cmpsxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpsxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpsxadd DWORD PTR [rip+0x100], eax, eax
    cmpsxadd DWORD PTR [0x1000], eax, eax
    cmpsxadd DWORD PTR [r13], eax, eax
    cmpsxadd QWORD PTR [rax], rax, rax
    cmpsxadd QWORD PTR [rax+0x7f], rax, rax
    cmpsxadd QWORD PTR [rax+0x80], rax, rax
    cmpsxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpsxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpsxadd QWORD PTR [rip+0x100], rax, rax
    cmpsxadd QWORD PTR [0x1000], rax, rax
    cmpsxadd QWORD PTR [r13], rax, rax
    cmpzxadd DWORD PTR [rax], eax, eax
    cmpzxadd DWORD PTR [rax+0x7f], eax, eax
    cmpzxadd DWORD PTR [rax+0x80], eax, eax
    cmpzxadd DWORD PTR [rax+rbx*4], eax, eax
    cmpzxadd DWORD PTR [rbx*8+0x10], eax, eax
    cmpzxadd DWORD PTR [rip+0x100], eax, eax
    cmpzxadd DWORD PTR [0x1000], eax, eax
    cmpzxadd DWORD PTR [r13], eax, eax
    cmpzxadd QWORD PTR [rax], rax, rax
    cmpzxadd QWORD PTR [rax+0x7f], rax, rax
    cmpzxadd QWORD PTR [rax+0x80], rax, rax
    cmpzxadd QWORD PTR [rax+rbx*4], rax, rax
    cmpzxadd QWORD PTR [rbx*8+0x10], rax, rax
    cmpzxadd QWORD PTR [rip+0x100], rax, rax
    cmpzxadd QWORD PTR [0x1000], rax, rax
    cmpzxadd QWORD PTR [r13], rax, rax
    cmppd xmm1, [rax], 0x1
    cmppd xmm1, [rax+0x7f], 0x1
    cmppd xmm1, [rax+0x80], 0x1
    cmppd xmm1, [rax+rbx*4], 0x1
    cmppd xmm1, [rbx*8+0x10], 0x1
    cmppd xmm1, [rip+0x100], 0x1
    cmppd xmm1, [0x1000], 0x1
    cmppd xmm1, [r13], 0x1
    vcmppd xmm1, xmm2, [rax], 0x1
    vcmppd xmm1, xmm2, [rax+0x7f], 0x1
    vcmppd xmm1, xmm2, [rax+0x80], 0x1
    vcmppd xmm1, xmm2, [rax+rbx*4], 0x1
    vcmppd xmm1, xmm2, [rbx*8+0x10], 0x1
    vcmppd xmm1, xmm2, [rip+0x100], 0x1
    vcmppd xmm1, xmm2, [0x1000], 0x1
    vcmppd xmm1, xmm2, [r13], 0x1
    vcmppd ymm1, ymm2, [rax], 0x1
    vcmppd ymm1, ymm2, [rax+0x7f], 0x1
    vcmppd ymm1, ymm2, [rax+0x80], 0x1
    vcmppd ymm1, ymm2, [rax+rbx*4], 0x1
    vcmppd ymm1, ymm2, [rbx*8+0x10], 0x1
    vcmppd ymm1, ymm2, [rip+0x100], 0x1
    vcmppd ymm1, ymm2, [0x1000], 0x1
    vcmppd ymm1, ymm2, [r13], 0x1
    cmpps xmm1, [rax], 0x1
    cmpps xmm1, [rax+0x7f], 0x1
    cmpps xmm1, [rax+0x80], 0x1
    cmpps xmm1, [rax+rbx*4], 0x1
    cmpps xmm1, [rbx*8+0x10], 0x1
    cmpps xmm1, [rip+0x100], 0x1
    cmpps xmm1, [0x1000], 0x1
    cmpps xmm1, [r13], 0x1
    vcmpps xmm1, xmm2, [rax], 0x1
    vcmpps xmm1, xmm2, [rax+0x7f], 0x1
    vcmpps xmm1, xmm2, [rax+0x80], 0x1
    vcmpps xmm1, xmm2, [rax+rbx*4], 0x1
    vcmpps xmm1, xmm2, [rbx*8+0x10], 0x1
    vcmpps xmm1, xmm2, [rip+0x100], 0x1
    vcmpps xmm1, xmm2, [0x1000], 0x1
    vcmpps xmm1, xmm2, [r13], 0x1
    vcmpps ymm1, ymm2, [rax], 0x1
    vcmpps ymm1, ymm2, [rax+0x7f], 0x1
    vcmpps ymm1, ymm2, [rax+0x80], 0x1
    vcmpps ymm1, ymm2, [rax+rbx*4], 0x1
    vcmpps ymm1, ymm2, [rbx*8+0x10], 0x1
    vcmpps ymm1, ymm2, [rip+0x100], 0x1
    vcmpps ymm1, ymm2, [0x1000], 0x1
    vcmpps ymm1, ymm2, [r13], 0x1
    cmps BYTE PTR [rax], BYTE PTR [rax]
    cmps BYTE PTR [rax+0x7f], BYTE PTR [rax]
    cmps BYTE PTR [rax+0x80], BYTE PTR [rax]
    cmps BYTE PTR [rax+rbx*4], BYTE PTR [rax]
    cmps BYTE PTR [rbx*8+0x10], BYTE PTR [rax]
    cmps BYTE PTR [rip+0x100], BYTE PTR [rax]
    cmps BYTE PTR [0x1000], BYTE PTR [rax]
    cmps BYTE PTR [r13], BYTE PTR [rax]
    cmps WORD PTR [rax], WORD PTR [rax]
    cmps WORD PTR [rax+0x7f], WORD PTR [rax]
    cmps WORD PTR [rax+0x80], WORD PTR [rax]
    cmps WORD PTR [rax+rbx*4], WORD PTR [rax]
    cmps WORD PTR [rbx*8+0x10], WORD PTR [rax]
    cmps WORD PTR [rip+0x100], WORD PTR [rax]
    cmps WORD PTR [0x1000], WORD PTR [rax]
    cmps WORD PTR [r13], WORD PTR [rax]
    cmps DWORD PTR [rax], DWORD PTR [rax]
    cmps DWORD PTR [rax+0x7f], DWORD PTR [rax]
    cmps DWORD PTR [rax+0x80], DWORD PTR [rax]
    cmps DWORD PTR [rax+rbx*4], DWORD PTR [rax]
    cmps DWORD PTR [rbx*8+0x10], DWORD PTR [rax]
    cmps DWORD PTR [rip+0x100], DWORD PTR [rax]
    cmps DWORD PTR [0x1000], DWORD PTR [rax]
    cmps DWORD PTR [r13], DWORD PTR [rax]
    cmps QWORD PTR [rax], QWORD PTR [rax]
    cmps QWORD PTR [rax+0x7f], QWORD PTR [rax]
    cmps QWORD PTR [rax+0x80], QWORD PTR [rax]
    cmps QWORD PTR [rax+rbx*4], QWORD PTR [rax]
    cmps QWORD PTR [rbx*8+0x10], QWORD PTR [rax]
    cmps QWORD PTR [rip+0x100], QWORD PTR [rax]
    cmps QWORD PTR [0x1000], QWORD PTR [rax]
    cmps QWORD PTR [r13], QWORD PTR [rax]
    cmpsd xmm1, QWORD PTR [rax], 0x1
    cmpsd xmm1, QWORD PTR [rax+0x7f], 0x1
    cmpsd xmm1, QWORD PTR [rax+0x80], 0x1
    cmpsd xmm1, QWORD PTR [rax+rbx*4], 0x1
    cmpsd xmm1, QWORD PTR [rbx*8+0x10], 0x1
    cmpsd xmm1, QWORD PTR [rip+0x100], 0x1
    cmpsd xmm1, QWORD PTR [0x1000], 0x1
    cmpsd xmm1, QWORD PTR [r13], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [rax], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [rax+0x7f], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [rax+0x80], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [rax+rbx*4], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [rbx*8+0x10], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [rip+0x100], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [0x1000], 0x1
    vcmpsd xmm1, xmm2, QWORD PTR [r13], 0x1
    cmpss xmm1, DWORD PTR [rax], 0x1
    cmpss xmm1, DWORD PTR [rax+0x7f], 0x1
    cmpss xmm1, DWORD PTR [rax+0x80], 0x1
    cmpss xmm1, DWORD PTR [rax+rbx*4], 0x1
    cmpss xmm1, DWORD PTR [rbx*8+0x10], 0x1
    cmpss xmm1, DWORD PTR [rip+0x100], 0x1
    cmpss xmm1, DWORD PTR [0x1000], 0x1
    cmpss xmm1, DWORD PTR [r13], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [rax], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [rax+0x7f], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [rax+0x80], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [rax+rbx*4], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [rbx*8+0x10], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [rip+0x100], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [0x1000], 0x1
    vcmpss xmm1, xmm2, DWORD PTR [r13], 0x1
    cmpxchg BYTE PTR [rax], al
    cmpxchg BYTE PTR [rax+0x7f], al
    cmpxchg BYTE PTR [rax+0x80], al
    cmpxchg BYTE PTR [rax+rbx*4], al
    cmpxchg BYTE PTR [rbx*8+0x10], al
    cmpxchg BYTE PTR [rip+0x100], al
    cmpxchg BYTE PTR [0x1000], al
    cmpxchg BYTE PTR [r13], al
    cmpxchg WORD PTR [rax], ax
    cmpxchg WORD PTR [rax+0x7f], ax
    cmpxchg WORD PTR [rax+0x80], ax
    cmpxchg WORD PTR [rax+rbx*4], ax
    cmpxchg WORD PTR [rbx*8+0x10], ax
    cmpxchg WORD PTR [rip+0x100], ax
    cmpxchg WORD PTR [0x1000], ax
    cmpxchg WORD PTR [r13], ax
    cmpxchg DWORD PTR [rax], eax
    cmpxchg DWORD PTR [rax+0x7f], eax
    cmpxchg DWORD PTR [rax+0x80], eax
    cmpxchg DWORD PTR [rax+rbx*4], eax
    cmpxchg DWORD PTR [rbx*8+0x10], eax
    cmpxchg DWORD PTR [rip+0x100], eax
    cmpxchg DWORD PTR [0x1000], eax
    cmpxchg DWORD PTR [r13], eax
    cmpxchg QWORD PTR [rax], rax
    cmpxchg QWORD PTR [rax+0x7f], rax
    cmpxchg QWORD PTR [rax+0x80], rax
    cmpxchg QWORD PTR [rax+rbx*4], rax
    cmpxchg QWORD PTR [rbx*8+0x10], rax
    cmpxchg QWORD PTR [rip+0x100], rax
    cmpxchg QWORD PTR [0x1000], rax
    cmpxchg QWORD PTR [r13], rax
    cmpxchg8b QWORD PTR [rax]
    cmpxchg8b QWORD PTR [rax+0x7f]
    cmpxchg8b QWORD PTR [rax+0x80]
    cmpxchg8b QWORD PTR [rax+rbx*4]
    cmpxchg8b QWORD PTR [rbx*8+0x10]
    cmpxchg8b QWORD PTR [rip+0x100]
    cmpxchg8b QWORD PTR [0x1000]
    cmpxchg8b QWORD PTR [r13]
    cmpxchg16b [rax]
    cmpxchg16b [rax+0x7f]
    cmpxchg16b [rax+0x80]
    cmpxchg16b [rax+rbx*4]
    cmpxchg16b [rbx*8+0x10]
    cmpxchg16b [rip+0x100]
    cmpxchg16b [0x1000]
    cmpxchg16b [r13]
    comisd xmm1, QWORD PTR [rax]
    comisd xmm1, QWORD PTR [rax+0x7f]
    comisd xmm1, QWORD PTR [rax+0x80]
    comisd xmm1, QWORD PTR [rax+rbx*4]
    comisd xmm1, QWORD PTR [rbx*8+0x10]
    comisd xmm1, QWORD PTR [rip+0x100]
    comisd xmm1, QWORD PTR [0x1000]
    comisd xmm1, QWORD PTR [r13]
    vcomisd xmm1, QWORD PTR [rax]
    vcomisd xmm1, QWORD PTR [rax+0x7f]
    vcomisd xmm1, QWORD PTR [rax+0x80]
    vcomisd xmm1, QWORD PTR [rax+rbx*4]
    vcomisd xmm1, QWORD PTR [rbx*8+0x10]
    vcomisd xmm1, QWORD PTR [rip+0x100]
    vcomisd xmm1, QWORD PTR [0x1000]
    vcomisd xmm1, QWORD PTR [r13]
    comiss xmm1, DWORD PTR [rax]
    comiss xmm1, DWORD PTR [rax+0x7f]
    comiss xmm1, DWORD PTR [rax+0x80]
    comiss xmm1, DWORD PTR [rax+rbx*4]
    comiss xmm1, DWORD PTR [rbx*8+0x10]
    comiss xmm1, DWORD PTR [rip+0x100]
    comiss xmm1, DWORD PTR [0x1000]
    comiss xmm1, DWORD PTR [r13]
    vcomiss xmm1, DWORD PTR [rax]
    vcomiss xmm1, DWORD PTR [rax+0x7f]
    vcomiss xmm1, DWORD PTR [rax+0x80]
    vcomiss xmm1, DWORD PTR [rax+rbx*4]
    vcomiss xmm1, DWORD PTR [rbx*8+0x10]
    vcomiss xmm1, DWORD PTR [rip+0x100]
    vcomiss xmm1, DWORD PTR [0x1000]
    vcomiss xmm1, DWORD PTR [r13]
    crc32 eax, BYTE PTR [rax]
    crc32 eax, BYTE PTR [rax+0x7f]
    crc32 eax, BYTE PTR [rax+0x80]
    crc32 eax, BYTE PTR [rax+rbx*4]
    crc32 eax, BYTE PTR [rbx*8+0x10]
    crc32 eax, BYTE PTR [rip+0x100]
    crc32 eax, BYTE PTR [0x1000]
    crc32 eax, BYTE PTR [r13]
    crc32 eax, WORD PTR [rax]
    crc32 eax, WORD PTR [rax+0x7f]
    crc32 eax, WORD PTR [rax+0x80]
    crc32 eax, WORD PTR [rax+rbx*4]
    crc32 eax, WORD PTR [rbx*8+0x10]
    crc32 eax, WORD PTR [rip+0x100]
    crc32 eax, WORD PTR [0x1000]
    crc32 eax, WORD PTR [r13]
    crc32 eax, DWORD PTR [rax]
    crc32 eax, DWORD PTR [rax+0x7f]
    crc32 eax, DWORD PTR [rax+0x80]
    crc32 eax, DWORD PTR [rax+rbx*4]
    crc32 eax, DWORD PTR [rbx*8+0x10]
    crc32 eax, DWORD PTR [rip+0x100]
    crc32 eax, DWORD PTR [0x1000]
    crc32 eax, DWORD PTR [r13]
    crc32 rax, BYTE PTR [rax]
    crc32 rax, BYTE PTR [rax+0x7f]
    crc32 rax, BYTE PTR [rax+0x80]
    crc32 rax, BYTE PTR [rax+rbx*4]
    crc32 rax, BYTE PTR [rbx*8+0x10]
    crc32 rax, BYTE PTR [rip+0x100]
    crc32 rax, BYTE PTR [0x1000]
    crc32 rax, BYTE PTR [r13]
    crc32 rax, QWORD PTR [rax]
    crc32 rax, QWORD PTR [rax+0x7f]
    crc32 rax, QWORD PTR [rax+0x80]
    crc32 rax, QWORD PTR [rax+rbx*4]
    crc32 rax, QWORD PTR [rbx*8+0x10]
    crc32 rax, QWORD PTR [rip+0x100]
    crc32 rax, QWORD PTR [0x1000]
    crc32 rax, QWORD PTR [r13]
    cvtdq2pd xmm1, QWORD PTR [rax]
    cvtdq2pd xmm1, QWORD PTR [rax+0x7f]
    cvtdq2pd xmm1, QWORD PTR [rax+0x80]
    cvtdq2pd xmm1, QWORD PTR [rax+rbx*4]
    cvtdq2pd xmm1, QWORD PTR [rbx*8+0x10]
    cvtdq2pd xmm1, QWORD PTR [rip+0x100]
    cvtdq2pd xmm1, QWORD PTR [0x1000]
    cvtdq2pd xmm1, QWORD PTR [r13]
    vcvtdq2pd xmm1, QWORD PTR [rax]
    vcvtdq2pd xmm1, QWORD PTR [rax+0x7f]
    vcvtdq2pd xmm1, QWORD PTR [rax+0x80]
    vcvtdq2pd xmm1, QWORD PTR [rax+rbx*4]
    vcvtdq2pd xmm1, QWORD PTR [rbx*8+0x10]
    vcvtdq2pd xmm1, QWORD PTR [rip+0x100]
    vcvtdq2pd xmm1, QWORD PTR [0x1000]
    vcvtdq2pd xmm1, QWORD PTR [r13]
    vcvtdq2pd ymm1, [rax]
    vcvtdq2pd ymm1, [rax+0x7f]
    vcvtdq2pd ymm1, [rax+0x80]
    vcvtdq2pd ymm1, [rax+rbx*4]
    vcvtdq2pd ymm1, [rbx*8+0x10]
    vcvtdq2pd ymm1, [rip+0x100]
    vcvtdq2pd ymm1, [0x1000]
    vcvtdq2pd ymm1, [r13]
    cvtdq2ps xmm1, [rax]
    cvtdq2ps xmm1, [rax+0x7f]
    cvtdq2ps xmm1, [rax+0x80]
    cvtdq2ps xmm1, [rax+rbx*4]
    cvtdq2ps xmm1, [rbx*8+0x10]
    cvtdq2ps xmm1, [rip+0x100]
    cvtdq2ps xmm1, [0x1000]
    cvtdq2ps xmm1, [r13]
    vcvtdq2ps xmm1, [rax]
    vcvtdq2ps xmm1, [rax+0x7f]
    vcvtdq2ps xmm1, [rax+0x80]
    vcvtdq2ps xmm1, [rax+rbx*4]
    vcvtdq2ps xmm1, [rbx*8+0x10]
    vcvtdq2ps xmm1, [rip+0x100]
    vcvtdq2ps xmm1, [0x1000]
    vcvtdq2ps xmm1, [r13]
    vcvtdq2ps ymm1, [rax]
    vcvtdq2ps ymm1, [rax+0x7f]
    vcvtdq2ps ymm1, [rax+0x80]
    vcvtdq2ps ymm1, [rax+rbx*4]
    vcvtdq2ps ymm1, [rbx*8+0x10]
    vcvtdq2ps ymm1, [rip+0x100]
    vcvtdq2ps ymm1, [0x1000]
    vcvtdq2ps ymm1, [r13]
    cvtpd2dq xmm1, [rax]
    cvtpd2dq xmm1, [rax+0x7f]
    cvtpd2dq xmm1, [rax+0x80]
    cvtpd2dq xmm1, [rax+rbx*4]
    cvtpd2dq xmm1, [rbx*8+0x10]
    cvtpd2dq xmm1, [rip+0x100]
    cvtpd2dq xmm1, [0x1000]
    cvtpd2dq xmm1, [r13]
    vcvtpd2dq xmm1, [rax]
    vcvtpd2dq xmm1, [rax+0x7f]
    vcvtpd2dq xmm1, [rax+0x80]
    vcvtpd2dq xmm1, [rax+rbx*4]
    vcvtpd2dq xmm1, [rbx*8+0x10]
    vcvtpd2dq xmm1, [rip+0x100]
    vcvtpd2dq xmm1, [0x1000]
    vcvtpd2dq xmm1, [r13]
    cvtpd2pi mm0, [rax]
    cvtpd2pi mm0, [rax+0x7f]
    cvtpd2pi mm0, [rax+0x80]
    cvtpd2pi mm0, [rax+rbx*4]
    cvtpd2pi mm0, [rbx*8+0x10]
    cvtpd2pi mm0, [rip+0x100]
    cvtpd2pi mm0, [0x1000]
    cvtpd2pi mm0, [r13]
    cvtpd2ps xmm1, [rax]
    cvtpd2ps xmm1, [rax+0x7f]
    cvtpd2ps xmm1, [rax+0x80]
    cvtpd2ps xmm1, [rax+rbx*4]
    cvtpd2ps xmm1, [rbx*8+0x10]
    cvtpd2ps xmm1, [rip+0x100]
    cvtpd2ps xmm1, [0x1000]
    cvtpd2ps xmm1, [r13]
    vcvtpd2ps xmm1, [rax]
    vcvtpd2ps xmm1, [rax+0x7f]
    vcvtpd2ps xmm1, [rax+0x80]
    vcvtpd2ps xmm1, [rax+rbx*4]
    vcvtpd2ps xmm1, [rbx*8+0x10]
    vcvtpd2ps xmm1, [rip+0x100]
    vcvtpd2ps xmm1, [0x1000]
    vcvtpd2ps xmm1, [r13]
    cvtpi2pd xmm0, QWORD PTR [rax]
    cvtpi2pd xmm0, QWORD PTR [rax+0x7f]
    cvtpi2pd xmm0, QWORD PTR [rax+0x80]
    cvtpi2pd xmm0, QWORD PTR [rax+rbx*4]
    cvtpi2pd xmm0, QWORD PTR [rbx*8+0x10]
    cvtpi2pd xmm0, QWORD PTR [rip+0x100]
    cvtpi2pd xmm0, QWORD PTR [0x1000]
    cvtpi2pd xmm0, QWORD PTR [r13]
    cvtpi2ps xmm0, QWORD PTR [rax]
    cvtpi2ps xmm0, QWORD PTR [rax+0x7f]
    cvtpi2ps xmm0, QWORD PTR [rax+0x80]
    cvtpi2ps xmm0, QWORD PTR [rax+rbx*4]
    cvtpi2ps xmm0, QWORD PTR [rbx*8+0x10]
    cvtpi2ps xmm0, QWORD PTR [rip+0x100]
    cvtpi2ps xmm0, QWORD PTR [0x1000]
    cvtpi2ps xmm0, QWORD PTR [r13]
    cvtps2dq xmm1, [rax]
    cvtps2dq xmm1, [rax+0x7f]
    cvtps2dq xmm1, [rax+0x80]
    cvtps2dq xmm1, [rax+rbx*4]
    cvtps2dq xmm1, [rbx*8+0x10]
    cvtps2dq xmm1, [rip+0x100]
    cvtps2dq xmm1, [0x1000]
    cvtps2dq xmm1, [r13]
    vcvtps2dq xmm1, [rax]
    vcvtps2dq xmm1, [rax+0x7f]
    vcvtps2dq xmm1, [rax+0x80]
    vcvtps2dq xmm1, [rax+rbx*4]
    vcvtps2dq xmm1, [rbx*8+0x10]
    vcvtps2dq xmm1, [rip+0x100]
    vcvtps2dq xmm1, [0x1000]
    vcvtps2dq xmm1, [r13]
    vcvtps2dq ymm1, [rax]
    vcvtps2dq ymm1, [rax+0x7f]
    vcvtps2dq ymm1, [rax+0x80]
    vcvtps2dq ymm1, [rax+rbx*4]
    vcvtps2dq ymm1, [rbx*8+0x10]
    vcvtps2dq ymm1, [rip+0x100]
    vcvtps2dq ymm1, [0x1000]
    vcvtps2dq ymm1, [r13]
    cvtps2pd xmm1, QWORD PTR [rax]
    cvtps2pd xmm1, QWORD PTR [rax+0x7f]
    cvtps2pd xmm1, QWORD PTR [rax+0x80]
    cvtps2pd xmm1, QWORD PTR [rax+rbx*4]
    cvtps2pd xmm1, QWORD PTR [rbx*8+0x10]
    cvtps2pd xmm1, QWORD PTR [rip+0x100]
    cvtps2pd xmm1, QWORD PTR [0x1000]
    cvtps2pd xmm1, QWORD PTR [r13]
    vcvtps2pd xmm1, QWORD PTR [rax]
    vcvtps2pd xmm1, QWORD PTR [rax+0x7f]
    vcvtps2pd xmm1, QWORD PTR [rax+0x80]
    vcvtps2pd xmm1, QWORD PTR [rax+rbx*4]
    vcvtps2pd xmm1, QWORD PTR [rbx*8+0x10]
    vcvtps2pd xmm1, QWORD PTR [rip+0x100]
    vcvtps2pd xmm1, QWORD PTR [0x1000]
    vcvtps2pd xmm1, QWORD PTR [r13]
    vcvtps2pd ymm1, [rax]
    vcvtps2pd ymm1, [rax+0x7f]
    vcvtps2pd ymm1, [rax+0x80]
    vcvtps2pd ymm1, [rax+rbx*4]
    vcvtps2pd ymm1, [rbx*8+0x10]
    vcvtps2pd ymm1, [rip+0x100]
    vcvtps2pd ymm1, [0x1000]
    vcvtps2pd ymm1, [r13]
    cvtps2pi mm0, QWORD PTR [rax]
    cvtps2pi mm0, QWORD PTR [rax+0x7f]
    cvtps2pi mm0, QWORD PTR [rax+0x80]
    cvtps2pi mm0, QWORD PTR [rax+rbx*4]
    cvtps2pi mm0, QWORD PTR [rbx*8+0x10]
    cvtps2pi mm0, QWORD PTR [rip+0x100]
    cvtps2pi mm0, QWORD PTR [0x1000]
    cvtps2pi mm0, QWORD PTR [r13]
    cvtsd2si eax, QWORD PTR [rax]
    cvtsd2si eax, QWORD PTR [rax+0x7f]
    cvtsd2si eax, QWORD PTR [rax+0x80]
    cvtsd2si eax, QWORD PTR [rax+rbx*4]
    cvtsd2si eax, QWORD PTR [rbx*8+0x10]
    cvtsd2si eax, QWORD PTR [rip+0x100]
    cvtsd2si eax, QWORD PTR [0x1000]
    cvtsd2si eax, QWORD PTR [r13]
    cvtsd2si rax, QWORD PTR [rax]
    cvtsd2si rax, QWORD PTR [rax+0x7f]
    cvtsd2si rax, QWORD PTR [rax+0x80]
    cvtsd2si rax, QWORD PTR [rax+rbx*4]
    cvtsd2si rax, QWORD PTR [rbx*8+0x10]
    cvtsd2si rax, QWORD PTR [rip+0x100]
    cvtsd2si rax, QWORD PTR [0x1000]
    cvtsd2si rax, QWORD PTR [r13]
    cvtsd2ss xmm1, QWORD PTR [rax]
    cvtsd2ss xmm1, QWORD PTR [rax+0x7f]
    cvtsd2ss xmm1, QWORD PTR [rax+0x80]
    cvtsd2ss xmm1, QWORD PTR [rax+rbx*4]
    cvtsd2ss xmm1, QWORD PTR [rbx*8+0x10]
    cvtsd2ss xmm1, QWORD PTR [rip+0x100]
    cvtsd2ss xmm1, QWORD PTR [0x1000]
    cvtsd2ss xmm1, QWORD PTR [r13]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [rax]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [rax+0x7f]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [rax+0x80]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [rip+0x100]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [0x1000]
    vcvtsd2ss xmm1, xmm2, QWORD PTR [r13]
    cvtsi2sd xmm1, DWORD PTR [rax]
    cvtsi2sd xmm1, DWORD PTR [rax+0x7f]
    cvtsi2sd xmm1, DWORD PTR [rax+0x80]
    cvtsi2sd xmm1, DWORD PTR [rax+rbx*4]
    cvtsi2sd xmm1, DWORD PTR [rbx*8+0x10]
    cvtsi2sd xmm1, DWORD PTR [rip+0x100]
    cvtsi2sd xmm1, DWORD PTR [0x1000]
    cvtsi2sd xmm1, DWORD PTR [r13]
    cvtsi2sd xmm1, QWORD PTR [rax]
    cvtsi2sd xmm1, QWORD PTR [rax+0x7f]
    cvtsi2sd xmm1, QWORD PTR [rax+0x80]
    cvtsi2sd xmm1, QWORD PTR [rax+rbx*4]
    cvtsi2sd xmm1, QWORD PTR [rbx*8+0x10]
    cvtsi2sd xmm1, QWORD PTR [rip+0x100]
    cvtsi2sd xmm1, QWORD PTR [0x1000]
    cvtsi2sd xmm1, QWORD PTR [r13]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax+0x7f]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax+0x80]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rip+0x100]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [0x1000]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [r13]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [0x1000]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [r13]
    cvtsi2ss xmm1, DWORD PTR [rax]
    cvtsi2ss xmm1, DWORD PTR [rax+0x7f]
    cvtsi2ss xmm1, DWORD PTR [rax+0x80]
    cvtsi2ss xmm1, DWORD PTR [rax+rbx*4]
    cvtsi2ss xmm1, DWORD PTR [rbx*8+0x10]
    cvtsi2ss xmm1, DWORD PTR [rip+0x100]
    cvtsi2ss xmm1, DWORD PTR [0x1000]
    cvtsi2ss xmm1, DWORD PTR [r13]
    cvtsi2ss xmm1, QWORD PTR [rax]
    cvtsi2ss xmm1, QWORD PTR [rax+0x7f]
    cvtsi2ss xmm1, QWORD PTR [rax+0x80]
    cvtsi2ss xmm1, QWORD PTR [rax+rbx*4]
    cvtsi2ss xmm1, QWORD PTR [rbx*8+0x10]
    cvtsi2ss xmm1, QWORD PTR [rip+0x100]
    cvtsi2ss xmm1, QWORD PTR [0x1000]
    cvtsi2ss xmm1, QWORD PTR [r13]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [0x1000]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [r13]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax+0x7f]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax+0x80]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rip+0x100]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [0x1000]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [r13]
    cvtss2sd xmm1, DWORD PTR [rax]
    cvtss2sd xmm1, DWORD PTR [rax+0x7f]
    cvtss2sd xmm1, DWORD PTR [rax+0x80]
    cvtss2sd xmm1, DWORD PTR [rax+rbx*4]
    cvtss2sd xmm1, DWORD PTR [rbx*8+0x10]
    cvtss2sd xmm1, DWORD PTR [rip+0x100]
    cvtss2sd xmm1, DWORD PTR [0x1000]
    cvtss2sd xmm1, DWORD PTR [r13]
    vcvtss2sd xmm1, xmm2, DWORD PTR [rax]
    vcvtss2sd xmm1, xmm2, DWORD PTR [rax+0x7f]
    vcvtss2sd xmm1, xmm2, DWORD PTR [rax+0x80]
    vcvtss2sd xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vcvtss2sd xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vcvtss2sd xmm1, xmm2, DWORD PTR [rip+0x100]
    vcvtss2sd xmm1, xmm2, DWORD PTR [0x1000]
    vcvtss2sd xmm1, xmm2, DWORD PTR [r13]
    cvtss2si eax, DWORD PTR [rax]
    cvtss2si eax, DWORD PTR [rax+0x7f]
    cvtss2si eax, DWORD PTR [rax+0x80]
    cvtss2si eax, DWORD PTR [rax+rbx*4]
    cvtss2si eax, DWORD PTR [rbx*8+0x10]
    cvtss2si eax, DWORD PTR [rip+0x100]
    cvtss2si eax, DWORD PTR [0x1000]
    cvtss2si eax, DWORD PTR [r13]
    cvtss2si rax, DWORD PTR [rax]
    cvtss2si rax, DWORD PTR [rax+0x7f]
    cvtss2si rax, DWORD PTR [rax+0x80]
    cvtss2si rax, DWORD PTR [rax+rbx*4]
    cvtss2si rax, DWORD PTR [rbx*8+0x10]
    cvtss2si rax, DWORD PTR [rip+0x100]
    cvtss2si rax, DWORD PTR [0x1000]
    cvtss2si rax, DWORD PTR [r13]
    cvttpd2dq xmm1, [rax]
    cvttpd2dq xmm1, [rax+0x7f]
    cvttpd2dq xmm1, [rax+0x80]
    cvttpd2dq xmm1, [rax+rbx*4]
    cvttpd2dq xmm1, [rbx*8+0x10]
    cvttpd2dq xmm1, [rip+0x100]
    cvttpd2dq xmm1, [0x1000]
    cvttpd2dq xmm1, [r13]
    vcvttpd2dq xmm1, [rax]
    vcvttpd2dq xmm1, [rax+0x7f]
    vcvttpd2dq xmm1, [rax+0x80]
    vcvttpd2dq xmm1, [rax+rbx*4]
    vcvttpd2dq xmm1, [rbx*8+0x10]
    vcvttpd2dq xmm1, [rip+0x100]
    vcvttpd2dq xmm1, [0x1000]
    vcvttpd2dq xmm1, [r13]
    cvttpd2pi mm0, [rax]
    cvttpd2pi mm0, [rax+0x7f]
    cvttpd2pi mm0, [rax+0x80]
    cvttpd2pi mm0, [rax+rbx*4]
    cvttpd2pi mm0, [rbx*8+0x10]
    cvttpd2pi mm0, [rip+0x100]
    cvttpd2pi mm0, [0x1000]
    cvttpd2pi mm0, [r13]
    cvttps2dq xmm1, [rax]
    cvttps2dq xmm1, [rax+0x7f]
    cvttps2dq xmm1, [rax+0x80]
    cvttps2dq xmm1, [rax+rbx*4]
    cvttps2dq xmm1, [rbx*8+0x10]
    cvttps2dq xmm1, [rip+0x100]
    cvttps2dq xmm1, [0x1000]
    cvttps2dq xmm1, [r13]
    vcvttps2dq xmm1, [rax]
    vcvttps2dq xmm1, [rax+0x7f]
    vcvttps2dq xmm1, [rax+0x80]
    vcvttps2dq xmm1, [rax+rbx*4]
    vcvttps2dq xmm1, [rbx*8+0x10]
    vcvttps2dq xmm1, [rip+0x100]
    vcvttps2dq xmm1, [0x1000]
    vcvttps2dq xmm1, [r13]
    vcvttps2dq ymm1, [rax]
    vcvttps2dq ymm1, [rax+0x7f]
    vcvttps2dq ymm1, [rax+0x80]
    vcvttps2dq ymm1, [rax+rbx*4]
    vcvttps2dq ymm1, [rbx*8+0x10]
    vcvttps2dq ymm1, [rip+0x100]
    vcvttps2dq ymm1, [0x1000]
    vcvttps2dq ymm1, [r13]
    cvttps2pi mm0, QWORD PTR [rax]
    cvttps2pi mm0, QWORD PTR [rax+0x7f]
    cvttps2pi mm0, QWORD PTR [rax+0x80]
    cvttps2pi mm0, QWORD PTR [rax+rbx*4]
    cvttps2pi mm0, QWORD PTR [rbx*8+0x10]
    cvttps2pi mm0, QWORD PTR [rip+0x100]
    cvttps2pi mm0, QWORD PTR [0x1000]
    cvttps2pi mm0, QWORD PTR [r13]
    cvttsd2si eax, QWORD PTR [rax]
    cvttsd2si eax, QWORD PTR [rax+0x7f]
    cvttsd2si eax, QWORD PTR [rax+0x80]
    cvttsd2si eax, QWORD PTR [rax+rbx*4]
    cvttsd2si eax, QWORD PTR [rbx*8+0x10]
    cvttsd2si eax, QWORD PTR [rip+0x100]
    cvttsd2si eax, QWORD PTR [0x1000]
    cvttsd2si eax, QWORD PTR [r13]
    cvttsd2si rax, QWORD PTR [rax]
    cvttsd2si rax, QWORD PTR [rax+0x7f]
    cvttsd2si rax, QWORD PTR [rax+0x80]
    cvttsd2si rax, QWORD PTR [rax+rbx*4]
    cvttsd2si rax, QWORD PTR [rbx*8+0x10]
    cvttsd2si rax, QWORD PTR [rip+0x100]
    cvttsd2si rax, QWORD PTR [0x1000]
    cvttsd2si rax, QWORD PTR [r13]
    cvttss2si eax, DWORD PTR [rax]
    cvttss2si eax, DWORD PTR [rax+0x7f]
    cvttss2si eax, DWORD PTR [rax+0x80]
    cvttss2si eax, DWORD PTR [rax+rbx*4]
    cvttss2si eax, DWORD PTR [rbx*8+0x10]
    cvttss2si eax, DWORD PTR [rip+0x100]
    cvttss2si eax, DWORD PTR [0x1000]
    cvttss2si eax, DWORD PTR [r13]
    cvttss2si rax, DWORD PTR [rax]
    cvttss2si rax, DWORD PTR [rax+0x7f]
    cvttss2si rax, DWORD PTR [rax+0x80]
    cvttss2si rax, DWORD PTR [rax+rbx*4]
    cvttss2si rax, DWORD PTR [rbx*8+0x10]
    cvttss2si rax, DWORD PTR [rip+0x100]
    cvttss2si rax, DWORD PTR [0x1000]
    cvttss2si rax, DWORD PTR [r13]
    dec BYTE PTR [rax]
    dec BYTE PTR [rax+0x7f]
    dec BYTE PTR [rax+0x80]
    dec BYTE PTR [rax+rbx*4]
    dec BYTE PTR [rbx*8+0x10]
    dec BYTE PTR [rip+0x100]
    dec BYTE PTR [0x1000]
    dec BYTE PTR [r13]
    dec WORD PTR [rax]
    dec WORD PTR [rax+0x7f]
    dec WORD PTR [rax+0x80]
    dec WORD PTR [rax+rbx*4]
    dec WORD PTR [rbx*8+0x10]
    dec WORD PTR [rip+0x100]
    dec WORD PTR [0x1000]
    dec WORD PTR [r13]
    dec DWORD PTR [rax]
    dec DWORD PTR [rax+0x7f]
    dec DWORD PTR [rax+0x80]
    dec DWORD PTR [rax+rbx*4]
    dec DWORD PTR [rbx*8+0x10]
    dec DWORD PTR [rip+0x100]
    dec DWORD PTR [0x1000]
    dec DWORD PTR [r13]
    dec QWORD PTR [rax]
    dec QWORD PTR [rax+0x7f]
    dec QWORD PTR [rax+0x80]
    dec QWORD PTR [rax+rbx*4]
    dec QWORD PTR [rbx*8+0x10]
    dec QWORD PTR [rip+0x100]
    dec QWORD PTR [0x1000]
    dec QWORD PTR [r13]
    div BYTE PTR [rax]
    div BYTE PTR [rax+0x7f]
    div BYTE PTR [rax+0x80]
    div BYTE PTR [rax+rbx*4]
    div BYTE PTR [rbx*8+0x10]
    div BYTE PTR [rip+0x100]
    div BYTE PTR [0x1000]
    div BYTE PTR [r13]
    div WORD PTR [rax]
    div WORD PTR [rax+0x7f]
    div WORD PTR [rax+0x80]
    div WORD PTR [rax+rbx*4]
    div WORD PTR [rbx*8+0x10]
    div WORD PTR [rip+0x100]
    div WORD PTR [0x1000]
    div WORD PTR [r13]
    div DWORD PTR [rax]
    div DWORD PTR [rax+0x7f]
    div DWORD PTR [rax+0x80]
    div DWORD PTR [rax+rbx*4]
    div DWORD PTR [rbx*8+0x10]
    div DWORD PTR [rip+0x100]
    div DWORD PTR [0x1000]
    div DWORD PTR [r13]
    div QWORD PTR [rax]
    div QWORD PTR [rax+0x7f]
    div QWORD PTR [rax+0x80]
    div QWORD PTR [rax+rbx*4]
    div QWORD PTR [rbx*8+0x10]
    div QWORD PTR [rip+0x100]
    div QWORD PTR [0x1000]
    div QWORD PTR [r13]
    divpd xmm1, [rax]
    divpd xmm1, [rax+0x7f]
    divpd xmm1, [rax+0x80]
    divpd xmm1, [rax+rbx*4]
    divpd xmm1, [rbx*8+0x10]
    divpd xmm1, [rip+0x100]
    divpd xmm1, [0x1000]
    divpd xmm1, [r13]
    vdivpd xmm1, xmm2, [rax]
    vdivpd xmm1, xmm2, [rax+0x7f]
    vdivpd xmm1, xmm2, [rax+0x80]
    vdivpd xmm1, xmm2, [rax+rbx*4]
    vdivpd xmm1, xmm2, [rbx*8+0x10]
    vdivpd xmm1, xmm2, [rip+0x100]
    vdivpd xmm1, xmm2, [0x1000]
    vdivpd xmm1, xmm2, [r13]
    vdivpd ymm1, ymm2, [rax]
    vdivpd ymm1, ymm2, [rax+0x7f]
    vdivpd ymm1, ymm2, [rax+0x80]
    vdivpd ymm1, ymm2, [rax+rbx*4]
    vdivpd ymm1, ymm2, [rbx*8+0x10]
    vdivpd ymm1, ymm2, [rip+0x100]
    vdivpd ymm1, ymm2, [0x1000]
    vdivpd ymm1, ymm2, [r13]
    divps xmm1, [rax]
    divps xmm1, [rax+0x7f]
    divps xmm1, [rax+0x80]
    divps xmm1, [rax+rbx*4]
    divps xmm1, [rbx*8+0x10]
    divps xmm1, [rip+0x100]
    divps xmm1, [0x1000]
    divps xmm1, [r13]
    vdivps xmm1, xmm2, [rax]
    vdivps xmm1, xmm2, [rax+0x7f]
    vdivps xmm1, xmm2, [rax+0x80]
    vdivps xmm1, xmm2, [rax+rbx*4]
    vdivps xmm1, xmm2, [rbx*8+0x10]
    vdivps xmm1, xmm2, [rip+0x100]
    vdivps xmm1, xmm2, [0x1000]
    vdivps xmm1, xmm2, [r13]
    vdivps ymm1, ymm2, [rax]
    vdivps ymm1, ymm2, [rax+0x7f]
    vdivps ymm1, ymm2, [rax+0x80]
    vdivps ymm1, ymm2, [rax+rbx*4]
    vdivps ymm1, ymm2, [rbx*8+0x10]
    vdivps ymm1, ymm2, [rip+0x100]
    vdivps ymm1, ymm2, [0x1000]
    vdivps ymm1, ymm2, [r13]
    divsd xmm1, QWORD PTR [rax]
    divsd xmm1, QWORD PTR [rax+0x7f]
    divsd xmm1, QWORD PTR [rax+0x80]
    divsd xmm1, QWORD PTR [rax+rbx*4]
    divsd xmm1, QWORD PTR [rbx*8+0x10]
    divsd xmm1, QWORD PTR [rip+0x100]
    divsd xmm1, QWORD PTR [0x1000]
    divsd xmm1, QWORD PTR [r13]
    vdivsd xmm1, xmm2, QWORD PTR [rax]
    vdivsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vdivsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vdivsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vdivsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vdivsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vdivsd xmm1, xmm2, QWORD PTR [0x1000]
    vdivsd xmm1, xmm2, QWORD PTR [r13]
    divss xmm1, DWORD PTR [rax]
    divss xmm1, DWORD PTR [rax+0x7f]
    divss xmm1, DWORD PTR [rax+0x80]
    divss xmm1, DWORD PTR [rax+rbx*4]
    divss xmm1, DWORD PTR [rbx*8+0x10]
    divss xmm1, DWORD PTR [rip+0x100]
    divss xmm1, DWORD PTR [0x1000]
    divss xmm1, DWORD PTR [r13]
    vdivss xmm1, xmm2, DWORD PTR [rax]
    vdivss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vdivss xmm1, xmm2, DWORD PTR [rax+0x80]
    vdivss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vdivss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vdivss xmm1, xmm2, DWORD PTR [rip+0x100]
    vdivss xmm1, xmm2, DWORD PTR [0x1000]
    vdivss xmm1, xmm2, DWORD PTR [r13]
    dppd xmm1, [rax], 0x1
    dppd xmm1, [rax+0x7f], 0x1
    dppd xmm1, [rax+0x80], 0x1
    dppd xmm1, [rax+rbx*4], 0x1
    dppd xmm1, [rbx*8+0x10], 0x1
    dppd xmm1, [rip+0x100], 0x1
    dppd xmm1, [0x1000], 0x1
    dppd xmm1, [r13], 0x1
    vdppd xmm1, xmm2, [rax], 0x1
    vdppd xmm1, xmm2, [rax+0x7f], 0x1
    vdppd xmm1, xmm2, [rax+0x80], 0x1
    vdppd xmm1, xmm2, [rax+rbx*4], 0x1
    vdppd xmm1, xmm2, [rbx*8+0x10], 0x1
    vdppd xmm1, xmm2, [rip+0x100], 0x1
    vdppd xmm1, xmm2, [0x1000], 0x1
    vdppd xmm1, xmm2, [r13], 0x1
    dpps xmm1, [rax], 0x1
    dpps xmm1, [rax+0x7f], 0x1
    dpps xmm1, [rax+0x80], 0x1
    dpps xmm1, [rax+rbx*4], 0x1
    dpps xmm1, [rbx*8+0x10], 0x1
    dpps xmm1, [rip+0x100], 0x1
    dpps xmm1, [0x1000], 0x1
    dpps xmm1, [r13], 0x1
    vdpps xmm1, xmm2, [rax], 0x1
    vdpps xmm1, xmm2, [rax+0x7f], 0x1
    vdpps xmm1, xmm2, [rax+0x80], 0x1
    vdpps xmm1, xmm2, [rax+rbx*4], 0x1
    vdpps xmm1, xmm2, [rbx*8+0x10], 0x1
    vdpps xmm1, xmm2, [rip+0x100], 0x1
    vdpps xmm1, xmm2, [0x1000], 0x1
    vdpps xmm1, xmm2, [r13], 0x1
    vdpps ymm1, ymm2, [rax], 0x1
    vdpps ymm1, ymm2, [rax+0x7f], 0x1
    vdpps ymm1, ymm2, [rax+0x80], 0x1
    vdpps ymm1, ymm2, [rax+rbx*4], 0x1
    vdpps ymm1, ymm2, [rbx*8+0x10], 0x1
    vdpps ymm1, ymm2, [rip+0x100], 0x1
    vdpps ymm1, ymm2, [0x1000], 0x1
    vdpps ymm1, ymm2, [r13], 0x1
    enqcmd rax, [rax]
    enqcmd rax, [rax+0x7f]
    enqcmd rax, [rax+0x80]
    enqcmd rax, [rax+rbx*4]
    enqcmd rax, [rbx*8+0x10]
    enqcmd rax, [rip+0x100]
    enqcmd rax, [0x1000]
    enqcmd rax, [r13]
    enqcmds rax, [rax]
    enqcmds rax, [rax+0x7f]
    enqcmds rax, [rax+0x80]
    enqcmds rax, [rax+rbx*4]
    enqcmds rax, [rbx*8+0x10]
    enqcmds rax, [rip+0x100]
    enqcmds rax, [0x1000]
    enqcmds rax, [r13]
    extractps DWORD PTR [rax], xmm1, 0x1
    extractps DWORD PTR [rax+0x7f], xmm1, 0x1
    extractps DWORD PTR [rax+0x80], xmm1, 0x1
    extractps DWORD PTR [rax+rbx*4], xmm1, 0x1
    extractps DWORD PTR [rbx*8+0x10], xmm1, 0x1
    extractps DWORD PTR [rip+0x100], xmm1, 0x1
    extractps DWORD PTR [0x1000], xmm1, 0x1
    extractps DWORD PTR [r13], xmm1, 0x1
    vextractps DWORD PTR [rax], xmm1, 0x1
    vextractps DWORD PTR [rax+0x7f], xmm1, 0x1
    vextractps DWORD PTR [rax+0x80], xmm1, 0x1
    vextractps DWORD PTR [rax+rbx*4], xmm1, 0x1
    vextractps DWORD PTR [rbx*8+0x10], xmm1, 0x1
    vextractps DWORD PTR [rip+0x100], xmm1, 0x1
    vextractps DWORD PTR [0x1000], xmm1, 0x1
    vextractps DWORD PTR [r13], xmm1, 0x1
    fadd DWORD PTR [rax]
    fadd DWORD PTR [rax+0x7f]
    fadd DWORD PTR [rax+0x80]
    fadd DWORD PTR [rax+rbx*4]
    fadd DWORD PTR [rbx*8+0x10]
    fadd DWORD PTR [rip+0x100]
    fadd DWORD PTR [0x1000]
    fadd DWORD PTR [r13]
    fadd QWORD PTR [rax]
    fadd QWORD PTR [rax+0x7f]
    fadd QWORD PTR [rax+0x80]
    fadd QWORD PTR [rax+rbx*4]
    fadd QWORD PTR [rbx*8+0x10]
    fadd QWORD PTR [rip+0x100]
    fadd QWORD PTR [0x1000]
    fadd QWORD PTR [r13]
    fiadd DWORD PTR [rax]
    fiadd DWORD PTR [rax+0x7f]
    fiadd DWORD PTR [rax+0x80]
    fiadd DWORD PTR [rax+rbx*4]
    fiadd DWORD PTR [rbx*8+0x10]
    fiadd DWORD PTR [rip+0x100]
    fiadd DWORD PTR [0x1000]
    fiadd DWORD PTR [r13]
    fiadd WORD PTR [rax]
    fiadd WORD PTR [rax+0x7f]
    fiadd WORD PTR [rax+0x80]
    fiadd WORD PTR [rax+rbx*4]
    fiadd WORD PTR [rbx*8+0x10]
    fiadd WORD PTR [rip+0x100]
    fiadd WORD PTR [0x1000]
    fiadd WORD PTR [r13]
    fbld TBYTE PTR [rax]
    fbld TBYTE PTR [rax+0x7f]
    fbld TBYTE PTR [rax+0x80]
    fbld TBYTE PTR [rax+rbx*4]
    fbld TBYTE PTR [rbx*8+0x10]
    fbld TBYTE PTR [rip+0x100]
    fbld TBYTE PTR [0x1000]
    fbld TBYTE PTR [r13]
    fbstp TBYTE PTR [rax]
    fbstp TBYTE PTR [rax+0x7f]
    fbstp TBYTE PTR [rax+0x80]
    fbstp TBYTE PTR [rax+rbx*4]
    fbstp TBYTE PTR [rbx*8+0x10]
    fbstp TBYTE PTR [rip+0x100]
    fbstp TBYTE PTR [0x1000]
    fbstp TBYTE PTR [r13]
    fcom DWORD PTR [rax]
    fcom DWORD PTR [rax+0x7f]
    fcom DWORD PTR [rax+0x80]
    fcom DWORD PTR [rax+rbx*4]
    fcom DWORD PTR [rbx*8+0x10]
    fcom DWORD PTR [rip+0x100]
    fcom DWORD PTR [0x1000]
    fcom DWORD PTR [r13]
    fcom QWORD PTR [rax]
    fcom QWORD PTR [rax+0x7f]
    fcom QWORD PTR [rax+0x80]
    fcom QWORD PTR [rax+rbx*4]
    fcom QWORD PTR [rbx*8+0x10]
    fcom QWORD PTR [rip+0x100]
    fcom QWORD PTR [0x1000]
    fcom QWORD PTR [r13]
    fcomp DWORD PTR [rax]
    fcomp DWORD PTR [rax+0x7f]
    fcomp DWORD PTR [rax+0x80]
    fcomp DWORD PTR [rax+rbx*4]
    fcomp DWORD PTR [rbx*8+0x10]
    fcomp DWORD PTR [rip+0x100]
    fcomp DWORD PTR [0x1000]
    fcomp DWORD PTR [r13]
    fcomp QWORD PTR [rax]
    fcomp QWORD PTR [rax+0x7f]
    fcomp QWORD PTR [rax+0x80]
    fcomp QWORD PTR [rax+rbx*4]
    fcomp QWORD PTR [rbx*8+0x10]
    fcomp QWORD PTR [rip+0x100]
    fcomp QWORD PTR [0x1000]
    fcomp QWORD PTR [r13]
    fdiv DWORD PTR [rax]
    fdiv DWORD PTR [rax+0x7f]
    fdiv DWORD PTR [rax+0x80]
    fdiv DWORD PTR [rax+rbx*4]
    fdiv DWORD PTR [rbx*8+0x10]
    fdiv DWORD PTR [rip+0x100]
    fdiv DWORD PTR [0x1000]
    fdiv DWORD PTR [r13]
    fdiv QWORD PTR [rax]
    fdiv QWORD PTR [rax+0x7f]
    fdiv QWORD PTR [rax+0x80]
    fdiv QWORD PTR [rax+rbx*4]
    fdiv QWORD PTR [rbx*8+0x10]
    fdiv QWORD PTR [rip+0x100]
    fdiv QWORD PTR [0x1000]
    fdiv QWORD PTR [r13]
    fidiv DWORD PTR [rax]
    fidiv DWORD PTR [rax+0x7f]
    fidiv DWORD PTR [rax+0x80]
    fidiv DWORD PTR [rax+rbx*4]
    fidiv DWORD PTR [rbx*8+0x10]
    fidiv DWORD PTR [rip+0x100]
    fidiv DWORD PTR [0x1000]
    fidiv DWORD PTR [r13]
    fidiv WORD PTR [rax]
    fidiv WORD PTR [rax+0x7f]
    fidiv WORD PTR [rax+0x80]
    fidiv WORD PTR [rax+rbx*4]
    fidiv WORD PTR [rbx*8+0x10]
    fidiv WORD PTR [rip+0x100]
    fidiv WORD PTR [0x1000]
    fidiv WORD PTR [r13]
    fdivr DWORD PTR [rax]
    fdivr DWORD PTR [rax+0x7f]
    fdivr DWORD PTR [rax+0x80]
    fdivr DWORD PTR [rax+rbx*4]
    fdivr DWORD PTR [rbx*8+0x10]
    fdivr DWORD PTR [rip+0x100]
    fdivr DWORD PTR [0x1000]
    fdivr DWORD PTR [r13]
    fdivr QWORD PTR [rax]
    fdivr QWORD PTR [rax+0x7f]
    fdivr QWORD PTR [rax+0x80]
    fdivr QWORD PTR [rax+rbx*4]
    fdivr QWORD PTR [rbx*8+0x10]
    fdivr QWORD PTR [rip+0x100]
    fdivr QWORD PTR [0x1000]
    fdivr QWORD PTR [r13]
    fidivr DWORD PTR [rax]
    fidivr DWORD PTR [rax+0x7f]
    fidivr DWORD PTR [rax+0x80]
    fidivr DWORD PTR [rax+rbx*4]
    fidivr DWORD PTR [rbx*8+0x10]
    fidivr DWORD PTR [rip+0x100]
    fidivr DWORD PTR [0x1000]
    fidivr DWORD PTR [r13]
    fidivr WORD PTR [rax]
    fidivr WORD PTR [rax+0x7f]
    fidivr WORD PTR [rax+0x80]
    fidivr WORD PTR [rax+rbx*4]
    fidivr WORD PTR [rbx*8+0x10]
    fidivr WORD PTR [rip+0x100]
    fidivr WORD PTR [0x1000]
    fidivr WORD PTR [r13]
    ficom WORD PTR [rax]
    ficom WORD PTR [rax+0x7f]
    ficom WORD PTR [rax+0x80]
    ficom WORD PTR [rax+rbx*4]
    ficom WORD PTR [rbx*8+0x10]
    ficom WORD PTR [rip+0x100]
    ficom WORD PTR [0x1000]
    ficom WORD PTR [r13]
    ficom DWORD PTR [rax]
    ficom DWORD PTR [rax+0x7f]
    ficom DWORD PTR [rax+0x80]
    ficom DWORD PTR [rax+rbx*4]
    ficom DWORD PTR [rbx*8+0x10]
    ficom DWORD PTR [rip+0x100]
    ficom DWORD PTR [0x1000]
    ficom DWORD PTR [r13]
    ficomp WORD PTR [rax]
    ficomp WORD PTR [rax+0x7f]
    ficomp WORD PTR [rax+0x80]
    ficomp WORD PTR [rax+rbx*4]
    ficomp WORD PTR [rbx*8+0x10]
    ficomp WORD PTR [rip+0x100]
    ficomp WORD PTR [0x1000]
    ficomp WORD PTR [r13]
    ficomp DWORD PTR [rax]
    ficomp DWORD PTR [rax+0x7f]
    ficomp DWORD PTR [rax+0x80]
    ficomp DWORD PTR [rax+rbx*4]
    ficomp DWORD PTR [rbx*8+0x10]
    ficomp DWORD PTR [rip+0x100]
    ficomp DWORD PTR [0x1000]
    ficomp DWORD PTR [r13]
    fild WORD PTR [rax]
    fild WORD PTR [rax+0x7f]
    fild WORD PTR [rax+0x80]
    fild WORD PTR [rax+rbx*4]
    fild WORD PTR [rbx*8+0x10]
    fild WORD PTR [rip+0x100]
    fild WORD PTR [0x1000]
    fild WORD PTR [r13]
    fild DWORD PTR [rax]
    fild DWORD PTR [rax+0x7f]
    fild DWORD PTR [rax+0x80]
    fild DWORD PTR [rax+rbx*4]
    fild DWORD PTR [rbx*8+0x10]
    fild DWORD PTR [rip+0x100]
    fild DWORD PTR [0x1000]
    fild DWORD PTR [r13]
    fild QWORD PTR [rax]
    fild QWORD PTR [rax+0x7f]
    fild QWORD PTR [rax+0x80]
    fild QWORD PTR [rax+rbx*4]
    fild QWORD PTR [rbx*8+0x10]
    fild QWORD PTR [rip+0x100]
    fild QWORD PTR [0x1000]
    fild QWORD PTR [r13]
    fist WORD PTR [rax]
    fist WORD PTR [rax+0x7f]
    fist WORD PTR [rax+0x80]
    fist WORD PTR [rax+rbx*4]
    fist WORD PTR [rbx*8+0x10]
    fist WORD PTR [rip+0x100]
    fist WORD PTR [0x1000]
    fist WORD PTR [r13]
    fist DWORD PTR [rax]
    fist DWORD PTR [rax+0x7f]
    fist DWORD PTR [rax+0x80]
    fist DWORD PTR [rax+rbx*4]
    fist DWORD PTR [rbx*8+0x10]
    fist DWORD PTR [rip+0x100]
    fist DWORD PTR [0x1000]
    fist DWORD PTR [r13]
    fistp WORD PTR [rax]
    fistp WORD PTR [rax+0x7f]
    fistp WORD PTR [rax+0x80]
    fistp WORD PTR [rax+rbx*4]
    fistp WORD PTR [rbx*8+0x10]
    fistp WORD PTR [rip+0x100]
    fistp WORD PTR [0x1000]
    fistp WORD PTR [r13]
    fistp DWORD PTR [rax]
    fistp DWORD PTR [rax+0x7f]
    fistp DWORD PTR [rax+0x80]
    fistp DWORD PTR [rax+rbx*4]
    fistp DWORD PTR [rbx*8+0x10]
    fistp DWORD PTR [rip+0x100]
    fistp DWORD PTR [0x1000]
    fistp DWORD PTR [r13]
    fistp QWORD PTR [rax]
    fistp QWORD PTR [rax+0x7f]
    fistp QWORD PTR [rax+0x80]
    fistp QWORD PTR [rax+rbx*4]
    fistp QWORD PTR [rbx*8+0x10]
    fistp QWORD PTR [rip+0x100]
    fistp QWORD PTR [0x1000]
    fistp QWORD PTR [r13]
    fisttp WORD PTR [rax]
    fisttp WORD PTR [rax+0x7f]
    fisttp WORD PTR [rax+0x80]
    fisttp WORD PTR [rax+rbx*4]
    fisttp WORD PTR [rbx*8+0x10]
    fisttp WORD PTR [rip+0x100]
    fisttp WORD PTR [0x1000]
    fisttp WORD PTR [r13]
    fisttp DWORD PTR [rax]
    fisttp DWORD PTR [rax+0x7f]
    fisttp DWORD PTR [rax+0x80]
    fisttp DWORD PTR [rax+rbx*4]
    fisttp DWORD PTR [rbx*8+0x10]
    fisttp DWORD PTR [rip+0x100]
    fisttp DWORD PTR [0x1000]
    fisttp DWORD PTR [r13]
    fisttp QWORD PTR [rax]
    fisttp QWORD PTR [rax+0x7f]
    fisttp QWORD PTR [rax+0x80]
    fisttp QWORD PTR [rax+rbx*4]
    fisttp QWORD PTR [rbx*8+0x10]
    fisttp QWORD PTR [rip+0x100]
    fisttp QWORD PTR [0x1000]
    fisttp QWORD PTR [r13]
    fld DWORD PTR [rax]
    fld DWORD PTR [rax+0x7f]
    fld DWORD PTR [rax+0x80]
    fld DWORD PTR [rax+rbx*4]
    fld DWORD PTR [rbx*8+0x10]
    fld DWORD PTR [rip+0x100]
    fld DWORD PTR [0x1000]
    fld DWORD PTR [r13]
    fld QWORD PTR [rax]
    fld QWORD PTR [rax+0x7f]
    fld QWORD PTR [rax+0x80]
    fld QWORD PTR [rax+rbx*4]
    fld QWORD PTR [rbx*8+0x10]
    fld QWORD PTR [rip+0x100]
    fld QWORD PTR [0x1000]
    fld QWORD PTR [r13]
    fld TBYTE PTR [rax]
    fld TBYTE PTR [rax+0x7f]
    fld TBYTE PTR [rax+0x80]
    fld TBYTE PTR [rax+rbx*4]
    fld TBYTE PTR [rbx*8+0x10]
    fld TBYTE PTR [rip+0x100]
    fld TBYTE PTR [0x1000]
    fld TBYTE PTR [r13]
    fldcw [rax]
    fldcw [rax+0x7f]
    fldcw [rax+0x80]
    fldcw [rax+rbx*4]
    fldcw [rbx*8+0x10]
    fldcw [rip+0x100]
    fldcw [0x1000]
    fldcw [r13]
    fmul DWORD PTR [rax]
    fmul DWORD PTR [rax+0x7f]
    fmul DWORD PTR [rax+0x80]
    fmul DWORD PTR [rax+rbx*4]
    fmul DWORD PTR [rbx*8+0x10]
    fmul DWORD PTR [rip+0x100]
    fmul DWORD PTR [0x1000]
    fmul DWORD PTR [r13]
    fmul QWORD PTR [rax]
    fmul QWORD PTR [rax+0x7f]
    fmul QWORD PTR [rax+0x80]
    fmul QWORD PTR [rax+rbx*4]
    fmul QWORD PTR [rbx*8+0x10]
    fmul QWORD PTR [rip+0x100]
    fmul QWORD PTR [0x1000]
    fmul QWORD PTR [r13]
    fimul DWORD PTR [rax]
    fimul DWORD PTR [rax+0x7f]
    fimul DWORD PTR [rax+0x80]
    fimul DWORD PTR [rax+rbx*4]
    fimul DWORD PTR [rbx*8+0x10]
    fimul DWORD PTR [rip+0x100]
    fimul DWORD PTR [0x1000]
    fimul DWORD PTR [r13]
    fimul WORD PTR [rax]
    fimul WORD PTR [rax+0x7f]
    fimul WORD PTR [rax+0x80]
    fimul WORD PTR [rax+rbx*4]
    fimul WORD PTR [rbx*8+0x10]
    fimul WORD PTR [rip+0x100]
    fimul WORD PTR [0x1000]
    fimul WORD PTR [r13]
    fst DWORD PTR [rax]
    fst DWORD PTR [rax+0x7f]
    fst DWORD PTR [rax+0x80]
    fst DWORD PTR [rax+rbx*4]
    fst DWORD PTR [rbx*8+0x10]
    fst DWORD PTR [rip+0x100]
    fst DWORD PTR [0x1000]
    fst DWORD PTR [r13]
    fst QWORD PTR [rax]
    fst QWORD PTR [rax+0x7f]
    fst QWORD PTR [rax+0x80]
    fst QWORD PTR [rax+rbx*4]
    fst QWORD PTR [rbx*8+0x10]
    fst QWORD PTR [rip+0x100]
    fst QWORD PTR [0x1000]
    fst QWORD PTR [r13]
    fstp DWORD PTR [rax]
    fstp DWORD PTR [rax+0x7f]
    fstp DWORD PTR [rax+0x80]
    fstp DWORD PTR [rax+rbx*4]
    fstp DWORD PTR [rbx*8+0x10]
    fstp DWORD PTR [rip+0x100]
    fstp DWORD PTR [0x1000]
    fstp DWORD PTR [r13]
    fstp QWORD PTR [rax]
    fstp QWORD PTR [rax+0x7f]
    fstp QWORD PTR [rax+0x80]
    fstp QWORD PTR [rax+rbx*4]
    fstp QWORD PTR [rbx*8+0x10]
    fstp QWORD PTR [rip+0x100]
    fstp QWORD PTR [0x1000]
    fstp QWORD PTR [r13]
    fstp TBYTE PTR [rax]
    fstp TBYTE PTR [rax+0x7f]
    fstp TBYTE PTR [rax+0x80]
    fstp TBYTE PTR [rax+rbx*4]
    fstp TBYTE PTR [rbx*8+0x10]
    fstp TBYTE PTR [rip+0x100]
    fstp TBYTE PTR [0x1000]
    fstp TBYTE PTR [r13]
    fstcw [rax]
    fstcw [rax+0x7f]
    fstcw [rax+0x80]
    fstcw [rax+rbx*4]
    fstcw [rbx*8+0x10]
    fstcw [rip+0x100]
    fstcw [0x1000]
    fstcw [r13]
    fnstcw [rax]
    fnstcw [rax+0x7f]
    fnstcw [rax+0x80]
    fnstcw [rax+rbx*4]
    fnstcw [rbx*8+0x10]
    fnstcw [rip+0x100]
    fnstcw [0x1000]
    fnstcw [r13]
    fstsw [rax]
    fstsw [rax+0x7f]
    fstsw [rax+0x80]
    fstsw [rax+rbx*4]
    fstsw [rbx*8+0x10]
    fstsw [rip+0x100]
    fstsw [0x1000]
    fstsw [r13]
    fnstsw [rax]
    fnstsw [rax+0x7f]
    fnstsw [rax+0x80]
    fnstsw [rax+rbx*4]
    fnstsw [rbx*8+0x10]
    fnstsw [rip+0x100]
    fnstsw [0x1000]
    fnstsw [r13]
    fsub DWORD PTR [rax]
    fsub DWORD PTR [rax+0x7f]
    fsub DWORD PTR [rax+0x80]
    fsub DWORD PTR [rax+rbx*4]
    fsub DWORD PTR [rbx*8+0x10]
    fsub DWORD PTR [rip+0x100]
    fsub DWORD PTR [0x1000]
    fsub DWORD PTR [r13]
    fsub QWORD PTR [rax]
    fsub QWORD PTR [rax+0x7f]
    fsub QWORD PTR [rax+0x80]
    fsub QWORD PTR [rax+rbx*4]
    fsub QWORD PTR [rbx*8+0x10]
    fsub QWORD PTR [rip+0x100]
    fsub QWORD PTR [0x1000]
    fsub QWORD PTR [r13]
    fisub DWORD PTR [rax]
    fisub DWORD PTR [rax+0x7f]
    fisub DWORD PTR [rax+0x80]
    fisub DWORD PTR [rax+rbx*4]
    fisub DWORD PTR [rbx*8+0x10]
    fisub DWORD PTR [rip+0x100]
    fisub DWORD PTR [0x1000]
    fisub DWORD PTR [r13]
    fisub WORD PTR [rax]
    fisub WORD PTR [rax+0x7f]
    fisub WORD PTR [rax+0x80]
    fisub WORD PTR [rax+rbx*4]
    fisub WORD PTR [rbx*8+0x10]
    fisub WORD PTR [rip+0x100]
    fisub WORD PTR [0x1000]
    fisub WORD PTR [r13]
    fsubr DWORD PTR [rax]
    fsubr DWORD PTR [rax+0x7f]
    fsubr DWORD PTR [rax+0x80]
    fsubr DWORD PTR [rax+rbx*4]
    fsubr DWORD PTR [rbx*8+0x10]
    fsubr DWORD PTR [rip+0x100]
    fsubr DWORD PTR [0x1000]
    fsubr DWORD PTR [r13]
    fsubr QWORD PTR [rax]
    fsubr QWORD PTR [rax+0x7f]
    fsubr QWORD PTR [rax+0x80]
    fsubr QWORD PTR [rax+rbx*4]
    fsubr QWORD PTR [rbx*8+0x10]
    fsubr QWORD PTR [rip+0x100]
    fsubr QWORD PTR [0x1000]
    fsubr QWORD PTR [r13]
    fisubr DWORD PTR [rax]
    fisubr DWORD PTR [rax+0x7f]
    fisubr DWORD PTR [rax+0x80]
    fisubr DWORD PTR [rax+rbx*4]
    fisubr DWORD PTR [rbx*8+0x10]
    fisubr DWORD PTR [rip+0x100]
    fisubr DWORD PTR [0x1000]
    fisubr DWORD PTR [r13]
    fisubr WORD PTR [rax]
    fisubr WORD PTR [rax+0x7f]
    fisubr WORD PTR [rax+0x80]
    fisubr WORD PTR [rax+rbx*4]
    fisubr WORD PTR [rbx*8+0x10]
    fisubr WORD PTR [rip+0x100]
    fisubr WORD PTR [0x1000]
    fisubr WORD PTR [r13]
    fxrstor [rax]
    fxrstor [rax+0x7f]
    fxrstor [rax+0x80]
    fxrstor [rax+rbx*4]
    fxrstor [rbx*8+0x10]
    fxrstor [rip+0x100]
    fxrstor [0x1000]
    fxrstor [r13]
    fxrstor64 [rax]
    fxrstor64 [rax+0x7f]
    fxrstor64 [rax+0x80]
    fxrstor64 [rax+rbx*4]
    fxrstor64 [rbx*8+0x10]
    fxrstor64 [rip+0x100]
    fxrstor64 [0x1000]
    fxrstor64 [r13]
    fxsave [rax]
    fxsave [rax+0x7f]
    fxsave [rax+0x80]
    fxsave [rax+rbx*4]
    fxsave [rbx*8+0x10]
    fxsave [rip+0x100]
    fxsave [0x1000]
    fxsave [r13]
    fxsave64 [rax]
    fxsave64 [rax+0x7f]
    fxsave64 [rax+0x80]
    fxsave64 [rax+rbx*4]
    fxsave64 [rbx*8+0x10]
    fxsave64 [rip+0x100]
    fxsave64 [0x1000]
    fxsave64 [r13]
    gf2p8affineinvqb xmm1, [rax], 0x1
    gf2p8affineinvqb xmm1, [rax+0x7f], 0x1
    gf2p8affineinvqb xmm1, [rax+0x80], 0x1
    gf2p8affineinvqb xmm1, [rax+rbx*4], 0x1
    gf2p8affineinvqb xmm1, [rbx*8+0x10], 0x1
    gf2p8affineinvqb xmm1, [rip+0x100], 0x1
    gf2p8affineinvqb xmm1, [0x1000], 0x1
    gf2p8affineinvqb xmm1, [r13], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [rax], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [rax+0x7f], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [rax+0x80], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [rax+rbx*4], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [rbx*8+0x10], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [rip+0x100], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [0x1000], 0x1
    vgf2p8affineinvqb xmm1, xmm2, [r13], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [rax], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [rax+0x7f], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [rax+0x80], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [rax+rbx*4], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [rbx*8+0x10], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [rip+0x100], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [0x1000], 0x1
    vgf2p8affineinvqb ymm1, ymm2, [r13], 0x1
    gf2p8affineqb xmm1, [rax], 0x1
    gf2p8affineqb xmm1, [rax+0x7f], 0x1
    gf2p8affineqb xmm1, [rax+0x80], 0x1
    gf2p8affineqb xmm1, [rax+rbx*4], 0x1
    gf2p8affineqb xmm1, [rbx*8+0x10], 0x1
    gf2p8affineqb xmm1, [rip+0x100], 0x1
    gf2p8affineqb xmm1, [0x1000], 0x1
    gf2p8affineqb xmm1, [r13], 0x1
    vgf2p8affineqb xmm1, xmm2, [rax], 0x1
    vgf2p8affineqb xmm1, xmm2, [rax+0x7f], 0x1
    vgf2p8affineqb xmm1, xmm2, [rax+0x80], 0x1
    vgf2p8affineqb xmm1, xmm2, [rax+rbx*4], 0x1
    vgf2p8affineqb xmm1, xmm2, [rbx*8+0x10], 0x1
    vgf2p8affineqb xmm1, xmm2, [rip+0x100], 0x1
    vgf2p8affineqb xmm1, xmm2, [0x1000], 0x1
    vgf2p8affineqb xmm1, xmm2, [r13], 0x1
    vgf2p8affineqb ymm1, ymm2, [rax], 0x1
    vgf2p8affineqb ymm1, ymm2, [rax+0x7f], 0x1
    vgf2p8affineqb ymm1, ymm2, [rax+0x80], 0x1
    vgf2p8affineqb ymm1, ymm2, [rax+rbx*4], 0x1
    vgf2p8affineqb ymm1, ymm2, [rbx*8+0x10], 0x1
    vgf2p8affineqb ymm1, ymm2, [rip+0x100], 0x1
    vgf2p8affineqb ymm1, ymm2, [0x1000], 0x1
    vgf2p8affineqb ymm1, ymm2, [r13], 0x1
    gf2p8mulb xmm1, [rax]
    gf2p8mulb xmm1, [rax+0x7f]
    gf2p8mulb xmm1, [rax+0x80]
    gf2p8mulb xmm1, [rax+rbx*4]
    gf2p8mulb xmm1, [rbx*8+0x10]
    gf2p8mulb xmm1, [rip+0x100]
    gf2p8mulb xmm1, [0x1000]
    gf2p8mulb xmm1, [r13]
    vgf2p8mulb xmm1, xmm2, [rax]
    vgf2p8mulb xmm1, xmm2, [rax+0x7f]
    vgf2p8mulb xmm1, xmm2, [rax+0x80]
    vgf2p8mulb xmm1, xmm2, [rax+rbx*4]
    vgf2p8mulb xmm1, xmm2, [rbx*8+0x10]
    vgf2p8mulb xmm1, xmm2, [rip+0x100]
    vgf2p8mulb xmm1, xmm2, [0x1000]
    vgf2p8mulb xmm1, xmm2, [r13]
    vgf2p8mulb ymm1, ymm2, [rax]
    vgf2p8mulb ymm1, ymm2, [rax+0x7f]
    vgf2p8mulb ymm1, ymm2, [rax+0x80]
    vgf2p8mulb ymm1, ymm2, [rax+rbx*4]
    vgf2p8mulb ymm1, ymm2, [rbx*8+0x10]
    vgf2p8mulb ymm1, ymm2, [rip+0x100]
    vgf2p8mulb ymm1, ymm2, [0x1000]
    vgf2p8mulb ymm1, ymm2, [r13]
    haddpd xmm1, [rax]
    haddpd xmm1, [rax+0x7f]
    haddpd xmm1, [rax+0x80]
    haddpd xmm1, [rax+rbx*4]
    haddpd xmm1, [rbx*8+0x10]
    haddpd xmm1, [rip+0x100]
    haddpd xmm1, [0x1000]
    haddpd xmm1, [r13]
    vhaddpd xmm1, xmm2, [rax]
    vhaddpd xmm1, xmm2, [rax+0x7f]
    vhaddpd xmm1, xmm2, [rax+0x80]
    vhaddpd xmm1, xmm2, [rax+rbx*4]
    vhaddpd xmm1, xmm2, [rbx*8+0x10]
    vhaddpd xmm1, xmm2, [rip+0x100]
    vhaddpd xmm1, xmm2, [0x1000]
    vhaddpd xmm1, xmm2, [r13]
    vhaddpd ymm1, ymm2, [rax]
    vhaddpd ymm1, ymm2, [rax+0x7f]
    vhaddpd ymm1, ymm2, [rax+0x80]
    vhaddpd ymm1, ymm2, [rax+rbx*4]
    vhaddpd ymm1, ymm2, [rbx*8+0x10]
    vhaddpd ymm1, ymm2, [rip+0x100]
    vhaddpd ymm1, ymm2, [0x1000]
    vhaddpd ymm1, ymm2, [r13]
    haddps xmm1, [rax]
    haddps xmm1, [rax+0x7f]
    haddps xmm1, [rax+0x80]
    haddps xmm1, [rax+rbx*4]
    haddps xmm1, [rbx*8+0x10]
    haddps xmm1, [rip+0x100]
    haddps xmm1, [0x1000]
    haddps xmm1, [r13]
    vhaddps xmm1, xmm2, [rax]
    vhaddps xmm1, xmm2, [rax+0x7f]
    vhaddps xmm1, xmm2, [rax+0x80]
    vhaddps xmm1, xmm2, [rax+rbx*4]
    vhaddps xmm1, xmm2, [rbx*8+0x10]
    vhaddps xmm1, xmm2, [rip+0x100]
    vhaddps xmm1, xmm2, [0x1000]
    vhaddps xmm1, xmm2, [r13]
    vhaddps ymm1, ymm2, [rax]
    vhaddps ymm1, ymm2, [rax+0x7f]
    vhaddps ymm1, ymm2, [rax+0x80]
    vhaddps ymm1, ymm2, [rax+rbx*4]
    vhaddps ymm1, ymm2, [rbx*8+0x10]
    vhaddps ymm1, ymm2, [rip+0x100]
    vhaddps ymm1, ymm2, [0x1000]
    vhaddps ymm1, ymm2, [r13]
    hsubpd xmm1, [rax]
    hsubpd xmm1, [rax+0x7f]
    hsubpd xmm1, [rax+0x80]
    hsubpd xmm1, [rax+rbx*4]
    hsubpd xmm1, [rbx*8+0x10]
    hsubpd xmm1, [rip+0x100]
    hsubpd xmm1, [0x1000]
    hsubpd xmm1, [r13]
    vhsubpd xmm1, xmm2, [rax]
    vhsubpd xmm1, xmm2, [rax+0x7f]
    vhsubpd xmm1, xmm2, [rax+0x80]
    vhsubpd xmm1, xmm2, [rax+rbx*4]
    vhsubpd xmm1, xmm2, [rbx*8+0x10]
    vhsubpd xmm1, xmm2, [rip+0x100]
    vhsubpd xmm1, xmm2, [0x1000]
    vhsubpd xmm1, xmm2, [r13]
    vhsubpd ymm1, ymm2, [rax]
    vhsubpd ymm1, ymm2, [rax+0x7f]
    vhsubpd ymm1, ymm2, [rax+0x80]
    vhsubpd ymm1, ymm2, [rax+rbx*4]
    vhsubpd ymm1, ymm2, [rbx*8+0x10]
    vhsubpd ymm1, ymm2, [rip+0x100]
    vhsubpd ymm1, ymm2, [0x1000]
    vhsubpd ymm1, ymm2, [r13]
    hsubps xmm1, [rax]
    hsubps xmm1, [rax+0x7f]
    hsubps xmm1, [rax+0x80]
    hsubps xmm1, [rax+rbx*4]
    hsubps xmm1, [rbx*8+0x10]
    hsubps xmm1, [rip+0x100]
    hsubps xmm1, [0x1000]
    hsubps xmm1, [r13]
    vhsubps xmm1, xmm2, [rax]
    vhsubps xmm1, xmm2, [rax+0x7f]
    vhsubps xmm1, xmm2, [rax+0x80]
    vhsubps xmm1, xmm2, [rax+rbx*4]
    vhsubps xmm1, xmm2, [rbx*8+0x10]
    vhsubps xmm1, xmm2, [rip+0x100]
    vhsubps xmm1, xmm2, [0x1000]
    vhsubps xmm1, xmm2, [r13]
    vhsubps ymm1, ymm2, [rax]
    vhsubps ymm1, ymm2, [rax+0x7f]
    vhsubps ymm1, ymm2, [rax+0x80]
    vhsubps ymm1, ymm2, [rax+rbx*4]
    vhsubps ymm1, ymm2, [rbx*8+0x10]
    vhsubps ymm1, ymm2, [rip+0x100]
    vhsubps ymm1, ymm2, [0x1000]
    vhsubps ymm1, ymm2, [r13]
    idiv BYTE PTR [rax]
    idiv BYTE PTR [rax+0x7f]
    idiv BYTE PTR [rax+0x80]
    idiv BYTE PTR [rax+rbx*4]
    idiv BYTE PTR [rbx*8+0x10]
    idiv BYTE PTR [rip+0x100]
    idiv BYTE PTR [0x1000]
    idiv BYTE PTR [r13]
    idiv WORD PTR [rax]
    idiv WORD PTR [rax+0x7f]
    idiv WORD PTR [rax+0x80]
    idiv WORD PTR [rax+rbx*4]
    idiv WORD PTR [rbx*8+0x10]
    idiv WORD PTR [rip+0x100]
    idiv WORD PTR [0x1000]
    idiv WORD PTR [r13]
    idiv DWORD PTR [rax]
    idiv DWORD PTR [rax+0x7f]
    idiv DWORD PTR [rax+0x80]
    idiv DWORD PTR [rax+rbx*4]
    idiv DWORD PTR [rbx*8+0x10]
    idiv DWORD PTR [rip+0x100]
    idiv DWORD PTR [0x1000]
    idiv DWORD PTR [r13]
    idiv QWORD PTR [rax]
    idiv QWORD PTR [rax+0x7f]
    idiv QWORD PTR [rax+0x80]
    idiv QWORD PTR [rax+rbx*4]
    idiv QWORD PTR [rbx*8+0x10]
    idiv QWORD PTR [rip+0x100]
    idiv QWORD PTR [0x1000]
    idiv QWORD PTR [r13]
    imul BYTE PTR [rax]
    imul BYTE PTR [rax+0x7f]
    imul BYTE PTR [rax+0x80]
    imul BYTE PTR [rax+rbx*4]
    imul BYTE PTR [rbx*8+0x10]
    imul BYTE PTR [rip+0x100]
    imul BYTE PTR [0x1000]
    imul BYTE PTR [r13]
    imul WORD PTR [rax]
    imul WORD PTR [rax+0x7f]
    imul WORD PTR [rax+0x80]
    imul WORD PTR [rax+rbx*4]
    imul WORD PTR [rbx*8+0x10]
    imul WORD PTR [rip+0x100]
    imul WORD PTR [0x1000]
    imul WORD PTR [r13]
    imul DWORD PTR [rax]
    imul DWORD PTR [rax+0x7f]
    imul DWORD PTR [rax+0x80]
    imul DWORD PTR [rax+rbx*4]
    imul DWORD PTR [rbx*8+0x10]
    imul DWORD PTR [rip+0x100]
    imul DWORD PTR [0x1000]
    imul DWORD PTR [r13]
    imul QWORD PTR [rax]
    imul QWORD PTR [rax+0x7f]
    imul QWORD PTR [rax+0x80]
    imul QWORD PTR [rax+rbx*4]
    imul QWORD PTR [rbx*8+0x10]
    imul QWORD PTR [rip+0x100]
    imul QWORD PTR [0x1000]
    imul QWORD PTR [r13]
    imul ax, WORD PTR [rax]
    imul ax, WORD PTR [rax+0x7f]
    imul ax, WORD PTR [rax+0x80]
    imul ax, WORD PTR [rax+rbx*4]
    imul ax, WORD PTR [rbx*8+0x10]
    imul ax, WORD PTR [rip+0x100]
    imul ax, WORD PTR [0x1000]
    imul ax, WORD PTR [r13]
    imul eax, DWORD PTR [rax]
    imul eax, DWORD PTR [rax+0x7f]
    imul eax, DWORD PTR [rax+0x80]
    imul eax, DWORD PTR [rax+rbx*4]
    imul eax, DWORD PTR [rbx*8+0x10]
    imul eax, DWORD PTR [rip+0x100]
    imul eax, DWORD PTR [0x1000]
    imul eax, DWORD PTR [r13]
    imul rax, QWORD PTR [rax]
    imul rax, QWORD PTR [rax+0x7f]
    imul rax, QWORD PTR [rax+0x80]
    imul rax, QWORD PTR [rax+rbx*4]
    imul rax, QWORD PTR [rbx*8+0x10]
    imul rax, QWORD PTR [rip+0x100]
    imul rax, QWORD PTR [0x1000]
    imul rax, QWORD PTR [r13]
    imul ax, WORD PTR [rax], 0x1
    imul ax, WORD PTR [rax+0x7f], 0x1
    imul ax, WORD PTR [rax+0x80], 0x1
    imul ax, WORD PTR [rax+rbx*4], 0x1
    imul ax, WORD PTR [rbx*8+0x10], 0x1
    imul ax, WORD PTR [rip+0x100], 0x1
    imul ax, WORD PTR [0x1000], 0x1
    imul ax, WORD PTR [r13], 0x1
    imul eax, DWORD PTR [rax], 0x1
    imul eax, DWORD PTR [rax+0x7f], 0x1
    imul eax, DWORD PTR [rax+0x80], 0x1
    imul eax, DWORD PTR [rax+rbx*4], 0x1
    imul eax, DWORD PTR [rbx*8+0x10], 0x1
    imul eax, DWORD PTR [rip+0x100], 0x1
    imul eax, DWORD PTR [0x1000], 0x1
    imul eax, DWORD PTR [r13], 0x1
    imul rax, QWORD PTR [rax], 0x1
    imul rax, QWORD PTR [rax+0x7f], 0x1
    imul rax, QWORD PTR [rax+0x80], 0x1
    imul rax, QWORD PTR [rax+rbx*4], 0x1
    imul rax, QWORD PTR [rbx*8+0x10], 0x1
    imul rax, QWORD PTR [rip+0x100], 0x1
    imul rax, QWORD PTR [0x1000], 0x1
    imul rax, QWORD PTR [r13], 0x1
    inc BYTE PTR [rax]
    inc BYTE PTR [rax+0x7f]
    inc BYTE PTR [rax+0x80]
    inc BYTE PTR [rax+rbx*4]
    inc BYTE PTR [rbx*8+0x10]
    inc BYTE PTR [rip+0x100]
    inc BYTE PTR [0x1000]
    inc BYTE PTR [r13]
    inc WORD PTR [rax]
    inc WORD PTR [rax+0x7f]
    inc WORD PTR [rax+0x80]
    inc WORD PTR [rax+rbx*4]
    inc WORD PTR [rbx*8+0x10]
    inc WORD PTR [rip+0x100]
    inc WORD PTR [0x1000]
    inc WORD PTR [r13]
    inc DWORD PTR [rax]
    inc DWORD PTR [rax+0x7f]
    inc DWORD PTR [rax+0x80]
    inc DWORD PTR [rax+rbx*4]
    inc DWORD PTR [rbx*8+0x10]
    inc DWORD PTR [rip+0x100]
    inc DWORD PTR [0x1000]
    inc DWORD PTR [r13]
    inc QWORD PTR [rax]
    inc QWORD PTR [rax+0x7f]
    inc QWORD PTR [rax+0x80]
    inc QWORD PTR [rax+rbx*4]
    inc QWORD PTR [rbx*8+0x10]
    inc QWORD PTR [rip+0x100]
    inc QWORD PTR [0x1000]
    inc QWORD PTR [r13]
    insertps xmm1, DWORD PTR [rax], 0x1
    insertps xmm1, DWORD PTR [rax+0x7f], 0x1
    insertps xmm1, DWORD PTR [rax+0x80], 0x1
    insertps xmm1, DWORD PTR [rax+rbx*4], 0x1
    insertps xmm1, DWORD PTR [rbx*8+0x10], 0x1
    insertps xmm1, DWORD PTR [rip+0x100], 0x1
    insertps xmm1, DWORD PTR [0x1000], 0x1
    insertps xmm1, DWORD PTR [r13], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rax], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rax+0x7f], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rax+0x80], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rax+rbx*4], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rbx*8+0x10], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rip+0x100], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [0x1000], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [r13], 0x1
    ins BYTE PTR [rax], dx
    ins BYTE PTR [rax+0x7f], dx
    ins BYTE PTR [rax+0x80], dx
    ins BYTE PTR [rax+rbx*4], dx
    ins BYTE PTR [rbx*8+0x10], dx
    ins BYTE PTR [rip+0x100], dx
    ins BYTE PTR [0x1000], dx
    ins BYTE PTR [r13], dx
    ins WORD PTR [rax], dx
    ins WORD PTR [rax+0x7f], dx
    ins WORD PTR [rax+0x80], dx
    ins WORD PTR [rax+rbx*4], dx
    ins WORD PTR [rbx*8+0x10], dx
    ins WORD PTR [rip+0x100], dx
    ins WORD PTR [0x1000], dx
    ins WORD PTR [r13], dx
    ins DWORD PTR [rax], dx
    ins DWORD PTR [rax+0x7f], dx
    ins DWORD PTR [rax+0x80], dx
    ins DWORD PTR [rax+rbx*4], dx
    ins DWORD PTR [rbx*8+0x10], dx
    ins DWORD PTR [rip+0x100], dx
    ins DWORD PTR [0x1000], dx
    ins DWORD PTR [r13], dx
    invlpg [rax]
    invlpg [rax+0x7f]
    invlpg [rax+0x80]
    invlpg [rax+rbx*4]
    invlpg [rbx*8+0x10]
    invlpg [rip+0x100]
    invlpg [0x1000]
    invlpg [r13]
    invpcid eax, [rax]
    invpcid eax, [rax+0x7f]
    invpcid eax, [rax+0x80]
    invpcid eax, [rax+rbx*4]
    invpcid eax, [rbx*8+0x10]
    invpcid eax, [rip+0x100]
    invpcid eax, [0x1000]
    invpcid eax, [r13]
    invpcid rax, [rax]
    invpcid rax, [rax+0x7f]
    invpcid rax, [rax+0x80]
    invpcid rax, [rax+rbx*4]
    invpcid rax, [rbx*8+0x10]
    invpcid rax, [rip+0x100]
    invpcid rax, [0x1000]
    invpcid rax, [r13]
    jmp WORD PTR [rax]
    jmp WORD PTR [rax+0x7f]
    jmp WORD PTR [rax+0x80]
    jmp WORD PTR [rax+rbx*4]
    jmp WORD PTR [rbx*8+0x10]
    jmp WORD PTR [rip+0x100]
    jmp WORD PTR [0x1000]
    jmp WORD PTR [r13]
    jmp DWORD PTR [rax]
    jmp DWORD PTR [rax+0x7f]
    jmp DWORD PTR [rax+0x80]
    jmp DWORD PTR [rax+rbx*4]
    jmp DWORD PTR [rbx*8+0x10]
    jmp DWORD PTR [rip+0x100]
    jmp DWORD PTR [0x1000]
    jmp DWORD PTR [r13]
    jmp QWORD PTR [rax]
    jmp QWORD PTR [rax+0x7f]
    jmp QWORD PTR [rax+0x80]
    jmp QWORD PTR [rax+rbx*4]
    jmp QWORD PTR [rbx*8+0x10]
    jmp QWORD PTR [rip+0x100]
    jmp QWORD PTR [0x1000]
    jmp QWORD PTR [r13]
    jmp FWORD PTR [rax]
    jmp FWORD PTR [rax+0x7f]
    jmp FWORD PTR [rax+0x80]
    jmp FWORD PTR [rax+rbx*4]
    jmp FWORD PTR [rbx*8+0x10]
    jmp FWORD PTR [rip+0x100]
    jmp FWORD PTR [0x1000]
    jmp FWORD PTR [r13]
    jmp TBYTE PTR [rax]
    jmp TBYTE PTR [rax+0x7f]
    jmp TBYTE PTR [rax+0x80]
    jmp TBYTE PTR [rax+rbx*4]
    jmp TBYTE PTR [rbx*8+0x10]
    jmp TBYTE PTR [rip+0x100]
    jmp TBYTE PTR [0x1000]
    jmp TBYTE PTR [r13]
    kmovw k1, WORD PTR [rax]
    kmovw k1, WORD PTR [rax+0x7f]
    kmovw k1, WORD PTR [rax+0x80]
    kmovw k1, WORD PTR [rax+rbx*4]
    kmovw k1, WORD PTR [rbx*8+0x10]
    kmovw k1, WORD PTR [rip+0x100]
    kmovw k1, WORD PTR [0x1000]
    kmovw k1, WORD PTR [r13]
    kmovb k1, BYTE PTR [rax]
    kmovb k1, BYTE PTR [rax+0x7f]
    kmovb k1, BYTE PTR [rax+0x80]
    kmovb k1, BYTE PTR [rax+rbx*4]
    kmovb k1, BYTE PTR [rbx*8+0x10]
    kmovb k1, BYTE PTR [rip+0x100]
    kmovb k1, BYTE PTR [0x1000]
    kmovb k1, BYTE PTR [r13]
    kmovq k1, QWORD PTR [rax]
    kmovq k1, QWORD PTR [rax+0x7f]
    kmovq k1, QWORD PTR [rax+0x80]
    kmovq k1, QWORD PTR [rax+rbx*4]
    kmovq k1, QWORD PTR [rbx*8+0x10]
    kmovq k1, QWORD PTR [rip+0x100]
    kmovq k1, QWORD PTR [0x1000]
    kmovq k1, QWORD PTR [r13]
    kmovd k1, DWORD PTR [rax]
    kmovd k1, DWORD PTR [rax+0x7f]
    kmovd k1, DWORD PTR [rax+0x80]
    kmovd k1, DWORD PTR [rax+rbx*4]
    kmovd k1, DWORD PTR [rbx*8+0x10]
    kmovd k1, DWORD PTR [rip+0x100]
    kmovd k1, DWORD PTR [0x1000]
    kmovd k1, DWORD PTR [r13]
    kmovw WORD PTR [rax], k1
    kmovw WORD PTR [rax+0x7f], k1
    kmovw WORD PTR [rax+0x80], k1
    kmovw WORD PTR [rax+rbx*4], k1
    kmovw WORD PTR [rbx*8+0x10], k1
    kmovw WORD PTR [rip+0x100], k1
    kmovw WORD PTR [0x1000], k1
    kmovw WORD PTR [r13], k1
    kmovb BYTE PTR [rax], k1
    kmovb BYTE PTR [rax+0x7f], k1
    kmovb BYTE PTR [rax+0x80], k1
    kmovb BYTE PTR [rax+rbx*4], k1
    kmovb BYTE PTR [rbx*8+0x10], k1
    kmovb BYTE PTR [rip+0x100], k1
    kmovb BYTE PTR [0x1000], k1
    kmovb BYTE PTR [r13], k1
    kmovq QWORD PTR [rax], k1
    kmovq QWORD PTR [rax+0x7f], k1
    kmovq QWORD PTR [rax+0x80], k1
    kmovq QWORD PTR [rax+rbx*4], k1
    kmovq QWORD PTR [rbx*8+0x10], k1
    kmovq QWORD PTR [rip+0x100], k1
    kmovq QWORD PTR [0x1000], k1
    kmovq QWORD PTR [r13], k1
    kmovd DWORD PTR [rax], k1
    kmovd DWORD PTR [rax+0x7f], k1
    kmovd DWORD PTR [rax+0x80], k1
    kmovd DWORD PTR [rax+rbx*4], k1
    kmovd DWORD PTR [rbx*8+0x10], k1
    kmovd DWORD PTR [rip+0x100], k1
    kmovd DWORD PTR [0x1000], k1
    kmovd DWORD PTR [r13], k1
    lar ax, WORD PTR [rax]
    lar ax, WORD PTR [rax+0x7f]
    lar ax, WORD PTR [rax+0x80]
    lar ax, WORD PTR [rax+rbx*4]
    lar ax, WORD PTR [rbx*8+0x10]
    lar ax, WORD PTR [rip+0x100]
    lar ax, WORD PTR [0x1000]
    lar ax, WORD PTR [r13]
    lar eax, WORD PTR [rax]
    lar eax, WORD PTR [rax+0x7f]
    lar eax, WORD PTR [rax+0x80]
    lar eax, WORD PTR [rax+rbx*4]
    lar eax, WORD PTR [rbx*8+0x10]
    lar eax, WORD PTR [rip+0x100]
    lar eax, WORD PTR [0x1000]
    lar eax, WORD PTR [r13]
    lddqu xmm1, [rax]
    lddqu xmm1, [rax+0x7f]
    lddqu xmm1, [rax+0x80]
    lddqu xmm1, [rax+rbx*4]
    lddqu xmm1, [rbx*8+0x10]
    lddqu xmm1, [rip+0x100]
    lddqu xmm1, [0x1000]
    lddqu xmm1, [r13]
    vlddqu xmm1, [rax]
    vlddqu xmm1, [rax+0x7f]
    vlddqu xmm1, [rax+0x80]
    vlddqu xmm1, [rax+rbx*4]
    vlddqu xmm1, [rbx*8+0x10]
    vlddqu xmm1, [rip+0x100]
    vlddqu xmm1, [0x1000]
    vlddqu xmm1, [r13]
    vlddqu ymm1, [rax]
    vlddqu ymm1, [rax+0x7f]
    vlddqu ymm1, [rax+0x80]
    vlddqu ymm1, [rax+rbx*4]
    vlddqu ymm1, [rbx*8+0x10]
    vlddqu ymm1, [rip+0x100]
    vlddqu ymm1, [0x1000]
    vlddqu ymm1, [r13]
    ldmxcsr DWORD PTR [rax]
    ldmxcsr DWORD PTR [rax+0x7f]
    ldmxcsr DWORD PTR [rax+0x80]
    ldmxcsr DWORD PTR [rax+rbx*4]
    ldmxcsr DWORD PTR [rbx*8+0x10]
    ldmxcsr DWORD PTR [rip+0x100]
    ldmxcsr DWORD PTR [0x1000]
    ldmxcsr DWORD PTR [r13]
    vldmxcsr DWORD PTR [rax]
    vldmxcsr DWORD PTR [rax+0x7f]
    vldmxcsr DWORD PTR [rax+0x80]
    vldmxcsr DWORD PTR [rax+rbx*4]
    vldmxcsr DWORD PTR [rbx*8+0x10]
    vldmxcsr DWORD PTR [rip+0x100]
    vldmxcsr DWORD PTR [0x1000]
    vldmxcsr DWORD PTR [r13]
    lds ax, DWORD PTR [rax]
    lds ax, DWORD PTR [rax+0x7f]
    lds ax, DWORD PTR [rax+0x80]
    lds ax, DWORD PTR [rax+rbx*4]
    lds ax, DWORD PTR [rbx*8+0x10]
    lds ax, DWORD PTR [rip+0x100]
    lds ax, DWORD PTR [0x1000]
    lds ax, DWORD PTR [r13]
    lds eax, FWORD PTR [rax]
    lds eax, FWORD PTR [rax+0x7f]
    lds eax, FWORD PTR [rax+0x80]
    lds eax, FWORD PTR [rax+rbx*4]
    lds eax, FWORD PTR [rbx*8+0x10]
    lds eax, FWORD PTR [rip+0x100]
    lds eax, FWORD PTR [0x1000]
    lds eax, FWORD PTR [r13]
    lss ax, DWORD PTR [rax]
    lss ax, DWORD PTR [rax+0x7f]
    lss ax, DWORD PTR [rax+0x80]
    lss ax, DWORD PTR [rax+rbx*4]
    lss ax, DWORD PTR [rbx*8+0x10]
    lss ax, DWORD PTR [rip+0x100]
    lss ax, DWORD PTR [0x1000]
    lss ax, DWORD PTR [r13]
    lss eax, FWORD PTR [rax]
    lss eax, FWORD PTR [rax+0x7f]
    lss eax, FWORD PTR [rax+0x80]
    lss eax, FWORD PTR [rax+rbx*4]
    lss eax, FWORD PTR [rbx*8+0x10]
    lss eax, FWORD PTR [rip+0x100]
    lss eax, FWORD PTR [0x1000]
    lss eax, FWORD PTR [r13]
    lss rax, TBYTE PTR [rax]
    lss rax, TBYTE PTR [rax+0x7f]
    lss rax, TBYTE PTR [rax+0x80]
    lss rax, TBYTE PTR [rax+rbx*4]
    lss rax, TBYTE PTR [rbx*8+0x10]
    lss rax, TBYTE PTR [rip+0x100]
    lss rax, TBYTE PTR [0x1000]
    lss rax, TBYTE PTR [r13]
    les ax, DWORD PTR [rax]
    les ax, DWORD PTR [rax+0x7f]
    les ax, DWORD PTR [rax+0x80]
    les ax, DWORD PTR [rax+rbx*4]
    les ax, DWORD PTR [rbx*8+0x10]
    les ax, DWORD PTR [rip+0x100]
    les ax, DWORD PTR [0x1000]
    les ax, DWORD PTR [r13]
    les eax, FWORD PTR [rax]
    les eax, FWORD PTR [rax+0x7f]
    les eax, FWORD PTR [rax+0x80]
    les eax, FWORD PTR [rax+rbx*4]
    les eax, FWORD PTR [rbx*8+0x10]
    les eax, FWORD PTR [rip+0x100]
    les eax, FWORD PTR [0x1000]
    les eax, FWORD PTR [r13]
    lfs ax, DWORD PTR [rax]
    lfs ax, DWORD PTR [rax+0x7f]
    lfs ax, DWORD PTR [rax+0x80]
    lfs ax, DWORD PTR [rax+rbx*4]
    lfs ax, DWORD PTR [rbx*8+0x10]
    lfs ax, DWORD PTR [rip+0x100]
    lfs ax, DWORD PTR [0x1000]
    lfs ax, DWORD PTR [r13]
    lfs eax, FWORD PTR [rax]
    lfs eax, FWORD PTR [rax+0x7f]
    lfs eax, FWORD PTR [rax+0x80]
    lfs eax, FWORD PTR [rax+rbx*4]
    lfs eax, FWORD PTR [rbx*8+0x10]
    lfs eax, FWORD PTR [rip+0x100]
    lfs eax, FWORD PTR [0x1000]
    lfs eax, FWORD PTR [r13]
    lfs rax, TBYTE PTR [rax]
    lfs rax, TBYTE PTR [rax+0x7f]
    lfs rax, TBYTE PTR [rax+0x80]
    lfs rax, TBYTE PTR [rax+rbx*4]
    lfs rax, TBYTE PTR [rbx*8+0x10]
    lfs rax, TBYTE PTR [rip+0x100]
    lfs rax, TBYTE PTR [0x1000]
    lfs rax, TBYTE PTR [r13]
    lgs ax, DWORD PTR [rax]
    lgs ax, DWORD PTR [rax+0x7f]
    lgs ax, DWORD PTR [rax+0x80]
    lgs ax, DWORD PTR [rax+rbx*4]
    lgs ax, DWORD PTR [rbx*8+0x10]
    lgs ax, DWORD PTR [rip+0x100]
    lgs ax, DWORD PTR [0x1000]
    lgs ax, DWORD PTR [r13]
    lgs eax, FWORD PTR [rax]
    lgs eax, FWORD PTR [rax+0x7f]
    lgs eax, FWORD PTR [rax+0x80]
    lgs eax, FWORD PTR [rax+rbx*4]
    lgs eax, FWORD PTR [rbx*8+0x10]
    lgs eax, FWORD PTR [rip+0x100]
    lgs eax, FWORD PTR [0x1000]
    lgs eax, FWORD PTR [r13]
    lgs rax, TBYTE PTR [rax]
    lgs rax, TBYTE PTR [rax+0x7f]
    lgs rax, TBYTE PTR [rax+0x80]
    lgs rax, TBYTE PTR [rax+rbx*4]
    lgs rax, TBYTE PTR [rbx*8+0x10]
    lgs rax, TBYTE PTR [rip+0x100]
    lgs rax, TBYTE PTR [0x1000]
    lgs rax, TBYTE PTR [r13]
    ldtilecfg [rax]
    ldtilecfg [rax+0x7f]
    ldtilecfg [rax+0x80]
    ldtilecfg [rax+rbx*4]
    ldtilecfg [rbx*8+0x10]
    ldtilecfg [rip+0x100]
    ldtilecfg [0x1000]
    ldtilecfg [r13]
    lea ax, [rax]
    lea ax, [rax+0x7f]
    lea ax, [rax+0x80]
    lea ax, [rax+rbx*4]
    lea ax, [rbx*8+0x10]
    lea ax, [rip+0x100]
    lea ax, [0x1000]
    lea ax, [r13]
    lea eax, [rax]
    lea eax, [rax+0x7f]
    lea eax, [rax+0x80]
    lea eax, [rax+rbx*4]
    lea eax, [rbx*8+0x10]
    lea eax, [rip+0x100]
    lea eax, [0x1000]
    lea eax, [r13]
    lea rax, [rax]
    lea rax, [rax+0x7f]
    lea rax, [rax+0x80]
    lea rax, [rax+rbx*4]
    lea rax, [rbx*8+0x10]
    lea rax, [rip+0x100]
    lea rax, [0x1000]
    lea rax, [r13]
    lgdt [rax]
    lgdt [rax+0x7f]
    lgdt [rax+0x80]
    lgdt [rax+rbx*4]
    lgdt [rbx*8+0x10]
    lgdt [rip+0x100]
    lgdt [0x1000]
    lgdt [r13]
    lidt [rax]
    lidt [rax+0x7f]
    lidt [rax+0x80]
    lidt [rax+rbx*4]
    lidt [rbx*8+0x10]
    lidt [rip+0x100]
    lidt [0x1000]
    lidt [r13]
    lkgs WORD PTR [rax]
    lkgs WORD PTR [rax+0x7f]
    lkgs WORD PTR [rax+0x80]
    lkgs WORD PTR [rax+rbx*4]
    lkgs WORD PTR [rbx*8+0x10]
    lkgs WORD PTR [rip+0x100]
    lkgs WORD PTR [0x1000]
    lkgs WORD PTR [r13]
    lldt WORD PTR [rax]
    lldt WORD PTR [rax+0x7f]
    lldt WORD PTR [rax+0x80]
    lldt WORD PTR [rax+rbx*4]
    lldt WORD PTR [rbx*8+0x10]
    lldt WORD PTR [rip+0x100]
    lldt WORD PTR [0x1000]
    lldt WORD PTR [r13]
    lmsw WORD PTR [rax]
    lmsw WORD PTR [rax+0x7f]
    lmsw WORD PTR [rax+0x80]
    lmsw WORD PTR [rax+rbx*4]
    lmsw WORD PTR [rbx*8+0x10]
    lmsw WORD PTR [rip+0x100]
    lmsw WORD PTR [0x1000]
    lmsw WORD PTR [r13]
    lods BYTE PTR [rax]
    lods BYTE PTR [rax+0x7f]
    lods BYTE PTR [rax+0x80]
    lods BYTE PTR [rax+rbx*4]
    lods BYTE PTR [rbx*8+0x10]
    lods BYTE PTR [rip+0x100]
    lods BYTE PTR [0x1000]
    lods BYTE PTR [r13]
    lods WORD PTR [rax]
    lods WORD PTR [rax+0x7f]
    lods WORD PTR [rax+0x80]
    lods WORD PTR [rax+rbx*4]
    lods WORD PTR [rbx*8+0x10]
    lods WORD PTR [rip+0x100]
    lods WORD PTR [0x1000]
    lods WORD PTR [r13]
    lods DWORD PTR [rax]
    lods DWORD PTR [rax+0x7f]
    lods DWORD PTR [rax+0x80]
    lods DWORD PTR [rax+rbx*4]
    lods DWORD PTR [rbx*8+0x10]
    lods DWORD PTR [rip+0x100]
    lods DWORD PTR [0x1000]
    lods DWORD PTR [r13]
    lods QWORD PTR [rax]
    lods QWORD PTR [rax+0x7f]
    lods QWORD PTR [rax+0x80]
    lods QWORD PTR [rax+rbx*4]
    lods QWORD PTR [rbx*8+0x10]
    lods QWORD PTR [rip+0x100]
    lods QWORD PTR [0x1000]
    lods QWORD PTR [r13]
    lsl ax, WORD PTR [rax]
    lsl ax, WORD PTR [rax+0x7f]
    lsl ax, WORD PTR [rax+0x80]
    lsl ax, WORD PTR [rax+rbx*4]
    lsl ax, WORD PTR [rbx*8+0x10]
    lsl ax, WORD PTR [rip+0x100]
    lsl ax, WORD PTR [0x1000]
    lsl ax, WORD PTR [r13]
    lsl eax, WORD PTR [rax]
    lsl eax, WORD PTR [rax+0x7f]
    lsl eax, WORD PTR [rax+0x80]
    lsl eax, WORD PTR [rax+rbx*4]
    lsl eax, WORD PTR [rbx*8+0x10]
    lsl eax, WORD PTR [rip+0x100]
    lsl eax, WORD PTR [0x1000]
    lsl eax, WORD PTR [r13]
    lsl rax, WORD PTR [rax]
    lsl rax, WORD PTR [rax+0x7f]
    lsl rax, WORD PTR [rax+0x80]
    lsl rax, WORD PTR [rax+rbx*4]
    lsl rax, WORD PTR [rbx*8+0x10]
    lsl rax, WORD PTR [rip+0x100]
    lsl rax, WORD PTR [0x1000]
    lsl rax, WORD PTR [r13]
    ltr WORD PTR [rax]
    ltr WORD PTR [rax+0x7f]
    ltr WORD PTR [rax+0x80]
    ltr WORD PTR [rax+rbx*4]
    ltr WORD PTR [rbx*8+0x10]
    ltr WORD PTR [rip+0x100]
    ltr WORD PTR [0x1000]
    ltr WORD PTR [r13]
    lzcnt ax, WORD PTR [rax]
    lzcnt ax, WORD PTR [rax+0x7f]
    lzcnt ax, WORD PTR [rax+0x80]
    lzcnt ax, WORD PTR [rax+rbx*4]
    lzcnt ax, WORD PTR [rbx*8+0x10]
    lzcnt ax, WORD PTR [rip+0x100]
    lzcnt ax, WORD PTR [0x1000]
    lzcnt ax, WORD PTR [r13]
    lzcnt eax, DWORD PTR [rax]
    lzcnt eax, DWORD PTR [rax+0x7f]
    lzcnt eax, DWORD PTR [rax+0x80]
    lzcnt eax, DWORD PTR [rax+rbx*4]
    lzcnt eax, DWORD PTR [rbx*8+0x10]
    lzcnt eax, DWORD PTR [rip+0x100]
    lzcnt eax, DWORD PTR [0x1000]
    lzcnt eax, DWORD PTR [r13]
    lzcnt rax, QWORD PTR [rax]
    lzcnt rax, QWORD PTR [rax+0x7f]
    lzcnt rax, QWORD PTR [rax+0x80]
    lzcnt rax, QWORD PTR [rax+rbx*4]
    lzcnt rax, QWORD PTR [rbx*8+0x10]
    lzcnt rax, QWORD PTR [rip+0x100]
    lzcnt rax, QWORD PTR [0x1000]
    lzcnt rax, QWORD PTR [r13]
    maxpd xmm1, [rax]
    maxpd xmm1, [rax+0x7f]
    maxpd xmm1, [rax+0x80]
    maxpd xmm1, [rax+rbx*4]
    maxpd xmm1, [rbx*8+0x10]
    maxpd xmm1, [rip+0x100]
    maxpd xmm1, [0x1000]
    maxpd xmm1, [r13]
    vmaxpd xmm1, xmm2, [rax]
    vmaxpd xmm1, xmm2, [rax+0x7f]
    vmaxpd xmm1, xmm2, [rax+0x80]
    vmaxpd xmm1, xmm2, [rax+rbx*4]
    vmaxpd xmm1, xmm2, [rbx*8+0x10]
    vmaxpd xmm1, xmm2, [rip+0x100]
    vmaxpd xmm1, xmm2, [0x1000]
    vmaxpd xmm1, xmm2, [r13]
    vmaxpd ymm1, ymm2, [rax]
    vmaxpd ymm1, ymm2, [rax+0x7f]
    vmaxpd ymm1, ymm2, [rax+0x80]
    vmaxpd ymm1, ymm2, [rax+rbx*4]
    vmaxpd ymm1, ymm2, [rbx*8+0x10]
    vmaxpd ymm1, ymm2, [rip+0x100]
    vmaxpd ymm1, ymm2, [0x1000]
    vmaxpd ymm1, ymm2, [r13]
    maxps xmm1, [rax]
    maxps xmm1, [rax+0x7f]
    maxps xmm1, [rax+0x80]
    maxps xmm1, [rax+rbx*4]
    maxps xmm1, [rbx*8+0x10]
    maxps xmm1, [rip+0x100]
    maxps xmm1, [0x1000]
    maxps xmm1, [r13]
    vmaxps xmm1, xmm2, [rax]
    vmaxps xmm1, xmm2, [rax+0x7f]
    vmaxps xmm1, xmm2, [rax+0x80]
    vmaxps xmm1, xmm2, [rax+rbx*4]
    vmaxps xmm1, xmm2, [rbx*8+0x10]
    vmaxps xmm1, xmm2, [rip+0x100]
    vmaxps xmm1, xmm2, [0x1000]
    vmaxps xmm1, xmm2, [r13]
    vmaxps ymm1, ymm2, [rax]
    vmaxps ymm1, ymm2, [rax+0x7f]
    vmaxps ymm1, ymm2, [rax+0x80]
    vmaxps ymm1, ymm2, [rax+rbx*4]
    vmaxps ymm1, ymm2, [rbx*8+0x10]
    vmaxps ymm1, ymm2, [rip+0x100]
    vmaxps ymm1, ymm2, [0x1000]
    vmaxps ymm1, ymm2, [r13]
    maxsd xmm1, QWORD PTR [rax]
    maxsd xmm1, QWORD PTR [rax+0x7f]
    maxsd xmm1, QWORD PTR [rax+0x80]
    maxsd xmm1, QWORD PTR [rax+rbx*4]
    maxsd xmm1, QWORD PTR [rbx*8+0x10]
    maxsd xmm1, QWORD PTR [rip+0x100]
    maxsd xmm1, QWORD PTR [0x1000]
    maxsd xmm1, QWORD PTR [r13]
    vmaxsd xmm1, xmm2, QWORD PTR [rax]
    vmaxsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vmaxsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vmaxsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vmaxsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vmaxsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vmaxsd xmm1, xmm2, QWORD PTR [0x1000]
    vmaxsd xmm1, xmm2, QWORD PTR [r13]
    maxss xmm1, DWORD PTR [rax]
    maxss xmm1, DWORD PTR [rax+0x7f]
    maxss xmm1, DWORD PTR [rax+0x80]
    maxss xmm1, DWORD PTR [rax+rbx*4]
    maxss xmm1, DWORD PTR [rbx*8+0x10]
    maxss xmm1, DWORD PTR [rip+0x100]
    maxss xmm1, DWORD PTR [0x1000]
    maxss xmm1, DWORD PTR [r13]
    vmaxss xmm1, xmm2, DWORD PTR [rax]
    vmaxss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vmaxss xmm1, xmm2, DWORD PTR [rax+0x80]
    vmaxss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vmaxss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vmaxss xmm1, xmm2, DWORD PTR [rip+0x100]
    vmaxss xmm1, xmm2, DWORD PTR [0x1000]
    vmaxss xmm1, xmm2, DWORD PTR [r13]
    minpd xmm1, [rax]
    minpd xmm1, [rax+0x7f]
    minpd xmm1, [rax+0x80]
    minpd xmm1, [rax+rbx*4]
    minpd xmm1, [rbx*8+0x10]
    minpd xmm1, [rip+0x100]
    minpd xmm1, [0x1000]
    minpd xmm1, [r13]
    vminpd xmm1, xmm2, [rax]
    vminpd xmm1, xmm2, [rax+0x7f]
    vminpd xmm1, xmm2, [rax+0x80]
    vminpd xmm1, xmm2, [rax+rbx*4]
    vminpd xmm1, xmm2, [rbx*8+0x10]
    vminpd xmm1, xmm2, [rip+0x100]
    vminpd xmm1, xmm2, [0x1000]
    vminpd xmm1, xmm2, [r13]
    vminpd ymm1, ymm2, [rax]
    vminpd ymm1, ymm2, [rax+0x7f]
    vminpd ymm1, ymm2, [rax+0x80]
    vminpd ymm1, ymm2, [rax+rbx*4]
    vminpd ymm1, ymm2, [rbx*8+0x10]
    vminpd ymm1, ymm2, [rip+0x100]
    vminpd ymm1, ymm2, [0x1000]
    vminpd ymm1, ymm2, [r13]
    minps xmm1, [rax]
    minps xmm1, [rax+0x7f]
    minps xmm1, [rax+0x80]
    minps xmm1, [rax+rbx*4]
    minps xmm1, [rbx*8+0x10]
    minps xmm1, [rip+0x100]
    minps xmm1, [0x1000]
    minps xmm1, [r13]
    vminps xmm1, xmm2, [rax]
    vminps xmm1, xmm2, [rax+0x7f]
    vminps xmm1, xmm2, [rax+0x80]
    vminps xmm1, xmm2, [rax+rbx*4]
    vminps xmm1, xmm2, [rbx*8+0x10]
    vminps xmm1, xmm2, [rip+0x100]
    vminps xmm1, xmm2, [0x1000]
    vminps xmm1, xmm2, [r13]
    vminps ymm1, ymm2, [rax]
    vminps ymm1, ymm2, [rax+0x7f]
    vminps ymm1, ymm2, [rax+0x80]
    vminps ymm1, ymm2, [rax+rbx*4]
    vminps ymm1, ymm2, [rbx*8+0x10]
    vminps ymm1, ymm2, [rip+0x100]
    vminps ymm1, ymm2, [0x1000]
    vminps ymm1, ymm2, [r13]
    minsd xmm1, QWORD PTR [rax]
    minsd xmm1, QWORD PTR [rax+0x7f]
    minsd xmm1, QWORD PTR [rax+0x80]
    minsd xmm1, QWORD PTR [rax+rbx*4]
    minsd xmm1, QWORD PTR [rbx*8+0x10]
    minsd xmm1, QWORD PTR [rip+0x100]
    minsd xmm1, QWORD PTR [0x1000]
    minsd xmm1, QWORD PTR [r13]
    vminsd xmm1, xmm2, QWORD PTR [rax]
    vminsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vminsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vminsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vminsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vminsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vminsd xmm1, xmm2, QWORD PTR [0x1000]
    vminsd xmm1, xmm2, QWORD PTR [r13]
    minss xmm1, DWORD PTR [rax]
    minss xmm1, DWORD PTR [rax+0x7f]
    minss xmm1, DWORD PTR [rax+0x80]
    minss xmm1, DWORD PTR [rax+rbx*4]
    minss xmm1, DWORD PTR [rbx*8+0x10]
    minss xmm1, DWORD PTR [rip+0x100]
    minss xmm1, DWORD PTR [0x1000]
    minss xmm1, DWORD PTR [r13]
    vminss xmm1, xmm2, DWORD PTR [rax]
    vminss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vminss xmm1, xmm2, DWORD PTR [rax+0x80]
    vminss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vminss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vminss xmm1, xmm2, DWORD PTR [rip+0x100]
    vminss xmm1, xmm2, DWORD PTR [0x1000]
    vminss xmm1, xmm2, DWORD PTR [r13]
    mov BYTE PTR [rax], al
    mov BYTE PTR [rax+0x7f], al
    mov BYTE PTR [rax+0x80], al
    mov BYTE PTR [rax+rbx*4], al
    mov BYTE PTR [rbx*8+0x10], al
    mov BYTE PTR [rip+0x100], al
    mov BYTE PTR [0x1000], al
    mov BYTE PTR [r13], al
    mov WORD PTR [rax], ax
    mov WORD PTR [rax+0x7f], ax
    mov WORD PTR [rax+0x80], ax
    mov WORD PTR [rax+rbx*4], ax
    mov WORD PTR [rbx*8+0x10], ax
    mov WORD PTR [rip+0x100], ax
    mov WORD PTR [0x1000], ax
    mov WORD PTR [r13], ax
    mov DWORD PTR [rax], eax
    mov DWORD PTR [rax+0x7f], eax
    mov DWORD PTR [rax+0x80], eax
    mov DWORD PTR [rax+rbx*4], eax
    mov DWORD PTR [rbx*8+0x10], eax
    mov DWORD PTR [rip+0x100], eax
    mov DWORD PTR [0x1000], eax
    mov DWORD PTR [r13], eax
    mov QWORD PTR [rax], rax
    mov QWORD PTR [rax+0x7f], rax
    mov QWORD PTR [rax+0x80], rax
    mov QWORD PTR [rax+rbx*4], rax
    mov QWORD PTR [rbx*8+0x10], rax
    mov QWORD PTR [rip+0x100], rax
    mov QWORD PTR [0x1000], rax
    mov QWORD PTR [r13], rax
    mov al, BYTE PTR [rax]
    mov al, BYTE PTR [rax+0x7f]
    mov al, BYTE PTR [rax+0x80]
    mov al, BYTE PTR [rax+rbx*4]
    mov al, BYTE PTR [rbx*8+0x10]
    mov al, BYTE PTR [rip+0x100]
    mov al, BYTE PTR [0x1000]
    mov al, BYTE PTR [r13]
    mov ax, WORD PTR [rax]
    mov ax, WORD PTR [rax+0x7f]
    mov ax, WORD PTR [rax+0x80]
    mov ax, WORD PTR [rax+rbx*4]
    mov ax, WORD PTR [rbx*8+0x10]
    mov ax, WORD PTR [rip+0x100]
    mov ax, WORD PTR [0x1000]
    mov ax, WORD PTR [r13]
    mov eax, DWORD PTR [rax]
    mov eax, DWORD PTR [rax+0x7f]
    mov eax, DWORD PTR [rax+0x80]
    mov eax, DWORD PTR [rax+rbx*4]
    mov eax, DWORD PTR [rbx*8+0x10]
    mov eax, DWORD PTR [rip+0x100]
    mov eax, DWORD PTR [0x1000]
    mov eax, DWORD PTR [r13]
    mov rax, QWORD PTR [rax]
    mov rax, QWORD PTR [rax+0x7f]
    mov rax, QWORD PTR [rax+0x80]
    mov rax, QWORD PTR [rax+rbx*4]
    mov rax, QWORD PTR [rbx*8+0x10]
    mov rax, QWORD PTR [rip+0x100]
    mov rax, QWORD PTR [0x1000]
    mov rax, QWORD PTR [r13]
    mov WORD PTR [rax], ds
    mov WORD PTR [rax+0x7f], ds
    mov WORD PTR [rax+0x80], ds
    mov WORD PTR [rax+rbx*4], ds
    mov WORD PTR [rbx*8+0x10], ds
    mov WORD PTR [rip+0x100], ds
    mov WORD PTR [0x1000], ds
    mov WORD PTR [r13], ds
    mov ds, WORD PTR [rax]
    mov ds, WORD PTR [rax+0x7f]
    mov ds, WORD PTR [rax+0x80]
    mov ds, WORD PTR [rax+rbx*4]
    mov ds, WORD PTR [rbx*8+0x10]
    mov ds, WORD PTR [rip+0x100]
    mov ds, WORD PTR [0x1000]
    mov ds, WORD PTR [r13]
    mov ds, QWORD PTR [rax]
    mov ds, QWORD PTR [rax+0x7f]
    mov ds, QWORD PTR [rax+0x80]
    mov ds, QWORD PTR [rax+rbx*4]
    mov ds, QWORD PTR [rbx*8+0x10]
    mov ds, QWORD PTR [rip+0x100]
    mov ds, QWORD PTR [0x1000]
    mov ds, QWORD PTR [r13]
    mov BYTE PTR [rax], 0x1
    mov BYTE PTR [rax+0x7f], 0x1
    mov BYTE PTR [rax+0x80], 0x1
    mov BYTE PTR [rax+rbx*4], 0x1
    mov BYTE PTR [rbx*8+0x10], 0x1
    mov BYTE PTR [rip+0x100], 0x1
    mov BYTE PTR [0x1000], 0x1
    mov BYTE PTR [r13], 0x1
    mov WORD PTR [rax], 0x1
    mov WORD PTR [rax+0x7f], 0x1
    mov WORD PTR [rax+0x80], 0x1
    mov WORD PTR [rax+rbx*4], 0x1
    mov WORD PTR [rbx*8+0x10], 0x1
    mov WORD PTR [rip+0x100], 0x1
    mov WORD PTR [0x1000], 0x1
    mov WORD PTR [r13], 0x1
    mov DWORD PTR [rax], 0x1
    mov DWORD PTR [rax+0x7f], 0x1
    mov DWORD PTR [rax+0x80], 0x1
    mov DWORD PTR [rax+rbx*4], 0x1
    mov DWORD PTR [rbx*8+0x10], 0x1
    mov DWORD PTR [rip+0x100], 0x1
    mov DWORD PTR [0x1000], 0x1
    mov DWORD PTR [r13], 0x1
    mov QWORD PTR [rax], 0x1
    mov QWORD PTR [rax+0x7f], 0x1
    mov QWORD PTR [rax+0x80], 0x1
    mov QWORD PTR [rax+rbx*4], 0x1
    mov QWORD PTR [rbx*8+0x10], 0x1
    mov QWORD PTR [rip+0x100], 0x1
    mov QWORD PTR [0x1000], 0x1
    mov QWORD PTR [r13], 0x1
    movapd xmm1, [rax]
    movapd xmm1, [rax+0x7f]
    movapd xmm1, [rax+0x80]
    movapd xmm1, [rax+rbx*4]
    movapd xmm1, [rbx*8+0x10]
    movapd xmm1, [rip+0x100]
    movapd xmm1, [0x1000]
    movapd xmm1, [r13]
    movapd [rax], xmm1
    movapd [rax+0x7f], xmm1
    movapd [rax+0x80], xmm1
    movapd [rax+rbx*4], xmm1
    movapd [rbx*8+0x10], xmm1
    movapd [rip+0x100], xmm1
    movapd [0x1000], xmm1
    movapd [r13], xmm1
    vmovapd xmm1, [rax]
    vmovapd xmm1, [rax+0x7f]
    vmovapd xmm1, [rax+0x80]
    vmovapd xmm1, [rax+rbx*4]
    vmovapd xmm1, [rbx*8+0x10]
    vmovapd xmm1, [rip+0x100]
    vmovapd xmm1, [0x1000]
    vmovapd xmm1, [r13]
    vmovapd [rax], xmm1
    vmovapd [rax+0x7f], xmm1
    vmovapd [rax+0x80], xmm1
    vmovapd [rax+rbx*4], xmm1
    vmovapd [rbx*8+0x10], xmm1
    vmovapd [rip+0x100], xmm1
    vmovapd [0x1000], xmm1
    vmovapd [r13], xmm1
    vmovapd ymm1, [rax]
    vmovapd ymm1, [rax+0x7f]
    vmovapd ymm1, [rax+0x80]
    vmovapd ymm1, [rax+rbx*4]
    vmovapd ymm1, [rbx*8+0x10]
    vmovapd ymm1, [rip+0x100]
    vmovapd ymm1, [0x1000]
    vmovapd ymm1, [r13]
    vmovapd [rax], ymm1
    vmovapd [rax+0x7f], ymm1
    vmovapd [rax+0x80], ymm1
    vmovapd [rax+rbx*4], ymm1
    vmovapd [rbx*8+0x10], ymm1
    vmovapd [rip+0x100], ymm1
    vmovapd [0x1000], ymm1
    vmovapd [r13], ymm1
    movaps xmm1, [rax]
    movaps xmm1, [rax+0x7f]
    movaps xmm1, [rax+0x80]
    movaps xmm1, [rax+rbx*4]
    movaps xmm1, [rbx*8+0x10]
    movaps xmm1, [rip+0x100]
    movaps xmm1, [0x1000]
    movaps xmm1, [r13]
    movaps [rax], xmm1
    movaps [rax+0x7f], xmm1
    movaps [rax+0x80], xmm1
    movaps [rax+rbx*4], xmm1
    movaps [rbx*8+0x10], xmm1
    movaps [rip+0x100], xmm1
    movaps [0x1000], xmm1
    movaps [r13], xmm1
    vmovaps xmm1, [rax]
    vmovaps xmm1, [rax+0x7f]
    vmovaps xmm1, [rax+0x80]
    vmovaps xmm1, [rax+rbx*4]
    vmovaps xmm1, [rbx*8+0x10]
    vmovaps xmm1, [rip+0x100]
    vmovaps xmm1, [0x1000]
    vmovaps xmm1, [r13]
    vmovaps [rax], xmm1
    vmovaps [rax+0x7f], xmm1
    vmovaps [rax+0x80], xmm1
    vmovaps [rax+rbx*4], xmm1
    vmovaps [rbx*8+0x10], xmm1
    vmovaps [rip+0x100], xmm1
    vmovaps [0x1000], xmm1
    vmovaps [r13], xmm1
    vmovaps ymm1, [rax]
    vmovaps ymm1, [rax+0x7f]
    vmovaps ymm1, [rax+0x80]
    vmovaps ymm1, [rax+rbx*4]
    vmovaps ymm1, [rbx*8+0x10]
    vmovaps ymm1, [rip+0x100]
    vmovaps ymm1, [0x1000]
    vmovaps ymm1, [r13]
    vmovaps [rax], ymm1
    vmovaps [rax+0x7f], ymm1
    vmovaps [rax+0x80], ymm1
    vmovaps [rax+rbx*4], ymm1
    vmovaps [rbx*8+0x10], ymm1
    vmovaps [rip+0x100], ymm1
    vmovaps [0x1000], ymm1
    vmovaps [r13], ymm1
    movbe ax, WORD PTR [rax]
    movbe ax, WORD PTR [rax+0x7f]
    movbe ax, WORD PTR [rax+0x80]
    movbe ax, WORD PTR [rax+rbx*4]
    movbe ax, WORD PTR [rbx*8+0x10]
    movbe ax, WORD PTR [rip+0x100]
    movbe ax, WORD PTR [0x1000]
    movbe ax, WORD PTR [r13]
    movbe eax, DWORD PTR [rax]
    movbe eax, DWORD PTR [rax+0x7f]
    movbe eax, DWORD PTR [rax+0x80]
    movbe eax, DWORD PTR [rax+rbx*4]
    movbe eax, DWORD PTR [rbx*8+0x10]
    movbe eax, DWORD PTR [rip+0x100]
    movbe eax, DWORD PTR [0x1000]
    movbe eax, DWORD PTR [r13]
    movbe rax, QWORD PTR [rax]
    movbe rax, QWORD PTR [rax+0x7f]
    movbe rax, QWORD PTR [rax+0x80]
    movbe rax, QWORD PTR [rax+rbx*4]
    movbe rax, QWORD PTR [rbx*8+0x10]
    movbe rax, QWORD PTR [rip+0x100]
    movbe rax, QWORD PTR [0x1000]
    movbe rax, QWORD PTR [r13]
    movbe WORD PTR [rax], ax
    movbe WORD PTR [rax+0x7f], ax
    movbe WORD PTR [rax+0x80], ax
    movbe WORD PTR [rax+rbx*4], ax
    movbe WORD PTR [rbx*8+0x10], ax
    movbe WORD PTR [rip+0x100], ax
    movbe WORD PTR [0x1000], ax
    movbe WORD PTR [r13], ax
    movbe DWORD PTR [rax], eax
    movbe DWORD PTR [rax+0x7f], eax
    movbe DWORD PTR [rax+0x80], eax
    movbe DWORD PTR [rax+rbx*4], eax
    movbe DWORD PTR [rbx*8+0x10], eax
    movbe DWORD PTR [rip+0x100], eax
    movbe DWORD PTR [0x1000], eax
    movbe DWORD PTR [r13], eax
    movbe QWORD PTR [rax], rax
    movbe QWORD PTR [rax+0x7f], rax
    movbe QWORD PTR [rax+0x80], rax
    movbe QWORD PTR [rax+rbx*4], rax
    movbe QWORD PTR [rbx*8+0x10], rax
    movbe QWORD PTR [rip+0x100], rax
    movbe QWORD PTR [0x1000], rax
    movbe QWORD PTR [r13], rax
    movddup xmm1, QWORD PTR [rax]
    movddup xmm1, QWORD PTR [rax+0x7f]
    movddup xmm1, QWORD PTR [rax+0x80]
    movddup xmm1, QWORD PTR [rax+rbx*4]
    movddup xmm1, QWORD PTR [rbx*8+0x10]
    movddup xmm1, QWORD PTR [rip+0x100]
    movddup xmm1, QWORD PTR [0x1000]
    movddup xmm1, QWORD PTR [r13]
    vmovddup xmm1, QWORD PTR [rax]
    vmovddup xmm1, QWORD PTR [rax+0x7f]
    vmovddup xmm1, QWORD PTR [rax+0x80]
    vmovddup xmm1, QWORD PTR [rax+rbx*4]
    vmovddup xmm1, QWORD PTR [rbx*8+0x10]
    vmovddup xmm1, QWORD PTR [rip+0x100]
    vmovddup xmm1, QWORD PTR [0x1000]
    vmovddup xmm1, QWORD PTR [r13]
    vmovddup ymm1, [rax]
    vmovddup ymm1, [rax+0x7f]
    vmovddup ymm1, [rax+0x80]
    vmovddup ymm1, [rax+rbx*4]
    vmovddup ymm1, [rbx*8+0x10]
    vmovddup ymm1, [rip+0x100]
    vmovddup ymm1, [0x1000]
    vmovddup ymm1, [r13]
    movdir64b rax, [rax]
    movdir64b rax, [rax+0x7f]
    movdir64b rax, [rax+0x80]
    movdir64b rax, [rax+rbx*4]
    movdir64b rax, [rbx*8+0x10]
    movdir64b rax, [rip+0x100]
    movdir64b rax, [0x1000]
    movdir64b rax, [r13]
    movdiri DWORD PTR [rax], eax
    movdiri DWORD PTR [rax+0x7f], eax
    movdiri DWORD PTR [rax+0x80], eax
    movdiri DWORD PTR [rax+rbx*4], eax
    movdiri DWORD PTR [rbx*8+0x10], eax
    movdiri DWORD PTR [rip+0x100], eax
    movdiri DWORD PTR [0x1000], eax
    movdiri DWORD PTR [r13], eax
    movdiri QWORD PTR [rax], rax
    movdiri QWORD PTR [rax+0x7f], rax
    movdiri QWORD PTR [rax+0x80], rax
    movdiri QWORD PTR [rax+rbx*4], rax
    movdiri QWORD PTR [rbx*8+0x10], rax
    movdiri QWORD PTR [rip+0x100], rax
    movdiri QWORD PTR [0x1000], rax
    movdiri QWORD PTR [r13], rax
    movd mm0, DWORD PTR [rax]
    movd mm0, DWORD PTR [rax+0x7f]
    movd mm0, DWORD PTR [rax+0x80]
    movd mm0, DWORD PTR [rax+rbx*4]
    movd mm0, DWORD PTR [rbx*8+0x10]
    movd mm0, DWORD PTR [rip+0x100]
    movd mm0, DWORD PTR [0x1000]
    movd mm0, DWORD PTR [r13]
    movq mm0, QWORD PTR [rax]
    movq mm0, QWORD PTR [rax+0x7f]
    movq mm0, QWORD PTR [rax+0x80]
    movq mm0, QWORD PTR [rax+rbx*4]
    movq mm0, QWORD PTR [rbx*8+0x10]
    movq mm0, QWORD PTR [rip+0x100]
    movq mm0, QWORD PTR [0x1000]
    movq mm0, QWORD PTR [r13]
    movd DWORD PTR [rax], mm0
    movd DWORD PTR [rax+0x7f], mm0
    movd DWORD PTR [rax+0x80], mm0
    movd DWORD PTR [rax+rbx*4], mm0
    movd DWORD PTR [rbx*8+0x10], mm0
    movd DWORD PTR [rip+0x100], mm0
    movd DWORD PTR [0x1000], mm0
    movd DWORD PTR [r13], mm0
    movq QWORD PTR [rax], mm0
    movq QWORD PTR [rax+0x7f], mm0
    movq QWORD PTR [rax+0x80], mm0
    movq QWORD PTR [rax+rbx*4], mm0
    movq QWORD PTR [rbx*8+0x10], mm0
    movq QWORD PTR [rip+0x100], mm0
    movq QWORD PTR [0x1000], mm0
    movq QWORD PTR [r13], mm0
    movd xmm0, DWORD PTR [rax]
    movd xmm0, DWORD PTR [rax+0x7f]
    movd xmm0, DWORD PTR [rax+0x80]
    movd xmm0, DWORD PTR [rax+rbx*4]
    movd xmm0, DWORD PTR [rbx*8+0x10]
    movd xmm0, DWORD PTR [rip+0x100]
    movd xmm0, DWORD PTR [0x1000]
    movd xmm0, DWORD PTR [r13]
    movq xmm0, QWORD PTR [rax]
    movq xmm0, QWORD PTR [rax+0x7f]
    movq xmm0, QWORD PTR [rax+0x80]
    movq xmm0, QWORD PTR [rax+rbx*4]
    movq xmm0, QWORD PTR [rbx*8+0x10]
    movq xmm0, QWORD PTR [rip+0x100]
    movq xmm0, QWORD PTR [0x1000]
    movq xmm0, QWORD PTR [r13]
    movd DWORD PTR [rax], xmm0
    movd DWORD PTR [rax+0x7f], xmm0
    movd DWORD PTR [rax+0x80], xmm0
    movd DWORD PTR [rax+rbx*4], xmm0
    movd DWORD PTR [rbx*8+0x10], xmm0
    movd DWORD PTR [rip+0x100], xmm0
    movd DWORD PTR [0x1000], xmm0
    movd DWORD PTR [r13], xmm0
    movq QWORD PTR [rax], xmm0
    movq QWORD PTR [rax+0x7f], xmm0
    movq QWORD PTR [rax+0x80], xmm0
    movq QWORD PTR [rax+rbx*4], xmm0
    movq QWORD PTR [rbx*8+0x10], xmm0
    movq QWORD PTR [rip+0x100], xmm0
    movq QWORD PTR [0x1000], xmm0
    movq QWORD PTR [r13], xmm0
    vmovq xmm1, QWORD PTR [rax]
    vmovq xmm1, QWORD PTR [rax+0x7f]
    vmovq xmm1, QWORD PTR [rax+0x80]
    vmovq xmm1, QWORD PTR [rax+rbx*4]
    vmovq xmm1, QWORD PTR [rbx*8+0x10]
    vmovq xmm1, QWORD PTR [rip+0x100]
    vmovq xmm1, QWORD PTR [0x1000]
    vmovq xmm1, QWORD PTR [r13]
    vmovd DWORD PTR [rax], xmm1
    vmovd DWORD PTR [rax+0x7f], xmm1
    vmovd DWORD PTR [rax+0x80], xmm1
    vmovd DWORD PTR [rax+rbx*4], xmm1
    vmovd DWORD PTR [rbx*8+0x10], xmm1
    vmovd DWORD PTR [rip+0x100], xmm1
    vmovd DWORD PTR [0x1000], xmm1
    vmovd DWORD PTR [r13], xmm1
    vmovq QWORD PTR [rax], xmm1
    vmovq QWORD PTR [rax+0x7f], xmm1
    vmovq QWORD PTR [rax+0x80], xmm1
    vmovq QWORD PTR [rax+rbx*4], xmm1
    vmovq QWORD PTR [rbx*8+0x10], xmm1
    vmovq QWORD PTR [rip+0x100], xmm1
    vmovq QWORD PTR [0x1000], xmm1
    vmovq QWORD PTR [r13], xmm1
    movdqa xmm1, [rax]
    movdqa xmm1, [rax+0x7f]
    movdqa xmm1, [rax+0x80]
    movdqa xmm1, [rax+rbx*4]
    movdqa xmm1, [rbx*8+0x10]
    movdqa xmm1, [rip+0x100]
    movdqa xmm1, [0x1000]
    movdqa xmm1, [r13]
    movdqa [rax], xmm1
    movdqa [rax+0x7f], xmm1
    movdqa [rax+0x80], xmm1
    movdqa [rax+rbx*4], xmm1
    movdqa [rbx*8+0x10], xmm1
    movdqa [rip+0x100], xmm1
    movdqa [0x1000], xmm1
    movdqa [r13], xmm1
    vmovdqa xmm1, [rax]
    vmovdqa xmm1, [rax+0x7f]
    vmovdqa xmm1, [rax+0x80]
    vmovdqa xmm1, [rax+rbx*4]
    vmovdqa xmm1, [rbx*8+0x10]
    vmovdqa xmm1, [rip+0x100]
    vmovdqa xmm1, [0x1000]
    vmovdqa xmm1, [r13]
    vmovdqa [rax], xmm1
    vmovdqa [rax+0x7f], xmm1
    vmovdqa [rax+0x80], xmm1
    vmovdqa [rax+rbx*4], xmm1
    vmovdqa [rbx*8+0x10], xmm1
    vmovdqa [rip+0x100], xmm1
    vmovdqa [0x1000], xmm1
    vmovdqa [r13], xmm1
    vmovdqa ymm1, [rax]
    vmovdqa ymm1, [rax+0x7f]
    vmovdqa ymm1, [rax+0x80]
    vmovdqa ymm1, [rax+rbx*4]
    vmovdqa ymm1, [rbx*8+0x10]
    vmovdqa ymm1, [rip+0x100]
    vmovdqa ymm1, [0x1000]
    vmovdqa ymm1, [r13]
    vmovdqa [rax], ymm1
    vmovdqa [rax+0x7f], ymm1
    vmovdqa [rax+0x80], ymm1
    vmovdqa [rax+rbx*4], ymm1
    vmovdqa [rbx*8+0x10], ymm1
    vmovdqa [rip+0x100], ymm1
    vmovdqa [0x1000], ymm1
    vmovdqa [r13], ymm1
    movdqu xmm1, [rax]
    movdqu xmm1, [rax+0x7f]
    movdqu xmm1, [rax+0x80]
    movdqu xmm1, [rax+rbx*4]
    movdqu xmm1, [rbx*8+0x10]
    movdqu xmm1, [rip+0x100]
    movdqu xmm1, [0x1000]
    movdqu xmm1, [r13]
    movdqu [rax], xmm1
    movdqu [rax+0x7f], xmm1
    movdqu [rax+0x80], xmm1
    movdqu [rax+rbx*4], xmm1
    movdqu [rbx*8+0x10], xmm1
    movdqu [rip+0x100], xmm1
    movdqu [0x1000], xmm1
    movdqu [r13], xmm1
    vmovdqu xmm1, [rax]
    vmovdqu xmm1, [rax+0x7f]
    vmovdqu xmm1, [rax+0x80]
    vmovdqu xmm1, [rax+rbx*4]
    vmovdqu xmm1, [rbx*8+0x10]
    vmovdqu xmm1, [rip+0x100]
    vmovdqu xmm1, [0x1000]
    vmovdqu xmm1, [r13]
    vmovdqu [rax], xmm1
    vmovdqu [rax+0x7f], xmm1
    vmovdqu [rax+0x80], xmm1
    vmovdqu [rax+rbx*4], xmm1
    vmovdqu [rbx*8+0x10], xmm1
    vmovdqu [rip+0x100], xmm1
    vmovdqu [0x1000], xmm1
    vmovdqu [r13], xmm1
    vmovdqu ymm1, [rax]
    vmovdqu ymm1, [rax+0x7f]
    vmovdqu ymm1, [rax+0x80]
    vmovdqu ymm1, [rax+rbx*4]
    vmovdqu ymm1, [rbx*8+0x10]
    vmovdqu ymm1, [rip+0x100]
    vmovdqu ymm1, [0x1000]
    vmovdqu ymm1, [r13]
    vmovdqu [rax], ymm1
    vmovdqu [rax+0x7f], ymm1
    vmovdqu [rax+0x80], ymm1
    vmovdqu [rax+rbx*4], ymm1
    vmovdqu [rbx*8+0x10], ymm1
    vmovdqu [rip+0x100], ymm1
    vmovdqu [0x1000], ymm1
    vmovdqu [r13], ymm1
    movhpd xmm1, QWORD PTR [rax]
    movhpd xmm1, QWORD PTR [rax+0x7f]
    movhpd xmm1, QWORD PTR [rax+0x80]
    movhpd xmm1, QWORD PTR [rax+rbx*4]
    movhpd xmm1, QWORD PTR [rbx*8+0x10]
    movhpd xmm1, QWORD PTR [rip+0x100]
    movhpd xmm1, QWORD PTR [0x1000]
    movhpd xmm1, QWORD PTR [r13]
    vmovhpd xmm2, xmm1, QWORD PTR [rax]
    vmovhpd xmm2, xmm1, QWORD PTR [rax+0x7f]
    vmovhpd xmm2, xmm1, QWORD PTR [rax+0x80]
    vmovhpd xmm2, xmm1, QWORD PTR [rax+rbx*4]
    vmovhpd xmm2, xmm1, QWORD PTR [rbx*8+0x10]
    vmovhpd xmm2, xmm1, QWORD PTR [rip+0x100]
    vmovhpd xmm2, xmm1, QWORD PTR [0x1000]
    vmovhpd xmm2, xmm1, QWORD PTR [r13]
    movhpd QWORD PTR [rax], xmm1
    movhpd QWORD PTR [rax+0x7f], xmm1
    movhpd QWORD PTR [rax+0x80], xmm1
    movhpd QWORD PTR [rax+rbx*4], xmm1
    movhpd QWORD PTR [rbx*8+0x10], xmm1
    movhpd QWORD PTR [rip+0x100], xmm1
    movhpd QWORD PTR [0x1000], xmm1
    movhpd QWORD PTR [r13], xmm1
    vmovhpd QWORD PTR [rax], xmm1
    vmovhpd QWORD PTR [rax+0x7f], xmm1
    vmovhpd QWORD PTR [rax+0x80], xmm1
    vmovhpd QWORD PTR [rax+rbx*4], xmm1
    vmovhpd QWORD PTR [rbx*8+0x10], xmm1
    vmovhpd QWORD PTR [rip+0x100], xmm1
    vmovhpd QWORD PTR [0x1000], xmm1
    vmovhpd QWORD PTR [r13], xmm1
    movhps xmm1, QWORD PTR [rax]
    movhps xmm1, QWORD PTR [rax+0x7f]
    movhps xmm1, QWORD PTR [rax+0x80]
    movhps xmm1, QWORD PTR [rax+rbx*4]
    movhps xmm1, QWORD PTR [rbx*8+0x10]
    movhps xmm1, QWORD PTR [rip+0x100]
    movhps xmm1, QWORD PTR [0x1000]
    movhps xmm1, QWORD PTR [r13]
    vmovhps xmm2, xmm1, QWORD PTR [rax]
    vmovhps xmm2, xmm1, QWORD PTR [rax+0x7f]
    vmovhps xmm2, xmm1, QWORD PTR [rax+0x80]
    vmovhps xmm2, xmm1, QWORD PTR [rax+rbx*4]
    vmovhps xmm2, xmm1, QWORD PTR [rbx*8+0x10]
    vmovhps xmm2, xmm1, QWORD PTR [rip+0x100]
    vmovhps xmm2, xmm1, QWORD PTR [0x1000]
    vmovhps xmm2, xmm1, QWORD PTR [r13]
    movhps QWORD PTR [rax], xmm1
    movhps QWORD PTR [rax+0x7f], xmm1
    movhps QWORD PTR [rax+0x80], xmm1
    movhps QWORD PTR [rax+rbx*4], xmm1
    movhps QWORD PTR [rbx*8+0x10], xmm1
    movhps QWORD PTR [rip+0x100], xmm1
    movhps QWORD PTR [0x1000], xmm1
    movhps QWORD PTR [r13], xmm1
    vmovhps QWORD PTR [rax], xmm1
    vmovhps QWORD PTR [rax+0x7f], xmm1
    vmovhps QWORD PTR [rax+0x80], xmm1
    vmovhps QWORD PTR [rax+rbx*4], xmm1
    vmovhps QWORD PTR [rbx*8+0x10], xmm1
    vmovhps QWORD PTR [rip+0x100], xmm1
    vmovhps QWORD PTR [0x1000], xmm1
    vmovhps QWORD PTR [r13], xmm1
    movlpd xmm1, QWORD PTR [rax]
    movlpd xmm1, QWORD PTR [rax+0x7f]
    movlpd xmm1, QWORD PTR [rax+0x80]
    movlpd xmm1, QWORD PTR [rax+rbx*4]
    movlpd xmm1, QWORD PTR [rbx*8+0x10]
    movlpd xmm1, QWORD PTR [rip+0x100]
    movlpd xmm1, QWORD PTR [0x1000]
    movlpd xmm1, QWORD PTR [r13]
    vmovlpd xmm2, xmm1, QWORD PTR [rax]
    vmovlpd xmm2, xmm1, QWORD PTR [rax+0x7f]
    vmovlpd xmm2, xmm1, QWORD PTR [rax+0x80]
    vmovlpd xmm2, xmm1, QWORD PTR [rax+rbx*4]
    vmovlpd xmm2, xmm1, QWORD PTR [rbx*8+0x10]
    vmovlpd xmm2, xmm1, QWORD PTR [rip+0x100]
    vmovlpd xmm2, xmm1, QWORD PTR [0x1000]
    vmovlpd xmm2, xmm1, QWORD PTR [r13]
    movlpd QWORD PTR [rax], xmm1
    movlpd QWORD PTR [rax+0x7f], xmm1
    movlpd QWORD PTR [rax+0x80], xmm1
    movlpd QWORD PTR [rax+rbx*4], xmm1
    movlpd QWORD PTR [rbx*8+0x10], xmm1
    movlpd QWORD PTR [rip+0x100], xmm1
    movlpd QWORD PTR [0x1000], xmm1
    movlpd QWORD PTR [r13], xmm1
    vmovlpd QWORD PTR [rax], xmm1
    vmovlpd QWORD PTR [rax+0x7f], xmm1
    vmovlpd QWORD PTR [rax+0x80], xmm1
    vmovlpd QWORD PTR [rax+rbx*4], xmm1
    vmovlpd QWORD PTR [rbx*8+0x10], xmm1
    vmovlpd QWORD PTR [rip+0x100], xmm1
    vmovlpd QWORD PTR [0x1000], xmm1
    vmovlpd QWORD PTR [r13], xmm1
    movlps xmm1, QWORD PTR [rax]
    movlps xmm1, QWORD PTR [rax+0x7f]
    movlps xmm1, QWORD PTR [rax+0x80]
    movlps xmm1, QWORD PTR [rax+rbx*4]
    movlps xmm1, QWORD PTR [rbx*8+0x10]
    movlps xmm1, QWORD PTR [rip+0x100]
    movlps xmm1, QWORD PTR [0x1000]
    movlps xmm1, QWORD PTR [r13]
    vmovlps xmm2, xmm1, QWORD PTR [rax]
    vmovlps xmm2, xmm1, QWORD PTR [rax+0x7f]
    vmovlps xmm2, xmm1, QWORD PTR [rax+0x80]
    vmovlps xmm2, xmm1, QWORD PTR [rax+rbx*4]
    vmovlps xmm2, xmm1, QWORD PTR [rbx*8+0x10]
    vmovlps xmm2, xmm1, QWORD PTR [rip+0x100]
    vmovlps xmm2, xmm1, QWORD PTR [0x1000]
    vmovlps xmm2, xmm1, QWORD PTR [r13]
    movlps QWORD PTR [rax], xmm1
    movlps QWORD PTR [rax+0x7f], xmm1
    movlps QWORD PTR [rax+0x80], xmm1
    movlps QWORD PTR [rax+rbx*4], xmm1
    movlps QWORD PTR [rbx*8+0x10], xmm1
    movlps QWORD PTR [rip+0x100], xmm1
    movlps QWORD PTR [0x1000], xmm1
    movlps QWORD PTR [r13], xmm1
    vmovlps QWORD PTR [rax], xmm1
    vmovlps QWORD PTR [rax+0x7f], xmm1
    vmovlps QWORD PTR [rax+0x80], xmm1
    vmovlps QWORD PTR [rax+rbx*4], xmm1
    vmovlps QWORD PTR [rbx*8+0x10], xmm1
    vmovlps QWORD PTR [rip+0x100], xmm1
    vmovlps QWORD PTR [0x1000], xmm1
    vmovlps QWORD PTR [r13], xmm1
    movntdq [rax], xmm1
    movntdq [rax+0x7f], xmm1
    movntdq [rax+0x80], xmm1
    movntdq [rax+rbx*4], xmm1
    movntdq [rbx*8+0x10], xmm1
    movntdq [rip+0x100], xmm1
    movntdq [0x1000], xmm1
    movntdq [r13], xmm1
    vmovntdq [rax], xmm1
    vmovntdq [rax+0x7f], xmm1
    vmovntdq [rax+0x80], xmm1
    vmovntdq [rax+rbx*4], xmm1
    vmovntdq [rbx*8+0x10], xmm1
    vmovntdq [rip+0x100], xmm1
    vmovntdq [0x1000], xmm1
    vmovntdq [r13], xmm1
    vmovntdq [rax], ymm1
    vmovntdq [rax+0x7f], ymm1
    vmovntdq [rax+0x80], ymm1
    vmovntdq [rax+rbx*4], ymm1
    vmovntdq [rbx*8+0x10], ymm1
    vmovntdq [rip+0x100], ymm1
    vmovntdq [0x1000], ymm1
    vmovntdq [r13], ymm1
    movntdqa xmm1, [rax]
    movntdqa xmm1, [rax+0x7f]
    movntdqa xmm1, [rax+0x80]
    movntdqa xmm1, [rax+rbx*4]
    movntdqa xmm1, [rbx*8+0x10]
    movntdqa xmm1, [rip+0x100]
    movntdqa xmm1, [0x1000]
    movntdqa xmm1, [r13]
    vmovntdqa xmm1, [rax]
    vmovntdqa xmm1, [rax+0x7f]
    vmovntdqa xmm1, [rax+0x80]
    vmovntdqa xmm1, [rax+rbx*4]
    vmovntdqa xmm1, [rbx*8+0x10]
    vmovntdqa xmm1, [rip+0x100]
    vmovntdqa xmm1, [0x1000]
    vmovntdqa xmm1, [r13]
    vmovntdqa ymm1, [rax]
    vmovntdqa ymm1, [rax+0x7f]
    vmovntdqa ymm1, [rax+0x80]
    vmovntdqa ymm1, [rax+rbx*4]
    vmovntdqa ymm1, [rbx*8+0x10]
    vmovntdqa ymm1, [rip+0x100]
    vmovntdqa ymm1, [0x1000]
    vmovntdqa ymm1, [r13]
    movnti DWORD PTR [rax], eax
    movnti DWORD PTR [rax+0x7f], eax
    movnti DWORD PTR [rax+0x80], eax
    movnti DWORD PTR [rax+rbx*4], eax
    movnti DWORD PTR [rbx*8+0x10], eax
    movnti DWORD PTR [rip+0x100], eax
    movnti DWORD PTR [0x1000], eax
    movnti DWORD PTR [r13], eax
    movnti QWORD PTR [rax], rax
    movnti QWORD PTR [rax+0x7f], rax
    movnti QWORD PTR [rax+0x80], rax
    movnti QWORD PTR [rax+rbx*4], rax
    movnti QWORD PTR [rbx*8+0x10], rax
    movnti QWORD PTR [rip+0x100], rax
    movnti QWORD PTR [0x1000], rax
    movnti QWORD PTR [r13], rax
    movntpd [rax], xmm1
    movntpd [rax+0x7f], xmm1
    movntpd [rax+0x80], xmm1
    movntpd [rax+rbx*4], xmm1
    movntpd [rbx*8+0x10], xmm1
    movntpd [rip+0x100], xmm1
    movntpd [0x1000], xmm1
    movntpd [r13], xmm1
    vmovntpd [rax], xmm1
    vmovntpd [rax+0x7f], xmm1
    vmovntpd [rax+0x80], xmm1
    vmovntpd [rax+rbx*4], xmm1
    vmovntpd [rbx*8+0x10], xmm1
    vmovntpd [rip+0x100], xmm1
    vmovntpd [0x1000], xmm1
    vmovntpd [r13], xmm1
    vmovntpd [rax], ymm1
    vmovntpd [rax+0x7f], ymm1
    vmovntpd [rax+0x80], ymm1
    vmovntpd [rax+rbx*4], ymm1
    vmovntpd [rbx*8+0x10], ymm1
    vmovntpd [rip+0x100], ymm1
    vmovntpd [0x1000], ymm1
    vmovntpd [r13], ymm1
    movntps [rax], xmm1
    movntps [rax+0x7f], xmm1
    movntps [rax+0x80], xmm1
    movntps [rax+rbx*4], xmm1
    movntps [rbx*8+0x10], xmm1
    movntps [rip+0x100], xmm1
    movntps [0x1000], xmm1
    movntps [r13], xmm1
    vmovntps [rax], xmm1
    vmovntps [rax+0x7f], xmm1
    vmovntps [rax+0x80], xmm1
    vmovntps [rax+rbx*4], xmm1
    vmovntps [rbx*8+0x10], xmm1
    vmovntps [rip+0x100], xmm1
    vmovntps [0x1000], xmm1
    vmovntps [r13], xmm1
    vmovntps [rax], ymm1
    vmovntps [rax+0x7f], ymm1
    vmovntps [rax+0x80], ymm1
    vmovntps [rax+rbx*4], ymm1
    vmovntps [rbx*8+0x10], ymm1
    vmovntps [rip+0x100], ymm1
    vmovntps [0x1000], ymm1
    vmovntps [r13], ymm1
    movntq QWORD PTR [rax], mm0
    movntq QWORD PTR [rax+0x7f], mm0
    movntq QWORD PTR [rax+0x80], mm0
    movntq QWORD PTR [rax+rbx*4], mm0
    movntq QWORD PTR [rbx*8+0x10], mm0
    movntq QWORD PTR [rip+0x100], mm0
    movntq QWORD PTR [0x1000], mm0
    movntq QWORD PTR [r13], mm0
    movq xmm1, QWORD PTR [rax]
    movq xmm1, QWORD PTR [rax+0x7f]
    movq xmm1, QWORD PTR [rax+0x80]
    movq xmm1, QWORD PTR [rax+rbx*4]
    movq xmm1, QWORD PTR [rbx*8+0x10]
    movq xmm1, QWORD PTR [rip+0x100]
    movq xmm1, QWORD PTR [0x1000]
    movq xmm1, QWORD PTR [r13]
    movq QWORD PTR [rax], xmm1
    movq QWORD PTR [rax+0x7f], xmm1
    movq QWORD PTR [rax+0x80], xmm1
    movq QWORD PTR [rax+rbx*4], xmm1
    movq QWORD PTR [rbx*8+0x10], xmm1
    movq QWORD PTR [rip+0x100], xmm1
    movq QWORD PTR [0x1000], xmm1
    movq QWORD PTR [r13], xmm1
    vmovq QWORD PTR [rax], xmm2
    vmovq QWORD PTR [rax+0x7f], xmm2
    vmovq QWORD PTR [rax+0x80], xmm2
    vmovq QWORD PTR [rax+rbx*4], xmm2
    vmovq QWORD PTR [rbx*8+0x10], xmm2
    vmovq QWORD PTR [rip+0x100], xmm2
    vmovq QWORD PTR [0x1000], xmm2
    vmovq QWORD PTR [r13], xmm2
    movs BYTE PTR [rax], BYTE PTR [rax]
    movs BYTE PTR [rax+0x7f], BYTE PTR [rax]
    movs BYTE PTR [rax+0x80], BYTE PTR [rax]
    movs BYTE PTR [rax+rbx*4], BYTE PTR [rax]
    movs BYTE PTR [rbx*8+0x10], BYTE PTR [rax]
    movs BYTE PTR [rip+0x100], BYTE PTR [rax]
    movs BYTE PTR [0x1000], BYTE PTR [rax]
    movs BYTE PTR [r13], BYTE PTR [rax]
    movs WORD PTR [rax], WORD PTR [rax]
    movs WORD PTR [rax+0x7f], WORD PTR [rax]
    movs WORD PTR [rax+0x80], WORD PTR [rax]
    movs WORD PTR [rax+rbx*4], WORD PTR [rax]
    movs WORD PTR [rbx*8+0x10], WORD PTR [rax]
    movs WORD PTR [rip+0x100], WORD PTR [rax]
    movs WORD PTR [0x1000], WORD PTR [rax]
    movs WORD PTR [r13], WORD PTR [rax]
    movs DWORD PTR [rax], DWORD PTR [rax]
    movs DWORD PTR [rax+0x7f], DWORD PTR [rax]
    movs DWORD PTR [rax+0x80], DWORD PTR [rax]
    movs DWORD PTR [rax+rbx*4], DWORD PTR [rax]
    movs DWORD PTR [rbx*8+0x10], DWORD PTR [rax]
    movs DWORD PTR [rip+0x100], DWORD PTR [rax]
    movs DWORD PTR [0x1000], DWORD PTR [rax]
    movs DWORD PTR [r13], DWORD PTR [rax]
    movs QWORD PTR [rax], QWORD PTR [rax]
    movs QWORD PTR [rax+0x7f], QWORD PTR [rax]
    movs QWORD PTR [rax+0x80], QWORD PTR [rax]
    movs QWORD PTR [rax+rbx*4], QWORD PTR [rax]
    movs QWORD PTR [rbx*8+0x10], QWORD PTR [rax]
    movs QWORD PTR [rip+0x100], QWORD PTR [rax]
    movs QWORD PTR [0x1000], QWORD PTR [rax]
    movs QWORD PTR [r13], QWORD PTR [rax]
    movsd xmm1, QWORD PTR [rax]
    movsd xmm1, QWORD PTR [rax+0x7f]
    movsd xmm1, QWORD PTR [rax+0x80]
    movsd xmm1, QWORD PTR [rax+rbx*4]
    movsd xmm1, QWORD PTR [rbx*8+0x10]
    movsd xmm1, QWORD PTR [rip+0x100]
    movsd xmm1, QWORD PTR [0x1000]
    movsd xmm1, QWORD PTR [r13]
    movsd QWORD PTR [rax], xmm2
    movsd QWORD PTR [rax+0x7f], xmm2
    movsd QWORD PTR [rax+0x80], xmm2
    movsd QWORD PTR [rax+rbx*4], xmm2
    movsd QWORD PTR [rbx*8+0x10], xmm2
    movsd QWORD PTR [rip+0x100], xmm2
    movsd QWORD PTR [0x1000], xmm2
    movsd QWORD PTR [r13], xmm2
    vmovsd xmm1, QWORD PTR [rax]
    vmovsd xmm1, QWORD PTR [rax+0x7f]
    vmovsd xmm1, QWORD PTR [rax+0x80]
    vmovsd xmm1, QWORD PTR [rax+rbx*4]
    vmovsd xmm1, QWORD PTR [rbx*8+0x10]
    vmovsd xmm1, QWORD PTR [rip+0x100]
    vmovsd xmm1, QWORD PTR [0x1000]
    vmovsd xmm1, QWORD PTR [r13]
    vmovsd QWORD PTR [rax], xmm1
    vmovsd QWORD PTR [rax+0x7f], xmm1
    vmovsd QWORD PTR [rax+0x80], xmm1
    vmovsd QWORD PTR [rax+rbx*4], xmm1
    vmovsd QWORD PTR [rbx*8+0x10], xmm1
    vmovsd QWORD PTR [rip+0x100], xmm1
    vmovsd QWORD PTR [0x1000], xmm1
    vmovsd QWORD PTR [r13], xmm1
    movshdup xmm1, [rax]
    movshdup xmm1, [rax+0x7f]
    movshdup xmm1, [rax+0x80]
    movshdup xmm1, [rax+rbx*4]
    movshdup xmm1, [rbx*8+0x10]
    movshdup xmm1, [rip+0x100]
    movshdup xmm1, [0x1000]
    movshdup xmm1, [r13]
    vmovshdup xmm1, [rax]
    vmovshdup xmm1, [rax+0x7f]
    vmovshdup xmm1, [rax+0x80]
    vmovshdup xmm1, [rax+rbx*4]
    vmovshdup xmm1, [rbx*8+0x10]
    vmovshdup xmm1, [rip+0x100]
    vmovshdup xmm1, [0x1000]
    vmovshdup xmm1, [r13]
    vmovshdup ymm1, [rax]
    vmovshdup ymm1, [rax+0x7f]
    vmovshdup ymm1, [rax+0x80]
    vmovshdup ymm1, [rax+rbx*4]
    vmovshdup ymm1, [rbx*8+0x10]
    vmovshdup ymm1, [rip+0x100]
    vmovshdup ymm1, [0x1000]
    vmovshdup ymm1, [r13]
    movsldup xmm1, [rax]
    movsldup xmm1, [rax+0x7f]
    movsldup xmm1, [rax+0x80]
    movsldup xmm1, [rax+rbx*4]
    movsldup xmm1, [rbx*8+0x10]
    movsldup xmm1, [rip+0x100]
    movsldup xmm1, [0x1000]
    movsldup xmm1, [r13]
    vmovsldup xmm1, [rax]
    vmovsldup xmm1, [rax+0x7f]
    vmovsldup xmm1, [rax+0x80]
    vmovsldup xmm1, [rax+rbx*4]
    vmovsldup xmm1, [rbx*8+0x10]
    vmovsldup xmm1, [rip+0x100]
    vmovsldup xmm1, [0x1000]
    vmovsldup xmm1, [r13]
    vmovsldup ymm1, [rax]
    vmovsldup ymm1, [rax+0x7f]
    vmovsldup ymm1, [rax+0x80]
    vmovsldup ymm1, [rax+rbx*4]
    vmovsldup ymm1, [rbx*8+0x10]
    vmovsldup ymm1, [rip+0x100]
    vmovsldup ymm1, [0x1000]
    vmovsldup ymm1, [r13]
    movss xmm1, DWORD PTR [rax]
    movss xmm1, DWORD PTR [rax+0x7f]
    movss xmm1, DWORD PTR [rax+0x80]
    movss xmm1, DWORD PTR [rax+rbx*4]
    movss xmm1, DWORD PTR [rbx*8+0x10]
    movss xmm1, DWORD PTR [rip+0x100]
    movss xmm1, DWORD PTR [0x1000]
    movss xmm1, DWORD PTR [r13]
    vmovss xmm1, DWORD PTR [rax]
    vmovss xmm1, DWORD PTR [rax+0x7f]
    vmovss xmm1, DWORD PTR [rax+0x80]
    vmovss xmm1, DWORD PTR [rax+rbx*4]
    vmovss xmm1, DWORD PTR [rbx*8+0x10]
    vmovss xmm1, DWORD PTR [rip+0x100]
    vmovss xmm1, DWORD PTR [0x1000]
    vmovss xmm1, DWORD PTR [r13]
    movss DWORD PTR [rax], xmm1
    movss DWORD PTR [rax+0x7f], xmm1
    movss DWORD PTR [rax+0x80], xmm1
    movss DWORD PTR [rax+rbx*4], xmm1
    movss DWORD PTR [rbx*8+0x10], xmm1
    movss DWORD PTR [rip+0x100], xmm1
    movss DWORD PTR [0x1000], xmm1
    movss DWORD PTR [r13], xmm1
    vmovss DWORD PTR [rax], xmm1
    vmovss DWORD PTR [rax+0x7f], xmm1
    vmovss DWORD PTR [rax+0x80], xmm1
    vmovss DWORD PTR [rax+rbx*4], xmm1
    vmovss DWORD PTR [rbx*8+0x10], xmm1
    vmovss DWORD PTR [rip+0x100], xmm1
    vmovss DWORD PTR [0x1000], xmm1
    vmovss DWORD PTR [r13], xmm1
    movsx ax, BYTE PTR [rax]
    movsx ax, BYTE PTR [rax+0x7f]
    movsx ax, BYTE PTR [rax+0x80]
    movsx ax, BYTE PTR [rax+rbx*4]
    movsx ax, BYTE PTR [rbx*8+0x10]
    movsx ax, BYTE PTR [rip+0x100]
    movsx ax, BYTE PTR [0x1000]
    movsx ax, BYTE PTR [r13]
    movsx eax, BYTE PTR [rax]
    movsx eax, BYTE PTR [rax+0x7f]
    movsx eax, BYTE PTR [rax+0x80]
    movsx eax, BYTE PTR [rax+rbx*4]
    movsx eax, BYTE PTR [rbx*8+0x10]
    movsx eax, BYTE PTR [rip+0x100]
    movsx eax, BYTE PTR [0x1000]
    movsx eax, BYTE PTR [r13]
    movsx rax, BYTE PTR [rax]
    movsx rax, BYTE PTR [rax+0x7f]
    movsx rax, BYTE PTR [rax+0x80]
    movsx rax, BYTE PTR [rax+rbx*4]
    movsx rax, BYTE PTR [rbx*8+0x10]
    movsx rax, BYTE PTR [rip+0x100]
    movsx rax, BYTE PTR [0x1000]
    movsx rax, BYTE PTR [r13]
    movsx eax, WORD PTR [rax]
    movsx eax, WORD PTR [rax+0x7f]
    movsx eax, WORD PTR [rax+0x80]
    movsx eax, WORD PTR [rax+rbx*4]
    movsx eax, WORD PTR [rbx*8+0x10]
    movsx eax, WORD PTR [rip+0x100]
    movsx eax, WORD PTR [0x1000]
    movsx eax, WORD PTR [r13]
    movsx rax, WORD PTR [rax]
    movsx rax, WORD PTR [rax+0x7f]
    movsx rax, WORD PTR [rax+0x80]
    movsx rax, WORD PTR [rax+rbx*4]
    movsx rax, WORD PTR [rbx*8+0x10]
    movsx rax, WORD PTR [rip+0x100]
    movsx rax, WORD PTR [0x1000]
    movsx rax, WORD PTR [r13]
    movsxd ax, WORD PTR [rax]
    movsxd ax, WORD PTR [rax+0x7f]
    movsxd ax, WORD PTR [rax+0x80]
    movsxd ax, WORD PTR [rax+rbx*4]
    movsxd ax, WORD PTR [rbx*8+0x10]
    movsxd ax, WORD PTR [rip+0x100]
    movsxd ax, WORD PTR [0x1000]
    movsxd ax, WORD PTR [r13]
    movsxd eax, DWORD PTR [rax]
    movsxd eax, DWORD PTR [rax+0x7f]
    movsxd eax, DWORD PTR [rax+0x80]
    movsxd eax, DWORD PTR [rax+rbx*4]
    movsxd eax, DWORD PTR [rbx*8+0x10]
    movsxd eax, DWORD PTR [rip+0x100]
    movsxd eax, DWORD PTR [0x1000]
    movsxd eax, DWORD PTR [r13]
    movsxd rax, DWORD PTR [rax]
    movsxd rax, DWORD PTR [rax+0x7f]
    movsxd rax, DWORD PTR [rax+0x80]
    movsxd rax, DWORD PTR [rax+rbx*4]
    movsxd rax, DWORD PTR [rbx*8+0x10]
    movsxd rax, DWORD PTR [rip+0x100]
    movsxd rax, DWORD PTR [0x1000]
    movsxd rax, DWORD PTR [r13]
    movupd xmm1, [rax]
    movupd xmm1, [rax+0x7f]
    movupd xmm1, [rax+0x80]
    movupd xmm1, [rax+rbx*4]
    movupd xmm1, [rbx*8+0x10]
    movupd xmm1, [rip+0x100]
    movupd xmm1, [0x1000]
    movupd xmm1, [r13]
    movupd [rax], xmm1
    movupd [rax+0x7f], xmm1
    movupd [rax+0x80], xmm1
    movupd [rax+rbx*4], xmm1
    movupd [rbx*8+0x10], xmm1
    movupd [rip+0x100], xmm1
    movupd [0x1000], xmm1
    movupd [r13], xmm1
    vmovupd xmm1, [rax]
    vmovupd xmm1, [rax+0x7f]
    vmovupd xmm1, [rax+0x80]
    vmovupd xmm1, [rax+rbx*4]
    vmovupd xmm1, [rbx*8+0x10]
    vmovupd xmm1, [rip+0x100]
    vmovupd xmm1, [0x1000]
    vmovupd xmm1, [r13]
    vmovupd [rax], xmm1
    vmovupd [rax+0x7f], xmm1
    vmovupd [rax+0x80], xmm1
    vmovupd [rax+rbx*4], xmm1
    vmovupd [rbx*8+0x10], xmm1
    vmovupd [rip+0x100], xmm1
    vmovupd [0x1000], xmm1
    vmovupd [r13], xmm1
    vmovupd ymm1, [rax]
    vmovupd ymm1, [rax+0x7f]
    vmovupd ymm1, [rax+0x80]
    vmovupd ymm1, [rax+rbx*4]
    vmovupd ymm1, [rbx*8+0x10]
    vmovupd ymm1, [rip+0x100]
    vmovupd ymm1, [0x1000]
    vmovupd ymm1, [r13]
    vmovupd [rax], ymm1
    vmovupd [rax+0x7f], ymm1
    vmovupd [rax+0x80], ymm1
    vmovupd [rax+rbx*4], ymm1
    vmovupd [rbx*8+0x10], ymm1
    vmovupd [rip+0x100], ymm1
    vmovupd [0x1000], ymm1
    vmovupd [r13], ymm1
    movups xmm1, [rax]
    movups xmm1, [rax+0x7f]
    movups xmm1, [rax+0x80]
    movups xmm1, [rax+rbx*4]
    movups xmm1, [rbx*8+0x10]
    movups xmm1, [rip+0x100]
    movups xmm1, [0x1000]
    movups xmm1, [r13]
    movups [rax], xmm1
    movups [rax+0x7f], xmm1
    movups [rax+0x80], xmm1
    movups [rax+rbx*4], xmm1
    movups [rbx*8+0x10], xmm1
    movups [rip+0x100], xmm1
    movups [0x1000], xmm1
    movups [r13], xmm1
    vmovups xmm1, [rax]
    vmovups xmm1, [rax+0x7f]
    vmovups xmm1, [rax+0x80]
    vmovups xmm1, [rax+rbx*4]
    vmovups xmm1, [rbx*8+0x10]
    vmovups xmm1, [rip+0x100]
    vmovups xmm1, [0x1000]
    vmovups xmm1, [r13]
    vmovups [rax], xmm1
    vmovups [rax+0x7f], xmm1
    vmovups [rax+0x80], xmm1
    vmovups [rax+rbx*4], xmm1
    vmovups [rbx*8+0x10], xmm1
    vmovups [rip+0x100], xmm1
    vmovups [0x1000], xmm1
    vmovups [r13], xmm1
    vmovups ymm1, [rax]
    vmovups ymm1, [rax+0x7f]
    vmovups ymm1, [rax+0x80]
    vmovups ymm1, [rax+rbx*4]
    vmovups ymm1, [rbx*8+0x10]
    vmovups ymm1, [rip+0x100]
    vmovups ymm1, [0x1000]
    vmovups ymm1, [r13]
    vmovups [rax], ymm1
    vmovups [rax+0x7f], ymm1
    vmovups [rax+0x80], ymm1
    vmovups [rax+rbx*4], ymm1
    vmovups [rbx*8+0x10], ymm1
    vmovups [rip+0x100], ymm1
    vmovups [0x1000], ymm1
    vmovups [r13], ymm1
    movzx ax, BYTE PTR [rax]
    movzx ax, BYTE PTR [rax+0x7f]
    movzx ax, BYTE PTR [rax+0x80]
    movzx ax, BYTE PTR [rax+rbx*4]
    movzx ax, BYTE PTR [rbx*8+0x10]
    movzx ax, BYTE PTR [rip+0x100]
    movzx ax, BYTE PTR [0x1000]
    movzx ax, BYTE PTR [r13]
    movzx eax, BYTE PTR [rax]
    movzx eax, BYTE PTR [rax+0x7f]
    movzx eax, BYTE PTR [rax+0x80]
    movzx eax, BYTE PTR [rax+rbx*4]
    movzx eax, BYTE PTR [rbx*8+0x10]
    movzx eax, BYTE PTR [rip+0x100]
    movzx eax, BYTE PTR [0x1000]
    movzx eax, BYTE PTR [r13]
    movzx rax, BYTE PTR [rax]
    movzx rax, BYTE PTR [rax+0x7f]
    movzx rax, BYTE PTR [rax+0x80]
    movzx rax, BYTE PTR [rax+rbx*4]
    movzx rax, BYTE PTR [rbx*8+0x10]
    movzx rax, BYTE PTR [rip+0x100]
    movzx rax, BYTE PTR [0x1000]
    movzx rax, BYTE PTR [r13]
    movzx eax, WORD PTR [rax]
    movzx eax, WORD PTR [rax+0x7f]
    movzx eax, WORD PTR [rax+0x80]
    movzx eax, WORD PTR [rax+rbx*4]
    movzx eax, WORD PTR [rbx*8+0x10]
    movzx eax, WORD PTR [rip+0x100]
    movzx eax, WORD PTR [0x1000]
    movzx eax, WORD PTR [r13]
    movzx rax, WORD PTR [rax]
    movzx rax, WORD PTR [rax+0x7f]
    movzx rax, WORD PTR [rax+0x80]
    movzx rax, WORD PTR [rax+rbx*4]
    movzx rax, WORD PTR [rbx*8+0x10]
    movzx rax, WORD PTR [rip+0x100]
    movzx rax, WORD PTR [0x1000]
    movzx rax, WORD PTR [r13]
    mpsadbw xmm1, [rax], 0x1
    mpsadbw xmm1, [rax+0x7f], 0x1
    mpsadbw xmm1, [rax+0x80], 0x1
    mpsadbw xmm1, [rax+rbx*4], 0x1
    mpsadbw xmm1, [rbx*8+0x10], 0x1
    mpsadbw xmm1, [rip+0x100], 0x1
    mpsadbw xmm1, [0x1000], 0x1
    mpsadbw xmm1, [r13], 0x1
    vmpsadbw xmm1, xmm2, [rax], 0x1
    vmpsadbw xmm1, xmm2, [rax+0x7f], 0x1
    vmpsadbw xmm1, xmm2, [rax+0x80], 0x1
    vmpsadbw xmm1, xmm2, [rax+rbx*4], 0x1
    vmpsadbw xmm1, xmm2, [rbx*8+0x10], 0x1
    vmpsadbw xmm1, xmm2, [rip+0x100], 0x1
    vmpsadbw xmm1, xmm2, [0x1000], 0x1
    vmpsadbw xmm1, xmm2, [r13], 0x1
    vmpsadbw ymm1, ymm2, [rax], 0x1
    vmpsadbw ymm1, ymm2, [rax+0x7f], 0x1
    vmpsadbw ymm1, ymm2, [rax+0x80], 0x1
    vmpsadbw ymm1, ymm2, [rax+rbx*4], 0x1
    vmpsadbw ymm1, ymm2, [rbx*8+0x10], 0x1
    vmpsadbw ymm1, ymm2, [rip+0x100], 0x1
    vmpsadbw ymm1, ymm2, [0x1000], 0x1
    vmpsadbw ymm1, ymm2, [r13], 0x1
    mul BYTE PTR [rax]
    mul BYTE PTR [rax+0x7f]
    mul BYTE PTR [rax+0x80]
    mul BYTE PTR [rax+rbx*4]
    mul BYTE PTR [rbx*8+0x10]
    mul BYTE PTR [rip+0x100]
    mul BYTE PTR [0x1000]
    mul BYTE PTR [r13]
    mul WORD PTR [rax]
    mul WORD PTR [rax+0x7f]
    mul WORD PTR [rax+0x80]
    mul WORD PTR [rax+rbx*4]
    mul WORD PTR [rbx*8+0x10]
    mul WORD PTR [rip+0x100]
    mul WORD PTR [0x1000]
    mul WORD PTR [r13]
    mul DWORD PTR [rax]
    mul DWORD PTR [rax+0x7f]
    mul DWORD PTR [rax+0x80]
    mul DWORD PTR [rax+rbx*4]
    mul DWORD PTR [rbx*8+0x10]
    mul DWORD PTR [rip+0x100]
    mul DWORD PTR [0x1000]
    mul DWORD PTR [r13]
    mul QWORD PTR [rax]
    mul QWORD PTR [rax+0x7f]
    mul QWORD PTR [rax+0x80]
    mul QWORD PTR [rax+rbx*4]
    mul QWORD PTR [rbx*8+0x10]
    mul QWORD PTR [rip+0x100]
    mul QWORD PTR [0x1000]
    mul QWORD PTR [r13]
    mulpd xmm1, [rax]
    mulpd xmm1, [rax+0x7f]
    mulpd xmm1, [rax+0x80]
    mulpd xmm1, [rax+rbx*4]
    mulpd xmm1, [rbx*8+0x10]
    mulpd xmm1, [rip+0x100]
    mulpd xmm1, [0x1000]
    mulpd xmm1, [r13]
    vmulpd xmm1, xmm2, [rax]
    vmulpd xmm1, xmm2, [rax+0x7f]
    vmulpd xmm1, xmm2, [rax+0x80]
    vmulpd xmm1, xmm2, [rax+rbx*4]
    vmulpd xmm1, xmm2, [rbx*8+0x10]
    vmulpd xmm1, xmm2, [rip+0x100]
    vmulpd xmm1, xmm2, [0x1000]
    vmulpd xmm1, xmm2, [r13]
    vmulpd ymm1, ymm2, [rax]
    vmulpd ymm1, ymm2, [rax+0x7f]
    vmulpd ymm1, ymm2, [rax+0x80]
    vmulpd ymm1, ymm2, [rax+rbx*4]
    vmulpd ymm1, ymm2, [rbx*8+0x10]
    vmulpd ymm1, ymm2, [rip+0x100]
    vmulpd ymm1, ymm2, [0x1000]
    vmulpd ymm1, ymm2, [r13]
    mulps xmm1, [rax]
    mulps xmm1, [rax+0x7f]
    mulps xmm1, [rax+0x80]
    mulps xmm1, [rax+rbx*4]
    mulps xmm1, [rbx*8+0x10]
    mulps xmm1, [rip+0x100]
    mulps xmm1, [0x1000]
    mulps xmm1, [r13]
    vmulps xmm1, xmm2, [rax]
    vmulps xmm1, xmm2, [rax+0x7f]
    vmulps xmm1, xmm2, [rax+0x80]
    vmulps xmm1, xmm2, [rax+rbx*4]
    vmulps xmm1, xmm2, [rbx*8+0x10]
    vmulps xmm1, xmm2, [rip+0x100]
    vmulps xmm1, xmm2, [0x1000]
    vmulps xmm1, xmm2, [r13]
    vmulps ymm1, ymm2, [rax]
    vmulps ymm1, ymm2, [rax+0x7f]
    vmulps ymm1, ymm2, [rax+0x80]
    vmulps ymm1, ymm2, [rax+rbx*4]
    vmulps ymm1, ymm2, [rbx*8+0x10]
    vmulps ymm1, ymm2, [rip+0x100]
    vmulps ymm1, ymm2, [0x1000]
    vmulps ymm1, ymm2, [r13]
    mulsd xmm1, QWORD PTR [rax]
    mulsd xmm1, QWORD PTR [rax+0x7f]
    mulsd xmm1, QWORD PTR [rax+0x80]
    mulsd xmm1, QWORD PTR [rax+rbx*4]
    mulsd xmm1, QWORD PTR [rbx*8+0x10]
    mulsd xmm1, QWORD PTR [rip+0x100]
    mulsd xmm1, QWORD PTR [0x1000]
    mulsd xmm1, QWORD PTR [r13]
    vmulsd xmm1, xmm2, QWORD PTR [rax]
    vmulsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vmulsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vmulsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vmulsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vmulsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vmulsd xmm1, xmm2, QWORD PTR [0x1000]
    vmulsd xmm1, xmm2, QWORD PTR [r13]
    mulss xmm1, DWORD PTR [rax]
    mulss xmm1, DWORD PTR [rax+0x7f]
    mulss xmm1, DWORD PTR [rax+0x80]
    mulss xmm1, DWORD PTR [rax+rbx*4]
    mulss xmm1, DWORD PTR [rbx*8+0x10]
    mulss xmm1, DWORD PTR [rip+0x100]
    mulss xmm1, DWORD PTR [0x1000]
    mulss xmm1, DWORD PTR [r13]
    vmulss xmm1, xmm2, DWORD PTR [rax]
    vmulss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vmulss xmm1, xmm2, DWORD PTR [rax+0x80]
    vmulss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vmulss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vmulss xmm1, xmm2, DWORD PTR [rip+0x100]
    vmulss xmm1, xmm2, DWORD PTR [0x1000]
    vmulss xmm1, xmm2, DWORD PTR [r13]
    mulx eax, eax, DWORD PTR [rax]
    mulx eax, eax, DWORD PTR [rax+0x7f]
    mulx eax, eax, DWORD PTR [rax+0x80]
    mulx eax, eax, DWORD PTR [rax+rbx*4]
    mulx eax, eax, DWORD PTR [rbx*8+0x10]
    mulx eax, eax, DWORD PTR [rip+0x100]
    mulx eax, eax, DWORD PTR [0x1000]
    mulx eax, eax, DWORD PTR [r13]
    mulx rax, rax, QWORD PTR [rax]
    mulx rax, rax, QWORD PTR [rax+0x7f]
    mulx rax, rax, QWORD PTR [rax+0x80]
    mulx rax, rax, QWORD PTR [rax+rbx*4]
    mulx rax, rax, QWORD PTR [rbx*8+0x10]
    mulx rax, rax, QWORD PTR [rip+0x100]
    mulx rax, rax, QWORD PTR [0x1000]
    mulx rax, rax, QWORD PTR [r13]
    neg BYTE PTR [rax]
    neg BYTE PTR [rax+0x7f]
    neg BYTE PTR [rax+0x80]
    neg BYTE PTR [rax+rbx*4]
    neg BYTE PTR [rbx*8+0x10]
    neg BYTE PTR [rip+0x100]
    neg BYTE PTR [0x1000]
    neg BYTE PTR [r13]
    neg WORD PTR [rax]
    neg WORD PTR [rax+0x7f]
    neg WORD PTR [rax+0x80]
    neg WORD PTR [rax+rbx*4]
    neg WORD PTR [rbx*8+0x10]
    neg WORD PTR [rip+0x100]
    neg WORD PTR [0x1000]
    neg WORD PTR [r13]
    neg DWORD PTR [rax]
    neg DWORD PTR [rax+0x7f]
    neg DWORD PTR [rax+0x80]
    neg DWORD PTR [rax+rbx*4]
    neg DWORD PTR [rbx*8+0x10]
    neg DWORD PTR [rip+0x100]
    neg DWORD PTR [0x1000]
    neg DWORD PTR [r13]
    neg QWORD PTR [rax]
    neg QWORD PTR [rax+0x7f]
    neg QWORD PTR [rax+0x80]
    neg QWORD PTR [rax+rbx*4]
    neg QWORD PTR [rbx*8+0x10]
    neg QWORD PTR [rip+0x100]
    neg QWORD PTR [0x1000]
    neg QWORD PTR [r13]
    nop WORD PTR [rax]
    nop WORD PTR [rax+0x7f]
    nop WORD PTR [rax+0x80]
    nop WORD PTR [rax+rbx*4]
    nop WORD PTR [rbx*8+0x10]
    nop WORD PTR [rip+0x100]
    nop WORD PTR [0x1000]
    nop WORD PTR [r13]
    nop DWORD PTR [rax]
    nop DWORD PTR [rax+0x7f]
    nop DWORD PTR [rax+0x80]
    nop DWORD PTR [rax+rbx*4]
    nop DWORD PTR [rbx*8+0x10]
    nop DWORD PTR [rip+0x100]
    nop DWORD PTR [0x1000]
    nop DWORD PTR [r13]
    not BYTE PTR [rax]
    not BYTE PTR [rax+0x7f]
    not BYTE PTR [rax+0x80]
    not BYTE PTR [rax+rbx*4]
    not BYTE PTR [rbx*8+0x10]
    not BYTE PTR [rip+0x100]
    not BYTE PTR [0x1000]
    not BYTE PTR [r13]
    not WORD PTR [rax]
    not WORD PTR [rax+0x7f]
    not WORD PTR [rax+0x80]
    not WORD PTR [rax+rbx*4]
    not WORD PTR [rbx*8+0x10]
    not WORD PTR [rip+0x100]
    not WORD PTR [0x1000]
    not WORD PTR [r13]
    not DWORD PTR [rax]
    not DWORD PTR [rax+0x7f]
    not DWORD PTR [rax+0x80]
    not DWORD PTR [rax+rbx*4]
    not DWORD PTR [rbx*8+0x10]
    not DWORD PTR [rip+0x100]
    not DWORD PTR [0x1000]
    not DWORD PTR [r13]
    not QWORD PTR [rax]
    not QWORD PTR [rax+0x7f]
    not QWORD PTR [rax+0x80]
    not QWORD PTR [rax+rbx*4]
    not QWORD PTR [rbx*8+0x10]
    not QWORD PTR [rip+0x100]
    not QWORD PTR [0x1000]
    not QWORD PTR [r13]
    or BYTE PTR [rax], 0x1
    or BYTE PTR [rax+0x7f], 0x1
    or BYTE PTR [rax+0x80], 0x1
    or BYTE PTR [rax+rbx*4], 0x1
    or BYTE PTR [rbx*8+0x10], 0x1
    or BYTE PTR [rip+0x100], 0x1
    or BYTE PTR [0x1000], 0x1
    or BYTE PTR [r13], 0x1
    or WORD PTR [rax], 0x1
    or WORD PTR [rax+0x7f], 0x1
    or WORD PTR [rax+0x80], 0x1
    or WORD PTR [rax+rbx*4], 0x1
    or WORD PTR [rbx*8+0x10], 0x1
    or WORD PTR [rip+0x100], 0x1
    or WORD PTR [0x1000], 0x1
    or WORD PTR [r13], 0x1
    or DWORD PTR [rax], 0x1
    or DWORD PTR [rax+0x7f], 0x1
    or DWORD PTR [rax+0x80], 0x1
    or DWORD PTR [rax+rbx*4], 0x1
    or DWORD PTR [rbx*8+0x10], 0x1
    or DWORD PTR [rip+0x100], 0x1
    or DWORD PTR [0x1000], 0x1
    or DWORD PTR [r13], 0x1
    or QWORD PTR [rax], 0x1
    or QWORD PTR [rax+0x7f], 0x1
    or QWORD PTR [rax+0x80], 0x1
    or QWORD PTR [rax+rbx*4], 0x1
    or QWORD PTR [rbx*8+0x10], 0x1
    or QWORD PTR [rip+0x100], 0x1
    or QWORD PTR [0x1000], 0x1
    or QWORD PTR [r13], 0x1
    or BYTE PTR [rax], al
    or BYTE PTR [rax+0x7f], al
    or BYTE PTR [rax+0x80], al
    or BYTE PTR [rax+rbx*4], al
    or BYTE PTR [rbx*8+0x10], al
    or BYTE PTR [rip+0x100], al
    or BYTE PTR [0x1000], al
    or BYTE PTR [r13], al
    or WORD PTR [rax], ax
    or WORD PTR [rax+0x7f], ax
    or WORD PTR [rax+0x80], ax
    or WORD PTR [rax+rbx*4], ax
    or WORD PTR [rbx*8+0x10], ax
    or WORD PTR [rip+0x100], ax
    or WORD PTR [0x1000], ax
    or WORD PTR [r13], ax
    or DWORD PTR [rax], eax
    or DWORD PTR [rax+0x7f], eax
    or DWORD PTR [rax+0x80], eax
    or DWORD PTR [rax+rbx*4], eax
    or DWORD PTR [rbx*8+0x10], eax
    or DWORD PTR [rip+0x100], eax
    or DWORD PTR [0x1000], eax
    or DWORD PTR [r13], eax
    or QWORD PTR [rax], rax
    or QWORD PTR [rax+0x7f], rax
    or QWORD PTR [rax+0x80], rax
    or QWORD PTR [rax+rbx*4], rax
    or QWORD PTR [rbx*8+0x10], rax
    or QWORD PTR [rip+0x100], rax
    or QWORD PTR [0x1000], rax
    or QWORD PTR [r13], rax
    or al, BYTE PTR [rax]
    or al, BYTE PTR [rax+0x7f]
    or al, BYTE PTR [rax+0x80]
    or al, BYTE PTR [rax+rbx*4]
    or al, BYTE PTR [rbx*8+0x10]
    or al, BYTE PTR [rip+0x100]
    or al, BYTE PTR [0x1000]
    or al, BYTE PTR [r13]
    or ax, WORD PTR [rax]
    or ax, WORD PTR [rax+0x7f]
    or ax, WORD PTR [rax+0x80]
    or ax, WORD PTR [rax+rbx*4]
    or ax, WORD PTR [rbx*8+0x10]
    or ax, WORD PTR [rip+0x100]
    or ax, WORD PTR [0x1000]
    or ax, WORD PTR [r13]
    or eax, DWORD PTR [rax]
    or eax, DWORD PTR [rax+0x7f]
    or eax, DWORD PTR [rax+0x80]
    or eax, DWORD PTR [rax+rbx*4]
    or eax, DWORD PTR [rbx*8+0x10]
    or eax, DWORD PTR [rip+0x100]
    or eax, DWORD PTR [0x1000]
    or eax, DWORD PTR [r13]
    or rax, QWORD PTR [rax]
    or rax, QWORD PTR [rax+0x7f]
    or rax, QWORD PTR [rax+0x80]
    or rax, QWORD PTR [rax+rbx*4]
    or rax, QWORD PTR [rbx*8+0x10]
    or rax, QWORD PTR [rip+0x100]
    or rax, QWORD PTR [0x1000]
    or rax, QWORD PTR [r13]
    orpd xmm1, [rax]
    orpd xmm1, [rax+0x7f]
    orpd xmm1, [rax+0x80]
    orpd xmm1, [rax+rbx*4]
    orpd xmm1, [rbx*8+0x10]
    orpd xmm1, [rip+0x100]
    orpd xmm1, [0x1000]
    orpd xmm1, [r13]
    vorpd xmm1, xmm2, [rax]
    vorpd xmm1, xmm2, [rax+0x7f]
    vorpd xmm1, xmm2, [rax+0x80]
    vorpd xmm1, xmm2, [rax+rbx*4]
    vorpd xmm1, xmm2, [rbx*8+0x10]
    vorpd xmm1, xmm2, [rip+0x100]
    vorpd xmm1, xmm2, [0x1000]
    vorpd xmm1, xmm2, [r13]
    vorpd ymm1, ymm2, [rax]
    vorpd ymm1, ymm2, [rax+0x7f]
    vorpd ymm1, ymm2, [rax+0x80]
    vorpd ymm1, ymm2, [rax+rbx*4]
    vorpd ymm1, ymm2, [rbx*8+0x10]
    vorpd ymm1, ymm2, [rip+0x100]
    vorpd ymm1, ymm2, [0x1000]
    vorpd ymm1, ymm2, [r13]
    orps xmm1, [rax]
    orps xmm1, [rax+0x7f]
    orps xmm1, [rax+0x80]
    orps xmm1, [rax+rbx*4]
    orps xmm1, [rbx*8+0x10]
    orps xmm1, [rip+0x100]
    orps xmm1, [0x1000]
    orps xmm1, [r13]
    vorps xmm1, xmm2, [rax]
    vorps xmm1, xmm2, [rax+0x7f]
    vorps xmm1, xmm2, [rax+0x80]
    vorps xmm1, xmm2, [rax+rbx*4]
    vorps xmm1, xmm2, [rbx*8+0x10]
    vorps xmm1, xmm2, [rip+0x100]
    vorps xmm1, xmm2, [0x1000]
    vorps xmm1, xmm2, [r13]
    vorps ymm1, ymm2, [rax]
    vorps ymm1, ymm2, [rax+0x7f]
    vorps ymm1, ymm2, [rax+0x80]
    vorps ymm1, ymm2, [rax+rbx*4]
    vorps ymm1, ymm2, [rbx*8+0x10]
    vorps ymm1, ymm2, [rip+0x100]
    vorps ymm1, ymm2, [0x1000]
    vorps ymm1, ymm2, [r13]
    outs dx, BYTE PTR [rax]
    outs dx, BYTE PTR [rax+0x7f]
    outs dx, BYTE PTR [rax+0x80]
    outs dx, BYTE PTR [rax+rbx*4]
    outs dx, BYTE PTR [rbx*8+0x10]
    outs dx, BYTE PTR [rip+0x100]
    outs dx, BYTE PTR [0x1000]
    outs dx, BYTE PTR [r13]
    outs dx, WORD PTR [rax]
    outs dx, WORD PTR [rax+0x7f]
    outs dx, WORD PTR [rax+0x80]
    outs dx, WORD PTR [rax+rbx*4]
    outs dx, WORD PTR [rbx*8+0x10]
    outs dx, WORD PTR [rip+0x100]
    outs dx, WORD PTR [0x1000]
    outs dx, WORD PTR [r13]
    outs dx, DWORD PTR [rax]
    outs dx, DWORD PTR [rax+0x7f]
    outs dx, DWORD PTR [rax+0x80]
    outs dx, DWORD PTR [rax+rbx*4]
    outs dx, DWORD PTR [rbx*8+0x10]
    outs dx, DWORD PTR [rip+0x100]
    outs dx, DWORD PTR [0x1000]
    outs dx, DWORD PTR [r13]
    pabsb mm1, QWORD PTR [rax]
    pabsb mm1, QWORD PTR [rax+0x7f]
    pabsb mm1, QWORD PTR [rax+0x80]
    pabsb mm1, QWORD PTR [rax+rbx*4]
    pabsb mm1, QWORD PTR [rbx*8+0x10]
    pabsb mm1, QWORD PTR [rip+0x100]
    pabsb mm1, QWORD PTR [0x1000]
    pabsb mm1, QWORD PTR [r13]
    pabsb xmm1, [rax]
    pabsb xmm1, [rax+0x7f]
    pabsb xmm1, [rax+0x80]
    pabsb xmm1, [rax+rbx*4]
    pabsb xmm1, [rbx*8+0x10]
    pabsb xmm1, [rip+0x100]
    pabsb xmm1, [0x1000]
    pabsb xmm1, [r13]
    pabsw mm1, QWORD PTR [rax]
    pabsw mm1, QWORD PTR [rax+0x7f]
    pabsw mm1, QWORD PTR [rax+0x80]
    pabsw mm1, QWORD PTR [rax+rbx*4]
    pabsw mm1, QWORD PTR [rbx*8+0x10]
    pabsw mm1, QWORD PTR [rip+0x100]
    pabsw mm1, QWORD PTR [0x1000]
    pabsw mm1, QWORD PTR [r13]
    pabsw xmm1, [rax]
    pabsw xmm1, [rax+0x7f]
    pabsw xmm1, [rax+0x80]
    pabsw xmm1, [rax+rbx*4]
    pabsw xmm1, [rbx*8+0x10]
    pabsw xmm1, [rip+0x100]
    pabsw xmm1, [0x1000]
    pabsw xmm1, [r13]
    pabsd mm1, QWORD PTR [rax]
    pabsd mm1, QWORD PTR [rax+0x7f]
    pabsd mm1, QWORD PTR [rax+0x80]
    pabsd mm1, QWORD PTR [rax+rbx*4]
    pabsd mm1, QWORD PTR [rbx*8+0x10]
    pabsd mm1, QWORD PTR [rip+0x100]
    pabsd mm1, QWORD PTR [0x1000]
    pabsd mm1, QWORD PTR [r13]
    pabsd xmm1, [rax]
    pabsd xmm1, [rax+0x7f]
    pabsd xmm1, [rax+0x80]
    pabsd xmm1, [rax+rbx*4]
    pabsd xmm1, [rbx*8+0x10]
    pabsd xmm1, [rip+0x100]
    pabsd xmm1, [0x1000]
    pabsd xmm1, [r13]
    vpabsb xmm1, [rax]
    vpabsb xmm1, [rax+0x7f]
    vpabsb xmm1, [rax+0x80]
    vpabsb xmm1, [rax+rbx*4]
    vpabsb xmm1, [rbx*8+0x10]
    vpabsb xmm1, [rip+0x100]
    vpabsb xmm1, [0x1000]
    vpabsb xmm1, [r13]
    vpabsw xmm1, [rax]
    vpabsw xmm1, [rax+0x7f]
    vpabsw xmm1, [rax+0x80]
    vpabsw xmm1, [rax+rbx*4]
    vpabsw xmm1, [rbx*8+0x10]
    vpabsw xmm1, [rip+0x100]
    vpabsw xmm1, [0x1000]
    vpabsw xmm1, [r13]
    vpabsd xmm1, [rax]
    vpabsd xmm1, [rax+0x7f]
    vpabsd xmm1, [rax+0x80]
    vpabsd xmm1, [rax+rbx*4]
    vpabsd xmm1, [rbx*8+0x10]
    vpabsd xmm1, [rip+0x100]
    vpabsd xmm1, [0x1000]
    vpabsd xmm1, [r13]
    vpabsb ymm1, [rax]
    vpabsb ymm1, [rax+0x7f]
    vpabsb ymm1, [rax+0x80]
    vpabsb ymm1, [rax+rbx*4]
    vpabsb ymm1, [rbx*8+0x10]
    vpabsb ymm1, [rip+0x100]
    vpabsb ymm1, [0x1000]
    vpabsb ymm1, [r13]
    vpabsw ymm1, [rax]
    vpabsw ymm1, [rax+0x7f]
    vpabsw ymm1, [rax+0x80]
    vpabsw ymm1, [rax+rbx*4]
    vpabsw ymm1, [rbx*8+0x10]
    vpabsw ymm1, [rip+0x100]
    vpabsw ymm1, [0x1000]
    vpabsw ymm1, [r13]
    vpabsd ymm1, [rax]
    vpabsd ymm1, [rax+0x7f]
    vpabsd ymm1, [rax+0x80]
    vpabsd ymm1, [rax+rbx*4]
    vpabsd ymm1, [rbx*8+0x10]
    vpabsd ymm1, [rip+0x100]
    vpabsd ymm1, [0x1000]
    vpabsd ymm1, [r13]
    packsswb mm1, QWORD PTR [rax]
    packsswb mm1, QWORD PTR [rax+0x7f]
    packsswb mm1, QWORD PTR [rax+0x80]
    packsswb mm1, QWORD PTR [rax+rbx*4]
    packsswb mm1, QWORD PTR [rbx*8+0x10]
    packsswb mm1, QWORD PTR [rip+0x100]
    packsswb mm1, QWORD PTR [0x1000]
    packsswb mm1, QWORD PTR [r13]
    packsswb xmm1, [rax]
    packsswb xmm1, [rax+0x7f]
    packsswb xmm1, [rax+0x80]
    packsswb xmm1, [rax+rbx*4]
    packsswb xmm1, [rbx*8+0x10]
    packsswb xmm1, [rip+0x100]
    packsswb xmm1, [0x1000]
    packsswb xmm1, [r13]
    packssdw mm1, QWORD PTR [rax]
    packssdw mm1, QWORD PTR [rax+0x7f]
    packssdw mm1, QWORD PTR [rax+0x80]
    packssdw mm1, QWORD PTR [rax+rbx*4]
    packssdw mm1, QWORD PTR [rbx*8+0x10]
    packssdw mm1, QWORD PTR [rip+0x100]
    packssdw mm1, QWORD PTR [0x1000]
    packssdw mm1, QWORD PTR [r13]
    packssdw xmm1, [rax]
    packssdw xmm1, [rax+0x7f]
    packssdw xmm1, [rax+0x80]
    packssdw xmm1, [rax+rbx*4]
    packssdw xmm1, [rbx*8+0x10]
    packssdw xmm1, [rip+0x100]
    packssdw xmm1, [0x1000]
    packssdw xmm1, [r13]
    vpacksswb xmm1, xmm2, [rax]
    vpacksswb xmm1, xmm2, [rax+0x7f]
    vpacksswb xmm1, xmm2, [rax+0x80]
    vpacksswb xmm1, xmm2, [rax+rbx*4]
    vpacksswb xmm1, xmm2, [rbx*8+0x10]
    vpacksswb xmm1, xmm2, [rip+0x100]
    vpacksswb xmm1, xmm2, [0x1000]
    vpacksswb xmm1, xmm2, [r13]
    vpackssdw xmm1, xmm2, [rax]
    vpackssdw xmm1, xmm2, [rax+0x7f]
    vpackssdw xmm1, xmm2, [rax+0x80]
    vpackssdw xmm1, xmm2, [rax+rbx*4]
    vpackssdw xmm1, xmm2, [rbx*8+0x10]
    vpackssdw xmm1, xmm2, [rip+0x100]
    vpackssdw xmm1, xmm2, [0x1000]
    vpackssdw xmm1, xmm2, [r13]
    vpacksswb ymm1, ymm2, [rax]
    vpacksswb ymm1, ymm2, [rax+0x7f]
    vpacksswb ymm1, ymm2, [rax+0x80]
    vpacksswb ymm1, ymm2, [rax+rbx*4]
    vpacksswb ymm1, ymm2, [rbx*8+0x10]
    vpacksswb ymm1, ymm2, [rip+0x100]
    vpacksswb ymm1, ymm2, [0x1000]
    vpacksswb ymm1, ymm2, [r13]
    vpackssdw ymm1, ymm2, [rax]
    vpackssdw ymm1, ymm2, [rax+0x7f]
    vpackssdw ymm1, ymm2, [rax+0x80]
    vpackssdw ymm1, ymm2, [rax+rbx*4]
    vpackssdw ymm1, ymm2, [rbx*8+0x10]
    vpackssdw ymm1, ymm2, [rip+0x100]
    vpackssdw ymm1, ymm2, [0x1000]
    vpackssdw ymm1, ymm2, [r13]
    packusdw xmm1, [rax]
    packusdw xmm1, [rax+0x7f]
    packusdw xmm1, [rax+0x80]
    packusdw xmm1, [rax+rbx*4]
    packusdw xmm1, [rbx*8+0x10]
    packusdw xmm1, [rip+0x100]
    packusdw xmm1, [0x1000]
    packusdw xmm1, [r13]
    vpackusdw xmm1, xmm2, [rax]
    vpackusdw xmm1, xmm2, [rax+0x7f]
    vpackusdw xmm1, xmm2, [rax+0x80]
    vpackusdw xmm1, xmm2, [rax+rbx*4]
    vpackusdw xmm1, xmm2, [rbx*8+0x10]
    vpackusdw xmm1, xmm2, [rip+0x100]
    vpackusdw xmm1, xmm2, [0x1000]
    vpackusdw xmm1, xmm2, [r13]
    vpackusdw ymm1, ymm2, [rax]
    vpackusdw ymm1, ymm2, [rax+0x7f]
    vpackusdw ymm1, ymm2, [rax+0x80]
    vpackusdw ymm1, ymm2, [rax+rbx*4]
    vpackusdw ymm1, ymm2, [rbx*8+0x10]
    vpackusdw ymm1, ymm2, [rip+0x100]
    vpackusdw ymm1, ymm2, [0x1000]
    vpackusdw ymm1, ymm2, [r13]
    packuswb mm0, QWORD PTR [rax]
    packuswb mm0, QWORD PTR [rax+0x7f]
    packuswb mm0, QWORD PTR [rax+0x80]
    packuswb mm0, QWORD PTR [rax+rbx*4]
    packuswb mm0, QWORD PTR [rbx*8+0x10]
    packuswb mm0, QWORD PTR [rip+0x100]
    packuswb mm0, QWORD PTR [0x1000]
    packuswb mm0, QWORD PTR [r13]
    packuswb xmm1, [rax]
    packuswb xmm1, [rax+0x7f]
    packuswb xmm1, [rax+0x80]
    packuswb xmm1, [rax+rbx*4]
    packuswb xmm1, [rbx*8+0x10]
    packuswb xmm1, [rip+0x100]
    packuswb xmm1, [0x1000]
    packuswb xmm1, [r13]
    vpackuswb xmm1, xmm2, [rax]
    vpackuswb xmm1, xmm2, [rax+0x7f]
    vpackuswb xmm1, xmm2, [rax+0x80]
    vpackuswb xmm1, xmm2, [rax+rbx*4]
    vpackuswb xmm1, xmm2, [rbx*8+0x10]
    vpackuswb xmm1, xmm2, [rip+0x100]
    vpackuswb xmm1, xmm2, [0x1000]
    vpackuswb xmm1, xmm2, [r13]
    vpackuswb ymm1, ymm2, [rax]
    vpackuswb ymm1, ymm2, [rax+0x7f]
    vpackuswb ymm1, ymm2, [rax+0x80]
    vpackuswb ymm1, ymm2, [rax+rbx*4]
    vpackuswb ymm1, ymm2, [rbx*8+0x10]
    vpackuswb ymm1, ymm2, [rip+0x100]
    vpackuswb ymm1, ymm2, [0x1000]
    vpackuswb ymm1, ymm2, [r13]
    paddb mm0, QWORD PTR [rax]
    paddb mm0, QWORD PTR [rax+0x7f]
    paddb mm0, QWORD PTR [rax+0x80]
    paddb mm0, QWORD PTR [rax+rbx*4]
    paddb mm0, QWORD PTR [rbx*8+0x10]
    paddb mm0, QWORD PTR [rip+0x100]
    paddb mm0, QWORD PTR [0x1000]
    paddb mm0, QWORD PTR [r13]
    paddw mm0, QWORD PTR [rax]
    paddw mm0, QWORD PTR [rax+0x7f]
    paddw mm0, QWORD PTR [rax+0x80]
    paddw mm0, QWORD PTR [rax+rbx*4]
    paddw mm0, QWORD PTR [rbx*8+0x10]
    paddw mm0, QWORD PTR [rip+0x100]
    paddw mm0, QWORD PTR [0x1000]
    paddw mm0, QWORD PTR [r13]
    paddd mm0, QWORD PTR [rax]
    paddd mm0, QWORD PTR [rax+0x7f]
    paddd mm0, QWORD PTR [rax+0x80]
    paddd mm0, QWORD PTR [rax+rbx*4]
    paddd mm0, QWORD PTR [rbx*8+0x10]
    paddd mm0, QWORD PTR [rip+0x100]
    paddd mm0, QWORD PTR [0x1000]
    paddd mm0, QWORD PTR [r13]
    paddq mm0, QWORD PTR [rax]
    paddq mm0, QWORD PTR [rax+0x7f]
    paddq mm0, QWORD PTR [rax+0x80]
    paddq mm0, QWORD PTR [rax+rbx*4]
    paddq mm0, QWORD PTR [rbx*8+0x10]
    paddq mm0, QWORD PTR [rip+0x100]
    paddq mm0, QWORD PTR [0x1000]
    paddq mm0, QWORD PTR [r13]
    paddb xmm1, [rax]
    paddb xmm1, [rax+0x7f]
    paddb xmm1, [rax+0x80]
    paddb xmm1, [rax+rbx*4]
    paddb xmm1, [rbx*8+0x10]
    paddb xmm1, [rip+0x100]
    paddb xmm1, [0x1000]
    paddb xmm1, [r13]
    paddw xmm1, [rax]
    paddw xmm1, [rax+0x7f]
    paddw xmm1, [rax+0x80]
    paddw xmm1, [rax+rbx*4]
    paddw xmm1, [rbx*8+0x10]
    paddw xmm1, [rip+0x100]
    paddw xmm1, [0x1000]
    paddw xmm1, [r13]
    paddd xmm1, [rax]
    paddd xmm1, [rax+0x7f]
    paddd xmm1, [rax+0x80]
    paddd xmm1, [rax+rbx*4]
    paddd xmm1, [rbx*8+0x10]
    paddd xmm1, [rip+0x100]
    paddd xmm1, [0x1000]
    paddd xmm1, [r13]
    paddq xmm1, [rax]
    paddq xmm1, [rax+0x7f]
    paddq xmm1, [rax+0x80]
    paddq xmm1, [rax+rbx*4]
    paddq xmm1, [rbx*8+0x10]
    paddq xmm1, [rip+0x100]
    paddq xmm1, [0x1000]
    paddq xmm1, [r13]
    vpaddb xmm1, xmm2, [rax]
    vpaddb xmm1, xmm2, [rax+0x7f]
    vpaddb xmm1, xmm2, [rax+0x80]
    vpaddb xmm1, xmm2, [rax+rbx*4]
    vpaddb xmm1, xmm2, [rbx*8+0x10]
    vpaddb xmm1, xmm2, [rip+0x100]
    vpaddb xmm1, xmm2, [0x1000]
    vpaddb xmm1, xmm2, [r13]
    vpaddw xmm1, xmm2, [rax]
    vpaddw xmm1, xmm2, [rax+0x7f]
    vpaddw xmm1, xmm2, [rax+0x80]
    vpaddw xmm1, xmm2, [rax+rbx*4]
    vpaddw xmm1, xmm2, [rbx*8+0x10]
    vpaddw xmm1, xmm2, [rip+0x100]
    vpaddw xmm1, xmm2, [0x1000]
    vpaddw xmm1, xmm2, [r13]
    vpaddd xmm1, xmm2, [rax]
    vpaddd xmm1, xmm2, [rax+0x7f]
    vpaddd xmm1, xmm2, [rax+0x80]
    vpaddd xmm1, xmm2, [rax+rbx*4]
    vpaddd xmm1, xmm2, [rbx*8+0x10]
    vpaddd xmm1, xmm2, [rip+0x100]
    vpaddd xmm1, xmm2, [0x1000]
    vpaddd xmm1, xmm2, [r13]
    vpaddq xmm1, xmm2, [rax]
    vpaddq xmm1, xmm2, [rax+0x7f]
    vpaddq xmm1, xmm2, [rax+0x80]
    vpaddq xmm1, xmm2, [rax+rbx*4]
    vpaddq xmm1, xmm2, [rbx*8+0x10]
    vpaddq xmm1, xmm2, [rip+0x100]
    vpaddq xmm1, xmm2, [0x1000]
    vpaddq xmm1, xmm2, [r13]
    vpaddb ymm1, ymm2, [rax]
    vpaddb ymm1, ymm2, [rax+0x7f]
    vpaddb ymm1, ymm2, [rax+0x80]
    vpaddb ymm1, ymm2, [rax+rbx*4]
    vpaddb ymm1, ymm2, [rbx*8+0x10]
    vpaddb ymm1, ymm2, [rip+0x100]
    vpaddb ymm1, ymm2, [0x1000]
    vpaddb ymm1, ymm2, [r13]
    vpaddw ymm1, ymm2, [rax]
    vpaddw ymm1, ymm2, [rax+0x7f]
    vpaddw ymm1, ymm2, [rax+0x80]
    vpaddw ymm1, ymm2, [rax+rbx*4]
    vpaddw ymm1, ymm2, [rbx*8+0x10]
    vpaddw ymm1, ymm2, [rip+0x100]
    vpaddw ymm1, ymm2, [0x1000]
    vpaddw ymm1, ymm2, [r13]
    vpaddd ymm1, ymm2, [rax]
    vpaddd ymm1, ymm2, [rax+0x7f]
    vpaddd ymm1, ymm2, [rax+0x80]
    vpaddd ymm1, ymm2, [rax+rbx*4]
    vpaddd ymm1, ymm2, [rbx*8+0x10]
    vpaddd ymm1, ymm2, [rip+0x100]
    vpaddd ymm1, ymm2, [0x1000]
    vpaddd ymm1, ymm2, [r13]
    vpaddq ymm1, ymm2, [rax]
    vpaddq ymm1, ymm2, [rax+0x7f]
    vpaddq ymm1, ymm2, [rax+0x80]
    vpaddq ymm1, ymm2, [rax+rbx*4]
    vpaddq ymm1, ymm2, [rbx*8+0x10]
    vpaddq ymm1, ymm2, [rip+0x100]
    vpaddq ymm1, ymm2, [0x1000]
    vpaddq ymm1, ymm2, [r13]
    paddsb mm0, QWORD PTR [rax]
    paddsb mm0, QWORD PTR [rax+0x7f]
    paddsb mm0, QWORD PTR [rax+0x80]
    paddsb mm0, QWORD PTR [rax+rbx*4]
    paddsb mm0, QWORD PTR [rbx*8+0x10]
    paddsb mm0, QWORD PTR [rip+0x100]
    paddsb mm0, QWORD PTR [0x1000]
    paddsb mm0, QWORD PTR [r13]
    paddsb xmm1, [rax]
    paddsb xmm1, [rax+0x7f]
    paddsb xmm1, [rax+0x80]
    paddsb xmm1, [rax+rbx*4]
    paddsb xmm1, [rbx*8+0x10]
    paddsb xmm1, [rip+0x100]
    paddsb xmm1, [0x1000]
    paddsb xmm1, [r13]
    paddsw mm0, QWORD PTR [rax]
    paddsw mm0, QWORD PTR [rax+0x7f]
    paddsw mm0, QWORD PTR [rax+0x80]
    paddsw mm0, QWORD PTR [rax+rbx*4]
    paddsw mm0, QWORD PTR [rbx*8+0x10]
    paddsw mm0, QWORD PTR [rip+0x100]
    paddsw mm0, QWORD PTR [0x1000]
    paddsw mm0, QWORD PTR [r13]
    paddsw xmm1, [rax]
    paddsw xmm1, [rax+0x7f]
    paddsw xmm1, [rax+0x80]
    paddsw xmm1, [rax+rbx*4]
    paddsw xmm1, [rbx*8+0x10]
    paddsw xmm1, [rip+0x100]
    paddsw xmm1, [0x1000]
    paddsw xmm1, [r13]
    vpaddsb xmm1, xmm2, [rax]
    vpaddsb xmm1, xmm2, [rax+0x7f]
    vpaddsb xmm1, xmm2, [rax+0x80]
    vpaddsb xmm1, xmm2, [rax+rbx*4]
    vpaddsb xmm1, xmm2, [rbx*8+0x10]
    vpaddsb xmm1, xmm2, [rip+0x100]
    vpaddsb xmm1, xmm2, [0x1000]
    vpaddsb xmm1, xmm2, [r13]
    vpaddsw xmm1, xmm2, [rax]
    vpaddsw xmm1, xmm2, [rax+0x7f]
    vpaddsw xmm1, xmm2, [rax+0x80]
    vpaddsw xmm1, xmm2, [rax+rbx*4]
    vpaddsw xmm1, xmm2, [rbx*8+0x10]
    vpaddsw xmm1, xmm2, [rip+0x100]
    vpaddsw xmm1, xmm2, [0x1000]
    vpaddsw xmm1, xmm2, [r13]
    vpaddsb ymm1, ymm2, [rax]
    vpaddsb ymm1, ymm2, [rax+0x7f]
    vpaddsb ymm1, ymm2, [rax+0x80]
    vpaddsb ymm1, ymm2, [rax+rbx*4]
    vpaddsb ymm1, ymm2, [rbx*8+0x10]
    vpaddsb ymm1, ymm2, [rip+0x100]
    vpaddsb ymm1, ymm2, [0x1000]
    vpaddsb ymm1, ymm2, [r13]
    vpaddsw ymm1, ymm2, [rax]
    vpaddsw ymm1, ymm2, [rax+0x7f]
    vpaddsw ymm1, ymm2, [rax+0x80]
    vpaddsw ymm1, ymm2, [rax+rbx*4]
    vpaddsw ymm1, ymm2, [rbx*8+0x10]
    vpaddsw ymm1, ymm2, [rip+0x100]
    vpaddsw ymm1, ymm2, [0x1000]
    vpaddsw ymm1, ymm2, [r13]
    paddusb mm0, QWORD PTR [rax]
    paddusb mm0, QWORD PTR [rax+0x7f]
    paddusb mm0, QWORD PTR [rax+0x80]
    paddusb mm0, QWORD PTR [rax+rbx*4]
    paddusb mm0, QWORD PTR [rbx*8+0x10]
    paddusb mm0, QWORD PTR [rip+0x100]
    paddusb mm0, QWORD PTR [0x1000]
    paddusb mm0, QWORD PTR [r13]
    paddusb xmm1, [rax]
    paddusb xmm1, [rax+0x7f]
    paddusb xmm1, [rax+0x80]
    paddusb xmm1, [rax+rbx*4]
    paddusb xmm1, [rbx*8+0x10]
    paddusb xmm1, [rip+0x100]
    paddusb xmm1, [0x1000]
    paddusb xmm1, [r13]
    paddusw mm0, QWORD PTR [rax]
    paddusw mm0, QWORD PTR [rax+0x7f]
    paddusw mm0, QWORD PTR [rax+0x80]
    paddusw mm0, QWORD PTR [rax+rbx*4]
    paddusw mm0, QWORD PTR [rbx*8+0x10]
    paddusw mm0, QWORD PTR [rip+0x100]
    paddusw mm0, QWORD PTR [0x1000]
    paddusw mm0, QWORD PTR [r13]
    paddusw xmm1, [rax]
    paddusw xmm1, [rax+0x7f]
    paddusw xmm1, [rax+0x80]
    paddusw xmm1, [rax+rbx*4]
    paddusw xmm1, [rbx*8+0x10]
    paddusw xmm1, [rip+0x100]
    paddusw xmm1, [0x1000]
    paddusw xmm1, [r13]
    vpaddusb xmm1, xmm2, [rax]
    vpaddusb xmm1, xmm2, [rax+0x7f]
    vpaddusb xmm1, xmm2, [rax+0x80]
    vpaddusb xmm1, xmm2, [rax+rbx*4]
    vpaddusb xmm1, xmm2, [rbx*8+0x10]
    vpaddusb xmm1, xmm2, [rip+0x100]
    vpaddusb xmm1, xmm2, [0x1000]
    vpaddusb xmm1, xmm2, [r13]
    vpaddusw xmm1, xmm2, [rax]
    vpaddusw xmm1, xmm2, [rax+0x7f]
    vpaddusw xmm1, xmm2, [rax+0x80]
    vpaddusw xmm1, xmm2, [rax+rbx*4]
    vpaddusw xmm1, xmm2, [rbx*8+0x10]
    vpaddusw xmm1, xmm2, [rip+0x100]
    vpaddusw xmm1, xmm2, [0x1000]
    vpaddusw xmm1, xmm2, [r13]
    vpaddusb ymm1, ymm2, [rax]
    vpaddusb ymm1, ymm2, [rax+0x7f]
    vpaddusb ymm1, ymm2, [rax+0x80]
    vpaddusb ymm1, ymm2, [rax+rbx*4]
    vpaddusb ymm1, ymm2, [rbx*8+0x10]
    vpaddusb ymm1, ymm2, [rip+0x100]
    vpaddusb ymm1, ymm2, [0x1000]
    vpaddusb ymm1, ymm2, [r13]
    vpaddusw ymm1, ymm2, [rax]
    vpaddusw ymm1, ymm2, [rax+0x7f]
    vpaddusw ymm1, ymm2, [rax+0x80]
    vpaddusw ymm1, ymm2, [rax+rbx*4]
    vpaddusw ymm1, ymm2, [rbx*8+0x10]
    vpaddusw ymm1, ymm2, [rip+0x100]
    vpaddusw ymm1, ymm2, [0x1000]
    vpaddusw ymm1, ymm2, [r13]
    palignr xmm1, [rax], 0x1
    palignr xmm1, [rax+0x7f], 0x1
    palignr xmm1, [rax+0x80], 0x1
    palignr xmm1, [rax+rbx*4], 0x1
    palignr xmm1, [rbx*8+0x10], 0x1
    palignr xmm1, [rip+0x100], 0x1
    palignr xmm1, [0x1000], 0x1
    palignr xmm1, [r13], 0x1
    vpalignr xmm1, xmm2, [rax], 0x1
    vpalignr xmm1, xmm2, [rax+0x7f], 0x1
    vpalignr xmm1, xmm2, [rax+0x80], 0x1
    vpalignr xmm1, xmm2, [rax+rbx*4], 0x1
    vpalignr xmm1, xmm2, [rbx*8+0x10], 0x1
    vpalignr xmm1, xmm2, [rip+0x100], 0x1
    vpalignr xmm1, xmm2, [0x1000], 0x1
    vpalignr xmm1, xmm2, [r13], 0x1
    vpalignr ymm1, ymm2, [rax], 0x1
    vpalignr ymm1, ymm2, [rax+0x7f], 0x1
    vpalignr ymm1, ymm2, [rax+0x80], 0x1
    vpalignr ymm1, ymm2, [rax+rbx*4], 0x1
    vpalignr ymm1, ymm2, [rbx*8+0x10], 0x1
    vpalignr ymm1, ymm2, [rip+0x100], 0x1
    vpalignr ymm1, ymm2, [0x1000], 0x1
    vpalignr ymm1, ymm2, [r13], 0x1
    pand mm0, QWORD PTR [rax]
    pand mm0, QWORD PTR [rax+0x7f]
    pand mm0, QWORD PTR [rax+0x80]
    pand mm0, QWORD PTR [rax+rbx*4]
    pand mm0, QWORD PTR [rbx*8+0x10]
    pand mm0, QWORD PTR [rip+0x100]
    pand mm0, QWORD PTR [0x1000]
    pand mm0, QWORD PTR [r13]
    pand xmm1, [rax]
    pand xmm1, [rax+0x7f]
    pand xmm1, [rax+0x80]
    pand xmm1, [rax+rbx*4]
    pand xmm1, [rbx*8+0x10]
    pand xmm1, [rip+0x100]
    pand xmm1, [0x1000]
    pand xmm1, [r13]
    vpand xmm1, xmm2, [rax]
    vpand xmm1, xmm2, [rax+0x7f]
    vpand xmm1, xmm2, [rax+0x80]
    vpand xmm1, xmm2, [rax+rbx*4]
    vpand xmm1, xmm2, [rbx*8+0x10]
    vpand xmm1, xmm2, [rip+0x100]
    vpand xmm1, xmm2, [0x1000]
    vpand xmm1, xmm2, [r13]
    pandn mm0, QWORD PTR [rax]
    pandn mm0, QWORD PTR [rax+0x7f]
    pandn mm0, QWORD PTR [rax+0x80]
    pandn mm0, QWORD PTR [rax+rbx*4]
    pandn mm0, QWORD PTR [rbx*8+0x10]
    pandn mm0, QWORD PTR [rip+0x100]
    pandn mm0, QWORD PTR [0x1000]
    pandn mm0, QWORD PTR [r13]
    pandn xmm1, [rax]
    pandn xmm1, [rax+0x7f]
    pandn xmm1, [rax+0x80]
    pandn xmm1, [rax+rbx*4]
    pandn xmm1, [rbx*8+0x10]
    pandn xmm1, [rip+0x100]
    pandn xmm1, [0x1000]
    pandn xmm1, [r13]
    vpandn xmm1, xmm2, [rax]
    vpandn xmm1, xmm2, [rax+0x7f]
    vpandn xmm1, xmm2, [rax+0x80]
    vpandn xmm1, xmm2, [rax+rbx*4]
    vpandn xmm1, xmm2, [rbx*8+0x10]
    vpandn xmm1, xmm2, [rip+0x100]
    vpandn xmm1, xmm2, [0x1000]
    vpandn xmm1, xmm2, [r13]
    vpandn ymm1, ymm2, [rax]
    vpandn ymm1, ymm2, [rax+0x7f]
    vpandn ymm1, ymm2, [rax+0x80]
    vpandn ymm1, ymm2, [rax+rbx*4]
    vpandn ymm1, ymm2, [rbx*8+0x10]
    vpandn ymm1, ymm2, [rip+0x100]
    vpandn ymm1, ymm2, [0x1000]
    vpandn ymm1, ymm2, [r13]
    pavgb mm1, QWORD PTR [rax]
    pavgb mm1, QWORD PTR [rax+0x7f]
    pavgb mm1, QWORD PTR [rax+0x80]
    pavgb mm1, QWORD PTR [rax+rbx*4]
    pavgb mm1, QWORD PTR [rbx*8+0x10]
    pavgb mm1, QWORD PTR [rip+0x100]
    pavgb mm1, QWORD PTR [0x1000]
    pavgb mm1, QWORD PTR [r13]
    pavgb xmm1, [rax]
    pavgb xmm1, [rax+0x7f]
    pavgb xmm1, [rax+0x80]
    pavgb xmm1, [rax+rbx*4]
    pavgb xmm1, [rbx*8+0x10]
    pavgb xmm1, [rip+0x100]
    pavgb xmm1, [0x1000]
    pavgb xmm1, [r13]
    pavgw mm1, QWORD PTR [rax]
    pavgw mm1, QWORD PTR [rax+0x7f]
    pavgw mm1, QWORD PTR [rax+0x80]
    pavgw mm1, QWORD PTR [rax+rbx*4]
    pavgw mm1, QWORD PTR [rbx*8+0x10]
    pavgw mm1, QWORD PTR [rip+0x100]
    pavgw mm1, QWORD PTR [0x1000]
    pavgw mm1, QWORD PTR [r13]
    pavgw xmm1, [rax]
    pavgw xmm1, [rax+0x7f]
    pavgw xmm1, [rax+0x80]
    pavgw xmm1, [rax+rbx*4]
    pavgw xmm1, [rbx*8+0x10]
    pavgw xmm1, [rip+0x100]
    pavgw xmm1, [0x1000]
    pavgw xmm1, [r13]
    vpavgb xmm1, xmm2, [rax]
    vpavgb xmm1, xmm2, [rax+0x7f]
    vpavgb xmm1, xmm2, [rax+0x80]
    vpavgb xmm1, xmm2, [rax+rbx*4]
    vpavgb xmm1, xmm2, [rbx*8+0x10]
    vpavgb xmm1, xmm2, [rip+0x100]
    vpavgb xmm1, xmm2, [0x1000]
    vpavgb xmm1, xmm2, [r13]
    vpavgw xmm1, xmm2, [rax]
    vpavgw xmm1, xmm2, [rax+0x7f]
    vpavgw xmm1, xmm2, [rax+0x80]
    vpavgw xmm1, xmm2, [rax+rbx*4]
    vpavgw xmm1, xmm2, [rbx*8+0x10]
    vpavgw xmm1, xmm2, [rip+0x100]
    vpavgw xmm1, xmm2, [0x1000]
    vpavgw xmm1, xmm2, [r13]
    vpavgb ymm1, ymm2, [rax]
    vpavgb ymm1, ymm2, [rax+0x7f]
    vpavgb ymm1, ymm2, [rax+0x80]
    vpavgb ymm1, ymm2, [rax+rbx*4]
    vpavgb ymm1, ymm2, [rbx*8+0x10]
    vpavgb ymm1, ymm2, [rip+0x100]
    vpavgb ymm1, ymm2, [0x1000]
    vpavgb ymm1, ymm2, [r13]
    vpavgw ymm1, ymm2, [rax]
    vpavgw ymm1, ymm2, [rax+0x7f]
    vpavgw ymm1, ymm2, [rax+0x80]
    vpavgw ymm1, ymm2, [rax+rbx*4]
    vpavgw ymm1, ymm2, [rbx*8+0x10]
    vpavgw ymm1, ymm2, [rip+0x100]
    vpavgw ymm1, ymm2, [0x1000]
    vpavgw ymm1, ymm2, [r13]
    pblendvb xmm1, [rax]
    pblendvb xmm1, [rax+0x7f]
    pblendvb xmm1, [rax+0x80]
    pblendvb xmm1, [rax+rbx*4]
    pblendvb xmm1, [rbx*8+0x10]
    pblendvb xmm1, [rip+0x100]
    pblendvb xmm1, [0x1000]
    pblendvb xmm1, [r13]
    vpblendvb xmm1, xmm2, [rax], xmm4
    vpblendvb xmm1, xmm2, [rax+0x7f], xmm4
    vpblendvb xmm1, xmm2, [rax+0x80], xmm4
    vpblendvb xmm1, xmm2, [rax+rbx*4], xmm4
    vpblendvb xmm1, xmm2, [rbx*8+0x10], xmm4
    vpblendvb xmm1, xmm2, [rip+0x100], xmm4
    vpblendvb xmm1, xmm2, [0x1000], xmm4
    vpblendvb xmm1, xmm2, [r13], xmm4
    vpblendvb ymm1, ymm2, [rax], ymm4
    vpblendvb ymm1, ymm2, [rax+0x7f], ymm4
    vpblendvb ymm1, ymm2, [rax+0x80], ymm4
    vpblendvb ymm1, ymm2, [rax+rbx*4], ymm4
    vpblendvb ymm1, ymm2, [rbx*8+0x10], ymm4
    vpblendvb ymm1, ymm2, [rip+0x100], ymm4
    vpblendvb ymm1, ymm2, [0x1000], ymm4
    vpblendvb ymm1, ymm2, [r13], ymm4
    pblendw xmm1, [rax], 0x1
    pblendw xmm1, [rax+0x7f], 0x1
    pblendw xmm1, [rax+0x80], 0x1
    pblendw xmm1, [rax+rbx*4], 0x1
    pblendw xmm1, [rbx*8+0x10], 0x1
    pblendw xmm1, [rip+0x100], 0x1
    pblendw xmm1, [0x1000], 0x1
    pblendw xmm1, [r13], 0x1
    vpblendw xmm1, xmm2, [rax], 0x1
    vpblendw xmm1, xmm2, [rax+0x7f], 0x1
    vpblendw xmm1, xmm2, [rax+0x80], 0x1
    vpblendw xmm1, xmm2, [rax+rbx*4], 0x1
    vpblendw xmm1, xmm2, [rbx*8+0x10], 0x1
    vpblendw xmm1, xmm2, [rip+0x100], 0x1
    vpblendw xmm1, xmm2, [0x1000], 0x1
    vpblendw xmm1, xmm2, [r13], 0x1
    vpblendw ymm1, ymm2, [rax], 0x1
    vpblendw ymm1, ymm2, [rax+0x7f], 0x1
    vpblendw ymm1, ymm2, [rax+0x80], 0x1
    vpblendw ymm1, ymm2, [rax+rbx*4], 0x1
    vpblendw ymm1, ymm2, [rbx*8+0x10], 0x1
    vpblendw ymm1, ymm2, [rip+0x100], 0x1
    vpblendw ymm1, ymm2, [0x1000], 0x1
    vpblendw ymm1, ymm2, [r13], 0x1
    pclmulqdq xmm1, [rax], 0x1
    pclmulqdq xmm1, [rax+0x7f], 0x1
    pclmulqdq xmm1, [rax+0x80], 0x1
    pclmulqdq xmm1, [rax+rbx*4], 0x1
    pclmulqdq xmm1, [rbx*8+0x10], 0x1
    pclmulqdq xmm1, [rip+0x100], 0x1
    pclmulqdq xmm1, [0x1000], 0x1
    pclmulqdq xmm1, [r13], 0x1
    vpclmulqdq xmm1, xmm2, [rax], 0x1
    vpclmulqdq xmm1, xmm2, [rax+0x7f], 0x1
    vpclmulqdq xmm1, xmm2, [rax+0x80], 0x1
    vpclmulqdq xmm1, xmm2, [rax+rbx*4], 0x1
    vpclmulqdq xmm1, xmm2, [rbx*8+0x10], 0x1
    vpclmulqdq xmm1, xmm2, [rip+0x100], 0x1
    vpclmulqdq xmm1, xmm2, [0x1000], 0x1
    vpclmulqdq xmm1, xmm2, [r13], 0x1
    vpclmulqdq ymm1, ymm2, [rax], 0x1
    vpclmulqdq ymm1, ymm2, [rax+0x7f], 0x1
    vpclmulqdq ymm1, ymm2, [rax+0x80], 0x1
    vpclmulqdq ymm1, ymm2, [rax+rbx*4], 0x1
    vpclmulqdq ymm1, ymm2, [rbx*8+0x10], 0x1
    vpclmulqdq ymm1, ymm2, [rip+0x100], 0x1
    vpclmulqdq ymm1, ymm2, [0x1000], 0x1
    vpclmulqdq ymm1, ymm2, [r13], 0x1
    pcmpeqb mm0, QWORD PTR [rax]
    pcmpeqb mm0, QWORD PTR [rax+0x7f]
    pcmpeqb mm0, QWORD PTR [rax+0x80]
    pcmpeqb mm0, QWORD PTR [rax+rbx*4]
    pcmpeqb mm0, QWORD PTR [rbx*8+0x10]
    pcmpeqb mm0, QWORD PTR [rip+0x100]
    pcmpeqb mm0, QWORD PTR [0x1000]
    pcmpeqb mm0, QWORD PTR [r13]
    pcmpeqb xmm1, [rax]
    pcmpeqb xmm1, [rax+0x7f]
    pcmpeqb xmm1, [rax+0x80]
    pcmpeqb xmm1, [rax+rbx*4]
    pcmpeqb xmm1, [rbx*8+0x10]
    pcmpeqb xmm1, [rip+0x100]
    pcmpeqb xmm1, [0x1000]
    pcmpeqb xmm1, [r13]
    pcmpeqw mm0, QWORD PTR [rax]
    pcmpeqw mm0, QWORD PTR [rax+0x7f]
    pcmpeqw mm0, QWORD PTR [rax+0x80]
    pcmpeqw mm0, QWORD PTR [rax+rbx*4]
    pcmpeqw mm0, QWORD PTR [rbx*8+0x10]
    pcmpeqw mm0, QWORD PTR [rip+0x100]
    pcmpeqw mm0, QWORD PTR [0x1000]
    pcmpeqw mm0, QWORD PTR [r13]
    pcmpeqw xmm1, [rax]
    pcmpeqw xmm1, [rax+0x7f]
    pcmpeqw xmm1, [rax+0x80]
    pcmpeqw xmm1, [rax+rbx*4]
    pcmpeqw xmm1, [rbx*8+0x10]
    pcmpeqw xmm1, [rip+0x100]
    pcmpeqw xmm1, [0x1000]
    pcmpeqw xmm1, [r13]
    pcmpeqd mm0, QWORD PTR [rax]
    pcmpeqd mm0, QWORD PTR [rax+0x7f]
    pcmpeqd mm0, QWORD PTR [rax+0x80]
    pcmpeqd mm0, QWORD PTR [rax+rbx*4]
    pcmpeqd mm0, QWORD PTR [rbx*8+0x10]
    pcmpeqd mm0, QWORD PTR [rip+0x100]
    pcmpeqd mm0, QWORD PTR [0x1000]
    pcmpeqd mm0, QWORD PTR [r13]
    pcmpeqd xmm1, [rax]
    pcmpeqd xmm1, [rax+0x7f]
    pcmpeqd xmm1, [rax+0x80]
    pcmpeqd xmm1, [rax+rbx*4]
    pcmpeqd xmm1, [rbx*8+0x10]
    pcmpeqd xmm1, [rip+0x100]
    pcmpeqd xmm1, [0x1000]
    pcmpeqd xmm1, [r13]
    vpcmpeqb xmm1, xmm2, [rax]
    vpcmpeqb xmm1, xmm2, [rax+0x7f]
    vpcmpeqb xmm1, xmm2, [rax+0x80]
    vpcmpeqb xmm1, xmm2, [rax+rbx*4]
    vpcmpeqb xmm1, xmm2, [rbx*8+0x10]
    vpcmpeqb xmm1, xmm2, [rip+0x100]
    vpcmpeqb xmm1, xmm2, [0x1000]
    vpcmpeqb xmm1, xmm2, [r13]
    vpcmpeqw xmm1, xmm2, [rax]
    vpcmpeqw xmm1, xmm2, [rax+0x7f]
    vpcmpeqw xmm1, xmm2, [rax+0x80]
    vpcmpeqw xmm1, xmm2, [rax+rbx*4]
    vpcmpeqw xmm1, xmm2, [rbx*8+0x10]
    vpcmpeqw xmm1, xmm2, [rip+0x100]
    vpcmpeqw xmm1, xmm2, [0x1000]
    vpcmpeqw xmm1, xmm2, [r13]
    vpcmpeqd xmm1, xmm2, [rax]
    vpcmpeqd xmm1, xmm2, [rax+0x7f]
    vpcmpeqd xmm1, xmm2, [rax+0x80]
    vpcmpeqd xmm1, xmm2, [rax+rbx*4]
    vpcmpeqd xmm1, xmm2, [rbx*8+0x10]
    vpcmpeqd xmm1, xmm2, [rip+0x100]
    vpcmpeqd xmm1, xmm2, [0x1000]
    vpcmpeqd xmm1, xmm2, [r13]
    vpcmpeqb ymm1, ymm2, [rax]
    vpcmpeqb ymm1, ymm2, [rax+0x7f]
    vpcmpeqb ymm1, ymm2, [rax+0x80]
    vpcmpeqb ymm1, ymm2, [rax+rbx*4]
    vpcmpeqb ymm1, ymm2, [rbx*8+0x10]
    vpcmpeqb ymm1, ymm2, [rip+0x100]
    vpcmpeqb ymm1, ymm2, [0x1000]
    vpcmpeqb ymm1, ymm2, [r13]
    vpcmpeqw ymm1, ymm2, [rax]
    vpcmpeqw ymm1, ymm2, [rax+0x7f]
    vpcmpeqw ymm1, ymm2, [rax+0x80]
    vpcmpeqw ymm1, ymm2, [rax+rbx*4]
    vpcmpeqw ymm1, ymm2, [rbx*8+0x10]
    vpcmpeqw ymm1, ymm2, [rip+0x100]
    vpcmpeqw ymm1, ymm2, [0x1000]
    vpcmpeqw ymm1, ymm2, [r13]
    vpcmpeqd ymm1, ymm2, [rax]
    vpcmpeqd ymm1, ymm2, [rax+0x7f]
    vpcmpeqd ymm1, ymm2, [rax+0x80]
    vpcmpeqd ymm1, ymm2, [rax+rbx*4]
    vpcmpeqd ymm1, ymm2, [rbx*8+0x10]
    vpcmpeqd ymm1, ymm2, [rip+0x100]
    vpcmpeqd ymm1, ymm2, [0x1000]
    vpcmpeqd ymm1, ymm2, [r13]
    pcmpeqq xmm1, [rax]
    pcmpeqq xmm1, [rax+0x7f]
    pcmpeqq xmm1, [rax+0x80]
    pcmpeqq xmm1, [rax+rbx*4]
    pcmpeqq xmm1, [rbx*8+0x10]
    pcmpeqq xmm1, [rip+0x100]
    pcmpeqq xmm1, [0x1000]
    pcmpeqq xmm1, [r13]
    vpcmpeqq xmm1, xmm2, [rax]
    vpcmpeqq xmm1, xmm2, [rax+0x7f]
    vpcmpeqq xmm1, xmm2, [rax+0x80]
    vpcmpeqq xmm1, xmm2, [rax+rbx*4]
    vpcmpeqq xmm1, xmm2, [rbx*8+0x10]
    vpcmpeqq xmm1, xmm2, [rip+0x100]
    vpcmpeqq xmm1, xmm2, [0x1000]
    vpcmpeqq xmm1, xmm2, [r13]
    vpcmpeqq ymm1, ymm2, [rax]
    vpcmpeqq ymm1, ymm2, [rax+0x7f]
    vpcmpeqq ymm1, ymm2, [rax+0x80]
    vpcmpeqq ymm1, ymm2, [rax+rbx*4]
    vpcmpeqq ymm1, ymm2, [rbx*8+0x10]
    vpcmpeqq ymm1, ymm2, [rip+0x100]
    vpcmpeqq ymm1, ymm2, [0x1000]
    vpcmpeqq ymm1, ymm2, [r13]
    pcmpestri xmm1, [rax], 0x1
    pcmpestri xmm1, [rax+0x7f], 0x1
    pcmpestri xmm1, [rax+0x80], 0x1
    pcmpestri xmm1, [rax+rbx*4], 0x1
    pcmpestri xmm1, [rbx*8+0x10], 0x1
    pcmpestri xmm1, [rip+0x100], 0x1
    pcmpestri xmm1, [0x1000], 0x1
    pcmpestri xmm1, [r13], 0x1
    vpcmpestri xmm1, [rax], 0x1
    vpcmpestri xmm1, [rax+0x7f], 0x1
    vpcmpestri xmm1, [rax+0x80], 0x1
    vpcmpestri xmm1, [rax+rbx*4], 0x1
    vpcmpestri xmm1, [rbx*8+0x10], 0x1
    vpcmpestri xmm1, [rip+0x100], 0x1
    vpcmpestri xmm1, [0x1000], 0x1
    vpcmpestri xmm1, [r13], 0x1
    pcmpestrm xmm1, [rax], 0x1
    pcmpestrm xmm1, [rax+0x7f], 0x1
    pcmpestrm xmm1, [rax+0x80], 0x1
    pcmpestrm xmm1, [rax+rbx*4], 0x1
    pcmpestrm xmm1, [rbx*8+0x10], 0x1
    pcmpestrm xmm1, [rip+0x100], 0x1
    pcmpestrm xmm1, [0x1000], 0x1
    pcmpestrm xmm1, [r13], 0x1
    vpcmpestrm xmm1, [rax], 0x1
    vpcmpestrm xmm1, [rax+0x7f], 0x1
    vpcmpestrm xmm1, [rax+0x80], 0x1
    vpcmpestrm xmm1, [rax+rbx*4], 0x1
    vpcmpestrm xmm1, [rbx*8+0x10], 0x1
    vpcmpestrm xmm1, [rip+0x100], 0x1
    vpcmpestrm xmm1, [0x1000], 0x1
    vpcmpestrm xmm1, [r13], 0x1
    pcmpgtb mm0, QWORD PTR [rax]
    pcmpgtb mm0, QWORD PTR [rax+0x7f]
    pcmpgtb mm0, QWORD PTR [rax+0x80]
    pcmpgtb mm0, QWORD PTR [rax+rbx*4]
    pcmpgtb mm0, QWORD PTR [rbx*8+0x10]
    pcmpgtb mm0, QWORD PTR [rip+0x100]
    pcmpgtb mm0, QWORD PTR [0x1000]
    pcmpgtb mm0, QWORD PTR [r13]
    pcmpgtb xmm1, [rax]
    pcmpgtb xmm1, [rax+0x7f]
    pcmpgtb xmm1, [rax+0x80]
    pcmpgtb xmm1, [rax+rbx*4]
    pcmpgtb xmm1, [rbx*8+0x10]
    pcmpgtb xmm1, [rip+0x100]
    pcmpgtb xmm1, [0x1000]
    pcmpgtb xmm1, [r13]
    pcmpgtw mm0, QWORD PTR [rax]
    pcmpgtw mm0, QWORD PTR [rax+0x7f]
    pcmpgtw mm0, QWORD PTR [rax+0x80]
    pcmpgtw mm0, QWORD PTR [rax+rbx*4]
    pcmpgtw mm0, QWORD PTR [rbx*8+0x10]
    pcmpgtw mm0, QWORD PTR [rip+0x100]
    pcmpgtw mm0, QWORD PTR [0x1000]
    pcmpgtw mm0, QWORD PTR [r13]
    pcmpgtw xmm1, [rax]
    pcmpgtw xmm1, [rax+0x7f]
    pcmpgtw xmm1, [rax+0x80]
    pcmpgtw xmm1, [rax+rbx*4]
    pcmpgtw xmm1, [rbx*8+0x10]
    pcmpgtw xmm1, [rip+0x100]
    pcmpgtw xmm1, [0x1000]
    pcmpgtw xmm1, [r13]
    pcmpgtd mm0, QWORD PTR [rax]
    pcmpgtd mm0, QWORD PTR [rax+0x7f]
    pcmpgtd mm0, QWORD PTR [rax+0x80]
    pcmpgtd mm0, QWORD PTR [rax+rbx*4]
    pcmpgtd mm0, QWORD PTR [rbx*8+0x10]
    pcmpgtd mm0, QWORD PTR [rip+0x100]
    pcmpgtd mm0, QWORD PTR [0x1000]
    pcmpgtd mm0, QWORD PTR [r13]
    pcmpgtd xmm1, [rax]
    pcmpgtd xmm1, [rax+0x7f]
    pcmpgtd xmm1, [rax+0x80]
    pcmpgtd xmm1, [rax+rbx*4]
    pcmpgtd xmm1, [rbx*8+0x10]
    pcmpgtd xmm1, [rip+0x100]
    pcmpgtd xmm1, [0x1000]
    pcmpgtd xmm1, [r13]
    vpcmpgtb xmm1, xmm2, [rax]
    vpcmpgtb xmm1, xmm2, [rax+0x7f]
    vpcmpgtb xmm1, xmm2, [rax+0x80]
    vpcmpgtb xmm1, xmm2, [rax+rbx*4]
    vpcmpgtb xmm1, xmm2, [rbx*8+0x10]
    vpcmpgtb xmm1, xmm2, [rip+0x100]
    vpcmpgtb xmm1, xmm2, [0x1000]
    vpcmpgtb xmm1, xmm2, [r13]
    vpcmpgtw xmm1, xmm2, [rax]
    vpcmpgtw xmm1, xmm2, [rax+0x7f]
    vpcmpgtw xmm1, xmm2, [rax+0x80]
    vpcmpgtw xmm1, xmm2, [rax+rbx*4]
    vpcmpgtw xmm1, xmm2, [rbx*8+0x10]
    vpcmpgtw xmm1, xmm2, [rip+0x100]
    vpcmpgtw xmm1, xmm2, [0x1000]
    vpcmpgtw xmm1, xmm2, [r13]
    vpcmpgtd xmm1, xmm2, [rax]
    vpcmpgtd xmm1, xmm2, [rax+0x7f]
    vpcmpgtd xmm1, xmm2, [rax+0x80]
    vpcmpgtd xmm1, xmm2, [rax+rbx*4]
    vpcmpgtd xmm1, xmm2, [rbx*8+0x10]
    vpcmpgtd xmm1, xmm2, [rip+0x100]
    vpcmpgtd xmm1, xmm2, [0x1000]
    vpcmpgtd xmm1, xmm2, [r13]
    vpcmpgtb ymm1, ymm2, [rax]
    vpcmpgtb ymm1, ymm2, [rax+0x7f]
    vpcmpgtb ymm1, ymm2, [rax+0x80]
    vpcmpgtb ymm1, ymm2, [rax+rbx*4]
    vpcmpgtb ymm1, ymm2, [rbx*8+0x10]
    vpcmpgtb ymm1, ymm2, [rip+0x100]
    vpcmpgtb ymm1, ymm2, [0x1000]
    vpcmpgtb ymm1, ymm2, [r13]
    vpcmpgtw ymm1, ymm2, [rax]
    vpcmpgtw ymm1, ymm2, [rax+0x7f]
    vpcmpgtw ymm1, ymm2, [rax+0x80]
    vpcmpgtw ymm1, ymm2, [rax+rbx*4]
    vpcmpgtw ymm1, ymm2, [rbx*8+0x10]
    vpcmpgtw ymm1, ymm2, [rip+0x100]
    vpcmpgtw ymm1, ymm2, [0x1000]
    vpcmpgtw ymm1, ymm2, [r13]
    vpcmpgtd ymm1, ymm2, [rax]
    vpcmpgtd ymm1, ymm2, [rax+0x7f]
    vpcmpgtd ymm1, ymm2, [rax+0x80]
    vpcmpgtd ymm1, ymm2, [rax+rbx*4]
    vpcmpgtd ymm1, ymm2, [rbx*8+0x10]
    vpcmpgtd ymm1, ymm2, [rip+0x100]
    vpcmpgtd ymm1, ymm2, [0x1000]
    vpcmpgtd ymm1, ymm2, [r13]
    pcmpgtq xmm1, [rax]
    pcmpgtq xmm1, [rax+0x7f]
    pcmpgtq xmm1, [rax+0x80]
    pcmpgtq xmm1, [rax+rbx*4]
    pcmpgtq xmm1, [rbx*8+0x10]
    pcmpgtq xmm1, [rip+0x100]
    pcmpgtq xmm1, [0x1000]
    pcmpgtq xmm1, [r13]
    vpcmpgtq xmm1, xmm2, [rax]
    vpcmpgtq xmm1, xmm2, [rax+0x7f]
    vpcmpgtq xmm1, xmm2, [rax+0x80]
    vpcmpgtq xmm1, xmm2, [rax+rbx*4]
    vpcmpgtq xmm1, xmm2, [rbx*8+0x10]
    vpcmpgtq xmm1, xmm2, [rip+0x100]
    vpcmpgtq xmm1, xmm2, [0x1000]
    vpcmpgtq xmm1, xmm2, [r13]
    vpcmpgtq ymm1, ymm2, [rax]
    vpcmpgtq ymm1, ymm2, [rax+0x7f]
    vpcmpgtq ymm1, ymm2, [rax+0x80]
    vpcmpgtq ymm1, ymm2, [rax+rbx*4]
    vpcmpgtq ymm1, ymm2, [rbx*8+0x10]
    vpcmpgtq ymm1, ymm2, [rip+0x100]
    vpcmpgtq ymm1, ymm2, [0x1000]
    vpcmpgtq ymm1, ymm2, [r13]
    pcmpistri xmm1, [rax], 0x1
    pcmpistri xmm1, [rax+0x7f], 0x1
    pcmpistri xmm1, [rax+0x80], 0x1
    pcmpistri xmm1, [rax+rbx*4], 0x1
    pcmpistri xmm1, [rbx*8+0x10], 0x1
    pcmpistri xmm1, [rip+0x100], 0x1
    pcmpistri xmm1, [0x1000], 0x1
    pcmpistri xmm1, [r13], 0x1
    vpcmpistri xmm1, [rax], 0x1
    vpcmpistri xmm1, [rax+0x7f], 0x1
    vpcmpistri xmm1, [rax+0x80], 0x1
    vpcmpistri xmm1, [rax+rbx*4], 0x1
    vpcmpistri xmm1, [rbx*8+0x10], 0x1
    vpcmpistri xmm1, [rip+0x100], 0x1
    vpcmpistri xmm1, [0x1000], 0x1
    vpcmpistri xmm1, [r13], 0x1
    pcmpistrm xmm1, [rax], 0x1
    pcmpistrm xmm1, [rax+0x7f], 0x1
    pcmpistrm xmm1, [rax+0x80], 0x1
    pcmpistrm xmm1, [rax+rbx*4], 0x1
    pcmpistrm xmm1, [rbx*8+0x10], 0x1
    pcmpistrm xmm1, [rip+0x100], 0x1
    pcmpistrm xmm1, [0x1000], 0x1
    pcmpistrm xmm1, [r13], 0x1
    vpcmpistrm xmm1, [rax], 0x1
    vpcmpistrm xmm1, [rax+0x7f], 0x1
    vpcmpistrm xmm1, [rax+0x80], 0x1
    vpcmpistrm xmm1, [rax+rbx*4], 0x1
    vpcmpistrm xmm1, [rbx*8+0x10], 0x1
    vpcmpistrm xmm1, [rip+0x100], 0x1
    vpcmpistrm xmm1, [0x1000], 0x1
    vpcmpistrm xmm1, [r13], 0x1
    pdep eax, eax, DWORD PTR [rax]
    pdep eax, eax, DWORD PTR [rax+0x7f]
    pdep eax, eax, DWORD PTR [rax+0x80]
    pdep eax, eax, DWORD PTR [rax+rbx*4]
    pdep eax, eax, DWORD PTR [rbx*8+0x10]
    pdep eax, eax, DWORD PTR [rip+0x100]
    pdep eax, eax, DWORD PTR [0x1000]
    pdep eax, eax, DWORD PTR [r13]
    pdep rax, rax, QWORD PTR [rax]
    pdep rax, rax, QWORD PTR [rax+0x7f]
    pdep rax, rax, QWORD PTR [rax+0x80]
    pdep rax, rax, QWORD PTR [rax+rbx*4]
    pdep rax, rax, QWORD PTR [rbx*8+0x10]
    pdep rax, rax, QWORD PTR [rip+0x100]
    pdep rax, rax, QWORD PTR [0x1000]
    pdep rax, rax, QWORD PTR [r13]
    pext eax, eax, DWORD PTR [rax]
    pext eax, eax, DWORD PTR [rax+0x7f]
    pext eax, eax, DWORD PTR [rax+0x80]
    pext eax, eax, DWORD PTR [rax+rbx*4]
    pext eax, eax, DWORD PTR [rbx*8+0x10]
    pext eax, eax, DWORD PTR [rip+0x100]
    pext eax, eax, DWORD PTR [0x1000]
    pext eax, eax, DWORD PTR [r13]
    pext rax, rax, QWORD PTR [rax]
    pext rax, rax, QWORD PTR [rax+0x7f]
    pext rax, rax, QWORD PTR [rax+0x80]
    pext rax, rax, QWORD PTR [rax+rbx*4]
    pext rax, rax, QWORD PTR [rbx*8+0x10]
    pext rax, rax, QWORD PTR [rip+0x100]
    pext rax, rax, QWORD PTR [0x1000]
    pext rax, rax, QWORD PTR [r13]
    pextrb BYTE PTR [rax], xmm2, 0x1
    pextrb BYTE PTR [rax+0x7f], xmm2, 0x1
    pextrb BYTE PTR [rax+0x80], xmm2, 0x1
    pextrb BYTE PTR [rax+rbx*4], xmm2, 0x1
    pextrb BYTE PTR [rbx*8+0x10], xmm2, 0x1
    pextrb BYTE PTR [rip+0x100], xmm2, 0x1
    pextrb BYTE PTR [0x1000], xmm2, 0x1
    pextrb BYTE PTR [r13], xmm2, 0x1
    pextrd DWORD PTR [rax], xmm2, 0x1
    pextrd DWORD PTR [rax+0x7f], xmm2, 0x1
    pextrd DWORD PTR [rax+0x80], xmm2, 0x1
    pextrd DWORD PTR [rax+rbx*4], xmm2, 0x1
    pextrd DWORD PTR [rbx*8+0x10], xmm2, 0x1
    pextrd DWORD PTR [rip+0x100], xmm2, 0x1
    pextrd DWORD PTR [0x1000], xmm2, 0x1
    pextrd DWORD PTR [r13], xmm2, 0x1
    pextrq QWORD PTR [rax], xmm2, 0x1
    pextrq QWORD PTR [rax+0x7f], xmm2, 0x1
    pextrq QWORD PTR [rax+0x80], xmm2, 0x1
    pextrq QWORD PTR [rax+rbx*4], xmm2, 0x1
    pextrq QWORD PTR [rbx*8+0x10], xmm2, 0x1
    pextrq QWORD PTR [rip+0x100], xmm2, 0x1
    pextrq QWORD PTR [0x1000], xmm2, 0x1
    pextrq QWORD PTR [r13], xmm2, 0x1
    vpextrb BYTE PTR [rax], xmm2, 0x1
    vpextrb BYTE PTR [rax+0x7f], xmm2, 0x1
    vpextrb BYTE PTR [rax+0x80], xmm2, 0x1
    vpextrb BYTE PTR [rax+rbx*4], xmm2, 0x1
    vpextrb BYTE PTR [rbx*8+0x10], xmm2, 0x1
    vpextrb BYTE PTR [rip+0x100], xmm2, 0x1
    vpextrb BYTE PTR [0x1000], xmm2, 0x1
    vpextrb BYTE PTR [r13], xmm2, 0x1
    vpextrd DWORD PTR [rax], xmm2, 0x1
    vpextrd DWORD PTR [rax+0x7f], xmm2, 0x1
    vpextrd DWORD PTR [rax+0x80], xmm2, 0x1
    vpextrd DWORD PTR [rax+rbx*4], xmm2, 0x1
    vpextrd DWORD PTR [rbx*8+0x10], xmm2, 0x1
    vpextrd DWORD PTR [rip+0x100], xmm2, 0x1
    vpextrd DWORD PTR [0x1000], xmm2, 0x1
    vpextrd DWORD PTR [r13], xmm2, 0x1
    vpextrq QWORD PTR [rax], xmm2, 0x1
    vpextrq QWORD PTR [rax+0x7f], xmm2, 0x1
    vpextrq QWORD PTR [rax+0x80], xmm2, 0x1
    vpextrq QWORD PTR [rax+rbx*4], xmm2, 0x1
    vpextrq QWORD PTR [rbx*8+0x10], xmm2, 0x1
    vpextrq QWORD PTR [rip+0x100], xmm2, 0x1
    vpextrq QWORD PTR [0x1000], xmm2, 0x1
    vpextrq QWORD PTR [r13], xmm2, 0x1
    pextrw WORD PTR [rax], xmm0, 0x1
    pextrw WORD PTR [rax+0x7f], xmm0, 0x1
    pextrw WORD PTR [rax+0x80], xmm0, 0x1
    pextrw WORD PTR [rax+rbx*4], xmm0, 0x1
    pextrw WORD PTR [rbx*8+0x10], xmm0, 0x1
    pextrw WORD PTR [rip+0x100], xmm0, 0x1
    pextrw WORD PTR [0x1000], xmm0, 0x1
    pextrw WORD PTR [r13], xmm0, 0x1
    vpextrw WORD PTR [rax], xmm2, 0x1
    vpextrw WORD PTR [rax+0x7f], xmm2, 0x1
    vpextrw WORD PTR [rax+0x80], xmm2, 0x1
    vpextrw WORD PTR [rax+rbx*4], xmm2, 0x1
    vpextrw WORD PTR [rbx*8+0x10], xmm2, 0x1
    vpextrw WORD PTR [rip+0x100], xmm2, 0x1
    vpextrw WORD PTR [0x1000], xmm2, 0x1
    vpextrw WORD PTR [r13], xmm2, 0x1
    phaddsw mm1, QWORD PTR [rax]
    phaddsw mm1, QWORD PTR [rax+0x7f]
    phaddsw mm1, QWORD PTR [rax+0x80]
    phaddsw mm1, QWORD PTR [rax+rbx*4]
    phaddsw mm1, QWORD PTR [rbx*8+0x10]
    phaddsw mm1, QWORD PTR [rip+0x100]
    phaddsw mm1, QWORD PTR [0x1000]
    phaddsw mm1, QWORD PTR [r13]
    phaddsw xmm1, [rax]
    phaddsw xmm1, [rax+0x7f]
    phaddsw xmm1, [rax+0x80]
    phaddsw xmm1, [rax+rbx*4]
    phaddsw xmm1, [rbx*8+0x10]
    phaddsw xmm1, [rip+0x100]
    phaddsw xmm1, [0x1000]
    phaddsw xmm1, [r13]
    vphaddsw xmm1, xmm2, [rax]
    vphaddsw xmm1, xmm2, [rax+0x7f]
    vphaddsw xmm1, xmm2, [rax+0x80]
    vphaddsw xmm1, xmm2, [rax+rbx*4]
    vphaddsw xmm1, xmm2, [rbx*8+0x10]
    vphaddsw xmm1, xmm2, [rip+0x100]
    vphaddsw xmm1, xmm2, [0x1000]
    vphaddsw xmm1, xmm2, [r13]
    vphaddsw ymm1, ymm2, [rax]
    vphaddsw ymm1, ymm2, [rax+0x7f]
    vphaddsw ymm1, ymm2, [rax+0x80]
    vphaddsw ymm1, ymm2, [rax+rbx*4]
    vphaddsw ymm1, ymm2, [rbx*8+0x10]
    vphaddsw ymm1, ymm2, [rip+0x100]
    vphaddsw ymm1, ymm2, [0x1000]
    vphaddsw ymm1, ymm2, [r13]
    phaddw mm1, QWORD PTR [rax]
    phaddw mm1, QWORD PTR [rax+0x7f]
    phaddw mm1, QWORD PTR [rax+0x80]
    phaddw mm1, QWORD PTR [rax+rbx*4]
    phaddw mm1, QWORD PTR [rbx*8+0x10]
    phaddw mm1, QWORD PTR [rip+0x100]
    phaddw mm1, QWORD PTR [0x1000]
    phaddw mm1, QWORD PTR [r13]
    phaddw xmm1, [rax]
    phaddw xmm1, [rax+0x7f]
    phaddw xmm1, [rax+0x80]
    phaddw xmm1, [rax+rbx*4]
    phaddw xmm1, [rbx*8+0x10]
    phaddw xmm1, [rip+0x100]
    phaddw xmm1, [0x1000]
    phaddw xmm1, [r13]
    phaddd mm1, QWORD PTR [rax]
    phaddd mm1, QWORD PTR [rax+0x7f]
    phaddd mm1, QWORD PTR [rax+0x80]
    phaddd mm1, QWORD PTR [rax+rbx*4]
    phaddd mm1, QWORD PTR [rbx*8+0x10]
    phaddd mm1, QWORD PTR [rip+0x100]
    phaddd mm1, QWORD PTR [0x1000]
    phaddd mm1, QWORD PTR [r13]
    phaddd xmm1, [rax]
    phaddd xmm1, [rax+0x7f]
    phaddd xmm1, [rax+0x80]
    phaddd xmm1, [rax+rbx*4]
    phaddd xmm1, [rbx*8+0x10]
    phaddd xmm1, [rip+0x100]
    phaddd xmm1, [0x1000]
    phaddd xmm1, [r13]
    vphaddw xmm1, xmm2, [rax]
    vphaddw xmm1, xmm2, [rax+0x7f]
    vphaddw xmm1, xmm2, [rax+0x80]
    vphaddw xmm1, xmm2, [rax+rbx*4]
    vphaddw xmm1, xmm2, [rbx*8+0x10]
    vphaddw xmm1, xmm2, [rip+0x100]
    vphaddw xmm1, xmm2, [0x1000]
    vphaddw xmm1, xmm2, [r13]
    vphaddd xmm1, xmm2, [rax]
    vphaddd xmm1, xmm2, [rax+0x7f]
    vphaddd xmm1, xmm2, [rax+0x80]
    vphaddd xmm1, xmm2, [rax+rbx*4]
    vphaddd xmm1, xmm2, [rbx*8+0x10]
    vphaddd xmm1, xmm2, [rip+0x100]
    vphaddd xmm1, xmm2, [0x1000]
    vphaddd xmm1, xmm2, [r13]
    vphaddw ymm1, ymm2, [rax]
    vphaddw ymm1, ymm2, [rax+0x7f]
    vphaddw ymm1, ymm2, [rax+0x80]
    vphaddw ymm1, ymm2, [rax+rbx*4]
    vphaddw ymm1, ymm2, [rbx*8+0x10]
    vphaddw ymm1, ymm2, [rip+0x100]
    vphaddw ymm1, ymm2, [0x1000]
    vphaddw ymm1, ymm2, [r13]
    vphaddd ymm1, ymm2, [rax]
    vphaddd ymm1, ymm2, [rax+0x7f]
    vphaddd ymm1, ymm2, [rax+0x80]
    vphaddd ymm1, ymm2, [rax+rbx*4]
    vphaddd ymm1, ymm2, [rbx*8+0x10]
    vphaddd ymm1, ymm2, [rip+0x100]
    vphaddd ymm1, ymm2, [0x1000]
    vphaddd ymm1, ymm2, [r13]
    phminposuw xmm1, [rax]
    phminposuw xmm1, [rax+0x7f]
    phminposuw xmm1, [rax+0x80]
    phminposuw xmm1, [rax+rbx*4]
    phminposuw xmm1, [rbx*8+0x10]
    phminposuw xmm1, [rip+0x100]
    phminposuw xmm1, [0x1000]
    phminposuw xmm1, [r13]
    vphminposuw xmm1, [rax]
    vphminposuw xmm1, [rax+0x7f]
    vphminposuw xmm1, [rax+0x80]
    vphminposuw xmm1, [rax+rbx*4]
    vphminposuw xmm1, [rbx*8+0x10]
    vphminposuw xmm1, [rip+0x100]
    vphminposuw xmm1, [0x1000]
    vphminposuw xmm1, [r13]
    phsubsw mm1, QWORD PTR [rax]
    phsubsw mm1, QWORD PTR [rax+0x7f]
    phsubsw mm1, QWORD PTR [rax+0x80]
    phsubsw mm1, QWORD PTR [rax+rbx*4]
    phsubsw mm1, QWORD PTR [rbx*8+0x10]
    phsubsw mm1, QWORD PTR [rip+0x100]
    phsubsw mm1, QWORD PTR [0x1000]
    phsubsw mm1, QWORD PTR [r13]
    phsubsw xmm1, [rax]
    phsubsw xmm1, [rax+0x7f]
    phsubsw xmm1, [rax+0x80]
    phsubsw xmm1, [rax+rbx*4]
    phsubsw xmm1, [rbx*8+0x10]
    phsubsw xmm1, [rip+0x100]
    phsubsw xmm1, [0x1000]
    phsubsw xmm1, [r13]
    vphsubsw xmm1, xmm2, [rax]
    vphsubsw xmm1, xmm2, [rax+0x7f]
    vphsubsw xmm1, xmm2, [rax+0x80]
    vphsubsw xmm1, xmm2, [rax+rbx*4]
    vphsubsw xmm1, xmm2, [rbx*8+0x10]
    vphsubsw xmm1, xmm2, [rip+0x100]
    vphsubsw xmm1, xmm2, [0x1000]
    vphsubsw xmm1, xmm2, [r13]
    vphsubsw ymm1, ymm2, [rax]
    vphsubsw ymm1, ymm2, [rax+0x7f]
    vphsubsw ymm1, ymm2, [rax+0x80]
    vphsubsw ymm1, ymm2, [rax+rbx*4]
    vphsubsw ymm1, ymm2, [rbx*8+0x10]
    vphsubsw ymm1, ymm2, [rip+0x100]
    vphsubsw ymm1, ymm2, [0x1000]
    vphsubsw ymm1, ymm2, [r13]
    phsubw mm1, QWORD PTR [rax]
    phsubw mm1, QWORD PTR [rax+0x7f]
    phsubw mm1, QWORD PTR [rax+0x80]
    phsubw mm1, QWORD PTR [rax+rbx*4]
    phsubw mm1, QWORD PTR [rbx*8+0x10]
    phsubw mm1, QWORD PTR [rip+0x100]
    phsubw mm1, QWORD PTR [0x1000]
    phsubw mm1, QWORD PTR [r13]
    phsubw xmm1, [rax]
    phsubw xmm1, [rax+0x7f]
    phsubw xmm1, [rax+0x80]
    phsubw xmm1, [rax+rbx*4]
    phsubw xmm1, [rbx*8+0x10]
    phsubw xmm1, [rip+0x100]
    phsubw xmm1, [0x1000]
    phsubw xmm1, [r13]
    phsubd mm1, QWORD PTR [rax]
    phsubd mm1, QWORD PTR [rax+0x7f]
    phsubd mm1, QWORD PTR [rax+0x80]
    phsubd mm1, QWORD PTR [rax+rbx*4]
    phsubd mm1, QWORD PTR [rbx*8+0x10]
    phsubd mm1, QWORD PTR [rip+0x100]
    phsubd mm1, QWORD PTR [0x1000]
    phsubd mm1, QWORD PTR [r13]
    phsubd xmm1, [rax]
    phsubd xmm1, [rax+0x7f]
    phsubd xmm1, [rax+0x80]
    phsubd xmm1, [rax+rbx*4]
    phsubd xmm1, [rbx*8+0x10]
    phsubd xmm1, [rip+0x100]
    phsubd xmm1, [0x1000]
    phsubd xmm1, [r13]
    vphsubw xmm1, xmm2, [rax]
    vphsubw xmm1, xmm2, [rax+0x7f]
    vphsubw xmm1, xmm2, [rax+0x80]
    vphsubw xmm1, xmm2, [rax+rbx*4]
    vphsubw xmm1, xmm2, [rbx*8+0x10]
    vphsubw xmm1, xmm2, [rip+0x100]
    vphsubw xmm1, xmm2, [0x1000]
    vphsubw xmm1, xmm2, [r13]
    vphsubd xmm1, xmm2, [rax]
    vphsubd xmm1, xmm2, [rax+0x7f]
    vphsubd xmm1, xmm2, [rax+0x80]
    vphsubd xmm1, xmm2, [rax+rbx*4]
    vphsubd xmm1, xmm2, [rbx*8+0x10]
    vphsubd xmm1, xmm2, [rip+0x100]
    vphsubd xmm1, xmm2, [0x1000]
    vphsubd xmm1, xmm2, [r13]
    vphsubw ymm1, ymm2, [rax]
    vphsubw ymm1, ymm2, [rax+0x7f]
    vphsubw ymm1, ymm2, [rax+0x80]
    vphsubw ymm1, ymm2, [rax+rbx*4]
    vphsubw ymm1, ymm2, [rbx*8+0x10]
    vphsubw ymm1, ymm2, [rip+0x100]
    vphsubw ymm1, ymm2, [0x1000]
    vphsubw ymm1, ymm2, [r13]
    vphsubd ymm1, ymm2, [rax]
    vphsubd ymm1, ymm2, [rax+0x7f]
    vphsubd ymm1, ymm2, [rax+0x80]
    vphsubd ymm1, ymm2, [rax+rbx*4]
    vphsubd ymm1, ymm2, [rbx*8+0x10]
    vphsubd ymm1, ymm2, [rip+0x100]
    vphsubd ymm1, ymm2, [0x1000]
    vphsubd ymm1, ymm2, [r13]
    pinsrb xmm1, BYTE PTR [rax], 0x1
    pinsrb xmm1, BYTE PTR [rax+0x7f], 0x1
    pinsrb xmm1, BYTE PTR [rax+0x80], 0x1
    pinsrb xmm1, BYTE PTR [rax+rbx*4], 0x1
    pinsrb xmm1, BYTE PTR [rbx*8+0x10], 0x1
    pinsrb xmm1, BYTE PTR [rip+0x100], 0x1
    pinsrb xmm1, BYTE PTR [0x1000], 0x1
    pinsrb xmm1, BYTE PTR [r13], 0x1
    pinsrd xmm1, DWORD PTR [rax], 0x1
    pinsrd xmm1, DWORD PTR [rax+0x7f], 0x1
    pinsrd xmm1, DWORD PTR [rax+0x80], 0x1
    pinsrd xmm1, DWORD PTR [rax+rbx*4], 0x1
    pinsrd xmm1, DWORD PTR [rbx*8+0x10], 0x1
    pinsrd xmm1, DWORD PTR [rip+0x100], 0x1
    pinsrd xmm1, DWORD PTR [0x1000], 0x1
    pinsrd xmm1, DWORD PTR [r13], 0x1
    pinsrq xmm1, QWORD PTR [rax], 0x1
    pinsrq xmm1, QWORD PTR [rax+0x7f], 0x1
    pinsrq xmm1, QWORD PTR [rax+0x80], 0x1
    pinsrq xmm1, QWORD PTR [rax+rbx*4], 0x1
    pinsrq xmm1, QWORD PTR [rbx*8+0x10], 0x1
    pinsrq xmm1, QWORD PTR [rip+0x100], 0x1
    pinsrq xmm1, QWORD PTR [0x1000], 0x1
    pinsrq xmm1, QWORD PTR [r13], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rax], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rax+0x7f], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rax+0x80], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rax+rbx*4], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rbx*8+0x10], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rip+0x100], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [0x1000], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [r13], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax+0x7f], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax+0x80], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax+rbx*4], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rbx*8+0x10], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rip+0x100], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [0x1000], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [r13], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax+0x7f], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax+0x80], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax+rbx*4], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rbx*8+0x10], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rip+0x100], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [0x1000], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [r13], 0x1
    pinsrw xmm0, WORD PTR [rax], 0x1
    pinsrw xmm0, WORD PTR [rax+0x7f], 0x1
    pinsrw xmm0, WORD PTR [rax+0x80], 0x1
    pinsrw xmm0, WORD PTR [rax+rbx*4], 0x1
    pinsrw xmm0, WORD PTR [rbx*8+0x10], 0x1
    pinsrw xmm0, WORD PTR [rip+0x100], 0x1
    pinsrw xmm0, WORD PTR [0x1000], 0x1
    pinsrw xmm0, WORD PTR [r13], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax+0x7f], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax+0x80], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax+rbx*4], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rbx*8+0x10], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rip+0x100], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [0x1000], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [r13], 0x1
    pmaddubsw mm1, QWORD PTR [rax]
    pmaddubsw mm1, QWORD PTR [rax+0x7f]
    pmaddubsw mm1, QWORD PTR [rax+0x80]
    pmaddubsw mm1, QWORD PTR [rax+rbx*4]
    pmaddubsw mm1, QWORD PTR [rbx*8+0x10]
    pmaddubsw mm1, QWORD PTR [rip+0x100]
    pmaddubsw mm1, QWORD PTR [0x1000]
    pmaddubsw mm1, QWORD PTR [r13]
    pmaddubsw xmm1, [rax]
    pmaddubsw xmm1, [rax+0x7f]
    pmaddubsw xmm1, [rax+0x80]
    pmaddubsw xmm1, [rax+rbx*4]
    pmaddubsw xmm1, [rbx*8+0x10]
    pmaddubsw xmm1, [rip+0x100]
    pmaddubsw xmm1, [0x1000]
    pmaddubsw xmm1, [r13]
    vpmaddubsw xmm1, xmm2, [rax]
    vpmaddubsw xmm1, xmm2, [rax+0x7f]
    vpmaddubsw xmm1, xmm2, [rax+0x80]
    vpmaddubsw xmm1, xmm2, [rax+rbx*4]
    vpmaddubsw xmm1, xmm2, [rbx*8+0x10]
    vpmaddubsw xmm1, xmm2, [rip+0x100]
    vpmaddubsw xmm1, xmm2, [0x1000]
    vpmaddubsw xmm1, xmm2, [r13]
    vpmaddubsw ymm1, ymm2, [rax]
    vpmaddubsw ymm1, ymm2, [rax+0x7f]
    vpmaddubsw ymm1, ymm2, [rax+0x80]
    vpmaddubsw ymm1, ymm2, [rax+rbx*4]
    vpmaddubsw ymm1, ymm2, [rbx*8+0x10]
    vpmaddubsw ymm1, ymm2, [rip+0x100]
    vpmaddubsw ymm1, ymm2, [0x1000]
    vpmaddubsw ymm1, ymm2, [r13]
    pmaddwd mm0, QWORD PTR [rax]
    pmaddwd mm0, QWORD PTR [rax+0x7f]
    pmaddwd mm0, QWORD PTR [rax+0x80]
    pmaddwd mm0, QWORD PTR [rax+rbx*4]
    pmaddwd mm0, QWORD PTR [rbx*8+0x10]
    pmaddwd mm0, QWORD PTR [rip+0x100]
    pmaddwd mm0, QWORD PTR [0x1000]
    pmaddwd mm0, QWORD PTR [r13]
    pmaddwd xmm1, [rax]
    pmaddwd xmm1, [rax+0x7f]
    pmaddwd xmm1, [rax+0x80]
    pmaddwd xmm1, [rax+rbx*4]
    pmaddwd xmm1, [rbx*8+0x10]
    pmaddwd xmm1, [rip+0x100]
    pmaddwd xmm1, [0x1000]
    pmaddwd xmm1, [r13]
    vpmaddwd xmm1, xmm2, [rax]
    vpmaddwd xmm1, xmm2, [rax+0x7f]
    vpmaddwd xmm1, xmm2, [rax+0x80]
    vpmaddwd xmm1, xmm2, [rax+rbx*4]
    vpmaddwd xmm1, xmm2, [rbx*8+0x10]
    vpmaddwd xmm1, xmm2, [rip+0x100]
    vpmaddwd xmm1, xmm2, [0x1000]
    vpmaddwd xmm1, xmm2, [r13]
    vpmaddwd ymm1, ymm2, [rax]
    vpmaddwd ymm1, ymm2, [rax+0x7f]
    vpmaddwd ymm1, ymm2, [rax+0x80]
    vpmaddwd ymm1, ymm2, [rax+rbx*4]
    vpmaddwd ymm1, ymm2, [rbx*8+0x10]
    vpmaddwd ymm1, ymm2, [rip+0x100]
    vpmaddwd ymm1, ymm2, [0x1000]
    vpmaddwd ymm1, ymm2, [r13]
    pmaxsw mm1, QWORD PTR [rax]
    pmaxsw mm1, QWORD PTR [rax+0x7f]
    pmaxsw mm1, QWORD PTR [rax+0x80]
    pmaxsw mm1, QWORD PTR [rax+rbx*4]
    pmaxsw mm1, QWORD PTR [rbx*8+0x10]
    pmaxsw mm1, QWORD PTR [rip+0x100]
    pmaxsw mm1, QWORD PTR [0x1000]
    pmaxsw mm1, QWORD PTR [r13]
    pmaxsb xmm1, [rax]
    pmaxsb xmm1, [rax+0x7f]
    pmaxsb xmm1, [rax+0x80]
    pmaxsb xmm1, [rax+rbx*4]
    pmaxsb xmm1, [rbx*8+0x10]
    pmaxsb xmm1, [rip+0x100]
    pmaxsb xmm1, [0x1000]
    pmaxsb xmm1, [r13]
    pmaxsw xmm1, [rax]
    pmaxsw xmm1, [rax+0x7f]
    pmaxsw xmm1, [rax+0x80]
    pmaxsw xmm1, [rax+rbx*4]
    pmaxsw xmm1, [rbx*8+0x10]
    pmaxsw xmm1, [rip+0x100]
    pmaxsw xmm1, [0x1000]
    pmaxsw xmm1, [r13]
    pmaxsd xmm1, [rax]
    pmaxsd xmm1, [rax+0x7f]
    pmaxsd xmm1, [rax+0x80]
    pmaxsd xmm1, [rax+rbx*4]
    pmaxsd xmm1, [rbx*8+0x10]
    pmaxsd xmm1, [rip+0x100]
    pmaxsd xmm1, [0x1000]
    pmaxsd xmm1, [r13]
    vpmaxsb xmm1, xmm2, [rax]
    vpmaxsb xmm1, xmm2, [rax+0x7f]
    vpmaxsb xmm1, xmm2, [rax+0x80]
    vpmaxsb xmm1, xmm2, [rax+rbx*4]
    vpmaxsb xmm1, xmm2, [rbx*8+0x10]
    vpmaxsb xmm1, xmm2, [rip+0x100]
    vpmaxsb xmm1, xmm2, [0x1000]
    vpmaxsb xmm1, xmm2, [r13]
    vpmaxsw xmm1, xmm2, [rax]
    vpmaxsw xmm1, xmm2, [rax+0x7f]
    vpmaxsw xmm1, xmm2, [rax+0x80]
    vpmaxsw xmm1, xmm2, [rax+rbx*4]
    vpmaxsw xmm1, xmm2, [rbx*8+0x10]
    vpmaxsw xmm1, xmm2, [rip+0x100]
    vpmaxsw xmm1, xmm2, [0x1000]
    vpmaxsw xmm1, xmm2, [r13]
    vpmaxsd xmm1, xmm2, [rax]
    vpmaxsd xmm1, xmm2, [rax+0x7f]
    vpmaxsd xmm1, xmm2, [rax+0x80]
    vpmaxsd xmm1, xmm2, [rax+rbx*4]
    vpmaxsd xmm1, xmm2, [rbx*8+0x10]
    vpmaxsd xmm1, xmm2, [rip+0x100]
    vpmaxsd xmm1, xmm2, [0x1000]
    vpmaxsd xmm1, xmm2, [r13]
    vpmaxsb ymm1, ymm2, [rax]
    vpmaxsb ymm1, ymm2, [rax+0x7f]
    vpmaxsb ymm1, ymm2, [rax+0x80]
    vpmaxsb ymm1, ymm2, [rax+rbx*4]
    vpmaxsb ymm1, ymm2, [rbx*8+0x10]
    vpmaxsb ymm1, ymm2, [rip+0x100]
    vpmaxsb ymm1, ymm2, [0x1000]
    vpmaxsb ymm1, ymm2, [r13]
    vpmaxsw ymm1, ymm2, [rax]
    vpmaxsw ymm1, ymm2, [rax+0x7f]
    vpmaxsw ymm1, ymm2, [rax+0x80]
    vpmaxsw ymm1, ymm2, [rax+rbx*4]
    vpmaxsw ymm1, ymm2, [rbx*8+0x10]
    vpmaxsw ymm1, ymm2, [rip+0x100]
    vpmaxsw ymm1, ymm2, [0x1000]
    vpmaxsw ymm1, ymm2, [r13]
    vpmaxsd ymm1, ymm2, [rax]
    vpmaxsd ymm1, ymm2, [rax+0x7f]
    vpmaxsd ymm1, ymm2, [rax+0x80]
    vpmaxsd ymm1, ymm2, [rax+rbx*4]
    vpmaxsd ymm1, ymm2, [rbx*8+0x10]
    vpmaxsd ymm1, ymm2, [rip+0x100]
    vpmaxsd ymm1, ymm2, [0x1000]
    vpmaxsd ymm1, ymm2, [r13]
    pmaxub mm1, QWORD PTR [rax]
    pmaxub mm1, QWORD PTR [rax+0x7f]
    pmaxub mm1, QWORD PTR [rax+0x80]
    pmaxub mm1, QWORD PTR [rax+rbx*4]
    pmaxub mm1, QWORD PTR [rbx*8+0x10]
    pmaxub mm1, QWORD PTR [rip+0x100]
    pmaxub mm1, QWORD PTR [0x1000]
    pmaxub mm1, QWORD PTR [r13]
    pmaxub xmm1, [rax]
    pmaxub xmm1, [rax+0x7f]
    pmaxub xmm1, [rax+0x80]
    pmaxub xmm1, [rax+rbx*4]
    pmaxub xmm1, [rbx*8+0x10]
    pmaxub xmm1, [rip+0x100]
    pmaxub xmm1, [0x1000]
    pmaxub xmm1, [r13]
    pmaxuw xmm1, [rax]
    pmaxuw xmm1, [rax+0x7f]
    pmaxuw xmm1, [rax+0x80]
    pmaxuw xmm1, [rax+rbx*4]
    pmaxuw xmm1, [rbx*8+0x10]
    pmaxuw xmm1, [rip+0x100]
    pmaxuw xmm1, [0x1000]
    pmaxuw xmm1, [r13]
    vpmaxub xmm1, xmm2, [rax]
    vpmaxub xmm1, xmm2, [rax+0x7f]
    vpmaxub xmm1, xmm2, [rax+0x80]
    vpmaxub xmm1, xmm2, [rax+rbx*4]
    vpmaxub xmm1, xmm2, [rbx*8+0x10]
    vpmaxub xmm1, xmm2, [rip+0x100]
    vpmaxub xmm1, xmm2, [0x1000]
    vpmaxub xmm1, xmm2, [r13]
    vpmaxuw xmm1, xmm2, [rax]
    vpmaxuw xmm1, xmm2, [rax+0x7f]
    vpmaxuw xmm1, xmm2, [rax+0x80]
    vpmaxuw xmm1, xmm2, [rax+rbx*4]
    vpmaxuw xmm1, xmm2, [rbx*8+0x10]
    vpmaxuw xmm1, xmm2, [rip+0x100]
    vpmaxuw xmm1, xmm2, [0x1000]
    vpmaxuw xmm1, xmm2, [r13]
    vpmaxub ymm1, ymm2, [rax]
    vpmaxub ymm1, ymm2, [rax+0x7f]
    vpmaxub ymm1, ymm2, [rax+0x80]
    vpmaxub ymm1, ymm2, [rax+rbx*4]
    vpmaxub ymm1, ymm2, [rbx*8+0x10]
    vpmaxub ymm1, ymm2, [rip+0x100]
    vpmaxub ymm1, ymm2, [0x1000]
    vpmaxub ymm1, ymm2, [r13]
    vpmaxuw ymm1, ymm2, [rax]
    vpmaxuw ymm1, ymm2, [rax+0x7f]
    vpmaxuw ymm1, ymm2, [rax+0x80]
    vpmaxuw ymm1, ymm2, [rax+rbx*4]
    vpmaxuw ymm1, ymm2, [rbx*8+0x10]
    vpmaxuw ymm1, ymm2, [rip+0x100]
    vpmaxuw ymm1, ymm2, [0x1000]
    vpmaxuw ymm1, ymm2, [r13]
    pmaxud xmm1, [rax]
    pmaxud xmm1, [rax+0x7f]
    pmaxud xmm1, [rax+0x80]
    pmaxud xmm1, [rax+rbx*4]
    pmaxud xmm1, [rbx*8+0x10]
    pmaxud xmm1, [rip+0x100]
    pmaxud xmm1, [0x1000]
    pmaxud xmm1, [r13]
    vpmaxud xmm1, xmm2, [rax]
    vpmaxud xmm1, xmm2, [rax+0x7f]
    vpmaxud xmm1, xmm2, [rax+0x80]
    vpmaxud xmm1, xmm2, [rax+rbx*4]
    vpmaxud xmm1, xmm2, [rbx*8+0x10]
    vpmaxud xmm1, xmm2, [rip+0x100]
    vpmaxud xmm1, xmm2, [0x1000]
    vpmaxud xmm1, xmm2, [r13]
    vpmaxud ymm1, ymm2, [rax]
    vpmaxud ymm1, ymm2, [rax+0x7f]
    vpmaxud ymm1, ymm2, [rax+0x80]
    vpmaxud ymm1, ymm2, [rax+rbx*4]
    vpmaxud ymm1, ymm2, [rbx*8+0x10]
    vpmaxud ymm1, ymm2, [rip+0x100]
    vpmaxud ymm1, ymm2, [0x1000]
    vpmaxud ymm1, ymm2, [r13]
    pminsw mm1, QWORD PTR [rax]
    pminsw mm1, QWORD PTR [rax+0x7f]
    pminsw mm1, QWORD PTR [rax+0x80]
    pminsw mm1, QWORD PTR [rax+rbx*4]
    pminsw mm1, QWORD PTR [rbx*8+0x10]
    pminsw mm1, QWORD PTR [rip+0x100]
    pminsw mm1, QWORD PTR [0x1000]
    pminsw mm1, QWORD PTR [r13]
    pminsb xmm1, [rax]
    pminsb xmm1, [rax+0x7f]
    pminsb xmm1, [rax+0x80]
    pminsb xmm1, [rax+rbx*4]
    pminsb xmm1, [rbx*8+0x10]
    pminsb xmm1, [rip+0x100]
    pminsb xmm1, [0x1000]
    pminsb xmm1, [r13]
    pminsw xmm1, [rax]
    pminsw xmm1, [rax+0x7f]
    pminsw xmm1, [rax+0x80]
    pminsw xmm1, [rax+rbx*4]
    pminsw xmm1, [rbx*8+0x10]
    pminsw xmm1, [rip+0x100]
    pminsw xmm1, [0x1000]
    pminsw xmm1, [r13]
    vpminsb xmm1, xmm2, [rax]
    vpminsb xmm1, xmm2, [rax+0x7f]
    vpminsb xmm1, xmm2, [rax+0x80]
    vpminsb xmm1, xmm2, [rax+rbx*4]
    vpminsb xmm1, xmm2, [rbx*8+0x10]
    vpminsb xmm1, xmm2, [rip+0x100]
    vpminsb xmm1, xmm2, [0x1000]
    vpminsb xmm1, xmm2, [r13]
    vpminsw xmm1, xmm2, [rax]
    vpminsw xmm1, xmm2, [rax+0x7f]
    vpminsw xmm1, xmm2, [rax+0x80]
    vpminsw xmm1, xmm2, [rax+rbx*4]
    vpminsw xmm1, xmm2, [rbx*8+0x10]
    vpminsw xmm1, xmm2, [rip+0x100]
    vpminsw xmm1, xmm2, [0x1000]
    vpminsw xmm1, xmm2, [r13]
    vpminsb ymm1, ymm2, [rax]
    vpminsb ymm1, ymm2, [rax+0x7f]
    vpminsb ymm1, ymm2, [rax+0x80]
    vpminsb ymm1, ymm2, [rax+rbx*4]
    vpminsb ymm1, ymm2, [rbx*8+0x10]
    vpminsb ymm1, ymm2, [rip+0x100]
    vpminsb ymm1, ymm2, [0x1000]
    vpminsb ymm1, ymm2, [r13]
    vpminsw ymm1, ymm2, [rax]
    vpminsw ymm1, ymm2, [rax+0x7f]
    vpminsw ymm1, ymm2, [rax+0x80]
    vpminsw ymm1, ymm2, [rax+rbx*4]
    vpminsw ymm1, ymm2, [rbx*8+0x10]
    vpminsw ymm1, ymm2, [rip+0x100]
    vpminsw ymm1, ymm2, [0x1000]
    vpminsw ymm1, ymm2, [r13]
    pminsd xmm1, [rax]
    pminsd xmm1, [rax+0x7f]
    pminsd xmm1, [rax+0x80]
    pminsd xmm1, [rax+rbx*4]
    pminsd xmm1, [rbx*8+0x10]
    pminsd xmm1, [rip+0x100]
    pminsd xmm1, [0x1000]
    pminsd xmm1, [r13]
    vpminsd xmm1, xmm2, [rax]
    vpminsd xmm1, xmm2, [rax+0x7f]
    vpminsd xmm1, xmm2, [rax+0x80]
    vpminsd xmm1, xmm2, [rax+rbx*4]
    vpminsd xmm1, xmm2, [rbx*8+0x10]
    vpminsd xmm1, xmm2, [rip+0x100]
    vpminsd xmm1, xmm2, [0x1000]
    vpminsd xmm1, xmm2, [r13]
    vpminsd ymm1, ymm2, [rax]
    vpminsd ymm1, ymm2, [rax+0x7f]
    vpminsd ymm1, ymm2, [rax+0x80]
    vpminsd ymm1, ymm2, [rax+rbx*4]
    vpminsd ymm1, ymm2, [rbx*8+0x10]
    vpminsd ymm1, ymm2, [rip+0x100]
    vpminsd ymm1, ymm2, [0x1000]
    vpminsd ymm1, ymm2, [r13]
    pminub mm1, QWORD PTR [rax]
    pminub mm1, QWORD PTR [rax+0x7f]
    pminub mm1, QWORD PTR [rax+0x80]
    pminub mm1, QWORD PTR [rax+rbx*4]
    pminub mm1, QWORD PTR [rbx*8+0x10]
    pminub mm1, QWORD PTR [rip+0x100]
    pminub mm1, QWORD PTR [0x1000]
    pminub mm1, QWORD PTR [r13]
    pminub xmm1, [rax]
    pminub xmm1, [rax+0x7f]
    pminub xmm1, [rax+0x80]
    pminub xmm1, [rax+rbx*4]
    pminub xmm1, [rbx*8+0x10]
    pminub xmm1, [rip+0x100]
    pminub xmm1, [0x1000]
    pminub xmm1, [r13]
    pminuw xmm1, [rax]
    pminuw xmm1, [rax+0x7f]
    pminuw xmm1, [rax+0x80]
    pminuw xmm1, [rax+rbx*4]
    pminuw xmm1, [rbx*8+0x10]
    pminuw xmm1, [rip+0x100]
    pminuw xmm1, [0x1000]
    pminuw xmm1, [r13]
    vpminub xmm1, xmm2, [rax]
    vpminub xmm1, xmm2, [rax+0x7f]
    vpminub xmm1, xmm2, [rax+0x80]
    vpminub xmm1, xmm2, [rax+rbx*4]
    vpminub xmm1, xmm2, [rbx*8+0x10]
    vpminub xmm1, xmm2, [rip+0x100]
    vpminub xmm1, xmm2, [0x1000]
    vpminub xmm1, xmm2, [r13]
    vpminuw xmm1, xmm2, [rax]
    vpminuw xmm1, xmm2, [rax+0x7f]
    vpminuw xmm1, xmm2, [rax+0x80]
    vpminuw xmm1, xmm2, [rax+rbx*4]
    vpminuw xmm1, xmm2, [rbx*8+0x10]
    vpminuw xmm1, xmm2, [rip+0x100]
    vpminuw xmm1, xmm2, [0x1000]
    vpminuw xmm1, xmm2, [r13]
    vpminub ymm1, ymm2, [rax]
    vpminub ymm1, ymm2, [rax+0x7f]
    vpminub ymm1, ymm2, [rax+0x80]
    vpminub ymm1, ymm2, [rax+rbx*4]
    vpminub ymm1, ymm2, [rbx*8+0x10]
    vpminub ymm1, ymm2, [rip+0x100]
    vpminub ymm1, ymm2, [0x1000]
    vpminub ymm1, ymm2, [r13]
    vpminuw ymm1, ymm2, [rax]
    vpminuw ymm1, ymm2, [rax+0x7f]
    vpminuw ymm1, ymm2, [rax+0x80]
    vpminuw ymm1, ymm2, [rax+rbx*4]
    vpminuw ymm1, ymm2, [rbx*8+0x10]
    vpminuw ymm1, ymm2, [rip+0x100]
    vpminuw ymm1, ymm2, [0x1000]
    vpminuw ymm1, ymm2, [r13]
    pminud xmm1, [rax]
    pminud xmm1, [rax+0x7f]
    pminud xmm1, [rax+0x80]
    pminud xmm1, [rax+rbx*4]
    pminud xmm1, [rbx*8+0x10]
    pminud xmm1, [rip+0x100]
    pminud xmm1, [0x1000]
    pminud xmm1, [r13]
    vpminud xmm1, xmm2, [rax]
    vpminud xmm1, xmm2, [rax+0x7f]
    vpminud xmm1, xmm2, [rax+0x80]
    vpminud xmm1, xmm2, [rax+rbx*4]
    vpminud xmm1, xmm2, [rbx*8+0x10]
    vpminud xmm1, xmm2, [rip+0x100]
    vpminud xmm1, xmm2, [0x1000]
    vpminud xmm1, xmm2, [r13]
    vpminud ymm1, ymm2, [rax]
    vpminud ymm1, ymm2, [rax+0x7f]
    vpminud ymm1, ymm2, [rax+0x80]
    vpminud ymm1, ymm2, [rax+rbx*4]
    vpminud ymm1, ymm2, [rbx*8+0x10]
    vpminud ymm1, ymm2, [rip+0x100]
    vpminud ymm1, ymm2, [0x1000]
    vpminud ymm1, ymm2, [r13]
    pmovsxbw xmm1, QWORD PTR [rax]
    pmovsxbw xmm1, QWORD PTR [rax+0x7f]
    pmovsxbw xmm1, QWORD PTR [rax+0x80]
    pmovsxbw xmm1, QWORD PTR [rax+rbx*4]
    pmovsxbw xmm1, QWORD PTR [rbx*8+0x10]
    pmovsxbw xmm1, QWORD PTR [rip+0x100]
    pmovsxbw xmm1, QWORD PTR [0x1000]
    pmovsxbw xmm1, QWORD PTR [r13]
    pmovsxbd xmm1, DWORD PTR [rax]
    pmovsxbd xmm1, DWORD PTR [rax+0x7f]
    pmovsxbd xmm1, DWORD PTR [rax+0x80]
    pmovsxbd xmm1, DWORD PTR [rax+rbx*4]
    pmovsxbd xmm1, DWORD PTR [rbx*8+0x10]
    pmovsxbd xmm1, DWORD PTR [rip+0x100]
    pmovsxbd xmm1, DWORD PTR [0x1000]
    pmovsxbd xmm1, DWORD PTR [r13]
    pmovsxbq xmm1, WORD PTR [rax]
    pmovsxbq xmm1, WORD PTR [rax+0x7f]
    pmovsxbq xmm1, WORD PTR [rax+0x80]
    pmovsxbq xmm1, WORD PTR [rax+rbx*4]
    pmovsxbq xmm1, WORD PTR [rbx*8+0x10]
    pmovsxbq xmm1, WORD PTR [rip+0x100]
    pmovsxbq xmm1, WORD PTR [0x1000]
    pmovsxbq xmm1, WORD PTR [r13]
    pmovsxwd xmm1, QWORD PTR [rax]
    pmovsxwd xmm1, QWORD PTR [rax+0x7f]
    pmovsxwd xmm1, QWORD PTR [rax+0x80]
    pmovsxwd xmm1, QWORD PTR [rax+rbx*4]
    pmovsxwd xmm1, QWORD PTR [rbx*8+0x10]
    pmovsxwd xmm1, QWORD PTR [rip+0x100]
    pmovsxwd xmm1, QWORD PTR [0x1000]
    pmovsxwd xmm1, QWORD PTR [r13]
    pmovsxwq xmm1, DWORD PTR [rax]
    pmovsxwq xmm1, DWORD PTR [rax+0x7f]
    pmovsxwq xmm1, DWORD PTR [rax+0x80]
    pmovsxwq xmm1, DWORD PTR [rax+rbx*4]
    pmovsxwq xmm1, DWORD PTR [rbx*8+0x10]
    pmovsxwq xmm1, DWORD PTR [rip+0x100]
    pmovsxwq xmm1, DWORD PTR [0x1000]
    pmovsxwq xmm1, DWORD PTR [r13]
    pmovsxdq xmm1, QWORD PTR [rax]
    pmovsxdq xmm1, QWORD PTR [rax+0x7f]
    pmovsxdq xmm1, QWORD PTR [rax+0x80]
    pmovsxdq xmm1, QWORD PTR [rax+rbx*4]
    pmovsxdq xmm1, QWORD PTR [rbx*8+0x10]
    pmovsxdq xmm1, QWORD PTR [rip+0x100]
    pmovsxdq xmm1, QWORD PTR [0x1000]
    pmovsxdq xmm1, QWORD PTR [r13]
    vpmovsxbw xmm1, QWORD PTR [rax]
    vpmovsxbw xmm1, QWORD PTR [rax+0x7f]
    vpmovsxbw xmm1, QWORD PTR [rax+0x80]
    vpmovsxbw xmm1, QWORD PTR [rax+rbx*4]
    vpmovsxbw xmm1, QWORD PTR [rbx*8+0x10]
    vpmovsxbw xmm1, QWORD PTR [rip+0x100]
    vpmovsxbw xmm1, QWORD PTR [0x1000]
    vpmovsxbw xmm1, QWORD PTR [r13]
    vpmovsxbd xmm1, DWORD PTR [rax]
    vpmovsxbd xmm1, DWORD PTR [rax+0x7f]
    vpmovsxbd xmm1, DWORD PTR [rax+0x80]
    vpmovsxbd xmm1, DWORD PTR [rax+rbx*4]
    vpmovsxbd xmm1, DWORD PTR [rbx*8+0x10]
    vpmovsxbd xmm1, DWORD PTR [rip+0x100]
    vpmovsxbd xmm1, DWORD PTR [0x1000]
    vpmovsxbd xmm1, DWORD PTR [r13]
    vpmovsxbq xmm1, WORD PTR [rax]
    vpmovsxbq xmm1, WORD PTR [rax+0x7f]
    vpmovsxbq xmm1, WORD PTR [rax+0x80]
    vpmovsxbq xmm1, WORD PTR [rax+rbx*4]
    vpmovsxbq xmm1, WORD PTR [rbx*8+0x10]
    vpmovsxbq xmm1, WORD PTR [rip+0x100]
    vpmovsxbq xmm1, WORD PTR [0x1000]
    vpmovsxbq xmm1, WORD PTR [r13]
    vpmovsxwd xmm1, QWORD PTR [rax]
    vpmovsxwd xmm1, QWORD PTR [rax+0x7f]
    vpmovsxwd xmm1, QWORD PTR [rax+0x80]
    vpmovsxwd xmm1, QWORD PTR [rax+rbx*4]
    vpmovsxwd xmm1, QWORD PTR [rbx*8+0x10]
    vpmovsxwd xmm1, QWORD PTR [rip+0x100]
    vpmovsxwd xmm1, QWORD PTR [0x1000]
    vpmovsxwd xmm1, QWORD PTR [r13]
    vpmovsxwq xmm1, DWORD PTR [rax]
    vpmovsxwq xmm1, DWORD PTR [rax+0x7f]
    vpmovsxwq xmm1, DWORD PTR [rax+0x80]
    vpmovsxwq xmm1, DWORD PTR [rax+rbx*4]
    vpmovsxwq xmm1, DWORD PTR [rbx*8+0x10]
    vpmovsxwq xmm1, DWORD PTR [rip+0x100]
    vpmovsxwq xmm1, DWORD PTR [0x1000]
    vpmovsxwq xmm1, DWORD PTR [r13]
    vpmovsxdq xmm1, QWORD PTR [rax]
    vpmovsxdq xmm1, QWORD PTR [rax+0x7f]
    vpmovsxdq xmm1, QWORD PTR [rax+0x80]
    vpmovsxdq xmm1, QWORD PTR [rax+rbx*4]
    vpmovsxdq xmm1, QWORD PTR [rbx*8+0x10]
    vpmovsxdq xmm1, QWORD PTR [rip+0x100]
    vpmovsxdq xmm1, QWORD PTR [0x1000]
    vpmovsxdq xmm1, QWORD PTR [r13]
    vpmovsxbw ymm1, [rax]
    vpmovsxbw ymm1, [rax+0x7f]
    vpmovsxbw ymm1, [rax+0x80]
    vpmovsxbw ymm1, [rax+rbx*4]
    vpmovsxbw ymm1, [rbx*8+0x10]
    vpmovsxbw ymm1, [rip+0x100]
    vpmovsxbw ymm1, [0x1000]
    vpmovsxbw ymm1, [r13]
    vpmovsxbd ymm1, QWORD PTR [rax]
    vpmovsxbd ymm1, QWORD PTR [rax+0x7f]
    vpmovsxbd ymm1, QWORD PTR [rax+0x80]
    vpmovsxbd ymm1, QWORD PTR [rax+rbx*4]
    vpmovsxbd ymm1, QWORD PTR [rbx*8+0x10]
    vpmovsxbd ymm1, QWORD PTR [rip+0x100]
    vpmovsxbd ymm1, QWORD PTR [0x1000]
    vpmovsxbd ymm1, QWORD PTR [r13]
    vpmovsxbq ymm1, DWORD PTR [rax]
    vpmovsxbq ymm1, DWORD PTR [rax+0x7f]
    vpmovsxbq ymm1, DWORD PTR [rax+0x80]
    vpmovsxbq ymm1, DWORD PTR [rax+rbx*4]
    vpmovsxbq ymm1, DWORD PTR [rbx*8+0x10]
    vpmovsxbq ymm1, DWORD PTR [rip+0x100]
    vpmovsxbq ymm1, DWORD PTR [0x1000]
    vpmovsxbq ymm1, DWORD PTR [r13]
    vpmovsxwd ymm1, [rax]
    vpmovsxwd ymm1, [rax+0x7f]
    vpmovsxwd ymm1, [rax+0x80]
    vpmovsxwd ymm1, [rax+rbx*4]
    vpmovsxwd ymm1, [rbx*8+0x10]
    vpmovsxwd ymm1, [rip+0x100]
    vpmovsxwd ymm1, [0x1000]
    vpmovsxwd ymm1, [r13]
    vpmovsxwq ymm1, QWORD PTR [rax]
    vpmovsxwq ymm1, QWORD PTR [rax+0x7f]
    vpmovsxwq ymm1, QWORD PTR [rax+0x80]
    vpmovsxwq ymm1, QWORD PTR [rax+rbx*4]
    vpmovsxwq ymm1, QWORD PTR [rbx*8+0x10]
    vpmovsxwq ymm1, QWORD PTR [rip+0x100]
    vpmovsxwq ymm1, QWORD PTR [0x1000]
    vpmovsxwq ymm1, QWORD PTR [r13]
    vpmovsxdq ymm1, [rax]
    vpmovsxdq ymm1, [rax+0x7f]
    vpmovsxdq ymm1, [rax+0x80]
    vpmovsxdq ymm1, [rax+rbx*4]
    vpmovsxdq ymm1, [rbx*8+0x10]
    vpmovsxdq ymm1, [rip+0x100]
    vpmovsxdq ymm1, [0x1000]
    vpmovsxdq ymm1, [r13]
    pmovzxbw xmm1, QWORD PTR [rax]
    pmovzxbw xmm1, QWORD PTR [rax+0x7f]
    pmovzxbw xmm1, QWORD PTR [rax+0x80]
    pmovzxbw xmm1, QWORD PTR [rax+rbx*4]
    pmovzxbw xmm1, QWORD PTR [rbx*8+0x10]
    pmovzxbw xmm1, QWORD PTR [rip+0x100]
    pmovzxbw xmm1, QWORD PTR [0x1000]
    pmovzxbw xmm1, QWORD PTR [r13]
    pmovzxbd xmm1, DWORD PTR [rax]
    pmovzxbd xmm1, DWORD PTR [rax+0x7f]
    pmovzxbd xmm1, DWORD PTR [rax+0x80]
    pmovzxbd xmm1, DWORD PTR [rax+rbx*4]
    pmovzxbd xmm1, DWORD PTR [rbx*8+0x10]
    pmovzxbd xmm1, DWORD PTR [rip+0x100]
    pmovzxbd xmm1, DWORD PTR [0x1000]
    pmovzxbd xmm1, DWORD PTR [r13]
    pmovzxbq xmm1, WORD PTR [rax]
    pmovzxbq xmm1, WORD PTR [rax+0x7f]
    pmovzxbq xmm1, WORD PTR [rax+0x80]
    pmovzxbq xmm1, WORD PTR [rax+rbx*4]
    pmovzxbq xmm1, WORD PTR [rbx*8+0x10]
    pmovzxbq xmm1, WORD PTR [rip+0x100]
    pmovzxbq xmm1, WORD PTR [0x1000]
    pmovzxbq xmm1, WORD PTR [r13]
    pmovzxwd xmm1, QWORD PTR [rax]
    pmovzxwd xmm1, QWORD PTR [rax+0x7f]
    pmovzxwd xmm1, QWORD PTR [rax+0x80]
    pmovzxwd xmm1, QWORD PTR [rax+rbx*4]
    pmovzxwd xmm1, QWORD PTR [rbx*8+0x10]
    pmovzxwd xmm1, QWORD PTR [rip+0x100]
    pmovzxwd xmm1, QWORD PTR [0x1000]
    pmovzxwd xmm1, QWORD PTR [r13]
    pmovzxwq xmm1, DWORD PTR [rax]
    pmovzxwq xmm1, DWORD PTR [rax+0x7f]
    pmovzxwq xmm1, DWORD PTR [rax+0x80]
    pmovzxwq xmm1, DWORD PTR [rax+rbx*4]
    pmovzxwq xmm1, DWORD PTR [rbx*8+0x10]
    pmovzxwq xmm1, DWORD PTR [rip+0x100]
    pmovzxwq xmm1, DWORD PTR [0x1000]
    pmovzxwq xmm1, DWORD PTR [r13]
    pmovzxdq xmm1, QWORD PTR [rax]
    pmovzxdq xmm1, QWORD PTR [rax+0x7f]
    pmovzxdq xmm1, QWORD PTR [rax+0x80]
    pmovzxdq xmm1, QWORD PTR [rax+rbx*4]
    pmovzxdq xmm1, QWORD PTR [rbx*8+0x10]
    pmovzxdq xmm1, QWORD PTR [rip+0x100]
    pmovzxdq xmm1, QWORD PTR [0x1000]
    pmovzxdq xmm1, QWORD PTR [r13]
    vpmovzxbw xmm1, QWORD PTR [rax]
    vpmovzxbw xmm1, QWORD PTR [rax+0x7f]
    vpmovzxbw xmm1, QWORD PTR [rax+0x80]
    vpmovzxbw xmm1, QWORD PTR [rax+rbx*4]
    vpmovzxbw xmm1, QWORD PTR [rbx*8+0x10]
    vpmovzxbw xmm1, QWORD PTR [rip+0x100]
    vpmovzxbw xmm1, QWORD PTR [0x1000]
    vpmovzxbw xmm1, QWORD PTR [r13]
    vpmovzxbd xmm1, DWORD PTR [rax]
    vpmovzxbd xmm1, DWORD PTR [rax+0x7f]
    vpmovzxbd xmm1, DWORD PTR [rax+0x80]
    vpmovzxbd xmm1, DWORD PTR [rax+rbx*4]
    vpmovzxbd xmm1, DWORD PTR [rbx*8+0x10]
    vpmovzxbd xmm1, DWORD PTR [rip+0x100]
    vpmovzxbd xmm1, DWORD PTR [0x1000]
    vpmovzxbd xmm1, DWORD PTR [r13]
    vpmovzxbq xmm1, WORD PTR [rax]
    vpmovzxbq xmm1, WORD PTR [rax+0x7f]
    vpmovzxbq xmm1, WORD PTR [rax+0x80]
    vpmovzxbq xmm1, WORD PTR [rax+rbx*4]
    vpmovzxbq xmm1, WORD PTR [rbx*8+0x10]
    vpmovzxbq xmm1, WORD PTR [rip+0x100]
    vpmovzxbq xmm1, WORD PTR [0x1000]
    vpmovzxbq xmm1, WORD PTR [r13]
    vpmovzxwd xmm1, QWORD PTR [rax]
    vpmovzxwd xmm1, QWORD PTR [rax+0x7f]
    vpmovzxwd xmm1, QWORD PTR [rax+0x80]
    vpmovzxwd xmm1, QWORD PTR [rax+rbx*4]
    vpmovzxwd xmm1, QWORD PTR [rbx*8+0x10]
    vpmovzxwd xmm1, QWORD PTR [rip+0x100]
    vpmovzxwd xmm1, QWORD PTR [0x1000]
    vpmovzxwd xmm1, QWORD PTR [r13]
    vpmovzxwq xmm1, DWORD PTR [rax]
    vpmovzxwq xmm1, DWORD PTR [rax+0x7f]
    vpmovzxwq xmm1, DWORD PTR [rax+0x80]
    vpmovzxwq xmm1, DWORD PTR [rax+rbx*4]
    vpmovzxwq xmm1, DWORD PTR [rbx*8+0x10]
    vpmovzxwq xmm1, DWORD PTR [rip+0x100]
    vpmovzxwq xmm1, DWORD PTR [0x1000]
    vpmovzxwq xmm1, DWORD PTR [r13]
    vpmovzxbw ymm1, [rax]
    vpmovzxbw ymm1, [rax+0x7f]
    vpmovzxbw ymm1, [rax+0x80]
    vpmovzxbw ymm1, [rax+rbx*4]
    vpmovzxbw ymm1, [rbx*8+0x10]
    vpmovzxbw ymm1, [rip+0x100]
    vpmovzxbw ymm1, [0x1000]
    vpmovzxbw ymm1, [r13]
    vpmovzxbd ymm1, QWORD PTR [rax]
    vpmovzxbd ymm1, QWORD PTR [rax+0x7f]
    vpmovzxbd ymm1, QWORD PTR [rax+0x80]
    vpmovzxbd ymm1, QWORD PTR [rax+rbx*4]
    vpmovzxbd ymm1, QWORD PTR [rbx*8+0x10]
    vpmovzxbd ymm1, QWORD PTR [rip+0x100]
    vpmovzxbd ymm1, QWORD PTR [0x1000]
    vpmovzxbd ymm1, QWORD PTR [r13]
    vpmovzxbq ymm1, DWORD PTR [rax]
    vpmovzxbq ymm1, DWORD PTR [rax+0x7f]
    vpmovzxbq ymm1, DWORD PTR [rax+0x80]
    vpmovzxbq ymm1, DWORD PTR [rax+rbx*4]
    vpmovzxbq ymm1, DWORD PTR [rbx*8+0x10]
    vpmovzxbq ymm1, DWORD PTR [rip+0x100]
    vpmovzxbq ymm1, DWORD PTR [0x1000]
    vpmovzxbq ymm1, DWORD PTR [r13]
    vpmovzxwd ymm1, [rax]
    vpmovzxwd ymm1, [rax+0x7f]
    vpmovzxwd ymm1, [rax+0x80]
    vpmovzxwd ymm1, [rax+rbx*4]
    vpmovzxwd ymm1, [rbx*8+0x10]
    vpmovzxwd ymm1, [rip+0x100]
    vpmovzxwd ymm1, [0x1000]
    vpmovzxwd ymm1, [r13]
    vpmovzxwq ymm1, QWORD PTR [rax]
    vpmovzxwq ymm1, QWORD PTR [rax+0x7f]
    vpmovzxwq ymm1, QWORD PTR [rax+0x80]
    vpmovzxwq ymm1, QWORD PTR [rax+rbx*4]
    vpmovzxwq ymm1, QWORD PTR [rbx*8+0x10]
    vpmovzxwq ymm1, QWORD PTR [rip+0x100]
    vpmovzxwq ymm1, QWORD PTR [0x1000]
    vpmovzxwq ymm1, QWORD PTR [r13]
    vpmovzxdq ymm1, [rax]
    vpmovzxdq ymm1, [rax+0x7f]
    vpmovzxdq ymm1, [rax+0x80]
    vpmovzxdq ymm1, [rax+rbx*4]
    vpmovzxdq ymm1, [rbx*8+0x10]
    vpmovzxdq ymm1, [rip+0x100]
    vpmovzxdq ymm1, [0x1000]
    vpmovzxdq ymm1, [r13]
    pmuldq xmm1, [rax]
    pmuldq xmm1, [rax+0x7f]
    pmuldq xmm1, [rax+0x80]
    pmuldq xmm1, [rax+rbx*4]
    pmuldq xmm1, [rbx*8+0x10]
    pmuldq xmm1, [rip+0x100]
    pmuldq xmm1, [0x1000]
    pmuldq xmm1, [r13]
    vpmuldq xmm1, xmm2, [rax]
    vpmuldq xmm1, xmm2, [rax+0x7f]
    vpmuldq xmm1, xmm2, [rax+0x80]
    vpmuldq xmm1, xmm2, [rax+rbx*4]
    vpmuldq xmm1, xmm2, [rbx*8+0x10]
    vpmuldq xmm1, xmm2, [rip+0x100]
    vpmuldq xmm1, xmm2, [0x1000]
    vpmuldq xmm1, xmm2, [r13]
    vpmuldq ymm1, ymm2, [rax]
    vpmuldq ymm1, ymm2, [rax+0x7f]
    vpmuldq ymm1, ymm2, [rax+0x80]
    vpmuldq ymm1, ymm2, [rax+rbx*4]
    vpmuldq ymm1, ymm2, [rbx*8+0x10]
    vpmuldq ymm1, ymm2, [rip+0x100]
    vpmuldq ymm1, ymm2, [0x1000]
    vpmuldq ymm1, ymm2, [r13]
    pmulhrsw mm1, QWORD PTR [rax]
    pmulhrsw mm1, QWORD PTR [rax+0x7f]
    pmulhrsw mm1, QWORD PTR [rax+0x80]
    pmulhrsw mm1, QWORD PTR [rax+rbx*4]
    pmulhrsw mm1, QWORD PTR [rbx*8+0x10]
    pmulhrsw mm1, QWORD PTR [rip+0x100]
    pmulhrsw mm1, QWORD PTR [0x1000]
    pmulhrsw mm1, QWORD PTR [r13]
    pmulhrsw xmm1, [rax]
    pmulhrsw xmm1, [rax+0x7f]
    pmulhrsw xmm1, [rax+0x80]
    pmulhrsw xmm1, [rax+rbx*4]
    pmulhrsw xmm1, [rbx*8+0x10]
    pmulhrsw xmm1, [rip+0x100]
    pmulhrsw xmm1, [0x1000]
    pmulhrsw xmm1, [r13]
    vpmulhrsw xmm1, xmm2, [rax]
    vpmulhrsw xmm1, xmm2, [rax+0x7f]
    vpmulhrsw xmm1, xmm2, [rax+0x80]
    vpmulhrsw xmm1, xmm2, [rax+rbx*4]
    vpmulhrsw xmm1, xmm2, [rbx*8+0x10]
    vpmulhrsw xmm1, xmm2, [rip+0x100]
    vpmulhrsw xmm1, xmm2, [0x1000]
    vpmulhrsw xmm1, xmm2, [r13]
    vpmulhrsw ymm1, ymm2, [rax]
    vpmulhrsw ymm1, ymm2, [rax+0x7f]
    vpmulhrsw ymm1, ymm2, [rax+0x80]
    vpmulhrsw ymm1, ymm2, [rax+rbx*4]
    vpmulhrsw ymm1, ymm2, [rbx*8+0x10]
    vpmulhrsw ymm1, ymm2, [rip+0x100]
    vpmulhrsw ymm1, ymm2, [0x1000]
    vpmulhrsw ymm1, ymm2, [r13]
    pmulhuw mm1, QWORD PTR [rax]
    pmulhuw mm1, QWORD PTR [rax+0x7f]
    pmulhuw mm1, QWORD PTR [rax+0x80]
    pmulhuw mm1, QWORD PTR [rax+rbx*4]
    pmulhuw mm1, QWORD PTR [rbx*8+0x10]
    pmulhuw mm1, QWORD PTR [rip+0x100]
    pmulhuw mm1, QWORD PTR [0x1000]
    pmulhuw mm1, QWORD PTR [r13]
    pmulhuw xmm1, [rax]
    pmulhuw xmm1, [rax+0x7f]
    pmulhuw xmm1, [rax+0x80]
    pmulhuw xmm1, [rax+rbx*4]
    pmulhuw xmm1, [rbx*8+0x10]
    pmulhuw xmm1, [rip+0x100]
    pmulhuw xmm1, [0x1000]
    pmulhuw xmm1, [r13]
    vpmulhuw xmm1, xmm2, [rax]
    vpmulhuw xmm1, xmm2, [rax+0x7f]
    vpmulhuw xmm1, xmm2, [rax+0x80]
    vpmulhuw xmm1, xmm2, [rax+rbx*4]
    vpmulhuw xmm1, xmm2, [rbx*8+0x10]
    vpmulhuw xmm1, xmm2, [rip+0x100]
    vpmulhuw xmm1, xmm2, [0x1000]
    vpmulhuw xmm1, xmm2, [r13]
    vpmulhuw ymm1, ymm2, [rax]
    vpmulhuw ymm1, ymm2, [rax+0x7f]
    vpmulhuw ymm1, ymm2, [rax+0x80]
    vpmulhuw ymm1, ymm2, [rax+rbx*4]
    vpmulhuw ymm1, ymm2, [rbx*8+0x10]
    vpmulhuw ymm1, ymm2, [rip+0x100]
    vpmulhuw ymm1, ymm2, [0x1000]
    vpmulhuw ymm1, ymm2, [r13]
    pmulhw mm0, QWORD PTR [rax]
    pmulhw mm0, QWORD PTR [rax+0x7f]
    pmulhw mm0, QWORD PTR [rax+0x80]
    pmulhw mm0, QWORD PTR [rax+rbx*4]
    pmulhw mm0, QWORD PTR [rbx*8+0x10]
    pmulhw mm0, QWORD PTR [rip+0x100]
    pmulhw mm0, QWORD PTR [0x1000]
    pmulhw mm0, QWORD PTR [r13]
    pmulhw xmm1, [rax]
    pmulhw xmm1, [rax+0x7f]
    pmulhw xmm1, [rax+0x80]
    pmulhw xmm1, [rax+rbx*4]
    pmulhw xmm1, [rbx*8+0x10]
    pmulhw xmm1, [rip+0x100]
    pmulhw xmm1, [0x1000]
    pmulhw xmm1, [r13]
    vpmulhw xmm1, xmm2, [rax]
    vpmulhw xmm1, xmm2, [rax+0x7f]
    vpmulhw xmm1, xmm2, [rax+0x80]
    vpmulhw xmm1, xmm2, [rax+rbx*4]
    vpmulhw xmm1, xmm2, [rbx*8+0x10]
    vpmulhw xmm1, xmm2, [rip+0x100]
    vpmulhw xmm1, xmm2, [0x1000]
    vpmulhw xmm1, xmm2, [r13]
    vpmulhw ymm1, ymm2, [rax]
    vpmulhw ymm1, ymm2, [rax+0x7f]
    vpmulhw ymm1, ymm2, [rax+0x80]
    vpmulhw ymm1, ymm2, [rax+rbx*4]
    vpmulhw ymm1, ymm2, [rbx*8+0x10]
    vpmulhw ymm1, ymm2, [rip+0x100]
    vpmulhw ymm1, ymm2, [0x1000]
    vpmulhw ymm1, ymm2, [r13]
    pmulld xmm1, [rax]
    pmulld xmm1, [rax+0x7f]
    pmulld xmm1, [rax+0x80]
    pmulld xmm1, [rax+rbx*4]
    pmulld xmm1, [rbx*8+0x10]
    pmulld xmm1, [rip+0x100]
    pmulld xmm1, [0x1000]
    pmulld xmm1, [r13]
    vpmulld xmm1, xmm2, [rax]
    vpmulld xmm1, xmm2, [rax+0x7f]
    vpmulld xmm1, xmm2, [rax+0x80]
    vpmulld xmm1, xmm2, [rax+rbx*4]
    vpmulld xmm1, xmm2, [rbx*8+0x10]
    vpmulld xmm1, xmm2, [rip+0x100]
    vpmulld xmm1, xmm2, [0x1000]
    vpmulld xmm1, xmm2, [r13]
    vpmulld ymm1, ymm2, [rax]
    vpmulld ymm1, ymm2, [rax+0x7f]
    vpmulld ymm1, ymm2, [rax+0x80]
    vpmulld ymm1, ymm2, [rax+rbx*4]
    vpmulld ymm1, ymm2, [rbx*8+0x10]
    vpmulld ymm1, ymm2, [rip+0x100]
    vpmulld ymm1, ymm2, [0x1000]
    vpmulld ymm1, ymm2, [r13]
    pmullw mm0, QWORD PTR [rax]
    pmullw mm0, QWORD PTR [rax+0x7f]
    pmullw mm0, QWORD PTR [rax+0x80]
    pmullw mm0, QWORD PTR [rax+rbx*4]
    pmullw mm0, QWORD PTR [rbx*8+0x10]
    pmullw mm0, QWORD PTR [rip+0x100]
    pmullw mm0, QWORD PTR [0x1000]
    pmullw mm0, QWORD PTR [r13]
    pmullw xmm1, [rax]
    pmullw xmm1, [rax+0x7f]
    pmullw xmm1, [rax+0x80]
    pmullw xmm1, [rax+rbx*4]
    pmullw xmm1, [rbx*8+0x10]
    pmullw xmm1, [rip+0x100]
    pmullw xmm1, [0x1000]
    pmullw xmm1, [r13]
    vpmullw xmm1, xmm2, [rax]
    vpmullw xmm1, xmm2, [rax+0x7f]
    vpmullw xmm1, xmm2, [rax+0x80]
    vpmullw xmm1, xmm2, [rax+rbx*4]
    vpmullw xmm1, xmm2, [rbx*8+0x10]
    vpmullw xmm1, xmm2, [rip+0x100]
    vpmullw xmm1, xmm2, [0x1000]
    vpmullw xmm1, xmm2, [r13]
    vpmullw ymm1, ymm2, [rax]
    vpmullw ymm1, ymm2, [rax+0x7f]
    vpmullw ymm1, ymm2, [rax+0x80]
    vpmullw ymm1, ymm2, [rax+rbx*4]
    vpmullw ymm1, ymm2, [rbx*8+0x10]
    vpmullw ymm1, ymm2, [rip+0x100]
    vpmullw ymm1, ymm2, [0x1000]
    vpmullw ymm1, ymm2, [r13]
    pmuludq mm1, QWORD PTR [rax]
    pmuludq mm1, QWORD PTR [rax+0x7f]
    pmuludq mm1, QWORD PTR [rax+0x80]
    pmuludq mm1, QWORD PTR [rax+rbx*4]
    pmuludq mm1, QWORD PTR [rbx*8+0x10]
    pmuludq mm1, QWORD PTR [rip+0x100]
    pmuludq mm1, QWORD PTR [0x1000]
    pmuludq mm1, QWORD PTR [r13]
    pmuludq xmm1, [rax]
    pmuludq xmm1, [rax+0x7f]
    pmuludq xmm1, [rax+0x80]
    pmuludq xmm1, [rax+rbx*4]
    pmuludq xmm1, [rbx*8+0x10]
    pmuludq xmm1, [rip+0x100]
    pmuludq xmm1, [0x1000]
    pmuludq xmm1, [r13]
    vpmuludq xmm1, xmm2, [rax]
    vpmuludq xmm1, xmm2, [rax+0x7f]
    vpmuludq xmm1, xmm2, [rax+0x80]
    vpmuludq xmm1, xmm2, [rax+rbx*4]
    vpmuludq xmm1, xmm2, [rbx*8+0x10]
    vpmuludq xmm1, xmm2, [rip+0x100]
    vpmuludq xmm1, xmm2, [0x1000]
    vpmuludq xmm1, xmm2, [r13]
    vpmuludq ymm1, ymm2, [rax]
    vpmuludq ymm1, ymm2, [rax+0x7f]
    vpmuludq ymm1, ymm2, [rax+0x80]
    vpmuludq ymm1, ymm2, [rax+rbx*4]
    vpmuludq ymm1, ymm2, [rbx*8+0x10]
    vpmuludq ymm1, ymm2, [rip+0x100]
    vpmuludq ymm1, ymm2, [0x1000]
    vpmuludq ymm1, ymm2, [r13]
    pop WORD PTR [rax]
    pop WORD PTR [rax+0x7f]
    pop WORD PTR [rax+0x80]
    pop WORD PTR [rax+rbx*4]
    pop WORD PTR [rbx*8+0x10]
    pop WORD PTR [rip+0x100]
    pop WORD PTR [0x1000]
    pop WORD PTR [r13]
    pop DWORD PTR [rax]
    pop DWORD PTR [rax+0x7f]
    pop DWORD PTR [rax+0x80]
    pop DWORD PTR [rax+rbx*4]
    pop DWORD PTR [rbx*8+0x10]
    pop DWORD PTR [rip+0x100]
    pop DWORD PTR [0x1000]
    pop DWORD PTR [r13]
    pop QWORD PTR [rax]
    pop QWORD PTR [rax+0x7f]
    pop QWORD PTR [rax+0x80]
    pop QWORD PTR [rax+rbx*4]
    pop QWORD PTR [rbx*8+0x10]
    pop QWORD PTR [rip+0x100]
    pop QWORD PTR [0x1000]
    pop QWORD PTR [r13]
    popcnt ax, WORD PTR [rax]
    popcnt ax, WORD PTR [rax+0x7f]
    popcnt ax, WORD PTR [rax+0x80]
    popcnt ax, WORD PTR [rax+rbx*4]
    popcnt ax, WORD PTR [rbx*8+0x10]
    popcnt ax, WORD PTR [rip+0x100]
    popcnt ax, WORD PTR [0x1000]
    popcnt ax, WORD PTR [r13]
    popcnt eax, DWORD PTR [rax]
    popcnt eax, DWORD PTR [rax+0x7f]
    popcnt eax, DWORD PTR [rax+0x80]
    popcnt eax, DWORD PTR [rax+rbx*4]
    popcnt eax, DWORD PTR [rbx*8+0x10]
    popcnt eax, DWORD PTR [rip+0x100]
    popcnt eax, DWORD PTR [0x1000]
    popcnt eax, DWORD PTR [r13]
    popcnt rax, QWORD PTR [rax]
    popcnt rax, QWORD PTR [rax+0x7f]
    popcnt rax, QWORD PTR [rax+0x80]
    popcnt rax, QWORD PTR [rax+rbx*4]
    popcnt rax, QWORD PTR [rbx*8+0x10]
    popcnt rax, QWORD PTR [rip+0x100]
    popcnt rax, QWORD PTR [0x1000]
    popcnt rax, QWORD PTR [r13]
    por mm0, QWORD PTR [rax]
    por mm0, QWORD PTR [rax+0x7f]
    por mm0, QWORD PTR [rax+0x80]
    por mm0, QWORD PTR [rax+rbx*4]
    por mm0, QWORD PTR [rbx*8+0x10]
    por mm0, QWORD PTR [rip+0x100]
    por mm0, QWORD PTR [0x1000]
    por mm0, QWORD PTR [r13]
    por xmm1, [rax]
    por xmm1, [rax+0x7f]
    por xmm1, [rax+0x80]
    por xmm1, [rax+rbx*4]
    por xmm1, [rbx*8+0x10]
    por xmm1, [rip+0x100]
    por xmm1, [0x1000]
    por xmm1, [r13]
    vpor xmm1, xmm2, [rax]
    vpor xmm1, xmm2, [rax+0x7f]
    vpor xmm1, xmm2, [rax+0x80]
    vpor xmm1, xmm2, [rax+rbx*4]
    vpor xmm1, xmm2, [rbx*8+0x10]
    vpor xmm1, xmm2, [rip+0x100]
    vpor xmm1, xmm2, [0x1000]
    vpor xmm1, xmm2, [r13]
    vpor ymm1, ymm2, [rax]
    vpor ymm1, ymm2, [rax+0x7f]
    vpor ymm1, ymm2, [rax+0x80]
    vpor ymm1, ymm2, [rax+rbx*4]
    vpor ymm1, ymm2, [rbx*8+0x10]
    vpor ymm1, ymm2, [rip+0x100]
    vpor ymm1, ymm2, [0x1000]
    vpor ymm1, ymm2, [r13]
    prefetcht0 BYTE PTR [rax]
    prefetcht0 BYTE PTR [rax+0x7f]
    prefetcht0 BYTE PTR [rax+0x80]
    prefetcht0 BYTE PTR [rax+rbx*4]
    prefetcht0 BYTE PTR [rbx*8+0x10]
    prefetcht0 BYTE PTR [rip+0x100]
    prefetcht0 BYTE PTR [0x1000]
    prefetcht0 BYTE PTR [r13]
    prefetcht1 BYTE PTR [rax]
    prefetcht1 BYTE PTR [rax+0x7f]
    prefetcht1 BYTE PTR [rax+0x80]
    prefetcht1 BYTE PTR [rax+rbx*4]
    prefetcht1 BYTE PTR [rbx*8+0x10]
    prefetcht1 BYTE PTR [rip+0x100]
    prefetcht1 BYTE PTR [0x1000]
    prefetcht1 BYTE PTR [r13]
    prefetcht2 BYTE PTR [rax]
    prefetcht2 BYTE PTR [rax+0x7f]
    prefetcht2 BYTE PTR [rax+0x80]
    prefetcht2 BYTE PTR [rax+rbx*4]
    prefetcht2 BYTE PTR [rbx*8+0x10]
    prefetcht2 BYTE PTR [rip+0x100]
    prefetcht2 BYTE PTR [0x1000]
    prefetcht2 BYTE PTR [r13]
    prefetchnta BYTE PTR [rax]
    prefetchnta BYTE PTR [rax+0x7f]
    prefetchnta BYTE PTR [rax+0x80]
    prefetchnta BYTE PTR [rax+rbx*4]
    prefetchnta BYTE PTR [rbx*8+0x10]
    prefetchnta BYTE PTR [rip+0x100]
    prefetchnta BYTE PTR [0x1000]
    prefetchnta BYTE PTR [r13]
    prefetchit0 BYTE PTR [rax]
    prefetchit0 BYTE PTR [rax+0x7f]
    prefetchit0 BYTE PTR [rax+0x80]
    prefetchit0 BYTE PTR [rax+rbx*4]
    prefetchit0 BYTE PTR [rbx*8+0x10]
    prefetchit0 BYTE PTR [rip+0x100]
    prefetchit0 BYTE PTR [0x1000]
    prefetchit0 BYTE PTR [r13]
    prefetchit1 BYTE PTR [rax]
    prefetchit1 BYTE PTR [rax+0x7f]
    prefetchit1 BYTE PTR [rax+0x80]
    prefetchit1 BYTE PTR [rax+rbx*4]
    prefetchit1 BYTE PTR [rbx*8+0x10]
    prefetchit1 BYTE PTR [rip+0x100]
    prefetchit1 BYTE PTR [0x1000]
    prefetchit1 BYTE PTR [r13]
    prefetchw BYTE PTR [rax]
    prefetchw BYTE PTR [rax+0x7f]
    prefetchw BYTE PTR [rax+0x80]
    prefetchw BYTE PTR [rax+rbx*4]
    prefetchw BYTE PTR [rbx*8+0x10]
    prefetchw BYTE PTR [rip+0x100]
    prefetchw BYTE PTR [0x1000]
    prefetchw BYTE PTR [r13]
    psadbw mm1, QWORD PTR [rax]
    psadbw mm1, QWORD PTR [rax+0x7f]
    psadbw mm1, QWORD PTR [rax+0x80]
    psadbw mm1, QWORD PTR [rax+rbx*4]
    psadbw mm1, QWORD PTR [rbx*8+0x10]
    psadbw mm1, QWORD PTR [rip+0x100]
    psadbw mm1, QWORD PTR [0x1000]
    psadbw mm1, QWORD PTR [r13]
    psadbw xmm1, [rax]
    psadbw xmm1, [rax+0x7f]
    psadbw xmm1, [rax+0x80]
    psadbw xmm1, [rax+rbx*4]
    psadbw xmm1, [rbx*8+0x10]
    psadbw xmm1, [rip+0x100]
    psadbw xmm1, [0x1000]
    psadbw xmm1, [r13]
    vpsadbw xmm1, xmm2, [rax]
    vpsadbw xmm1, xmm2, [rax+0x7f]
    vpsadbw xmm1, xmm2, [rax+0x80]
    vpsadbw xmm1, xmm2, [rax+rbx*4]
    vpsadbw xmm1, xmm2, [rbx*8+0x10]
    vpsadbw xmm1, xmm2, [rip+0x100]
    vpsadbw xmm1, xmm2, [0x1000]
    vpsadbw xmm1, xmm2, [r13]
    vpsadbw ymm1, ymm2, [rax]
    vpsadbw ymm1, ymm2, [rax+0x7f]
    vpsadbw ymm1, ymm2, [rax+0x80]
    vpsadbw ymm1, ymm2, [rax+rbx*4]
    vpsadbw ymm1, ymm2, [rbx*8+0x10]
    vpsadbw ymm1, ymm2, [rip+0x100]
    vpsadbw ymm1, ymm2, [0x1000]
    vpsadbw ymm1, ymm2, [r13]
    pshufb mm1, QWORD PTR [rax]
    pshufb mm1, QWORD PTR [rax+0x7f]
    pshufb mm1, QWORD PTR [rax+0x80]
    pshufb mm1, QWORD PTR [rax+rbx*4]
    pshufb mm1, QWORD PTR [rbx*8+0x10]
    pshufb mm1, QWORD PTR [rip+0x100]
    pshufb mm1, QWORD PTR [0x1000]
    pshufb mm1, QWORD PTR [r13]
    pshufb xmm1, [rax]
    pshufb xmm1, [rax+0x7f]
    pshufb xmm1, [rax+0x80]
    pshufb xmm1, [rax+rbx*4]
    pshufb xmm1, [rbx*8+0x10]
    pshufb xmm1, [rip+0x100]
    pshufb xmm1, [0x1000]
    pshufb xmm1, [r13]
    vpshufb xmm1, xmm2, [rax]
    vpshufb xmm1, xmm2, [rax+0x7f]
    vpshufb xmm1, xmm2, [rax+0x80]
    vpshufb xmm1, xmm2, [rax+rbx*4]
    vpshufb xmm1, xmm2, [rbx*8+0x10]
    vpshufb xmm1, xmm2, [rip+0x100]
    vpshufb xmm1, xmm2, [0x1000]
    vpshufb xmm1, xmm2, [r13]
    vpshufb ymm1, ymm2, [rax]
    vpshufb ymm1, ymm2, [rax+0x7f]
    vpshufb ymm1, ymm2, [rax+0x80]
    vpshufb ymm1, ymm2, [rax+rbx*4]
    vpshufb ymm1, ymm2, [rbx*8+0x10]
    vpshufb ymm1, ymm2, [rip+0x100]
    vpshufb ymm1, ymm2, [0x1000]
    vpshufb ymm1, ymm2, [r13]
    pshufd xmm1, [rax], 0x1
    pshufd xmm1, [rax+0x7f], 0x1
    pshufd xmm1, [rax+0x80], 0x1
    pshufd xmm1, [rax+rbx*4], 0x1
    pshufd xmm1, [rbx*8+0x10], 0x1
    pshufd xmm1, [rip+0x100], 0x1
    pshufd xmm1, [0x1000], 0x1
    pshufd xmm1, [r13], 0x1
    vpshufd xmm1, [rax], 0x1
    vpshufd xmm1, [rax+0x7f], 0x1
    vpshufd xmm1, [rax+0x80], 0x1
    vpshufd xmm1, [rax+rbx*4], 0x1
    vpshufd xmm1, [rbx*8+0x10], 0x1
    vpshufd xmm1, [rip+0x100], 0x1
    vpshufd xmm1, [0x1000], 0x1
    vpshufd xmm1, [r13], 0x1
    vpshufd ymm1, [rax], 0x1
    vpshufd ymm1, [rax+0x7f], 0x1
    vpshufd ymm1, [rax+0x80], 0x1
    vpshufd ymm1, [rax+rbx*4], 0x1
    vpshufd ymm1, [rbx*8+0x10], 0x1
    vpshufd ymm1, [rip+0x100], 0x1
    vpshufd ymm1, [0x1000], 0x1
    vpshufd ymm1, [r13], 0x1
    pshufhw xmm1, [rax], 0x1
    pshufhw xmm1, [rax+0x7f], 0x1
    pshufhw xmm1, [rax+0x80], 0x1
    pshufhw xmm1, [rax+rbx*4], 0x1
    pshufhw xmm1, [rbx*8+0x10], 0x1
    pshufhw xmm1, [rip+0x100], 0x1
    pshufhw xmm1, [0x1000], 0x1
    pshufhw xmm1, [r13], 0x1
    vpshufhw xmm1, [rax], 0x1
    vpshufhw xmm1, [rax+0x7f], 0x1
    vpshufhw xmm1, [rax+0x80], 0x1
    vpshufhw xmm1, [rax+rbx*4], 0x1
    vpshufhw xmm1, [rbx*8+0x10], 0x1
    vpshufhw xmm1, [rip+0x100], 0x1
    vpshufhw xmm1, [0x1000], 0x1
    vpshufhw xmm1, [r13], 0x1
    vpshufhw ymm1, [rax], 0x1
    vpshufhw ymm1, [rax+0x7f], 0x1
    vpshufhw ymm1, [rax+0x80], 0x1
    vpshufhw ymm1, [rax+rbx*4], 0x1
    vpshufhw ymm1, [rbx*8+0x10], 0x1
    vpshufhw ymm1, [rip+0x100], 0x1
    vpshufhw ymm1, [0x1000], 0x1
    vpshufhw ymm1, [r13], 0x1
    pshuflw xmm1, [rax], 0x1
    pshuflw xmm1, [rax+0x7f], 0x1
    pshuflw xmm1, [rax+0x80], 0x1
    pshuflw xmm1, [rax+rbx*4], 0x1
    pshuflw xmm1, [rbx*8+0x10], 0x1
    pshuflw xmm1, [rip+0x100], 0x1
    pshuflw xmm1, [0x1000], 0x1
    pshuflw xmm1, [r13], 0x1
    vpshuflw xmm1, [rax], 0x1
    vpshuflw xmm1, [rax+0x7f], 0x1
    vpshuflw xmm1, [rax+0x80], 0x1
    vpshuflw xmm1, [rax+rbx*4], 0x1
    vpshuflw xmm1, [rbx*8+0x10], 0x1
    vpshuflw xmm1, [rip+0x100], 0x1
    vpshuflw xmm1, [0x1000], 0x1
    vpshuflw xmm1, [r13], 0x1
    vpshuflw ymm1, [rax], 0x1
    vpshuflw ymm1, [rax+0x7f], 0x1
    vpshuflw ymm1, [rax+0x80], 0x1
    vpshuflw ymm1, [rax+rbx*4], 0x1
    vpshuflw ymm1, [rbx*8+0x10], 0x1
    vpshuflw ymm1, [rip+0x100], 0x1
    vpshuflw ymm1, [0x1000], 0x1
    vpshuflw ymm1, [r13], 0x1
    pshufw mm1, QWORD PTR [rax], 0x1
    pshufw mm1, QWORD PTR [rax+0x7f], 0x1
    pshufw mm1, QWORD PTR [rax+0x80], 0x1
    pshufw mm1, QWORD PTR [rax+rbx*4], 0x1
    pshufw mm1, QWORD PTR [rbx*8+0x10], 0x1
    pshufw mm1, QWORD PTR [rip+0x100], 0x1
    pshufw mm1, QWORD PTR [0x1000], 0x1
    pshufw mm1, QWORD PTR [r13], 0x1
    psignb mm1, QWORD PTR [rax]
    psignb mm1, QWORD PTR [rax+0x7f]
    psignb mm1, QWORD PTR [rax+0x80]
    psignb mm1, QWORD PTR [rax+rbx*4]
    psignb mm1, QWORD PTR [rbx*8+0x10]
    psignb mm1, QWORD PTR [rip+0x100]
    psignb mm1, QWORD PTR [0x1000]
    psignb mm1, QWORD PTR [r13]
    psignb xmm1, [rax]
    psignb xmm1, [rax+0x7f]
    psignb xmm1, [rax+0x80]
    psignb xmm1, [rax+rbx*4]
    psignb xmm1, [rbx*8+0x10]
    psignb xmm1, [rip+0x100]
    psignb xmm1, [0x1000]
    psignb xmm1, [r13]
    psignw mm1, QWORD PTR [rax]
    psignw mm1, QWORD PTR [rax+0x7f]
    psignw mm1, QWORD PTR [rax+0x80]
    psignw mm1, QWORD PTR [rax+rbx*4]
    psignw mm1, QWORD PTR [rbx*8+0x10]
    psignw mm1, QWORD PTR [rip+0x100]
    psignw mm1, QWORD PTR [0x1000]
    psignw mm1, QWORD PTR [r13]
    psignw xmm1, [rax]
    psignw xmm1, [rax+0x7f]
    psignw xmm1, [rax+0x80]
    psignw xmm1, [rax+rbx*4]
    psignw xmm1, [rbx*8+0x10]
    psignw xmm1, [rip+0x100]
    psignw xmm1, [0x1000]
    psignw xmm1, [r13]
    psignd mm1, QWORD PTR [rax]
    psignd mm1, QWORD PTR [rax+0x7f]
    psignd mm1, QWORD PTR [rax+0x80]
    psignd mm1, QWORD PTR [rax+rbx*4]
    psignd mm1, QWORD PTR [rbx*8+0x10]
    psignd mm1, QWORD PTR [rip+0x100]
    psignd mm1, QWORD PTR [0x1000]
    psignd mm1, QWORD PTR [r13]
    psignd xmm1, [rax]
    psignd xmm1, [rax+0x7f]
    psignd xmm1, [rax+0x80]
    psignd xmm1, [rax+rbx*4]
    psignd xmm1, [rbx*8+0x10]
    psignd xmm1, [rip+0x100]
    psignd xmm1, [0x1000]
    psignd xmm1, [r13]
    vpsignb xmm1, xmm2, [rax]
    vpsignb xmm1, xmm2, [rax+0x7f]
    vpsignb xmm1, xmm2, [rax+0x80]
    vpsignb xmm1, xmm2, [rax+rbx*4]
    vpsignb xmm1, xmm2, [rbx*8+0x10]
    vpsignb xmm1, xmm2, [rip+0x100]
    vpsignb xmm1, xmm2, [0x1000]
    vpsignb xmm1, xmm2, [r13]
    vpsignw xmm1, xmm2, [rax]
    vpsignw xmm1, xmm2, [rax+0x7f]
    vpsignw xmm1, xmm2, [rax+0x80]
    vpsignw xmm1, xmm2, [rax+rbx*4]
    vpsignw xmm1, xmm2, [rbx*8+0x10]
    vpsignw xmm1, xmm2, [rip+0x100]
    vpsignw xmm1, xmm2, [0x1000]
    vpsignw xmm1, xmm2, [r13]
    vpsignd xmm1, xmm2, [rax]
    vpsignd xmm1, xmm2, [rax+0x7f]
    vpsignd xmm1, xmm2, [rax+0x80]
    vpsignd xmm1, xmm2, [rax+rbx*4]
    vpsignd xmm1, xmm2, [rbx*8+0x10]
    vpsignd xmm1, xmm2, [rip+0x100]
    vpsignd xmm1, xmm2, [0x1000]
    vpsignd xmm1, xmm2, [r13]
    vpsignb ymm1, ymm2, [rax]
    vpsignb ymm1, ymm2, [rax+0x7f]
    vpsignb ymm1, ymm2, [rax+0x80]
    vpsignb ymm1, ymm2, [rax+rbx*4]
    vpsignb ymm1, ymm2, [rbx*8+0x10]
    vpsignb ymm1, ymm2, [rip+0x100]
    vpsignb ymm1, ymm2, [0x1000]
    vpsignb ymm1, ymm2, [r13]
    vpsignw ymm1, ymm2, [rax]
    vpsignw ymm1, ymm2, [rax+0x7f]
    vpsignw ymm1, ymm2, [rax+0x80]
    vpsignw ymm1, ymm2, [rax+rbx*4]
    vpsignw ymm1, ymm2, [rbx*8+0x10]
    vpsignw ymm1, ymm2, [rip+0x100]
    vpsignw ymm1, ymm2, [0x1000]
    vpsignw ymm1, ymm2, [r13]
    vpsignd ymm1, ymm2, [rax]
    vpsignd ymm1, ymm2, [rax+0x7f]
    vpsignd ymm1, ymm2, [rax+0x80]
    vpsignd ymm1, ymm2, [rax+rbx*4]
    vpsignd ymm1, ymm2, [rbx*8+0x10]
    vpsignd ymm1, ymm2, [rip+0x100]
    vpsignd ymm1, ymm2, [0x1000]
    vpsignd ymm1, ymm2, [r13]
    psllw mm0, QWORD PTR [rax]
    psllw mm0, QWORD PTR [rax+0x7f]
    psllw mm0, QWORD PTR [rax+0x80]
    psllw mm0, QWORD PTR [rax+rbx*4]
    psllw mm0, QWORD PTR [rbx*8+0x10]
    psllw mm0, QWORD PTR [rip+0x100]
    psllw mm0, QWORD PTR [0x1000]
    psllw mm0, QWORD PTR [r13]
    psllw xmm1, [rax]
    psllw xmm1, [rax+0x7f]
    psllw xmm1, [rax+0x80]
    psllw xmm1, [rax+rbx*4]
    psllw xmm1, [rbx*8+0x10]
    psllw xmm1, [rip+0x100]
    psllw xmm1, [0x1000]
    psllw xmm1, [r13]
    pslld mm0, QWORD PTR [rax]
    pslld mm0, QWORD PTR [rax+0x7f]
    pslld mm0, QWORD PTR [rax+0x80]
    pslld mm0, QWORD PTR [rax+rbx*4]
    pslld mm0, QWORD PTR [rbx*8+0x10]
    pslld mm0, QWORD PTR [rip+0x100]
    pslld mm0, QWORD PTR [0x1000]
    pslld mm0, QWORD PTR [r13]
    pslld xmm1, [rax]
    pslld xmm1, [rax+0x7f]
    pslld xmm1, [rax+0x80]
    pslld xmm1, [rax+rbx*4]
    pslld xmm1, [rbx*8+0x10]
    pslld xmm1, [rip+0x100]
    pslld xmm1, [0x1000]
    pslld xmm1, [r13]
    psllq mm0, QWORD PTR [rax]
    psllq mm0, QWORD PTR [rax+0x7f]
    psllq mm0, QWORD PTR [rax+0x80]
    psllq mm0, QWORD PTR [rax+rbx*4]
    psllq mm0, QWORD PTR [rbx*8+0x10]
    psllq mm0, QWORD PTR [rip+0x100]
    psllq mm0, QWORD PTR [0x1000]
    psllq mm0, QWORD PTR [r13]
    psllq xmm1, [rax]
    psllq xmm1, [rax+0x7f]
    psllq xmm1, [rax+0x80]
    psllq xmm1, [rax+rbx*4]
    psllq xmm1, [rbx*8+0x10]
    psllq xmm1, [rip+0x100]
    psllq xmm1, [0x1000]
    psllq xmm1, [r13]
    vpsllw xmm1, xmm2, [rax]
    vpsllw xmm1, xmm2, [rax+0x7f]
    vpsllw xmm1, xmm2, [rax+0x80]
    vpsllw xmm1, xmm2, [rax+rbx*4]
    vpsllw xmm1, xmm2, [rbx*8+0x10]
    vpsllw xmm1, xmm2, [rip+0x100]
    vpsllw xmm1, xmm2, [0x1000]
    vpsllw xmm1, xmm2, [r13]
    vpslld xmm1, xmm2, [rax]
    vpslld xmm1, xmm2, [rax+0x7f]
    vpslld xmm1, xmm2, [rax+0x80]
    vpslld xmm1, xmm2, [rax+rbx*4]
    vpslld xmm1, xmm2, [rbx*8+0x10]
    vpslld xmm1, xmm2, [rip+0x100]
    vpslld xmm1, xmm2, [0x1000]
    vpslld xmm1, xmm2, [r13]
    vpsllq xmm1, xmm2, [rax]
    vpsllq xmm1, xmm2, [rax+0x7f]
    vpsllq xmm1, xmm2, [rax+0x80]
    vpsllq xmm1, xmm2, [rax+rbx*4]
    vpsllq xmm1, xmm2, [rbx*8+0x10]
    vpsllq xmm1, xmm2, [rip+0x100]
    vpsllq xmm1, xmm2, [0x1000]
    vpsllq xmm1, xmm2, [r13]
    vpsllw ymm1, ymm2, [rax]
    vpsllw ymm1, ymm2, [rax+0x7f]
    vpsllw ymm1, ymm2, [rax+0x80]
    vpsllw ymm1, ymm2, [rax+rbx*4]
    vpsllw ymm1, ymm2, [rbx*8+0x10]
    vpsllw ymm1, ymm2, [rip+0x100]
    vpsllw ymm1, ymm2, [0x1000]
    vpsllw ymm1, ymm2, [r13]
    vpslld ymm1, ymm2, [rax]
    vpslld ymm1, ymm2, [rax+0x7f]
    vpslld ymm1, ymm2, [rax+0x80]
    vpslld ymm1, ymm2, [rax+rbx*4]
    vpslld ymm1, ymm2, [rbx*8+0x10]
    vpslld ymm1, ymm2, [rip+0x100]
    vpslld ymm1, ymm2, [0x1000]
    vpslld ymm1, ymm2, [r13]
    vpsllq ymm1, ymm2, [rax]
    vpsllq ymm1, ymm2, [rax+0x7f]
    vpsllq ymm1, ymm2, [rax+0x80]
    vpsllq ymm1, ymm2, [rax+rbx*4]
    vpsllq ymm1, ymm2, [rbx*8+0x10]
    vpsllq ymm1, ymm2, [rip+0x100]
    vpsllq ymm1, ymm2, [0x1000]
    vpsllq ymm1, ymm2, [r13]
    psraw mm0, QWORD PTR [rax]
    psraw mm0, QWORD PTR [rax+0x7f]
    psraw mm0, QWORD PTR [rax+0x80]
    psraw mm0, QWORD PTR [rax+rbx*4]
    psraw mm0, QWORD PTR [rbx*8+0x10]
    psraw mm0, QWORD PTR [rip+0x100]
    psraw mm0, QWORD PTR [0x1000]
    psraw mm0, QWORD PTR [r13]
    psraw xmm1, [rax]
    psraw xmm1, [rax+0x7f]
    psraw xmm1, [rax+0x80]
    psraw xmm1, [rax+rbx*4]
    psraw xmm1, [rbx*8+0x10]
    psraw xmm1, [rip+0x100]
    psraw xmm1, [0x1000]
    psraw xmm1, [r13]
    psrad mm0, QWORD PTR [rax]
    psrad mm0, QWORD PTR [rax+0x7f]
    psrad mm0, QWORD PTR [rax+0x80]
    psrad mm0, QWORD PTR [rax+rbx*4]
    psrad mm0, QWORD PTR [rbx*8+0x10]
    psrad mm0, QWORD PTR [rip+0x100]
    psrad mm0, QWORD PTR [0x1000]
    psrad mm0, QWORD PTR [r13]
    psrad xmm1, [rax]
    psrad xmm1, [rax+0x7f]
    psrad xmm1, [rax+0x80]
    psrad xmm1, [rax+rbx*4]
    psrad xmm1, [rbx*8+0x10]
    psrad xmm1, [rip+0x100]
    psrad xmm1, [0x1000]
    psrad xmm1, [r13]
    vpsraw xmm1, xmm2, [rax]
    vpsraw xmm1, xmm2, [rax+0x7f]
    vpsraw xmm1, xmm2, [rax+0x80]
    vpsraw xmm1, xmm2, [rax+rbx*4]
    vpsraw xmm1, xmm2, [rbx*8+0x10]
    vpsraw xmm1, xmm2, [rip+0x100]
    vpsraw xmm1, xmm2, [0x1000]
    vpsraw xmm1, xmm2, [r13]
    vpsrad xmm1, xmm2, [rax]
    vpsrad xmm1, xmm2, [rax+0x7f]
    vpsrad xmm1, xmm2, [rax+0x80]
    vpsrad xmm1, xmm2, [rax+rbx*4]
    vpsrad xmm1, xmm2, [rbx*8+0x10]
    vpsrad xmm1, xmm2, [rip+0x100]
    vpsrad xmm1, xmm2, [0x1000]
    vpsrad xmm1, xmm2, [r13]
    vpsraw ymm1, ymm2, [rax]
    vpsraw ymm1, ymm2, [rax+0x7f]
    vpsraw ymm1, ymm2, [rax+0x80]
    vpsraw ymm1, ymm2, [rax+rbx*4]
    vpsraw ymm1, ymm2, [rbx*8+0x10]
    vpsraw ymm1, ymm2, [rip+0x100]
    vpsraw ymm1, ymm2, [0x1000]
    vpsraw ymm1, ymm2, [r13]
    vpsrad ymm1, ymm2, [rax]
    vpsrad ymm1, ymm2, [rax+0x7f]
    vpsrad ymm1, ymm2, [rax+0x80]
    vpsrad ymm1, ymm2, [rax+rbx*4]
    vpsrad ymm1, ymm2, [rbx*8+0x10]
    vpsrad ymm1, ymm2, [rip+0x100]
    vpsrad ymm1, ymm2, [0x1000]
    vpsrad ymm1, ymm2, [r13]
    psrlw mm0, QWORD PTR [rax]
    psrlw mm0, QWORD PTR [rax+0x7f]
    psrlw mm0, QWORD PTR [rax+0x80]
    psrlw mm0, QWORD PTR [rax+rbx*4]
    psrlw mm0, QWORD PTR [rbx*8+0x10]
    psrlw mm0, QWORD PTR [rip+0x100]
    psrlw mm0, QWORD PTR [0x1000]
    psrlw mm0, QWORD PTR [r13]
    psrlw xmm1, [rax]
    psrlw xmm1, [rax+0x7f]
    psrlw xmm1, [rax+0x80]
    psrlw xmm1, [rax+rbx*4]
    psrlw xmm1, [rbx*8+0x10]
    psrlw xmm1, [rip+0x100]
    psrlw xmm1, [0x1000]
    psrlw xmm1, [r13]
    psrld mm0, QWORD PTR [rax]
    psrld mm0, QWORD PTR [rax+0x7f]
    psrld mm0, QWORD PTR [rax+0x80]
    psrld mm0, QWORD PTR [rax+rbx*4]
    psrld mm0, QWORD PTR [rbx*8+0x10]
    psrld mm0, QWORD PTR [rip+0x100]
    psrld mm0, QWORD PTR [0x1000]
    psrld mm0, QWORD PTR [r13]
    psrld xmm1, [rax]
    psrld xmm1, [rax+0x7f]
    psrld xmm1, [rax+0x80]
    psrld xmm1, [rax+rbx*4]
    psrld xmm1, [rbx*8+0x10]
    psrld xmm1, [rip+0x100]
    psrld xmm1, [0x1000]
    psrld xmm1, [r13]
    psrlq mm0, QWORD PTR [rax]
    psrlq mm0, QWORD PTR [rax+0x7f]
    psrlq mm0, QWORD PTR [rax+0x80]
    psrlq mm0, QWORD PTR [rax+rbx*4]
    psrlq mm0, QWORD PTR [rbx*8+0x10]
    psrlq mm0, QWORD PTR [rip+0x100]
    psrlq mm0, QWORD PTR [0x1000]
    psrlq mm0, QWORD PTR [r13]
    psrlq xmm1, [rax]
    psrlq xmm1, [rax+0x7f]
    psrlq xmm1, [rax+0x80]
    psrlq xmm1, [rax+rbx*4]
    psrlq xmm1, [rbx*8+0x10]
    psrlq xmm1, [rip+0x100]
    psrlq xmm1, [0x1000]
    psrlq xmm1, [r13]
    vpsrlw xmm1, xmm2, [rax]
    vpsrlw xmm1, xmm2, [rax+0x7f]
    vpsrlw xmm1, xmm2, [rax+0x80]
    vpsrlw xmm1, xmm2, [rax+rbx*4]
    vpsrlw xmm1, xmm2, [rbx*8+0x10]
    vpsrlw xmm1, xmm2, [rip+0x100]
    vpsrlw xmm1, xmm2, [0x1000]
    vpsrlw xmm1, xmm2, [r13]
    vpsrld xmm1, xmm2, [rax]
    vpsrld xmm1, xmm2, [rax+0x7f]
    vpsrld xmm1, xmm2, [rax+0x80]
    vpsrld xmm1, xmm2, [rax+rbx*4]
    vpsrld xmm1, xmm2, [rbx*8+0x10]
    vpsrld xmm1, xmm2, [rip+0x100]
    vpsrld xmm1, xmm2, [0x1000]
    vpsrld xmm1, xmm2, [r13]
    vpsrlq xmm1, xmm2, [rax]
    vpsrlq xmm1, xmm2, [rax+0x7f]
    vpsrlq xmm1, xmm2, [rax+0x80]
    vpsrlq xmm1, xmm2, [rax+rbx*4]
    vpsrlq xmm1, xmm2, [rbx*8+0x10]
    vpsrlq xmm1, xmm2, [rip+0x100]
    vpsrlq xmm1, xmm2, [0x1000]
    vpsrlq xmm1, xmm2, [r13]
    vpsrlw ymm1, ymm2, [rax]
    vpsrlw ymm1, ymm2, [rax+0x7f]
    vpsrlw ymm1, ymm2, [rax+0x80]
    vpsrlw ymm1, ymm2, [rax+rbx*4]
    vpsrlw ymm1, ymm2, [rbx*8+0x10]
    vpsrlw ymm1, ymm2, [rip+0x100]
    vpsrlw ymm1, ymm2, [0x1000]
    vpsrlw ymm1, ymm2, [r13]
    vpsrld ymm1, ymm2, [rax]
    vpsrld ymm1, ymm2, [rax+0x7f]
    vpsrld ymm1, ymm2, [rax+0x80]
    vpsrld ymm1, ymm2, [rax+rbx*4]
    vpsrld ymm1, ymm2, [rbx*8+0x10]
    vpsrld ymm1, ymm2, [rip+0x100]
    vpsrld ymm1, ymm2, [0x1000]
    vpsrld ymm1, ymm2, [r13]
    vpsrlq ymm1, ymm2, [rax]
    vpsrlq ymm1, ymm2, [rax+0x7f]
    vpsrlq ymm1, ymm2, [rax+0x80]
    vpsrlq ymm1, ymm2, [rax+rbx*4]
    vpsrlq ymm1, ymm2, [rbx*8+0x10]
    vpsrlq ymm1, ymm2, [rip+0x100]
    vpsrlq ymm1, ymm2, [0x1000]
    vpsrlq ymm1, ymm2, [r13]
    psubb mm0, QWORD PTR [rax]
    psubb mm0, QWORD PTR [rax+0x7f]
    psubb mm0, QWORD PTR [rax+0x80]
    psubb mm0, QWORD PTR [rax+rbx*4]
    psubb mm0, QWORD PTR [rbx*8+0x10]
    psubb mm0, QWORD PTR [rip+0x100]
    psubb mm0, QWORD PTR [0x1000]
    psubb mm0, QWORD PTR [r13]
    psubb xmm1, [rax]
    psubb xmm1, [rax+0x7f]
    psubb xmm1, [rax+0x80]
    psubb xmm1, [rax+rbx*4]
    psubb xmm1, [rbx*8+0x10]
    psubb xmm1, [rip+0x100]
    psubb xmm1, [0x1000]
    psubb xmm1, [r13]
    psubw mm0, QWORD PTR [rax]
    psubw mm0, QWORD PTR [rax+0x7f]
    psubw mm0, QWORD PTR [rax+0x80]
    psubw mm0, QWORD PTR [rax+rbx*4]
    psubw mm0, QWORD PTR [rbx*8+0x10]
    psubw mm0, QWORD PTR [rip+0x100]
    psubw mm0, QWORD PTR [0x1000]
    psubw mm0, QWORD PTR [r13]
    psubw xmm1, [rax]
    psubw xmm1, [rax+0x7f]
    psubw xmm1, [rax+0x80]
    psubw xmm1, [rax+rbx*4]
    psubw xmm1, [rbx*8+0x10]
    psubw xmm1, [rip+0x100]
    psubw xmm1, [0x1000]
    psubw xmm1, [r13]
    psubd mm0, QWORD PTR [rax]
    psubd mm0, QWORD PTR [rax+0x7f]
    psubd mm0, QWORD PTR [rax+0x80]
    psubd mm0, QWORD PTR [rax+rbx*4]
    psubd mm0, QWORD PTR [rbx*8+0x10]
    psubd mm0, QWORD PTR [rip+0x100]
    psubd mm0, QWORD PTR [0x1000]
    psubd mm0, QWORD PTR [r13]
    psubd xmm1, [rax]
    psubd xmm1, [rax+0x7f]
    psubd xmm1, [rax+0x80]
    psubd xmm1, [rax+rbx*4]
    psubd xmm1, [rbx*8+0x10]
    psubd xmm1, [rip+0x100]
    psubd xmm1, [0x1000]
    psubd xmm1, [r13]
    vpsubb xmm1, xmm2, [rax]
    vpsubb xmm1, xmm2, [rax+0x7f]
    vpsubb xmm1, xmm2, [rax+0x80]
    vpsubb xmm1, xmm2, [rax+rbx*4]
    vpsubb xmm1, xmm2, [rbx*8+0x10]
    vpsubb xmm1, xmm2, [rip+0x100]
    vpsubb xmm1, xmm2, [0x1000]
    vpsubb xmm1, xmm2, [r13]
    vpsubw xmm1, xmm2, [rax]
    vpsubw xmm1, xmm2, [rax+0x7f]
    vpsubw xmm1, xmm2, [rax+0x80]
    vpsubw xmm1, xmm2, [rax+rbx*4]
    vpsubw xmm1, xmm2, [rbx*8+0x10]
    vpsubw xmm1, xmm2, [rip+0x100]
    vpsubw xmm1, xmm2, [0x1000]
    vpsubw xmm1, xmm2, [r13]
    vpsubd xmm1, xmm2, [rax]
    vpsubd xmm1, xmm2, [rax+0x7f]
    vpsubd xmm1, xmm2, [rax+0x80]
    vpsubd xmm1, xmm2, [rax+rbx*4]
    vpsubd xmm1, xmm2, [rbx*8+0x10]
    vpsubd xmm1, xmm2, [rip+0x100]
    vpsubd xmm1, xmm2, [0x1000]
    vpsubd xmm1, xmm2, [r13]
    vpsubb ymm1, ymm2, [rax]
    vpsubb ymm1, ymm2, [rax+0x7f]
    vpsubb ymm1, ymm2, [rax+0x80]
    vpsubb ymm1, ymm2, [rax+rbx*4]
    vpsubb ymm1, ymm2, [rbx*8+0x10]
    vpsubb ymm1, ymm2, [rip+0x100]
    vpsubb ymm1, ymm2, [0x1000]
    vpsubb ymm1, ymm2, [r13]
    vpsubw ymm1, ymm2, [rax]
    vpsubw ymm1, ymm2, [rax+0x7f]
    vpsubw ymm1, ymm2, [rax+0x80]
    vpsubw ymm1, ymm2, [rax+rbx*4]
    vpsubw ymm1, ymm2, [rbx*8+0x10]
    vpsubw ymm1, ymm2, [rip+0x100]
    vpsubw ymm1, ymm2, [0x1000]
    vpsubw ymm1, ymm2, [r13]
    vpsubd ymm1, ymm2, [rax]
    vpsubd ymm1, ymm2, [rax+0x7f]
    vpsubd ymm1, ymm2, [rax+0x80]
    vpsubd ymm1, ymm2, [rax+rbx*4]
    vpsubd ymm1, ymm2, [rbx*8+0x10]
    vpsubd ymm1, ymm2, [rip+0x100]
    vpsubd ymm1, ymm2, [0x1000]
    vpsubd ymm1, ymm2, [r13]
    psubq mm1, QWORD PTR [rax]
    psubq mm1, QWORD PTR [rax+0x7f]
    psubq mm1, QWORD PTR [rax+0x80]
    psubq mm1, QWORD PTR [rax+rbx*4]
    psubq mm1, QWORD PTR [rbx*8+0x10]
    psubq mm1, QWORD PTR [rip+0x100]
    psubq mm1, QWORD PTR [0x1000]
    psubq mm1, QWORD PTR [r13]
    psubq xmm1, [rax]
    psubq xmm1, [rax+0x7f]
    psubq xmm1, [rax+0x80]
    psubq xmm1, [rax+rbx*4]
    psubq xmm1, [rbx*8+0x10]
    psubq xmm1, [rip+0x100]
    psubq xmm1, [0x1000]
    psubq xmm1, [r13]
    vpsubq xmm1, xmm2, [rax]
    vpsubq xmm1, xmm2, [rax+0x7f]
    vpsubq xmm1, xmm2, [rax+0x80]
    vpsubq xmm1, xmm2, [rax+rbx*4]
    vpsubq xmm1, xmm2, [rbx*8+0x10]
    vpsubq xmm1, xmm2, [rip+0x100]
    vpsubq xmm1, xmm2, [0x1000]
    vpsubq xmm1, xmm2, [r13]
    vpsubq ymm1, ymm2, [rax]
    vpsubq ymm1, ymm2, [rax+0x7f]
    vpsubq ymm1, ymm2, [rax+0x80]
    vpsubq ymm1, ymm2, [rax+rbx*4]
    vpsubq ymm1, ymm2, [rbx*8+0x10]
    vpsubq ymm1, ymm2, [rip+0x100]
    vpsubq ymm1, ymm2, [0x1000]
    vpsubq ymm1, ymm2, [r13]
    psubsb mm0, QWORD PTR [rax]
    psubsb mm0, QWORD PTR [rax+0x7f]
    psubsb mm0, QWORD PTR [rax+0x80]
    psubsb mm0, QWORD PTR [rax+rbx*4]
    psubsb mm0, QWORD PTR [rbx*8+0x10]
    psubsb mm0, QWORD PTR [rip+0x100]
    psubsb mm0, QWORD PTR [0x1000]
    psubsb mm0, QWORD PTR [r13]
    psubsb xmm1, [rax]
    psubsb xmm1, [rax+0x7f]
    psubsb xmm1, [rax+0x80]
    psubsb xmm1, [rax+rbx*4]
    psubsb xmm1, [rbx*8+0x10]
    psubsb xmm1, [rip+0x100]
    psubsb xmm1, [0x1000]
    psubsb xmm1, [r13]
    psubsw mm0, QWORD PTR [rax]
    psubsw mm0, QWORD PTR [rax+0x7f]
    psubsw mm0, QWORD PTR [rax+0x80]
    psubsw mm0, QWORD PTR [rax+rbx*4]
    psubsw mm0, QWORD PTR [rbx*8+0x10]
    psubsw mm0, QWORD PTR [rip+0x100]
    psubsw mm0, QWORD PTR [0x1000]
    psubsw mm0, QWORD PTR [r13]
    psubsw xmm1, [rax]
    psubsw xmm1, [rax+0x7f]
    psubsw xmm1, [rax+0x80]
    psubsw xmm1, [rax+rbx*4]
    psubsw xmm1, [rbx*8+0x10]
    psubsw xmm1, [rip+0x100]
    psubsw xmm1, [0x1000]
    psubsw xmm1, [r13]
    vpsubsb xmm1, xmm2, [rax]
    vpsubsb xmm1, xmm2, [rax+0x7f]
    vpsubsb xmm1, xmm2, [rax+0x80]
    vpsubsb xmm1, xmm2, [rax+rbx*4]
    vpsubsb xmm1, xmm2, [rbx*8+0x10]
    vpsubsb xmm1, xmm2, [rip+0x100]
    vpsubsb xmm1, xmm2, [0x1000]
    vpsubsb xmm1, xmm2, [r13]
    vpsubsw xmm1, xmm2, [rax]
    vpsubsw xmm1, xmm2, [rax+0x7f]
    vpsubsw xmm1, xmm2, [rax+0x80]
    vpsubsw xmm1, xmm2, [rax+rbx*4]
    vpsubsw xmm1, xmm2, [rbx*8+0x10]
    vpsubsw xmm1, xmm2, [rip+0x100]
    vpsubsw xmm1, xmm2, [0x1000]
    vpsubsw xmm1, xmm2, [r13]
    vpsubsb ymm1, ymm2, [rax]
    vpsubsb ymm1, ymm2, [rax+0x7f]
    vpsubsb ymm1, ymm2, [rax+0x80]
    vpsubsb ymm1, ymm2, [rax+rbx*4]
    vpsubsb ymm1, ymm2, [rbx*8+0x10]
    vpsubsb ymm1, ymm2, [rip+0x100]
    vpsubsb ymm1, ymm2, [0x1000]
    vpsubsb ymm1, ymm2, [r13]
    vpsubsw ymm1, ymm2, [rax]
    vpsubsw ymm1, ymm2, [rax+0x7f]
    vpsubsw ymm1, ymm2, [rax+0x80]
    vpsubsw ymm1, ymm2, [rax+rbx*4]
    vpsubsw ymm1, ymm2, [rbx*8+0x10]
    vpsubsw ymm1, ymm2, [rip+0x100]
    vpsubsw ymm1, ymm2, [0x1000]
    vpsubsw ymm1, ymm2, [r13]
    psubusb mm0, QWORD PTR [rax]
    psubusb mm0, QWORD PTR [rax+0x7f]
    psubusb mm0, QWORD PTR [rax+0x80]
    psubusb mm0, QWORD PTR [rax+rbx*4]
    psubusb mm0, QWORD PTR [rbx*8+0x10]
    psubusb mm0, QWORD PTR [rip+0x100]
    psubusb mm0, QWORD PTR [0x1000]
    psubusb mm0, QWORD PTR [r13]
    psubusb xmm1, [rax]
    psubusb xmm1, [rax+0x7f]
    psubusb xmm1, [rax+0x80]
    psubusb xmm1, [rax+rbx*4]
    psubusb xmm1, [rbx*8+0x10]
    psubusb xmm1, [rip+0x100]
    psubusb xmm1, [0x1000]
    psubusb xmm1, [r13]
    psubusw mm0, QWORD PTR [rax]
    psubusw mm0, QWORD PTR [rax+0x7f]
    psubusw mm0, QWORD PTR [rax+0x80]
    psubusw mm0, QWORD PTR [rax+rbx*4]
    psubusw mm0, QWORD PTR [rbx*8+0x10]
    psubusw mm0, QWORD PTR [rip+0x100]
    psubusw mm0, QWORD PTR [0x1000]
    psubusw mm0, QWORD PTR [r13]
    psubusw xmm1, [rax]
    psubusw xmm1, [rax+0x7f]
    psubusw xmm1, [rax+0x80]
    psubusw xmm1, [rax+rbx*4]
    psubusw xmm1, [rbx*8+0x10]
    psubusw xmm1, [rip+0x100]
    psubusw xmm1, [0x1000]
    psubusw xmm1, [r13]
    vpsubusb xmm1, xmm2, [rax]
    vpsubusb xmm1, xmm2, [rax+0x7f]
    vpsubusb xmm1, xmm2, [rax+0x80]
    vpsubusb xmm1, xmm2, [rax+rbx*4]
    vpsubusb xmm1, xmm2, [rbx*8+0x10]
    vpsubusb xmm1, xmm2, [rip+0x100]
    vpsubusb xmm1, xmm2, [0x1000]
    vpsubusb xmm1, xmm2, [r13]
    vpsubusw xmm1, xmm2, [rax]
    vpsubusw xmm1, xmm2, [rax+0x7f]
    vpsubusw xmm1, xmm2, [rax+0x80]
    vpsubusw xmm1, xmm2, [rax+rbx*4]
    vpsubusw xmm1, xmm2, [rbx*8+0x10]
    vpsubusw xmm1, xmm2, [rip+0x100]
    vpsubusw xmm1, xmm2, [0x1000]
    vpsubusw xmm1, xmm2, [r13]
    vpsubusb ymm1, ymm2, [rax]
    vpsubusb ymm1, ymm2, [rax+0x7f]
    vpsubusb ymm1, ymm2, [rax+0x80]
    vpsubusb ymm1, ymm2, [rax+rbx*4]
    vpsubusb ymm1, ymm2, [rbx*8+0x10]
    vpsubusb ymm1, ymm2, [rip+0x100]
    vpsubusb ymm1, ymm2, [0x1000]
    vpsubusb ymm1, ymm2, [r13]
    vpsubusw ymm1, ymm2, [rax]
    vpsubusw ymm1, ymm2, [rax+0x7f]
    vpsubusw ymm1, ymm2, [rax+0x80]
    vpsubusw ymm1, ymm2, [rax+rbx*4]
    vpsubusw ymm1, ymm2, [rbx*8+0x10]
    vpsubusw ymm1, ymm2, [rip+0x100]
    vpsubusw ymm1, ymm2, [0x1000]
    vpsubusw ymm1, ymm2, [r13]
    ptest xmm1, [rax]
    ptest xmm1, [rax+0x7f]
    ptest xmm1, [rax+0x80]
    ptest xmm1, [rax+rbx*4]
    ptest xmm1, [rbx*8+0x10]
    ptest xmm1, [rip+0x100]
    ptest xmm1, [0x1000]
    ptest xmm1, [r13]
    vptest xmm1, [rax]
    vptest xmm1, [rax+0x7f]
    vptest xmm1, [rax+0x80]
    vptest xmm1, [rax+rbx*4]
    vptest xmm1, [rbx*8+0x10]
    vptest xmm1, [rip+0x100]
    vptest xmm1, [0x1000]
    vptest xmm1, [r13]
    vptest ymm1, [rax]
    vptest ymm1, [rax+0x7f]
    vptest ymm1, [rax+0x80]
    vptest ymm1, [rax+rbx*4]
    vptest ymm1, [rbx*8+0x10]
    vptest ymm1, [rip+0x100]
    vptest ymm1, [0x1000]
    vptest ymm1, [r13]
    ptwrite QWORD PTR [rax]
    ptwrite QWORD PTR [rax+0x7f]
    ptwrite QWORD PTR [rax+0x80]
    ptwrite QWORD PTR [rax+rbx*4]
    ptwrite QWORD PTR [rbx*8+0x10]
    ptwrite QWORD PTR [rip+0x100]
    ptwrite QWORD PTR [0x1000]
    ptwrite QWORD PTR [r13]
    ptwrite DWORD PTR [rax]
    ptwrite DWORD PTR [rax+0x7f]
    ptwrite DWORD PTR [rax+0x80]
    ptwrite DWORD PTR [rax+rbx*4]
    ptwrite DWORD PTR [rbx*8+0x10]
    ptwrite DWORD PTR [rip+0x100]
    ptwrite DWORD PTR [0x1000]
    ptwrite DWORD PTR [r13]
    punpckhbw mm0, QWORD PTR [rax]
    punpckhbw mm0, QWORD PTR [rax+0x7f]
    punpckhbw mm0, QWORD PTR [rax+0x80]
    punpckhbw mm0, QWORD PTR [rax+rbx*4]
    punpckhbw mm0, QWORD PTR [rbx*8+0x10]
    punpckhbw mm0, QWORD PTR [rip+0x100]
    punpckhbw mm0, QWORD PTR [0x1000]
    punpckhbw mm0, QWORD PTR [r13]
    punpckhbw xmm1, [rax]
    punpckhbw xmm1, [rax+0x7f]
    punpckhbw xmm1, [rax+0x80]
    punpckhbw xmm1, [rax+rbx*4]
    punpckhbw xmm1, [rbx*8+0x10]
    punpckhbw xmm1, [rip+0x100]
    punpckhbw xmm1, [0x1000]
    punpckhbw xmm1, [r13]
    punpckhwd mm0, QWORD PTR [rax]
    punpckhwd mm0, QWORD PTR [rax+0x7f]
    punpckhwd mm0, QWORD PTR [rax+0x80]
    punpckhwd mm0, QWORD PTR [rax+rbx*4]
    punpckhwd mm0, QWORD PTR [rbx*8+0x10]
    punpckhwd mm0, QWORD PTR [rip+0x100]
    punpckhwd mm0, QWORD PTR [0x1000]
    punpckhwd mm0, QWORD PTR [r13]
    punpckhwd xmm1, [rax]
    punpckhwd xmm1, [rax+0x7f]
    punpckhwd xmm1, [rax+0x80]
    punpckhwd xmm1, [rax+rbx*4]
    punpckhwd xmm1, [rbx*8+0x10]
    punpckhwd xmm1, [rip+0x100]
    punpckhwd xmm1, [0x1000]
    punpckhwd xmm1, [r13]
    punpckhdq mm0, QWORD PTR [rax]
    punpckhdq mm0, QWORD PTR [rax+0x7f]
    punpckhdq mm0, QWORD PTR [rax+0x80]
    punpckhdq mm0, QWORD PTR [rax+rbx*4]
    punpckhdq mm0, QWORD PTR [rbx*8+0x10]
    punpckhdq mm0, QWORD PTR [rip+0x100]
    punpckhdq mm0, QWORD PTR [0x1000]
    punpckhdq mm0, QWORD PTR [r13]
    punpckhdq xmm1, [rax]
    punpckhdq xmm1, [rax+0x7f]
    punpckhdq xmm1, [rax+0x80]
    punpckhdq xmm1, [rax+rbx*4]
    punpckhdq xmm1, [rbx*8+0x10]
    punpckhdq xmm1, [rip+0x100]
    punpckhdq xmm1, [0x1000]
    punpckhdq xmm1, [r13]
    punpckhqdq xmm1, [rax]
    punpckhqdq xmm1, [rax+0x7f]
    punpckhqdq xmm1, [rax+0x80]
    punpckhqdq xmm1, [rax+rbx*4]
    punpckhqdq xmm1, [rbx*8+0x10]
    punpckhqdq xmm1, [rip+0x100]
    punpckhqdq xmm1, [0x1000]
    punpckhqdq xmm1, [r13]
    vpunpckhbw xmm1, xmm2, [rax]
    vpunpckhbw xmm1, xmm2, [rax+0x7f]
    vpunpckhbw xmm1, xmm2, [rax+0x80]
    vpunpckhbw xmm1, xmm2, [rax+rbx*4]
    vpunpckhbw xmm1, xmm2, [rbx*8+0x10]
    vpunpckhbw xmm1, xmm2, [rip+0x100]
    vpunpckhbw xmm1, xmm2, [0x1000]
    vpunpckhbw xmm1, xmm2, [r13]
    vpunpckhwd xmm1, xmm2, [rax]
    vpunpckhwd xmm1, xmm2, [rax+0x7f]
    vpunpckhwd xmm1, xmm2, [rax+0x80]
    vpunpckhwd xmm1, xmm2, [rax+rbx*4]
    vpunpckhwd xmm1, xmm2, [rbx*8+0x10]
    vpunpckhwd xmm1, xmm2, [rip+0x100]
    vpunpckhwd xmm1, xmm2, [0x1000]
    vpunpckhwd xmm1, xmm2, [r13]
    vpunpckhdq xmm1, xmm2, [rax]
    vpunpckhdq xmm1, xmm2, [rax+0x7f]
    vpunpckhdq xmm1, xmm2, [rax+0x80]
    vpunpckhdq xmm1, xmm2, [rax+rbx*4]
    vpunpckhdq xmm1, xmm2, [rbx*8+0x10]
    vpunpckhdq xmm1, xmm2, [rip+0x100]
    vpunpckhdq xmm1, xmm2, [0x1000]
    vpunpckhdq xmm1, xmm2, [r13]
    vpunpckhqdq xmm1, xmm2, [rax]
    vpunpckhqdq xmm1, xmm2, [rax+0x7f]
    vpunpckhqdq xmm1, xmm2, [rax+0x80]
    vpunpckhqdq xmm1, xmm2, [rax+rbx*4]
    vpunpckhqdq xmm1, xmm2, [rbx*8+0x10]
    vpunpckhqdq xmm1, xmm2, [rip+0x100]
    vpunpckhqdq xmm1, xmm2, [0x1000]
    vpunpckhqdq xmm1, xmm2, [r13]
    vpunpckhbw ymm1, ymm2, [rax]
    vpunpckhbw ymm1, ymm2, [rax+0x7f]
    vpunpckhbw ymm1, ymm2, [rax+0x80]
    vpunpckhbw ymm1, ymm2, [rax+rbx*4]
    vpunpckhbw ymm1, ymm2, [rbx*8+0x10]
    vpunpckhbw ymm1, ymm2, [rip+0x100]
    vpunpckhbw ymm1, ymm2, [0x1000]
    vpunpckhbw ymm1, ymm2, [r13]
    vpunpckhwd ymm1, ymm2, [rax]
    vpunpckhwd ymm1, ymm2, [rax+0x7f]
    vpunpckhwd ymm1, ymm2, [rax+0x80]
    vpunpckhwd ymm1, ymm2, [rax+rbx*4]
    vpunpckhwd ymm1, ymm2, [rbx*8+0x10]
    vpunpckhwd ymm1, ymm2, [rip+0x100]
    vpunpckhwd ymm1, ymm2, [0x1000]
    vpunpckhwd ymm1, ymm2, [r13]
    vpunpckhdq ymm1, ymm2, [rax]
    vpunpckhdq ymm1, ymm2, [rax+0x7f]
    vpunpckhdq ymm1, ymm2, [rax+0x80]
    vpunpckhdq ymm1, ymm2, [rax+rbx*4]
    vpunpckhdq ymm1, ymm2, [rbx*8+0x10]
    vpunpckhdq ymm1, ymm2, [rip+0x100]
    vpunpckhdq ymm1, ymm2, [0x1000]
    vpunpckhdq ymm1, ymm2, [r13]
    vpunpckhqdq ymm1, ymm2, [rax]
    vpunpckhqdq ymm1, ymm2, [rax+0x7f]
    vpunpckhqdq ymm1, ymm2, [rax+0x80]
    vpunpckhqdq ymm1, ymm2, [rax+rbx*4]
    vpunpckhqdq ymm1, ymm2, [rbx*8+0x10]
    vpunpckhqdq ymm1, ymm2, [rip+0x100]
    vpunpckhqdq ymm1, ymm2, [0x1000]
    vpunpckhqdq ymm1, ymm2, [r13]
    punpcklbw mm0, DWORD PTR [rax]
    punpcklbw mm0, DWORD PTR [rax+0x7f]
    punpcklbw mm0, DWORD PTR [rax+0x80]
    punpcklbw mm0, DWORD PTR [rax+rbx*4]
    punpcklbw mm0, DWORD PTR [rbx*8+0x10]
    punpcklbw mm0, DWORD PTR [rip+0x100]
    punpcklbw mm0, DWORD PTR [0x1000]
    punpcklbw mm0, DWORD PTR [r13]
    punpcklbw xmm1, [rax]
    punpcklbw xmm1, [rax+0x7f]
    punpcklbw xmm1, [rax+0x80]
    punpcklbw xmm1, [rax+rbx*4]
    punpcklbw xmm1, [rbx*8+0x10]
    punpcklbw xmm1, [rip+0x100]
    punpcklbw xmm1, [0x1000]
    punpcklbw xmm1, [r13]
    punpcklwd mm0, DWORD PTR [rax]
    punpcklwd mm0, DWORD PTR [rax+0x7f]
    punpcklwd mm0, DWORD PTR [rax+0x80]
    punpcklwd mm0, DWORD PTR [rax+rbx*4]
    punpcklwd mm0, DWORD PTR [rbx*8+0x10]
    punpcklwd mm0, DWORD PTR [rip+0x100]
    punpcklwd mm0, DWORD PTR [0x1000]
    punpcklwd mm0, DWORD PTR [r13]
    punpcklwd xmm1, [rax]
    punpcklwd xmm1, [rax+0x7f]
    punpcklwd xmm1, [rax+0x80]
    punpcklwd xmm1, [rax+rbx*4]
    punpcklwd xmm1, [rbx*8+0x10]
    punpcklwd xmm1, [rip+0x100]
    punpcklwd xmm1, [0x1000]
    punpcklwd xmm1, [r13]
    punpckldq mm0, DWORD PTR [rax]
    punpckldq mm0, DWORD PTR [rax+0x7f]
    punpckldq mm0, DWORD PTR [rax+0x80]
    punpckldq mm0, DWORD PTR [rax+rbx*4]
    punpckldq mm0, DWORD PTR [rbx*8+0x10]
    punpckldq mm0, DWORD PTR [rip+0x100]
    punpckldq mm0, DWORD PTR [0x1000]
    punpckldq mm0, DWORD PTR [r13]
    punpckldq xmm1, [rax]
    punpckldq xmm1, [rax+0x7f]
    punpckldq xmm1, [rax+0x80]
    punpckldq xmm1, [rax+rbx*4]
    punpckldq xmm1, [rbx*8+0x10]
    punpckldq xmm1, [rip+0x100]
    punpckldq xmm1, [0x1000]
    punpckldq xmm1, [r13]
    punpcklqdq xmm1, [rax]
    punpcklqdq xmm1, [rax+0x7f]
    punpcklqdq xmm1, [rax+0x80]
    punpcklqdq xmm1, [rax+rbx*4]
    punpcklqdq xmm1, [rbx*8+0x10]
    punpcklqdq xmm1, [rip+0x100]
    punpcklqdq xmm1, [0x1000]
    punpcklqdq xmm1, [r13]
    vpunpcklbw xmm1, xmm2, [rax]
    vpunpcklbw xmm1, xmm2, [rax+0x7f]
    vpunpcklbw xmm1, xmm2, [rax+0x80]
    vpunpcklbw xmm1, xmm2, [rax+rbx*4]
    vpunpcklbw xmm1, xmm2, [rbx*8+0x10]
    vpunpcklbw xmm1, xmm2, [rip+0x100]
    vpunpcklbw xmm1, xmm2, [0x1000]
    vpunpcklbw xmm1, xmm2, [r13]
    vpunpcklwd xmm1, xmm2, [rax]
    vpunpcklwd xmm1, xmm2, [rax+0x7f]
    vpunpcklwd xmm1, xmm2, [rax+0x80]
    vpunpcklwd xmm1, xmm2, [rax+rbx*4]
    vpunpcklwd xmm1, xmm2, [rbx*8+0x10]
    vpunpcklwd xmm1, xmm2, [rip+0x100]
    vpunpcklwd xmm1, xmm2, [0x1000]
    vpunpcklwd xmm1, xmm2, [r13]
    vpunpckldq xmm1, xmm2, [rax]
    vpunpckldq xmm1, xmm2, [rax+0x7f]
    vpunpckldq xmm1, xmm2, [rax+0x80]
    vpunpckldq xmm1, xmm2, [rax+rbx*4]
    vpunpckldq xmm1, xmm2, [rbx*8+0x10]
    vpunpckldq xmm1, xmm2, [rip+0x100]
    vpunpckldq xmm1, xmm2, [0x1000]
    vpunpckldq xmm1, xmm2, [r13]
    vpunpcklqdq xmm1, xmm2, [rax]
    vpunpcklqdq xmm1, xmm2, [rax+0x7f]
    vpunpcklqdq xmm1, xmm2, [rax+0x80]
    vpunpcklqdq xmm1, xmm2, [rax+rbx*4]
    vpunpcklqdq xmm1, xmm2, [rbx*8+0x10]
    vpunpcklqdq xmm1, xmm2, [rip+0x100]
    vpunpcklqdq xmm1, xmm2, [0x1000]
    vpunpcklqdq xmm1, xmm2, [r13]
    vpunpcklbw ymm1, ymm2, [rax]
    vpunpcklbw ymm1, ymm2, [rax+0x7f]
    vpunpcklbw ymm1, ymm2, [rax+0x80]
    vpunpcklbw ymm1, ymm2, [rax+rbx*4]
    vpunpcklbw ymm1, ymm2, [rbx*8+0x10]
    vpunpcklbw ymm1, ymm2, [rip+0x100]
    vpunpcklbw ymm1, ymm2, [0x1000]
    vpunpcklbw ymm1, ymm2, [r13]
    vpunpcklwd ymm1, ymm2, [rax]
    vpunpcklwd ymm1, ymm2, [rax+0x7f]
    vpunpcklwd ymm1, ymm2, [rax+0x80]
    vpunpcklwd ymm1, ymm2, [rax+rbx*4]
    vpunpcklwd ymm1, ymm2, [rbx*8+0x10]
    vpunpcklwd ymm1, ymm2, [rip+0x100]
    vpunpcklwd ymm1, ymm2, [0x1000]
    vpunpcklwd ymm1, ymm2, [r13]
    vpunpckldq ymm1, ymm2, [rax]
    vpunpckldq ymm1, ymm2, [rax+0x7f]
    vpunpckldq ymm1, ymm2, [rax+0x80]
    vpunpckldq ymm1, ymm2, [rax+rbx*4]
    vpunpckldq ymm1, ymm2, [rbx*8+0x10]
    vpunpckldq ymm1, ymm2, [rip+0x100]
    vpunpckldq ymm1, ymm2, [0x1000]
    vpunpckldq ymm1, ymm2, [r13]
    vpunpcklqdq ymm1, ymm2, [rax]
    vpunpcklqdq ymm1, ymm2, [rax+0x7f]
    vpunpcklqdq ymm1, ymm2, [rax+0x80]
    vpunpcklqdq ymm1, ymm2, [rax+rbx*4]
    vpunpcklqdq ymm1, ymm2, [rbx*8+0x10]
    vpunpcklqdq ymm1, ymm2, [rip+0x100]
    vpunpcklqdq ymm1, ymm2, [0x1000]
    vpunpcklqdq ymm1, ymm2, [r13]
    push WORD PTR [rax]
    push WORD PTR [rax+0x7f]
    push WORD PTR [rax+0x80]
    push WORD PTR [rax+rbx*4]
    push WORD PTR [rbx*8+0x10]
    push WORD PTR [rip+0x100]
    push WORD PTR [0x1000]
    push WORD PTR [r13]
    push DWORD PTR [rax]
    push DWORD PTR [rax+0x7f]
    push DWORD PTR [rax+0x80]
    push DWORD PTR [rax+rbx*4]
    push DWORD PTR [rbx*8+0x10]
    push DWORD PTR [rip+0x100]
    push DWORD PTR [0x1000]
    push DWORD PTR [r13]
    push QWORD PTR [rax]
    push QWORD PTR [rax+0x7f]
    push QWORD PTR [rax+0x80]
    push QWORD PTR [rax+rbx*4]
    push QWORD PTR [rbx*8+0x10]
    push QWORD PTR [rip+0x100]
    push QWORD PTR [0x1000]
    push QWORD PTR [r13]
    pxor mm0, QWORD PTR [rax]
    pxor mm0, QWORD PTR [rax+0x7f]
    pxor mm0, QWORD PTR [rax+0x80]
    pxor mm0, QWORD PTR [rax+rbx*4]
    pxor mm0, QWORD PTR [rbx*8+0x10]
    pxor mm0, QWORD PTR [rip+0x100]
    pxor mm0, QWORD PTR [0x1000]
    pxor mm0, QWORD PTR [r13]
    pxor xmm1, [rax]
    pxor xmm1, [rax+0x7f]
    pxor xmm1, [rax+0x80]
    pxor xmm1, [rax+rbx*4]
    pxor xmm1, [rbx*8+0x10]
    pxor xmm1, [rip+0x100]
    pxor xmm1, [0x1000]
    pxor xmm1, [r13]
    vpxor xmm1, xmm2, [rax]
    vpxor xmm1, xmm2, [rax+0x7f]
    vpxor xmm1, xmm2, [rax+0x80]
    vpxor xmm1, xmm2, [rax+rbx*4]
    vpxor xmm1, xmm2, [rbx*8+0x10]
    vpxor xmm1, xmm2, [rip+0x100]
    vpxor xmm1, xmm2, [0x1000]
    vpxor xmm1, xmm2, [r13]
    vpxor ymm1, ymm2, [rax]
    vpxor ymm1, ymm2, [rax+0x7f]
    vpxor ymm1, ymm2, [rax+0x80]
    vpxor ymm1, ymm2, [rax+rbx*4]
    vpxor ymm1, ymm2, [rbx*8+0x10]
    vpxor ymm1, ymm2, [rip+0x100]
    vpxor ymm1, ymm2, [0x1000]
    vpxor ymm1, ymm2, [r13]
    rcl BYTE PTR [rax], 1
    rcl BYTE PTR [rax+0x7f], 1
    rcl BYTE PTR [rax+0x80], 1
    rcl BYTE PTR [rax+rbx*4], 1
    rcl BYTE PTR [rbx*8+0x10], 1
    rcl BYTE PTR [rip+0x100], 1
    rcl BYTE PTR [0x1000], 1
    rcl BYTE PTR [r13], 1
    rcl BYTE PTR [rax], cl
    rcl BYTE PTR [rax+0x7f], cl
    rcl BYTE PTR [rax+0x80], cl
    rcl BYTE PTR [rax+rbx*4], cl
    rcl BYTE PTR [rbx*8+0x10], cl
    rcl BYTE PTR [rip+0x100], cl
    rcl BYTE PTR [0x1000], cl
    rcl BYTE PTR [r13], cl
    rcl BYTE PTR [rax], 0x1
    rcl BYTE PTR [rax+0x7f], 0x1
    rcl BYTE PTR [rax+0x80], 0x1
    rcl BYTE PTR [rax+rbx*4], 0x1
    rcl BYTE PTR [rbx*8+0x10], 0x1
    rcl BYTE PTR [rip+0x100], 0x1
    rcl BYTE PTR [0x1000], 0x1
    rcl BYTE PTR [r13], 0x1
    rcl WORD PTR [rax], 1
    rcl WORD PTR [rax+0x7f], 1
    rcl WORD PTR [rax+0x80], 1
    rcl WORD PTR [rax+rbx*4], 1
    rcl WORD PTR [rbx*8+0x10], 1
    rcl WORD PTR [rip+0x100], 1
    rcl WORD PTR [0x1000], 1
    rcl WORD PTR [r13], 1
    rcl WORD PTR [rax], cl
    rcl WORD PTR [rax+0x7f], cl
    rcl WORD PTR [rax+0x80], cl
    rcl WORD PTR [rax+rbx*4], cl
    rcl WORD PTR [rbx*8+0x10], cl
    rcl WORD PTR [rip+0x100], cl
    rcl WORD PTR [0x1000], cl
    rcl WORD PTR [r13], cl
    rcl WORD PTR [rax], 0x1
    rcl WORD PTR [rax+0x7f], 0x1
    rcl WORD PTR [rax+0x80], 0x1
    rcl WORD PTR [rax+rbx*4], 0x1
    rcl WORD PTR [rbx*8+0x10], 0x1
    rcl WORD PTR [rip+0x100], 0x1
    rcl WORD PTR [0x1000], 0x1
    rcl WORD PTR [r13], 0x1
    rcl DWORD PTR [rax], 1
    rcl DWORD PTR [rax+0x7f], 1
    rcl DWORD PTR [rax+0x80], 1
    rcl DWORD PTR [rax+rbx*4], 1
    rcl DWORD PTR [rbx*8+0x10], 1
    rcl DWORD PTR [rip+0x100], 1
    rcl DWORD PTR [0x1000], 1
    rcl DWORD PTR [r13], 1
    rcl QWORD PTR [rax], 1
    rcl QWORD PTR [rax+0x7f], 1
    rcl QWORD PTR [rax+0x80], 1
    rcl QWORD PTR [rax+rbx*4], 1
    rcl QWORD PTR [rbx*8+0x10], 1
    rcl QWORD PTR [rip+0x100], 1
    rcl QWORD PTR [0x1000], 1
    rcl QWORD PTR [r13], 1
    rcl DWORD PTR [rax], cl
    rcl DWORD PTR [rax+0x7f], cl
    rcl DWORD PTR [rax+0x80], cl
    rcl DWORD PTR [rax+rbx*4], cl
    rcl DWORD PTR [rbx*8+0x10], cl
    rcl DWORD PTR [rip+0x100], cl
    rcl DWORD PTR [0x1000], cl
    rcl DWORD PTR [r13], cl
    rcl QWORD PTR [rax], cl
    rcl QWORD PTR [rax+0x7f], cl
    rcl QWORD PTR [rax+0x80], cl
    rcl QWORD PTR [rax+rbx*4], cl
    rcl QWORD PTR [rbx*8+0x10], cl
    rcl QWORD PTR [rip+0x100], cl
    rcl QWORD PTR [0x1000], cl
    rcl QWORD PTR [r13], cl
    rcl DWORD PTR [rax], 0x1
    rcl DWORD PTR [rax+0x7f], 0x1
    rcl DWORD PTR [rax+0x80], 0x1
    rcl DWORD PTR [rax+rbx*4], 0x1
    rcl DWORD PTR [rbx*8+0x10], 0x1
    rcl DWORD PTR [rip+0x100], 0x1
    rcl DWORD PTR [0x1000], 0x1
    rcl DWORD PTR [r13], 0x1
    rcl QWORD PTR [rax], 0x1
    rcl QWORD PTR [rax+0x7f], 0x1
    rcl QWORD PTR [rax+0x80], 0x1
    rcl QWORD PTR [rax+rbx*4], 0x1
    rcl QWORD PTR [rbx*8+0x10], 0x1
    rcl QWORD PTR [rip+0x100], 0x1
    rcl QWORD PTR [0x1000], 0x1
    rcl QWORD PTR [r13], 0x1
    rcr BYTE PTR [rax], 1
    rcr BYTE PTR [rax+0x7f], 1
    rcr BYTE PTR [rax+0x80], 1
    rcr BYTE PTR [rax+rbx*4], 1
    rcr BYTE PTR [rbx*8+0x10], 1
    rcr BYTE PTR [rip+0x100], 1
    rcr BYTE PTR [0x1000], 1
    rcr BYTE PTR [r13], 1
    rcr BYTE PTR [rax], cl
    rcr BYTE PTR [rax+0x7f], cl
    rcr BYTE PTR [rax+0x80], cl
    rcr BYTE PTR [rax+rbx*4], cl
    rcr BYTE PTR [rbx*8+0x10], cl
    rcr BYTE PTR [rip+0x100], cl
    rcr BYTE PTR [0x1000], cl
    rcr BYTE PTR [r13], cl
    rcr BYTE PTR [rax], 0x1
    rcr BYTE PTR [rax+0x7f], 0x1
    rcr BYTE PTR [rax+0x80], 0x1
    rcr BYTE PTR [rax+rbx*4], 0x1
    rcr BYTE PTR [rbx*8+0x10], 0x1
    rcr BYTE PTR [rip+0x100], 0x1
    rcr BYTE PTR [0x1000], 0x1
    rcr BYTE PTR [r13], 0x1
    rcr WORD PTR [rax], 1
    rcr WORD PTR [rax+0x7f], 1
    rcr WORD PTR [rax+0x80], 1
    rcr WORD PTR [rax+rbx*4], 1
    rcr WORD PTR [rbx*8+0x10], 1
    rcr WORD PTR [rip+0x100], 1
    rcr WORD PTR [0x1000], 1
    rcr WORD PTR [r13], 1
    rcr WORD PTR [rax], cl
    rcr WORD PTR [rax+0x7f], cl
    rcr WORD PTR [rax+0x80], cl
    rcr WORD PTR [rax+rbx*4], cl
    rcr WORD PTR [rbx*8+0x10], cl
    rcr WORD PTR [rip+0x100], cl
    rcr WORD PTR [0x1000], cl
    rcr WORD PTR [r13], cl
    rcr WORD PTR [rax], 0x1
    rcr WORD PTR [rax+0x7f], 0x1
    rcr WORD PTR [rax+0x80], 0x1
    rcr WORD PTR [rax+rbx*4], 0x1
    rcr WORD PTR [rbx*8+0x10], 0x1
    rcr WORD PTR [rip+0x100], 0x1
    rcr WORD PTR [0x1000], 0x1
    rcr WORD PTR [r13], 0x1
    rcr DWORD PTR [rax], 1
    rcr DWORD PTR [rax+0x7f], 1
    rcr DWORD PTR [rax+0x80], 1
    rcr DWORD PTR [rax+rbx*4], 1
    rcr DWORD PTR [rbx*8+0x10], 1
    rcr DWORD PTR [rip+0x100], 1
    rcr DWORD PTR [0x1000], 1
    rcr DWORD PTR [r13], 1
    rcr QWORD PTR [rax], 1
    rcr QWORD PTR [rax+0x7f], 1
    rcr QWORD PTR [rax+0x80], 1
    rcr QWORD PTR [rax+rbx*4], 1
    rcr QWORD PTR [rbx*8+0x10], 1
    rcr QWORD PTR [rip+0x100], 1
    rcr QWORD PTR [0x1000], 1
    rcr QWORD PTR [r13], 1
    rcr DWORD PTR [rax], cl
    rcr DWORD PTR [rax+0x7f], cl
    rcr DWORD PTR [rax+0x80], cl
    rcr DWORD PTR [rax+rbx*4], cl
    rcr DWORD PTR [rbx*8+0x10], cl
    rcr DWORD PTR [rip+0x100], cl
    rcr DWORD PTR [0x1000], cl
    rcr DWORD PTR [r13], cl
    rcr QWORD PTR [rax], cl
    rcr QWORD PTR [rax+0x7f], cl
    rcr QWORD PTR [rax+0x80], cl
    rcr QWORD PTR [rax+rbx*4], cl
    rcr QWORD PTR [rbx*8+0x10], cl
    rcr QWORD PTR [rip+0x100], cl
    rcr QWORD PTR [0x1000], cl
    rcr QWORD PTR [r13], cl
    rcr DWORD PTR [rax], 0x1
    rcr DWORD PTR [rax+0x7f], 0x1
    rcr DWORD PTR [rax+0x80], 0x1
    rcr DWORD PTR [rax+rbx*4], 0x1
    rcr DWORD PTR [rbx*8+0x10], 0x1
    rcr DWORD PTR [rip+0x100], 0x1
    rcr DWORD PTR [0x1000], 0x1
    rcr DWORD PTR [r13], 0x1
    rcr QWORD PTR [rax], 0x1
    rcr QWORD PTR [rax+0x7f], 0x1
    rcr QWORD PTR [rax+0x80], 0x1
    rcr QWORD PTR [rax+rbx*4], 0x1
    rcr QWORD PTR [rbx*8+0x10], 0x1
    rcr QWORD PTR [rip+0x100], 0x1
    rcr QWORD PTR [0x1000], 0x1
    rcr QWORD PTR [r13], 0x1
    rol BYTE PTR [rax], cl
    rol BYTE PTR [rax+0x7f], cl
    rol BYTE PTR [rax+0x80], cl
    rol BYTE PTR [rax+rbx*4], cl
    rol BYTE PTR [rbx*8+0x10], cl
    rol BYTE PTR [rip+0x100], cl
    rol BYTE PTR [0x1000], cl
    rol BYTE PTR [r13], cl
    rol BYTE PTR [rax], 0x1
    rol BYTE PTR [rax+0x7f], 0x1
    rol BYTE PTR [rax+0x80], 0x1
    rol BYTE PTR [rax+rbx*4], 0x1
    rol BYTE PTR [rbx*8+0x10], 0x1
    rol BYTE PTR [rip+0x100], 0x1
    rol BYTE PTR [0x1000], 0x1
    rol BYTE PTR [r13], 0x1
    rol WORD PTR [rax], 1
    rol WORD PTR [rax+0x7f], 1
    rol WORD PTR [rax+0x80], 1
    rol WORD PTR [rax+rbx*4], 1
    rol WORD PTR [rbx*8+0x10], 1
    rol WORD PTR [rip+0x100], 1
    rol WORD PTR [0x1000], 1
    rol WORD PTR [r13], 1
    rol WORD PTR [rax], cl
    rol WORD PTR [rax+0x7f], cl
    rol WORD PTR [rax+0x80], cl
    rol WORD PTR [rax+rbx*4], cl
    rol WORD PTR [rbx*8+0x10], cl
    rol WORD PTR [rip+0x100], cl
    rol WORD PTR [0x1000], cl
    rol WORD PTR [r13], cl
    rol WORD PTR [rax], 0x1
    rol WORD PTR [rax+0x7f], 0x1
    rol WORD PTR [rax+0x80], 0x1
    rol WORD PTR [rax+rbx*4], 0x1
    rol WORD PTR [rbx*8+0x10], 0x1
    rol WORD PTR [rip+0x100], 0x1
    rol WORD PTR [0x1000], 0x1
    rol WORD PTR [r13], 0x1
    rol DWORD PTR [rax], 1
    rol DWORD PTR [rax+0x7f], 1
    rol DWORD PTR [rax+0x80], 1
    rol DWORD PTR [rax+rbx*4], 1
    rol DWORD PTR [rbx*8+0x10], 1
    rol DWORD PTR [rip+0x100], 1
    rol DWORD PTR [0x1000], 1
    rol DWORD PTR [r13], 1
    rol QWORD PTR [rax], 1
    rol QWORD PTR [rax+0x7f], 1
    rol QWORD PTR [rax+0x80], 1
    rol QWORD PTR [rax+rbx*4], 1
    rol QWORD PTR [rbx*8+0x10], 1
    rol QWORD PTR [rip+0x100], 1
    rol QWORD PTR [0x1000], 1
    rol QWORD PTR [r13], 1
    rol DWORD PTR [rax], cl
    rol DWORD PTR [rax+0x7f], cl
    rol DWORD PTR [rax+0x80], cl
    rol DWORD PTR [rax+rbx*4], cl
    rol DWORD PTR [rbx*8+0x10], cl
    rol DWORD PTR [rip+0x100], cl
    rol DWORD PTR [0x1000], cl
    rol DWORD PTR [r13], cl
    rol QWORD PTR [rax], cl
    rol QWORD PTR [rax+0x7f], cl
    rol QWORD PTR [rax+0x80], cl
    rol QWORD PTR [rax+rbx*4], cl
    rol QWORD PTR [rbx*8+0x10], cl
    rol QWORD PTR [rip+0x100], cl
    rol QWORD PTR [0x1000], cl
    rol QWORD PTR [r13], cl
    rol DWORD PTR [rax], 0x1
    rol DWORD PTR [rax+0x7f], 0x1
    rol DWORD PTR [rax+0x80], 0x1
    rol DWORD PTR [rax+rbx*4], 0x1
    rol DWORD PTR [rbx*8+0x10], 0x1
    rol DWORD PTR [rip+0x100], 0x1
    rol DWORD PTR [0x1000], 0x1
    rol DWORD PTR [r13], 0x1
    rol QWORD PTR [rax], 0x1
    rol QWORD PTR [rax+0x7f], 0x1
    rol QWORD PTR [rax+0x80], 0x1
    rol QWORD PTR [rax+rbx*4], 0x1
    rol QWORD PTR [rbx*8+0x10], 0x1
    rol QWORD PTR [rip+0x100], 0x1
    rol QWORD PTR [0x1000], 0x1
    rol QWORD PTR [r13], 0x1
    ror BYTE PTR [rax], 1
    ror BYTE PTR [rax+0x7f], 1
    ror BYTE PTR [rax+0x80], 1
    ror BYTE PTR [rax+rbx*4], 1
    ror BYTE PTR [rbx*8+0x10], 1
    ror BYTE PTR [rip+0x100], 1
    ror BYTE PTR [0x1000], 1
    ror BYTE PTR [r13], 1
    ror BYTE PTR [rax], cl
    ror BYTE PTR [rax+0x7f], cl
    ror BYTE PTR [rax+0x80], cl
    ror BYTE PTR [rax+rbx*4], cl
    ror BYTE PTR [rbx*8+0x10], cl
    ror BYTE PTR [rip+0x100], cl
    ror BYTE PTR [0x1000], cl
    ror BYTE PTR [r13], cl
    ror BYTE PTR [rax], 0x1
    ror BYTE PTR [rax+0x7f], 0x1
    ror BYTE PTR [rax+0x80], 0x1
    ror BYTE PTR [rax+rbx*4], 0x1
    ror BYTE PTR [rbx*8+0x10], 0x1
    ror BYTE PTR [rip+0x100], 0x1
    ror BYTE PTR [0x1000], 0x1
    ror BYTE PTR [r13], 0x1
    ror WORD PTR [rax], 1
    ror WORD PTR [rax+0x7f], 1
    ror WORD PTR [rax+0x80], 1
    ror WORD PTR [rax+rbx*4], 1
    ror WORD PTR [rbx*8+0x10], 1
    ror WORD PTR [rip+0x100], 1
    ror WORD PTR [0x1000], 1
    ror WORD PTR [r13], 1
    ror WORD PTR [rax], cl
    ror WORD PTR [rax+0x7f], cl
    ror WORD PTR [rax+0x80], cl
    ror WORD PTR [rax+rbx*4], cl
    ror WORD PTR [rbx*8+0x10], cl
    ror WORD PTR [rip+0x100], cl
    ror WORD PTR [0x1000], cl
    ror WORD PTR [r13], cl
    ror WORD PTR [rax], 0x1
    ror WORD PTR [rax+0x7f], 0x1
    ror WORD PTR [rax+0x80], 0x1
    ror WORD PTR [rax+rbx*4], 0x1
    ror WORD PTR [rbx*8+0x10], 0x1
    ror WORD PTR [rip+0x100], 0x1
    ror WORD PTR [0x1000], 0x1
    ror WORD PTR [r13], 0x1
    ror DWORD PTR [rax], 1
    ror DWORD PTR [rax+0x7f], 1
    ror DWORD PTR [rax+0x80], 1
    ror DWORD PTR [rax+rbx*4], 1
    ror DWORD PTR [rbx*8+0x10], 1
    ror DWORD PTR [rip+0x100], 1
    ror DWORD PTR [0x1000], 1
    ror DWORD PTR [r13], 1
    ror QWORD PTR [rax], 1
    ror QWORD PTR [rax+0x7f], 1
    ror QWORD PTR [rax+0x80], 1
    ror QWORD PTR [rax+rbx*4], 1
    ror QWORD PTR [rbx*8+0x10], 1
    ror QWORD PTR [rip+0x100], 1
    ror QWORD PTR [0x1000], 1
    ror QWORD PTR [r13], 1
    ror DWORD PTR [rax], cl
    ror DWORD PTR [rax+0x7f], cl
    ror DWORD PTR [rax+0x80], cl
    ror DWORD PTR [rax+rbx*4], cl
    ror DWORD PTR [rbx*8+0x10], cl
    ror DWORD PTR [rip+0x100], cl
    ror DWORD PTR [0x1000], cl
    ror DWORD PTR [r13], cl
    ror QWORD PTR [rax], cl
    ror QWORD PTR [rax+0x7f], cl
    ror QWORD PTR [rax+0x80], cl
    ror QWORD PTR [rax+rbx*4], cl
    ror QWORD PTR [rbx*8+0x10], cl
    ror QWORD PTR [rip+0x100], cl
    ror QWORD PTR [0x1000], cl
    ror QWORD PTR [r13], cl
    ror DWORD PTR [rax], 0x1
    ror DWORD PTR [rax+0x7f], 0x1
    ror DWORD PTR [rax+0x80], 0x1
    ror DWORD PTR [rax+rbx*4], 0x1
    ror DWORD PTR [rbx*8+0x10], 0x1
    ror DWORD PTR [rip+0x100], 0x1
    ror DWORD PTR [0x1000], 0x1
    ror DWORD PTR [r13], 0x1
    ror QWORD PTR [rax], 0x1
    ror QWORD PTR [rax+0x7f], 0x1
    ror QWORD PTR [rax+0x80], 0x1
    ror QWORD PTR [rax+rbx*4], 0x1
    ror QWORD PTR [rbx*8+0x10], 0x1
    ror QWORD PTR [rip+0x100], 0x1
    ror QWORD PTR [0x1000], 0x1
    ror QWORD PTR [r13], 0x1
    rcpps xmm1, [rax]
    rcpps xmm1, [rax+0x7f]
    rcpps xmm1, [rax+0x80]
    rcpps xmm1, [rax+rbx*4]
    rcpps xmm1, [rbx*8+0x10]
    rcpps xmm1, [rip+0x100]
    rcpps xmm1, [0x1000]
    rcpps xmm1, [r13]
    vrcpps xmm1, [rax]
    vrcpps xmm1, [rax+0x7f]
    vrcpps xmm1, [rax+0x80]
    vrcpps xmm1, [rax+rbx*4]
    vrcpps xmm1, [rbx*8+0x10]
    vrcpps xmm1, [rip+0x100]
    vrcpps xmm1, [0x1000]
    vrcpps xmm1, [r13]
    vrcpps ymm1, [rax]
    vrcpps ymm1, [rax+0x7f]
    vrcpps ymm1, [rax+0x80]
    vrcpps ymm1, [rax+rbx*4]
    vrcpps ymm1, [rbx*8+0x10]
    vrcpps ymm1, [rip+0x100]
    vrcpps ymm1, [0x1000]
    vrcpps ymm1, [r13]
    rcpss xmm1, DWORD PTR [rax]
    rcpss xmm1, DWORD PTR [rax+0x7f]
    rcpss xmm1, DWORD PTR [rax+0x80]
    rcpss xmm1, DWORD PTR [rax+rbx*4]
    rcpss xmm1, DWORD PTR [rbx*8+0x10]
    rcpss xmm1, DWORD PTR [rip+0x100]
    rcpss xmm1, DWORD PTR [0x1000]
    rcpss xmm1, DWORD PTR [r13]
    vrcpss xmm1, xmm2, DWORD PTR [rax]
    vrcpss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vrcpss xmm1, xmm2, DWORD PTR [rax+0x80]
    vrcpss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vrcpss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vrcpss xmm1, xmm2, DWORD PTR [rip+0x100]
    vrcpss xmm1, xmm2, DWORD PTR [0x1000]
    vrcpss xmm1, xmm2, DWORD PTR [r13]
    rorx eax, DWORD PTR [rax], 0x1
    rorx eax, DWORD PTR [rax+0x7f], 0x1
    rorx eax, DWORD PTR [rax+0x80], 0x1
    rorx eax, DWORD PTR [rax+rbx*4], 0x1
    rorx eax, DWORD PTR [rbx*8+0x10], 0x1
    rorx eax, DWORD PTR [rip+0x100], 0x1
    rorx eax, DWORD PTR [0x1000], 0x1
    rorx eax, DWORD PTR [r13], 0x1
    rorx rax, QWORD PTR [rax], 0x1
    rorx rax, QWORD PTR [rax+0x7f], 0x1
    rorx rax, QWORD PTR [rax+0x80], 0x1
    rorx rax, QWORD PTR [rax+rbx*4], 0x1
    rorx rax, QWORD PTR [rbx*8+0x10], 0x1
    rorx rax, QWORD PTR [rip+0x100], 0x1
    rorx rax, QWORD PTR [0x1000], 0x1
    rorx rax, QWORD PTR [r13], 0x1
    roundpd xmm1, [rax], 0x1
    roundpd xmm1, [rax+0x7f], 0x1
    roundpd xmm1, [rax+0x80], 0x1
    roundpd xmm1, [rax+rbx*4], 0x1
    roundpd xmm1, [rbx*8+0x10], 0x1
    roundpd xmm1, [rip+0x100], 0x1
    roundpd xmm1, [0x1000], 0x1
    roundpd xmm1, [r13], 0x1
    vroundpd xmm1, [rax], 0x1
    vroundpd xmm1, [rax+0x7f], 0x1
    vroundpd xmm1, [rax+0x80], 0x1
    vroundpd xmm1, [rax+rbx*4], 0x1
    vroundpd xmm1, [rbx*8+0x10], 0x1
    vroundpd xmm1, [rip+0x100], 0x1
    vroundpd xmm1, [0x1000], 0x1
    vroundpd xmm1, [r13], 0x1
    vroundpd ymm1, [rax], 0x1
    vroundpd ymm1, [rax+0x7f], 0x1
    vroundpd ymm1, [rax+0x80], 0x1
    vroundpd ymm1, [rax+rbx*4], 0x1
    vroundpd ymm1, [rbx*8+0x10], 0x1
    vroundpd ymm1, [rip+0x100], 0x1
    vroundpd ymm1, [0x1000], 0x1
    vroundpd ymm1, [r13], 0x1
    roundps xmm1, [rax], 0x1
    roundps xmm1, [rax+0x7f], 0x1
    roundps xmm1, [rax+0x80], 0x1
    roundps xmm1, [rax+rbx*4], 0x1
    roundps xmm1, [rbx*8+0x10], 0x1
    roundps xmm1, [rip+0x100], 0x1
    roundps xmm1, [0x1000], 0x1
    roundps xmm1, [r13], 0x1
    vroundps xmm1, [rax], 0x1
    vroundps xmm1, [rax+0x7f], 0x1
    vroundps xmm1, [rax+0x80], 0x1
    vroundps xmm1, [rax+rbx*4], 0x1
    vroundps xmm1, [rbx*8+0x10], 0x1
    vroundps xmm1, [rip+0x100], 0x1
    vroundps xmm1, [0x1000], 0x1
    vroundps xmm1, [r13], 0x1
    vroundps ymm1, [rax], 0x1
    vroundps ymm1, [rax+0x7f], 0x1
    vroundps ymm1, [rax+0x80], 0x1
    vroundps ymm1, [rax+rbx*4], 0x1
    vroundps ymm1, [rbx*8+0x10], 0x1
    vroundps ymm1, [rip+0x100], 0x1
    vroundps ymm1, [0x1000], 0x1
    vroundps ymm1, [r13], 0x1
    roundsd xmm1, QWORD PTR [rax], 0x1
    roundsd xmm1, QWORD PTR [rax+0x7f], 0x1
    roundsd xmm1, QWORD PTR [rax+0x80], 0x1
    roundsd xmm1, QWORD PTR [rax+rbx*4], 0x1
    roundsd xmm1, QWORD PTR [rbx*8+0x10], 0x1
    roundsd xmm1, QWORD PTR [rip+0x100], 0x1
    roundsd xmm1, QWORD PTR [0x1000], 0x1
    roundsd xmm1, QWORD PTR [r13], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [rax], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [rax+0x7f], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [rax+0x80], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [rax+rbx*4], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [rbx*8+0x10], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [rip+0x100], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [0x1000], 0x1
    vroundsd xmm1, xmm2, QWORD PTR [r13], 0x1
    roundss xmm1, DWORD PTR [rax], 0x1
    roundss xmm1, DWORD PTR [rax+0x7f], 0x1
    roundss xmm1, DWORD PTR [rax+0x80], 0x1
    roundss xmm1, DWORD PTR [rax+rbx*4], 0x1
    roundss xmm1, DWORD PTR [rbx*8+0x10], 0x1
    roundss xmm1, DWORD PTR [rip+0x100], 0x1
    roundss xmm1, DWORD PTR [0x1000], 0x1
    roundss xmm1, DWORD PTR [r13], 0x1
    vroundss xmm1, xmm2, DWORD PTR [rax], 0x1
    vroundss xmm1, xmm2, DWORD PTR [rax+0x7f], 0x1
    vroundss xmm1, xmm2, DWORD PTR [rax+0x80], 0x1
    vroundss xmm1, xmm2, DWORD PTR [rax+rbx*4], 0x1
    vroundss xmm1, xmm2, DWORD PTR [rbx*8+0x10], 0x1
    vroundss xmm1, xmm2, DWORD PTR [rip+0x100], 0x1
    vroundss xmm1, xmm2, DWORD PTR [0x1000], 0x1
    vroundss xmm1, xmm2, DWORD PTR [r13], 0x1
    rsqrtps xmm1, [rax]
    rsqrtps xmm1, [rax+0x7f]
    rsqrtps xmm1, [rax+0x80]
    rsqrtps xmm1, [rax+rbx*4]
    rsqrtps xmm1, [rbx*8+0x10]
    rsqrtps xmm1, [rip+0x100]
    rsqrtps xmm1, [0x1000]
    rsqrtps xmm1, [r13]
    vrsqrtps xmm1, [rax]
    vrsqrtps xmm1, [rax+0x7f]
    vrsqrtps xmm1, [rax+0x80]
    vrsqrtps xmm1, [rax+rbx*4]
    vrsqrtps xmm1, [rbx*8+0x10]
    vrsqrtps xmm1, [rip+0x100]
    vrsqrtps xmm1, [0x1000]
    vrsqrtps xmm1, [r13]
    vrsqrtps ymm1, [rax]
    vrsqrtps ymm1, [rax+0x7f]
    vrsqrtps ymm1, [rax+0x80]
    vrsqrtps ymm1, [rax+rbx*4]
    vrsqrtps ymm1, [rbx*8+0x10]
    vrsqrtps ymm1, [rip+0x100]
    vrsqrtps ymm1, [0x1000]
    vrsqrtps ymm1, [r13]
    rsqrtss xmm1, DWORD PTR [rax]
    rsqrtss xmm1, DWORD PTR [rax+0x7f]
    rsqrtss xmm1, DWORD PTR [rax+0x80]
    rsqrtss xmm1, DWORD PTR [rax+rbx*4]
    rsqrtss xmm1, DWORD PTR [rbx*8+0x10]
    rsqrtss xmm1, DWORD PTR [rip+0x100]
    rsqrtss xmm1, DWORD PTR [0x1000]
    rsqrtss xmm1, DWORD PTR [r13]
    vrsqrtss xmm1, xmm2, DWORD PTR [rax]
    vrsqrtss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vrsqrtss xmm1, xmm2, DWORD PTR [rax+0x80]
    vrsqrtss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vrsqrtss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vrsqrtss xmm1, xmm2, DWORD PTR [rip+0x100]
    vrsqrtss xmm1, xmm2, DWORD PTR [0x1000]
    vrsqrtss xmm1, xmm2, DWORD PTR [r13]
    rstorssp QWORD PTR [rax]
    rstorssp QWORD PTR [rax+0x7f]
    rstorssp QWORD PTR [rax+0x80]
    rstorssp QWORD PTR [rax+rbx*4]
    rstorssp QWORD PTR [rbx*8+0x10]
    rstorssp QWORD PTR [rip+0x100]
    rstorssp QWORD PTR [0x1000]
    rstorssp QWORD PTR [r13]
    sal BYTE PTR [rax], 1
    sal BYTE PTR [rax+0x7f], 1
    sal BYTE PTR [rax+0x80], 1
    sal BYTE PTR [rax+rbx*4], 1
    sal BYTE PTR [rbx*8+0x10], 1
    sal BYTE PTR [rip+0x100], 1
    sal BYTE PTR [0x1000], 1
    sal BYTE PTR [r13], 1
    sal BYTE PTR [rax], cl
    sal BYTE PTR [rax+0x7f], cl
    sal BYTE PTR [rax+0x80], cl
    sal BYTE PTR [rax+rbx*4], cl
    sal BYTE PTR [rbx*8+0x10], cl
    sal BYTE PTR [rip+0x100], cl
    sal BYTE PTR [0x1000], cl
    sal BYTE PTR [r13], cl
    sal BYTE PTR [rax], 0x1
    sal BYTE PTR [rax+0x7f], 0x1
    sal BYTE PTR [rax+0x80], 0x1
    sal BYTE PTR [rax+rbx*4], 0x1
    sal BYTE PTR [rbx*8+0x10], 0x1
    sal BYTE PTR [rip+0x100], 0x1
    sal BYTE PTR [0x1000], 0x1
    sal BYTE PTR [r13], 0x1
    sal WORD PTR [rax], 1
    sal WORD PTR [rax+0x7f], 1
    sal WORD PTR [rax+0x80], 1
    sal WORD PTR [rax+rbx*4], 1
    sal WORD PTR [rbx*8+0x10], 1
    sal WORD PTR [rip+0x100], 1
    sal WORD PTR [0x1000], 1
    sal WORD PTR [r13], 1
    sal WORD PTR [rax], cl
    sal WORD PTR [rax+0x7f], cl
    sal WORD PTR [rax+0x80], cl
    sal WORD PTR [rax+rbx*4], cl
    sal WORD PTR [rbx*8+0x10], cl
    sal WORD PTR [rip+0x100], cl
    sal WORD PTR [0x1000], cl
    sal WORD PTR [r13], cl
    sal WORD PTR [rax], 0x1
    sal WORD PTR [rax+0x7f], 0x1
    sal WORD PTR [rax+0x80], 0x1
    sal WORD PTR [rax+rbx*4], 0x1
    sal WORD PTR [rbx*8+0x10], 0x1
    sal WORD PTR [rip+0x100], 0x1
    sal WORD PTR [0x1000], 0x1
    sal WORD PTR [r13], 0x1
    sal DWORD PTR [rax], 1
    sal DWORD PTR [rax+0x7f], 1
    sal DWORD PTR [rax+0x80], 1
    sal DWORD PTR [rax+rbx*4], 1
    sal DWORD PTR [rbx*8+0x10], 1
    sal DWORD PTR [rip+0x100], 1
    sal DWORD PTR [0x1000], 1
    sal DWORD PTR [r13], 1
    sal QWORD PTR [rax], 1
    sal QWORD PTR [rax+0x7f], 1
    sal QWORD PTR [rax+0x80], 1
    sal QWORD PTR [rax+rbx*4], 1
    sal QWORD PTR [rbx*8+0x10], 1
    sal QWORD PTR [rip+0x100], 1
    sal QWORD PTR [0x1000], 1
    sal QWORD PTR [r13], 1
    sal DWORD PTR [rax], cl
    sal DWORD PTR [rax+0x7f], cl
    sal DWORD PTR [rax+0x80], cl
    sal DWORD PTR [rax+rbx*4], cl
    sal DWORD PTR [rbx*8+0x10], cl
    sal DWORD PTR [rip+0x100], cl
    sal DWORD PTR [0x1000], cl
    sal DWORD PTR [r13], cl
    sal QWORD PTR [rax], cl
    sal QWORD PTR [rax+0x7f], cl
    sal QWORD PTR [rax+0x80], cl
    sal QWORD PTR [rax+rbx*4], cl
    sal QWORD PTR [rbx*8+0x10], cl
    sal QWORD PTR [rip+0x100], cl
    sal QWORD PTR [0x1000], cl
    sal QWORD PTR [r13], cl
    sal DWORD PTR [rax], 0x1
    sal DWORD PTR [rax+0x7f], 0x1
    sal DWORD PTR [rax+0x80], 0x1
    sal DWORD PTR [rax+rbx*4], 0x1
    sal DWORD PTR [rbx*8+0x10], 0x1
    sal DWORD PTR [rip+0x100], 0x1
    sal DWORD PTR [0x1000], 0x1
    sal DWORD PTR [r13], 0x1
    sal QWORD PTR [rax], 0x1
    sal QWORD PTR [rax+0x7f], 0x1
    sal QWORD PTR [rax+0x80], 0x1
    sal QWORD PTR [rax+rbx*4], 0x1
    sal QWORD PTR [rbx*8+0x10], 0x1
    sal QWORD PTR [rip+0x100], 0x1
    sal QWORD PTR [0x1000], 0x1
    sal QWORD PTR [r13], 0x1
    sar BYTE PTR [rax], 1
    sar BYTE PTR [rax+0x7f], 1
    sar BYTE PTR [rax+0x80], 1
    sar BYTE PTR [rax+rbx*4], 1
    sar BYTE PTR [rbx*8+0x10], 1
    sar BYTE PTR [rip+0x100], 1
    sar BYTE PTR [0x1000], 1
    sar BYTE PTR [r13], 1
    sar BYTE PTR [rax], cl
    sar BYTE PTR [rax+0x7f], cl
    sar BYTE PTR [rax+0x80], cl
    sar BYTE PTR [rax+rbx*4], cl
    sar BYTE PTR [rbx*8+0x10], cl
    sar BYTE PTR [rip+0x100], cl
    sar BYTE PTR [0x1000], cl
    sar BYTE PTR [r13], cl
    sar BYTE PTR [rax], 0x1
    sar BYTE PTR [rax+0x7f], 0x1
    sar BYTE PTR [rax+0x80], 0x1
    sar BYTE PTR [rax+rbx*4], 0x1
    sar BYTE PTR [rbx*8+0x10], 0x1
    sar BYTE PTR [rip+0x100], 0x1
    sar BYTE PTR [0x1000], 0x1
    sar BYTE PTR [r13], 0x1
    sar WORD PTR [rax], 1
    sar WORD PTR [rax+0x7f], 1
    sar WORD PTR [rax+0x80], 1
    sar WORD PTR [rax+rbx*4], 1
    sar WORD PTR [rbx*8+0x10], 1
    sar WORD PTR [rip+0x100], 1
    sar WORD PTR [0x1000], 1
    sar WORD PTR [r13], 1
    sar WORD PTR [rax], cl
    sar WORD PTR [rax+0x7f], cl
    sar WORD PTR [rax+0x80], cl
    sar WORD PTR [rax+rbx*4], cl
    sar WORD PTR [rbx*8+0x10], cl
    sar WORD PTR [rip+0x100], cl
    sar WORD PTR [0x1000], cl
    sar WORD PTR [r13], cl
    sar WORD PTR [rax], 0x1
    sar WORD PTR [rax+0x7f], 0x1
    sar WORD PTR [rax+0x80], 0x1
    sar WORD PTR [rax+rbx*4], 0x1
    sar WORD PTR [rbx*8+0x10], 0x1
    sar WORD PTR [rip+0x100], 0x1
    sar WORD PTR [0x1000], 0x1
    sar WORD PTR [r13], 0x1
    sar DWORD PTR [rax], 1
    sar DWORD PTR [rax+0x7f], 1
    sar DWORD PTR [rax+0x80], 1
    sar DWORD PTR [rax+rbx*4], 1
    sar DWORD PTR [rbx*8+0x10], 1
    sar DWORD PTR [rip+0x100], 1
    sar DWORD PTR [0x1000], 1
    sar DWORD PTR [r13], 1
    sar QWORD PTR [rax], 1
    sar QWORD PTR [rax+0x7f], 1
    sar QWORD PTR [rax+0x80], 1
    sar QWORD PTR [rax+rbx*4], 1
    sar QWORD PTR [rbx*8+0x10], 1
    sar QWORD PTR [rip+0x100], 1
    sar QWORD PTR [0x1000], 1
    sar QWORD PTR [r13], 1
    sar DWORD PTR [rax], cl
    sar DWORD PTR [rax+0x7f], cl
    sar DWORD PTR [rax+0x80], cl
    sar DWORD PTR [rax+rbx*4], cl
    sar DWORD PTR [rbx*8+0x10], cl
    sar DWORD PTR [rip+0x100], cl
    sar DWORD PTR [0x1000], cl
    sar DWORD PTR [r13], cl
    sar QWORD PTR [rax], cl
    sar QWORD PTR [rax+0x7f], cl
    sar QWORD PTR [rax+0x80], cl
    sar QWORD PTR [rax+rbx*4], cl
    sar QWORD PTR [rbx*8+0x10], cl
    sar QWORD PTR [rip+0x100], cl
    sar QWORD PTR [0x1000], cl
    sar QWORD PTR [r13], cl
    sar DWORD PTR [rax], 0x1
    sar DWORD PTR [rax+0x7f], 0x1
    sar DWORD PTR [rax+0x80], 0x1
    sar DWORD PTR [rax+rbx*4], 0x1
    sar DWORD PTR [rbx*8+0x10], 0x1
    sar DWORD PTR [rip+0x100], 0x1
    sar DWORD PTR [0x1000], 0x1
    sar DWORD PTR [r13], 0x1
    sar QWORD PTR [rax], 0x1
    sar QWORD PTR [rax+0x7f], 0x1
    sar QWORD PTR [rax+0x80], 0x1
    sar QWORD PTR [rax+rbx*4], 0x1
    sar QWORD PTR [rbx*8+0x10], 0x1
    sar QWORD PTR [rip+0x100], 0x1
    sar QWORD PTR [0x1000], 0x1
    sar QWORD PTR [r13], 0x1
    shl BYTE PTR [rax], 1
    shl BYTE PTR [rax+0x7f], 1
    shl BYTE PTR [rax+0x80], 1
    shl BYTE PTR [rax+rbx*4], 1
    shl BYTE PTR [rbx*8+0x10], 1
    shl BYTE PTR [rip+0x100], 1
    shl BYTE PTR [0x1000], 1
    shl BYTE PTR [r13], 1
    shl BYTE PTR [rax], cl
    shl BYTE PTR [rax+0x7f], cl
    shl BYTE PTR [rax+0x80], cl
    shl BYTE PTR [rax+rbx*4], cl
    shl BYTE PTR [rbx*8+0x10], cl
    shl BYTE PTR [rip+0x100], cl
    shl BYTE PTR [0x1000], cl
    shl BYTE PTR [r13], cl
    shl BYTE PTR [rax], 0x1
    shl BYTE PTR [rax+0x7f], 0x1
    shl BYTE PTR [rax+0x80], 0x1
    shl BYTE PTR [rax+rbx*4], 0x1
    shl BYTE PTR [rbx*8+0x10], 0x1
    shl BYTE PTR [rip+0x100], 0x1
    shl BYTE PTR [0x1000], 0x1
    shl BYTE PTR [r13], 0x1
    shl WORD PTR [rax], 1
    shl WORD PTR [rax+0x7f], 1
    shl WORD PTR [rax+0x80], 1
    shl WORD PTR [rax+rbx*4], 1
    shl WORD PTR [rbx*8+0x10], 1
    shl WORD PTR [rip+0x100], 1
    shl WORD PTR [0x1000], 1
    shl WORD PTR [r13], 1
    shl WORD PTR [rax], cl
    shl WORD PTR [rax+0x7f], cl
    shl WORD PTR [rax+0x80], cl
    shl WORD PTR [rax+rbx*4], cl
    shl WORD PTR [rbx*8+0x10], cl
    shl WORD PTR [rip+0x100], cl
    shl WORD PTR [0x1000], cl
    shl WORD PTR [r13], cl
    shl WORD PTR [rax], 0x1
    shl WORD PTR [rax+0x7f], 0x1
    shl WORD PTR [rax+0x80], 0x1
    shl WORD PTR [rax+rbx*4], 0x1
    shl WORD PTR [rbx*8+0x10], 0x1
    shl WORD PTR [rip+0x100], 0x1
    shl WORD PTR [0x1000], 0x1
    shl WORD PTR [r13], 0x1
    shl DWORD PTR [rax], 1
    shl DWORD PTR [rax+0x7f], 1
    shl DWORD PTR [rax+0x80], 1
    shl DWORD PTR [rax+rbx*4], 1
    shl DWORD PTR [rbx*8+0x10], 1
    shl DWORD PTR [rip+0x100], 1
    shl DWORD PTR [0x1000], 1
    shl DWORD PTR [r13], 1
    shl QWORD PTR [rax], 1
    shl QWORD PTR [rax+0x7f], 1
    shl QWORD PTR [rax+0x80], 1
    shl QWORD PTR [rax+rbx*4], 1
    shl QWORD PTR [rbx*8+0x10], 1
    shl QWORD PTR [rip+0x100], 1
    shl QWORD PTR [0x1000], 1
    shl QWORD PTR [r13], 1
    shl DWORD PTR [rax], cl
    shl DWORD PTR [rax+0x7f], cl
    shl DWORD PTR [rax+0x80], cl
    shl DWORD PTR [rax+rbx*4], cl
    shl DWORD PTR [rbx*8+0x10], cl
    shl DWORD PTR [rip+0x100], cl
    shl DWORD PTR [0x1000], cl
    shl DWORD PTR [r13], cl
    shl QWORD PTR [rax], cl
    shl QWORD PTR [rax+0x7f], cl
    shl QWORD PTR [rax+0x80], cl
    shl QWORD PTR [rax+rbx*4], cl
    shl QWORD PTR [rbx*8+0x10], cl
    shl QWORD PTR [rip+0x100], cl
    shl QWORD PTR [0x1000], cl
    shl QWORD PTR [r13], cl
    shl DWORD PTR [rax], 0x1
    shl DWORD PTR [rax+0x7f], 0x1
    shl DWORD PTR [rax+0x80], 0x1
    shl DWORD PTR [rax+rbx*4], 0x1
    shl DWORD PTR [rbx*8+0x10], 0x1
    shl DWORD PTR [rip+0x100], 0x1
    shl DWORD PTR [0x1000], 0x1
    shl DWORD PTR [r13], 0x1
    shl QWORD PTR [rax], 0x1
    shl QWORD PTR [rax+0x7f], 0x1
    shl QWORD PTR [rax+0x80], 0x1
    shl QWORD PTR [rax+rbx*4], 0x1
    shl QWORD PTR [rbx*8+0x10], 0x1
    shl QWORD PTR [rip+0x100], 0x1
    shl QWORD PTR [0x1000], 0x1
    shl QWORD PTR [r13], 0x1
    shr BYTE PTR [rax], 1
    shr BYTE PTR [rax+0x7f], 1
    shr BYTE PTR [rax+0x80], 1
    shr BYTE PTR [rax+rbx*4], 1
    shr BYTE PTR [rbx*8+0x10], 1
    shr BYTE PTR [rip+0x100], 1
    shr BYTE PTR [0x1000], 1
    shr BYTE PTR [r13], 1
    shr BYTE PTR [rax], cl
    shr BYTE PTR [rax+0x7f], cl
    shr BYTE PTR [rax+0x80], cl
    shr BYTE PTR [rax+rbx*4], cl
    shr BYTE PTR [rbx*8+0x10], cl
    shr BYTE PTR [rip+0x100], cl
    shr BYTE PTR [0x1000], cl
    shr BYTE PTR [r13], cl
    shr BYTE PTR [rax], 0x1
    shr BYTE PTR [rax+0x7f], 0x1
    shr BYTE PTR [rax+0x80], 0x1
    shr BYTE PTR [rax+rbx*4], 0x1
    shr BYTE PTR [rbx*8+0x10], 0x1
    shr BYTE PTR [rip+0x100], 0x1
    shr BYTE PTR [0x1000], 0x1
    shr BYTE PTR [r13], 0x1
    shr WORD PTR [rax], 1
    shr WORD PTR [rax+0x7f], 1
    shr WORD PTR [rax+0x80], 1
    shr WORD PTR [rax+rbx*4], 1
    shr WORD PTR [rbx*8+0x10], 1
    shr WORD PTR [rip+0x100], 1
    shr WORD PTR [0x1000], 1
    shr WORD PTR [r13], 1
    shr WORD PTR [rax], cl
    shr WORD PTR [rax+0x7f], cl
    shr WORD PTR [rax+0x80], cl
    shr WORD PTR [rax+rbx*4], cl
    shr WORD PTR [rbx*8+0x10], cl
    shr WORD PTR [rip+0x100], cl
    shr WORD PTR [0x1000], cl
    shr WORD PTR [r13], cl
    shr WORD PTR [rax], 0x1
    shr WORD PTR [rax+0x7f], 0x1
    shr WORD PTR [rax+0x80], 0x1
    shr WORD PTR [rax+rbx*4], 0x1
    shr WORD PTR [rbx*8+0x10], 0x1
    shr WORD PTR [rip+0x100], 0x1
    shr WORD PTR [0x1000], 0x1
    shr WORD PTR [r13], 0x1
    shr DWORD PTR [rax], 1
    shr DWORD PTR [rax+0x7f], 1
    shr DWORD PTR [rax+0x80], 1
    shr DWORD PTR [rax+rbx*4], 1
    shr DWORD PTR [rbx*8+0x10], 1
    shr DWORD PTR [rip+0x100], 1
    shr DWORD PTR [0x1000], 1
    shr DWORD PTR [r13], 1
    shr QWORD PTR [rax], 1
    shr QWORD PTR [rax+0x7f], 1
    shr QWORD PTR [rax+0x80], 1
    shr QWORD PTR [rax+rbx*4], 1
    shr QWORD PTR [rbx*8+0x10], 1
    shr QWORD PTR [rip+0x100], 1
    shr QWORD PTR [0x1000], 1
    shr QWORD PTR [r13], 1
    shr DWORD PTR [rax], cl
    shr DWORD PTR [rax+0x7f], cl
    shr DWORD PTR [rax+0x80], cl
    shr DWORD PTR [rax+rbx*4], cl
    shr DWORD PTR [rbx*8+0x10], cl
    shr DWORD PTR [rip+0x100], cl
    shr DWORD PTR [0x1000], cl
    shr DWORD PTR [r13], cl
    shr QWORD PTR [rax], cl
    shr QWORD PTR [rax+0x7f], cl
    shr QWORD PTR [rax+0x80], cl
    shr QWORD PTR [rax+rbx*4], cl
    shr QWORD PTR [rbx*8+0x10], cl
    shr QWORD PTR [rip+0x100], cl
    shr QWORD PTR [0x1000], cl
    shr QWORD PTR [r13], cl
    shr DWORD PTR [rax], 0x1
    shr DWORD PTR [rax+0x7f], 0x1
    shr DWORD PTR [rax+0x80], 0x1
    shr DWORD PTR [rax+rbx*4], 0x1
    shr DWORD PTR [rbx*8+0x10], 0x1
    shr DWORD PTR [rip+0x100], 0x1
    shr DWORD PTR [0x1000], 0x1
    shr DWORD PTR [r13], 0x1
    shr QWORD PTR [rax], 0x1
    shr QWORD PTR [rax+0x7f], 0x1
    shr QWORD PTR [rax+0x80], 0x1
    shr QWORD PTR [rax+rbx*4], 0x1
    shr QWORD PTR [rbx*8+0x10], 0x1
    shr QWORD PTR [rip+0x100], 0x1
    shr QWORD PTR [0x1000], 0x1
    shr QWORD PTR [r13], 0x1
    sarx eax, DWORD PTR [rax], eax
    sarx eax, DWORD PTR [rax+0x7f], eax
    sarx eax, DWORD PTR [rax+0x80], eax
    sarx eax, DWORD PTR [rax+rbx*4], eax
    sarx eax, DWORD PTR [rbx*8+0x10], eax
    sarx eax, DWORD PTR [rip+0x100], eax
    sarx eax, DWORD PTR [0x1000], eax
    sarx eax, DWORD PTR [r13], eax
    shlx eax, DWORD PTR [rax], eax
    shlx eax, DWORD PTR [rax+0x7f], eax
    shlx eax, DWORD PTR [rax+0x80], eax
    shlx eax, DWORD PTR [rax+rbx*4], eax
    shlx eax, DWORD PTR [rbx*8+0x10], eax
    shlx eax, DWORD PTR [rip+0x100], eax
    shlx eax, DWORD PTR [0x1000], eax
    shlx eax, DWORD PTR [r13], eax
    shrx eax, DWORD PTR [rax], eax
    shrx eax, DWORD PTR [rax+0x7f], eax
    shrx eax, DWORD PTR [rax+0x80], eax
    shrx eax, DWORD PTR [rax+rbx*4], eax
    shrx eax, DWORD PTR [rbx*8+0x10], eax
    shrx eax, DWORD PTR [rip+0x100], eax
    shrx eax, DWORD PTR [0x1000], eax
    shrx eax, DWORD PTR [r13], eax
    sarx rax, QWORD PTR [rax], rax
    sarx rax, QWORD PTR [rax+0x7f], rax
    sarx rax, QWORD PTR [rax+0x80], rax
    sarx rax, QWORD PTR [rax+rbx*4], rax
    sarx rax, QWORD PTR [rbx*8+0x10], rax
    sarx rax, QWORD PTR [rip+0x100], rax
    sarx rax, QWORD PTR [0x1000], rax
    sarx rax, QWORD PTR [r13], rax
    shlx rax, QWORD PTR [rax], rax
    shlx rax, QWORD PTR [rax+0x7f], rax
    shlx rax, QWORD PTR [rax+0x80], rax
    shlx rax, QWORD PTR [rax+rbx*4], rax
    shlx rax, QWORD PTR [rbx*8+0x10], rax
    shlx rax, QWORD PTR [rip+0x100], rax
    shlx rax, QWORD PTR [0x1000], rax
    shlx rax, QWORD PTR [r13], rax
    shrx rax, QWORD PTR [rax], rax
    shrx rax, QWORD PTR [rax+0x7f], rax
    shrx rax, QWORD PTR [rax+0x80], rax
    shrx rax, QWORD PTR [rax+rbx*4], rax
    shrx rax, QWORD PTR [rbx*8+0x10], rax
    shrx rax, QWORD PTR [rip+0x100], rax
    shrx rax, QWORD PTR [0x1000], rax
    shrx rax, QWORD PTR [r13], rax
    sbb BYTE PTR [rax], 0x1
    sbb BYTE PTR [rax+0x7f], 0x1
    sbb BYTE PTR [rax+0x80], 0x1
    sbb BYTE PTR [rax+rbx*4], 0x1
    sbb BYTE PTR [rbx*8+0x10], 0x1
    sbb BYTE PTR [rip+0x100], 0x1
    sbb BYTE PTR [0x1000], 0x1
    sbb BYTE PTR [r13], 0x1
    sbb WORD PTR [rax], 0x1
    sbb WORD PTR [rax+0x7f], 0x1
    sbb WORD PTR [rax+0x80], 0x1
    sbb WORD PTR [rax+rbx*4], 0x1
    sbb WORD PTR [rbx*8+0x10], 0x1
    sbb WORD PTR [rip+0x100], 0x1
    sbb WORD PTR [0x1000], 0x1
    sbb WORD PTR [r13], 0x1
    sbb DWORD PTR [rax], 0x1
    sbb DWORD PTR [rax+0x7f], 0x1
    sbb DWORD PTR [rax+0x80], 0x1
    sbb DWORD PTR [rax+rbx*4], 0x1
    sbb DWORD PTR [rbx*8+0x10], 0x1
    sbb DWORD PTR [rip+0x100], 0x1
    sbb DWORD PTR [0x1000], 0x1
    sbb DWORD PTR [r13], 0x1
    sbb QWORD PTR [rax], 0x1
    sbb QWORD PTR [rax+0x7f], 0x1
    sbb QWORD PTR [rax+0x80], 0x1
    sbb QWORD PTR [rax+rbx*4], 0x1
    sbb QWORD PTR [rbx*8+0x10], 0x1
    sbb QWORD PTR [rip+0x100], 0x1
    sbb QWORD PTR [0x1000], 0x1
    sbb QWORD PTR [r13], 0x1
    sbb BYTE PTR [rax], al
    sbb BYTE PTR [rax+0x7f], al
    sbb BYTE PTR [rax+0x80], al
    sbb BYTE PTR [rax+rbx*4], al
    sbb BYTE PTR [rbx*8+0x10], al
    sbb BYTE PTR [rip+0x100], al
    sbb BYTE PTR [0x1000], al
    sbb BYTE PTR [r13], al
    sbb WORD PTR [rax], ax
    sbb WORD PTR [rax+0x7f], ax
    sbb WORD PTR [rax+0x80], ax
    sbb WORD PTR [rax+rbx*4], ax
    sbb WORD PTR [rbx*8+0x10], ax
    sbb WORD PTR [rip+0x100], ax
    sbb WORD PTR [0x1000], ax
    sbb WORD PTR [r13], ax
    sbb DWORD PTR [rax], eax
    sbb DWORD PTR [rax+0x7f], eax
    sbb DWORD PTR [rax+0x80], eax
    sbb DWORD PTR [rax+rbx*4], eax
    sbb DWORD PTR [rbx*8+0x10], eax
    sbb DWORD PTR [rip+0x100], eax
    sbb DWORD PTR [0x1000], eax
    sbb DWORD PTR [r13], eax
    sbb QWORD PTR [rax], rax
    sbb QWORD PTR [rax+0x7f], rax
    sbb QWORD PTR [rax+0x80], rax
    sbb QWORD PTR [rax+rbx*4], rax
    sbb QWORD PTR [rbx*8+0x10], rax
    sbb QWORD PTR [rip+0x100], rax
    sbb QWORD PTR [0x1000], rax
    sbb QWORD PTR [r13], rax
    sbb al, BYTE PTR [rax]
    sbb al, BYTE PTR [rax+0x7f]
    sbb al, BYTE PTR [rax+0x80]
    sbb al, BYTE PTR [rax+rbx*4]
    sbb al, BYTE PTR [rbx*8+0x10]
    sbb al, BYTE PTR [rip+0x100]
    sbb al, BYTE PTR [0x1000]
    sbb al, BYTE PTR [r13]
    sbb ax, WORD PTR [rax]
    sbb ax, WORD PTR [rax+0x7f]
    sbb ax, WORD PTR [rax+0x80]
    sbb ax, WORD PTR [rax+rbx*4]
    sbb ax, WORD PTR [rbx*8+0x10]
    sbb ax, WORD PTR [rip+0x100]
    sbb ax, WORD PTR [0x1000]
    sbb ax, WORD PTR [r13]
    sbb eax, DWORD PTR [rax]
    sbb eax, DWORD PTR [rax+0x7f]
    sbb eax, DWORD PTR [rax+0x80]
    sbb eax, DWORD PTR [rax+rbx*4]
    sbb eax, DWORD PTR [rbx*8+0x10]
    sbb eax, DWORD PTR [rip+0x100]
    sbb eax, DWORD PTR [0x1000]
    sbb eax, DWORD PTR [r13]
    sbb rax, QWORD PTR [rax]
    sbb rax, QWORD PTR [rax+0x7f]
    sbb rax, QWORD PTR [rax+0x80]
    sbb rax, QWORD PTR [rax+rbx*4]
    sbb rax, QWORD PTR [rbx*8+0x10]
    sbb rax, QWORD PTR [rip+0x100]
    sbb rax, QWORD PTR [0x1000]
    sbb rax, QWORD PTR [r13]
    scas BYTE PTR [rax]
    scas BYTE PTR [rax+0x7f]
    scas BYTE PTR [rax+0x80]
    scas BYTE PTR [rax+rbx*4]
    scas BYTE PTR [rbx*8+0x10]
    scas BYTE PTR [rip+0x100]
    scas BYTE PTR [0x1000]
    scas BYTE PTR [r13]
    scas WORD PTR [rax]
    scas WORD PTR [rax+0x7f]
    scas WORD PTR [rax+0x80]
    scas WORD PTR [rax+rbx*4]
    scas WORD PTR [rbx*8+0x10]
    scas WORD PTR [rip+0x100]
    scas WORD PTR [0x1000]
    scas WORD PTR [r13]
    scas DWORD PTR [rax]
    scas DWORD PTR [rax+0x7f]
    scas DWORD PTR [rax+0x80]
    scas DWORD PTR [rax+rbx*4]
    scas DWORD PTR [rbx*8+0x10]
    scas DWORD PTR [rip+0x100]
    scas DWORD PTR [0x1000]
    scas DWORD PTR [r13]
    scas QWORD PTR [rax]
    scas QWORD PTR [rax+0x7f]
    scas QWORD PTR [rax+0x80]
    scas QWORD PTR [rax+rbx*4]
    scas QWORD PTR [rbx*8+0x10]
    scas QWORD PTR [rip+0x100]
    scas QWORD PTR [0x1000]
    scas QWORD PTR [r13]
    seta BYTE PTR [rax]
    seta BYTE PTR [rax+0x7f]
    seta BYTE PTR [rax+0x80]
    seta BYTE PTR [rax+rbx*4]
    seta BYTE PTR [rbx*8+0x10]
    seta BYTE PTR [rip+0x100]
    seta BYTE PTR [0x1000]
    seta BYTE PTR [r13]
    setae BYTE PTR [rax]
    setae BYTE PTR [rax+0x7f]
    setae BYTE PTR [rax+0x80]
    setae BYTE PTR [rax+rbx*4]
    setae BYTE PTR [rbx*8+0x10]
    setae BYTE PTR [rip+0x100]
    setae BYTE PTR [0x1000]
    setae BYTE PTR [r13]
    setb BYTE PTR [rax]
    setb BYTE PTR [rax+0x7f]
    setb BYTE PTR [rax+0x80]
    setb BYTE PTR [rax+rbx*4]
    setb BYTE PTR [rbx*8+0x10]
    setb BYTE PTR [rip+0x100]
    setb BYTE PTR [0x1000]
    setb BYTE PTR [r13]
    setbe BYTE PTR [rax]
    setbe BYTE PTR [rax+0x7f]
    setbe BYTE PTR [rax+0x80]
    setbe BYTE PTR [rax+rbx*4]
    setbe BYTE PTR [rbx*8+0x10]
    setbe BYTE PTR [rip+0x100]
    setbe BYTE PTR [0x1000]
    setbe BYTE PTR [r13]
    setc BYTE PTR [rax]
    setc BYTE PTR [rax+0x7f]
    setc BYTE PTR [rax+0x80]
    setc BYTE PTR [rax+rbx*4]
    setc BYTE PTR [rbx*8+0x10]
    setc BYTE PTR [rip+0x100]
    setc BYTE PTR [0x1000]
    setc BYTE PTR [r13]
    sete BYTE PTR [rax]
    sete BYTE PTR [rax+0x7f]
    sete BYTE PTR [rax+0x80]
    sete BYTE PTR [rax+rbx*4]
    sete BYTE PTR [rbx*8+0x10]
    sete BYTE PTR [rip+0x100]
    sete BYTE PTR [0x1000]
    sete BYTE PTR [r13]
    setg BYTE PTR [rax]
    setg BYTE PTR [rax+0x7f]
    setg BYTE PTR [rax+0x80]
    setg BYTE PTR [rax+rbx*4]
    setg BYTE PTR [rbx*8+0x10]
    setg BYTE PTR [rip+0x100]
    setg BYTE PTR [0x1000]
    setg BYTE PTR [r13]
    setge BYTE PTR [rax]
    setge BYTE PTR [rax+0x7f]
    setge BYTE PTR [rax+0x80]
    setge BYTE PTR [rax+rbx*4]
    setge BYTE PTR [rbx*8+0x10]
    setge BYTE PTR [rip+0x100]
    setge BYTE PTR [0x1000]
    setge BYTE PTR [r13]
    setl BYTE PTR [rax]
    setl BYTE PTR [rax+0x7f]
    setl BYTE PTR [rax+0x80]
    setl BYTE PTR [rax+rbx*4]
    setl BYTE PTR [rbx*8+0x10]
    setl BYTE PTR [rip+0x100]
    setl BYTE PTR [0x1000]
    setl BYTE PTR [r13]
    setle BYTE PTR [rax]
    setle BYTE PTR [rax+0x7f]
    setle BYTE PTR [rax+0x80]
    setle BYTE PTR [rax+rbx*4]
    setle BYTE PTR [rbx*8+0x10]
    setle BYTE PTR [rip+0x100]
    setle BYTE PTR [0x1000]
    setle BYTE PTR [r13]
    setna BYTE PTR [rax]
    setna BYTE PTR [rax+0x7f]
    setna BYTE PTR [rax+0x80]
    setna BYTE PTR [rax+rbx*4]
    setna BYTE PTR [rbx*8+0x10]
    setna BYTE PTR [rip+0x100]
    setna BYTE PTR [0x1000]
    setna BYTE PTR [r13]
    setnae BYTE PTR [rax]
    setnae BYTE PTR [rax+0x7f]
    setnae BYTE PTR [rax+0x80]
    setnae BYTE PTR [rax+rbx*4]
    setnae BYTE PTR [rbx*8+0x10]
    setnae BYTE PTR [rip+0x100]
    setnae BYTE PTR [0x1000]
    setnae BYTE PTR [r13]
    setnb BYTE PTR [rax]
    setnb BYTE PTR [rax+0x7f]
    setnb BYTE PTR [rax+0x80]
    setnb BYTE PTR [rax+rbx*4]
    setnb BYTE PTR [rbx*8+0x10]
    setnb BYTE PTR [rip+0x100]
    setnb BYTE PTR [0x1000]
    setnb BYTE PTR [r13]
    setnbe BYTE PTR [rax]
    setnbe BYTE PTR [rax+0x7f]
    setnbe BYTE PTR [rax+0x80]
    setnbe BYTE PTR [rax+rbx*4]
    setnbe BYTE PTR [rbx*8+0x10]
    setnbe BYTE PTR [rip+0x100]
    setnbe BYTE PTR [0x1000]
    setnbe BYTE PTR [r13]
    setnc BYTE PTR [rax]
    setnc BYTE PTR [rax+0x7f]
    setnc BYTE PTR [rax+0x80]
    setnc BYTE PTR [rax+rbx*4]
    setnc BYTE PTR [rbx*8+0x10]
    setnc BYTE PTR [rip+0x100]
    setnc BYTE PTR [0x1000]
    setnc BYTE PTR [r13]
    setne BYTE PTR [rax]
    setne BYTE PTR [rax+0x7f]
    setne BYTE PTR [rax+0x80]
    setne BYTE PTR [rax+rbx*4]
    setne BYTE PTR [rbx*8+0x10]
    setne BYTE PTR [rip+0x100]
    setne BYTE PTR [0x1000]
    setne BYTE PTR [r13]
    setng BYTE PTR [rax]
    setng BYTE PTR [rax+0x7f]
    setng BYTE PTR [rax+0x80]
    setng BYTE PTR [rax+rbx*4]
    setng BYTE PTR [rbx*8+0x10]
    setng BYTE PTR [rip+0x100]
    setng BYTE PTR [0x1000]
    setng BYTE PTR [r13]
    setnge BYTE PTR [rax]
    setnge BYTE PTR [rax+0x7f]
    setnge BYTE PTR [rax+0x80]
    setnge BYTE PTR [rax+rbx*4]
    setnge BYTE PTR [rbx*8+0x10]
    setnge BYTE PTR [rip+0x100]
    setnge BYTE PTR [0x1000]
    setnge BYTE PTR [r13]
    setnl BYTE PTR [rax]
    setnl BYTE PTR [rax+0x7f]
    setnl BYTE PTR [rax+0x80]
    setnl BYTE PTR [rax+rbx*4]
    setnl BYTE PTR [rbx*8+0x10]
    setnl BYTE PTR [rip+0x100]
    setnl BYTE PTR [0x1000]
    setnl BYTE PTR [r13]
    setnle BYTE PTR [rax]
    setnle BYTE PTR [rax+0x7f]
    setnle BYTE PTR [rax+0x80]
    setnle BYTE PTR [rax+rbx*4]
    setnle BYTE PTR [rbx*8+0x10]
    setnle BYTE PTR [rip+0x100]
    setnle BYTE PTR [0x1000]
    setnle BYTE PTR [r13]
    setno BYTE PTR [rax]
    setno BYTE PTR [rax+0x7f]
    setno BYTE PTR [rax+0x80]
    setno BYTE PTR [rax+rbx*4]
    setno BYTE PTR [rbx*8+0x10]
    setno BYTE PTR [rip+0x100]
    setno BYTE PTR [0x1000]
    setno BYTE PTR [r13]
    setnp BYTE PTR [rax]
    setnp BYTE PTR [rax+0x7f]
    setnp BYTE PTR [rax+0x80]
    setnp BYTE PTR [rax+rbx*4]
    setnp BYTE PTR [rbx*8+0x10]
    setnp BYTE PTR [rip+0x100]
    setnp BYTE PTR [0x1000]
    setnp BYTE PTR [r13]
    setns BYTE PTR [rax]
    setns BYTE PTR [rax+0x7f]
    setns BYTE PTR [rax+0x80]
    setns BYTE PTR [rax+rbx*4]
    setns BYTE PTR [rbx*8+0x10]
    setns BYTE PTR [rip+0x100]
    setns BYTE PTR [0x1000]
    setns BYTE PTR [r13]
    setnz BYTE PTR [rax]
    setnz BYTE PTR [rax+0x7f]
    setnz BYTE PTR [rax+0x80]
    setnz BYTE PTR [rax+rbx*4]
    setnz BYTE PTR [rbx*8+0x10]
    setnz BYTE PTR [rip+0x100]
    setnz BYTE PTR [0x1000]
    setnz BYTE PTR [r13]
    seto BYTE PTR [rax]
    seto BYTE PTR [rax+0x7f]
    seto BYTE PTR [rax+0x80]
    seto BYTE PTR [rax+rbx*4]
    seto BYTE PTR [rbx*8+0x10]
    seto BYTE PTR [rip+0x100]
    seto BYTE PTR [0x1000]
    seto BYTE PTR [r13]
    setp BYTE PTR [rax]
    setp BYTE PTR [rax+0x7f]
    setp BYTE PTR [rax+0x80]
    setp BYTE PTR [rax+rbx*4]
    setp BYTE PTR [rbx*8+0x10]
    setp BYTE PTR [rip+0x100]
    setp BYTE PTR [0x1000]
    setp BYTE PTR [r13]
    setpe BYTE PTR [rax]
    setpe BYTE PTR [rax+0x7f]
    setpe BYTE PTR [rax+0x80]
    setpe BYTE PTR [rax+rbx*4]
    setpe BYTE PTR [rbx*8+0x10]
    setpe BYTE PTR [rip+0x100]
    setpe BYTE PTR [0x1000]
    setpe BYTE PTR [r13]
    setpo BYTE PTR [rax]
    setpo BYTE PTR [rax+0x7f]
    setpo BYTE PTR [rax+0x80]
    setpo BYTE PTR [rax+rbx*4]
    setpo BYTE PTR [rbx*8+0x10]
    setpo BYTE PTR [rip+0x100]
    setpo BYTE PTR [0x1000]
    setpo BYTE PTR [r13]
    sets BYTE PTR [rax]
    sets BYTE PTR [rax+0x7f]
    sets BYTE PTR [rax+0x80]
    sets BYTE PTR [rax+rbx*4]
    sets BYTE PTR [rbx*8+0x10]
    sets BYTE PTR [rip+0x100]
    sets BYTE PTR [0x1000]
    sets BYTE PTR [r13]
    setz BYTE PTR [rax]
    setz BYTE PTR [rax+0x7f]
    setz BYTE PTR [rax+0x80]
    setz BYTE PTR [rax+rbx*4]
    setz BYTE PTR [rbx*8+0x10]
    setz BYTE PTR [rip+0x100]
    setz BYTE PTR [0x1000]
    setz BYTE PTR [r13]
    sgdt [rax]
    sgdt [rax+0x7f]
    sgdt [rax+0x80]
    sgdt [rax+rbx*4]
    sgdt [rbx*8+0x10]
    sgdt [rip+0x100]
    sgdt [0x1000]
    sgdt [r13]
    sha1msg1 xmm1, [rax]
    sha1msg1 xmm1, [rax+0x7f]
    sha1msg1 xmm1, [rax+0x80]
    sha1msg1 xmm1, [rax+rbx*4]
    sha1msg1 xmm1, [rbx*8+0x10]
    sha1msg1 xmm1, [rip+0x100]
    sha1msg1 xmm1, [0x1000]
    sha1msg1 xmm1, [r13]
    sha1msg2 xmm1, [rax]
    sha1msg2 xmm1, [rax+0x7f]
    sha1msg2 xmm1, [rax+0x80]
    sha1msg2 xmm1, [rax+rbx*4]
    sha1msg2 xmm1, [rbx*8+0x10]
    sha1msg2 xmm1, [rip+0x100]
    sha1msg2 xmm1, [0x1000]
    sha1msg2 xmm1, [r13]
    sha1nexte xmm1, [rax]
    sha1nexte xmm1, [rax+0x7f]
    sha1nexte xmm1, [rax+0x80]
    sha1nexte xmm1, [rax+rbx*4]
    sha1nexte xmm1, [rbx*8+0x10]
    sha1nexte xmm1, [rip+0x100]
    sha1nexte xmm1, [0x1000]
    sha1nexte xmm1, [r13]
    sha1rnds4 xmm1, [rax], 0x1
    sha1rnds4 xmm1, [rax+0x7f], 0x1
    sha1rnds4 xmm1, [rax+0x80], 0x1
    sha1rnds4 xmm1, [rax+rbx*4], 0x1
    sha1rnds4 xmm1, [rbx*8+0x10], 0x1
    sha1rnds4 xmm1, [rip+0x100], 0x1
    sha1rnds4 xmm1, [0x1000], 0x1
    sha1rnds4 xmm1, [r13], 0x1
    sha256msg1 xmm1, [rax]
    sha256msg1 xmm1, [rax+0x7f]
    sha256msg1 xmm1, [rax+0x80]
    sha256msg1 xmm1, [rax+rbx*4]
    sha256msg1 xmm1, [rbx*8+0x10]
    sha256msg1 xmm1, [rip+0x100]
    sha256msg1 xmm1, [0x1000]
    sha256msg1 xmm1, [r13]
    sha256msg2 xmm1, [rax]
    sha256msg2 xmm1, [rax+0x7f]
    sha256msg2 xmm1, [rax+0x80]
    sha256msg2 xmm1, [rax+rbx*4]
    sha256msg2 xmm1, [rbx*8+0x10]
    sha256msg2 xmm1, [rip+0x100]
    sha256msg2 xmm1, [0x1000]
    sha256msg2 xmm1, [r13]
    sha256rnds2 xmm1, [rax]
    sha256rnds2 xmm1, [rax+0x7f]
    sha256rnds2 xmm1, [rax+0x80]
    sha256rnds2 xmm1, [rax+rbx*4]
    sha256rnds2 xmm1, [rbx*8+0x10]
    sha256rnds2 xmm1, [rip+0x100]
    sha256rnds2 xmm1, [0x1000]
    sha256rnds2 xmm1, [r13]
    shld WORD PTR [rax], ax, 0x1
    shld WORD PTR [rax+0x7f], ax, 0x1
    shld WORD PTR [rax+0x80], ax, 0x1
    shld WORD PTR [rax+rbx*4], ax, 0x1
    shld WORD PTR [rbx*8+0x10], ax, 0x1
    shld WORD PTR [rip+0x100], ax, 0x1
    shld WORD PTR [0x1000], ax, 0x1
    shld WORD PTR [r13], ax, 0x1
    shld WORD PTR [rax], ax, cl
    shld WORD PTR [rax+0x7f], ax, cl
    shld WORD PTR [rax+0x80], ax, cl
    shld WORD PTR [rax+rbx*4], ax, cl
    shld WORD PTR [rbx*8+0x10], ax, cl
    shld WORD PTR [rip+0x100], ax, cl
    shld WORD PTR [0x1000], ax, cl
    shld WORD PTR [r13], ax, cl
    shld DWORD PTR [rax], eax, 0x1
    shld DWORD PTR [rax+0x7f], eax, 0x1
    shld DWORD PTR [rax+0x80], eax, 0x1
    shld DWORD PTR [rax+rbx*4], eax, 0x1
    shld DWORD PTR [rbx*8+0x10], eax, 0x1
    shld DWORD PTR [rip+0x100], eax, 0x1
    shld DWORD PTR [0x1000], eax, 0x1
    shld DWORD PTR [r13], eax, 0x1
    shld QWORD PTR [rax], rax, 0x1
    shld QWORD PTR [rax+0x7f], rax, 0x1
    shld QWORD PTR [rax+0x80], rax, 0x1
    shld QWORD PTR [rax+rbx*4], rax, 0x1
    shld QWORD PTR [rbx*8+0x10], rax, 0x1
    shld QWORD PTR [rip+0x100], rax, 0x1
    shld QWORD PTR [0x1000], rax, 0x1
    shld QWORD PTR [r13], rax, 0x1
    shld DWORD PTR [rax], eax, cl
    shld DWORD PTR [rax+0x7f], eax, cl
    shld DWORD PTR [rax+0x80], eax, cl
    shld DWORD PTR [rax+rbx*4], eax, cl
    shld DWORD PTR [rbx*8+0x10], eax, cl
    shld DWORD PTR [rip+0x100], eax, cl
    shld DWORD PTR [0x1000], eax, cl
    shld DWORD PTR [r13], eax, cl
    shld QWORD PTR [rax], rax, cl
    shld QWORD PTR [rax+0x7f], rax, cl
    shld QWORD PTR [rax+0x80], rax, cl
    shld QWORD PTR [rax+rbx*4], rax, cl
    shld QWORD PTR [rbx*8+0x10], rax, cl
    shld QWORD PTR [rip+0x100], rax, cl
    shld QWORD PTR [0x1000], rax, cl
    shld QWORD PTR [r13], rax, cl
    shrd WORD PTR [rax], ax, 0x1
    shrd WORD PTR [rax+0x7f], ax, 0x1
    shrd WORD PTR [rax+0x80], ax, 0x1
    shrd WORD PTR [rax+rbx*4], ax, 0x1
    shrd WORD PTR [rbx*8+0x10], ax, 0x1
    shrd WORD PTR [rip+0x100], ax, 0x1
    shrd WORD PTR [0x1000], ax, 0x1
    shrd WORD PTR [r13], ax, 0x1
    shrd WORD PTR [rax], ax, cl
    shrd WORD PTR [rax+0x7f], ax, cl
    shrd WORD PTR [rax+0x80], ax, cl
    shrd WORD PTR [rax+rbx*4], ax, cl
    shrd WORD PTR [rbx*8+0x10], ax, cl
    shrd WORD PTR [rip+0x100], ax, cl
    shrd WORD PTR [0x1000], ax, cl
    shrd WORD PTR [r13], ax, cl
    shrd DWORD PTR [rax], eax, 0x1
    shrd DWORD PTR [rax+0x7f], eax, 0x1
    shrd DWORD PTR [rax+0x80], eax, 0x1
    shrd DWORD PTR [rax+rbx*4], eax, 0x1
    shrd DWORD PTR [rbx*8+0x10], eax, 0x1
    shrd DWORD PTR [rip+0x100], eax, 0x1
    shrd DWORD PTR [0x1000], eax, 0x1
    shrd DWORD PTR [r13], eax, 0x1
    shrd QWORD PTR [rax], rax, 0x1
    shrd QWORD PTR [rax+0x7f], rax, 0x1
    shrd QWORD PTR [rax+0x80], rax, 0x1
    shrd QWORD PTR [rax+rbx*4], rax, 0x1
    shrd QWORD PTR [rbx*8+0x10], rax, 0x1
    shrd QWORD PTR [rip+0x100], rax, 0x1
    shrd QWORD PTR [0x1000], rax, 0x1
    shrd QWORD PTR [r13], rax, 0x1
    shrd DWORD PTR [rax], eax, cl
    shrd DWORD PTR [rax+0x7f], eax, cl
    shrd DWORD PTR [rax+0x80], eax, cl
    shrd DWORD PTR [rax+rbx*4], eax, cl
    shrd DWORD PTR [rbx*8+0x10], eax, cl
    shrd DWORD PTR [rip+0x100], eax, cl
    shrd DWORD PTR [0x1000], eax, cl
    shrd DWORD PTR [r13], eax, cl
    shrd QWORD PTR [rax], rax, cl
    shrd QWORD PTR [rax+0x7f], rax, cl
    shrd QWORD PTR [rax+0x80], rax, cl
    shrd QWORD PTR [rax+rbx*4], rax, cl
    shrd QWORD PTR [rbx*8+0x10], rax, cl
    shrd QWORD PTR [rip+0x100], rax, cl
    shrd QWORD PTR [0x1000], rax, cl
    shrd QWORD PTR [r13], rax, cl
    shufpd xmm1, [rax], 0x1
    shufpd xmm1, [rax+0x7f], 0x1
    shufpd xmm1, [rax+0x80], 0x1
    shufpd xmm1, [rax+rbx*4], 0x1
    shufpd xmm1, [rbx*8+0x10], 0x1
    shufpd xmm1, [rip+0x100], 0x1
    shufpd xmm1, [0x1000], 0x1
    shufpd xmm1, [r13], 0x1
    vshufpd xmm1, xmm2, [rax], 0x1
    vshufpd xmm1, xmm2, [rax+0x7f], 0x1
    vshufpd xmm1, xmm2, [rax+0x80], 0x1
    vshufpd xmm1, xmm2, [rax+rbx*4], 0x1
    vshufpd xmm1, xmm2, [rbx*8+0x10], 0x1
    vshufpd xmm1, xmm2, [rip+0x100], 0x1
    vshufpd xmm1, xmm2, [0x1000], 0x1
    vshufpd xmm1, xmm2, [r13], 0x1
    vshufpd ymm1, ymm2, [rax], 0x1
    vshufpd ymm1, ymm2, [rax+0x7f], 0x1
    vshufpd ymm1, ymm2, [rax+0x80], 0x1
    vshufpd ymm1, ymm2, [rax+rbx*4], 0x1
    vshufpd ymm1, ymm2, [rbx*8+0x10], 0x1
    vshufpd ymm1, ymm2, [rip+0x100], 0x1
    vshufpd ymm1, ymm2, [0x1000], 0x1
    vshufpd ymm1, ymm2, [r13], 0x1
    shufps xmm1, [rax], 0x1
    shufps xmm1, [rax+0x7f], 0x1
    shufps xmm1, [rax+0x80], 0x1
    shufps xmm1, [rax+rbx*4], 0x1
    shufps xmm1, [rbx*8+0x10], 0x1
    shufps xmm1, [rip+0x100], 0x1
    shufps xmm1, [0x1000], 0x1
    shufps xmm1, [r13], 0x1
    vshufps xmm1, xmm2, [rax], 0x1
    vshufps xmm1, xmm2, [rax+0x7f], 0x1
    vshufps xmm1, xmm2, [rax+0x80], 0x1
    vshufps xmm1, xmm2, [rax+rbx*4], 0x1
    vshufps xmm1, xmm2, [rbx*8+0x10], 0x1
    vshufps xmm1, xmm2, [rip+0x100], 0x1
    vshufps xmm1, xmm2, [0x1000], 0x1
    vshufps xmm1, xmm2, [r13], 0x1
    vshufps ymm1, ymm2, [rax], 0x1
    vshufps ymm1, ymm2, [rax+0x7f], 0x1
    vshufps ymm1, ymm2, [rax+0x80], 0x1
    vshufps ymm1, ymm2, [rax+rbx*4], 0x1
    vshufps ymm1, ymm2, [rbx*8+0x10], 0x1
    vshufps ymm1, ymm2, [rip+0x100], 0x1
    vshufps ymm1, ymm2, [0x1000], 0x1
    vshufps ymm1, ymm2, [r13], 0x1
    sidt [rax]
    sidt [rax+0x7f]
    sidt [rax+0x80]
    sidt [rax+rbx*4]
    sidt [rbx*8+0x10]
    sidt [rip+0x100]
    sidt [0x1000]
    sidt [r13]
    sldt WORD PTR [rax]
    sldt WORD PTR [rax+0x7f]
    sldt WORD PTR [rax+0x80]
    sldt WORD PTR [rax+rbx*4]
    sldt WORD PTR [rbx*8+0x10]
    sldt WORD PTR [rip+0x100]
    sldt WORD PTR [0x1000]
    sldt WORD PTR [r13]
    smsw WORD PTR [rax]
    smsw WORD PTR [rax+0x7f]
    smsw WORD PTR [rax+0x80]
    smsw WORD PTR [rax+rbx*4]
    smsw WORD PTR [rbx*8+0x10]
    smsw WORD PTR [rip+0x100]
    smsw WORD PTR [0x1000]
    smsw WORD PTR [r13]
    sqrtpd xmm1, [rax]
    sqrtpd xmm1, [rax+0x7f]
    sqrtpd xmm1, [rax+0x80]
    sqrtpd xmm1, [rax+rbx*4]
    sqrtpd xmm1, [rbx*8+0x10]
    sqrtpd xmm1, [rip+0x100]
    sqrtpd xmm1, [0x1000]
    sqrtpd xmm1, [r13]
    vsqrtpd xmm1, [rax]
    vsqrtpd xmm1, [rax+0x7f]
    vsqrtpd xmm1, [rax+0x80]
    vsqrtpd xmm1, [rax+rbx*4]
    vsqrtpd xmm1, [rbx*8+0x10]
    vsqrtpd xmm1, [rip+0x100]
    vsqrtpd xmm1, [0x1000]
    vsqrtpd xmm1, [r13]
    vsqrtpd ymm1, [rax]
    vsqrtpd ymm1, [rax+0x7f]
    vsqrtpd ymm1, [rax+0x80]
    vsqrtpd ymm1, [rax+rbx*4]
    vsqrtpd ymm1, [rbx*8+0x10]
    vsqrtpd ymm1, [rip+0x100]
    vsqrtpd ymm1, [0x1000]
    vsqrtpd ymm1, [r13]
    sqrtps xmm1, [rax]
    sqrtps xmm1, [rax+0x7f]
    sqrtps xmm1, [rax+0x80]
    sqrtps xmm1, [rax+rbx*4]
    sqrtps xmm1, [rbx*8+0x10]
    sqrtps xmm1, [rip+0x100]
    sqrtps xmm1, [0x1000]
    sqrtps xmm1, [r13]
    vsqrtps xmm1, [rax]
    vsqrtps xmm1, [rax+0x7f]
    vsqrtps xmm1, [rax+0x80]
    vsqrtps xmm1, [rax+rbx*4]
    vsqrtps xmm1, [rbx*8+0x10]
    vsqrtps xmm1, [rip+0x100]
    vsqrtps xmm1, [0x1000]
    vsqrtps xmm1, [r13]
    vsqrtps ymm1, [rax]
    vsqrtps ymm1, [rax+0x7f]
    vsqrtps ymm1, [rax+0x80]
    vsqrtps ymm1, [rax+rbx*4]
    vsqrtps ymm1, [rbx*8+0x10]
    vsqrtps ymm1, [rip+0x100]
    vsqrtps ymm1, [0x1000]
    vsqrtps ymm1, [r13]
    sqrtsd xmm1, QWORD PTR [rax]
    sqrtsd xmm1, QWORD PTR [rax+0x7f]
    sqrtsd xmm1, QWORD PTR [rax+0x80]
    sqrtsd xmm1, QWORD PTR [rax+rbx*4]
    sqrtsd xmm1, QWORD PTR [rbx*8+0x10]
    sqrtsd xmm1, QWORD PTR [rip+0x100]
    sqrtsd xmm1, QWORD PTR [0x1000]
    sqrtsd xmm1, QWORD PTR [r13]
    vsqrtsd xmm1, xmm2, QWORD PTR [rax]
    vsqrtsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vsqrtsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vsqrtsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vsqrtsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vsqrtsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vsqrtsd xmm1, xmm2, QWORD PTR [0x1000]
    vsqrtsd xmm1, xmm2, QWORD PTR [r13]
    sqrtss xmm1, DWORD PTR [rax]
    sqrtss xmm1, DWORD PTR [rax+0x7f]
    sqrtss xmm1, DWORD PTR [rax+0x80]
    sqrtss xmm1, DWORD PTR [rax+rbx*4]
    sqrtss xmm1, DWORD PTR [rbx*8+0x10]
    sqrtss xmm1, DWORD PTR [rip+0x100]
    sqrtss xmm1, DWORD PTR [0x1000]
    sqrtss xmm1, DWORD PTR [r13]
    vsqrtss xmm1, xmm2, DWORD PTR [rax]
    vsqrtss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vsqrtss xmm1, xmm2, DWORD PTR [rax+0x80]
    vsqrtss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vsqrtss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vsqrtss xmm1, xmm2, DWORD PTR [rip+0x100]
    vsqrtss xmm1, xmm2, DWORD PTR [0x1000]
    vsqrtss xmm1, xmm2, DWORD PTR [r13]
    stmxcsr DWORD PTR [rax]
    stmxcsr DWORD PTR [rax+0x7f]
    stmxcsr DWORD PTR [rax+0x80]
    stmxcsr DWORD PTR [rax+rbx*4]
    stmxcsr DWORD PTR [rbx*8+0x10]
    stmxcsr DWORD PTR [rip+0x100]
    stmxcsr DWORD PTR [0x1000]
    stmxcsr DWORD PTR [r13]
    vstmxcsr DWORD PTR [rax]
    vstmxcsr DWORD PTR [rax+0x7f]
    vstmxcsr DWORD PTR [rax+0x80]
    vstmxcsr DWORD PTR [rax+rbx*4]
    vstmxcsr DWORD PTR [rbx*8+0x10]
    vstmxcsr DWORD PTR [rip+0x100]
    vstmxcsr DWORD PTR [0x1000]
    vstmxcsr DWORD PTR [r13]
    stos BYTE PTR [rax]
    stos BYTE PTR [rax+0x7f]
    stos BYTE PTR [rax+0x80]
    stos BYTE PTR [rax+rbx*4]
    stos BYTE PTR [rbx*8+0x10]
    stos BYTE PTR [rip+0x100]
    stos BYTE PTR [0x1000]
    stos BYTE PTR [r13]
    stos WORD PTR [rax]
    stos WORD PTR [rax+0x7f]
    stos WORD PTR [rax+0x80]
    stos WORD PTR [rax+rbx*4]
    stos WORD PTR [rbx*8+0x10]
    stos WORD PTR [rip+0x100]
    stos WORD PTR [0x1000]
    stos WORD PTR [r13]
    stos DWORD PTR [rax]
    stos DWORD PTR [rax+0x7f]
    stos DWORD PTR [rax+0x80]
    stos DWORD PTR [rax+rbx*4]
    stos DWORD PTR [rbx*8+0x10]
    stos DWORD PTR [rip+0x100]
    stos DWORD PTR [0x1000]
    stos DWORD PTR [r13]
    stos QWORD PTR [rax]
    stos QWORD PTR [rax+0x7f]
    stos QWORD PTR [rax+0x80]
    stos QWORD PTR [rax+rbx*4]
    stos QWORD PTR [rbx*8+0x10]
    stos QWORD PTR [rip+0x100]
    stos QWORD PTR [0x1000]
    stos QWORD PTR [r13]
    str WORD PTR [rax]
    str WORD PTR [rax+0x7f]
    str WORD PTR [rax+0x80]
    str WORD PTR [rax+rbx*4]
    str WORD PTR [rbx*8+0x10]
    str WORD PTR [rip+0x100]
    str WORD PTR [0x1000]
    str WORD PTR [r13]
    sttilecfg [rax]
    sttilecfg [rax+0x7f]
    sttilecfg [rax+0x80]
    sttilecfg [rax+rbx*4]
    sttilecfg [rbx*8+0x10]
    sttilecfg [rip+0x100]
    sttilecfg [0x1000]
    sttilecfg [r13]
    sub BYTE PTR [rax], 0x1
    sub BYTE PTR [rax+0x7f], 0x1
    sub BYTE PTR [rax+0x80], 0x1
    sub BYTE PTR [rax+rbx*4], 0x1
    sub BYTE PTR [rbx*8+0x10], 0x1
    sub BYTE PTR [rip+0x100], 0x1
    sub BYTE PTR [0x1000], 0x1
    sub BYTE PTR [r13], 0x1
    sub WORD PTR [rax], 0x1
    sub WORD PTR [rax+0x7f], 0x1
    sub WORD PTR [rax+0x80], 0x1
    sub WORD PTR [rax+rbx*4], 0x1
    sub WORD PTR [rbx*8+0x10], 0x1
    sub WORD PTR [rip+0x100], 0x1
    sub WORD PTR [0x1000], 0x1
    sub WORD PTR [r13], 0x1
    sub DWORD PTR [rax], 0x1
    sub DWORD PTR [rax+0x7f], 0x1
    sub DWORD PTR [rax+0x80], 0x1
    sub DWORD PTR [rax+rbx*4], 0x1
    sub DWORD PTR [rbx*8+0x10], 0x1
    sub DWORD PTR [rip+0x100], 0x1
    sub DWORD PTR [0x1000], 0x1
    sub DWORD PTR [r13], 0x1
    sub QWORD PTR [rax], 0x1
    sub QWORD PTR [rax+0x7f], 0x1
    sub QWORD PTR [rax+0x80], 0x1
    sub QWORD PTR [rax+rbx*4], 0x1
    sub QWORD PTR [rbx*8+0x10], 0x1
    sub QWORD PTR [rip+0x100], 0x1
    sub QWORD PTR [0x1000], 0x1
    sub QWORD PTR [r13], 0x1
    sub BYTE PTR [rax], al
    sub BYTE PTR [rax+0x7f], al
    sub BYTE PTR [rax+0x80], al
    sub BYTE PTR [rax+rbx*4], al
    sub BYTE PTR [rbx*8+0x10], al
    sub BYTE PTR [rip+0x100], al
    sub BYTE PTR [0x1000], al
    sub BYTE PTR [r13], al
    sub WORD PTR [rax], ax
    sub WORD PTR [rax+0x7f], ax
    sub WORD PTR [rax+0x80], ax
    sub WORD PTR [rax+rbx*4], ax
    sub WORD PTR [rbx*8+0x10], ax
    sub WORD PTR [rip+0x100], ax
    sub WORD PTR [0x1000], ax
    sub WORD PTR [r13], ax
    sub DWORD PTR [rax], eax
    sub DWORD PTR [rax+0x7f], eax
    sub DWORD PTR [rax+0x80], eax
    sub DWORD PTR [rax+rbx*4], eax
    sub DWORD PTR [rbx*8+0x10], eax
    sub DWORD PTR [rip+0x100], eax
    sub DWORD PTR [0x1000], eax
    sub DWORD PTR [r13], eax
    sub QWORD PTR [rax], rax
    sub QWORD PTR [rax+0x7f], rax
    sub QWORD PTR [rax+0x80], rax
    sub QWORD PTR [rax+rbx*4], rax
    sub QWORD PTR [rbx*8+0x10], rax
    sub QWORD PTR [rip+0x100], rax
    sub QWORD PTR [0x1000], rax
    sub QWORD PTR [r13], rax
    sub al, BYTE PTR [rax]
    sub al, BYTE PTR [rax+0x7f]
    sub al, BYTE PTR [rax+0x80]
    sub al, BYTE PTR [rax+rbx*4]
    sub al, BYTE PTR [rbx*8+0x10]
    sub al, BYTE PTR [rip+0x100]
    sub al, BYTE PTR [0x1000]
    sub al, BYTE PTR [r13]
    sub ax, WORD PTR [rax]
    sub ax, WORD PTR [rax+0x7f]
    sub ax, WORD PTR [rax+0x80]
    sub ax, WORD PTR [rax+rbx*4]
    sub ax, WORD PTR [rbx*8+0x10]
    sub ax, WORD PTR [rip+0x100]
    sub ax, WORD PTR [0x1000]
    sub ax, WORD PTR [r13]
    sub eax, DWORD PTR [rax]
    sub eax, DWORD PTR [rax+0x7f]
    sub eax, DWORD PTR [rax+0x80]
    sub eax, DWORD PTR [rax+rbx*4]
    sub eax, DWORD PTR [rbx*8+0x10]
    sub eax, DWORD PTR [rip+0x100]
    sub eax, DWORD PTR [0x1000]
    sub eax, DWORD PTR [r13]
    sub rax, QWORD PTR [rax]
    sub rax, QWORD PTR [rax+0x7f]
    sub rax, QWORD PTR [rax+0x80]
    sub rax, QWORD PTR [rax+rbx*4]
    sub rax, QWORD PTR [rbx*8+0x10]
    sub rax, QWORD PTR [rip+0x100]
    sub rax, QWORD PTR [0x1000]
    sub rax, QWORD PTR [r13]
    subpd xmm1, [rax]
    subpd xmm1, [rax+0x7f]
    subpd xmm1, [rax+0x80]
    subpd xmm1, [rax+rbx*4]
    subpd xmm1, [rbx*8+0x10]
    subpd xmm1, [rip+0x100]
    subpd xmm1, [0x1000]
    subpd xmm1, [r13]
    vsubpd xmm1, xmm2, [rax]
    vsubpd xmm1, xmm2, [rax+0x7f]
    vsubpd xmm1, xmm2, [rax+0x80]
    vsubpd xmm1, xmm2, [rax+rbx*4]
    vsubpd xmm1, xmm2, [rbx*8+0x10]
    vsubpd xmm1, xmm2, [rip+0x100]
    vsubpd xmm1, xmm2, [0x1000]
    vsubpd xmm1, xmm2, [r13]
    vsubpd ymm1, ymm2, [rax]
    vsubpd ymm1, ymm2, [rax+0x7f]
    vsubpd ymm1, ymm2, [rax+0x80]
    vsubpd ymm1, ymm2, [rax+rbx*4]
    vsubpd ymm1, ymm2, [rbx*8+0x10]
    vsubpd ymm1, ymm2, [rip+0x100]
    vsubpd ymm1, ymm2, [0x1000]
    vsubpd ymm1, ymm2, [r13]
    subps xmm1, [rax]
    subps xmm1, [rax+0x7f]
    subps xmm1, [rax+0x80]
    subps xmm1, [rax+rbx*4]
    subps xmm1, [rbx*8+0x10]
    subps xmm1, [rip+0x100]
    subps xmm1, [0x1000]
    subps xmm1, [r13]
    vsubps xmm1, xmm2, [rax]
    vsubps xmm1, xmm2, [rax+0x7f]
    vsubps xmm1, xmm2, [rax+0x80]
    vsubps xmm1, xmm2, [rax+rbx*4]
    vsubps xmm1, xmm2, [rbx*8+0x10]
    vsubps xmm1, xmm2, [rip+0x100]
    vsubps xmm1, xmm2, [0x1000]
    vsubps xmm1, xmm2, [r13]
    vsubps ymm1, ymm2, [rax]
    vsubps ymm1, ymm2, [rax+0x7f]
    vsubps ymm1, ymm2, [rax+0x80]
    vsubps ymm1, ymm2, [rax+rbx*4]
    vsubps ymm1, ymm2, [rbx*8+0x10]
    vsubps ymm1, ymm2, [rip+0x100]
    vsubps ymm1, ymm2, [0x1000]
    vsubps ymm1, ymm2, [r13]
    subsd xmm1, QWORD PTR [rax]
    subsd xmm1, QWORD PTR [rax+0x7f]
    subsd xmm1, QWORD PTR [rax+0x80]
    subsd xmm1, QWORD PTR [rax+rbx*4]
    subsd xmm1, QWORD PTR [rbx*8+0x10]
    subsd xmm1, QWORD PTR [rip+0x100]
    subsd xmm1, QWORD PTR [0x1000]
    subsd xmm1, QWORD PTR [r13]
    vsubsd xmm1, xmm2, QWORD PTR [rax]
    vsubsd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vsubsd xmm1, xmm2, QWORD PTR [rax+0x80]
    vsubsd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vsubsd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vsubsd xmm1, xmm2, QWORD PTR [rip+0x100]
    vsubsd xmm1, xmm2, QWORD PTR [0x1000]
    vsubsd xmm1, xmm2, QWORD PTR [r13]
    subss xmm1, DWORD PTR [rax]
    subss xmm1, DWORD PTR [rax+0x7f]
    subss xmm1, DWORD PTR [rax+0x80]
    subss xmm1, DWORD PTR [rax+rbx*4]
    subss xmm1, DWORD PTR [rbx*8+0x10]
    subss xmm1, DWORD PTR [rip+0x100]
    subss xmm1, DWORD PTR [0x1000]
    subss xmm1, DWORD PTR [r13]
    vsubss xmm1, xmm2, DWORD PTR [rax]
    vsubss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vsubss xmm1, xmm2, DWORD PTR [rax+0x80]
    vsubss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vsubss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vsubss xmm1, xmm2, DWORD PTR [rip+0x100]
    vsubss xmm1, xmm2, DWORD PTR [0x1000]
    vsubss xmm1, xmm2, DWORD PTR [r13]
    test BYTE PTR [rax], 0x1
    test BYTE PTR [rax+0x7f], 0x1
    test BYTE PTR [rax+0x80], 0x1
    test BYTE PTR [rax+rbx*4], 0x1
    test BYTE PTR [rbx*8+0x10], 0x1
    test BYTE PTR [rip+0x100], 0x1
    test BYTE PTR [0x1000], 0x1
    test BYTE PTR [r13], 0x1
    test WORD PTR [rax], 0x1
    test WORD PTR [rax+0x7f], 0x1
    test WORD PTR [rax+0x80], 0x1
    test WORD PTR [rax+rbx*4], 0x1
    test WORD PTR [rbx*8+0x10], 0x1
    test WORD PTR [rip+0x100], 0x1
    test WORD PTR [0x1000], 0x1
    test WORD PTR [r13], 0x1
    test DWORD PTR [rax], 0x1
    test DWORD PTR [rax+0x7f], 0x1
    test DWORD PTR [rax+0x80], 0x1
    test DWORD PTR [rax+rbx*4], 0x1
    test DWORD PTR [rbx*8+0x10], 0x1
    test DWORD PTR [rip+0x100], 0x1
    test DWORD PTR [0x1000], 0x1
    test DWORD PTR [r13], 0x1
    test QWORD PTR [rax], 0x1
    test QWORD PTR [rax+0x7f], 0x1
    test QWORD PTR [rax+0x80], 0x1
    test QWORD PTR [rax+rbx*4], 0x1
    test QWORD PTR [rbx*8+0x10], 0x1
    test QWORD PTR [rip+0x100], 0x1
    test QWORD PTR [0x1000], 0x1
    test QWORD PTR [r13], 0x1
    test BYTE PTR [rax], al
    test BYTE PTR [rax+0x7f], al
    test BYTE PTR [rax+0x80], al
    test BYTE PTR [rax+rbx*4], al
    test BYTE PTR [rbx*8+0x10], al
    test BYTE PTR [rip+0x100], al
    test BYTE PTR [0x1000], al
    test BYTE PTR [r13], al
    test WORD PTR [rax], ax
    test WORD PTR [rax+0x7f], ax
    test WORD PTR [rax+0x80], ax
    test WORD PTR [rax+rbx*4], ax
    test WORD PTR [rbx*8+0x10], ax
    test WORD PTR [rip+0x100], ax
    test WORD PTR [0x1000], ax
    test WORD PTR [r13], ax
    test DWORD PTR [rax], eax
    test DWORD PTR [rax+0x7f], eax
    test DWORD PTR [rax+0x80], eax
    test DWORD PTR [rax+rbx*4], eax
    test DWORD PTR [rbx*8+0x10], eax
    test DWORD PTR [rip+0x100], eax
    test DWORD PTR [0x1000], eax
    test DWORD PTR [r13], eax
    test QWORD PTR [rax], rax
    test QWORD PTR [rax+0x7f], rax
    test QWORD PTR [rax+0x80], rax
    test QWORD PTR [rax+rbx*4], rax
    test QWORD PTR [rbx*8+0x10], rax
    test QWORD PTR [rip+0x100], rax
    test QWORD PTR [0x1000], rax
    test QWORD PTR [r13], rax
    tzcnt ax, WORD PTR [rax]
    tzcnt ax, WORD PTR [rax+0x7f]
    tzcnt ax, WORD PTR [rax+0x80]
    tzcnt ax, WORD PTR [rax+rbx*4]
    tzcnt ax, WORD PTR [rbx*8+0x10]
    tzcnt ax, WORD PTR [rip+0x100]
    tzcnt ax, WORD PTR [0x1000]
    tzcnt ax, WORD PTR [r13]
    tzcnt eax, DWORD PTR [rax]
    tzcnt eax, DWORD PTR [rax+0x7f]
    tzcnt eax, DWORD PTR [rax+0x80]
    tzcnt eax, DWORD PTR [rax+rbx*4]
    tzcnt eax, DWORD PTR [rbx*8+0x10]
    tzcnt eax, DWORD PTR [rip+0x100]
    tzcnt eax, DWORD PTR [0x1000]
    tzcnt eax, DWORD PTR [r13]
    tzcnt rax, QWORD PTR [rax]
    tzcnt rax, QWORD PTR [rax+0x7f]
    tzcnt rax, QWORD PTR [rax+0x80]
    tzcnt rax, QWORD PTR [rax+rbx*4]
    tzcnt rax, QWORD PTR [rbx*8+0x10]
    tzcnt rax, QWORD PTR [rip+0x100]
    tzcnt rax, QWORD PTR [0x1000]
    tzcnt rax, QWORD PTR [r13]
    ucomisd xmm1, QWORD PTR [rax]
    ucomisd xmm1, QWORD PTR [rax+0x7f]
    ucomisd xmm1, QWORD PTR [rax+0x80]
    ucomisd xmm1, QWORD PTR [rax+rbx*4]
    ucomisd xmm1, QWORD PTR [rbx*8+0x10]
    ucomisd xmm1, QWORD PTR [rip+0x100]
    ucomisd xmm1, QWORD PTR [0x1000]
    ucomisd xmm1, QWORD PTR [r13]
    vucomisd xmm1, QWORD PTR [rax]
    vucomisd xmm1, QWORD PTR [rax+0x7f]
    vucomisd xmm1, QWORD PTR [rax+0x80]
    vucomisd xmm1, QWORD PTR [rax+rbx*4]
    vucomisd xmm1, QWORD PTR [rbx*8+0x10]
    vucomisd xmm1, QWORD PTR [rip+0x100]
    vucomisd xmm1, QWORD PTR [0x1000]
    vucomisd xmm1, QWORD PTR [r13]
    ucomiss xmm1, DWORD PTR [rax]
    ucomiss xmm1, DWORD PTR [rax+0x7f]
    ucomiss xmm1, DWORD PTR [rax+0x80]
    ucomiss xmm1, DWORD PTR [rax+rbx*4]
    ucomiss xmm1, DWORD PTR [rbx*8+0x10]
    ucomiss xmm1, DWORD PTR [rip+0x100]
    ucomiss xmm1, DWORD PTR [0x1000]
    ucomiss xmm1, DWORD PTR [r13]
    vucomiss xmm1, DWORD PTR [rax]
    vucomiss xmm1, DWORD PTR [rax+0x7f]
    vucomiss xmm1, DWORD PTR [rax+0x80]
    vucomiss xmm1, DWORD PTR [rax+rbx*4]
    vucomiss xmm1, DWORD PTR [rbx*8+0x10]
    vucomiss xmm1, DWORD PTR [rip+0x100]
    vucomiss xmm1, DWORD PTR [0x1000]
    vucomiss xmm1, DWORD PTR [r13]
    ud01 eax, DWORD PTR [rax]
    ud01 eax, DWORD PTR [rax+0x7f]
    ud01 eax, DWORD PTR [rax+0x80]
    ud01 eax, DWORD PTR [rax+rbx*4]
    ud01 eax, DWORD PTR [rbx*8+0x10]
    ud01 eax, DWORD PTR [rip+0x100]
    ud01 eax, DWORD PTR [0x1000]
    ud01 eax, DWORD PTR [r13]
    ud1 eax, DWORD PTR [rax]
    ud1 eax, DWORD PTR [rax+0x7f]
    ud1 eax, DWORD PTR [rax+0x80]
    ud1 eax, DWORD PTR [rax+rbx*4]
    ud1 eax, DWORD PTR [rbx*8+0x10]
    ud1 eax, DWORD PTR [rip+0x100]
    ud1 eax, DWORD PTR [0x1000]
    ud1 eax, DWORD PTR [r13]
    unpckhpd xmm1, [rax]
    unpckhpd xmm1, [rax+0x7f]
    unpckhpd xmm1, [rax+0x80]
    unpckhpd xmm1, [rax+rbx*4]
    unpckhpd xmm1, [rbx*8+0x10]
    unpckhpd xmm1, [rip+0x100]
    unpckhpd xmm1, [0x1000]
    unpckhpd xmm1, [r13]
    vunpckhpd xmm1, xmm2, [rax]
    vunpckhpd xmm1, xmm2, [rax+0x7f]
    vunpckhpd xmm1, xmm2, [rax+0x80]
    vunpckhpd xmm1, xmm2, [rax+rbx*4]
    vunpckhpd xmm1, xmm2, [rbx*8+0x10]
    vunpckhpd xmm1, xmm2, [rip+0x100]
    vunpckhpd xmm1, xmm2, [0x1000]
    vunpckhpd xmm1, xmm2, [r13]
    vunpckhpd ymm1, ymm2, [rax]
    vunpckhpd ymm1, ymm2, [rax+0x7f]
    vunpckhpd ymm1, ymm2, [rax+0x80]
    vunpckhpd ymm1, ymm2, [rax+rbx*4]
    vunpckhpd ymm1, ymm2, [rbx*8+0x10]
    vunpckhpd ymm1, ymm2, [rip+0x100]
    vunpckhpd ymm1, ymm2, [0x1000]
    vunpckhpd ymm1, ymm2, [r13]
    unpckhps xmm1, [rax]
    unpckhps xmm1, [rax+0x7f]
    unpckhps xmm1, [rax+0x80]
    unpckhps xmm1, [rax+rbx*4]
    unpckhps xmm1, [rbx*8+0x10]
    unpckhps xmm1, [rip+0x100]
    unpckhps xmm1, [0x1000]
    unpckhps xmm1, [r13]
    vunpckhps xmm1, xmm2, [rax]
    vunpckhps xmm1, xmm2, [rax+0x7f]
    vunpckhps xmm1, xmm2, [rax+0x80]
    vunpckhps xmm1, xmm2, [rax+rbx*4]
    vunpckhps xmm1, xmm2, [rbx*8+0x10]
    vunpckhps xmm1, xmm2, [rip+0x100]
    vunpckhps xmm1, xmm2, [0x1000]
    vunpckhps xmm1, xmm2, [r13]
    vunpckhps ymm1, ymm2, [rax]
    vunpckhps ymm1, ymm2, [rax+0x7f]
    vunpckhps ymm1, ymm2, [rax+0x80]
    vunpckhps ymm1, ymm2, [rax+rbx*4]
    vunpckhps ymm1, ymm2, [rbx*8+0x10]
    vunpckhps ymm1, ymm2, [rip+0x100]
    vunpckhps ymm1, ymm2, [0x1000]
    vunpckhps ymm1, ymm2, [r13]
    unpcklpd xmm1, [rax]
    unpcklpd xmm1, [rax+0x7f]
    unpcklpd xmm1, [rax+0x80]
    unpcklpd xmm1, [rax+rbx*4]
    unpcklpd xmm1, [rbx*8+0x10]
    unpcklpd xmm1, [rip+0x100]
    unpcklpd xmm1, [0x1000]
    unpcklpd xmm1, [r13]
    vunpcklpd xmm1, xmm2, [rax]
    vunpcklpd xmm1, xmm2, [rax+0x7f]
    vunpcklpd xmm1, xmm2, [rax+0x80]
    vunpcklpd xmm1, xmm2, [rax+rbx*4]
    vunpcklpd xmm1, xmm2, [rbx*8+0x10]
    vunpcklpd xmm1, xmm2, [rip+0x100]
    vunpcklpd xmm1, xmm2, [0x1000]
    vunpcklpd xmm1, xmm2, [r13]
    vunpcklpd ymm1, ymm2, [rax]
    vunpcklpd ymm1, ymm2, [rax+0x7f]
    vunpcklpd ymm1, ymm2, [rax+0x80]
    vunpcklpd ymm1, ymm2, [rax+rbx*4]
    vunpcklpd ymm1, ymm2, [rbx*8+0x10]
    vunpcklpd ymm1, ymm2, [rip+0x100]
    vunpcklpd ymm1, ymm2, [0x1000]
    vunpcklpd ymm1, ymm2, [r13]
    unpcklps xmm1, [rax]
    unpcklps xmm1, [rax+0x7f]
    unpcklps xmm1, [rax+0x80]
    unpcklps xmm1, [rax+rbx*4]
    unpcklps xmm1, [rbx*8+0x10]
    unpcklps xmm1, [rip+0x100]
    unpcklps xmm1, [0x1000]
    unpcklps xmm1, [r13]
    vunpcklps xmm1, xmm2, [rax]
    vunpcklps xmm1, xmm2, [rax+0x7f]
    vunpcklps xmm1, xmm2, [rax+0x80]
    vunpcklps xmm1, xmm2, [rax+rbx*4]
    vunpcklps xmm1, xmm2, [rbx*8+0x10]
    vunpcklps xmm1, xmm2, [rip+0x100]
    vunpcklps xmm1, xmm2, [0x1000]
    vunpcklps xmm1, xmm2, [r13]
    vunpcklps ymm1, ymm2, [rax]
    vunpcklps ymm1, ymm2, [rax+0x7f]
    vunpcklps ymm1, ymm2, [rax+0x80]
    vunpcklps ymm1, ymm2, [rax+rbx*4]
    vunpcklps ymm1, ymm2, [rbx*8+0x10]
    vunpcklps ymm1, ymm2, [rip+0x100]
    vunpcklps ymm1, ymm2, [0x1000]
    vunpcklps ymm1, ymm2, [r13]
    vbcstnebf162ps xmm1, WORD PTR [rax]
    vbcstnebf162ps xmm1, WORD PTR [rax+0x7f]
    vbcstnebf162ps xmm1, WORD PTR [rax+0x80]
    vbcstnebf162ps xmm1, WORD PTR [rax+rbx*4]
    vbcstnebf162ps xmm1, WORD PTR [rbx*8+0x10]
    vbcstnebf162ps xmm1, WORD PTR [rip+0x100]
    vbcstnebf162ps xmm1, WORD PTR [0x1000]
    vbcstnebf162ps xmm1, WORD PTR [r13]
    vbcstnebf162ps ymm1, WORD PTR [rax]
    vbcstnebf162ps ymm1, WORD PTR [rax+0x7f]
    vbcstnebf162ps ymm1, WORD PTR [rax+0x80]
    vbcstnebf162ps ymm1, WORD PTR [rax+rbx*4]
    vbcstnebf162ps ymm1, WORD PTR [rbx*8+0x10]
    vbcstnebf162ps ymm1, WORD PTR [rip+0x100]
    vbcstnebf162ps ymm1, WORD PTR [0x1000]
    vbcstnebf162ps ymm1, WORD PTR [r13]
    vbcstnesh2ps xmm1, WORD PTR [rax]
    vbcstnesh2ps xmm1, WORD PTR [rax+0x7f]
    vbcstnesh2ps xmm1, WORD PTR [rax+0x80]
    vbcstnesh2ps xmm1, WORD PTR [rax+rbx*4]
    vbcstnesh2ps xmm1, WORD PTR [rbx*8+0x10]
    vbcstnesh2ps xmm1, WORD PTR [rip+0x100]
    vbcstnesh2ps xmm1, WORD PTR [0x1000]
    vbcstnesh2ps xmm1, WORD PTR [r13]
    vbcstnesh2ps ymm1, WORD PTR [rax]
    vbcstnesh2ps ymm1, WORD PTR [rax+0x7f]
    vbcstnesh2ps ymm1, WORD PTR [rax+0x80]
    vbcstnesh2ps ymm1, WORD PTR [rax+rbx*4]
    vbcstnesh2ps ymm1, WORD PTR [rbx*8+0x10]
    vbcstnesh2ps ymm1, WORD PTR [rip+0x100]
    vbcstnesh2ps ymm1, WORD PTR [0x1000]
    vbcstnesh2ps ymm1, WORD PTR [r13]
    vbroadcastss xmm1, DWORD PTR [rax]
    vbroadcastss xmm1, DWORD PTR [rax+0x7f]
    vbroadcastss xmm1, DWORD PTR [rax+0x80]
    vbroadcastss xmm1, DWORD PTR [rax+rbx*4]
    vbroadcastss xmm1, DWORD PTR [rbx*8+0x10]
    vbroadcastss xmm1, DWORD PTR [rip+0x100]
    vbroadcastss xmm1, DWORD PTR [0x1000]
    vbroadcastss xmm1, DWORD PTR [r13]
    vbroadcastss ymm1, DWORD PTR [rax]
    vbroadcastss ymm1, DWORD PTR [rax+0x7f]
    vbroadcastss ymm1, DWORD PTR [rax+0x80]
    vbroadcastss ymm1, DWORD PTR [rax+rbx*4]
    vbroadcastss ymm1, DWORD PTR [rbx*8+0x10]
    vbroadcastss ymm1, DWORD PTR [rip+0x100]
    vbroadcastss ymm1, DWORD PTR [0x1000]
    vbroadcastss ymm1, DWORD PTR [r13]
    vbroadcastsd ymm1, QWORD PTR [rax]
    vbroadcastsd ymm1, QWORD PTR [rax+0x7f]
    vbroadcastsd ymm1, QWORD PTR [rax+0x80]
    vbroadcastsd ymm1, QWORD PTR [rax+rbx*4]
    vbroadcastsd ymm1, QWORD PTR [rbx*8+0x10]
    vbroadcastsd ymm1, QWORD PTR [rip+0x100]
    vbroadcastsd ymm1, QWORD PTR [0x1000]
    vbroadcastsd ymm1, QWORD PTR [r13]
    vbroadcastf128 ymm1, [rax]
    vbroadcastf128 ymm1, [rax+0x7f]
    vbroadcastf128 ymm1, [rax+0x80]
    vbroadcastf128 ymm1, [rax+rbx*4]
    vbroadcastf128 ymm1, [rbx*8+0x10]
    vbroadcastf128 ymm1, [rip+0x100]
    vbroadcastf128 ymm1, [0x1000]
    vbroadcastf128 ymm1, [r13]
    vcvtneebf162ps xmm1, [rax]
    vcvtneebf162ps xmm1, [rax+0x7f]
    vcvtneebf162ps xmm1, [rax+0x80]
    vcvtneebf162ps xmm1, [rax+rbx*4]
    vcvtneebf162ps xmm1, [rbx*8+0x10]
    vcvtneebf162ps xmm1, [rip+0x100]
    vcvtneebf162ps xmm1, [0x1000]
    vcvtneebf162ps xmm1, [r13]
    vcvtneebf162ps ymm1, [rax]
    vcvtneebf162ps ymm1, [rax+0x7f]
    vcvtneebf162ps ymm1, [rax+0x80]
    vcvtneebf162ps ymm1, [rax+rbx*4]
    vcvtneebf162ps ymm1, [rbx*8+0x10]
    vcvtneebf162ps ymm1, [rip+0x100]
    vcvtneebf162ps ymm1, [0x1000]
    vcvtneebf162ps ymm1, [r13]
    vcvtneeph2ps xmm1, [rax]
    vcvtneeph2ps xmm1, [rax+0x7f]
    vcvtneeph2ps xmm1, [rax+0x80]
    vcvtneeph2ps xmm1, [rax+rbx*4]
    vcvtneeph2ps xmm1, [rbx*8+0x10]
    vcvtneeph2ps xmm1, [rip+0x100]
    vcvtneeph2ps xmm1, [0x1000]
    vcvtneeph2ps xmm1, [r13]
    vcvtneeph2ps ymm1, [rax]
    vcvtneeph2ps ymm1, [rax+0x7f]
    vcvtneeph2ps ymm1, [rax+0x80]
    vcvtneeph2ps ymm1, [rax+rbx*4]
    vcvtneeph2ps ymm1, [rbx*8+0x10]
    vcvtneeph2ps ymm1, [rip+0x100]
    vcvtneeph2ps ymm1, [0x1000]
    vcvtneeph2ps ymm1, [r13]
    vcvtneobf162ps xmm1, [rax]
    vcvtneobf162ps xmm1, [rax+0x7f]
    vcvtneobf162ps xmm1, [rax+0x80]
    vcvtneobf162ps xmm1, [rax+rbx*4]
    vcvtneobf162ps xmm1, [rbx*8+0x10]
    vcvtneobf162ps xmm1, [rip+0x100]
    vcvtneobf162ps xmm1, [0x1000]
    vcvtneobf162ps xmm1, [r13]
    vcvtneobf162ps ymm1, [rax]
    vcvtneobf162ps ymm1, [rax+0x7f]
    vcvtneobf162ps ymm1, [rax+0x80]
    vcvtneobf162ps ymm1, [rax+rbx*4]
    vcvtneobf162ps ymm1, [rbx*8+0x10]
    vcvtneobf162ps ymm1, [rip+0x100]
    vcvtneobf162ps ymm1, [0x1000]
    vcvtneobf162ps ymm1, [r13]
    vcvtneoph2ps xmm1, [rax]
    vcvtneoph2ps xmm1, [rax+0x7f]
    vcvtneoph2ps xmm1, [rax+0x80]
    vcvtneoph2ps xmm1, [rax+rbx*4]
    vcvtneoph2ps xmm1, [rbx*8+0x10]
    vcvtneoph2ps xmm1, [rip+0x100]
    vcvtneoph2ps xmm1, [0x1000]
    vcvtneoph2ps xmm1, [r13]
    vcvtneoph2ps ymm1, [rax]
    vcvtneoph2ps ymm1, [rax+0x7f]
    vcvtneoph2ps ymm1, [rax+0x80]
    vcvtneoph2ps ymm1, [rax+rbx*4]
    vcvtneoph2ps ymm1, [rbx*8+0x10]
    vcvtneoph2ps ymm1, [rip+0x100]
    vcvtneoph2ps ymm1, [0x1000]
    vcvtneoph2ps ymm1, [r13]
    vcvtneps2bf16 xmm1, [rax]
    vcvtneps2bf16 xmm1, [rax+0x7f]
    vcvtneps2bf16 xmm1, [rax+0x80]
    vcvtneps2bf16 xmm1, [rax+rbx*4]
    vcvtneps2bf16 xmm1, [rbx*8+0x10]
    vcvtneps2bf16 xmm1, [rip+0x100]
    vcvtneps2bf16 xmm1, [0x1000]
    vcvtneps2bf16 xmm1, [r13]
    vcvtph2ps xmm1, QWORD PTR [rax]
    vcvtph2ps xmm1, QWORD PTR [rax+0x7f]
    vcvtph2ps xmm1, QWORD PTR [rax+0x80]
    vcvtph2ps xmm1, QWORD PTR [rax+rbx*4]
    vcvtph2ps xmm1, QWORD PTR [rbx*8+0x10]
    vcvtph2ps xmm1, QWORD PTR [rip+0x100]
    vcvtph2ps xmm1, QWORD PTR [0x1000]
    vcvtph2ps xmm1, QWORD PTR [r13]
    vcvtph2ps ymm1, [rax]
    vcvtph2ps ymm1, [rax+0x7f]
    vcvtph2ps ymm1, [rax+0x80]
    vcvtph2ps ymm1, [rax+rbx*4]
    vcvtph2ps ymm1, [rbx*8+0x10]
    vcvtph2ps ymm1, [rip+0x100]
    vcvtph2ps ymm1, [0x1000]
    vcvtph2ps ymm1, [r13]
    vcvtps2ph QWORD PTR [rax], xmm2, 0x1
    vcvtps2ph QWORD PTR [rax+0x7f], xmm2, 0x1
    vcvtps2ph QWORD PTR [rax+0x80], xmm2, 0x1
    vcvtps2ph QWORD PTR [rax+rbx*4], xmm2, 0x1
    vcvtps2ph QWORD PTR [rbx*8+0x10], xmm2, 0x1
    vcvtps2ph QWORD PTR [rip+0x100], xmm2, 0x1
    vcvtps2ph QWORD PTR [0x1000], xmm2, 0x1
    vcvtps2ph QWORD PTR [r13], xmm2, 0x1
    vcvtps2ph [rax], ymm2, 0x1
    vcvtps2ph [rax+0x7f], ymm2, 0x1
    vcvtps2ph [rax+0x80], ymm2, 0x1
    vcvtps2ph [rax+rbx*4], ymm2, 0x1
    vcvtps2ph [rbx*8+0x10], ymm2, 0x1
    vcvtps2ph [rip+0x100], ymm2, 0x1
    vcvtps2ph [0x1000], ymm2, 0x1
    vcvtps2ph [r13], ymm2, 0x1
    verr WORD PTR [rax]
    verr WORD PTR [rax+0x7f]
    verr WORD PTR [rax+0x80]
    verr WORD PTR [rax+rbx*4]
    verr WORD PTR [rbx*8+0x10]
    verr WORD PTR [rip+0x100]
    verr WORD PTR [0x1000]
    verr WORD PTR [r13]
    verw WORD PTR [rax]
    verw WORD PTR [rax+0x7f]
    verw WORD PTR [rax+0x80]
    verw WORD PTR [rax+rbx*4]
    verw WORD PTR [rbx*8+0x10]
    verw WORD PTR [rip+0x100]
    verw WORD PTR [0x1000]
    verw WORD PTR [r13]
    vextractf128 [rax], ymm2, 0x1
    vextractf128 [rax+0x7f], ymm2, 0x1
    vextractf128 [rax+0x80], ymm2, 0x1
    vextractf128 [rax+rbx*4], ymm2, 0x1
    vextractf128 [rbx*8+0x10], ymm2, 0x1
    vextractf128 [rip+0x100], ymm2, 0x1
    vextractf128 [0x1000], ymm2, 0x1
    vextractf128 [r13], ymm2, 0x1
    vextracti128 [rax], ymm2, 0x1
    vextracti128 [rax+0x7f], ymm2, 0x1
    vextracti128 [rax+0x80], ymm2, 0x1
    vextracti128 [rax+rbx*4], ymm2, 0x1
    vextracti128 [rbx*8+0x10], ymm2, 0x1
    vextracti128 [rip+0x100], ymm2, 0x1
    vextracti128 [0x1000], ymm2, 0x1
    vextracti128 [r13], ymm2, 0x1
    vfmadd132pd xmm1, xmm2, [rax]
    vfmadd132pd xmm1, xmm2, [rax+0x7f]
    vfmadd132pd xmm1, xmm2, [rax+0x80]
    vfmadd132pd xmm1, xmm2, [rax+rbx*4]
    vfmadd132pd xmm1, xmm2, [rbx*8+0x10]
    vfmadd132pd xmm1, xmm2, [rip+0x100]
    vfmadd132pd xmm1, xmm2, [0x1000]
    vfmadd132pd xmm1, xmm2, [r13]
    vfmadd213pd xmm1, xmm2, [rax]
    vfmadd213pd xmm1, xmm2, [rax+0x7f]
    vfmadd213pd xmm1, xmm2, [rax+0x80]
    vfmadd213pd xmm1, xmm2, [rax+rbx*4]
    vfmadd213pd xmm1, xmm2, [rbx*8+0x10]
    vfmadd213pd xmm1, xmm2, [rip+0x100]
    vfmadd213pd xmm1, xmm2, [0x1000]
    vfmadd213pd xmm1, xmm2, [r13]
    vfmadd231pd xmm1, xmm2, [rax]
    vfmadd231pd xmm1, xmm2, [rax+0x7f]
    vfmadd231pd xmm1, xmm2, [rax+0x80]
    vfmadd231pd xmm1, xmm2, [rax+rbx*4]
    vfmadd231pd xmm1, xmm2, [rbx*8+0x10]
    vfmadd231pd xmm1, xmm2, [rip+0x100]
    vfmadd231pd xmm1, xmm2, [0x1000]
    vfmadd231pd xmm1, xmm2, [r13]
    vfmadd132pd ymm1, ymm2, [rax]
    vfmadd132pd ymm1, ymm2, [rax+0x7f]
    vfmadd132pd ymm1, ymm2, [rax+0x80]
    vfmadd132pd ymm1, ymm2, [rax+rbx*4]
    vfmadd132pd ymm1, ymm2, [rbx*8+0x10]
    vfmadd132pd ymm1, ymm2, [rip+0x100]
    vfmadd132pd ymm1, ymm2, [0x1000]
    vfmadd132pd ymm1, ymm2, [r13]
    vfmadd213pd ymm1, ymm2, [rax]
    vfmadd213pd ymm1, ymm2, [rax+0x7f]
    vfmadd213pd ymm1, ymm2, [rax+0x80]
    vfmadd213pd ymm1, ymm2, [rax+rbx*4]
    vfmadd213pd ymm1, ymm2, [rbx*8+0x10]
    vfmadd213pd ymm1, ymm2, [rip+0x100]
    vfmadd213pd ymm1, ymm2, [0x1000]
    vfmadd213pd ymm1, ymm2, [r13]
    vfmadd231pd ymm1, ymm2, [rax]
    vfmadd231pd ymm1, ymm2, [rax+0x7f]
    vfmadd231pd ymm1, ymm2, [rax+0x80]
    vfmadd231pd ymm1, ymm2, [rax+rbx*4]
    vfmadd231pd ymm1, ymm2, [rbx*8+0x10]
    vfmadd231pd ymm1, ymm2, [rip+0x100]
    vfmadd231pd ymm1, ymm2, [0x1000]
    vfmadd231pd ymm1, ymm2, [r13]
    vfmadd132ps xmm1, xmm2, [rax]
    vfmadd132ps xmm1, xmm2, [rax+0x7f]
    vfmadd132ps xmm1, xmm2, [rax+0x80]
    vfmadd132ps xmm1, xmm2, [rax+rbx*4]
    vfmadd132ps xmm1, xmm2, [rbx*8+0x10]
    vfmadd132ps xmm1, xmm2, [rip+0x100]
    vfmadd132ps xmm1, xmm2, [0x1000]
    vfmadd132ps xmm1, xmm2, [r13]
    vfmadd213ps xmm1, xmm2, [rax]
    vfmadd213ps xmm1, xmm2, [rax+0x7f]
    vfmadd213ps xmm1, xmm2, [rax+0x80]
    vfmadd213ps xmm1, xmm2, [rax+rbx*4]
    vfmadd213ps xmm1, xmm2, [rbx*8+0x10]
    vfmadd213ps xmm1, xmm2, [rip+0x100]
    vfmadd213ps xmm1, xmm2, [0x1000]
    vfmadd213ps xmm1, xmm2, [r13]
    vfmadd231ps xmm1, xmm2, [rax]
    vfmadd231ps xmm1, xmm2, [rax+0x7f]
    vfmadd231ps xmm1, xmm2, [rax+0x80]
    vfmadd231ps xmm1, xmm2, [rax+rbx*4]
    vfmadd231ps xmm1, xmm2, [rbx*8+0x10]
    vfmadd231ps xmm1, xmm2, [rip+0x100]
    vfmadd231ps xmm1, xmm2, [0x1000]
    vfmadd231ps xmm1, xmm2, [r13]
    vfmadd132ps ymm1, ymm2, [rax]
    vfmadd132ps ymm1, ymm2, [rax+0x7f]
    vfmadd132ps ymm1, ymm2, [rax+0x80]
    vfmadd132ps ymm1, ymm2, [rax+rbx*4]
    vfmadd132ps ymm1, ymm2, [rbx*8+0x10]
    vfmadd132ps ymm1, ymm2, [rip+0x100]
    vfmadd132ps ymm1, ymm2, [0x1000]
    vfmadd132ps ymm1, ymm2, [r13]
    vfmadd213ps ymm1, ymm2, [rax]
    vfmadd213ps ymm1, ymm2, [rax+0x7f]
    vfmadd213ps ymm1, ymm2, [rax+0x80]
    vfmadd213ps ymm1, ymm2, [rax+rbx*4]
    vfmadd213ps ymm1, ymm2, [rbx*8+0x10]
    vfmadd213ps ymm1, ymm2, [rip+0x100]
    vfmadd213ps ymm1, ymm2, [0x1000]
    vfmadd213ps ymm1, ymm2, [r13]
    vfmadd231ps ymm1, ymm2, [rax]
    vfmadd231ps ymm1, ymm2, [rax+0x7f]
    vfmadd231ps ymm1, ymm2, [rax+0x80]
    vfmadd231ps ymm1, ymm2, [rax+rbx*4]
    vfmadd231ps ymm1, ymm2, [rbx*8+0x10]
    vfmadd231ps ymm1, ymm2, [rip+0x100]
    vfmadd231ps ymm1, ymm2, [0x1000]
    vfmadd231ps ymm1, ymm2, [r13]
    vfmadd132sd xmm1, xmm2, QWORD PTR [rax]
    vfmadd132sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfmadd132sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfmadd132sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfmadd132sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfmadd132sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfmadd132sd xmm1, xmm2, QWORD PTR [0x1000]
    vfmadd132sd xmm1, xmm2, QWORD PTR [r13]
    vfmadd213sd xmm1, xmm2, QWORD PTR [rax]
    vfmadd213sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfmadd213sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfmadd213sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfmadd213sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfmadd213sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfmadd213sd xmm1, xmm2, QWORD PTR [0x1000]
    vfmadd213sd xmm1, xmm2, QWORD PTR [r13]
    vfmadd231sd xmm1, xmm2, QWORD PTR [rax]
    vfmadd231sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfmadd231sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfmadd231sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfmadd231sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfmadd231sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfmadd231sd xmm1, xmm2, QWORD PTR [0x1000]
    vfmadd231sd xmm1, xmm2, QWORD PTR [r13]
    vfmadd132ss xmm1, xmm2, DWORD PTR [rax]
    vfmadd132ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfmadd132ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfmadd132ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfmadd132ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfmadd132ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfmadd132ss xmm1, xmm2, DWORD PTR [0x1000]
    vfmadd132ss xmm1, xmm2, DWORD PTR [r13]
    vfmadd213ss xmm1, xmm2, DWORD PTR [rax]
    vfmadd213ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfmadd213ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfmadd213ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfmadd213ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfmadd213ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfmadd213ss xmm1, xmm2, DWORD PTR [0x1000]
    vfmadd213ss xmm1, xmm2, DWORD PTR [r13]
    vfmadd231ss xmm1, xmm2, DWORD PTR [rax]
    vfmadd231ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfmadd231ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfmadd231ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfmadd231ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfmadd231ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfmadd231ss xmm1, xmm2, DWORD PTR [0x1000]
    vfmadd231ss xmm1, xmm2, DWORD PTR [r13]
    vfmaddsub132pd xmm1, xmm2, [rax]
    vfmaddsub132pd xmm1, xmm2, [rax+0x7f]
    vfmaddsub132pd xmm1, xmm2, [rax+0x80]
    vfmaddsub132pd xmm1, xmm2, [rax+rbx*4]
    vfmaddsub132pd xmm1, xmm2, [rbx*8+0x10]
    vfmaddsub132pd xmm1, xmm2, [rip+0x100]
    vfmaddsub132pd xmm1, xmm2, [0x1000]
    vfmaddsub132pd xmm1, xmm2, [r13]
    vfmaddsub213pd xmm1, xmm2, [rax]
    vfmaddsub213pd xmm1, xmm2, [rax+0x7f]
    vfmaddsub213pd xmm1, xmm2, [rax+0x80]
    vfmaddsub213pd xmm1, xmm2, [rax+rbx*4]
    vfmaddsub213pd xmm1, xmm2, [rbx*8+0x10]
    vfmaddsub213pd xmm1, xmm2, [rip+0x100]
    vfmaddsub213pd xmm1, xmm2, [0x1000]
    vfmaddsub213pd xmm1, xmm2, [r13]
    vfmaddsub231pd xmm1, xmm2, [rax]
    vfmaddsub231pd xmm1, xmm2, [rax+0x7f]
    vfmaddsub231pd xmm1, xmm2, [rax+0x80]
    vfmaddsub231pd xmm1, xmm2, [rax+rbx*4]
    vfmaddsub231pd xmm1, xmm2, [rbx*8+0x10]
    vfmaddsub231pd xmm1, xmm2, [rip+0x100]
    vfmaddsub231pd xmm1, xmm2, [0x1000]
    vfmaddsub231pd xmm1, xmm2, [r13]
    vfmaddsub132pd ymm1, ymm2, [rax]
    vfmaddsub132pd ymm1, ymm2, [rax+0x7f]
    vfmaddsub132pd ymm1, ymm2, [rax+0x80]
    vfmaddsub132pd ymm1, ymm2, [rax+rbx*4]
    vfmaddsub132pd ymm1, ymm2, [rbx*8+0x10]
    vfmaddsub132pd ymm1, ymm2, [rip+0x100]
    vfmaddsub132pd ymm1, ymm2, [0x1000]
    vfmaddsub132pd ymm1, ymm2, [r13]
    vfmaddsub213pd ymm1, ymm2, [rax]
    vfmaddsub213pd ymm1, ymm2, [rax+0x7f]
    vfmaddsub213pd ymm1, ymm2, [rax+0x80]
    vfmaddsub213pd ymm1, ymm2, [rax+rbx*4]
    vfmaddsub213pd ymm1, ymm2, [rbx*8+0x10]
    vfmaddsub213pd ymm1, ymm2, [rip+0x100]
    vfmaddsub213pd ymm1, ymm2, [0x1000]
    vfmaddsub213pd ymm1, ymm2, [r13]
    vfmaddsub231pd ymm1, ymm2, [rax]
    vfmaddsub231pd ymm1, ymm2, [rax+0x7f]
    vfmaddsub231pd ymm1, ymm2, [rax+0x80]
    vfmaddsub231pd ymm1, ymm2, [rax+rbx*4]
    vfmaddsub231pd ymm1, ymm2, [rbx*8+0x10]
    vfmaddsub231pd ymm1, ymm2, [rip+0x100]
    vfmaddsub231pd ymm1, ymm2, [0x1000]
    vfmaddsub231pd ymm1, ymm2, [r13]
    vfmaddsub132ps xmm1, xmm2, [rax]
    vfmaddsub132ps xmm1, xmm2, [rax+0x7f]
    vfmaddsub132ps xmm1, xmm2, [rax+0x80]
    vfmaddsub132ps xmm1, xmm2, [rax+rbx*4]
    vfmaddsub132ps xmm1, xmm2, [rbx*8+0x10]
    vfmaddsub132ps xmm1, xmm2, [rip+0x100]
    vfmaddsub132ps xmm1, xmm2, [0x1000]
    vfmaddsub132ps xmm1, xmm2, [r13]
    vfmaddsub213ps xmm1, xmm2, [rax]
    vfmaddsub213ps xmm1, xmm2, [rax+0x7f]
    vfmaddsub213ps xmm1, xmm2, [rax+0x80]
    vfmaddsub213ps xmm1, xmm2, [rax+rbx*4]
    vfmaddsub213ps xmm1, xmm2, [rbx*8+0x10]
    vfmaddsub213ps xmm1, xmm2, [rip+0x100]
    vfmaddsub213ps xmm1, xmm2, [0x1000]
    vfmaddsub213ps xmm1, xmm2, [r13]
    vfmaddsub231ps xmm1, xmm2, [rax]
    vfmaddsub231ps xmm1, xmm2, [rax+0x7f]
    vfmaddsub231ps xmm1, xmm2, [rax+0x80]
    vfmaddsub231ps xmm1, xmm2, [rax+rbx*4]
    vfmaddsub231ps xmm1, xmm2, [rbx*8+0x10]
    vfmaddsub231ps xmm1, xmm2, [rip+0x100]
    vfmaddsub231ps xmm1, xmm2, [0x1000]
    vfmaddsub231ps xmm1, xmm2, [r13]
    vfmaddsub132ps ymm1, ymm2, [rax]
    vfmaddsub132ps ymm1, ymm2, [rax+0x7f]
    vfmaddsub132ps ymm1, ymm2, [rax+0x80]
    vfmaddsub132ps ymm1, ymm2, [rax+rbx*4]
    vfmaddsub132ps ymm1, ymm2, [rbx*8+0x10]
    vfmaddsub132ps ymm1, ymm2, [rip+0x100]
    vfmaddsub132ps ymm1, ymm2, [0x1000]
    vfmaddsub132ps ymm1, ymm2, [r13]
    vfmaddsub213ps ymm1, ymm2, [rax]
    vfmaddsub213ps ymm1, ymm2, [rax+0x7f]
    vfmaddsub213ps ymm1, ymm2, [rax+0x80]
    vfmaddsub213ps ymm1, ymm2, [rax+rbx*4]
    vfmaddsub213ps ymm1, ymm2, [rbx*8+0x10]
    vfmaddsub213ps ymm1, ymm2, [rip+0x100]
    vfmaddsub213ps ymm1, ymm2, [0x1000]
    vfmaddsub213ps ymm1, ymm2, [r13]
    vfmaddsub231ps ymm1, ymm2, [rax]
    vfmaddsub231ps ymm1, ymm2, [rax+0x7f]
    vfmaddsub231ps ymm1, ymm2, [rax+0x80]
    vfmaddsub231ps ymm1, ymm2, [rax+rbx*4]
    vfmaddsub231ps ymm1, ymm2, [rbx*8+0x10]
    vfmaddsub231ps ymm1, ymm2, [rip+0x100]
    vfmaddsub231ps ymm1, ymm2, [0x1000]
    vfmaddsub231ps ymm1, ymm2, [r13]
    vfmsub132pd xmm1, xmm2, [rax]
    vfmsub132pd xmm1, xmm2, [rax+0x7f]
    vfmsub132pd xmm1, xmm2, [rax+0x80]
    vfmsub132pd xmm1, xmm2, [rax+rbx*4]
    vfmsub132pd xmm1, xmm2, [rbx*8+0x10]
    vfmsub132pd xmm1, xmm2, [rip+0x100]
    vfmsub132pd xmm1, xmm2, [0x1000]
    vfmsub132pd xmm1, xmm2, [r13]
    vfmsub213pd xmm1, xmm2, [rax]
    vfmsub213pd xmm1, xmm2, [rax+0x7f]
    vfmsub213pd xmm1, xmm2, [rax+0x80]
    vfmsub213pd xmm1, xmm2, [rax+rbx*4]
    vfmsub213pd xmm1, xmm2, [rbx*8+0x10]
    vfmsub213pd xmm1, xmm2, [rip+0x100]
    vfmsub213pd xmm1, xmm2, [0x1000]
    vfmsub213pd xmm1, xmm2, [r13]
    vfmsub231pd xmm1, xmm2, [rax]
    vfmsub231pd xmm1, xmm2, [rax+0x7f]
    vfmsub231pd xmm1, xmm2, [rax+0x80]
    vfmsub231pd xmm1, xmm2, [rax+rbx*4]
    vfmsub231pd xmm1, xmm2, [rbx*8+0x10]
    vfmsub231pd xmm1, xmm2, [rip+0x100]
    vfmsub231pd xmm1, xmm2, [0x1000]
    vfmsub231pd xmm1, xmm2, [r13]
    vfmsub132pd ymm1, ymm2, [rax]
    vfmsub132pd ymm1, ymm2, [rax+0x7f]
    vfmsub132pd ymm1, ymm2, [rax+0x80]
    vfmsub132pd ymm1, ymm2, [rax+rbx*4]
    vfmsub132pd ymm1, ymm2, [rbx*8+0x10]
    vfmsub132pd ymm1, ymm2, [rip+0x100]
    vfmsub132pd ymm1, ymm2, [0x1000]
    vfmsub132pd ymm1, ymm2, [r13]
    vfmsub213pd ymm1, ymm2, [rax]
    vfmsub213pd ymm1, ymm2, [rax+0x7f]
    vfmsub213pd ymm1, ymm2, [rax+0x80]
    vfmsub213pd ymm1, ymm2, [rax+rbx*4]
    vfmsub213pd ymm1, ymm2, [rbx*8+0x10]
    vfmsub213pd ymm1, ymm2, [rip+0x100]
    vfmsub213pd ymm1, ymm2, [0x1000]
    vfmsub213pd ymm1, ymm2, [r13]
    vfmsub231pd ymm1, ymm2, [rax]
    vfmsub231pd ymm1, ymm2, [rax+0x7f]
    vfmsub231pd ymm1, ymm2, [rax+0x80]
    vfmsub231pd ymm1, ymm2, [rax+rbx*4]
    vfmsub231pd ymm1, ymm2, [rbx*8+0x10]
    vfmsub231pd ymm1, ymm2, [rip+0x100]
    vfmsub231pd ymm1, ymm2, [0x1000]
    vfmsub231pd ymm1, ymm2, [r13]
    vfmsub132ps xmm1, xmm2, [rax]
    vfmsub132ps xmm1, xmm2, [rax+0x7f]
    vfmsub132ps xmm1, xmm2, [rax+0x80]
    vfmsub132ps xmm1, xmm2, [rax+rbx*4]
    vfmsub132ps xmm1, xmm2, [rbx*8+0x10]
    vfmsub132ps xmm1, xmm2, [rip+0x100]
    vfmsub132ps xmm1, xmm2, [0x1000]
    vfmsub132ps xmm1, xmm2, [r13]
    vfmsub213ps xmm1, xmm2, [rax]
    vfmsub213ps xmm1, xmm2, [rax+0x7f]
    vfmsub213ps xmm1, xmm2, [rax+0x80]
    vfmsub213ps xmm1, xmm2, [rax+rbx*4]
    vfmsub213ps xmm1, xmm2, [rbx*8+0x10]
    vfmsub213ps xmm1, xmm2, [rip+0x100]
    vfmsub213ps xmm1, xmm2, [0x1000]
    vfmsub213ps xmm1, xmm2, [r13]
    vfmsub231ps xmm1, xmm2, [rax]
    vfmsub231ps xmm1, xmm2, [rax+0x7f]
    vfmsub231ps xmm1, xmm2, [rax+0x80]
    vfmsub231ps xmm1, xmm2, [rax+rbx*4]
    vfmsub231ps xmm1, xmm2, [rbx*8+0x10]
    vfmsub231ps xmm1, xmm2, [rip+0x100]
    vfmsub231ps xmm1, xmm2, [0x1000]
    vfmsub231ps xmm1, xmm2, [r13]
    vfmsub132ps ymm1, ymm2, [rax]
    vfmsub132ps ymm1, ymm2, [rax+0x7f]
    vfmsub132ps ymm1, ymm2, [rax+0x80]
    vfmsub132ps ymm1, ymm2, [rax+rbx*4]
    vfmsub132ps ymm1, ymm2, [rbx*8+0x10]
    vfmsub132ps ymm1, ymm2, [rip+0x100]
    vfmsub132ps ymm1, ymm2, [0x1000]
    vfmsub132ps ymm1, ymm2, [r13]
    vfmsub213ps ymm1, ymm2, [rax]
    vfmsub213ps ymm1, ymm2, [rax+0x7f]
    vfmsub213ps ymm1, ymm2, [rax+0x80]
    vfmsub213ps ymm1, ymm2, [rax+rbx*4]
    vfmsub213ps ymm1, ymm2, [rbx*8+0x10]
    vfmsub213ps ymm1, ymm2, [rip+0x100]
    vfmsub213ps ymm1, ymm2, [0x1000]
    vfmsub213ps ymm1, ymm2, [r13]
    vfmsub231ps ymm1, ymm2, [rax]
    vfmsub231ps ymm1, ymm2, [rax+0x7f]
    vfmsub231ps ymm1, ymm2, [rax+0x80]
    vfmsub231ps ymm1, ymm2, [rax+rbx*4]
    vfmsub231ps ymm1, ymm2, [rbx*8+0x10]
    vfmsub231ps ymm1, ymm2, [rip+0x100]
    vfmsub231ps ymm1, ymm2, [0x1000]
    vfmsub231ps ymm1, ymm2, [r13]
    vfmsub132sd xmm1, xmm2, QWORD PTR [rax]
    vfmsub132sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfmsub132sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfmsub132sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfmsub132sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfmsub132sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfmsub132sd xmm1, xmm2, QWORD PTR [0x1000]
    vfmsub132sd xmm1, xmm2, QWORD PTR [r13]
    vfmsub213sd xmm1, xmm2, QWORD PTR [rax]
    vfmsub213sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfmsub213sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfmsub213sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfmsub213sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfmsub213sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfmsub213sd xmm1, xmm2, QWORD PTR [0x1000]
    vfmsub213sd xmm1, xmm2, QWORD PTR [r13]
    vfmsub231sd xmm1, xmm2, QWORD PTR [rax]
    vfmsub231sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfmsub231sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfmsub231sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfmsub231sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfmsub231sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfmsub231sd xmm1, xmm2, QWORD PTR [0x1000]
    vfmsub231sd xmm1, xmm2, QWORD PTR [r13]
    vfmsub132ss xmm1, xmm2, DWORD PTR [rax]
    vfmsub132ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfmsub132ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfmsub132ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfmsub132ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfmsub132ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfmsub132ss xmm1, xmm2, DWORD PTR [0x1000]
    vfmsub132ss xmm1, xmm2, DWORD PTR [r13]
    vfmsub213ss xmm1, xmm2, DWORD PTR [rax]
    vfmsub213ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfmsub213ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfmsub213ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfmsub213ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfmsub213ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfmsub213ss xmm1, xmm2, DWORD PTR [0x1000]
    vfmsub213ss xmm1, xmm2, DWORD PTR [r13]
    vfmsub231ss xmm1, xmm2, DWORD PTR [rax]
    vfmsub231ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfmsub231ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfmsub231ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfmsub231ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfmsub231ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfmsub231ss xmm1, xmm2, DWORD PTR [0x1000]
    vfmsub231ss xmm1, xmm2, DWORD PTR [r13]
    vfmsubadd132pd xmm1, xmm2, [rax]
    vfmsubadd132pd xmm1, xmm2, [rax+0x7f]
    vfmsubadd132pd xmm1, xmm2, [rax+0x80]
    vfmsubadd132pd xmm1, xmm2, [rax+rbx*4]
    vfmsubadd132pd xmm1, xmm2, [rbx*8+0x10]
    vfmsubadd132pd xmm1, xmm2, [rip+0x100]
    vfmsubadd132pd xmm1, xmm2, [0x1000]
    vfmsubadd132pd xmm1, xmm2, [r13]
    vfmsubadd213pd xmm1, xmm2, [rax]
    vfmsubadd213pd xmm1, xmm2, [rax+0x7f]
    vfmsubadd213pd xmm1, xmm2, [rax+0x80]
    vfmsubadd213pd xmm1, xmm2, [rax+rbx*4]
    vfmsubadd213pd xmm1, xmm2, [rbx*8+0x10]
    vfmsubadd213pd xmm1, xmm2, [rip+0x100]
    vfmsubadd213pd xmm1, xmm2, [0x1000]
    vfmsubadd213pd xmm1, xmm2, [r13]
    vfmsubadd231pd xmm1, xmm2, [rax]
    vfmsubadd231pd xmm1, xmm2, [rax+0x7f]
    vfmsubadd231pd xmm1, xmm2, [rax+0x80]
    vfmsubadd231pd xmm1, xmm2, [rax+rbx*4]
    vfmsubadd231pd xmm1, xmm2, [rbx*8+0x10]
    vfmsubadd231pd xmm1, xmm2, [rip+0x100]
    vfmsubadd231pd xmm1, xmm2, [0x1000]
    vfmsubadd231pd xmm1, xmm2, [r13]
    vfmsubadd132pd ymm1, ymm2, [rax]
    vfmsubadd132pd ymm1, ymm2, [rax+0x7f]
    vfmsubadd132pd ymm1, ymm2, [rax+0x80]
    vfmsubadd132pd ymm1, ymm2, [rax+rbx*4]
    vfmsubadd132pd ymm1, ymm2, [rbx*8+0x10]
    vfmsubadd132pd ymm1, ymm2, [rip+0x100]
    vfmsubadd132pd ymm1, ymm2, [0x1000]
    vfmsubadd132pd ymm1, ymm2, [r13]
    vfmsubadd213pd ymm1, ymm2, [rax]
    vfmsubadd213pd ymm1, ymm2, [rax+0x7f]
    vfmsubadd213pd ymm1, ymm2, [rax+0x80]
    vfmsubadd213pd ymm1, ymm2, [rax+rbx*4]
    vfmsubadd213pd ymm1, ymm2, [rbx*8+0x10]
    vfmsubadd213pd ymm1, ymm2, [rip+0x100]
    vfmsubadd213pd ymm1, ymm2, [0x1000]
    vfmsubadd213pd ymm1, ymm2, [r13]
    vfmsubadd231pd ymm1, ymm2, [rax]
    vfmsubadd231pd ymm1, ymm2, [rax+0x7f]
    vfmsubadd231pd ymm1, ymm2, [rax+0x80]
    vfmsubadd231pd ymm1, ymm2, [rax+rbx*4]
    vfmsubadd231pd ymm1, ymm2, [rbx*8+0x10]
    vfmsubadd231pd ymm1, ymm2, [rip+0x100]
    vfmsubadd231pd ymm1, ymm2, [0x1000]
    vfmsubadd231pd ymm1, ymm2, [r13]
    vfmsubadd132ps xmm1, xmm2, [rax]
    vfmsubadd132ps xmm1, xmm2, [rax+0x7f]
    vfmsubadd132ps xmm1, xmm2, [rax+0x80]
    vfmsubadd132ps xmm1, xmm2, [rax+rbx*4]
    vfmsubadd132ps xmm1, xmm2, [rbx*8+0x10]
    vfmsubadd132ps xmm1, xmm2, [rip+0x100]
    vfmsubadd132ps xmm1, xmm2, [0x1000]
    vfmsubadd132ps xmm1, xmm2, [r13]
    vfmsubadd213ps xmm1, xmm2, [rax]
    vfmsubadd213ps xmm1, xmm2, [rax+0x7f]
    vfmsubadd213ps xmm1, xmm2, [rax+0x80]
    vfmsubadd213ps xmm1, xmm2, [rax+rbx*4]
    vfmsubadd213ps xmm1, xmm2, [rbx*8+0x10]
    vfmsubadd213ps xmm1, xmm2, [rip+0x100]
    vfmsubadd213ps xmm1, xmm2, [0x1000]
    vfmsubadd213ps xmm1, xmm2, [r13]
    vfmsubadd231ps xmm1, xmm2, [rax]
    vfmsubadd231ps xmm1, xmm2, [rax+0x7f]
    vfmsubadd231ps xmm1, xmm2, [rax+0x80]
    vfmsubadd231ps xmm1, xmm2, [rax+rbx*4]
    vfmsubadd231ps xmm1, xmm2, [rbx*8+0x10]
    vfmsubadd231ps xmm1, xmm2, [rip+0x100]
    vfmsubadd231ps xmm1, xmm2, [0x1000]
    vfmsubadd231ps xmm1, xmm2, [r13]
    vfmsubadd132ps ymm1, ymm2, [rax]
    vfmsubadd132ps ymm1, ymm2, [rax+0x7f]
    vfmsubadd132ps ymm1, ymm2, [rax+0x80]
    vfmsubadd132ps ymm1, ymm2, [rax+rbx*4]
    vfmsubadd132ps ymm1, ymm2, [rbx*8+0x10]
    vfmsubadd132ps ymm1, ymm2, [rip+0x100]
    vfmsubadd132ps ymm1, ymm2, [0x1000]
    vfmsubadd132ps ymm1, ymm2, [r13]
    vfmsubadd213ps ymm1, ymm2, [rax]
    vfmsubadd213ps ymm1, ymm2, [rax+0x7f]
    vfmsubadd213ps ymm1, ymm2, [rax+0x80]
    vfmsubadd213ps ymm1, ymm2, [rax+rbx*4]
    vfmsubadd213ps ymm1, ymm2, [rbx*8+0x10]
    vfmsubadd213ps ymm1, ymm2, [rip+0x100]
    vfmsubadd213ps ymm1, ymm2, [0x1000]
    vfmsubadd213ps ymm1, ymm2, [r13]
    vfmsubadd231ps ymm1, ymm2, [rax]
    vfmsubadd231ps ymm1, ymm2, [rax+0x7f]
    vfmsubadd231ps ymm1, ymm2, [rax+0x80]
    vfmsubadd231ps ymm1, ymm2, [rax+rbx*4]
    vfmsubadd231ps ymm1, ymm2, [rbx*8+0x10]
    vfmsubadd231ps ymm1, ymm2, [rip+0x100]
    vfmsubadd231ps ymm1, ymm2, [0x1000]
    vfmsubadd231ps ymm1, ymm2, [r13]
    vfnmadd132pd xmm1, xmm2, [rax]
    vfnmadd132pd xmm1, xmm2, [rax+0x7f]
    vfnmadd132pd xmm1, xmm2, [rax+0x80]
    vfnmadd132pd xmm1, xmm2, [rax+rbx*4]
    vfnmadd132pd xmm1, xmm2, [rbx*8+0x10]
    vfnmadd132pd xmm1, xmm2, [rip+0x100]
    vfnmadd132pd xmm1, xmm2, [0x1000]
    vfnmadd132pd xmm1, xmm2, [r13]
    vfnmadd213pd xmm1, xmm2, [rax]
    vfnmadd213pd xmm1, xmm2, [rax+0x7f]
    vfnmadd213pd xmm1, xmm2, [rax+0x80]
    vfnmadd213pd xmm1, xmm2, [rax+rbx*4]
    vfnmadd213pd xmm1, xmm2, [rbx*8+0x10]
    vfnmadd213pd xmm1, xmm2, [rip+0x100]
    vfnmadd213pd xmm1, xmm2, [0x1000]
    vfnmadd213pd xmm1, xmm2, [r13]
    vfnmadd231pd xmm1, xmm2, [rax]
    vfnmadd231pd xmm1, xmm2, [rax+0x7f]
    vfnmadd231pd xmm1, xmm2, [rax+0x80]
    vfnmadd231pd xmm1, xmm2, [rax+rbx*4]
    vfnmadd231pd xmm1, xmm2, [rbx*8+0x10]
    vfnmadd231pd xmm1, xmm2, [rip+0x100]
    vfnmadd231pd xmm1, xmm2, [0x1000]
    vfnmadd231pd xmm1, xmm2, [r13]
    vfnmadd132pd ymm1, ymm2, [rax]
    vfnmadd132pd ymm1, ymm2, [rax+0x7f]
    vfnmadd132pd ymm1, ymm2, [rax+0x80]
    vfnmadd132pd ymm1, ymm2, [rax+rbx*4]
    vfnmadd132pd ymm1, ymm2, [rbx*8+0x10]
    vfnmadd132pd ymm1, ymm2, [rip+0x100]
    vfnmadd132pd ymm1, ymm2, [0x1000]
    vfnmadd132pd ymm1, ymm2, [r13]
    vfnmadd213pd ymm1, ymm2, [rax]
    vfnmadd213pd ymm1, ymm2, [rax+0x7f]
    vfnmadd213pd ymm1, ymm2, [rax+0x80]
    vfnmadd213pd ymm1, ymm2, [rax+rbx*4]
    vfnmadd213pd ymm1, ymm2, [rbx*8+0x10]
    vfnmadd213pd ymm1, ymm2, [rip+0x100]
    vfnmadd213pd ymm1, ymm2, [0x1000]
    vfnmadd213pd ymm1, ymm2, [r13]
    vfnmadd231pd ymm1, ymm2, [rax]
    vfnmadd231pd ymm1, ymm2, [rax+0x7f]
    vfnmadd231pd ymm1, ymm2, [rax+0x80]
    vfnmadd231pd ymm1, ymm2, [rax+rbx*4]
    vfnmadd231pd ymm1, ymm2, [rbx*8+0x10]
    vfnmadd231pd ymm1, ymm2, [rip+0x100]
    vfnmadd231pd ymm1, ymm2, [0x1000]
    vfnmadd231pd ymm1, ymm2, [r13]
    vfnmadd132ps xmm1, xmm2, [rax]
    vfnmadd132ps xmm1, xmm2, [rax+0x7f]
    vfnmadd132ps xmm1, xmm2, [rax+0x80]
    vfnmadd132ps xmm1, xmm2, [rax+rbx*4]
    vfnmadd132ps xmm1, xmm2, [rbx*8+0x10]
    vfnmadd132ps xmm1, xmm2, [rip+0x100]
    vfnmadd132ps xmm1, xmm2, [0x1000]
    vfnmadd132ps xmm1, xmm2, [r13]
    vfnmadd213ps xmm1, xmm2, [rax]
    vfnmadd213ps xmm1, xmm2, [rax+0x7f]
    vfnmadd213ps xmm1, xmm2, [rax+0x80]
    vfnmadd213ps xmm1, xmm2, [rax+rbx*4]
    vfnmadd213ps xmm1, xmm2, [rbx*8+0x10]
    vfnmadd213ps xmm1, xmm2, [rip+0x100]
    vfnmadd213ps xmm1, xmm2, [0x1000]
    vfnmadd213ps xmm1, xmm2, [r13]
    vfnmadd231ps xmm1, xmm2, [rax]
    vfnmadd231ps xmm1, xmm2, [rax+0x7f]
    vfnmadd231ps xmm1, xmm2, [rax+0x80]
    vfnmadd231ps xmm1, xmm2, [rax+rbx*4]
    vfnmadd231ps xmm1, xmm2, [rbx*8+0x10]
    vfnmadd231ps xmm1, xmm2, [rip+0x100]
    vfnmadd231ps xmm1, xmm2, [0x1000]
    vfnmadd231ps xmm1, xmm2, [r13]
    vfnmadd132ps ymm1, ymm2, [rax]
    vfnmadd132ps ymm1, ymm2, [rax+0x7f]
    vfnmadd132ps ymm1, ymm2, [rax+0x80]
    vfnmadd132ps ymm1, ymm2, [rax+rbx*4]
    vfnmadd132ps ymm1, ymm2, [rbx*8+0x10]
    vfnmadd132ps ymm1, ymm2, [rip+0x100]
    vfnmadd132ps ymm1, ymm2, [0x1000]
    vfnmadd132ps ymm1, ymm2, [r13]
    vfnmadd213ps ymm1, ymm2, [rax]
    vfnmadd213ps ymm1, ymm2, [rax+0x7f]
    vfnmadd213ps ymm1, ymm2, [rax+0x80]
    vfnmadd213ps ymm1, ymm2, [rax+rbx*4]
    vfnmadd213ps ymm1, ymm2, [rbx*8+0x10]
    vfnmadd213ps ymm1, ymm2, [rip+0x100]
    vfnmadd213ps ymm1, ymm2, [0x1000]
    vfnmadd213ps ymm1, ymm2, [r13]
    vfnmadd231ps ymm1, ymm2, [rax]
    vfnmadd231ps ymm1, ymm2, [rax+0x7f]
    vfnmadd231ps ymm1, ymm2, [rax+0x80]
    vfnmadd231ps ymm1, ymm2, [rax+rbx*4]
    vfnmadd231ps ymm1, ymm2, [rbx*8+0x10]
    vfnmadd231ps ymm1, ymm2, [rip+0x100]
    vfnmadd231ps ymm1, ymm2, [0x1000]
    vfnmadd231ps ymm1, ymm2, [r13]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [rax]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [0x1000]
    vfnmadd132sd xmm1, xmm2, QWORD PTR [r13]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [rax]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [0x1000]
    vfnmadd213sd xmm1, xmm2, QWORD PTR [r13]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [rax]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [0x1000]
    vfnmadd231sd xmm1, xmm2, QWORD PTR [r13]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [rax]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [0x1000]
    vfnmadd132ss xmm1, xmm2, DWORD PTR [r13]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [rax]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [0x1000]
    vfnmadd213ss xmm1, xmm2, DWORD PTR [r13]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [rax]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [0x1000]
    vfnmadd231ss xmm1, xmm2, DWORD PTR [r13]
    vfnmsub132pd xmm1, xmm2, [rax]
    vfnmsub132pd xmm1, xmm2, [rax+0x7f]
    vfnmsub132pd xmm1, xmm2, [rax+0x80]
    vfnmsub132pd xmm1, xmm2, [rax+rbx*4]
    vfnmsub132pd xmm1, xmm2, [rbx*8+0x10]
    vfnmsub132pd xmm1, xmm2, [rip+0x100]
    vfnmsub132pd xmm1, xmm2, [0x1000]
    vfnmsub132pd xmm1, xmm2, [r13]
    vfnmsub213pd xmm1, xmm2, [rax]
    vfnmsub213pd xmm1, xmm2, [rax+0x7f]
    vfnmsub213pd xmm1, xmm2, [rax+0x80]
    vfnmsub213pd xmm1, xmm2, [rax+rbx*4]
    vfnmsub213pd xmm1, xmm2, [rbx*8+0x10]
    vfnmsub213pd xmm1, xmm2, [rip+0x100]
    vfnmsub213pd xmm1, xmm2, [0x1000]
    vfnmsub213pd xmm1, xmm2, [r13]
    vfnmsub231pd xmm1, xmm2, [rax]
    vfnmsub231pd xmm1, xmm2, [rax+0x7f]
    vfnmsub231pd xmm1, xmm2, [rax+0x80]
    vfnmsub231pd xmm1, xmm2, [rax+rbx*4]
    vfnmsub231pd xmm1, xmm2, [rbx*8+0x10]
    vfnmsub231pd xmm1, xmm2, [rip+0x100]
    vfnmsub231pd xmm1, xmm2, [0x1000]
    vfnmsub231pd xmm1, xmm2, [r13]
    vfnmsub132pd ymm1, ymm2, [rax]
    vfnmsub132pd ymm1, ymm2, [rax+0x7f]
    vfnmsub132pd ymm1, ymm2, [rax+0x80]
    vfnmsub132pd ymm1, ymm2, [rax+rbx*4]
    vfnmsub132pd ymm1, ymm2, [rbx*8+0x10]
    vfnmsub132pd ymm1, ymm2, [rip+0x100]
    vfnmsub132pd ymm1, ymm2, [0x1000]
    vfnmsub132pd ymm1, ymm2, [r13]
    vfnmsub213pd ymm1, ymm2, [rax]
    vfnmsub213pd ymm1, ymm2, [rax+0x7f]
    vfnmsub213pd ymm1, ymm2, [rax+0x80]
    vfnmsub213pd ymm1, ymm2, [rax+rbx*4]
    vfnmsub213pd ymm1, ymm2, [rbx*8+0x10]
    vfnmsub213pd ymm1, ymm2, [rip+0x100]
    vfnmsub213pd ymm1, ymm2, [0x1000]
    vfnmsub213pd ymm1, ymm2, [r13]
    vfnmsub231pd ymm1, ymm2, [rax]
    vfnmsub231pd ymm1, ymm2, [rax+0x7f]
    vfnmsub231pd ymm1, ymm2, [rax+0x80]
    vfnmsub231pd ymm1, ymm2, [rax+rbx*4]
    vfnmsub231pd ymm1, ymm2, [rbx*8+0x10]
    vfnmsub231pd ymm1, ymm2, [rip+0x100]
    vfnmsub231pd ymm1, ymm2, [0x1000]
    vfnmsub231pd ymm1, ymm2, [r13]
    vfnmsub132ps xmm1, xmm2, [rax]
    vfnmsub132ps xmm1, xmm2, [rax+0x7f]
    vfnmsub132ps xmm1, xmm2, [rax+0x80]
    vfnmsub132ps xmm1, xmm2, [rax+rbx*4]
    vfnmsub132ps xmm1, xmm2, [rbx*8+0x10]
    vfnmsub132ps xmm1, xmm2, [rip+0x100]
    vfnmsub132ps xmm1, xmm2, [0x1000]
    vfnmsub132ps xmm1, xmm2, [r13]
    vfnmsub213ps xmm1, xmm2, [rax]
    vfnmsub213ps xmm1, xmm2, [rax+0x7f]
    vfnmsub213ps xmm1, xmm2, [rax+0x80]
    vfnmsub213ps xmm1, xmm2, [rax+rbx*4]
    vfnmsub213ps xmm1, xmm2, [rbx*8+0x10]
    vfnmsub213ps xmm1, xmm2, [rip+0x100]
    vfnmsub213ps xmm1, xmm2, [0x1000]
    vfnmsub213ps xmm1, xmm2, [r13]
    vfnmsub231ps xmm1, xmm2, [rax]
    vfnmsub231ps xmm1, xmm2, [rax+0x7f]
    vfnmsub231ps xmm1, xmm2, [rax+0x80]
    vfnmsub231ps xmm1, xmm2, [rax+rbx*4]
    vfnmsub231ps xmm1, xmm2, [rbx*8+0x10]
    vfnmsub231ps xmm1, xmm2, [rip+0x100]
    vfnmsub231ps xmm1, xmm2, [0x1000]
    vfnmsub231ps xmm1, xmm2, [r13]
    vfnmsub132ps ymm1, ymm2, [rax]
    vfnmsub132ps ymm1, ymm2, [rax+0x7f]
    vfnmsub132ps ymm1, ymm2, [rax+0x80]
    vfnmsub132ps ymm1, ymm2, [rax+rbx*4]
    vfnmsub132ps ymm1, ymm2, [rbx*8+0x10]
    vfnmsub132ps ymm1, ymm2, [rip+0x100]
    vfnmsub132ps ymm1, ymm2, [0x1000]
    vfnmsub132ps ymm1, ymm2, [r13]
    vfnmsub213ps ymm1, ymm2, [rax]
    vfnmsub213ps ymm1, ymm2, [rax+0x7f]
    vfnmsub213ps ymm1, ymm2, [rax+0x80]
    vfnmsub213ps ymm1, ymm2, [rax+rbx*4]
    vfnmsub213ps ymm1, ymm2, [rbx*8+0x10]
    vfnmsub213ps ymm1, ymm2, [rip+0x100]
    vfnmsub213ps ymm1, ymm2, [0x1000]
    vfnmsub213ps ymm1, ymm2, [r13]
    vfnmsub231ps ymm1, ymm2, [rax]
    vfnmsub231ps ymm1, ymm2, [rax+0x7f]
    vfnmsub231ps ymm1, ymm2, [rax+0x80]
    vfnmsub231ps ymm1, ymm2, [rax+rbx*4]
    vfnmsub231ps ymm1, ymm2, [rbx*8+0x10]
    vfnmsub231ps ymm1, ymm2, [rip+0x100]
    vfnmsub231ps ymm1, ymm2, [0x1000]
    vfnmsub231ps ymm1, ymm2, [r13]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [rax]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [0x1000]
    vfnmsub132sd xmm1, xmm2, QWORD PTR [r13]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [rax]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [0x1000]
    vfnmsub213sd xmm1, xmm2, QWORD PTR [r13]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [rax]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [rax+0x7f]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [rax+0x80]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [rax+rbx*4]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [rbx*8+0x10]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [rip+0x100]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [0x1000]
    vfnmsub231sd xmm1, xmm2, QWORD PTR [r13]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [rax]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [0x1000]
    vfnmsub132ss xmm1, xmm2, DWORD PTR [r13]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [rax]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [0x1000]
    vfnmsub213ss xmm1, xmm2, DWORD PTR [r13]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [rax]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [rax+0x7f]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [rax+0x80]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [rax+rbx*4]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [rbx*8+0x10]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [rip+0x100]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [0x1000]
    vfnmsub231ss xmm1, xmm2, DWORD PTR [r13]
    vinsertf128 ymm1, ymm2, [rax], 0x1
    vinsertf128 ymm1, ymm2, [rax+0x7f], 0x1
    vinsertf128 ymm1, ymm2, [rax+0x80], 0x1
    vinsertf128 ymm1, ymm2, [rax+rbx*4], 0x1
    vinsertf128 ymm1, ymm2, [rbx*8+0x10], 0x1
    vinsertf128 ymm1, ymm2, [rip+0x100], 0x1
    vinsertf128 ymm1, ymm2, [0x1000], 0x1
    vinsertf128 ymm1, ymm2, [r13], 0x1
    vinserti128 ymm1, ymm2, [rax], 0x1
    vinserti128 ymm1, ymm2, [rax+0x7f], 0x1
    vinserti128 ymm1, ymm2, [rax+0x80], 0x1
    vinserti128 ymm1, ymm2, [rax+rbx*4], 0x1
    vinserti128 ymm1, ymm2, [rbx*8+0x10], 0x1
    vinserti128 ymm1, ymm2, [rip+0x100], 0x1
    vinserti128 ymm1, ymm2, [0x1000], 0x1
    vinserti128 ymm1, ymm2, [r13], 0x1
    vmaskmovps xmm1, xmm2, [rax]
    vmaskmovps xmm1, xmm2, [rax+0x7f]
    vmaskmovps xmm1, xmm2, [rax+0x80]
    vmaskmovps xmm1, xmm2, [rax+rbx*4]
    vmaskmovps xmm1, xmm2, [rbx*8+0x10]
    vmaskmovps xmm1, xmm2, [rip+0x100]
    vmaskmovps xmm1, xmm2, [0x1000]
    vmaskmovps xmm1, xmm2, [r13]
    vmaskmovps ymm1, ymm2, [rax]
    vmaskmovps ymm1, ymm2, [rax+0x7f]
    vmaskmovps ymm1, ymm2, [rax+0x80]
    vmaskmovps ymm1, ymm2, [rax+rbx*4]
    vmaskmovps ymm1, ymm2, [rbx*8+0x10]
    vmaskmovps ymm1, ymm2, [rip+0x100]
    vmaskmovps ymm1, ymm2, [0x1000]
    vmaskmovps ymm1, ymm2, [r13]
    vmaskmovpd xmm1, xmm2, [rax]
    vmaskmovpd xmm1, xmm2, [rax+0x7f]
    vmaskmovpd xmm1, xmm2, [rax+0x80]
    vmaskmovpd xmm1, xmm2, [rax+rbx*4]
    vmaskmovpd xmm1, xmm2, [rbx*8+0x10]
    vmaskmovpd xmm1, xmm2, [rip+0x100]
    vmaskmovpd xmm1, xmm2, [0x1000]
    vmaskmovpd xmm1, xmm2, [r13]
    vmaskmovpd ymm1, ymm2, [rax]
    vmaskmovpd ymm1, ymm2, [rax+0x7f]
    vmaskmovpd ymm1, ymm2, [rax+0x80]
    vmaskmovpd ymm1, ymm2, [rax+rbx*4]
    vmaskmovpd ymm1, ymm2, [rbx*8+0x10]
    vmaskmovpd ymm1, ymm2, [rip+0x100]
    vmaskmovpd ymm1, ymm2, [0x1000]
    vmaskmovpd ymm1, ymm2, [r13]
    vmaskmovps [rax], xmm1, xmm2
    vmaskmovps [rax+0x7f], xmm1, xmm2
    vmaskmovps [rax+0x80], xmm1, xmm2
    vmaskmovps [rax+rbx*4], xmm1, xmm2
    vmaskmovps [rbx*8+0x10], xmm1, xmm2
    vmaskmovps [rip+0x100], xmm1, xmm2
    vmaskmovps [0x1000], xmm1, xmm2
    vmaskmovps [r13], xmm1, xmm2
    vmaskmovps [rax], ymm1, ymm2
    vmaskmovps [rax+0x7f], ymm1, ymm2
    vmaskmovps [rax+0x80], ymm1, ymm2
    vmaskmovps [rax+rbx*4], ymm1, ymm2
    vmaskmovps [rbx*8+0x10], ymm1, ymm2
    vmaskmovps [rip+0x100], ymm1, ymm2
    vmaskmovps [0x1000], ymm1, ymm2
    vmaskmovps [r13], ymm1, ymm2
    vmaskmovpd [rax], xmm1, xmm2
    vmaskmovpd [rax+0x7f], xmm1, xmm2
    vmaskmovpd [rax+0x80], xmm1, xmm2
    vmaskmovpd [rax+rbx*4], xmm1, xmm2
    vmaskmovpd [rbx*8+0x10], xmm1, xmm2
    vmaskmovpd [rip+0x100], xmm1, xmm2
    vmaskmovpd [0x1000], xmm1, xmm2
    vmaskmovpd [r13], xmm1, xmm2
    vmaskmovpd [rax], ymm1, ymm2
    vmaskmovpd [rax+0x7f], ymm1, ymm2
    vmaskmovpd [rax+0x80], ymm1, ymm2
    vmaskmovpd [rax+rbx*4], ymm1, ymm2
    vmaskmovpd [rbx*8+0x10], ymm1, ymm2
    vmaskmovpd [rip+0x100], ymm1, ymm2
    vmaskmovpd [0x1000], ymm1, ymm2
    vmaskmovpd [r13], ymm1, ymm2
    vpblendd xmm1, xmm2, [rax], 0x1
    vpblendd xmm1, xmm2, [rax+0x7f], 0x1
    vpblendd xmm1, xmm2, [rax+0x80], 0x1
    vpblendd xmm1, xmm2, [rax+rbx*4], 0x1
    vpblendd xmm1, xmm2, [rbx*8+0x10], 0x1
    vpblendd xmm1, xmm2, [rip+0x100], 0x1
    vpblendd xmm1, xmm2, [0x1000], 0x1
    vpblendd xmm1, xmm2, [r13], 0x1
    vpblendd ymm1, ymm2, [rax], 0x1
    vpblendd ymm1, ymm2, [rax+0x7f], 0x1
    vpblendd ymm1, ymm2, [rax+0x80], 0x1
    vpblendd ymm1, ymm2, [rax+rbx*4], 0x1
    vpblendd ymm1, ymm2, [rbx*8+0x10], 0x1
    vpblendd ymm1, ymm2, [rip+0x100], 0x1
    vpblendd ymm1, ymm2, [0x1000], 0x1
    vpblendd ymm1, ymm2, [r13], 0x1
    vpbroadcastb xmm1, BYTE PTR [rax]
    vpbroadcastb xmm1, BYTE PTR [rax+0x7f]
    vpbroadcastb xmm1, BYTE PTR [rax+0x80]
    vpbroadcastb xmm1, BYTE PTR [rax+rbx*4]
    vpbroadcastb xmm1, BYTE PTR [rbx*8+0x10]
    vpbroadcastb xmm1, BYTE PTR [rip+0x100]
    vpbroadcastb xmm1, BYTE PTR [0x1000]
    vpbroadcastb xmm1, BYTE PTR [r13]
    vpbroadcastb ymm1, BYTE PTR [rax]
    vpbroadcastb ymm1, BYTE PTR [rax+0x7f]
    vpbroadcastb ymm1, BYTE PTR [rax+0x80]
    vpbroadcastb ymm1, BYTE PTR [rax+rbx*4]
    vpbroadcastb ymm1, BYTE PTR [rbx*8+0x10]
    vpbroadcastb ymm1, BYTE PTR [rip+0x100]
    vpbroadcastb ymm1, BYTE PTR [0x1000]
    vpbroadcastb ymm1, BYTE PTR [r13]
    vpbroadcastw xmm1, WORD PTR [rax]
    vpbroadcastw xmm1, WORD PTR [rax+0x7f]
    vpbroadcastw xmm1, WORD PTR [rax+0x80]
    vpbroadcastw xmm1, WORD PTR [rax+rbx*4]
    vpbroadcastw xmm1, WORD PTR [rbx*8+0x10]
    vpbroadcastw xmm1, WORD PTR [rip+0x100]
    vpbroadcastw xmm1, WORD PTR [0x1000]
    vpbroadcastw xmm1, WORD PTR [r13]
    vpbroadcastw ymm1, WORD PTR [rax]
    vpbroadcastw ymm1, WORD PTR [rax+0x7f]
    vpbroadcastw ymm1, WORD PTR [rax+0x80]
    vpbroadcastw ymm1, WORD PTR [rax+rbx*4]
    vpbroadcastw ymm1, WORD PTR [rbx*8+0x10]
    vpbroadcastw ymm1, WORD PTR [rip+0x100]
    vpbroadcastw ymm1, WORD PTR [0x1000]
    vpbroadcastw ymm1, WORD PTR [r13]
    vpbroadcastd xmm1, DWORD PTR [rax]
    vpbroadcastd xmm1, DWORD PTR [rax+0x7f]
    vpbroadcastd xmm1, DWORD PTR [rax+0x80]
    vpbroadcastd xmm1, DWORD PTR [rax+rbx*4]
    vpbroadcastd xmm1, DWORD PTR [rbx*8+0x10]
    vpbroadcastd xmm1, DWORD PTR [rip+0x100]
    vpbroadcastd xmm1, DWORD PTR [0x1000]
    vpbroadcastd xmm1, DWORD PTR [r13]
    vpbroadcastd ymm1, DWORD PTR [rax]
    vpbroadcastd ymm1, DWORD PTR [rax+0x7f]
    vpbroadcastd ymm1, DWORD PTR [rax+0x80]
    vpbroadcastd ymm1, DWORD PTR [rax+rbx*4]
    vpbroadcastd ymm1, DWORD PTR [rbx*8+0x10]
    vpbroadcastd ymm1, DWORD PTR [rip+0x100]
    vpbroadcastd ymm1, DWORD PTR [0x1000]
    vpbroadcastd ymm1, DWORD PTR [r13]
    vpbroadcastq xmm1, QWORD PTR [rax]
    vpbroadcastq xmm1, QWORD PTR [rax+0x7f]
    vpbroadcastq xmm1, QWORD PTR [rax+0x80]
    vpbroadcastq xmm1, QWORD PTR [rax+rbx*4]
    vpbroadcastq xmm1, QWORD PTR [rbx*8+0x10]
    vpbroadcastq xmm1, QWORD PTR [rip+0x100]
    vpbroadcastq xmm1, QWORD PTR [0x1000]
    vpbroadcastq xmm1, QWORD PTR [r13]
    vpbroadcastq ymm1, QWORD PTR [rax]
    vpbroadcastq ymm1, QWORD PTR [rax+0x7f]
    vpbroadcastq ymm1, QWORD PTR [rax+0x80]
    vpbroadcastq ymm1, QWORD PTR [rax+rbx*4]
    vpbroadcastq ymm1, QWORD PTR [rbx*8+0x10]
    vpbroadcastq ymm1, QWORD PTR [rip+0x100]
    vpbroadcastq ymm1, QWORD PTR [0x1000]
    vpbroadcastq ymm1, QWORD PTR [r13]
    vbroadcasti128 ymm1, [rax]
    vbroadcasti128 ymm1, [rax+0x7f]
    vbroadcasti128 ymm1, [rax+0x80]
    vbroadcasti128 ymm1, [rax+rbx*4]
    vbroadcasti128 ymm1, [rbx*8+0x10]
    vbroadcasti128 ymm1, [rip+0x100]
    vbroadcasti128 ymm1, [0x1000]
    vbroadcasti128 ymm1, [r13]
    vpdpbssd xmm1, xmm2, [rax]
    vpdpbssd xmm1, xmm2, [rax+0x7f]
    vpdpbssd xmm1, xmm2, [rax+0x80]
    vpdpbssd xmm1, xmm2, [rax+rbx*4]
    vpdpbssd xmm1, xmm2, [rbx*8+0x10]
    vpdpbssd xmm1, xmm2, [rip+0x100]
    vpdpbssd xmm1, xmm2, [0x1000]
    vpdpbssd xmm1, xmm2, [r13]
    vpdpbssd ymm1, ymm2, [rax]
    vpdpbssd ymm1, ymm2, [rax+0x7f]
    vpdpbssd ymm1, ymm2, [rax+0x80]
    vpdpbssd ymm1, ymm2, [rax+rbx*4]
    vpdpbssd ymm1, ymm2, [rbx*8+0x10]
    vpdpbssd ymm1, ymm2, [rip+0x100]
    vpdpbssd ymm1, ymm2, [0x1000]
    vpdpbssd ymm1, ymm2, [r13]
    vpdpbssds xmm1, xmm2, [rax]
    vpdpbssds xmm1, xmm2, [rax+0x7f]
    vpdpbssds xmm1, xmm2, [rax+0x80]
    vpdpbssds xmm1, xmm2, [rax+rbx*4]
    vpdpbssds xmm1, xmm2, [rbx*8+0x10]
    vpdpbssds xmm1, xmm2, [rip+0x100]
    vpdpbssds xmm1, xmm2, [0x1000]
    vpdpbssds xmm1, xmm2, [r13]
    vpdpbssds ymm1, ymm2, [rax]
    vpdpbssds ymm1, ymm2, [rax+0x7f]
    vpdpbssds ymm1, ymm2, [rax+0x80]
    vpdpbssds ymm1, ymm2, [rax+rbx*4]
    vpdpbssds ymm1, ymm2, [rbx*8+0x10]
    vpdpbssds ymm1, ymm2, [rip+0x100]
    vpdpbssds ymm1, ymm2, [0x1000]
    vpdpbssds ymm1, ymm2, [r13]
    vpdpbsud xmm1, xmm2, [rax]
    vpdpbsud xmm1, xmm2, [rax+0x7f]
    vpdpbsud xmm1, xmm2, [rax+0x80]
    vpdpbsud xmm1, xmm2, [rax+rbx*4]
    vpdpbsud xmm1, xmm2, [rbx*8+0x10]
    vpdpbsud xmm1, xmm2, [rip+0x100]
    vpdpbsud xmm1, xmm2, [0x1000]
    vpdpbsud xmm1, xmm2, [r13]
    vpdpbsud ymm1, ymm2, [rax]
    vpdpbsud ymm1, ymm2, [rax+0x7f]
    vpdpbsud ymm1, ymm2, [rax+0x80]
    vpdpbsud ymm1, ymm2, [rax+rbx*4]
    vpdpbsud ymm1, ymm2, [rbx*8+0x10]
    vpdpbsud ymm1, ymm2, [rip+0x100]
    vpdpbsud ymm1, ymm2, [0x1000]
    vpdpbsud ymm1, ymm2, [r13]
    vpdpbsuds xmm1, xmm2, [rax]
    vpdpbsuds xmm1, xmm2, [rax+0x7f]
    vpdpbsuds xmm1, xmm2, [rax+0x80]
    vpdpbsuds xmm1, xmm2, [rax+rbx*4]
    vpdpbsuds xmm1, xmm2, [rbx*8+0x10]
    vpdpbsuds xmm1, xmm2, [rip+0x100]
    vpdpbsuds xmm1, xmm2, [0x1000]
    vpdpbsuds xmm1, xmm2, [r13]
    vpdpbsuds ymm1, ymm2, [rax]
    vpdpbsuds ymm1, ymm2, [rax+0x7f]
    vpdpbsuds ymm1, ymm2, [rax+0x80]
    vpdpbsuds ymm1, ymm2, [rax+rbx*4]
    vpdpbsuds ymm1, ymm2, [rbx*8+0x10]
    vpdpbsuds ymm1, ymm2, [rip+0x100]
    vpdpbsuds ymm1, ymm2, [0x1000]
    vpdpbsuds ymm1, ymm2, [r13]
    vpdpbuud xmm1, xmm2, [rax]
    vpdpbuud xmm1, xmm2, [rax+0x7f]
    vpdpbuud xmm1, xmm2, [rax+0x80]
    vpdpbuud xmm1, xmm2, [rax+rbx*4]
    vpdpbuud xmm1, xmm2, [rbx*8+0x10]
    vpdpbuud xmm1, xmm2, [rip+0x100]
    vpdpbuud xmm1, xmm2, [0x1000]
    vpdpbuud xmm1, xmm2, [r13]
    vpdpbuud ymm1, ymm2, [rax]
    vpdpbuud ymm1, ymm2, [rax+0x7f]
    vpdpbuud ymm1, ymm2, [rax+0x80]
    vpdpbuud ymm1, ymm2, [rax+rbx*4]
    vpdpbuud ymm1, ymm2, [rbx*8+0x10]
    vpdpbuud ymm1, ymm2, [rip+0x100]
    vpdpbuud ymm1, ymm2, [0x1000]
    vpdpbuud ymm1, ymm2, [r13]
    vpdpbuuds xmm1, xmm2, [rax]
    vpdpbuuds xmm1, xmm2, [rax+0x7f]
    vpdpbuuds xmm1, xmm2, [rax+0x80]
    vpdpbuuds xmm1, xmm2, [rax+rbx*4]
    vpdpbuuds xmm1, xmm2, [rbx*8+0x10]
    vpdpbuuds xmm1, xmm2, [rip+0x100]
    vpdpbuuds xmm1, xmm2, [0x1000]
    vpdpbuuds xmm1, xmm2, [r13]
    vpdpbuuds ymm1, ymm2, [rax]
    vpdpbuuds ymm1, ymm2, [rax+0x7f]
    vpdpbuuds ymm1, ymm2, [rax+0x80]
    vpdpbuuds ymm1, ymm2, [rax+rbx*4]
    vpdpbuuds ymm1, ymm2, [rbx*8+0x10]
    vpdpbuuds ymm1, ymm2, [rip+0x100]
    vpdpbuuds ymm1, ymm2, [0x1000]
    vpdpbuuds ymm1, ymm2, [r13]
    vpdpbusd xmm1, xmm2, [rax]
    vpdpbusd xmm1, xmm2, [rax+0x7f]
    vpdpbusd xmm1, xmm2, [rax+0x80]
    vpdpbusd xmm1, xmm2, [rax+rbx*4]
    vpdpbusd xmm1, xmm2, [rbx*8+0x10]
    vpdpbusd xmm1, xmm2, [rip+0x100]
    vpdpbusd xmm1, xmm2, [0x1000]
    vpdpbusd xmm1, xmm2, [r13]
    vpdpbusd ymm1, ymm2, [rax]
    vpdpbusd ymm1, ymm2, [rax+0x7f]
    vpdpbusd ymm1, ymm2, [rax+0x80]
    vpdpbusd ymm1, ymm2, [rax+rbx*4]
    vpdpbusd ymm1, ymm2, [rbx*8+0x10]
    vpdpbusd ymm1, ymm2, [rip+0x100]
    vpdpbusd ymm1, ymm2, [0x1000]
    vpdpbusd ymm1, ymm2, [r13]
    vpdpbusds xmm1, xmm2, [rax]
    vpdpbusds xmm1, xmm2, [rax+0x7f]
    vpdpbusds xmm1, xmm2, [rax+0x80]
    vpdpbusds xmm1, xmm2, [rax+rbx*4]
    vpdpbusds xmm1, xmm2, [rbx*8+0x10]
    vpdpbusds xmm1, xmm2, [rip+0x100]
    vpdpbusds xmm1, xmm2, [0x1000]
    vpdpbusds xmm1, xmm2, [r13]
    vpdpbusds ymm1, ymm2, [rax]
    vpdpbusds ymm1, ymm2, [rax+0x7f]
    vpdpbusds ymm1, ymm2, [rax+0x80]
    vpdpbusds ymm1, ymm2, [rax+rbx*4]
    vpdpbusds ymm1, ymm2, [rbx*8+0x10]
    vpdpbusds ymm1, ymm2, [rip+0x100]
    vpdpbusds ymm1, ymm2, [0x1000]
    vpdpbusds ymm1, ymm2, [r13]
    vpdpwssd xmm1, xmm2, [rax]
    vpdpwssd xmm1, xmm2, [rax+0x7f]
    vpdpwssd xmm1, xmm2, [rax+0x80]
    vpdpwssd xmm1, xmm2, [rax+rbx*4]
    vpdpwssd xmm1, xmm2, [rbx*8+0x10]
    vpdpwssd xmm1, xmm2, [rip+0x100]
    vpdpwssd xmm1, xmm2, [0x1000]
    vpdpwssd xmm1, xmm2, [r13]
    vpdpwssd ymm1, ymm2, [rax]
    vpdpwssd ymm1, ymm2, [rax+0x7f]
    vpdpwssd ymm1, ymm2, [rax+0x80]
    vpdpwssd ymm1, ymm2, [rax+rbx*4]
    vpdpwssd ymm1, ymm2, [rbx*8+0x10]
    vpdpwssd ymm1, ymm2, [rip+0x100]
    vpdpwssd ymm1, ymm2, [0x1000]
    vpdpwssd ymm1, ymm2, [r13]
    vpdpwssds xmm1, xmm2, [rax]
    vpdpwssds xmm1, xmm2, [rax+0x7f]
    vpdpwssds xmm1, xmm2, [rax+0x80]
    vpdpwssds xmm1, xmm2, [rax+rbx*4]
    vpdpwssds xmm1, xmm2, [rbx*8+0x10]
    vpdpwssds xmm1, xmm2, [rip+0x100]
    vpdpwssds xmm1, xmm2, [0x1000]
    vpdpwssds xmm1, xmm2, [r13]
    vpdpwssds ymm1, ymm2, [rax]
    vpdpwssds ymm1, ymm2, [rax+0x7f]
    vpdpwssds ymm1, ymm2, [rax+0x80]
    vpdpwssds ymm1, ymm2, [rax+rbx*4]
    vpdpwssds ymm1, ymm2, [rbx*8+0x10]
    vpdpwssds ymm1, ymm2, [rip+0x100]
    vpdpwssds ymm1, ymm2, [0x1000]
    vpdpwssds ymm1, ymm2, [r13]
    vpdpwsud xmm1, xmm2, [rax]
    vpdpwsud xmm1, xmm2, [rax+0x7f]
    vpdpwsud xmm1, xmm2, [rax+0x80]
    vpdpwsud xmm1, xmm2, [rax+rbx*4]
    vpdpwsud xmm1, xmm2, [rbx*8+0x10]
    vpdpwsud xmm1, xmm2, [rip+0x100]
    vpdpwsud xmm1, xmm2, [0x1000]
    vpdpwsud xmm1, xmm2, [r13]
    vpdpwsud ymm1, ymm2, [rax]
    vpdpwsud ymm1, ymm2, [rax+0x7f]
    vpdpwsud ymm1, ymm2, [rax+0x80]
    vpdpwsud ymm1, ymm2, [rax+rbx*4]
    vpdpwsud ymm1, ymm2, [rbx*8+0x10]
    vpdpwsud ymm1, ymm2, [rip+0x100]
    vpdpwsud ymm1, ymm2, [0x1000]
    vpdpwsud ymm1, ymm2, [r13]
    vpdpwsuds xmm1, xmm2, [rax]
    vpdpwsuds xmm1, xmm2, [rax+0x7f]
    vpdpwsuds xmm1, xmm2, [rax+0x80]
    vpdpwsuds xmm1, xmm2, [rax+rbx*4]
    vpdpwsuds xmm1, xmm2, [rbx*8+0x10]
    vpdpwsuds xmm1, xmm2, [rip+0x100]
    vpdpwsuds xmm1, xmm2, [0x1000]
    vpdpwsuds xmm1, xmm2, [r13]
    vpdpwsuds ymm1, ymm2, [rax]
    vpdpwsuds ymm1, ymm2, [rax+0x7f]
    vpdpwsuds ymm1, ymm2, [rax+0x80]
    vpdpwsuds ymm1, ymm2, [rax+rbx*4]
    vpdpwsuds ymm1, ymm2, [rbx*8+0x10]
    vpdpwsuds ymm1, ymm2, [rip+0x100]
    vpdpwsuds ymm1, ymm2, [0x1000]
    vpdpwsuds ymm1, ymm2, [r13]
    vpdpwusd xmm1, xmm2, [rax]
    vpdpwusd xmm1, xmm2, [rax+0x7f]
    vpdpwusd xmm1, xmm2, [rax+0x80]
    vpdpwusd xmm1, xmm2, [rax+rbx*4]
    vpdpwusd xmm1, xmm2, [rbx*8+0x10]
    vpdpwusd xmm1, xmm2, [rip+0x100]
    vpdpwusd xmm1, xmm2, [0x1000]
    vpdpwusd xmm1, xmm2, [r13]
    vpdpwusd ymm1, ymm2, [rax]
    vpdpwusd ymm1, ymm2, [rax+0x7f]
    vpdpwusd ymm1, ymm2, [rax+0x80]
    vpdpwusd ymm1, ymm2, [rax+rbx*4]
    vpdpwusd ymm1, ymm2, [rbx*8+0x10]
    vpdpwusd ymm1, ymm2, [rip+0x100]
    vpdpwusd ymm1, ymm2, [0x1000]
    vpdpwusd ymm1, ymm2, [r13]
    vpdpwusds xmm1, xmm2, [rax]
    vpdpwusds xmm1, xmm2, [rax+0x7f]
    vpdpwusds xmm1, xmm2, [rax+0x80]
    vpdpwusds xmm1, xmm2, [rax+rbx*4]
    vpdpwusds xmm1, xmm2, [rbx*8+0x10]
    vpdpwusds xmm1, xmm2, [rip+0x100]
    vpdpwusds xmm1, xmm2, [0x1000]
    vpdpwusds xmm1, xmm2, [r13]
    vpdpwusds ymm1, ymm2, [rax]
    vpdpwusds ymm1, ymm2, [rax+0x7f]
    vpdpwusds ymm1, ymm2, [rax+0x80]
    vpdpwusds ymm1, ymm2, [rax+rbx*4]
    vpdpwusds ymm1, ymm2, [rbx*8+0x10]
    vpdpwusds ymm1, ymm2, [rip+0x100]
    vpdpwusds ymm1, ymm2, [0x1000]
    vpdpwusds ymm1, ymm2, [r13]
    vpdpwuud xmm1, xmm2, [rax]
    vpdpwuud xmm1, xmm2, [rax+0x7f]
    vpdpwuud xmm1, xmm2, [rax+0x80]
    vpdpwuud xmm1, xmm2, [rax+rbx*4]
    vpdpwuud xmm1, xmm2, [rbx*8+0x10]
    vpdpwuud xmm1, xmm2, [rip+0x100]
    vpdpwuud xmm1, xmm2, [0x1000]
    vpdpwuud xmm1, xmm2, [r13]
    vpdpwuud ymm1, ymm2, [rax]
    vpdpwuud ymm1, ymm2, [rax+0x7f]
    vpdpwuud ymm1, ymm2, [rax+0x80]
    vpdpwuud ymm1, ymm2, [rax+rbx*4]
    vpdpwuud ymm1, ymm2, [rbx*8+0x10]
    vpdpwuud ymm1, ymm2, [rip+0x100]
    vpdpwuud ymm1, ymm2, [0x1000]
    vpdpwuud ymm1, ymm2, [r13]
    vpdpwuuds xmm1, xmm2, [rax]
    vpdpwuuds xmm1, xmm2, [rax+0x7f]
    vpdpwuuds xmm1, xmm2, [rax+0x80]
    vpdpwuuds xmm1, xmm2, [rax+rbx*4]
    vpdpwuuds xmm1, xmm2, [rbx*8+0x10]
    vpdpwuuds xmm1, xmm2, [rip+0x100]
    vpdpwuuds xmm1, xmm2, [0x1000]
    vpdpwuuds xmm1, xmm2, [r13]
    vpdpwuuds ymm1, ymm2, [rax]
    vpdpwuuds ymm1, ymm2, [rax+0x7f]
    vpdpwuuds ymm1, ymm2, [rax+0x80]
    vpdpwuuds ymm1, ymm2, [rax+rbx*4]
    vpdpwuuds ymm1, ymm2, [rbx*8+0x10]
    vpdpwuuds ymm1, ymm2, [rip+0x100]
    vpdpwuuds ymm1, ymm2, [0x1000]
    vpdpwuuds ymm1, ymm2, [r13]
    vperm2f128 ymm1, ymm2, [rax], 0x1
    vperm2f128 ymm1, ymm2, [rax+0x7f], 0x1
    vperm2f128 ymm1, ymm2, [rax+0x80], 0x1
    vperm2f128 ymm1, ymm2, [rax+rbx*4], 0x1
    vperm2f128 ymm1, ymm2, [rbx*8+0x10], 0x1
    vperm2f128 ymm1, ymm2, [rip+0x100], 0x1
    vperm2f128 ymm1, ymm2, [0x1000], 0x1
    vperm2f128 ymm1, ymm2, [r13], 0x1
    vperm2i128 ymm1, ymm2, [rax], 0x1
    vperm2i128 ymm1, ymm2, [rax+0x7f], 0x1
    vperm2i128 ymm1, ymm2, [rax+0x80], 0x1
    vperm2i128 ymm1, ymm2, [rax+rbx*4], 0x1
    vperm2i128 ymm1, ymm2, [rbx*8+0x10], 0x1
    vperm2i128 ymm1, ymm2, [rip+0x100], 0x1
    vperm2i128 ymm1, ymm2, [0x1000], 0x1
    vperm2i128 ymm1, ymm2, [r13], 0x1
    vpermd ymm1, ymm2, [rax]
    vpermd ymm1, ymm2, [rax+0x7f]
    vpermd ymm1, ymm2, [rax+0x80]
    vpermd ymm1, ymm2, [rax+rbx*4]
    vpermd ymm1, ymm2, [rbx*8+0x10]
    vpermd ymm1, ymm2, [rip+0x100]
    vpermd ymm1, ymm2, [0x1000]
    vpermd ymm1, ymm2, [r13]
    vpermilpd xmm1, xmm2, [rax]
    vpermilpd xmm1, xmm2, [rax+0x7f]
    vpermilpd xmm1, xmm2, [rax+0x80]
    vpermilpd xmm1, xmm2, [rax+rbx*4]
    vpermilpd xmm1, xmm2, [rbx*8+0x10]
    vpermilpd xmm1, xmm2, [rip+0x100]
    vpermilpd xmm1, xmm2, [0x1000]
    vpermilpd xmm1, xmm2, [r13]
    vpermilpd ymm1, ymm2, [rax]
    vpermilpd ymm1, ymm2, [rax+0x7f]
    vpermilpd ymm1, ymm2, [rax+0x80]
    vpermilpd ymm1, ymm2, [rax+rbx*4]
    vpermilpd ymm1, ymm2, [rbx*8+0x10]
    vpermilpd ymm1, ymm2, [rip+0x100]
    vpermilpd ymm1, ymm2, [0x1000]
    vpermilpd ymm1, ymm2, [r13]
    vpermilpd xmm1, [rax], 0x1
    vpermilpd xmm1, [rax+0x7f], 0x1
    vpermilpd xmm1, [rax+0x80], 0x1
    vpermilpd xmm1, [rax+rbx*4], 0x1
    vpermilpd xmm1, [rbx*8+0x10], 0x1
    vpermilpd xmm1, [rip+0x100], 0x1
    vpermilpd xmm1, [0x1000], 0x1
    vpermilpd xmm1, [r13], 0x1
    vpermilpd ymm1, [rax], 0x1
    vpermilpd ymm1, [rax+0x7f], 0x1
    vpermilpd ymm1, [rax+0x80], 0x1
    vpermilpd ymm1, [rax+rbx*4], 0x1
    vpermilpd ymm1, [rbx*8+0x10], 0x1
    vpermilpd ymm1, [rip+0x100], 0x1
    vpermilpd ymm1, [0x1000], 0x1
    vpermilpd ymm1, [r13], 0x1
    vpermilps xmm1, xmm2, [rax]
    vpermilps xmm1, xmm2, [rax+0x7f]
    vpermilps xmm1, xmm2, [rax+0x80]
    vpermilps xmm1, xmm2, [rax+rbx*4]
    vpermilps xmm1, xmm2, [rbx*8+0x10]
    vpermilps xmm1, xmm2, [rip+0x100]
    vpermilps xmm1, xmm2, [0x1000]
    vpermilps xmm1, xmm2, [r13]
    vpermilps xmm1, [rax], 0x1
    vpermilps xmm1, [rax+0x7f], 0x1
    vpermilps xmm1, [rax+0x80], 0x1
    vpermilps xmm1, [rax+rbx*4], 0x1
    vpermilps xmm1, [rbx*8+0x10], 0x1
    vpermilps xmm1, [rip+0x100], 0x1
    vpermilps xmm1, [0x1000], 0x1
    vpermilps xmm1, [r13], 0x1
    vpermilps ymm1, ymm2, [rax]
    vpermilps ymm1, ymm2, [rax+0x7f]
    vpermilps ymm1, ymm2, [rax+0x80]
    vpermilps ymm1, ymm2, [rax+rbx*4]
    vpermilps ymm1, ymm2, [rbx*8+0x10]
    vpermilps ymm1, ymm2, [rip+0x100]
    vpermilps ymm1, ymm2, [0x1000]
    vpermilps ymm1, ymm2, [r13]
    vpermilps ymm1, [rax], 0x1
    vpermilps ymm1, [rax+0x7f], 0x1
    vpermilps ymm1, [rax+0x80], 0x1
    vpermilps ymm1, [rax+rbx*4], 0x1
    vpermilps ymm1, [rbx*8+0x10], 0x1
    vpermilps ymm1, [rip+0x100], 0x1
    vpermilps ymm1, [0x1000], 0x1
    vpermilps ymm1, [r13], 0x1
    vpermpd ymm1, [rax], 0x1
    vpermpd ymm1, [rax+0x7f], 0x1
    vpermpd ymm1, [rax+0x80], 0x1
    vpermpd ymm1, [rax+rbx*4], 0x1
    vpermpd ymm1, [rbx*8+0x10], 0x1
    vpermpd ymm1, [rip+0x100], 0x1
    vpermpd ymm1, [0x1000], 0x1
    vpermpd ymm1, [r13], 0x1
    vpermps ymm1, ymm2, [rax]
    vpermps ymm1, ymm2, [rax+0x7f]
    vpermps ymm1, ymm2, [rax+0x80]
    vpermps ymm1, ymm2, [rax+rbx*4]
    vpermps ymm1, ymm2, [rbx*8+0x10]
    vpermps ymm1, ymm2, [rip+0x100]
    vpermps ymm1, ymm2, [0x1000]
    vpermps ymm1, ymm2, [r13]
    vpermq ymm1, [rax], 0x1
    vpermq ymm1, [rax+0x7f], 0x1
    vpermq ymm1, [rax+0x80], 0x1
    vpermq ymm1, [rax+rbx*4], 0x1
    vpermq ymm1, [rbx*8+0x10], 0x1
    vpermq ymm1, [rip+0x100], 0x1
    vpermq ymm1, [0x1000], 0x1
    vpermq ymm1, [r13], 0x1
    vpmadd52huq xmm1, xmm2, [rax]
    vpmadd52huq xmm1, xmm2, [rax+0x7f]
    vpmadd52huq xmm1, xmm2, [rax+0x80]
    vpmadd52huq xmm1, xmm2, [rax+rbx*4]
    vpmadd52huq xmm1, xmm2, [rbx*8+0x10]
    vpmadd52huq xmm1, xmm2, [rip+0x100]
    vpmadd52huq xmm1, xmm2, [0x1000]
    vpmadd52huq xmm1, xmm2, [r13]
    vpmadd52huq ymm1, ymm2, [rax]
    vpmadd52huq ymm1, ymm2, [rax+0x7f]
    vpmadd52huq ymm1, ymm2, [rax+0x80]
    vpmadd52huq ymm1, ymm2, [rax+rbx*4]
    vpmadd52huq ymm1, ymm2, [rbx*8+0x10]
    vpmadd52huq ymm1, ymm2, [rip+0x100]
    vpmadd52huq ymm1, ymm2, [0x1000]
    vpmadd52huq ymm1, ymm2, [r13]
    vpmadd52luq xmm1, xmm2, [rax]
    vpmadd52luq xmm1, xmm2, [rax+0x7f]
    vpmadd52luq xmm1, xmm2, [rax+0x80]
    vpmadd52luq xmm1, xmm2, [rax+rbx*4]
    vpmadd52luq xmm1, xmm2, [rbx*8+0x10]
    vpmadd52luq xmm1, xmm2, [rip+0x100]
    vpmadd52luq xmm1, xmm2, [0x1000]
    vpmadd52luq xmm1, xmm2, [r13]
    vpmadd52luq ymm1, ymm2, [rax]
    vpmadd52luq ymm1, ymm2, [rax+0x7f]
    vpmadd52luq ymm1, ymm2, [rax+0x80]
    vpmadd52luq ymm1, ymm2, [rax+rbx*4]
    vpmadd52luq ymm1, ymm2, [rbx*8+0x10]
    vpmadd52luq ymm1, ymm2, [rip+0x100]
    vpmadd52luq ymm1, ymm2, [0x1000]
    vpmadd52luq ymm1, ymm2, [r13]
    vpmaskmovd xmm1, xmm2, [rax]
    vpmaskmovd xmm1, xmm2, [rax+0x7f]
    vpmaskmovd xmm1, xmm2, [rax+0x80]
    vpmaskmovd xmm1, xmm2, [rax+rbx*4]
    vpmaskmovd xmm1, xmm2, [rbx*8+0x10]
    vpmaskmovd xmm1, xmm2, [rip+0x100]
    vpmaskmovd xmm1, xmm2, [0x1000]
    vpmaskmovd xmm1, xmm2, [r13]
    vpmaskmovd ymm1, ymm2, [rax]
    vpmaskmovd ymm1, ymm2, [rax+0x7f]
    vpmaskmovd ymm1, ymm2, [rax+0x80]
    vpmaskmovd ymm1, ymm2, [rax+rbx*4]
    vpmaskmovd ymm1, ymm2, [rbx*8+0x10]
    vpmaskmovd ymm1, ymm2, [rip+0x100]
    vpmaskmovd ymm1, ymm2, [0x1000]
    vpmaskmovd ymm1, ymm2, [r13]
    vpmaskmovq xmm1, xmm2, [rax]
    vpmaskmovq xmm1, xmm2, [rax+0x7f]
    vpmaskmovq xmm1, xmm2, [rax+0x80]
    vpmaskmovq xmm1, xmm2, [rax+rbx*4]
    vpmaskmovq xmm1, xmm2, [rbx*8+0x10]
    vpmaskmovq xmm1, xmm2, [rip+0x100]
    vpmaskmovq xmm1, xmm2, [0x1000]
    vpmaskmovq xmm1, xmm2, [r13]
    vpmaskmovq ymm1, ymm2, [rax]
    vpmaskmovq ymm1, ymm2, [rax+0x7f]
    vpmaskmovq ymm1, ymm2, [rax+0x80]
    vpmaskmovq ymm1, ymm2, [rax+rbx*4]
    vpmaskmovq ymm1, ymm2, [rbx*8+0x10]
    vpmaskmovq ymm1, ymm2, [rip+0x100]
    vpmaskmovq ymm1, ymm2, [0x1000]
    vpmaskmovq ymm1, ymm2, [r13]
    vpmaskmovd [rax], xmm1, xmm2
    vpmaskmovd [rax+0x7f], xmm1, xmm2
    vpmaskmovd [rax+0x80], xmm1, xmm2
    vpmaskmovd [rax+rbx*4], xmm1, xmm2
    vpmaskmovd [rbx*8+0x10], xmm1, xmm2
    vpmaskmovd [rip+0x100], xmm1, xmm2
    vpmaskmovd [0x1000], xmm1, xmm2
    vpmaskmovd [r13], xmm1, xmm2
    vpmaskmovd [rax], ymm1, ymm2
    vpmaskmovd [rax+0x7f], ymm1, ymm2
    vpmaskmovd [rax+0x80], ymm1, ymm2
    vpmaskmovd [rax+rbx*4], ymm1, ymm2
    vpmaskmovd [rbx*8+0x10], ymm1, ymm2
    vpmaskmovd [rip+0x100], ymm1, ymm2
    vpmaskmovd [0x1000], ymm1, ymm2
    vpmaskmovd [r13], ymm1, ymm2
    vpmaskmovq [rax], xmm1, xmm2
    vpmaskmovq [rax+0x7f], xmm1, xmm2
    vpmaskmovq [rax+0x80], xmm1, xmm2
    vpmaskmovq [rax+rbx*4], xmm1, xmm2
    vpmaskmovq [rbx*8+0x10], xmm1, xmm2
    vpmaskmovq [rip+0x100], xmm1, xmm2
    vpmaskmovq [0x1000], xmm1, xmm2
    vpmaskmovq [r13], xmm1, xmm2
    vpmaskmovq [rax], ymm1, ymm2
    vpmaskmovq [rax+0x7f], ymm1, ymm2
    vpmaskmovq [rax+0x80], ymm1, ymm2
    vpmaskmovq [rax+rbx*4], ymm1, ymm2
    vpmaskmovq [rbx*8+0x10], ymm1, ymm2
    vpmaskmovq [rip+0x100], ymm1, ymm2
    vpmaskmovq [0x1000], ymm1, ymm2
    vpmaskmovq [r13], ymm1, ymm2
    vpsllvd xmm1, xmm2, [rax]
    vpsllvd xmm1, xmm2, [rax+0x7f]
    vpsllvd xmm1, xmm2, [rax+0x80]
    vpsllvd xmm1, xmm2, [rax+rbx*4]
    vpsllvd xmm1, xmm2, [rbx*8+0x10]
    vpsllvd xmm1, xmm2, [rip+0x100]
    vpsllvd xmm1, xmm2, [0x1000]
    vpsllvd xmm1, xmm2, [r13]
    vpsllvq xmm1, xmm2, [rax]
    vpsllvq xmm1, xmm2, [rax+0x7f]
    vpsllvq xmm1, xmm2, [rax+0x80]
    vpsllvq xmm1, xmm2, [rax+rbx*4]
    vpsllvq xmm1, xmm2, [rbx*8+0x10]
    vpsllvq xmm1, xmm2, [rip+0x100]
    vpsllvq xmm1, xmm2, [0x1000]
    vpsllvq xmm1, xmm2, [r13]
    vpsllvd ymm1, ymm2, [rax]
    vpsllvd ymm1, ymm2, [rax+0x7f]
    vpsllvd ymm1, ymm2, [rax+0x80]
    vpsllvd ymm1, ymm2, [rax+rbx*4]
    vpsllvd ymm1, ymm2, [rbx*8+0x10]
    vpsllvd ymm1, ymm2, [rip+0x100]
    vpsllvd ymm1, ymm2, [0x1000]
    vpsllvd ymm1, ymm2, [r13]
    vpsllvq ymm1, ymm2, [rax]
    vpsllvq ymm1, ymm2, [rax+0x7f]
    vpsllvq ymm1, ymm2, [rax+0x80]
    vpsllvq ymm1, ymm2, [rax+rbx*4]
    vpsllvq ymm1, ymm2, [rbx*8+0x10]
    vpsllvq ymm1, ymm2, [rip+0x100]
    vpsllvq ymm1, ymm2, [0x1000]
    vpsllvq ymm1, ymm2, [r13]
    vpsravd xmm1, xmm2, [rax]
    vpsravd xmm1, xmm2, [rax+0x7f]
    vpsravd xmm1, xmm2, [rax+0x80]
    vpsravd xmm1, xmm2, [rax+rbx*4]
    vpsravd xmm1, xmm2, [rbx*8+0x10]
    vpsravd xmm1, xmm2, [rip+0x100]
    vpsravd xmm1, xmm2, [0x1000]
    vpsravd xmm1, xmm2, [r13]
    vpsravd ymm1, ymm2, [rax]
    vpsravd ymm1, ymm2, [rax+0x7f]
    vpsravd ymm1, ymm2, [rax+0x80]
    vpsravd ymm1, ymm2, [rax+rbx*4]
    vpsravd ymm1, ymm2, [rbx*8+0x10]
    vpsravd ymm1, ymm2, [rip+0x100]
    vpsravd ymm1, ymm2, [0x1000]
    vpsravd ymm1, ymm2, [r13]
    vpsrlvd xmm1, xmm2, [rax]
    vpsrlvd xmm1, xmm2, [rax+0x7f]
    vpsrlvd xmm1, xmm2, [rax+0x80]
    vpsrlvd xmm1, xmm2, [rax+rbx*4]
    vpsrlvd xmm1, xmm2, [rbx*8+0x10]
    vpsrlvd xmm1, xmm2, [rip+0x100]
    vpsrlvd xmm1, xmm2, [0x1000]
    vpsrlvd xmm1, xmm2, [r13]
    vpsrlvq xmm1, xmm2, [rax]
    vpsrlvq xmm1, xmm2, [rax+0x7f]
    vpsrlvq xmm1, xmm2, [rax+0x80]
    vpsrlvq xmm1, xmm2, [rax+rbx*4]
    vpsrlvq xmm1, xmm2, [rbx*8+0x10]
    vpsrlvq xmm1, xmm2, [rip+0x100]
    vpsrlvq xmm1, xmm2, [0x1000]
    vpsrlvq xmm1, xmm2, [r13]
    vpsrlvd ymm1, ymm2, [rax]
    vpsrlvd ymm1, ymm2, [rax+0x7f]
    vpsrlvd ymm1, ymm2, [rax+0x80]
    vpsrlvd ymm1, ymm2, [rax+rbx*4]
    vpsrlvd ymm1, ymm2, [rbx*8+0x10]
    vpsrlvd ymm1, ymm2, [rip+0x100]
    vpsrlvd ymm1, ymm2, [0x1000]
    vpsrlvd ymm1, ymm2, [r13]
    vpsrlvq ymm1, ymm2, [rax]
    vpsrlvq ymm1, ymm2, [rax+0x7f]
    vpsrlvq ymm1, ymm2, [rax+0x80]
    vpsrlvq ymm1, ymm2, [rax+rbx*4]
    vpsrlvq ymm1, ymm2, [rbx*8+0x10]
    vpsrlvq ymm1, ymm2, [rip+0x100]
    vpsrlvq ymm1, ymm2, [0x1000]
    vpsrlvq ymm1, ymm2, [r13]
    vsm3msg1 xmm1, xmm2, [rax]
    vsm3msg1 xmm1, xmm2, [rax+0x7f]
    vsm3msg1 xmm1, xmm2, [rax+0x80]
    vsm3msg1 xmm1, xmm2, [rax+rbx*4]
    vsm3msg1 xmm1, xmm2, [rbx*8+0x10]
    vsm3msg1 xmm1, xmm2, [rip+0x100]
    vsm3msg1 xmm1, xmm2, [0x1000]
    vsm3msg1 xmm1, xmm2, [r13]
    vsm3msg2 xmm1, xmm2, [rax]
    vsm3msg2 xmm1, xmm2, [rax+0x7f]
    vsm3msg2 xmm1, xmm2, [rax+0x80]
    vsm3msg2 xmm1, xmm2, [rax+rbx*4]
    vsm3msg2 xmm1, xmm2, [rbx*8+0x10]
    vsm3msg2 xmm1, xmm2, [rip+0x100]
    vsm3msg2 xmm1, xmm2, [0x1000]
    vsm3msg2 xmm1, xmm2, [r13]
    vsm3rnds2 xmm1, xmm2, [rax], 0x1
    vsm3rnds2 xmm1, xmm2, [rax+0x7f], 0x1
    vsm3rnds2 xmm1, xmm2, [rax+0x80], 0x1
    vsm3rnds2 xmm1, xmm2, [rax+rbx*4], 0x1
    vsm3rnds2 xmm1, xmm2, [rbx*8+0x10], 0x1
    vsm3rnds2 xmm1, xmm2, [rip+0x100], 0x1
    vsm3rnds2 xmm1, xmm2, [0x1000], 0x1
    vsm3rnds2 xmm1, xmm2, [r13], 0x1
    vsm4key4 xmm1, xmm2, [rax]
    vsm4key4 xmm1, xmm2, [rax+0x7f]
    vsm4key4 xmm1, xmm2, [rax+0x80]
    vsm4key4 xmm1, xmm2, [rax+rbx*4]
    vsm4key4 xmm1, xmm2, [rbx*8+0x10]
    vsm4key4 xmm1, xmm2, [rip+0x100]
    vsm4key4 xmm1, xmm2, [0x1000]
    vsm4key4 xmm1, xmm2, [r13]
    vsm4key4 ymm1, ymm2, [rax]
    vsm4key4 ymm1, ymm2, [rax+0x7f]
    vsm4key4 ymm1, ymm2, [rax+0x80]
    vsm4key4 ymm1, ymm2, [rax+rbx*4]
    vsm4key4 ymm1, ymm2, [rbx*8+0x10]
    vsm4key4 ymm1, ymm2, [rip+0x100]
    vsm4key4 ymm1, ymm2, [0x1000]
    vsm4key4 ymm1, ymm2, [r13]
    vsm4rnds4 xmm1, xmm2, [rax]
    vsm4rnds4 xmm1, xmm2, [rax+0x7f]
    vsm4rnds4 xmm1, xmm2, [rax+0x80]
    vsm4rnds4 xmm1, xmm2, [rax+rbx*4]
    vsm4rnds4 xmm1, xmm2, [rbx*8+0x10]
    vsm4rnds4 xmm1, xmm2, [rip+0x100]
    vsm4rnds4 xmm1, xmm2, [0x1000]
    vsm4rnds4 xmm1, xmm2, [r13]
    vsm4rnds4 ymm1, ymm2, [rax]
    vsm4rnds4 ymm1, ymm2, [rax+0x7f]
    vsm4rnds4 ymm1, ymm2, [rax+0x80]
    vsm4rnds4 ymm1, ymm2, [rax+rbx*4]
    vsm4rnds4 ymm1, ymm2, [rbx*8+0x10]
    vsm4rnds4 ymm1, ymm2, [rip+0x100]
    vsm4rnds4 ymm1, ymm2, [0x1000]
    vsm4rnds4 ymm1, ymm2, [r13]
    vtestps xmm1, [rax]
    vtestps xmm1, [rax+0x7f]
    vtestps xmm1, [rax+0x80]
    vtestps xmm1, [rax+rbx*4]
    vtestps xmm1, [rbx*8+0x10]
    vtestps xmm1, [rip+0x100]
    vtestps xmm1, [0x1000]
    vtestps xmm1, [r13]
    vtestps ymm1, [rax]
    vtestps ymm1, [rax+0x7f]
    vtestps ymm1, [rax+0x80]
    vtestps ymm1, [rax+rbx*4]
    vtestps ymm1, [rbx*8+0x10]
    vtestps ymm1, [rip+0x100]
    vtestps ymm1, [0x1000]
    vtestps ymm1, [r13]
    vtestpd xmm1, [rax]
    vtestpd xmm1, [rax+0x7f]
    vtestpd xmm1, [rax+0x80]
    vtestpd xmm1, [rax+rbx*4]
    vtestpd xmm1, [rbx*8+0x10]
    vtestpd xmm1, [rip+0x100]
    vtestpd xmm1, [0x1000]
    vtestpd xmm1, [r13]
    vtestpd ymm1, [rax]
    vtestpd ymm1, [rax+0x7f]
    vtestpd ymm1, [rax+0x80]
    vtestpd ymm1, [rax+rbx*4]
    vtestpd ymm1, [rbx*8+0x10]
    vtestpd ymm1, [rip+0x100]
    vtestpd ymm1, [0x1000]
    vtestpd ymm1, [r13]
    wrssd DWORD PTR [rax], eax
    wrssd DWORD PTR [rax+0x7f], eax
    wrssd DWORD PTR [rax+0x80], eax
    wrssd DWORD PTR [rax+rbx*4], eax
    wrssd DWORD PTR [rbx*8+0x10], eax
    wrssd DWORD PTR [rip+0x100], eax
    wrssd DWORD PTR [0x1000], eax
    wrssd DWORD PTR [r13], eax
    wrssq QWORD PTR [rax], rax
    wrssq QWORD PTR [rax+0x7f], rax
    wrssq QWORD PTR [rax+0x80], rax
    wrssq QWORD PTR [rax+rbx*4], rax
    wrssq QWORD PTR [rbx*8+0x10], rax
    wrssq QWORD PTR [rip+0x100], rax
    wrssq QWORD PTR [0x1000], rax
    wrssq QWORD PTR [r13], rax
    wrussd DWORD PTR [rax], eax
    wrussd DWORD PTR [rax+0x7f], eax
    wrussd DWORD PTR [rax+0x80], eax
    wrussd DWORD PTR [rax+rbx*4], eax
    wrussd DWORD PTR [rbx*8+0x10], eax
    wrussd DWORD PTR [rip+0x100], eax
    wrussd DWORD PTR [0x1000], eax
    wrussd DWORD PTR [r13], eax
    wrussq QWORD PTR [rax], rax
    wrussq QWORD PTR [rax+0x7f], rax
    wrussq QWORD PTR [rax+0x80], rax
    wrussq QWORD PTR [rax+rbx*4], rax
    wrussq QWORD PTR [rbx*8+0x10], rax
    wrussq QWORD PTR [rip+0x100], rax
    wrussq QWORD PTR [0x1000], rax
    wrussq QWORD PTR [r13], rax
    xadd BYTE PTR [rax], al
    xadd BYTE PTR [rax+0x7f], al
    xadd BYTE PTR [rax+0x80], al
    xadd BYTE PTR [rax+rbx*4], al
    xadd BYTE PTR [rbx*8+0x10], al
    xadd BYTE PTR [rip+0x100], al
    xadd BYTE PTR [0x1000], al
    xadd BYTE PTR [r13], al
    xadd WORD PTR [rax], ax
    xadd WORD PTR [rax+0x7f], ax
    xadd WORD PTR [rax+0x80], ax
    xadd WORD PTR [rax+rbx*4], ax
    xadd WORD PTR [rbx*8+0x10], ax
    xadd WORD PTR [rip+0x100], ax
    xadd WORD PTR [0x1000], ax
    xadd WORD PTR [r13], ax
    xadd DWORD PTR [rax], eax
    xadd DWORD PTR [rax+0x7f], eax
    xadd DWORD PTR [rax+0x80], eax
    xadd DWORD PTR [rax+rbx*4], eax
    xadd DWORD PTR [rbx*8+0x10], eax
    xadd DWORD PTR [rip+0x100], eax
    xadd DWORD PTR [0x1000], eax
    xadd DWORD PTR [r13], eax
    xadd QWORD PTR [rax], rax
    xadd QWORD PTR [rax+0x7f], rax
    xadd QWORD PTR [rax+0x80], rax
    xadd QWORD PTR [rax+rbx*4], rax
    xadd QWORD PTR [rbx*8+0x10], rax
    xadd QWORD PTR [rip+0x100], rax
    xadd QWORD PTR [0x1000], rax
    xadd QWORD PTR [r13], rax
    xchg BYTE PTR [rax], al
    xchg BYTE PTR [rax+0x7f], al
    xchg BYTE PTR [rax+0x80], al
    xchg BYTE PTR [rax+rbx*4], al
    xchg BYTE PTR [rbx*8+0x10], al
    xchg BYTE PTR [rip+0x100], al
    xchg BYTE PTR [0x1000], al
    xchg BYTE PTR [r13], al
    xchg al, BYTE PTR [rax]
    xchg al, BYTE PTR [rax+0x7f]
    xchg al, BYTE PTR [rax+0x80]
    xchg al, BYTE PTR [rax+rbx*4]
    xchg al, BYTE PTR [rbx*8+0x10]
    xchg al, BYTE PTR [rip+0x100]
    xchg al, BYTE PTR [0x1000]
    xchg al, BYTE PTR [r13]
    xchg WORD PTR [rax], ax
    xchg WORD PTR [rax+0x7f], ax
    xchg WORD PTR [rax+0x80], ax
    xchg WORD PTR [rax+rbx*4], ax
    xchg WORD PTR [rbx*8+0x10], ax
    xchg WORD PTR [rip+0x100], ax
    xchg WORD PTR [0x1000], ax
    xchg WORD PTR [r13], ax
    xchg ax, WORD PTR [rax]
    xchg ax, WORD PTR [rax+0x7f]
    xchg ax, WORD PTR [rax+0x80]
    xchg ax, WORD PTR [rax+rbx*4]
    xchg ax, WORD PTR [rbx*8+0x10]
    xchg ax, WORD PTR [rip+0x100]
    xchg ax, WORD PTR [0x1000]
    xchg ax, WORD PTR [r13]
    xchg DWORD PTR [rax], eax
    xchg DWORD PTR [rax+0x7f], eax
    xchg DWORD PTR [rax+0x80], eax
    xchg DWORD PTR [rax+rbx*4], eax
    xchg DWORD PTR [rbx*8+0x10], eax
    xchg DWORD PTR [rip+0x100], eax
    xchg DWORD PTR [0x1000], eax
    xchg DWORD PTR [r13], eax
    xchg QWORD PTR [rax], rax
    xchg QWORD PTR [rax+0x7f], rax
    xchg QWORD PTR [rax+0x80], rax
    xchg QWORD PTR [rax+rbx*4], rax
    xchg QWORD PTR [rbx*8+0x10], rax
    xchg QWORD PTR [rip+0x100], rax
    xchg QWORD PTR [0x1000], rax
    xchg QWORD PTR [r13], rax
    xchg eax, DWORD PTR [rax]
    xchg eax, DWORD PTR [rax+0x7f]
    xchg eax, DWORD PTR [rax+0x80]
    xchg eax, DWORD PTR [rax+rbx*4]
    xchg eax, DWORD PTR [rbx*8+0x10]
    xchg eax, DWORD PTR [rip+0x100]
    xchg eax, DWORD PTR [0x1000]
    xchg eax, DWORD PTR [r13]
    xchg rax, QWORD PTR [rax]
    xchg rax, QWORD PTR [rax+0x7f]
    xchg rax, QWORD PTR [rax+0x80]
    xchg rax, QWORD PTR [rax+rbx*4]
    xchg rax, QWORD PTR [rbx*8+0x10]
    xchg rax, QWORD PTR [rip+0x100]
    xchg rax, QWORD PTR [0x1000]
    xchg rax, QWORD PTR [r13]
    xlat BYTE PTR [rax]
    xlat BYTE PTR [rax+0x7f]
    xlat BYTE PTR [rax+0x80]
    xlat BYTE PTR [rax+rbx*4]
    xlat BYTE PTR [rbx*8+0x10]
    xlat BYTE PTR [rip+0x100]
    xlat BYTE PTR [0x1000]
    xlat BYTE PTR [r13]
    xor BYTE PTR [rax], 0x1
    xor BYTE PTR [rax+0x7f], 0x1
    xor BYTE PTR [rax+0x80], 0x1
    xor BYTE PTR [rax+rbx*4], 0x1
    xor BYTE PTR [rbx*8+0x10], 0x1
    xor BYTE PTR [rip+0x100], 0x1
    xor BYTE PTR [0x1000], 0x1
    xor BYTE PTR [r13], 0x1
    xor WORD PTR [rax], 0x1
    xor WORD PTR [rax+0x7f], 0x1
    xor WORD PTR [rax+0x80], 0x1
    xor WORD PTR [rax+rbx*4], 0x1
    xor WORD PTR [rbx*8+0x10], 0x1
    xor WORD PTR [rip+0x100], 0x1
    xor WORD PTR [0x1000], 0x1
    xor WORD PTR [r13], 0x1
    xor DWORD PTR [rax], 0x1
    xor DWORD PTR [rax+0x7f], 0x1
    xor DWORD PTR [rax+0x80], 0x1
    xor DWORD PTR [rax+rbx*4], 0x1
    xor DWORD PTR [rbx*8+0x10], 0x1
    xor DWORD PTR [rip+0x100], 0x1
    xor DWORD PTR [0x1000], 0x1
    xor DWORD PTR [r13], 0x1
    xor QWORD PTR [rax], 0x1
    xor QWORD PTR [rax+0x7f], 0x1
    xor QWORD PTR [rax+0x80], 0x1
    xor QWORD PTR [rax+rbx*4], 0x1
    xor QWORD PTR [rbx*8+0x10], 0x1
    xor QWORD PTR [rip+0x100], 0x1
    xor QWORD PTR [0x1000], 0x1
    xor QWORD PTR [r13], 0x1
    xor BYTE PTR [rax], al
    xor BYTE PTR [rax+0x7f], al
    xor BYTE PTR [rax+0x80], al
    xor BYTE PTR [rax+rbx*4], al
    xor BYTE PTR [rbx*8+0x10], al
    xor BYTE PTR [rip+0x100], al
    xor BYTE PTR [0x1000], al
    xor BYTE PTR [r13], al
    xor WORD PTR [rax], ax
    xor WORD PTR [rax+0x7f], ax
    xor WORD PTR [rax+0x80], ax
    xor WORD PTR [rax+rbx*4], ax
    xor WORD PTR [rbx*8+0x10], ax
    xor WORD PTR [rip+0x100], ax
    xor WORD PTR [0x1000], ax
    xor WORD PTR [r13], ax
    xor DWORD PTR [rax], eax
    xor DWORD PTR [rax+0x7f], eax
    xor DWORD PTR [rax+0x80], eax
    xor DWORD PTR [rax+rbx*4], eax
    xor DWORD PTR [rbx*8+0x10], eax
    xor DWORD PTR [rip+0x100], eax
    xor DWORD PTR [0x1000], eax
    xor DWORD PTR [r13], eax
    xor QWORD PTR [rax], rax
    xor QWORD PTR [rax+0x7f], rax
    xor QWORD PTR [rax+0x80], rax
    xor QWORD PTR [rax+rbx*4], rax
    xor QWORD PTR [rbx*8+0x10], rax
    xor QWORD PTR [rip+0x100], rax
    xor QWORD PTR [0x1000], rax
    xor QWORD PTR [r13], rax
    xor ax, WORD PTR [rax]
    xor ax, WORD PTR [rax+0x7f]
    xor ax, WORD PTR [rax+0x80]
    xor ax, WORD PTR [rax+rbx*4]
    xor ax, WORD PTR [rbx*8+0x10]
    xor ax, WORD PTR [rip+0x100]
    xor ax, WORD PTR [0x1000]
    xor ax, WORD PTR [r13]
    xor eax, DWORD PTR [rax]
    xor eax, DWORD PTR [rax+0x7f]
    xor eax, DWORD PTR [rax+0x80]
    xor eax, DWORD PTR [rax+rbx*4]
    xor eax, DWORD PTR [rbx*8+0x10]
    xor eax, DWORD PTR [rip+0x100]
    xor eax, DWORD PTR [0x1000]
    xor eax, DWORD PTR [r13]
    xor rax, QWORD PTR [rax]
    xor rax, QWORD PTR [rax+0x7f]
    xor rax, QWORD PTR [rax+0x80]
    xor rax, QWORD PTR [rax+rbx*4]
    xor rax, QWORD PTR [rbx*8+0x10]
    xor rax, QWORD PTR [rip+0x100]
    xor rax, QWORD PTR [0x1000]
    xor rax, QWORD PTR [r13]
    xorpd xmm1, [rax]
    xorpd xmm1, [rax+0x7f]
    xorpd xmm1, [rax+0x80]
    xorpd xmm1, [rax+rbx*4]
    xorpd xmm1, [rbx*8+0x10]
    xorpd xmm1, [rip+0x100]
    xorpd xmm1, [0x1000]
    xorpd xmm1, [r13]
    vxorpd xmm1, xmm2, [rax]
    vxorpd xmm1, xmm2, [rax+0x7f]
    vxorpd xmm1, xmm2, [rax+0x80]
    vxorpd xmm1, xmm2, [rax+rbx*4]
    vxorpd xmm1, xmm2, [rbx*8+0x10]
    vxorpd xmm1, xmm2, [rip+0x100]
    vxorpd xmm1, xmm2, [0x1000]
    vxorpd xmm1, xmm2, [r13]
    vxorpd ymm1, ymm2, [rax]
    vxorpd ymm1, ymm2, [rax+0x7f]
    vxorpd ymm1, ymm2, [rax+0x80]
    vxorpd ymm1, ymm2, [rax+rbx*4]
    vxorpd ymm1, ymm2, [rbx*8+0x10]
    vxorpd ymm1, ymm2, [rip+0x100]
    vxorpd ymm1, ymm2, [0x1000]
    vxorpd ymm1, ymm2, [r13]
    xorps xmm1, [rax]
    xorps xmm1, [rax+0x7f]
    xorps xmm1, [rax+0x80]
    xorps xmm1, [rax+rbx*4]
    xorps xmm1, [rbx*8+0x10]
    xorps xmm1, [rip+0x100]
    xorps xmm1, [0x1000]
    xorps xmm1, [r13]
    vxorps xmm1, xmm2, [rax]
    vxorps xmm1, xmm2, [rax+0x7f]
    vxorps xmm1, xmm2, [rax+0x80]
    vxorps xmm1, xmm2, [rax+rbx*4]
    vxorps xmm1, xmm2, [rbx*8+0x10]
    vxorps xmm1, xmm2, [rip+0x100]
    vxorps xmm1, xmm2, [0x1000]
    vxorps xmm1, xmm2, [r13]
    vxorps ymm1, ymm2, [rax]
    vxorps ymm1, ymm2, [rax+0x7f]
    vxorps ymm1, ymm2, [rax+0x80]
    vxorps ymm1, ymm2, [rax+rbx*4]
    vxorps ymm1, ymm2, [rbx*8+0x10]
    vxorps ymm1, ymm2, [rip+0x100]
    vxorps ymm1, ymm2, [0x1000]
    vxorps ymm1, ymm2, [r13]
    xrstor [rax]
    xrstor [rax+0x7f]
    xrstor [rax+0x80]
    xrstor [rax+rbx*4]
    xrstor [rbx*8+0x10]
    xrstor [rip+0x100]
    xrstor [0x1000]
    xrstor [r13]
    xrstor64 [rax]
    xrstor64 [rax+0x7f]
    xrstor64 [rax+0x80]
    xrstor64 [rax+rbx*4]
    xrstor64 [rbx*8+0x10]
    xrstor64 [rip+0x100]
    xrstor64 [0x1000]
    xrstor64 [r13]
    xrstors [rax]
    xrstors [rax+0x7f]
    xrstors [rax+0x80]
    xrstors [rax+rbx*4]
    xrstors [rbx*8+0x10]
    xrstors [rip+0x100]
    xrstors [0x1000]
    xrstors [r13]
    xrstors64 [rax]
    xrstors64 [rax+0x7f]
    xrstors64 [rax+0x80]
    xrstors64 [rax+rbx*4]
    xrstors64 [rbx*8+0x10]
    xrstors64 [rip+0x100]
    xrstors64 [0x1000]
    xrstors64 [r13]
    xsave [rax]
    xsave [rax+0x7f]
    xsave [rax+0x80]
    xsave [rax+rbx*4]
    xsave [rbx*8+0x10]
    xsave [rip+0x100]
    xsave [0x1000]
    xsave [r13]
    xsave64 [rax]
    xsave64 [rax+0x7f]
    xsave64 [rax+0x80]
    xsave64 [rax+rbx*4]
    xsave64 [rbx*8+0x10]
    xsave64 [rip+0x100]
    xsave64 [0x1000]
    xsave64 [r13]
    xsavec [rax]
    xsavec [rax+0x7f]
    xsavec [rax+0x80]
    xsavec [rax+rbx*4]
    xsavec [rbx*8+0x10]
    xsavec [rip+0x100]
    xsavec [0x1000]
    xsavec [r13]
    xsavec64 [rax]
    xsavec64 [rax+0x7f]
    xsavec64 [rax+0x80]
    xsavec64 [rax+rbx*4]
    xsavec64 [rbx*8+0x10]
    xsavec64 [rip+0x100]
    xsavec64 [0x1000]
    xsavec64 [r13]
    xsaveopt [rax]
    xsaveopt [rax+0x7f]
    xsaveopt [rax+0x80]
    xsaveopt [rax+rbx*4]
    xsaveopt [rbx*8+0x10]
    xsaveopt [rip+0x100]
    xsaveopt [0x1000]
    xsaveopt [r13]
    xsaveopt64 [rax]
    xsaveopt64 [rax+0x7f]
    xsaveopt64 [rax+0x80]
    xsaveopt64 [rax+rbx*4]
    xsaveopt64 [rbx*8+0x10]
    xsaveopt64 [rip+0x100]
    xsaveopt64 [0x1000]
    xsaveopt64 [r13]
    xsaves [rax]
    xsaves [rax+0x7f]
    xsaves [rax+0x80]
    xsaves [rax+rbx*4]
    xsaves [rbx*8+0x10]
    xsaves [rip+0x100]
    xsaves [0x1000]
    xsaves [r13]
    xsaves64 [rax]
    xsaves64 [rax+0x7f]
    xsaves64 [rax+0x80]
    xsaves64 [rax+rbx*4]
    xsaves64 [rbx*8+0x10]
    xsaves64 [rip+0x100]
    xsaves64 [0x1000]
    xsaves64 [r13]
    prefetchwt1 BYTE PTR [rax]
    prefetchwt1 BYTE PTR [rax+0x7f]
    prefetchwt1 BYTE PTR [rax+0x80]
    prefetchwt1 BYTE PTR [rax+rbx*4]
    prefetchwt1 BYTE PTR [rbx*8+0x10]
    prefetchwt1 BYTE PTR [rip+0x100]
    prefetchwt1 BYTE PTR [0x1000]
    prefetchwt1 BYTE PTR [r13]
