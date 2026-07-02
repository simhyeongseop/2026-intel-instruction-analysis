.intel_syntax noprefix
// Stage3 generated (register-form, masks kept, er/sae dropped)

    adc al, 0x1
    adc ax, 0x1
    adc eax, 0x1
    adc rax, 0x1
    adc al, 0x1
    adc BYTE PTR [rax], 0x1
    adc ax, 0x1
    adc WORD PTR [rax], 0x1
    adc eax, 0x1
    adc DWORD PTR [rax], 0x1
    adc rax, 0x1
    adc QWORD PTR [rax], 0x1
    adc ax, 0x1
    adc WORD PTR [rax], 0x1
    adc eax, 0x1
    adc DWORD PTR [rax], 0x1
    adc rax, 0x1
    adc QWORD PTR [rax], 0x1
    adc al, al
    adc BYTE PTR [rax], al
    adc ax, ax
    adc WORD PTR [rax], ax
    adc eax, eax
    adc DWORD PTR [rax], eax
    adc rax, rax
    adc QWORD PTR [rax], rax
    adc al, al
    adc al, BYTE PTR [rax]
    adc ax, ax
    adc ax, WORD PTR [rax]
    adc eax, eax
    adc eax, DWORD PTR [rax]
    adc rax, rax
    adc rax, QWORD PTR [rax]
    adcx eax, eax
    adcx eax, DWORD PTR [rax]
    adcx rax, rax
    adcx rax, QWORD PTR [rax]
    add al, 0x1
    add ax, 0x1
    add eax, 0x1
    add rax, 0x1
    add al, 0x1
    add BYTE PTR [rax], 0x1
    add ax, 0x1
    add WORD PTR [rax], 0x1
    add eax, 0x1
    add DWORD PTR [rax], 0x1
    add rax, 0x1
    add QWORD PTR [rax], 0x1
    add ax, 0x1
    add WORD PTR [rax], 0x1
    add eax, 0x1
    add DWORD PTR [rax], 0x1
    add rax, 0x1
    add QWORD PTR [rax], 0x1
    add al, al
    add BYTE PTR [rax], al
    add ax, ax
    add WORD PTR [rax], ax
    add eax, eax
    add DWORD PTR [rax], eax
    add rax, rax
    add QWORD PTR [rax], rax
    add al, al
    add al, BYTE PTR [rax]
    add ax, ax
    add ax, WORD PTR [rax]
    add eax, eax
    add eax, DWORD PTR [rax]
    add rax, rax
    add rax, QWORD PTR [rax]
    addpd xmm1, xmm2
    vaddpd xmm1, xmm2, xmm3
    vaddpd ymm1, ymm2, ymm3
    vaddpd xmm1{k1}{z}, xmm2, xmm3
    vaddpd ymm1{k1}{z}, ymm2, ymm3
    vaddpd zmm1{k1}{z}, zmm2, zmm3
    addps xmm1, xmm2
    vaddps xmm1, xmm2, xmm3
    vaddps ymm1, ymm2, ymm3
    vaddps xmm1{k1}{z}, xmm2, xmm3
    vaddps ymm1{k1}{z}, ymm2, ymm3
    vaddps zmm1{k1}{z}, zmm2, zmm3
    addsd xmm1, xmm2
    vaddsd xmm1, xmm2, xmm3
    vaddsd xmm1{k1}{z}, xmm2, xmm3
    addss xmm1, xmm2
    vaddss xmm1, xmm2, xmm3
    vaddss xmm1{k1}{z}, xmm2, xmm3
    addsubpd xmm1, xmm2
    vaddsubpd xmm1, xmm2, xmm3
    vaddsubpd ymm1, ymm2, ymm3
    addsubps xmm1, xmm2
    vaddsubps xmm1, xmm2, xmm3
    vaddsubps ymm1, ymm2, ymm3
    adox eax, eax
    adox eax, DWORD PTR [rax]
    adox rax, rax
    adox rax, QWORD PTR [rax]
    aesdec xmm1, xmm2
    vaesdec xmm1, xmm2, xmm3
    vaesdec ymm1, ymm2, ymm3
    vaesdec xmm1, xmm2, xmm3
    vaesdec ymm1, ymm2, ymm3
    vaesdec zmm1, zmm2, zmm3
    aesdec128kl xmm0, [rax]
    aesdec256kl xmm0, [rax]
    aesdeclast xmm1, xmm2
    vaesdeclast xmm1, xmm2, xmm3
    vaesdeclast ymm1, ymm2, ymm3
    vaesdeclast xmm1, xmm2, xmm3
    vaesdeclast ymm1, ymm2, ymm3
    vaesdeclast zmm1, zmm2, zmm3
    aesdecwide128kl [rax]
    aesdecwide256kl [rax]
    aesenc xmm1, xmm2
    vaesenc xmm1, xmm2, xmm3
    vaesenc ymm1, ymm2, ymm3
    vaesenc xmm1, xmm2, xmm3
    vaesenc ymm1, ymm2, ymm3
    vaesenc zmm1, zmm2, zmm3
    aesenc128kl xmm0, [rax]
    aesenc256kl xmm0, [rax]
    aesenclast xmm1, xmm2
    vaesenclast xmm1, xmm2, xmm3
    vaesenclast ymm1, ymm2, ymm3
    vaesenclast xmm1, xmm2, xmm3
    vaesenclast ymm1, ymm2, ymm3
    vaesenclast zmm1, zmm2, zmm3
    aesencwide128kl [rax]
    aesencwide256kl [rax]
    aesimc xmm1, xmm2
    vaesimc xmm1, xmm2
    aeskeygenassist xmm1, xmm2, 0x1
    vaeskeygenassist xmm1, xmm2, 0x1
    and al, 0x1
    and ax, 0x1
    and eax, 0x1
    and rax, 0x1
    and al, 0x1
    and BYTE PTR [rax], 0x1
    and ax, 0x1
    and WORD PTR [rax], 0x1
    and eax, 0x1
    and DWORD PTR [rax], 0x1
    and rax, 0x1
    and QWORD PTR [rax], 0x1
    and ax, 0x1
    and WORD PTR [rax], 0x1
    and eax, 0x1
    and DWORD PTR [rax], 0x1
    and rax, 0x1
    and QWORD PTR [rax], 0x1
    and ax, ax
    and WORD PTR [rax], ax
    and eax, eax
    and DWORD PTR [rax], eax
    and rax, rax
    and QWORD PTR [rax], rax
    and ax, ax
    and ax, WORD PTR [rax]
    and eax, eax
    and eax, DWORD PTR [rax]
    and rax, rax
    and rax, QWORD PTR [rax]
    andn eax, eax, eax
    andn eax, eax, DWORD PTR [rax]
    andnpd xmm1, xmm2
    vandnpd xmm1, xmm2, xmm3
    vandnpd ymm1, ymm2, ymm3
    vandnpd xmm1{k1}{z}, xmm2, xmm3
    vandnpd ymm1{k1}{z}, ymm2, ymm3
    vandnpd zmm1{k1}{z}, zmm2, zmm3
    andnps xmm1, xmm2
    vandnps xmm1, xmm2, xmm3
    vandnps ymm1, ymm2, ymm3
    vandnps xmm1{k1}{z}, xmm2, xmm3
    vandnps ymm1{k1}{z}, ymm2, ymm3
    vandnps zmm1{k1}{z}, zmm2, zmm3
    andpd xmm1, xmm2
    vandpd xmm1, xmm2, xmm3
    vandpd ymm1, ymm2, ymm3
    vandpd xmm1{k1}{z}, xmm2, xmm3
    vandpd ymm1{k1}{z}, ymm2, ymm3
    vandpd zmm1{k1}{z}, zmm2, zmm3
    andps xmm1, xmm2
    vandps xmm1, xmm2, xmm3
    vandps ymm1, ymm2, ymm3
    vandps xmm1{k1}{z}, xmm2, xmm3
    vandps ymm1{k1}{z}, ymm2, ymm3
    vandps zmm1{k1}{z}, zmm2, zmm3
    bextr eax, eax, eax
    bextr eax, DWORD PTR [rax], eax
    bextr rax, rax, rax
    bextr rax, QWORD PTR [rax], rax
    blendpd xmm1, xmm2, 0x1
    vblendpd xmm1, xmm2, xmm3, 0x1
    vblendpd ymm1, ymm2, ymm3, 0x1
    blendps xmm1, xmm2, 0x1
    vblendps xmm1, xmm2, xmm3, 0x1
    vblendps ymm1, ymm2, ymm3, 0x1
    blendvpd xmm1, xmm2
    vblendvpd xmm1, xmm2, xmm3, xmm4
    vblendvpd ymm1, ymm2, ymm3, ymm4
    blendvps xmm1, xmm2
    vblendvps xmm1, xmm2, xmm3, xmm4
    vblendvps ymm1, ymm2, ymm3, ymm4
    blsi eax, eax
    blsi eax, DWORD PTR [rax]
    blsi rax, rax
    blsi rax, QWORD PTR [rax]
    blsmsk eax, eax
    blsmsk eax, DWORD PTR [rax]
    blsmsk rax, rax
    blsmsk rax, QWORD PTR [rax]
    blsr eax, eax
    blsr eax, DWORD PTR [rax]
    blsr rax, rax
    blsr rax, QWORD PTR [rax]
    bndcl bnd0, rax
    bndcl bnd0, QWORD PTR [rax]
    bndcu bnd0, rax
    bndcu bnd0, QWORD PTR [rax]
    bndcn bnd0, rax
    bndcn bnd0, QWORD PTR [rax]
    bndldx bnd0, [rax+rbx*1]
    bndmk bnd0, QWORD PTR [rax]
    bndmov bnd1, bnd2
    bndmov bnd1, bnd2
    bndstx [rax+rbx*1], bnd0
    bsf ax, ax
    bsf ax, WORD PTR [rax]
    bsf eax, eax
    bsf eax, DWORD PTR [rax]
    bsf rax, rax
    bsf rax, QWORD PTR [rax]
    bsr ax, ax
    bsr ax, WORD PTR [rax]
    bsr eax, eax
    bsr eax, DWORD PTR [rax]
    bsr rax, rax
    bsr rax, QWORD PTR [rax]
    bswap eax
    bswap rax
    bt ax, ax
    bt WORD PTR [rax], ax
    bt eax, eax
    bt DWORD PTR [rax], eax
    bt rax, rax
    bt QWORD PTR [rax], rax
    bt ax, 0x1
    bt WORD PTR [rax], 0x1
    bt eax, 0x1
    bt DWORD PTR [rax], 0x1
    bt rax, 0x1
    bt QWORD PTR [rax], 0x1
    btc ax, ax
    btc WORD PTR [rax], ax
    btc eax, eax
    btc DWORD PTR [rax], eax
    btc rax, rax
    btc QWORD PTR [rax], rax
    btc ax, 0x1
    btc WORD PTR [rax], 0x1
    btc eax, 0x1
    btc DWORD PTR [rax], 0x1
    btc rax, 0x1
    btc QWORD PTR [rax], 0x1
    btr ax, ax
    btr WORD PTR [rax], ax
    btr eax, eax
    btr DWORD PTR [rax], eax
    btr rax, rax
    btr QWORD PTR [rax], rax
    btr ax, 0x1
    btr WORD PTR [rax], 0x1
    btr eax, 0x1
    btr DWORD PTR [rax], 0x1
    btr rax, 0x1
    btr QWORD PTR [rax], 0x1
    bts ax, ax
    bts WORD PTR [rax], ax
    bts eax, eax
    bts DWORD PTR [rax], eax
    bts rax, rax
    bts QWORD PTR [rax], rax
    bts ax, 0x1
    bts WORD PTR [rax], 0x1
    bts eax, 0x1
    bts DWORD PTR [rax], 0x1
    bts rax, 0x1
    bts QWORD PTR [rax], 0x1
    bzhi eax, eax, eax
    bzhi eax, DWORD PTR [rax], eax
    bzhi rax, rax, rax
    bzhi rax, QWORD PTR [rax], rax
    call 1f
    call rax
    call QWORD PTR [rax]
    call DWORD PTR [rax]
    call FWORD PTR [rax]
    call TBYTE PTR [rax]
    cbw
    cwde
    cdqe
    clac
    clc
    cld
    cldemote BYTE PTR [rax]
    clflush BYTE PTR [rax]
    clflushopt BYTE PTR [rax]
    cli
    clrssbsy QWORD PTR [rax]
    clts
    clui
    clwb BYTE PTR [rax]
    cmc
    cmova ax, ax
    cmova ax, WORD PTR [rax]
    cmova eax, eax
    cmova eax, DWORD PTR [rax]
    cmova rax, rax
    cmova rax, QWORD PTR [rax]
    cmovae ax, ax
    cmovae ax, WORD PTR [rax]
    cmovae eax, eax
    cmovae eax, DWORD PTR [rax]
    cmovae rax, rax
    cmovae rax, QWORD PTR [rax]
    cmovb ax, ax
    cmovb ax, WORD PTR [rax]
    cmovb eax, eax
    cmovb eax, DWORD PTR [rax]
    cmovb rax, rax
    cmovb rax, QWORD PTR [rax]
    cmovbe ax, ax
    cmovbe ax, WORD PTR [rax]
    cmovbe eax, eax
    cmovbe eax, DWORD PTR [rax]
    cmovbe rax, rax
    cmovbe rax, QWORD PTR [rax]
    cmovc ax, ax
    cmovc ax, WORD PTR [rax]
    cmovc eax, eax
    cmovc eax, DWORD PTR [rax]
    cmovc rax, rax
    cmovc rax, QWORD PTR [rax]
    cmove ax, ax
    cmove ax, WORD PTR [rax]
    cmove eax, eax
    cmove eax, DWORD PTR [rax]
    cmove rax, rax
    cmove rax, QWORD PTR [rax]
    cmovg ax, ax
    cmovg ax, WORD PTR [rax]
    cmovg eax, eax
    cmovg eax, DWORD PTR [rax]
    cmovg rax, rax
    cmovg rax, QWORD PTR [rax]
    cmovge ax, ax
    cmovge ax, WORD PTR [rax]
    cmovge eax, eax
    cmovge eax, DWORD PTR [rax]
    cmovge rax, rax
    cmovge rax, QWORD PTR [rax]
    cmovl ax, ax
    cmovl ax, WORD PTR [rax]
    cmovl eax, eax
    cmovl eax, DWORD PTR [rax]
    cmovl rax, rax
    cmovl rax, QWORD PTR [rax]
    cmovle ax, ax
    cmovle ax, WORD PTR [rax]
    cmovle eax, eax
    cmovle eax, DWORD PTR [rax]
    cmovle rax, rax
    cmovle rax, QWORD PTR [rax]
    cmovna ax, ax
    cmovna ax, WORD PTR [rax]
    cmovna eax, eax
    cmovna eax, DWORD PTR [rax]
    cmovna rax, rax
    cmovna rax, QWORD PTR [rax]
    cmovnae ax, ax
    cmovnae ax, WORD PTR [rax]
    cmovnae eax, eax
    cmovnae eax, DWORD PTR [rax]
    cmovnae rax, rax
    cmovnae rax, QWORD PTR [rax]
    cmovnb ax, ax
    cmovnb ax, WORD PTR [rax]
    cmovnb eax, eax
    cmovnb eax, DWORD PTR [rax]
    cmovnb rax, rax
    cmovnb rax, QWORD PTR [rax]
    cmovnbe ax, ax
    cmovnbe ax, WORD PTR [rax]
    cmovnbe eax, eax
    cmovnbe eax, DWORD PTR [rax]
    cmovnbe rax, rax
    cmovnbe rax, QWORD PTR [rax]
    cmovnc ax, ax
    cmovnc ax, WORD PTR [rax]
    cmovnc eax, eax
    cmovnc eax, DWORD PTR [rax]
    cmovnc rax, rax
    cmovnc rax, QWORD PTR [rax]
    cmovne ax, ax
    cmovne ax, WORD PTR [rax]
    cmovne eax, eax
    cmovne eax, DWORD PTR [rax]
    cmovne rax, rax
    cmovne rax, QWORD PTR [rax]
    cmovng ax, ax
    cmovng ax, WORD PTR [rax]
    cmovng eax, eax
    cmovng eax, DWORD PTR [rax]
    cmovng rax, rax
    cmovng rax, QWORD PTR [rax]
    cmovnge ax, ax
    cmovnge ax, WORD PTR [rax]
    cmovnge eax, eax
    cmovnge eax, DWORD PTR [rax]
    cmovnge rax, rax
    cmovnge rax, QWORD PTR [rax]
    cmovnl ax, ax
    cmovnl ax, WORD PTR [rax]
    cmovnl eax, eax
    cmovnl eax, DWORD PTR [rax]
    cmovnl rax, rax
    cmovnl rax, QWORD PTR [rax]
    cmovnle ax, ax
    cmovnle ax, WORD PTR [rax]
    cmovnle eax, eax
    cmovnle eax, DWORD PTR [rax]
    cmovnle rax, rax
    cmovnle rax, QWORD PTR [rax]
    cmovno ax, ax
    cmovno ax, WORD PTR [rax]
    cmovno eax, eax
    cmovno eax, DWORD PTR [rax]
    cmovno rax, rax
    cmovno rax, QWORD PTR [rax]
    cmovnp ax, ax
    cmovnp ax, WORD PTR [rax]
    cmovnp eax, eax
    cmovnp eax, DWORD PTR [rax]
    cmovnp rax, rax
    cmovnp rax, QWORD PTR [rax]
    cmovns ax, ax
    cmovns ax, WORD PTR [rax]
    cmovns eax, eax
    cmovns eax, DWORD PTR [rax]
    cmovns rax, rax
    cmovns rax, QWORD PTR [rax]
    cmovnz ax, ax
    cmovnz ax, WORD PTR [rax]
    cmovnz eax, eax
    cmovnz eax, DWORD PTR [rax]
    cmovnz rax, rax
    cmovnz rax, QWORD PTR [rax]
    cmovo ax, ax
    cmovo ax, WORD PTR [rax]
    cmovo eax, eax
    cmovo eax, DWORD PTR [rax]
    cmovo rax, rax
    cmovo rax, QWORD PTR [rax]
    cmovp ax, ax
    cmovp ax, WORD PTR [rax]
    cmovp eax, eax
    cmovp eax, DWORD PTR [rax]
    cmovp rax, rax
    cmovp rax, QWORD PTR [rax]
    cmovpe ax, ax
    cmovpe ax, WORD PTR [rax]
    cmovpe eax, eax
    cmovpe eax, DWORD PTR [rax]
    cmovpe rax, rax
    cmovpe rax, QWORD PTR [rax]
    cmovpo ax, ax
    cmovpo ax, WORD PTR [rax]
    cmovpo eax, eax
    cmovpo eax, DWORD PTR [rax]
    cmovpo rax, rax
    cmovpo rax, QWORD PTR [rax]
    cmovs ax, ax
    cmovs ax, WORD PTR [rax]
    cmovs eax, eax
    cmovs eax, DWORD PTR [rax]
    cmovs rax, rax
    cmovs rax, QWORD PTR [rax]
    cmovz ax, ax
    cmovz ax, WORD PTR [rax]
    cmovz eax, eax
    cmovz eax, DWORD PTR [rax]
    cmovz rax, rax
    cmovz rax, QWORD PTR [rax]
    cmp al, 0x1
    cmp ax, 0x1
    cmp eax, 0x1
    cmp rax, 0x1
    cmp al, 0x1
    cmp BYTE PTR [rax], 0x1
    cmp ax, 0x1
    cmp WORD PTR [rax], 0x1
    cmp eax, 0x1
    cmp DWORD PTR [rax], 0x1
    cmp rax, 0x1
    cmp QWORD PTR [rax], 0x1
    cmp ax, 0x1
    cmp WORD PTR [rax], 0x1
    cmp eax, 0x1
    cmp DWORD PTR [rax], 0x1
    cmp rax, 0x1
    cmp QWORD PTR [rax], 0x1
    cmp al, al
    cmp BYTE PTR [rax], al
    cmp ax, ax
    cmp WORD PTR [rax], ax
    cmp eax, eax
    cmp DWORD PTR [rax], eax
    cmp rax, rax
    cmp QWORD PTR [rax], rax
    cmp al, al
    cmp al, BYTE PTR [rax]
    cmp ax, ax
    cmp ax, WORD PTR [rax]
    cmp eax, eax
    cmp eax, DWORD PTR [rax]
    cmp rax, rax
    cmp rax, QWORD PTR [rax]
    cmpbexadd DWORD PTR [rax], eax, eax
    cmpbexadd QWORD PTR [rax], rax, rax
    cmpbxadd DWORD PTR [rax], eax, eax
    cmpbxadd QWORD PTR [rax], rax, rax
    cmplexadd DWORD PTR [rax], eax, eax
    cmplexadd QWORD PTR [rax], rax, rax
    cmplxadd DWORD PTR [rax], eax, eax
    cmplxadd QWORD PTR [rax], rax, rax
    cmpnbexadd DWORD PTR [rax], eax, eax
    cmpnbexadd QWORD PTR [rax], rax, rax
    cmpnbxadd DWORD PTR [rax], eax, eax
    cmpnbxadd QWORD PTR [rax], rax, rax
    cmpnlexadd DWORD PTR [rax], eax, eax
    cmpnlexadd QWORD PTR [rax], rax, rax
    cmpnlxadd DWORD PTR [rax], eax, eax
    cmpnlxadd QWORD PTR [rax], rax, rax
    cmpnoxadd DWORD PTR [rax], eax, eax
    cmpnoxadd QWORD PTR [rax], rax, rax
    cmpnpxadd DWORD PTR [rax], eax, eax
    cmpnpxadd QWORD PTR [rax], rax, rax
    cmpnsxadd DWORD PTR [rax], eax, eax
    cmpnsxadd QWORD PTR [rax], rax, rax
    cmpnzxadd DWORD PTR [rax], eax, eax
    cmpnzxadd QWORD PTR [rax], rax, rax
    cmpoxadd DWORD PTR [rax], eax, eax
    cmpoxadd QWORD PTR [rax], rax, rax
    cmppxadd DWORD PTR [rax], eax, eax
    cmppxadd QWORD PTR [rax], rax, rax
    cmpsxadd DWORD PTR [rax], eax, eax
    cmpsxadd QWORD PTR [rax], rax, rax
    cmpzxadd DWORD PTR [rax], eax, eax
    cmpzxadd QWORD PTR [rax], rax, rax
    cmppd xmm1, xmm2, 0x1
    vcmppd xmm1, xmm2, xmm3, 0x1
    vcmppd ymm1, ymm2, ymm3, 0x1
    vcmppd k1{k2}, xmm2, xmm3, 0x1
    vcmppd k1{k2}, ymm2, ymm3, 0x1
    vcmppd k1{k2}, zmm2, zmm3, 0x1
    cmpps xmm1, xmm2, 0x1
    vcmpps xmm1, xmm2, xmm3, 0x1
    vcmpps ymm1, ymm2, ymm3, 0x1
    vcmpps k1{k2}, xmm2, xmm3, 0x1
    vcmpps k1{k2}, ymm2, ymm3, 0x1
    vcmpps k1{k2}, zmm2, zmm3, 0x1
    cmpsb
    cmpsw
    cmpsd
    cmpsq
    cmpsb
    cmpsw
    cmpsd
    cmpsq
    cmpsd xmm1, xmm2, 0x1
    vcmpsd xmm1, xmm2, xmm3, 0x1
    vcmpsd k1{k2}, xmm2, xmm3, 0x1
    cmpss xmm1, xmm2, 0x1
    vcmpss xmm1, xmm2, xmm3, 0x1
    vcmpss k1{k2}, xmm2, xmm3, 0x1
    cmpxchg al, al
    cmpxchg BYTE PTR [rax], al
    cmpxchg ax, ax
    cmpxchg WORD PTR [rax], ax
    cmpxchg eax, eax
    cmpxchg DWORD PTR [rax], eax
    cmpxchg rax, rax
    cmpxchg QWORD PTR [rax], rax
    cmpxchg8b QWORD PTR [rax]
    cmpxchg16b [rax]
    comisd xmm1, xmm2
    vcomisd xmm1, xmm2
    vcomisd xmm1, xmm2
    comiss xmm1, xmm2
    vcomiss xmm1, xmm2
    vcomiss xmm1, xmm2
    cpuid
    crc32 eax, al
    crc32 eax, BYTE PTR [rax]
    crc32 eax, ax
    crc32 eax, WORD PTR [rax]
    crc32 eax, eax
    crc32 eax, DWORD PTR [rax]
    crc32 rax, al
    crc32 rax, BYTE PTR [rax]
    crc32 rax, rax
    crc32 rax, QWORD PTR [rax]
    cvtdq2pd xmm1, xmm2
    vcvtdq2pd xmm1, xmm2
    vcvtdq2pd ymm1, xmm2
    vcvtdq2pd xmm1{k1}{z}, xmm2
    vcvtdq2pd ymm1{k1}{z}, xmm2
    vcvtdq2pd zmm1{k1}{z}, ymm2
    cvtdq2ps xmm1, xmm2
    vcvtdq2ps xmm1, xmm2
    vcvtdq2ps ymm1, ymm2
    vcvtdq2ps xmm1{k1}{z}, xmm2
    vcvtdq2ps ymm1{k1}{z}, ymm2
    vcvtdq2ps zmm1{k1}{z}, zmm2
    cvtpd2dq xmm1, xmm2
    vcvtpd2dq xmm1, xmm2
    vcvtpd2dq xmm1, ymm2
    vcvtpd2dq xmm1{k1}{z}, xmm2
    vcvtpd2dq xmm1{k1}{z}, ymm2
    vcvtpd2dq ymm1{k1}{z}, zmm2
    cvtpd2pi mm0, xmm0
    cvtpd2ps xmm1, xmm2
    vcvtpd2ps xmm1, xmm2
    vcvtpd2ps xmm1, ymm2
    vcvtpd2ps xmm1{k1}{z}, xmm2
    vcvtpd2ps xmm1{k1}{z}, ymm2
    vcvtpd2ps ymm1{k1}{z}, zmm2
    cvtpi2pd xmm0, mm0
    cvtpi2ps xmm0, mm0
    cvtps2dq xmm1, xmm2
    vcvtps2dq xmm1, xmm2
    vcvtps2dq ymm1, ymm2
    vcvtps2dq xmm1{k1}{z}, xmm2
    vcvtps2dq ymm1{k1}{z}, ymm2
    vcvtps2dq zmm1{k1}{z}, zmm2
    cvtps2pd xmm1, xmm2
    vcvtps2pd xmm1, xmm2
    vcvtps2pd ymm1, xmm2
    vcvtps2pd xmm1{k1}{z}, xmm2
    vcvtps2pd ymm1{k1}{z}, xmm2
    vcvtps2pd zmm1{k1}{z}, ymm2
    cvtps2pi mm0, xmm0
    cvtsd2si eax, xmm1
    cvtsd2si rax, xmm1
    vcvtsd2si eax, xmm1
    vcvtsd2si rax, xmm1
    cvtsd2ss xmm1, xmm2
    vcvtsd2ss xmm1, xmm2, xmm3
    vcvtsd2ss xmm1{k1}{z}, xmm2, xmm3
    cvtsi2sd xmm1, eax
    cvtsi2sd xmm1, rax
    cvtsi2sd xmm1, QWORD PTR [rax]
    vcvtsi2sd xmm1, xmm2, eax
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax]
    vcvtsi2sd xmm1, xmm2, rax
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax]
    vcvtsi2sd xmm1, xmm2, eax
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax]
    vcvtsi2sd xmm1, xmm2, rax
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax]
    cvtsi2ss xmm1, eax
    cvtsi2ss xmm1, DWORD PTR [rax]
    cvtsi2ss xmm1, rax
    cvtsi2ss xmm1, QWORD PTR [rax]
    vcvtsi2ss xmm1, xmm2, eax
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax]
    vcvtsi2ss xmm1, xmm2, rax
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax]
    vcvtsi2ss xmm1, xmm2, eax
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax]
    vcvtsi2ss xmm1, xmm2, rax
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax]
    cvtss2sd xmm1, xmm2
    vcvtss2sd xmm1, xmm2, xmm3
    vcvtss2sd xmm1{k1}{z}, xmm2, xmm3
    cvtss2si eax, xmm1
    cvtss2si rax, xmm1
    vcvtss2si eax, xmm1
    vcvtss2si rax, xmm1
    cvttpd2dq xmm1, xmm2
    vcvttpd2dq xmm1, xmm2
    vcvttpd2dq xmm1, ymm2
    vcvttpd2dq xmm1{k1}{z}, xmm2
    vcvttpd2dq xmm1{k1}{z}, ymm2
    vcvttpd2dq ymm1{k1}{z}, zmm2
    cvttpd2pi mm0, xmm0
    cvttps2dq xmm1, xmm2
    vcvttps2dq xmm1, xmm2
    vcvttps2dq ymm1, ymm2
    vcvttps2dq xmm1{k1}{z}, xmm2
    vcvttps2dq ymm1{k1}{z}, ymm2
    vcvttps2dq zmm1{k1}{z}, zmm2
    cvttps2pi mm0, xmm0
    cvttsd2si eax, xmm1
    cvttsd2si rax, xmm1
    vcvttsd2si eax, xmm1
    vcvttsd2si rax, xmm1
    cvttss2si eax, xmm1
    cvttss2si rax, xmm1
    vcvttss2si eax, xmm1
    vcvttss2si rax, xmm1
    cwd
    cdq
    cqo
    dec al
    dec BYTE PTR [rax]
    dec ax
    dec WORD PTR [rax]
    dec eax
    dec DWORD PTR [rax]
    dec rax
    dec QWORD PTR [rax]
    div al
    div BYTE PTR [rax]
    div ax
    div WORD PTR [rax]
    div eax
    div DWORD PTR [rax]
    div rax
    div QWORD PTR [rax]
    divpd xmm1, xmm2
    vdivpd xmm1, xmm2, xmm3
    vdivpd ymm1, ymm2, ymm3
    vdivpd xmm1{k1}{z}, xmm2, xmm3
    vdivpd ymm1{k1}{z}, ymm2, ymm3
    vdivpd zmm1{k1}{z}, zmm2, zmm3
    divps xmm1, xmm2
    vdivps xmm1, xmm2, xmm3
    vdivps ymm1, ymm2, ymm3
    vdivps xmm1{k1}{z}, xmm2, xmm3
    vdivps ymm1{k1}{z}, ymm2, ymm3
    vdivps zmm1{k1}{z}, zmm2, zmm3
    divsd xmm1, xmm2
    vdivsd xmm1, xmm2, xmm3
    vdivsd xmm1{k1}{z}, xmm2, xmm3
    divss xmm1, xmm2
    vdivss xmm1, xmm2, xmm3
    vdivss xmm1{k1}{z}, xmm2, xmm3
    dppd xmm1, xmm2, 0x1
    vdppd xmm1, xmm2, xmm3, 0x1
    dpps xmm1, xmm2, 0x1
    vdpps xmm1, xmm2, xmm3, 0x1
    vdpps ymm1, ymm2, ymm3, 0x1
    emms
    encodekey128 eax, eax
    encodekey256 eax, eax
    endbr32
    endbr64
    enqcmd rax, [rax]
    enqcmds rax, [rax]
    enter 0x1, 0
    enter 0x1, 1
    enter 0x1, 0x1
    erets
    eretu
    extractps eax, xmm1, 0x1
    vextractps eax, xmm1, 0x1
    vextractps eax, xmm1, 0x1
    f2xm1
    fabs
    fadd DWORD PTR [rax]
    fadd QWORD PTR [rax]
    fadd st(0), st(1)
    fadd st(1), st(0)
    faddp st(1), st(0)
    faddp
    fiadd DWORD PTR [rax]
    fiadd WORD PTR [rax]
    fbld TBYTE PTR [rax]
    fbstp TBYTE PTR [rax]
    fchs
    fclex
    fnclex
    fcmovb st(0), st(1)
    fcmove st(0), st(1)
    fcmovbe st(0), st(1)
    fcmovu st(0), st(1)
    fcmovnb st(0), st(1)
    fcmovne st(0), st(1)
    fcmovnbe st(0), st(1)
    fcmovnu st(0), st(1)
    fcom DWORD PTR [rax]
    fcom QWORD PTR [rax]
    fcom st(1)
    fcom
    fcomp DWORD PTR [rax]
    fcomp QWORD PTR [rax]
    fcomp st(1)
    fcomp
    fcompp
    fcomi st(0), st(1)
    fcomip st(0), st(1)
    fucomi st(0), st(1)
    fucomip st(0), st(1)
    fcos
    fdecstp
    fdiv DWORD PTR [rax]
    fdiv QWORD PTR [rax]
    fdiv st(0), st(1)
    fdiv st(1), st(0)
    fdivp st(1), st(0)
    fdivp
    fidiv DWORD PTR [rax]
    fidiv WORD PTR [rax]
    fdivr DWORD PTR [rax]
    fdivr QWORD PTR [rax]
    fdivr st(0), st(1)
    fdivr st(1), st(0)
    fdivrp st(1), st(0)
    fdivrp
    fidivr DWORD PTR [rax]
    fidivr WORD PTR [rax]
    ffree st(1)
    ficom WORD PTR [rax]
    ficom DWORD PTR [rax]
    ficomp WORD PTR [rax]
    ficomp DWORD PTR [rax]
    fild WORD PTR [rax]
    fild DWORD PTR [rax]
    fild QWORD PTR [rax]
    fincstp
    finit
    fninit
    fist WORD PTR [rax]
    fist DWORD PTR [rax]
    fistp WORD PTR [rax]
    fistp DWORD PTR [rax]
    fistp QWORD PTR [rax]
    fisttp WORD PTR [rax]
    fisttp DWORD PTR [rax]
    fisttp QWORD PTR [rax]
    fld DWORD PTR [rax]
    fld QWORD PTR [rax]
    fld TBYTE PTR [rax]
    fld st(1)
    fld1
    fldl2t
    fldl2e
    fldpi
    fldlg2
    fldln2
    fldz
    fldcw [rax]
    fldenv [rax]
    fmul DWORD PTR [rax]
    fmul QWORD PTR [rax]
    fmul st(0), st(1)
    fmul st(1), st(0)
    fmulp st(1), st(0)
    fmulp
    fimul DWORD PTR [rax]
    fimul WORD PTR [rax]
    fnop
    fpatan
    fprem
    fprem1
    fptan
    frndint
    frstor [rax]
    fsave [rax]
    fnsave [rax]
    fscale
    fsin
    fsincos
    fsqrt
    fst DWORD PTR [rax]
    fst QWORD PTR [rax]
    fst st(1)
    fstp DWORD PTR [rax]
    fstp QWORD PTR [rax]
    fstp TBYTE PTR [rax]
    fstp st(1)
    fstcw [rax]
    fnstcw [rax]
    fstenv [rax]
    fnstenv [rax]
    fstsw [rax]
    fstsw ax
    fnstsw [rax]
    fnstsw ax
    fsub DWORD PTR [rax]
    fsub QWORD PTR [rax]
    fsub st(0), st(1)
    fsub st(1), st(0)
    fsubp st(1), st(0)
    fsubp
    fisub DWORD PTR [rax]
    fisub WORD PTR [rax]
    fsubr DWORD PTR [rax]
    fsubr QWORD PTR [rax]
    fsubr st(0), st(1)
    fsubr st(1), st(0)
    fsubrp st(1), st(0)
    fsubrp
    fisubr DWORD PTR [rax]
    fisubr WORD PTR [rax]
    ftst
    fucom st(1)
    fucom
    fucomp st(1)
    fucomp
    fucompp
    fxam
    fxch st(1)
    fxch
    fxrstor [rax]
    fxrstor64 [rax]
    fxsave [rax]
    fxsave64 [rax]
    fxtract
    fyl2x
    fyl2xp1
    gf2p8affineinvqb xmm1, xmm2, 0x1
    vgf2p8affineinvqb xmm1, xmm2, xmm3, 0x1
    vgf2p8affineinvqb ymm1, ymm2, ymm3, 0x1
    vgf2p8affineinvqb xmm1{k1}{z}, xmm2, xmm3, 0x1
    vgf2p8affineinvqb ymm1{k1}{z}, ymm2, ymm3, 0x1
    vgf2p8affineinvqb zmm1{k1}{z}, zmm2, zmm3, 0x1
    gf2p8affineqb xmm1, xmm2, 0x1
    vgf2p8affineqb xmm1, xmm2, xmm3, 0x1
    vgf2p8affineqb ymm1, ymm2, ymm3, 0x1
    vgf2p8affineqb xmm1{k1}{z}, xmm2, xmm3, 0x1
    vgf2p8affineqb ymm1{k1}{z}, ymm2, ymm3, 0x1
    vgf2p8affineqb zmm1{k1}{z}, zmm2, zmm3, 0x1
    gf2p8mulb xmm1, xmm2
    vgf2p8mulb xmm1, xmm2, xmm3
    vgf2p8mulb ymm1, ymm2, ymm3
    vgf2p8mulb xmm1{k1}{z}, xmm2, xmm3
    vgf2p8mulb ymm1{k1}{z}, ymm2, ymm3
    vgf2p8mulb zmm1{k1}{z}, zmm2, zmm3
    haddpd xmm1, xmm2
    vhaddpd xmm1, xmm2, xmm3
    vhaddpd ymm1, ymm2, ymm3
    haddps xmm1, xmm2
    vhaddps xmm1, xmm2, xmm3
    vhaddps ymm1, ymm2, ymm3
    hlt
    hreset 0x1
    hsubpd xmm1, xmm2
    vhsubpd xmm1, xmm2, xmm3
    vhsubpd ymm1, ymm2, ymm3
    hsubps xmm1, xmm2
    vhsubps xmm1, xmm2, xmm3
    vhsubps ymm1, ymm2, ymm3
    idiv al
    idiv BYTE PTR [rax]
    idiv ax
    idiv WORD PTR [rax]
    idiv eax
    idiv DWORD PTR [rax]
    idiv rax
    idiv QWORD PTR [rax]
    imul al
    imul BYTE PTR [rax]
    imul ax
    imul WORD PTR [rax]
    imul eax
    imul DWORD PTR [rax]
    imul rax
    imul QWORD PTR [rax]
    imul ax, ax
    imul ax, WORD PTR [rax]
    imul eax, eax
    imul eax, DWORD PTR [rax]
    imul rax, rax
    imul rax, QWORD PTR [rax]
    imul ax, ax, 0x1
    imul ax, WORD PTR [rax], 0x1
    imul eax, eax, 0x1
    imul eax, DWORD PTR [rax], 0x1
    imul rax, rax, 0x1
    imul rax, QWORD PTR [rax], 0x1
    imul ax, ax, 0x1
    imul ax, WORD PTR [rax], 0x1
    imul eax, eax, 0x1
    imul eax, DWORD PTR [rax], 0x1
    imul rax, rax, 0x1
    imul rax, QWORD PTR [rax], 0x1
    in al, 0x1
    in ax, 0x1
    in eax, 0x1
    in al, dx
    in ax, dx
    in eax, dx
    inc al
    inc BYTE PTR [rax]
    inc ax
    inc WORD PTR [rax]
    inc eax
    inc DWORD PTR [rax]
    inc rax
    inc QWORD PTR [rax]
    incsspd eax
    incsspq rax
    insertps xmm1, xmm2, 0x1
    vinsertps xmm1, xmm2, xmm3, 0x1
    vinsertps xmm1, xmm2, xmm3, 0x1
    insb
    insw
    insd
    insb
    insw
    insd
    int3
    int 0x1
    int1
    invd
    invlpg [rax]
    invpcid rax, [rax]
    iret
    iretd
    iretq
    ja 1f
    jae 1f
    jb 1f
    jbe 1f
    jc 1f
    jecxz 1f
    jrcxz 1f
    je 1f
    jg 1f
    jge 1f
    jl 1f
    jle 1f
    jna 1f
    jnae 1f
    jnb 1f
    jnbe 1f
    jnc 1f
    jne 1f
    jng 1f
    jnge 1f
    jnl 1f
    jnle 1f
    jno 1f
    jnp 1f
    jns 1f
    jnz 1f
    jo 1f
    jp 1f
    jpe 1f
    jpo 1f
    js 1f
    jz 1f
    ja 1f
    jae 1f
    jb 1f
    jbe 1f
    jc 1f
    je 1f
    jz 1f
    jg 1f
    jge 1f
    jl 1f
    jle 1f
    jna 1f
    jnae 1f
    jnb 1f
    jnbe 1f
    jnc 1f
    jne 1f
    jng 1f
    jnge 1f
    jnl 1f
    jnle 1f
    jno 1f
    jnp 1f
    jns 1f
    jnz 1f
    jo 1f
    jp 1f
    jpe 1f
    jpo 1f
    js 1f
    jmp 1f
    jmp 1f
    jmp rax
    jmp QWORD PTR [rax]
    jmp DWORD PTR [rax]
    jmp FWORD PTR [rax]
    jmp TBYTE PTR [rax]
    kaddw k1, k2, k3
    kaddb k1, k2, k3
    kaddq k1, k2, k3
    kaddd k1, k2, k3
    kandnw k1, k2, k3
    kandnb k1, k2, k3
    kandnq k1, k2, k3
    kandnd k1, k2, k3
    kandw k1, k2, k3
    kandb k1, k2, k3
    kandq k1, k2, k3
    kandd k1, k2, k3
    kmovw k1, k2
    kmovb k1, k2
    kmovq k1, k2
    kmovd k1, k2
    kmovw WORD PTR [rax], k1
    kmovb BYTE PTR [rax], k1
    kmovq QWORD PTR [rax], k1
    kmovd DWORD PTR [rax], k1
    kmovw k1, eax
    kmovb k1, eax
    kmovq k1, rax
    kmovd k1, eax
    kmovw eax, k1
    kmovb eax, k1
    kmovq rax, k1
    kmovd eax, k1
    knotw k1, k2
    knotb k1, k2
    knotq k1, k2
    knotd k1, k2
    kortestw k1, k2
    kortestb k1, k2
    kortestq k1, k2
    kortestd k1, k2
    korw k1, k2, k3
    korb k1, k2, k3
    korq k1, k2, k3
    kord k1, k2, k3
    kshiftlw k1, k2, 0x1
    kshiftlb k1, k2, 0x1
    kshiftlq k1, k2, 0x1
    kshiftld k1, k2, 0x1
    kshiftrw k1, k2, 0x1
    kshiftrb k1, k2, 0x1
    kshiftrq k1, k2, 0x1
    kshiftrd k1, k2, 0x1
    ktestw k1, k2
    ktestb k1, k2
    ktestq k1, k2
    ktestd k1, k2
    kunpckbw k1, k2, k3
    kunpckwd k1, k2, k3
    kunpckdq k1, k2, k3
    kxnorw k1, k2, k3
    kxnorb k1, k2, k3
    kxnorq k1, k2, k3
    kxnord k1, k2, k3
    kxorw k1, k2, k3
    kxorb k1, k2, k3
    kxorq k1, k2, k3
    kxord k1, k2, k3
    lar ax, ax
    lar eax, eax
    lddqu xmm1, [rax]
    vlddqu xmm1, [rax]
    vlddqu ymm1, [rax]
    ldmxcsr DWORD PTR [rax]
    vldmxcsr DWORD PTR [rax]
    lss ax, DWORD PTR [rax]
    lss eax, FWORD PTR [rax]
    lss rax, TBYTE PTR [rax]
    lfs ax, DWORD PTR [rax]
    lfs eax, FWORD PTR [rax]
    lfs rax, TBYTE PTR [rax]
    lgs ax, DWORD PTR [rax]
    lgs eax, FWORD PTR [rax]
    lgs rax, TBYTE PTR [rax]
    ldtilecfg [rax]
    lea ax, [rax]
    lea eax, [rax]
    lea rax, [rax]
    leave
    lfence
    lgdt [rax]
    lidt [rax]
    lkgs ax
    lkgs WORD PTR [rax]
    lldt ax
    lldt WORD PTR [rax]
    lmsw ax
    lmsw WORD PTR [rax]
    loadiwkey xmm1, xmm2
    lodsb
    lodsw
    lodsd
    lodsq
    lodsb
    lodsw
    lodsd
    lodsq
    loop 1f
    loope 1f
    loopne 1f
    lsl ax, ax
    lsl eax, eax
    lsl rax, rax
    ltr ax
    ltr WORD PTR [rax]
    lzcnt ax, ax
    lzcnt ax, WORD PTR [rax]
    lzcnt eax, eax
    lzcnt eax, DWORD PTR [rax]
    lzcnt rax, rax
    lzcnt rax, QWORD PTR [rax]
    maskmovdqu xmm1, xmm2
    vmaskmovdqu xmm1, xmm2
    maskmovq mm1, mm2
    maxpd xmm1, xmm2
    vmaxpd xmm1, xmm2, xmm3
    vmaxpd ymm1, ymm2, ymm3
    vmaxpd xmm1{k1}{z}, xmm2, xmm3
    vmaxpd ymm1{k1}{z}, ymm2, ymm3
    vmaxpd zmm1{k1}{z}, zmm2, zmm3
    maxps xmm1, xmm2
    vmaxps xmm1, xmm2, xmm3
    vmaxps ymm1, ymm2, ymm3
    vmaxps xmm1{k1}{z}, xmm2, xmm3
    vmaxps ymm1{k1}{z}, ymm2, ymm3
    vmaxps zmm1{k1}{z}, zmm2, zmm3
    maxsd xmm1, xmm2
    vmaxsd xmm1, xmm2, xmm3
    vmaxsd xmm1{k1}{z}, xmm2, xmm3
    maxss xmm1, xmm2
    vmaxss xmm1, xmm2, xmm3
    vmaxss xmm1{k1}{z}, xmm2, xmm3
    mfence
    minpd xmm1, xmm2
    vminpd xmm1, xmm2, xmm3
    vminpd ymm1, ymm2, ymm3
    vminpd xmm1{k1}{z}, xmm2, xmm3
    vminpd ymm1{k1}{z}, ymm2, ymm3
    vminpd zmm1{k1}{z}, zmm2, zmm3
    minps xmm1, xmm2
    vminps xmm1, xmm2, xmm3
    vminps ymm1, ymm2, ymm3
    vminps xmm1{k1}{z}, xmm2, xmm3
    vminps ymm1{k1}{z}, ymm2, ymm3
    vminps zmm1{k1}{z}, zmm2, zmm3
    minsd xmm1, xmm2
    vminsd xmm1, xmm2, xmm3
    vminsd xmm1{k1}{z}, xmm2, xmm3
    minss xmm1, xmm2
    vminss xmm1, xmm2, xmm3
    vminss xmm1{k1}{z}, xmm2, xmm3
    monitor
    mov al, al
    mov BYTE PTR [rax], al
    mov ax, ax
    mov WORD PTR [rax], ax
    mov eax, eax
    mov DWORD PTR [rax], eax
    mov rax, rax
    mov QWORD PTR [rax], rax
    mov al, al
    mov al, BYTE PTR [rax]
    mov ax, ax
    mov ax, WORD PTR [rax]
    mov eax, eax
    mov eax, DWORD PTR [rax]
    mov rax, rax
    mov rax, QWORD PTR [rax]
    mov ax, ds
    mov WORD PTR [rax], ds
    mov eax, ds
    mov rax, ds
    mov ds, ax
    mov ds, WORD PTR [rax]
    mov ds, rax
    mov ds, ax
    mov al, [0x1000]
    mov al, [0x1000]
    mov ax, [0x1000]
    mov eax, [0x1000]
    mov rax, [0x1000]
    mov [0x1000], al
    mov [0x1000], al
    mov [0x1000], ax
    mov [0x1000], eax
    mov [0x1000], rax
    mov al, 0x1
    mov ax, 0x1
    mov eax, 0x1
    mov rax, 0x1
    mov al, 0x1
    mov BYTE PTR [rax], 0x1
    mov ax, 0x1
    mov WORD PTR [rax], 0x1
    mov eax, 0x1
    mov DWORD PTR [rax], 0x1
    mov rax, 0x1
    mov QWORD PTR [rax], 0x1
    mov rax, cr0
    mov rax, cr8
    mov cr0, rax
    mov cr8, rax
    mov rax, dr0
    mov dr0, rax
    movapd xmm1, xmm2
    movapd xmm2, xmm1
    vmovapd xmm1, xmm2
    vmovapd xmm2, xmm1
    vmovapd ymm1, ymm2
    vmovapd ymm2, ymm1
    vmovapd xmm1{k1}{z}, xmm2
    vmovapd ymm1{k1}{z}, ymm2
    vmovapd zmm1{k1}{z}, zmm2
    vmovapd xmm2{k1}{z}, xmm1
    vmovapd ymm2{k1}{z}, ymm1
    vmovapd zmm2{k1}{z}, zmm1
    movaps xmm1, xmm2
    movaps xmm2, xmm1
    vmovaps xmm1, xmm2
    vmovaps xmm2, xmm1
    vmovaps ymm1, ymm2
    vmovaps ymm2, ymm1
    vmovaps xmm1{k1}{z}, xmm2
    vmovaps ymm1{k1}{z}, ymm2
    vmovaps zmm1{k1}{z}, zmm2
    vmovaps xmm2{k1}{z}, xmm1
    vmovaps ymm2{k1}{z}, ymm1
    vmovaps zmm2{k1}{z}, zmm1
    movbe ax, WORD PTR [rax]
    movbe eax, DWORD PTR [rax]
    movbe rax, QWORD PTR [rax]
    movbe WORD PTR [rax], ax
    movbe DWORD PTR [rax], eax
    movbe QWORD PTR [rax], rax
    movddup xmm1, xmm2
    vmovddup xmm1, xmm2
    vmovddup ymm1, ymm2
    vmovddup xmm1{k1}{z}, xmm2
    vmovddup ymm1{k1}{z}, ymm2
    vmovddup zmm1{k1}{z}, zmm2
    movdir64b rax, [rax]
    movdiri DWORD PTR [rax], eax
    movdiri QWORD PTR [rax], rax
    movd mm0, eax
    movd mm0, DWORD PTR [rax]
    movq mm0, rax
    movq mm0, QWORD PTR [rax]
    movd eax, mm0
    movd DWORD PTR [rax], mm0
    movq rax, mm0
    movq QWORD PTR [rax], mm0
    movd xmm0, eax
    movd xmm0, DWORD PTR [rax]
    movq xmm0, rax
    movq xmm0, QWORD PTR [rax]
    movd eax, xmm0
    movd DWORD PTR [rax], xmm0
    movq rax, xmm0
    movq QWORD PTR [rax], xmm0
    vmovq xmm1, rax
    vmovd eax, xmm1
    vmovq rax, xmm1
    vmovd xmm1, eax
    vmovq xmm1, rax
    vmovd eax, xmm1
    vmovq rax, xmm1
    movdq2q mm0, xmm0
    movdqa xmm1, xmm2
    movdqa xmm2, xmm1
    vmovdqa xmm1, xmm2
    vmovdqa xmm2, xmm1
    vmovdqa ymm1, ymm2
    vmovdqa ymm2, ymm1
    vmovdqa32 xmm1{k1}{z}, xmm2
    vmovdqa32 ymm1{k1}{z}, ymm2
    vmovdqa32 zmm1{k1}{z}, zmm2
    vmovdqa32 xmm2{k1}{z}, xmm1
    vmovdqa32 ymm2{k1}{z}, ymm1
    vmovdqa32 zmm2{k1}{z}, zmm1
    vmovdqa64 xmm1{k1}{z}, xmm2
    vmovdqa64 ymm1{k1}{z}, ymm2
    vmovdqa64 zmm1{k1}{z}, zmm2
    vmovdqa64 xmm2{k1}{z}, xmm1
    vmovdqa64 ymm2{k1}{z}, ymm1
    vmovdqa64 zmm2{k1}{z}, zmm1
    movdqu xmm1, xmm2
    movdqu xmm2, xmm1
    vmovdqu xmm1, xmm2
    vmovdqu xmm2, xmm1
    vmovdqu ymm1, ymm2
    vmovdqu ymm2, ymm1
    vmovdqu8 xmm1{k1}{z}, xmm2
    vmovdqu8 ymm1{k1}{z}, ymm2
    vmovdqu8 zmm1{k1}{z}, zmm2
    vmovdqu8 xmm2{k1}{z}, xmm1
    vmovdqu8 ymm2{k1}{z}, ymm1
    vmovdqu8 zmm2{k1}{z}, zmm1
    vmovdqu16 xmm1{k1}{z}, xmm2
    vmovdqu16 ymm1{k1}{z}, ymm2
    vmovdqu16 zmm1{k1}{z}, zmm2
    vmovdqu16 xmm2{k1}{z}, xmm1
    vmovdqu16 ymm2{k1}{z}, ymm1
    vmovdqu16 zmm2{k1}{z}, zmm1
    vmovdqu32 xmm1{k1}{z}, xmm2
    vmovdqu32 ymm1{k1}{z}, ymm2
    vmovdqu32 zmm1{k1}{z}, zmm2
    vmovdqu32 xmm2{k1}{z}, xmm1
    vmovdqu32 ymm2{k1}{z}, ymm1
    vmovdqu32 zmm2{k1}{z}, zmm1
    vmovdqu64 xmm1{k1}{z}, xmm2
    vmovdqu64 ymm1{k1}{z}, ymm2
    vmovdqu64 zmm1{k1}{z}, zmm2
    vmovdqu64 xmm2{k1}{z}, xmm1
    vmovdqu64 ymm2{k1}{z}, ymm1
    vmovdqu64 zmm2{k1}{z}, zmm1
    movhlps xmm1, xmm2
    vmovhlps xmm1, xmm2, xmm3
    vmovhlps xmm1, xmm2, xmm3
    movhpd xmm1, QWORD PTR [rax]
    vmovhpd xmm2, xmm1, QWORD PTR [rax]
    vmovhpd xmm2, xmm1, QWORD PTR [rax]
    movhpd QWORD PTR [rax], xmm1
    vmovhpd QWORD PTR [rax], xmm1
    vmovhpd QWORD PTR [rax], xmm1
    movhps xmm1, QWORD PTR [rax]
    vmovhps xmm2, xmm1, QWORD PTR [rax]
    vmovhps xmm2, xmm1, QWORD PTR [rax]
    movhps QWORD PTR [rax], xmm1
    vmovhps QWORD PTR [rax], xmm1
    vmovhps QWORD PTR [rax], xmm1
    movlhps xmm1, xmm2
    vmovlhps xmm1, xmm2, xmm3
    vmovlhps xmm1, xmm2, xmm3
    movlpd xmm1, QWORD PTR [rax]
    vmovlpd xmm2, xmm1, QWORD PTR [rax]
    vmovlpd xmm2, xmm1, QWORD PTR [rax]
    movlpd QWORD PTR [rax], xmm1
    vmovlpd QWORD PTR [rax], xmm1
    vmovlpd QWORD PTR [rax], xmm1
    movlps xmm1, QWORD PTR [rax]
    vmovlps xmm2, xmm1, QWORD PTR [rax]
    vmovlps xmm2, xmm1, QWORD PTR [rax]
    movlps QWORD PTR [rax], xmm1
    vmovlps QWORD PTR [rax], xmm1
    vmovlps QWORD PTR [rax], xmm1
    movmskpd eax, xmm0
    vmovmskpd eax, xmm2
    vmovmskpd eax, ymm2
    movmskps eax, xmm0
    vmovmskps eax, xmm2
    vmovmskps eax, ymm2
    movntdq [rax], xmm1
    vmovntdq [rax], xmm1
    vmovntdq [rax], ymm1
    vmovntdq [rax], xmm1
    vmovntdq [rax], ymm1
    vmovntdq [rax], zmm1
    movntdqa xmm1, [rax]
    vmovntdqa xmm1, [rax]
    vmovntdqa ymm1, [rax]
    vmovntdqa xmm1, [rax]
    vmovntdqa ymm1, [rax]
    vmovntdqa zmm1, [rax]
    movnti DWORD PTR [rax], eax
    movnti QWORD PTR [rax], rax
    movntpd [rax], xmm1
    vmovntpd [rax], xmm1
    vmovntpd [rax], ymm1
    vmovntpd [rax], xmm1
    vmovntpd [rax], ymm1
    vmovntpd [rax], zmm1
    movntps [rax], xmm1
    vmovntps [rax], xmm1
    vmovntps [rax], ymm1
    vmovntps [rax], xmm1
    vmovntps [rax], ymm1
    vmovntps [rax], zmm1
    movntq QWORD PTR [rax], mm0
    movq mm0, mm0
    movq mm0, mm0
    movq xmm1, xmm2
    vmovq xmm1, xmm2
    vmovq xmm1, xmm2
    movq xmm2, xmm1
    vmovq xmm1, xmm2
    vmovq xmm1, xmm2
    movq2dq xmm0, mm0
    movsb
    movsw
    movsd
    movsq
    movsb
    movsw
    movsd
    movsq
    movsd xmm1, xmm2
    movsd xmm1, QWORD PTR [rax]
    movsd xmm1, xmm2
    vmovsd xmm1, xmm2, xmm3
    vmovsd xmm1, QWORD PTR [rax]
    vmovsd xmm1, xmm2, xmm3
    vmovsd QWORD PTR [rax], xmm1
    vmovsd xmm1{k1}{z}, xmm2, xmm3
    vmovsd xmm1{k1}{z}, QWORD PTR [rax]
    vmovsd xmm1{k1}{z}, xmm2, xmm3
    vmovsd QWORD PTR [rax], xmm1
    movshdup xmm1, xmm2
    vmovshdup xmm1, xmm2
    vmovshdup ymm1, ymm2
    vmovshdup xmm1{k1}{z}, xmm2
    vmovshdup ymm1{k1}{z}, ymm2
    vmovshdup zmm1{k1}{z}, zmm2
    movsldup xmm1, xmm2
    vmovsldup xmm1, xmm2
    vmovsldup ymm1, ymm2
    vmovsldup xmm1{k1}{z}, xmm2
    vmovsldup ymm1{k1}{z}, ymm2
    vmovsldup zmm1{k1}{z}, zmm2
    movss xmm1, xmm2
    movss xmm1, DWORD PTR [rax]
    vmovss xmm1, xmm2, xmm3
    vmovss xmm1, DWORD PTR [rax]
    movss xmm2, xmm1
    vmovss xmm1, xmm2, xmm3
    vmovss DWORD PTR [rax], xmm1
    vmovss xmm1{k1}{z}, xmm2, xmm3
    vmovss xmm1{k1}{z}, DWORD PTR [rax]
    vmovss xmm1{k1}{z}, xmm2, xmm3
    vmovss DWORD PTR [rax], xmm1
    movsx ax, al
    movsx ax, BYTE PTR [rax]
    movsx eax, al
    movsx eax, BYTE PTR [rax]
    movsx rax, al
    movsx rax, BYTE PTR [rax]
    movsx eax, ax
    movsx eax, WORD PTR [rax]
    movsx rax, ax
    movsx rax, WORD PTR [rax]
    movsxd ax, ax
    movsxd ax, WORD PTR [rax]
    movsxd eax, eax
    movsxd eax, DWORD PTR [rax]
    movsxd rax, eax
    movsxd rax, DWORD PTR [rax]
    movupd xmm1, xmm2
    movupd xmm2, xmm1
    vmovupd xmm1, xmm2
    vmovupd xmm2, xmm1
    vmovupd ymm1, ymm2
    vmovupd ymm2, ymm1
    vmovupd xmm1{k1}{z}, xmm2
    vmovupd xmm2{k1}{z}, xmm1
    vmovupd ymm1{k1}{z}, ymm2
    vmovupd ymm2{k1}{z}, ymm1
    vmovupd zmm1{k1}{z}, zmm2
    vmovupd zmm2{k1}{z}, zmm1
    movups xmm1, xmm2
    movups xmm2, xmm1
    vmovups xmm1, xmm2
    vmovups xmm2, xmm1
    vmovups ymm1, ymm2
    vmovups ymm2, ymm1
    vmovups xmm1{k1}{z}, xmm2
    vmovups ymm1{k1}{z}, ymm2
    vmovups zmm1{k1}{z}, zmm2
    vmovups xmm2{k1}{z}, xmm1
    vmovups ymm2{k1}{z}, ymm1
    vmovups zmm2{k1}{z}, zmm1
    movzx ax, al
    movzx ax, BYTE PTR [rax]
    movzx eax, al
    movzx eax, BYTE PTR [rax]
    movzx rax, al
    movzx rax, BYTE PTR [rax]
    movzx eax, ax
    movzx eax, WORD PTR [rax]
    movzx rax, ax
    movzx rax, WORD PTR [rax]
    mpsadbw xmm1, xmm2, 0x1
    vmpsadbw xmm1, xmm2, xmm3, 0x1
    vmpsadbw ymm1, ymm2, ymm3, 0x1
    mul al
    mul BYTE PTR [rax]
    mul ax
    mul WORD PTR [rax]
    mul eax
    mul DWORD PTR [rax]
    mul rax
    mul QWORD PTR [rax]
    mulpd xmm1, xmm2
    vmulpd xmm1, xmm2, xmm3
    vmulpd ymm1, ymm2, ymm3
    vmulpd xmm1{k1}{z}, xmm2, xmm3
    vmulpd ymm1{k1}{z}, ymm2, ymm3
    vmulpd zmm1{k1}{z}, zmm2, zmm3
    mulps xmm1, xmm2
    vmulps xmm1, xmm2, xmm3
    vmulps ymm1, ymm2, ymm3
    vmulps xmm1{k1}{z}, xmm2, xmm3
    vmulps ymm1{k1}{z}, ymm2, ymm3
    vmulps zmm1{k1}{z}, zmm2, zmm3
    mulsd xmm1, xmm2
    vmulsd xmm1, xmm2, xmm3
    vmulsd xmm1{k1}{z}, xmm2, xmm3
    mulss xmm1, xmm2
    vmulss xmm1, xmm2, xmm3
    vmulss xmm1{k1}{z}, xmm2, xmm3
    mulx eax, eax, eax
    mulx eax, eax, DWORD PTR [rax]
    mulx rax, rax, rax
    mulx rax, rax, QWORD PTR [rax]
    mwait
    neg al
    neg BYTE PTR [rax]
    neg ax
    neg WORD PTR [rax]
    neg eax
    neg DWORD PTR [rax]
    neg rax
    neg QWORD PTR [rax]
    nop
    nop ax
    nop WORD PTR [rax]
    nop eax
    nop DWORD PTR [rax]
    not al
    not BYTE PTR [rax]
    not ax
    not WORD PTR [rax]
    not eax
    not DWORD PTR [rax]
    not rax
    not QWORD PTR [rax]
    or al, 0x1
    or ax, 0x1
    or eax, 0x1
    or rax, 0x1
    or al, 0x1
    or BYTE PTR [rax], 0x1
    or ax, 0x1
    or WORD PTR [rax], 0x1
    or eax, 0x1
    or DWORD PTR [rax], 0x1
    or rax, 0x1
    or QWORD PTR [rax], 0x1
    or ax, 0x1
    or WORD PTR [rax], 0x1
    or eax, 0x1
    or DWORD PTR [rax], 0x1
    or rax, 0x1
    or QWORD PTR [rax], 0x1
    or al, al
    or BYTE PTR [rax], al
    or ax, ax
    or WORD PTR [rax], ax
    or eax, eax
    or DWORD PTR [rax], eax
    or rax, rax
    or QWORD PTR [rax], rax
    or al, al
    or al, BYTE PTR [rax]
    or ax, ax
    or ax, WORD PTR [rax]
    or eax, eax
    or eax, DWORD PTR [rax]
    or rax, rax
    or rax, QWORD PTR [rax]
    orpd xmm1, xmm2
    vorpd xmm1, xmm2, xmm3
    vorpd ymm1, ymm2, ymm3
    vorpd xmm1{k1}{z}, xmm2, xmm3
    vorpd ymm1{k1}{z}, ymm2, ymm3
    vorpd zmm1{k1}{z}, zmm2, zmm3
    orps xmm1, xmm2
    vorps xmm1, xmm2, xmm3
    vorps ymm1, ymm2, ymm3
    vorps xmm1{k1}{z}, xmm2, xmm3
    vorps ymm1{k1}{z}, ymm2, ymm3
    vorps zmm1{k1}{z}, zmm2, zmm3
    out 0x1, al
    out 0x1, ax
    out 0x1, eax
    out dx, al
    out dx, ax
    out dx, eax
    outsb
    outsw
    outsd
    outsb
    outsw
    outsd
    pabsb mm1, mm2
    pabsb xmm1, xmm2
    pabsw mm1, mm2
    pabsw xmm1, xmm2
    pabsd mm1, mm2
    pabsd xmm1, xmm2
    vpabsb xmm1, xmm2
    vpabsw xmm1, xmm2
    vpabsd xmm1, xmm2
    vpabsb ymm1, ymm2
    vpabsw ymm1, ymm2
    vpabsd ymm1, ymm2
    vpabsb xmm1{k1}{z}, xmm2
    vpabsb ymm1{k1}{z}, ymm2
    vpabsb zmm1{k1}{z}, zmm2
    vpabsw xmm1{k1}{z}, xmm2
    vpabsw ymm1{k1}{z}, ymm2
    vpabsw zmm1{k1}{z}, zmm2
    vpabsd xmm1{k1}{z}, xmm2
    vpabsd ymm1{k1}{z}, ymm2
    vpabsd zmm1{k1}{z}, zmm2
    vpabsq xmm1{k1}{z}, xmm2
    vpabsq ymm1{k1}{z}, ymm2
    vpabsq zmm1{k1}{z}, zmm2
    packsswb mm1, mm2
    packsswb xmm1, xmm2
    packssdw mm1, mm2
    packssdw xmm1, xmm2
    vpacksswb xmm1, xmm2, xmm3
    vpackssdw xmm1, xmm2, xmm3
    vpacksswb ymm1, ymm2, ymm3
    vpackssdw ymm1, ymm2, ymm3
    vpacksswb xmm1{k1}{z}, xmm2, xmm3
    vpacksswb ymm1{k1}{z}, ymm2, ymm3
    vpacksswb zmm1{k1}{z}, zmm2, zmm3
    vpackssdw xmm1{k1}{z}, xmm2, xmm3
    vpackssdw ymm1{k1}{z}, ymm2, ymm3
    vpackssdw zmm1{k1}{z}, zmm2, zmm3
    packusdw xmm1, xmm2
    vpackusdw xmm1, xmm2, xmm3
    vpackusdw ymm1, ymm2, ymm3
    vpackusdw xmm1{k1}{z}, xmm2, xmm3
    vpackusdw ymm1{k1}{z}, ymm2, ymm3
    vpackusdw zmm1{k1}{z}, zmm2, zmm3
    packuswb mm0, mm0
    packuswb xmm1, xmm2
    vpackuswb xmm1, xmm2, xmm3
    vpackuswb ymm1, ymm2, ymm3
    vpackuswb xmm1{k1}{z}, xmm2, xmm3
    vpackuswb ymm1{k1}{z}, ymm2, ymm3
    vpackuswb zmm1{k1}{z}, zmm2, zmm3
    paddb mm0, mm0
    paddw mm0, mm0
    paddd mm0, mm0
    paddq mm0, mm0
    paddb xmm1, xmm2
    paddw xmm1, xmm2
    paddd xmm1, xmm2
    paddq xmm1, xmm2
    vpaddb xmm1, xmm2, xmm3
    vpaddw xmm1, xmm2, xmm3
    vpaddd xmm1, xmm2, xmm3
    vpaddq xmm1, xmm2, xmm3
    vpaddb ymm1, ymm2, ymm3
    vpaddw ymm1, ymm2, ymm3
    vpaddd ymm1, ymm2, ymm3
    vpaddq ymm1, ymm2, ymm3
    vpaddb xmm1{k1}{z}, xmm2, xmm3
    vpaddw xmm1{k1}{z}, xmm2, xmm3
    vpaddd xmm1{k1}{z}, xmm2, xmm3
    vpaddq xmm1{k1}{z}, xmm2, xmm3
    vpaddb ymm1{k1}{z}, ymm2, ymm3
    vpaddw ymm1{k1}{z}, ymm2, ymm3
    vpaddd ymm1{k1}{z}, ymm2, ymm3
    vpaddq ymm1{k1}{z}, ymm2, ymm3
    vpaddb zmm1{k1}{z}, zmm2, zmm3
    vpaddw zmm1{k1}{z}, zmm2, zmm3
    vpaddd zmm1{k1}{z}, zmm2, zmm3
    vpaddq zmm1{k1}{z}, zmm2, zmm3
    paddsb mm0, mm0
    paddsb xmm1, xmm2
    paddsw mm0, mm0
    paddsw xmm1, xmm2
    vpaddsb xmm1, xmm2, xmm3
    vpaddsw xmm1, xmm2, xmm3
    vpaddsb ymm1, ymm2, ymm3
    vpaddsw ymm1, ymm2, ymm3
    vpaddsb xmm1{k1}{z}, xmm2, xmm3
    vpaddsb ymm1{k1}{z}, ymm2, ymm3
    vpaddsb zmm1{k1}{z}, zmm2, zmm3
    vpaddsw xmm1{k1}{z}, xmm2, xmm3
    vpaddsw ymm1{k1}{z}, ymm2, ymm3
    vpaddsw zmm1{k1}{z}, zmm2, zmm3
    paddusb mm0, mm0
    paddusb xmm1, xmm2
    paddusw mm0, mm0
    paddusw xmm1, xmm2
    vpaddusb xmm1, xmm2, xmm3
    vpaddusw xmm1, xmm2, xmm3
    vpaddusb ymm1, ymm2, ymm3
    vpaddusw ymm1, ymm2, ymm3
    vpaddusb xmm1{k1}{z}, xmm2, xmm3
    vpaddusb ymm1{k1}{z}, ymm2, ymm3
    vpaddusb zmm1{k1}{z}, zmm2, zmm3
    vpaddusw xmm1{k1}{z}, xmm2, xmm3
    vpaddusw ymm1{k1}{z}, ymm2, ymm3
    vpaddusw zmm1{k1}{z}, zmm2, zmm3
    palignr xmm1, xmm2, 0x1
    vpalignr xmm1, xmm2, xmm3, 0x1
    vpalignr ymm1, ymm2, ymm3, 0x1
    vpalignr xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpalignr ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpalignr zmm1{k1}{z}, zmm2, zmm3, 0x1
    pand mm0, mm0
    pand xmm1, xmm2
    vpand xmm1, xmm2, xmm3
    vpand ymm1, ymm2, ymm3
    vpandd xmm1{k1}{z}, xmm2, xmm3
    vpandd ymm1{k1}{z}, ymm2, ymm3
    vpandd zmm1{k1}{z}, zmm2, zmm3
    vpandq xmm1{k1}{z}, xmm2, xmm3
    vpandq ymm1{k1}{z}, ymm2, ymm3
    vpandq zmm1{k1}{z}, zmm2, zmm3
    pandn mm0, mm0
    pandn xmm1, xmm2
    vpandn xmm1, xmm2, xmm3
    vpandn ymm1, ymm2, ymm3
    vpandnd xmm1{k1}{z}, xmm2, xmm3
    vpandnd ymm1{k1}{z}, ymm2, ymm3
    vpandnd zmm1{k1}{z}, zmm2, zmm3
    vpandnq xmm1{k1}{z}, xmm2, xmm3
    vpandnq ymm1{k1}{z}, ymm2, ymm3
    vpandnq zmm1{k1}{z}, zmm2, zmm3
    pause
    pavgb mm1, mm2
    pavgb xmm1, xmm2
    pavgw mm1, mm2
    pavgw xmm1, xmm2
    vpavgb xmm1, xmm2, xmm3
    vpavgw xmm1, xmm2, xmm3
    vpavgb ymm1, ymm2, ymm3
    vpavgw ymm1, ymm2, ymm3
    vpavgb xmm1{k1}{z}, xmm2, xmm3
    vpavgb ymm1{k1}{z}, ymm2, ymm3
    vpavgb zmm1{k1}{z}, zmm2, zmm3
    vpavgw xmm1{k1}{z}, xmm2, xmm3
    vpavgw ymm1{k1}{z}, ymm2, ymm3
    vpavgw zmm1{k1}{z}, zmm2, zmm3
    pblendvb xmm1, xmm2
    vpblendvb xmm1, xmm2, xmm3, xmm4
    vpblendvb ymm1, ymm2, ymm3, ymm4
    pblendw xmm1, xmm2, 0x1
    vpblendw xmm1, xmm2, xmm3, 0x1
    vpblendw ymm1, ymm2, ymm3, 0x1
    pbndkb
    pclmulqdq xmm1, xmm2, 0x1
    vpclmulqdq xmm1, xmm2, xmm3, 0x1
    vpclmulqdq ymm1, ymm2, ymm3, 0x1
    vpclmulqdq xmm1, xmm2, xmm3, 0x1
    vpclmulqdq ymm1, ymm2, ymm3, 0x1
    vpclmulqdq zmm1, zmm2, zmm3, 0x1
    pcmpeqb mm0, mm0
    pcmpeqb xmm1, xmm2
    pcmpeqw mm0, mm0
    pcmpeqw xmm1, xmm2
    pcmpeqd mm0, mm0
    pcmpeqd xmm1, xmm2
    vpcmpeqb xmm1, xmm2, xmm3
    vpcmpeqw xmm1, xmm2, xmm3
    vpcmpeqd xmm1, xmm2, xmm3
    vpcmpeqb ymm1, ymm2, ymm3
    vpcmpeqw ymm1, ymm2, ymm3
    vpcmpeqd ymm1, ymm2, ymm3
    vpcmpeqd k1{k2}, xmm2, xmm3
    vpcmpeqd k1{k2}, ymm2, ymm3
    vpcmpeqd k1{k2}, zmm2, zmm3
    vpcmpeqb k1{k2}, xmm2, xmm3
    vpcmpeqb k1{k2}, ymm2, ymm3
    vpcmpeqb k1{k2}, zmm2, zmm3
    vpcmpeqw k1{k2}, xmm2, xmm3
    vpcmpeqw k1{k2}, ymm2, ymm3
    vpcmpeqw k1{k2}, zmm2, zmm3
    pcmpeqq xmm1, xmm2
    vpcmpeqq xmm1, xmm2, xmm3
    vpcmpeqq ymm1, ymm2, ymm3
    vpcmpeqq k1{k2}, xmm2, xmm3
    vpcmpeqq k1{k2}, ymm2, ymm3
    vpcmpeqq k1{k2}, zmm2, zmm3
    pcmpestri xmm1, xmm2, 0x1
    vpcmpestri xmm1, xmm2, 0x1
    pcmpestrm xmm1, xmm2, 0x1
    vpcmpestrm xmm1, xmm2, 0x1
    pcmpgtb mm0, mm0
    pcmpgtb xmm1, xmm2
    pcmpgtw mm0, mm0
    pcmpgtw xmm1, xmm2
    pcmpgtd mm0, mm0
    pcmpgtd xmm1, xmm2
    vpcmpgtb xmm1, xmm2, xmm3
    vpcmpgtw xmm1, xmm2, xmm3
    vpcmpgtd xmm1, xmm2, xmm3
    vpcmpgtb ymm1, ymm2, ymm3
    vpcmpgtw ymm1, ymm2, ymm3
    vpcmpgtd ymm1, ymm2, ymm3
    vpcmpgtd k1{k2}, xmm2, xmm3
    vpcmpgtd k1{k2}, ymm2, ymm3
    vpcmpgtd k1{k2}, zmm2, zmm3
    vpcmpgtb k1{k2}, xmm2, xmm3
    vpcmpgtb k1{k2}, ymm2, ymm3
    vpcmpgtb k1{k2}, zmm2, zmm3
    vpcmpgtw k1{k2}, xmm2, xmm3
    vpcmpgtw k1{k2}, ymm2, ymm3
    vpcmpgtw k1{k2}, zmm2, zmm3
    pcmpgtq xmm1, xmm2
    vpcmpgtq xmm1, xmm2, xmm3
    vpcmpgtq ymm1, ymm2, ymm3
    vpcmpgtq k1{k2}, xmm2, xmm3
    vpcmpgtq k1{k2}, ymm2, ymm3
    vpcmpgtq k1{k2}, zmm2, zmm3
    pcmpistri xmm1, xmm2, 0x1
    vpcmpistri xmm1, xmm2, 0x1
    pcmpistrm xmm1, xmm2, 0x1
    vpcmpistrm xmm1, xmm2, 0x1
    pconfig
    pdep eax, eax, eax
    pdep eax, eax, DWORD PTR [rax]
    pdep rax, rax, rax
    pdep rax, rax, QWORD PTR [rax]
    pext eax, eax, eax
    pext eax, eax, DWORD PTR [rax]
    pext rax, rax, rax
    pext rax, rax, QWORD PTR [rax]
    pextrb eax, xmm2, 0x1
    pextrd eax, xmm2, 0x1
    pextrd DWORD PTR [rax], xmm2, 0x1
    pextrq rax, xmm2, 0x1
    pextrq QWORD PTR [rax], xmm2, 0x1
    vpextrb eax, xmm2, 0x1
    vpextrd eax, xmm2, 0x1
    vpextrq rax, xmm2, 0x1
    vpextrb eax, xmm2, 0x1
    vpextrd eax, xmm2, 0x1
    vpextrq rax, xmm2, 0x1
    pextrw eax, xmm0, 0x1
    pextrw eax, xmm0, 0x1
    vpextrw eax, xmm1, 0x1
    vpextrw eax, xmm2, 0x1
    vpextrw eax, xmm1, 0x1
    vpextrw eax, xmm2, 0x1
    phaddsw mm1, mm2
    phaddsw xmm1, xmm2
    vphaddsw xmm1, xmm2, xmm3
    vphaddsw ymm1, ymm2, ymm3
    phaddw mm1, mm2
    phaddw xmm1, xmm2
    phaddd mm1, mm2
    phaddd xmm1, xmm2
    vphaddw xmm1, xmm2, xmm3
    vphaddd xmm1, xmm2, xmm3
    vphaddw ymm1, ymm2, ymm3
    vphaddd ymm1, ymm2, ymm3
    phminposuw xmm1, xmm2
    vphminposuw xmm1, xmm2
    phsubsw mm1, mm2
    phsubsw xmm1, xmm2
    vphsubsw xmm1, xmm2, xmm3
    vphsubsw ymm1, ymm2, ymm3
    phsubw mm1, mm2
    phsubw xmm1, xmm2
    phsubd mm1, mm2
    phsubd xmm1, xmm2
    vphsubw xmm1, xmm2, xmm3
    vphsubd xmm1, xmm2, xmm3
    vphsubw ymm1, ymm2, ymm3
    vphsubd ymm1, ymm2, ymm3
    pinsrb xmm1, eax, 0x1
    pinsrd xmm1, eax, 0x1
    pinsrd xmm1, DWORD PTR [rax], 0x1
    pinsrq xmm1, rax, 0x1
    pinsrq xmm1, QWORD PTR [rax], 0x1
    vpinsrb xmm1, xmm2, eax, 0x1
    vpinsrd xmm1, xmm2, eax, 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax], 0x1
    vpinsrq xmm1, xmm2, rax, 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax], 0x1
    vpinsrb xmm1, xmm2, eax, 0x1
    vpinsrd xmm1, xmm2, eax, 0x1
    vpinsrq xmm1, xmm2, rax, 0x1
    pinsrw xmm0, eax, 0x1
    vpinsrw xmm1, xmm2, eax, 0x1
    vpinsrw xmm1, xmm2, eax, 0x1
    pmaddubsw mm1, mm2
    pmaddubsw xmm1, xmm2
    vpmaddubsw xmm1, xmm2, xmm3
    vpmaddubsw ymm1, ymm2, ymm3
    vpmaddubsw xmm1{k1}{z}, xmm2, xmm3
    vpmaddubsw ymm1{k1}{z}, ymm2, ymm3
    vpmaddubsw zmm1{k1}{z}, zmm2, zmm3
    pmaddwd mm0, mm0
    pmaddwd xmm1, xmm2
    vpmaddwd xmm1, xmm2, xmm3
    vpmaddwd ymm1, ymm2, ymm3
    vpmaddwd xmm1{k1}{z}, xmm2, xmm3
    vpmaddwd ymm1{k1}{z}, ymm2, ymm3
    vpmaddwd zmm1{k1}{z}, zmm2, zmm3
    pmaxsw mm1, mm2
    pmaxsb xmm1, xmm2
    pmaxsw xmm1, xmm2
    pmaxsd xmm1, xmm2
    vpmaxsb xmm1, xmm2, xmm3
    vpmaxsw xmm1, xmm2, xmm3
    vpmaxsd xmm1, xmm2, xmm3
    vpmaxsb ymm1, ymm2, ymm3
    vpmaxsw ymm1, ymm2, ymm3
    vpmaxsd ymm1, ymm2, ymm3
    vpmaxsb xmm1{k1}{z}, xmm2, xmm3
    vpmaxsb ymm1{k1}{z}, ymm2, ymm3
    vpmaxsb zmm1{k1}{z}, zmm2, zmm3
    vpmaxsw xmm1{k1}{z}, xmm2, xmm3
    vpmaxsw ymm1{k1}{z}, ymm2, ymm3
    vpmaxsw zmm1{k1}{z}, zmm2, zmm3
    vpmaxsd xmm1{k1}{z}, xmm2, xmm3
    vpmaxsd ymm1{k1}{z}, ymm2, ymm3
    vpmaxsd zmm1{k1}{z}, zmm2, zmm3
    vpmaxsq xmm1{k1}{z}, xmm2, xmm3
    vpmaxsq ymm1{k1}{z}, ymm2, ymm3
    vpmaxsq zmm1{k1}{z}, zmm2, zmm3
    pmaxub mm1, mm2
    pmaxub xmm1, xmm2
    pmaxuw xmm1, xmm2
    vpmaxub xmm1, xmm2, xmm3
    vpmaxuw xmm1, xmm2, xmm3
    vpmaxub ymm1, ymm2, ymm3
    vpmaxuw ymm1, ymm2, ymm3
    vpmaxub xmm1{k1}{z}, xmm2, xmm3
    vpmaxub ymm1{k1}{z}, ymm2, ymm3
    vpmaxub zmm1{k1}{z}, zmm2, zmm3
    vpmaxuw xmm1{k1}{z}, xmm2, xmm3
    vpmaxuw ymm1{k1}{z}, ymm2, ymm3
    vpmaxuw zmm1{k1}{z}, zmm2, zmm3
    pmaxud xmm1, xmm2
    vpmaxud xmm1, xmm2, xmm3
    vpmaxud ymm1, ymm2, ymm3
    vpmaxud xmm1{k1}{z}, xmm2, xmm3
    vpmaxud ymm1{k1}{z}, ymm2, ymm3
    vpmaxud zmm1{k1}{z}, zmm2, zmm3
    vpmaxuq xmm1{k1}{z}, xmm2, xmm3
    vpmaxuq ymm1{k1}{z}, ymm2, ymm3
    vpmaxuq zmm1{k1}{z}, zmm2, zmm3
    pminsw mm1, mm2
    pminsb xmm1, xmm2
    pminsw xmm1, xmm2
    vpminsb xmm1, xmm2, xmm3
    vpminsw xmm1, xmm2, xmm3
    vpminsb ymm1, ymm2, ymm3
    vpminsw ymm1, ymm2, ymm3
    vpminsb xmm1{k1}{z}, xmm2, xmm3
    vpminsb ymm1{k1}{z}, ymm2, ymm3
    vpminsb zmm1{k1}{z}, zmm2, zmm3
    vpminsw xmm1{k1}{z}, xmm2, xmm3
    vpminsw ymm1{k1}{z}, ymm2, ymm3
    vpminsw zmm1{k1}{z}, zmm2, zmm3
    pminsd xmm1, xmm2
    vpminsd xmm1, xmm2, xmm3
    vpminsd ymm1, ymm2, ymm3
    vpminsd xmm1{k1}{z}, xmm2, xmm3
    vpminsd ymm1{k1}{z}, ymm2, ymm3
    vpminsd zmm1{k1}{z}, zmm2, zmm3
    vpminsq xmm1{k1}{z}, xmm2, xmm3
    vpminsq ymm1{k1}{z}, ymm2, ymm3
    vpminsq zmm1{k1}{z}, zmm2, zmm3
    pminub mm1, mm2
    pminub xmm1, xmm2
    pminuw xmm1, xmm2
    vpminub xmm1, xmm2, xmm3
    vpminuw xmm1, xmm2, xmm3
    vpminub ymm1, ymm2, ymm3
    vpminuw ymm1, ymm2, ymm3
    vpminub xmm1{k1}{z}, xmm2, xmm3
    vpminub ymm1{k1}{z}, ymm2, ymm3
    vpminub zmm1{k1}{z}, zmm2, zmm3
    vpminuw xmm1{k1}{z}, xmm2, xmm3
    vpminuw ymm1{k1}{z}, ymm2, ymm3
    vpminuw zmm1{k1}{z}, zmm2, zmm3
    pminud xmm1, xmm2
    vpminud xmm1, xmm2, xmm3
    vpminud ymm1, ymm2, ymm3
    vpminud xmm1{k1}{z}, xmm2, xmm3
    vpminud ymm1{k1}{z}, ymm2, ymm3
    vpminud zmm1{k1}{z}, zmm2, zmm3
    vpminuq xmm1{k1}{z}, xmm2, xmm3
    vpminuq ymm1{k1}{z}, ymm2, ymm3
    vpminuq zmm1{k1}{z}, zmm2, zmm3
    pmovmskb eax, mm0
    pmovmskb eax, xmm0
    vpmovmskb eax, xmm1
    vpmovmskb eax, ymm1
    pmovsxbw xmm1, xmm2
    pmovsxbd xmm1, xmm2
    pmovsxbq xmm1, xmm2
    pmovsxwd xmm1, xmm2
    pmovsxwq xmm1, xmm2
    pmovsxdq xmm1, xmm2
    vpmovsxbw xmm1, xmm2
    vpmovsxbd xmm1, xmm2
    vpmovsxbq xmm1, xmm2
    vpmovsxwd xmm1, xmm2
    vpmovsxwq xmm1, xmm2
    vpmovsxdq xmm1, xmm2
    vpmovsxbw ymm1, xmm2
    vpmovsxbd ymm1, xmm2
    vpmovsxbq ymm1, xmm2
    vpmovsxwd ymm1, xmm2
    vpmovsxwq ymm1, xmm2
    vpmovsxdq ymm1, xmm2
    vpmovsxbw xmm1{k1}{z}, xmm2
    vpmovsxbw ymm1{k1}{z}, xmm2
    vpmovsxbw zmm1{k1}{z}, ymm2
    vpmovsxbd xmm1{k1}{z}, xmm2
    vpmovsxbd ymm1{k1}{z}, xmm2
    vpmovsxbd zmm1{k1}{z}, xmm2
    vpmovsxbq xmm1{k1}{z}, xmm2
    vpmovsxbq ymm1{k1}{z}, xmm2
    vpmovsxbq zmm1{k1}{z}, xmm2
    vpmovsxwd xmm1{k1}{z}, xmm2
    vpmovsxwd ymm1{k1}{z}, xmm2
    vpmovsxwd zmm1{k1}{z}, ymm2
    vpmovsxwq xmm1{k1}{z}, xmm2
    vpmovsxwq ymm1{k1}{z}, xmm2
    vpmovsxwq zmm1{k1}{z}, xmm2
    vpmovsxdq xmm1{k1}{z}, xmm2
    vpmovsxdq ymm1{k1}{z}, xmm2
    vpmovsxdq zmm1{k1}{z}, ymm2
    pmovzxbw xmm1, xmm2
    pmovzxbd xmm1, xmm2
    pmovzxbq xmm1, xmm2
    pmovzxwd xmm1, xmm2
    pmovzxwq xmm1, xmm2
    pmovzxdq xmm1, xmm2
    vpmovzxbw xmm1, xmm2
    vpmovzxbd xmm1, xmm2
    vpmovzxbq xmm1, xmm2
    vpmovzxwd xmm1, xmm2
    vpmovzxwq xmm1, xmm2
    vpmovzxbw ymm1, xmm2
    vpmovzxbd ymm1, xmm2
    vpmovzxbq ymm1, xmm2
    vpmovzxwd ymm1, xmm2
    vpmovzxwq ymm1, xmm2
    vpmovzxdq ymm1, xmm2
    vpmovzxbw ymm1{k1}{z}, xmm2
    vpmovzxbw zmm1{k1}{z}, ymm2
    vpmovzxbd xmm1{k1}{z}, xmm2
    vpmovzxbd ymm1{k1}{z}, xmm2
    vpmovzxbd zmm1{k1}{z}, xmm2
    vpmovzxbq xmm1{k1}{z}, xmm2
    vpmovzxbq ymm1{k1}{z}, xmm2
    vpmovzxbq zmm1{k1}{z}, xmm2
    vpmovzxwd xmm1{k1}{z}, xmm2
    vpmovzxwd ymm1{k1}{z}, xmm2
    vpmovzxwd zmm1{k1}{z}, ymm2
    vpmovzxwq xmm1{k1}{z}, xmm2
    vpmovzxwq ymm1{k1}{z}, xmm2
    vpmovzxwq zmm1{k1}{z}, xmm2
    vpmovzxdq xmm1{k1}{z}, xmm2
    vpmovzxdq ymm1{k1}{z}, xmm2
    vpmovzxdq zmm1{k1}{z}, ymm2
    pmuldq xmm1, xmm2
    vpmuldq xmm1, xmm2, xmm3
    vpmuldq ymm1, ymm2, ymm3
    vpmuldq xmm1{k1}{z}, xmm2, xmm3
    vpmuldq ymm1{k1}{z}, ymm2, ymm3
    vpmuldq zmm1{k1}{z}, zmm2, zmm3
    pmulhrsw mm1, mm2
    pmulhrsw xmm1, xmm2
    vpmulhrsw xmm1, xmm2, xmm3
    vpmulhrsw ymm1, ymm2, ymm3
    vpmulhrsw xmm1{k1}{z}, xmm2, xmm3
    vpmulhrsw ymm1{k1}{z}, ymm2, ymm3
    vpmulhrsw zmm1{k1}{z}, zmm2, zmm3
    pmulhuw mm1, mm2
    pmulhuw xmm1, xmm2
    vpmulhuw xmm1, xmm2, xmm3
    vpmulhuw ymm1, ymm2, ymm3
    vpmulhuw xmm1{k1}{z}, xmm2, xmm3
    vpmulhuw ymm1{k1}{z}, ymm2, ymm3
    vpmulhuw zmm1{k1}{z}, zmm2, zmm3
    pmulhw mm0, mm0
    pmulhw xmm1, xmm2
    vpmulhw xmm1, xmm2, xmm3
    vpmulhw ymm1, ymm2, ymm3
    vpmulhw xmm1{k1}{z}, xmm2, xmm3
    vpmulhw ymm1{k1}{z}, ymm2, ymm3
    vpmulhw zmm1{k1}{z}, zmm2, zmm3
    pmulld xmm1, xmm2
    vpmulld xmm1, xmm2, xmm3
    vpmulld ymm1, ymm2, ymm3
    vpmulld xmm1{k1}{z}, xmm2, xmm3
    vpmulld ymm1{k1}{z}, ymm2, ymm3
    vpmulld zmm1{k1}{z}, zmm2, zmm3
    vpmullq xmm1{k1}{z}, xmm2, xmm3
    vpmullq ymm1{k1}{z}, ymm2, ymm3
    vpmullq zmm1{k1}{z}, zmm2, zmm3
    pmullw mm0, mm0
    pmullw xmm1, xmm2
    vpmullw xmm1, xmm2, xmm3
    vpmullw ymm1, ymm2, ymm3
    vpmullw xmm1{k1}{z}, xmm2, xmm3
    vpmullw ymm1{k1}{z}, ymm2, ymm3
    vpmullw zmm1{k1}{z}, zmm2, zmm3
    pmuludq mm1, mm2
    pmuludq xmm1, xmm2
    vpmuludq xmm1, xmm2, xmm3
    vpmuludq ymm1, ymm2, ymm3
    vpmuludq xmm1{k1}{z}, xmm2, xmm3
    vpmuludq ymm1{k1}{z}, ymm2, ymm3
    vpmuludq zmm1{k1}{z}, zmm2, zmm3
    pop ax
    pop WORD PTR [rax]
    pop rax
    pop QWORD PTR [rax]
    pop ax
    pop rax
    pop fs
    pop gs
    popcnt ax, ax
    popcnt ax, WORD PTR [rax]
    popcnt eax, eax
    popcnt eax, DWORD PTR [rax]
    popcnt rax, rax
    popcnt rax, QWORD PTR [rax]
    popf
    popfq
    por mm0, mm0
    por xmm1, xmm2
    vpor xmm1, xmm2, xmm3
    vpor ymm1, ymm2, ymm3
    vpord xmm1{k1}{z}, xmm2, xmm3
    vpord ymm1{k1}{z}, ymm2, ymm3
    vpord zmm1{k1}{z}, zmm2, zmm3
    vporq xmm1{k1}{z}, xmm2, xmm3
    vporq ymm1{k1}{z}, ymm2, ymm3
    vporq zmm1{k1}{z}, zmm2, zmm3
    prefetcht0 BYTE PTR [rax]
    prefetcht1 BYTE PTR [rax]
    prefetcht2 BYTE PTR [rax]
    prefetchnta BYTE PTR [rax]
    prefetchit0 BYTE PTR [rip+0x100]
    prefetchit1 BYTE PTR [rip+0x100]
    prefetchw BYTE PTR [rax]
    psadbw mm1, mm2
    psadbw xmm1, xmm2
    vpsadbw xmm1, xmm2, xmm3
    vpsadbw ymm1, ymm2, ymm3
    vpsadbw xmm1, xmm2, xmm3
    vpsadbw ymm1, ymm2, ymm3
    vpsadbw zmm1, zmm2, zmm3
    pshufb mm1, mm2
    pshufb xmm1, xmm2
    vpshufb xmm1, xmm2, xmm3
    vpshufb ymm1, ymm2, ymm3
    vpshufb xmm1{k1}{z}, xmm2, xmm3
    vpshufb ymm1{k1}{z}, ymm2, ymm3
    vpshufb zmm1{k1}{z}, zmm2, zmm3
    pshufd xmm1, xmm2, 0x1
    vpshufd xmm1, xmm2, 0x1
    vpshufd ymm1, ymm2, 0x1
    vpshufd xmm1{k1}{z}, xmm2, 0x1
    vpshufd ymm1{k1}{z}, ymm2, 0x1
    vpshufd zmm1{k1}{z}, zmm2, 0x1
    pshufhw xmm1, xmm2, 0x1
    vpshufhw xmm1, xmm2, 0x1
    vpshufhw ymm1, ymm2, 0x1
    vpshufhw xmm1{k1}{z}, xmm2, 0x1
    vpshufhw ymm1{k1}{z}, ymm2, 0x1
    vpshufhw zmm1{k1}{z}, zmm2, 0x1
    pshuflw xmm1, xmm2, 0x1
    vpshuflw xmm1, xmm2, 0x1
    vpshuflw ymm1, ymm2, 0x1
    vpshuflw xmm1{k1}{z}, xmm2, 0x1
    vpshuflw ymm1{k1}{z}, ymm2, 0x1
    vpshuflw zmm1{k1}{z}, zmm2, 0x1
    pshufw mm1, mm2, 0x1
    psignb mm1, mm2
    psignb xmm1, xmm2
    psignw mm1, mm2
    psignw xmm1, xmm2
    psignd mm1, mm2
    psignd xmm1, xmm2
    vpsignb xmm1, xmm2, xmm3
    vpsignw xmm1, xmm2, xmm3
    vpsignd xmm1, xmm2, xmm3
    vpsignb ymm1, ymm2, ymm3
    vpsignw ymm1, ymm2, ymm3
    vpsignd ymm1, ymm2, ymm3
    pslldq xmm1, 0x1
    vpslldq xmm1, xmm2, 0x1
    vpslldq ymm1, ymm2, 0x1
    vpslldq xmm1, xmm2, 0x1
    vpslldq ymm1, ymm2, 0x1
    vpslldq zmm1, zmm2, 0x1
    psllw mm0, mm0
    psllw xmm1, xmm2
    psllw mm1, 0x1
    psllw xmm1, 0x1
    pslld mm0, mm0
    pslld xmm1, xmm2
    pslld xmm1, 0x1
    psllq mm0, mm0
    psllq xmm1, xmm2
    psllq xmm1, 0x1
    vpsllw xmm1, xmm2, xmm3
    vpsllw xmm1, xmm2, 0x1
    vpslld xmm1, xmm2, xmm3
    vpslld xmm1, xmm2, 0x1
    vpsllq xmm1, xmm2, xmm3
    vpsllq xmm1, xmm2, 0x1
    vpsllw ymm1, ymm2, xmm3
    vpsllw ymm1, ymm2, 0x1
    vpslld ymm1, ymm2, xmm3
    vpslld ymm1, ymm2, 0x1
    vpsllq ymm1, ymm2, xmm3
    vpsllq ymm1, ymm2, 0x1
    vpsllw xmm1{k1}{z}, xmm2, xmm3
    vpsllw ymm1{k1}{z}, ymm2, xmm3
    vpsllw zmm1{k1}{z}, zmm2, xmm3
    vpsllw xmm1{k1}{z}, xmm2, 0x1
    vpsllw ymm1{k1}{z}, ymm2, 0x1
    vpsllw zmm1{k1}{z}, zmm2, 0x1
    vpslld xmm1{k1}{z}, xmm2, xmm3
    vpslld ymm1{k1}{z}, ymm2, xmm3
    vpslld zmm1{k1}{z}, zmm2, xmm3
    vpslld xmm1{k1}{z}, xmm2, 0x1
    vpslld ymm1{k1}{z}, ymm2, 0x1
    vpslld zmm1{k1}{z}, zmm2, 0x1
    vpsllq xmm1{k1}{z}, xmm2, xmm3
    vpsllq ymm1{k1}{z}, ymm2, xmm3
    vpsllq zmm1{k1}{z}, zmm2, xmm3
    vpsllq xmm1{k1}{z}, xmm2, 0x1
    vpsllq ymm1{k1}{z}, ymm2, 0x1
    vpsllq zmm1{k1}{z}, zmm2, 0x1
    psraw mm0, mm0
    psraw xmm1, xmm2
    psraw xmm1, 0x1
    psrad mm0, mm0
    psrad xmm1, xmm2
    psrad xmm1, 0x1
    vpsraw xmm1, xmm2, xmm3
    vpsraw xmm1, xmm2, 0x1
    vpsrad xmm1, xmm2, xmm3
    vpsrad xmm1, xmm2, 0x1
    vpsraw ymm1, ymm2, xmm3
    vpsraw ymm1, ymm2, 0x1
    vpsrad ymm1, ymm2, xmm3
    vpsrad ymm1, ymm2, 0x1
    vpsraw xmm1{k1}{z}, xmm2, xmm3
    vpsraw ymm1{k1}{z}, ymm2, xmm3
    vpsraw zmm1{k1}{z}, zmm2, xmm3
    vpsraw xmm1{k1}{z}, xmm2, 0x1
    vpsraw ymm1{k1}{z}, ymm2, 0x1
    vpsraw zmm1{k1}{z}, zmm2, 0x1
    vpsrad xmm1{k1}{z}, xmm2, xmm3
    vpsrad ymm1{k1}{z}, ymm2, xmm3
    vpsrad zmm1{k1}{z}, zmm2, xmm3
    vpsrad xmm1{k1}{z}, xmm2, 0x1
    vpsrad ymm1{k1}{z}, ymm2, 0x1
    vpsrad zmm1{k1}{z}, zmm2, 0x1
    vpsraq xmm1{k1}{z}, xmm2, xmm3
    vpsraq ymm1{k1}{z}, ymm2, xmm3
    vpsraq zmm1{k1}{z}, zmm2, xmm3
    vpsraq xmm1{k1}{z}, xmm2, 0x1
    vpsraq ymm1{k1}{z}, ymm2, 0x1
    vpsraq zmm1{k1}{z}, zmm2, 0x1
    psrldq xmm1, 0x1
    vpsrldq xmm1, xmm2, 0x1
    vpsrldq ymm1, ymm2, 0x1
    vpsrldq xmm1, xmm2, 0x1
    vpsrldq ymm1, ymm2, 0x1
    vpsrldq zmm1, zmm2, 0x1
    psrlw mm0, mm0
    psrlw xmm1, xmm2
    psrlw xmm1, 0x1
    psrld mm0, mm0
    psrld xmm1, xmm2
    psrld xmm1, 0x1
    psrlq mm0, mm0
    psrlq xmm1, xmm2
    psrlq xmm1, 0x1
    vpsrlw xmm1, xmm2, xmm3
    vpsrlw xmm1, xmm2, 0x1
    vpsrld xmm1, xmm2, xmm3
    vpsrld xmm1, xmm2, 0x1
    vpsrlq xmm1, xmm2, xmm3
    vpsrlq xmm1, xmm2, 0x1
    vpsrlw ymm1, ymm2, xmm3
    vpsrlw ymm1, ymm2, 0x1
    vpsrld ymm1, ymm2, xmm3
    vpsrld ymm1, ymm2, 0x1
    vpsrlq ymm1, ymm2, xmm3
    vpsrlq ymm1, ymm2, 0x1
    vpsrlw xmm1{k1}{z}, xmm2, xmm3
    vpsrlw ymm1{k1}{z}, ymm2, xmm3
    vpsrlw zmm1{k1}{z}, zmm2, xmm3
    vpsrlw xmm1{k1}{z}, xmm2, 0x1
    vpsrlw ymm1{k1}{z}, ymm2, 0x1
    vpsrlw zmm1{k1}{z}, zmm2, 0x1
    vpsrld xmm1{k1}{z}, xmm2, xmm3
    vpsrld ymm1{k1}{z}, ymm2, xmm3
    vpsrld zmm1{k1}{z}, zmm2, xmm3
    vpsrld xmm1{k1}{z}, xmm2, 0x1
    vpsrld ymm1{k1}{z}, ymm2, 0x1
    vpsrld zmm1{k1}{z}, zmm2, 0x1
    vpsrlq xmm1{k1}{z}, xmm2, xmm3
    vpsrlq ymm1{k1}{z}, ymm2, xmm3
    vpsrlq zmm1{k1}{z}, zmm2, xmm3
    vpsrlq xmm1{k1}{z}, xmm2, 0x1
    vpsrlq ymm1{k1}{z}, ymm2, 0x1
    vpsrlq zmm1{k1}{z}, zmm2, 0x1
    psubb mm0, mm0
    psubb xmm1, xmm2
    psubw mm0, mm0
    psubw xmm1, xmm2
    psubd mm0, mm0
    psubd xmm1, xmm2
    vpsubb xmm1, xmm2, xmm3
    vpsubw xmm1, xmm2, xmm3
    vpsubd xmm1, xmm2, xmm3
    vpsubb ymm1, ymm2, ymm3
    vpsubw ymm1, ymm2, ymm3
    vpsubd ymm1, ymm2, ymm3
    vpsubb xmm1{k1}{z}, xmm2, xmm3
    vpsubb ymm1{k1}{z}, ymm2, ymm3
    vpsubb zmm1{k1}{z}, zmm2, zmm3
    vpsubw xmm1{k1}{z}, xmm2, xmm3
    vpsubw ymm1{k1}{z}, ymm2, ymm3
    vpsubw zmm1{k1}{z}, zmm2, zmm3
    vpsubd xmm1{k1}{z}, xmm2, xmm3
    vpsubd ymm1{k1}{z}, ymm2, ymm3
    vpsubd zmm1{k1}{z}, zmm2, zmm3
    psubq mm1, mm2
    psubq xmm1, xmm2
    vpsubq xmm1, xmm2, xmm3
    vpsubq ymm1, ymm2, ymm3
    vpsubq xmm1{k1}{z}, xmm2, xmm3
    vpsubq ymm1{k1}{z}, ymm2, ymm3
    vpsubq zmm1{k1}{z}, zmm2, zmm3
    psubsb mm0, mm0
    psubsb xmm1, xmm2
    psubsw mm0, mm0
    psubsw xmm1, xmm2
    vpsubsb xmm1, xmm2, xmm3
    vpsubsw xmm1, xmm2, xmm3
    vpsubsb ymm1, ymm2, ymm3
    vpsubsw ymm1, ymm2, ymm3
    vpsubsb xmm1{k1}{z}, xmm2, xmm3
    vpsubsb ymm1{k1}{z}, ymm2, ymm3
    vpsubsb zmm1{k1}{z}, zmm2, zmm3
    vpsubsw xmm1{k1}{z}, xmm2, xmm3
    vpsubsw ymm1{k1}{z}, ymm2, ymm3
    vpsubsw zmm1{k1}{z}, zmm2, zmm3
    psubusb mm0, mm0
    psubusb xmm1, xmm2
    psubusw mm0, mm0
    psubusw xmm1, xmm2
    vpsubusb xmm1, xmm2, xmm3
    vpsubusw xmm1, xmm2, xmm3
    vpsubusb ymm1, ymm2, ymm3
    vpsubusw ymm1, ymm2, ymm3
    vpsubusb xmm1{k1}{z}, xmm2, xmm3
    vpsubusb ymm1{k1}{z}, ymm2, ymm3
    vpsubusb zmm1{k1}{z}, zmm2, zmm3
    vpsubusw xmm1{k1}{z}, xmm2, xmm3
    vpsubusw ymm1{k1}{z}, ymm2, ymm3
    vpsubusw zmm1{k1}{z}, zmm2, zmm3
    ptest xmm1, xmm2
    vptest xmm1, xmm2
    vptest ymm1, ymm2
    ptwrite rax
    ptwrite eax
    punpckhbw mm0, mm0
    punpckhbw xmm1, xmm2
    punpckhwd mm0, mm0
    punpckhwd xmm1, xmm2
    punpckhdq mm0, mm0
    punpckhdq xmm1, xmm2
    punpckhqdq xmm1, xmm2
    vpunpckhbw xmm1, xmm2, xmm3
    vpunpckhwd xmm1, xmm2, xmm3
    vpunpckhdq xmm1, xmm2, xmm3
    vpunpckhqdq xmm1, xmm2, xmm3
    vpunpckhbw ymm1, ymm2, ymm3
    vpunpckhwd ymm1, ymm2, ymm3
    vpunpckhdq ymm1, ymm2, ymm3
    vpunpckhqdq ymm1, ymm2, ymm3
    vpunpckhbw xmm1{k1}{z}, xmm2, xmm3
    vpunpckhwd xmm1{k1}{z}, xmm2, xmm3
    vpunpckhdq xmm1{k1}{z}, xmm2, xmm3
    vpunpckhqdq xmm1{k1}{z}, xmm2, xmm3
    vpunpckhbw ymm1{k1}{z}, ymm2, ymm3
    vpunpckhwd ymm1{k1}{z}, ymm2, ymm3
    vpunpckhdq ymm1{k1}{z}, ymm2, ymm3
    vpunpckhqdq ymm1{k1}{z}, ymm2, ymm3
    vpunpckhbw zmm1{k1}{z}, zmm2, zmm3
    vpunpckhwd zmm1{k1}{z}, zmm2, zmm3
    vpunpckhdq zmm1{k1}{z}, zmm2, zmm3
    vpunpckhqdq zmm1{k1}{z}, zmm2, zmm3
    punpcklbw mm0, mm0
    punpcklbw xmm1, xmm2
    punpcklwd mm0, mm0
    punpcklwd xmm1, xmm2
    punpckldq mm0, mm0
    punpckldq xmm1, xmm2
    punpcklqdq xmm1, xmm2
    vpunpcklbw xmm1, xmm2, xmm3
    vpunpcklwd xmm1, xmm2, xmm3
    vpunpckldq xmm1, xmm2, xmm3
    vpunpcklqdq xmm1, xmm2, xmm3
    vpunpcklbw ymm1, ymm2, ymm3
    vpunpcklwd ymm1, ymm2, ymm3
    vpunpckldq ymm1, ymm2, ymm3
    vpunpcklqdq ymm1, ymm2, ymm3
    vpunpcklbw xmm1{k1}{z}, xmm2, xmm3
    vpunpcklwd xmm1{k1}{z}, xmm2, xmm3
    vpunpckldq xmm1{k1}{z}, xmm2, xmm3
    vpunpcklqdq xmm1{k1}{z}, xmm2, xmm3
    vpunpcklbw ymm1{k1}{z}, ymm2, ymm3
    vpunpcklwd ymm1{k1}{z}, ymm2, ymm3
    vpunpckldq ymm1{k1}{z}, ymm2, ymm3
    vpunpcklqdq ymm1{k1}{z}, ymm2, ymm3
    vpunpcklbw zmm1{k1}{z}, zmm2, zmm3
    vpunpcklwd zmm1{k1}{z}, zmm2, zmm3
    vpunpckldq zmm1{k1}{z}, zmm2, zmm3
    vpunpcklqdq zmm1{k1}{z}, zmm2, zmm3
    push ax
    push WORD PTR [rax]
    push rax
    push QWORD PTR [rax]
    push ax
    push rax
    push 0x1
    push 0x1
    push 0x1
    push fs
    push gs
    pushf
    pushfq
    pxor mm0, mm0
    pxor xmm1, xmm2
    vpxor xmm1, xmm2, xmm3
    vpxor ymm1, ymm2, ymm3
    vpxord xmm1{k1}{z}, xmm2, xmm3
    vpxord ymm1{k1}{z}, ymm2, ymm3
    vpxord zmm1{k1}{z}, zmm2, zmm3
    vpxorq xmm1{k1}{z}, xmm2, xmm3
    vpxorq ymm1{k1}{z}, ymm2, ymm3
    vpxorq zmm1{k1}{z}, zmm2, zmm3
    rcl al, 1
    rcl BYTE PTR [rax], 1
    rcl al, cl
    rcl BYTE PTR [rax], cl
    rcl al, 0x1
    rcl BYTE PTR [rax], 0x1
    rcl ax, 1
    rcl WORD PTR [rax], 1
    rcl ax, cl
    rcl WORD PTR [rax], cl
    rcl ax, 0x1
    rcl WORD PTR [rax], 0x1
    rcl eax, 1
    rcl DWORD PTR [rax], 1
    rcl rax, 1
    rcl QWORD PTR [rax], 1
    rcl eax, cl
    rcl DWORD PTR [rax], cl
    rcl rax, cl
    rcl QWORD PTR [rax], cl
    rcl eax, 0x1
    rcl DWORD PTR [rax], 0x1
    rcl rax, 0x1
    rcl QWORD PTR [rax], 0x1
    rcr al, 1
    rcr BYTE PTR [rax], 1
    rcr al, cl
    rcr BYTE PTR [rax], cl
    rcr al, 0x1
    rcr BYTE PTR [rax], 0x1
    rcr ax, 1
    rcr WORD PTR [rax], 1
    rcr ax, cl
    rcr WORD PTR [rax], cl
    rcr ax, 0x1
    rcr WORD PTR [rax], 0x1
    rcr eax, 1
    rcr DWORD PTR [rax], 1
    rcr rax, 1
    rcr QWORD PTR [rax], 1
    rcr eax, cl
    rcr DWORD PTR [rax], cl
    rcr rax, cl
    rcr QWORD PTR [rax], cl
    rcr eax, 0x1
    rcr DWORD PTR [rax], 0x1
    rcr rax, 0x1
    rcr QWORD PTR [rax], 0x1
    rol al, cl
    rol BYTE PTR [rax], cl
    rol al, 0x1
    rol BYTE PTR [rax], 0x1
    rol ax, 1
    rol WORD PTR [rax], 1
    rol ax, cl
    rol WORD PTR [rax], cl
    rol ax, 0x1
    rol WORD PTR [rax], 0x1
    rol eax, 1
    rol DWORD PTR [rax], 1
    rol rax, 1
    rol QWORD PTR [rax], 1
    rol eax, cl
    rol DWORD PTR [rax], cl
    rol rax, cl
    rol QWORD PTR [rax], cl
    rol eax, 0x1
    rol DWORD PTR [rax], 0x1
    rol rax, 0x1
    rol QWORD PTR [rax], 0x1
    ror al, 1
    ror BYTE PTR [rax], 1
    ror al, cl
    ror BYTE PTR [rax], cl
    ror al, 0x1
    ror BYTE PTR [rax], 0x1
    ror ax, 1
    ror WORD PTR [rax], 1
    ror ax, cl
    ror WORD PTR [rax], cl
    ror ax, 0x1
    ror WORD PTR [rax], 0x1
    ror eax, 1
    ror DWORD PTR [rax], 1
    ror rax, 1
    ror QWORD PTR [rax], 1
    ror eax, cl
    ror DWORD PTR [rax], cl
    ror rax, cl
    ror QWORD PTR [rax], cl
    ror eax, 0x1
    ror DWORD PTR [rax], 0x1
    ror rax, 0x1
    ror QWORD PTR [rax], 0x1
    rcpps xmm1, xmm2
    vrcpps xmm1, xmm2
    vrcpps ymm1, ymm2
    rcpss xmm1, xmm2
    vrcpss xmm1, xmm2, xmm3
    rdfsbase eax
    rdfsbase rax
    rdgsbase eax
    rdgsbase rax
    rdmsr
    rdmsrlist
    rdpid rax
    rdpkru
    rdpmc
    rdrand ax
    rdrand eax
    rdrand rax
    rdseed ax
    rdseed eax
    rdseed rax
    rdsspd eax
    rdsspq rax
    rdtsc
    rdtscp
    rep insb
    rep insw
    rep insd
    rep lodsb
    rep lodsw
    rep lodsd
    rep lodsq
    rep movsb
    rep movsw
    rep movsd
    rep movsq
    rep outsb
    rep outsw
    rep outsd
    rep stosb
    rep stosw
    rep stosd
    rep stosq
    repe cmpsb
    repe cmpsw
    repe cmpsd
    repe cmpsq
    repe scasb
    repe scasw
    repe scasd
    repe scasq
    repne cmpsb
    repne cmpsw
    repne cmpsd
    repne cmpsq
    repne scasb
    repne scasw
    repne scasd
    repne scasq
    ret
    ret
    ret 0x1
    ret 0x1
    rorx eax, eax, 0x1
    rorx eax, DWORD PTR [rax], 0x1
    rorx rax, rax, 0x1
    rorx rax, QWORD PTR [rax], 0x1
    roundpd xmm1, xmm2, 0x1
    vroundpd xmm1, xmm2, 0x1
    vroundpd ymm1, ymm2, 0x1
    roundps xmm1, xmm2, 0x1
    vroundps xmm1, xmm2, 0x1
    vroundps ymm1, ymm2, 0x1
    roundsd xmm1, xmm2, 0x1
    vroundsd xmm1, xmm2, xmm3, 0x1
    roundss xmm1, xmm2, 0x1
    vroundss xmm1, xmm2, xmm3, 0x1
    rsm
    rsqrtps xmm1, xmm2
    vrsqrtps xmm1, xmm2
    vrsqrtps ymm1, ymm2
    rsqrtss xmm1, xmm2
    vrsqrtss xmm1, xmm2, xmm3
    rstorssp QWORD PTR [rax]
    sal al, 1
    sal BYTE PTR [rax], 1
    sal al, cl
    sal BYTE PTR [rax], cl
    sal al, 0x1
    sal BYTE PTR [rax], 0x1
    sal ax, 1
    sal WORD PTR [rax], 1
    sal ax, cl
    sal WORD PTR [rax], cl
    sal ax, 0x1
    sal WORD PTR [rax], 0x1
    sal eax, 1
    sal DWORD PTR [rax], 1
    sal rax, 1
    sal QWORD PTR [rax], 1
    sal eax, cl
    sal DWORD PTR [rax], cl
    sal rax, cl
    sal QWORD PTR [rax], cl
    sal eax, 0x1
    sal DWORD PTR [rax], 0x1
    sal rax, 0x1
    sal QWORD PTR [rax], 0x1
    sar al, 1
    sar BYTE PTR [rax], 1
    sar al, cl
    sar BYTE PTR [rax], cl
    sar al, 0x1
    sar BYTE PTR [rax], 0x1
    sar ax, 1
    sar WORD PTR [rax], 1
    sar ax, cl
    sar WORD PTR [rax], cl
    sar ax, 0x1
    sar WORD PTR [rax], 0x1
    sar eax, 1
    sar DWORD PTR [rax], 1
    sar rax, 1
    sar QWORD PTR [rax], 1
    sar eax, cl
    sar DWORD PTR [rax], cl
    sar rax, cl
    sar QWORD PTR [rax], cl
    sar eax, 0x1
    sar DWORD PTR [rax], 0x1
    sar rax, 0x1
    sar QWORD PTR [rax], 0x1
    shl al, 1
    shl BYTE PTR [rax], 1
    shl al, cl
    shl BYTE PTR [rax], cl
    shl al, 0x1
    shl BYTE PTR [rax], 0x1
    shl ax, 1
    shl WORD PTR [rax], 1
    shl ax, cl
    shl WORD PTR [rax], cl
    shl ax, 0x1
    shl WORD PTR [rax], 0x1
    shl eax, 1
    shl DWORD PTR [rax], 1
    shl rax, 1
    shl QWORD PTR [rax], 1
    shl eax, cl
    shl DWORD PTR [rax], cl
    shl rax, cl
    shl QWORD PTR [rax], cl
    shl eax, 0x1
    shl DWORD PTR [rax], 0x1
    shl rax, 0x1
    shl QWORD PTR [rax], 0x1
    shr al, 1
    shr BYTE PTR [rax], 1
    shr al, cl
    shr BYTE PTR [rax], cl
    shr al, 0x1
    shr BYTE PTR [rax], 0x1
    shr ax, 1
    shr WORD PTR [rax], 1
    shr ax, cl
    shr WORD PTR [rax], cl
    shr ax, 0x1
    shr WORD PTR [rax], 0x1
    shr eax, 1
    shr DWORD PTR [rax], 1
    shr rax, 1
    shr QWORD PTR [rax], 1
    shr eax, cl
    shr DWORD PTR [rax], cl
    shr rax, cl
    shr QWORD PTR [rax], cl
    shr eax, 0x1
    shr DWORD PTR [rax], 0x1
    shr rax, 0x1
    shr QWORD PTR [rax], 0x1
    sarx eax, eax, eax
    sarx eax, DWORD PTR [rax], eax
    shlx eax, eax, eax
    shlx eax, DWORD PTR [rax], eax
    shrx eax, eax, eax
    shrx eax, DWORD PTR [rax], eax
    sarx rax, rax, rax
    sarx rax, QWORD PTR [rax], rax
    shlx rax, rax, rax
    shlx rax, QWORD PTR [rax], rax
    shrx rax, rax, rax
    shrx rax, QWORD PTR [rax], rax
    saveprevssp
    sbb al, 0x1
    sbb ax, 0x1
    sbb eax, 0x1
    sbb rax, 0x1
    sbb al, 0x1
    sbb BYTE PTR [rax], 0x1
    sbb ax, 0x1
    sbb WORD PTR [rax], 0x1
    sbb eax, 0x1
    sbb DWORD PTR [rax], 0x1
    sbb rax, 0x1
    sbb QWORD PTR [rax], 0x1
    sbb ax, 0x1
    sbb WORD PTR [rax], 0x1
    sbb eax, 0x1
    sbb DWORD PTR [rax], 0x1
    sbb rax, 0x1
    sbb QWORD PTR [rax], 0x1
    sbb al, al
    sbb BYTE PTR [rax], al
    sbb ax, ax
    sbb WORD PTR [rax], ax
    sbb eax, eax
    sbb DWORD PTR [rax], eax
    sbb rax, rax
    sbb QWORD PTR [rax], rax
    sbb al, al
    sbb al, BYTE PTR [rax]
    sbb ax, ax
    sbb ax, WORD PTR [rax]
    sbb eax, eax
    sbb eax, DWORD PTR [rax]
    sbb rax, rax
    sbb rax, QWORD PTR [rax]
    scasb
    scasw
    scasd
    scasq
    scasb
    scasw
    scasd
    scasq
    senduipi rax
    serialize
    seta al
    seta BYTE PTR [rax]
    setae al
    setae BYTE PTR [rax]
    setb al
    setb BYTE PTR [rax]
    setbe al
    setbe BYTE PTR [rax]
    setc al
    setc BYTE PTR [rax]
    sete al
    sete BYTE PTR [rax]
    setg al
    setg BYTE PTR [rax]
    setge al
    setge BYTE PTR [rax]
    setl al
    setl BYTE PTR [rax]
    setle al
    setle BYTE PTR [rax]
    setna al
    setna BYTE PTR [rax]
    setnae al
    setnae BYTE PTR [rax]
    setnb al
    setnb BYTE PTR [rax]
    setnbe al
    setnbe BYTE PTR [rax]
    setnc al
    setnc BYTE PTR [rax]
    setne al
    setne BYTE PTR [rax]
    setng al
    setng BYTE PTR [rax]
    setnge al
    setnge BYTE PTR [rax]
    setnl al
    setnl BYTE PTR [rax]
    setnle al
    setnle BYTE PTR [rax]
    setno al
    setno BYTE PTR [rax]
    setnp al
    setnp BYTE PTR [rax]
    setns al
    setns BYTE PTR [rax]
    setnz al
    setnz BYTE PTR [rax]
    seto al
    seto BYTE PTR [rax]
    setp al
    setp BYTE PTR [rax]
    setpe al
    setpe BYTE PTR [rax]
    setpo al
    setpo BYTE PTR [rax]
    sets al
    sets BYTE PTR [rax]
    setz al
    setz BYTE PTR [rax]
    setssbsy
    sfence
    sgdt [rax]
    sha1msg1 xmm1, xmm2
    sha1msg2 xmm1, xmm2
    sha1nexte xmm1, xmm2
    sha1rnds4 xmm1, xmm2, 0x1
    sha256msg1 xmm1, xmm2
    sha256msg2 xmm1, xmm2
    sha256rnds2 xmm1, xmm2
    shld ax, ax, 0x1
    shld WORD PTR [rax], ax, 0x1
    shld ax, ax, cl
    shld WORD PTR [rax], ax, cl
    shld eax, eax, 0x1
    shld DWORD PTR [rax], eax, 0x1
    shld rax, rax, 0x1
    shld QWORD PTR [rax], rax, 0x1
    shld eax, eax, cl
    shld DWORD PTR [rax], eax, cl
    shld rax, rax, cl
    shld QWORD PTR [rax], rax, cl
    shrd ax, ax, 0x1
    shrd WORD PTR [rax], ax, 0x1
    shrd ax, ax, cl
    shrd WORD PTR [rax], ax, cl
    shrd eax, eax, 0x1
    shrd DWORD PTR [rax], eax, 0x1
    shrd rax, rax, 0x1
    shrd QWORD PTR [rax], rax, 0x1
    shrd eax, eax, cl
    shrd DWORD PTR [rax], eax, cl
    shrd rax, rax, cl
    shrd QWORD PTR [rax], rax, cl
    shufpd xmm1, xmm2, 0x1
    vshufpd xmm1, xmm2, xmm3, 0x1
    vshufpd ymm1, ymm2, ymm3, 0x1
    vshufpd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vshufpd ymm1{k1}{z}, ymm2, ymm3, 0x1
    vshufpd zmm1{k1}{z}, zmm2, zmm3, 0x1
    shufps xmm1, xmm3, 0x1
    vshufps xmm1, xmm2, xmm3, 0x1
    vshufps ymm1, ymm2, ymm3, 0x1
    vshufps xmm1{k1}{z}, xmm2, xmm3, 0x1
    vshufps ymm1{k1}{z}, ymm2, ymm3, 0x1
    vshufps zmm1{k1}{z}, zmm2, zmm3, 0x1
    sidt [rax]
    sldt ax
    sldt WORD PTR [rax]
    smsw ax
    smsw WORD PTR [rax]
    smsw eax
    smsw rax
    sqrtpd xmm1, xmm2
    vsqrtpd xmm1, xmm2
    vsqrtpd ymm1, ymm2
    vsqrtpd xmm1{k1}{z}, xmm2
    vsqrtpd ymm1{k1}{z}, ymm2
    vsqrtpd zmm1{k1}{z}, zmm2
    sqrtps xmm1, xmm2
    vsqrtps xmm1, xmm2
    vsqrtps ymm1, ymm2
    vsqrtps xmm1{k1}{z}, xmm2
    vsqrtps ymm1{k1}{z}, ymm2
    vsqrtps zmm1{k1}{z}, zmm2
    sqrtsd xmm1, xmm2
    vsqrtsd xmm1, xmm2, xmm3
    vsqrtsd xmm1{k1}{z}, xmm2, xmm3
    sqrtss xmm1, xmm2
    vsqrtss xmm1, xmm2, xmm3
    vsqrtss xmm1{k1}{z}, xmm2, xmm3
    stac
    stc
    std
    sti
    stmxcsr DWORD PTR [rax]
    vstmxcsr DWORD PTR [rax]
    stosb
    stosw
    stosd
    stosq
    stosb
    stosw
    stosd
    stosq
    str ax
    str WORD PTR [rax]
    sttilecfg [rax]
    stui
    sub al, 0x1
    sub ax, 0x1
    sub eax, 0x1
    sub rax, 0x1
    sub al, 0x1
    sub BYTE PTR [rax], 0x1
    sub ax, 0x1
    sub WORD PTR [rax], 0x1
    sub eax, 0x1
    sub DWORD PTR [rax], 0x1
    sub rax, 0x1
    sub QWORD PTR [rax], 0x1
    sub ax, 0x1
    sub WORD PTR [rax], 0x1
    sub eax, 0x1
    sub DWORD PTR [rax], 0x1
    sub rax, 0x1
    sub QWORD PTR [rax], 0x1
    sub al, al
    sub BYTE PTR [rax], al
    sub ax, ax
    sub WORD PTR [rax], ax
    sub eax, eax
    sub DWORD PTR [rax], eax
    sub rax, rax
    sub QWORD PTR [rax], rax
    sub al, al
    sub al, BYTE PTR [rax]
    sub ax, ax
    sub ax, WORD PTR [rax]
    sub eax, eax
    sub eax, DWORD PTR [rax]
    sub rax, rax
    sub rax, QWORD PTR [rax]
    subpd xmm1, xmm2
    vsubpd xmm1, xmm2, xmm3
    vsubpd ymm1, ymm2, ymm3
    vsubpd xmm1{k1}{z}, xmm2, xmm3
    vsubpd ymm1{k1}{z}, ymm2, ymm3
    vsubpd zmm1{k1}{z}, zmm2, zmm3
    subps xmm1, xmm2
    vsubps xmm1, xmm2, xmm3
    vsubps ymm1, ymm2, ymm3
    vsubps xmm1{k1}{z}, xmm2, xmm3
    vsubps ymm1{k1}{z}, ymm2, ymm3
    vsubps zmm1{k1}{z}, zmm2, zmm3
    subsd xmm1, xmm2
    vsubsd xmm1, xmm2, xmm3
    vsubsd xmm1{k1}{z}, xmm2, xmm3
    subss xmm1, xmm2
    vsubss xmm1, xmm2, xmm3
    vsubss xmm1{k1}{z}, xmm2, xmm3
    swapgs
    syscall
    sysenter
    sysexitq
    sysexitq
    sysretq
    sysretq
    tdpbf16ps tmm1, tmm2, tmm3
    tdpbssd tmm1, tmm2, tmm3
    tdpbsud tmm1, tmm2, tmm3
    tdpbusd tmm1, tmm2, tmm3
    tdpbuud tmm1, tmm2, tmm3
    tdpfp16ps tmm1, tmm2, tmm3
    test al, 0x1
    test ax, 0x1
    test eax, 0x1
    test rax, 0x1
    test al, 0x1
    test BYTE PTR [rax], 0x1
    test ax, 0x1
    test WORD PTR [rax], 0x1
    test eax, 0x1
    test DWORD PTR [rax], 0x1
    test rax, 0x1
    test QWORD PTR [rax], 0x1
    test al, al
    test BYTE PTR [rax], al
    test ax, ax
    test WORD PTR [rax], ax
    test eax, eax
    test DWORD PTR [rax], eax
    test rax, rax
    test QWORD PTR [rax], rax
    testui
    tileloadd tmm1, [rax+rbx*1]
    tileloaddt1 tmm1, [rax+rbx*1]
    tilerelease
    tilestored [rax+rbx*1], tmm1
    tilezero tmm1
    tpause eax
    tzcnt ax, ax
    tzcnt ax, WORD PTR [rax]
    tzcnt eax, eax
    tzcnt eax, DWORD PTR [rax]
    tzcnt rax, rax
    tzcnt rax, QWORD PTR [rax]
    ucomisd xmm1, xmm2
    vucomisd xmm1, xmm2
    vucomisd xmm1, xmm2
    ucomiss xmm1, xmm2
    vucomiss xmm1, xmm2
    vucomiss xmm1, xmm2
    ud01 eax, eax
    ud01 eax, DWORD PTR [rax]
    ud1 eax, eax
    ud1 eax, DWORD PTR [rax]
    ud2
    udb
    uiret
    umonitor rax
    umwait eax
    unpckhpd xmm1, xmm2
    vunpckhpd xmm1, xmm2, xmm3
    vunpckhpd ymm1, ymm2, ymm3
    vunpckhpd xmm1{k1}{z}, xmm2, xmm3
    vunpckhpd ymm1{k1}{z}, ymm2, ymm3
    vunpckhpd zmm1{k1}{z}, zmm2, zmm3
    unpckhps xmm1, xmm2
    vunpckhps xmm1, xmm2, xmm3
    vunpckhps ymm1, ymm2, ymm3
    vunpckhps xmm1{k1}{z}, xmm2, xmm3
    vunpckhps ymm1{k1}{z}, ymm2, ymm3
    vunpckhps zmm1{k1}{z}, zmm2, zmm3
    unpcklpd xmm1, xmm2
    vunpcklpd xmm1, xmm2, xmm3
    vunpcklpd ymm1, ymm2, ymm3
    vunpcklpd xmm1{k1}{z}, xmm2, xmm3
    vunpcklpd ymm1{k1}{z}, ymm2, ymm3
    vunpcklpd zmm1{k1}{z}, zmm2, zmm3
    unpcklps xmm1, xmm2
    vunpcklps xmm1, xmm2, xmm3
    vunpcklps ymm1, ymm2, ymm3
    vunpcklps xmm1{k1}{z}, xmm2, xmm3
    vunpcklps ymm1{k1}{z}, ymm2, ymm3
    vunpcklps zmm1{k1}{z}, zmm2, zmm3
    vaddph xmm1{k1}{z}, xmm2, xmm3
    vaddph ymm1{k1}{z}, ymm2, ymm3
    vaddph zmm1{k1}{z}, zmm2, zmm3
    vaddsh xmm1{k1}{z}, xmm2, xmm3
    valignd xmm1{k1}{z}, xmm2, xmm3, 0x1
    valignq xmm1{k1}{z}, xmm2, xmm3, 0x1
    valignd ymm1{k1}{z}, ymm2, ymm3, 0x1
    valignq ymm1{k1}{z}, ymm2, ymm3, 0x1
    valignd zmm1{k1}{z}, zmm2, zmm3, 0x1
    valignq zmm1{k1}{z}, zmm2, zmm3, 0x1
    vbcstnebf162ps xmm1, WORD PTR [rax]
    vbcstnebf162ps ymm1, WORD PTR [rax]
    vbcstnesh2ps xmm1, WORD PTR [rax]
    vbcstnesh2ps ymm1, WORD PTR [rax]
    vblendmpd xmm1{k1}{z}, xmm2, xmm3
    vblendmpd ymm1{k1}{z}, ymm2, ymm3
    vblendmpd zmm1{k1}{z}, zmm2, zmm3
    vblendmps xmm1{k1}{z}, xmm2, xmm3
    vblendmps ymm1{k1}{z}, ymm2, ymm3
    vblendmps zmm1{k1}{z}, zmm2, zmm3
    vbroadcastss xmm1, DWORD PTR [rax]
    vbroadcastss ymm1, DWORD PTR [rax]
    vbroadcastsd ymm1, QWORD PTR [rax]
    vbroadcastf128 ymm1, [rax]
    vbroadcastss xmm1, xmm2
    vbroadcastss ymm1, xmm2
    vbroadcastsd ymm1, xmm2
    vbroadcastsd ymm1{k1}{z}, xmm2
    vbroadcastsd zmm1{k1}{z}, xmm2
    vbroadcastf32x2 ymm1{k1}{z}, xmm2
    vbroadcastf32x2 zmm1{k1}{z}, xmm2
    vbroadcastss xmm1{k1}{z}, xmm2
    vbroadcastss ymm1{k1}{z}, xmm2
    vbroadcastss zmm1{k1}{z}, xmm2
    vbroadcastf32x4 ymm1{k1}{z}, [rax]
    vbroadcastf32x4 zmm1{k1}{z}, [rax]
    vbroadcastf64x2 ymm1{k1}{z}, [rax]
    vbroadcastf64x2 zmm1{k1}{z}, [rax]
    vbroadcastf32x8 zmm1{k1}{z}, [rax]
    vbroadcastf64x4 zmm1{k1}{z}, [rax]
    vcmpph k1{k2}, xmm2, xmm3, 0x1
    vcmpph k1{k2}, ymm2, ymm3, 0x1
    vcmpph k1{k2}, zmm2, zmm3, 0x1
    vcmpsh k1{k2}, xmm2, xmm3, 0x1
    vcomish xmm1, xmm2
    vcompresspd xmm1{k1}{z}, xmm2
    vcompresspd ymm1{k1}{z}, ymm2
    vcompresspd zmm1{k1}{z}, zmm2
    vcompressps xmm1{k1}{z}, xmm2
    vcompressps ymm1{k1}{z}, ymm2
    vcompressps zmm1{k1}{z}, zmm2
    vcvtdq2ph xmm1{k1}{z}, xmm2
    vcvtdq2ph xmm1{k1}{z}, ymm2
    vcvtdq2ph ymm1{k1}{z}, zmm2
    vcvtne2ps2bf16 xmm1{k1}{z}, xmm2, xmm3
    vcvtne2ps2bf16 ymm1{k1}{z}, ymm2, ymm3
    vcvtne2ps2bf16 zmm1{k1}{z}, zmm2, zmm3
    vcvtneebf162ps xmm1, [rax]
    vcvtneebf162ps ymm1, [rax]
    vcvtneeph2ps xmm1, [rax]
    vcvtneeph2ps ymm1, [rax]
    vcvtneobf162ps xmm1, [rax]
    vcvtneobf162ps ymm1, [rax]
    vcvtneoph2ps xmm1, [rax]
    vcvtneoph2ps ymm1, [rax]
    vcvtneps2bf16 xmm1, xmm2
    vcvtneps2bf16 xmm1, ymm2
    vcvtneps2bf16 xmm1{k1}{z}, xmm2
    vcvtneps2bf16 xmm1{k1}{z}, ymm2
    vcvtneps2bf16 ymm1{k1}{z}, zmm2
    vcvtpd2ph xmm1{k1}{z}, xmm2
    vcvtpd2ph xmm1{k1}{z}, ymm2
    vcvtpd2ph xmm1{k1}{z}, zmm2
    vcvtpd2qq xmm1{k1}{z}, xmm2
    vcvtpd2qq ymm1{k1}{z}, ymm2
    vcvtpd2qq zmm1{k1}{z}, zmm2
    vcvtpd2udq xmm1{k1}{z}, xmm2
    vcvtpd2udq xmm1{k1}{z}, ymm2
    vcvtpd2udq ymm1{k1}{z}, zmm2
    vcvtpd2uqq xmm1{k1}{z}, xmm2
    vcvtpd2uqq ymm1{k1}{z}, ymm2
    vcvtpd2uqq zmm1{k1}{z}, zmm2
    vcvtph2dq xmm1{k1}{z}, xmm2
    vcvtph2dq ymm1{k1}{z}, xmm2
    vcvtph2dq zmm1{k1}{z}, ymm2
    vcvtph2pd xmm1{k1}{z}, xmm2
    vcvtph2pd ymm1{k1}{z}, xmm2
    vcvtph2pd zmm1{k1}{z}, xmm2
    vcvtph2ps xmm1, xmm2
    vcvtph2ps ymm1, xmm2
    vcvtph2ps xmm1{k1}{z}, xmm2
    vcvtph2ps ymm1{k1}{z}, xmm2
    vcvtph2ps zmm1{k1}{z}, ymm2
    vcvtph2psx xmm1{k1}{z}, xmm2
    vcvtph2psx ymm1{k1}{z}, xmm2
    vcvtph2psx zmm1{k1}{z}, ymm2
    vcvtph2qq xmm1{k1}{z}, xmm2
    vcvtph2qq ymm1{k1}{z}, xmm2
    vcvtph2qq zmm1{k1}{z}, xmm2
    vcvtph2udq xmm1{k1}{z}, xmm2
    vcvtph2udq ymm1{k1}{z}, xmm2
    vcvtph2udq zmm1{k1}{z}, ymm2
    vcvtph2uqq xmm1{k1}{z}, xmm2
    vcvtph2uqq ymm1{k1}{z}, xmm2
    vcvtph2uqq zmm1{k1}{z}, xmm2
    vcvtph2uw xmm1{k1}{z}, xmm2
    vcvtph2uw ymm1{k1}{z}, ymm2
    vcvtph2uw zmm1{k1}{z}, zmm2
    vcvtph2w xmm1{k1}{z}, xmm2
    vcvtph2w ymm1{k1}{z}, ymm2
    vcvtph2w zmm1{k1}{z}, zmm2
    vcvtps2ph xmm1, xmm2, 0x1
    vcvtps2ph xmm1, ymm2, 0x1
    vcvtps2ph xmm1{k1}{z}, xmm2, 0x1
    vcvtps2ph xmm1{k1}{z}, ymm2, 0x1
    vcvtps2ph ymm1{k1}{z}, zmm2, 0x1
    vcvtps2phx xmm1{k1}{z}, xmm2
    vcvtps2phx xmm1{k1}{z}, ymm2
    vcvtps2phx ymm1{k1}{z}, zmm2
    vcvtps2qq xmm1{k1}{z}, xmm2
    vcvtps2qq ymm1{k1}{z}, xmm2
    vcvtps2qq zmm1{k1}{z}, ymm2
    vcvtps2udq xmm1{k1}{z}, xmm2
    vcvtps2udq ymm1{k1}{z}, ymm2
    vcvtps2udq zmm1{k1}{z}, zmm2
    vcvtps2uqq xmm1{k1}{z}, xmm2
    vcvtps2uqq ymm1{k1}{z}, xmm2
    vcvtps2uqq zmm1{k1}{z}, ymm2
    vcvtqq2pd xmm1{k1}{z}, xmm2
    vcvtqq2pd ymm1{k1}{z}, ymm2
    vcvtqq2pd zmm1{k1}{z}, zmm2
    vcvtqq2ph xmm1{k1}{z}, xmm2
    vcvtqq2ph xmm1{k1}{z}, ymm2
    vcvtqq2ph xmm1{k1}{z}, zmm2
    vcvtqq2ps xmm1{k1}{z}, xmm2
    vcvtqq2ps xmm1{k1}{z}, ymm2
    vcvtqq2ps ymm1{k1}{z}, zmm2
    vcvtsd2sh xmm1{k1}{z}, xmm2, xmm3
    vcvtsd2usi eax, xmm1
    vcvtsd2usi rax, xmm1
    vcvtsh2sd xmm1{k1}{z}, xmm2, xmm3
    vcvtsh2si eax, xmm1
    vcvtsh2si rax, xmm1
    vcvtsh2ss xmm1{k1}{z}, xmm2, xmm3
    vcvtsh2usi eax, xmm1
    vcvtsh2usi rax, xmm1
    vcvtsi2sh xmm1, xmm2, eax
    vcvtsi2sh xmm1, xmm2, rax
    vcvtss2sh xmm1{k1}{z}, xmm2, xmm3
    vcvtss2usi eax, xmm1
    vcvtss2usi rax, xmm1
    vcvttpd2qq xmm1{k1}{z}, xmm2
    vcvttpd2qq ymm1{k1}{z}, ymm2
    vcvttpd2qq zmm1{k1}{z}, zmm2
    vcvttpd2udq xmm1{k1}{z}, xmm2
    vcvttpd2udq xmm1{k1}{z}, ymm2
    vcvttpd2udq ymm1{k1}{z}, zmm2
    vcvttpd2uqq xmm1{k1}{z}, xmm2
    vcvttpd2uqq ymm1{k1}{z}, ymm2
    vcvttpd2uqq zmm1{k1}{z}, zmm2
    vcvttph2dq xmm1{k1}{z}, xmm2
    vcvttph2dq ymm1{k1}{z}, xmm2
    vcvttph2dq zmm1{k1}{z}, ymm2
    vcvttph2qq xmm1{k1}{z}, xmm2
    vcvttph2qq ymm1{k1}{z}, xmm2
    vcvttph2qq zmm1{k1}{z}, xmm2
    vcvttph2udq xmm1{k1}{z}, xmm2
    vcvttph2udq ymm1{k1}{z}, xmm2
    vcvttph2udq zmm1{k1}{z}, ymm2
    vcvttph2uqq xmm1{k1}{z}, xmm2
    vcvttph2uqq ymm1{k1}{z}, xmm2
    vcvttph2uqq zmm1{k1}{z}, xmm2
    vcvttph2uw xmm1{k1}{z}, xmm2
    vcvttph2uw ymm1{k1}{z}, ymm2
    vcvttph2uw zmm1{k1}{z}, zmm2
    vcvttph2w xmm1{k1}{z}, xmm2
    vcvttph2w ymm1{k1}{z}, ymm2
    vcvttph2w zmm1{k1}{z}, zmm2
    vcvttps2qq xmm1{k1}{z}, xmm2
    vcvttps2qq ymm1{k1}{z}, xmm2
    vcvttps2qq zmm1{k1}{z}, ymm2
    vcvttps2udq xmm1{k1}{z}, xmm2
    vcvttps2udq ymm1{k1}{z}, ymm2
    vcvttps2udq zmm1{k1}{z}, zmm2
    vcvttps2uqq xmm1{k1}{z}, xmm2
    vcvttps2uqq ymm1{k1}{z}, xmm2
    vcvttps2uqq zmm1{k1}{z}, ymm2
    vcvttsd2usi eax, xmm1
    vcvttsd2usi rax, xmm1
    vcvttsh2si eax, xmm1
    vcvttsh2si rax, xmm1
    vcvttsh2usi eax, xmm1
    vcvttsh2usi rax, xmm1
    vcvttss2usi eax, xmm1
    vcvttss2usi rax, xmm1
    vcvtudq2pd xmm1{k1}{z}, xmm2
    vcvtudq2pd ymm1{k1}{z}, xmm2
    vcvtudq2pd zmm1{k1}{z}, ymm2
    vcvtudq2ph xmm1{k1}{z}, xmm2
    vcvtudq2ph xmm1{k1}{z}, ymm2
    vcvtudq2ph ymm1{k1}{z}, zmm2
    vcvtudq2ps xmm1{k1}{z}, xmm2
    vcvtudq2ps ymm1{k1}{z}, ymm2
    vcvtudq2ps zmm1{k1}{z}, zmm2
    vcvtuqq2pd xmm1{k1}{z}, xmm2
    vcvtuqq2pd ymm1{k1}{z}, ymm2
    vcvtuqq2pd zmm1{k1}{z}, zmm2
    vcvtuqq2ph xmm1{k1}{z}, xmm2
    vcvtuqq2ph xmm1{k1}{z}, ymm2
    vcvtuqq2ph xmm1{k1}{z}, zmm2
    vcvtuqq2ps xmm1{k1}{z}, xmm2
    vcvtuqq2ps xmm1{k1}{z}, ymm2
    vcvtuqq2ps ymm1{k1}{z}, zmm2
    vcvtusi2sd xmm1, xmm2, eax
    vcvtusi2sd xmm1, xmm2, DWORD PTR [rax]
    vcvtusi2sd xmm1, xmm2, rax
    vcvtusi2sd xmm1, xmm2, QWORD PTR [rax]
    vcvtusi2sh xmm1, xmm2, eax
    vcvtusi2sh xmm1, xmm2, rax
    vcvtusi2ss xmm1, xmm2, eax
    vcvtusi2ss xmm1, xmm2, DWORD PTR [rax]
    vcvtusi2ss xmm1, xmm2, rax
    vcvtusi2ss xmm1, xmm2, QWORD PTR [rax]
    vcvtuw2ph xmm1{k1}{z}, xmm2
    vcvtuw2ph ymm1{k1}{z}, ymm2
    vcvtuw2ph zmm1{k1}{z}, zmm2
    vcvtw2ph xmm1{k1}{z}, xmm2
    vcvtw2ph ymm1{k1}{z}, ymm2
    vcvtw2ph zmm1{k1}{z}, zmm2
    vdbpsadbw xmm1{k1}{z}, xmm2, xmm3, 0x1
    vdbpsadbw ymm1{k1}{z}, ymm2, ymm3, 0x1
    vdbpsadbw zmm1{k1}{z}, zmm2, zmm3, 0x1
    vdivph xmm1{k1}{z}, xmm2, xmm3
    vdivph ymm1{k1}{z}, ymm2, ymm3
    vdivph zmm1{k1}{z}, zmm2, zmm3
    vdivsh xmm1{k1}{z}, xmm2, xmm3
    vdpbf16ps xmm1{k1}{z}, xmm2, xmm3
    vdpbf16ps ymm1{k1}{z}, ymm2, ymm3
    vdpbf16ps zmm1{k1}{z}, zmm2, zmm3
    verr ax
    verr WORD PTR [rax]
    verw ax
    verw WORD PTR [rax]
    vexpandpd xmm1{k1}{z}, xmm2
    vexpandpd ymm1{k1}{z}, ymm2
    vexpandpd zmm1{k1}{z}, zmm2
    vexpandps xmm1{k1}{z}, xmm2
    vexpandps ymm1{k1}{z}, ymm2
    vexpandps zmm1{k1}{z}, zmm2
    vextractf128 xmm1, ymm2, 0x1
    vextractf32x4 xmm1{k1}{z}, ymm2, 0x1
    vextractf32x4 xmm1{k1}{z}, zmm2, 0x1
    vextractf64x2 xmm1{k1}{z}, ymm2, 0x1
    vextractf64x2 xmm1{k1}{z}, zmm2, 0x1
    vextractf32x8 ymm1{k1}{z}, zmm2, 0x1
    vextractf64x4 ymm1{k1}{z}, zmm2, 0x1
    vextracti128 xmm1, ymm2, 0x1
    vextracti32x4 xmm1{k1}{z}, ymm2, 0x1
    vextracti32x4 xmm1{k1}{z}, zmm2, 0x1
    vextracti64x2 xmm1{k1}{z}, ymm2, 0x1
    vextracti64x2 xmm1{k1}{z}, zmm2, 0x1
    vextracti32x8 ymm1{k1}{z}, zmm2, 0x1
    vextracti64x4 ymm1{k1}{z}, zmm2, 0x1
    vfcmaddcph xmm1{k1}{z}, xmm2, xmm3
    vfcmaddcph ymm1{k1}{z}, ymm2, ymm3
    vfcmaddcph zmm1{k1}{z}, zmm2, zmm3
    vfmaddcph xmm1{k1}{z}, xmm2, xmm3
    vfmaddcph ymm1{k1}{z}, ymm2, ymm3
    vfmaddcph zmm1{k1}{z}, zmm2, zmm3
    vfcmaddcsh xmm1{k1}{z}, xmm2, xmm3
    vfmaddcsh xmm1{k1}{z}, xmm2, xmm3
    vfcmulcph xmm1{k1}{z}, xmm2, xmm3
    vfcmulcph ymm1{k1}{z}, ymm2, ymm3
    vfcmulcph zmm1{k1}{z}, zmm2, zmm3
    vfmulcph xmm1{k1}{z}, xmm2, xmm3
    vfmulcph ymm1{k1}{z}, ymm2, ymm3
    vfmulcph zmm1{k1}{z}, zmm2, zmm3
    vfcmulcsh xmm1{k1}{z}, xmm2, xmm3
    vfmulcsh xmm1{k1}{z}, xmm2, xmm3
    vfixupimmpd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vfixupimmpd ymm1{k1}{z}, ymm2, ymm3, 0x1
    vfixupimmpd zmm1{k1}{z}, zmm2, zmm3, 0x1
    vfixupimmps xmm1{k1}{z}, xmm2, xmm3, 0x1
    vfixupimmps ymm1{k1}{z}, ymm2, ymm3, 0x1
    vfixupimmps zmm1{k1}{z}, zmm2, zmm3, 0x1
    vfixupimmsd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vfixupimmss xmm1{k1}{z}, xmm2, xmm3, 0x1
    vfmadd132pd xmm1, xmm2, xmm3
    vfmadd213pd xmm1, xmm2, xmm3
    vfmadd231pd xmm1, xmm2, xmm3
    vfmadd132pd ymm1, ymm2, ymm3
    vfmadd213pd ymm1, ymm2, ymm3
    vfmadd231pd ymm1, ymm2, ymm3
    vfmadd132pd xmm1{k1}{z}, xmm2, xmm3
    vfmadd213pd xmm1{k1}{z}, xmm2, xmm3
    vfmadd231pd xmm1{k1}{z}, xmm2, xmm3
    vfmadd132pd ymm1{k1}{z}, ymm2, ymm3
    vfmadd213pd ymm1{k1}{z}, ymm2, ymm3
    vfmadd231pd ymm1{k1}{z}, ymm2, ymm3
    vfmadd132pd zmm1{k1}{z}, zmm2, zmm3
    vfmadd213pd zmm1{k1}{z}, zmm2, zmm3
    vfmadd231pd zmm1{k1}{z}, zmm2, zmm3
    vfmadd132ph xmm1{k1}{z}, xmm2, xmm3
    vfmadd132ph ymm1{k1}{z}, ymm2, ymm3
    vfmadd132ph zmm1{k1}{z}, zmm2, zmm3
    vfmadd213ph xmm1{k1}{z}, xmm2, xmm3
    vfmadd213ph ymm1{k1}{z}, ymm2, ymm3
    vfmadd213ph zmm1{k1}{z}, zmm2, zmm3
    vfmadd231ph xmm1{k1}{z}, xmm2, xmm3
    vfmadd231ph ymm1{k1}{z}, ymm2, ymm3
    vfmadd231ph zmm1{k1}{z}, zmm2, zmm3
    vfnmadd132ph xmm1{k1}{z}, xmm2, xmm3
    vfnmadd132ph ymm1{k1}{z}, ymm2, ymm3
    vfnmadd132ph zmm1{k1}{z}, zmm2, zmm3
    vfnmadd213ph xmm1{k1}{z}, xmm2, xmm3
    vfnmadd213ph ymm1{k1}{z}, ymm2, ymm3
    vfnmadd213ph zmm1{k1}{z}, zmm2, zmm3
    vfnmadd231ph xmm1{k1}{z}, xmm2, xmm3
    vfnmadd231ph ymm1{k1}{z}, ymm2, ymm3
    vfnmadd231ph zmm1{k1}{z}, zmm2, zmm3
    vfmadd132ps xmm1, xmm2, xmm3
    vfmadd213ps xmm1, xmm2, xmm3
    vfmadd231ps xmm1, xmm2, xmm3
    vfmadd132ps ymm1, ymm2, ymm3
    vfmadd213ps ymm1, ymm2, ymm3
    vfmadd231ps ymm1, ymm2, ymm3
    vfmadd132ps xmm1{k1}{z}, xmm2, xmm3
    vfmadd213ps xmm1{k1}{z}, xmm2, xmm3
    vfmadd231ps xmm1{k1}{z}, xmm2, xmm3
    vfmadd132ps ymm1{k1}{z}, ymm2, ymm3
    vfmadd213ps ymm1{k1}{z}, ymm2, ymm3
    vfmadd231ps ymm1{k1}{z}, ymm2, ymm3
    vfmadd132ps zmm1{k1}{z}, zmm2, zmm3
    vfmadd213ps zmm1{k1}{z}, zmm2, zmm3
    vfmadd231ps zmm1{k1}{z}, zmm2, zmm3
    vfmadd132sd xmm1, xmm2, xmm3
    vfmadd213sd xmm1, xmm2, xmm3
    vfmadd231sd xmm1, xmm2, xmm3
    vfmadd132sd xmm1{k1}{z}, xmm2, xmm3
    vfmadd213sd xmm1{k1}{z}, xmm2, xmm3
    vfmadd231sd xmm1{k1}{z}, xmm2, xmm3
    vfmadd132sh xmm1{k1}{z}, xmm2, xmm3
    vfmadd213sh xmm1{k1}{z}, xmm2, xmm3
    vfmadd231sh xmm1{k1}{z}, xmm2, xmm3
    vfnmadd132sh xmm1{k1}{z}, xmm2, xmm3
    vfnmadd213sh xmm1{k1}{z}, xmm2, xmm3
    vfnmadd231sh xmm1{k1}{z}, xmm2, xmm3
    vfmadd132ss xmm1, xmm2, xmm3
    vfmadd213ss xmm1, xmm2, xmm3
    vfmadd231ss xmm1, xmm2, xmm3
    vfmadd132ss xmm1{k1}{z}, xmm2, xmm3
    vfmadd213ss xmm1{k1}{z}, xmm2, xmm3
    vfmadd231ss xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub132pd xmm1, xmm2, xmm3
    vfmaddsub213pd xmm1, xmm2, xmm3
    vfmaddsub231pd xmm1, xmm2, xmm3
    vfmaddsub132pd ymm1, ymm2, ymm3
    vfmaddsub213pd ymm1, ymm2, ymm3
    vfmaddsub231pd ymm1, ymm2, ymm3
    vfmaddsub213pd xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub231pd xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub132pd xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub213pd ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub231pd ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub132pd ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub213pd zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub231pd zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub132pd zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub132ph xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub132ph ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub132ph zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub213ph xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub213ph ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub213ph zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub231ph xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub231ph ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub231ph zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub132ps xmm1, xmm2, xmm3
    vfmaddsub213ps xmm1, xmm2, xmm3
    vfmaddsub231ps xmm1, xmm2, xmm3
    vfmaddsub132ps ymm1, ymm2, ymm3
    vfmaddsub213ps ymm1, ymm2, ymm3
    vfmaddsub231ps ymm1, ymm2, ymm3
    vfmaddsub213ps xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub231ps xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub132ps xmm1{k1}{z}, xmm2, xmm3
    vfmaddsub213ps ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub231ps ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub132ps ymm1{k1}{z}, ymm2, ymm3
    vfmaddsub213ps zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub231ps zmm1{k1}{z}, zmm2, zmm3
    vfmaddsub132ps zmm1{k1}{z}, zmm2, zmm3
    vfmsub132pd xmm1, xmm2, xmm3
    vfmsub213pd xmm1, xmm2, xmm3
    vfmsub231pd xmm1, xmm2, xmm3
    vfmsub132pd ymm1, ymm2, ymm3
    vfmsub213pd ymm1, ymm2, ymm3
    vfmsub231pd ymm1, ymm2, ymm3
    vfmsub132pd xmm1{k1}{z}, xmm2, xmm3
    vfmsub213pd xmm1{k1}{z}, xmm2, xmm3
    vfmsub231pd xmm1{k1}{z}, xmm2, xmm3
    vfmsub132pd ymm1{k1}{z}, ymm2, ymm3
    vfmsub213pd ymm1{k1}{z}, ymm2, ymm3
    vfmsub231pd ymm1{k1}{z}, ymm2, ymm3
    vfmsub132pd zmm1{k1}{z}, zmm2, zmm3
    vfmsub213pd zmm1{k1}{z}, zmm2, zmm3
    vfmsub231pd zmm1{k1}{z}, zmm2, zmm3
    vfmsub132ph xmm1{k1}{z}, xmm2, xmm3
    vfmsub132ph ymm1{k1}{z}, ymm2, ymm3
    vfmsub132ph zmm1{k1}{z}, zmm2, zmm3
    vfmsub213ph xmm1{k1}{z}, xmm2, xmm3
    vfmsub213ph ymm1{k1}{z}, ymm2, ymm3
    vfmsub213ph zmm1{k1}{z}, zmm2, zmm3
    vfmsub231ph xmm1{k1}{z}, xmm2, xmm3
    vfmsub231ph ymm1{k1}{z}, ymm2, ymm3
    vfmsub231ph zmm1{k1}{z}, zmm2, zmm3
    vfnmsub132ph xmm1{k1}{z}, xmm2, xmm3
    vfnmsub132ph ymm1{k1}{z}, ymm2, ymm3
    vfnmsub132ph zmm1{k1}{z}, zmm2, zmm3
    vfnmsub213ph xmm1{k1}{z}, xmm2, xmm3
    vfnmsub213ph ymm1{k1}{z}, ymm2, ymm3
    vfnmsub213ph zmm1{k1}{z}, zmm2, zmm3
    vfnmsub231ph xmm1{k1}{z}, xmm2, xmm3
    vfnmsub231ph ymm1{k1}{z}, ymm2, ymm3
    vfnmsub231ph zmm1{k1}{z}, zmm2, zmm3
    vfmsub132ps xmm1, xmm2, xmm3
    vfmsub213ps xmm1, xmm2, xmm3
    vfmsub231ps xmm1, xmm2, xmm3
    vfmsub132ps ymm1, ymm2, ymm3
    vfmsub213ps ymm1, ymm2, ymm3
    vfmsub231ps ymm1, ymm2, ymm3
    vfmsub132ps xmm1{k1}{z}, xmm2, xmm3
    vfmsub213ps xmm1{k1}{z}, xmm2, xmm3
    vfmsub231ps xmm1{k1}{z}, xmm2, xmm3
    vfmsub132ps ymm1{k1}{z}, ymm2, ymm3
    vfmsub213ps ymm1{k1}{z}, ymm2, ymm3
    vfmsub231ps ymm1{k1}{z}, ymm2, ymm3
    vfmsub132ps zmm1{k1}{z}, zmm2, zmm3
    vfmsub213ps zmm1{k1}{z}, zmm2, zmm3
    vfmsub231ps zmm1{k1}{z}, zmm2, zmm3
    vfmsub132sd xmm1, xmm2, xmm3
    vfmsub213sd xmm1, xmm2, xmm3
    vfmsub231sd xmm1, xmm2, xmm3
    vfmsub132sd xmm1{k1}{z}, xmm2, xmm3
    vfmsub213sd xmm1{k1}{z}, xmm2, xmm3
    vfmsub231sd xmm1{k1}{z}, xmm2, xmm3
    vfmsub132sh xmm1{k1}{z}, xmm2, xmm3
    vfmsub213sh xmm1{k1}{z}, xmm2, xmm3
    vfmsub231sh xmm1{k1}{z}, xmm2, xmm3
    vfnmsub132sh xmm1{k1}{z}, xmm2, xmm3
    vfnmsub213sh xmm1{k1}{z}, xmm2, xmm3
    vfnmsub231sh xmm1{k1}{z}, xmm2, xmm3
    vfmsub132ss xmm1, xmm2, xmm3
    vfmsub213ss xmm1, xmm2, xmm3
    vfmsub231ss xmm1, xmm2, xmm3
    vfmsub132ss xmm1{k1}{z}, xmm2, xmm3
    vfmsub213ss xmm1{k1}{z}, xmm2, xmm3
    vfmsub231ss xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd132pd xmm1, xmm2, xmm3
    vfmsubadd213pd xmm1, xmm2, xmm3
    vfmsubadd231pd xmm1, xmm2, xmm3
    vfmsubadd132pd ymm1, ymm2, ymm3
    vfmsubadd213pd ymm1, ymm2, ymm3
    vfmsubadd231pd ymm1, ymm2, ymm3
    vfmsubadd132pd xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd213pd xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd231pd xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd132pd ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd213pd ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd231pd ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd132pd zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd213pd zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd231pd zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd132ph xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd132ph ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd132ph zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd213ph xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd213ph ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd213ph zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd231ph xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd231ph ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd231ph zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd132ps xmm1, xmm2, xmm3
    vfmsubadd213ps xmm1, xmm2, xmm3
    vfmsubadd231ps xmm1, xmm2, xmm3
    vfmsubadd132ps ymm1, ymm2, ymm3
    vfmsubadd213ps ymm1, ymm2, ymm3
    vfmsubadd231ps ymm1, ymm2, ymm3
    vfmsubadd132ps xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd213ps xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd231ps xmm1{k1}{z}, xmm2, xmm3
    vfmsubadd132ps ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd213ps ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd231ps ymm1{k1}{z}, ymm2, ymm3
    vfmsubadd132ps zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd213ps zmm1{k1}{z}, zmm2, zmm3
    vfmsubadd231ps zmm1{k1}{z}, zmm2, zmm3
    vfnmadd132pd xmm1, xmm2, xmm3
    vfnmadd213pd xmm1, xmm2, xmm3
    vfnmadd231pd xmm1, xmm2, xmm3
    vfnmadd132pd ymm1, ymm2, ymm3
    vfnmadd213pd ymm1, ymm2, ymm3
    vfnmadd231pd ymm1, ymm2, ymm3
    vfnmadd132pd xmm0{k1}{z}, xmm1, xmm2
    vfnmadd213pd xmm1{k1}{z}, xmm2, xmm3
    vfnmadd231pd xmm1{k1}{z}, xmm2, xmm3
    vfnmadd132pd ymm1{k1}{z}, ymm2, ymm3
    vfnmadd213pd ymm1{k1}{z}, ymm2, ymm3
    vfnmadd231pd ymm1{k1}{z}, ymm2, ymm3
    vfnmadd132pd zmm1{k1}{z}, zmm2, zmm3
    vfnmadd213pd zmm1{k1}{z}, zmm2, zmm3
    vfnmadd231pd zmm1{k1}{z}, zmm2, zmm3
    vfnmadd132ps xmm1, xmm2, xmm3
    vfnmadd213ps xmm1, xmm2, xmm3
    vfnmadd231ps xmm1, xmm2, xmm3
    vfnmadd132ps ymm1, ymm2, ymm3
    vfnmadd213ps ymm1, ymm2, ymm3
    vfnmadd231ps ymm1, ymm2, ymm3
    vfnmadd132ps xmm1{k1}{z}, xmm2, xmm3
    vfnmadd213ps xmm1{k1}{z}, xmm2, xmm3
    vfnmadd231ps xmm1{k1}{z}, xmm2, xmm3
    vfnmadd132ps ymm1{k1}{z}, ymm2, ymm3
    vfnmadd213ps ymm1{k1}{z}, ymm2, ymm3
    vfnmadd231ps ymm1{k1}{z}, ymm2, ymm3
    vfnmadd132ps zmm1{k1}{z}, zmm2, zmm3
    vfnmadd213ps zmm1{k1}{z}, zmm2, zmm3
    vfnmadd231ps zmm1{k1}{z}, zmm2, zmm3
    vfnmadd132sd xmm1, xmm2, xmm3
    vfnmadd213sd xmm1, xmm2, xmm3
    vfnmadd231sd xmm1, xmm2, xmm3
    vfnmadd132sd xmm1{k1}{z}, xmm2, xmm3
    vfnmadd213sd xmm1{k1}{z}, xmm2, xmm3
    vfnmadd231sd xmm1{k1}{z}, xmm2, xmm3
    vfnmadd132ss xmm1, xmm2, xmm3
    vfnmadd213ss xmm1, xmm2, xmm3
    vfnmadd231ss xmm1, xmm2, xmm3
    vfnmadd132ss xmm1{k1}{z}, xmm2, xmm3
    vfnmadd213ss xmm1{k1}{z}, xmm2, xmm3
    vfnmadd231ss xmm1{k1}{z}, xmm2, xmm3
    vfnmsub132pd xmm1, xmm2, xmm3
    vfnmsub213pd xmm1, xmm2, xmm3
    vfnmsub231pd xmm1, xmm2, xmm3
    vfnmsub132pd ymm1, ymm2, ymm3
    vfnmsub213pd ymm1, ymm2, ymm3
    vfnmsub231pd ymm1, ymm2, ymm3
    vfnmsub132pd xmm1{k1}{z}, xmm2, xmm3
    vfnmsub213pd xmm1{k1}{z}, xmm2, xmm3
    vfnmsub231pd xmm1{k1}{z}, xmm2, xmm3
    vfnmsub132pd ymm1{k1}{z}, ymm2, ymm3
    vfnmsub213pd ymm1{k1}{z}, ymm2, ymm3
    vfnmsub231pd ymm1{k1}{z}, ymm2, ymm3
    vfnmsub132pd zmm1{k1}{z}, zmm2, zmm3
    vfnmsub213pd zmm1{k1}{z}, zmm2, zmm3
    vfnmsub231pd zmm1{k1}{z}, zmm2, zmm3
    vfnmsub132ps xmm1, xmm2, xmm3
    vfnmsub213ps xmm1, xmm2, xmm3
    vfnmsub231ps xmm1, xmm2, xmm3
    vfnmsub132ps ymm1, ymm2, ymm3
    vfnmsub213ps ymm1, ymm2, ymm3
    vfnmsub231ps ymm1, ymm2, ymm3
    vfnmsub132ps xmm1{k1}{z}, xmm2, xmm3
    vfnmsub213ps xmm1{k1}{z}, xmm2, xmm3
    vfnmsub231ps xmm1{k1}{z}, xmm2, xmm3
    vfnmsub132ps ymm1{k1}{z}, ymm2, ymm3
    vfnmsub213ps ymm1{k1}{z}, ymm2, ymm3
    vfnmsub231ps ymm1{k1}{z}, ymm2, ymm3
    vfnmsub132ps zmm1{k1}{z}, zmm2, zmm3
    vfnmsub213ps zmm1{k1}{z}, zmm2, zmm3
    vfnmsub231ps zmm1{k1}{z}, zmm2, zmm3
    vfnmsub132sd xmm1, xmm2, xmm3
    vfnmsub213sd xmm1, xmm2, xmm3
    vfnmsub231sd xmm1, xmm2, xmm3
    vfnmsub132sd xmm1{k1}{z}, xmm2, xmm3
    vfnmsub213sd xmm1{k1}{z}, xmm2, xmm3
    vfnmsub231sd xmm1{k1}{z}, xmm2, xmm3
    vfnmsub132ss xmm1, xmm2, xmm3
    vfnmsub213ss xmm1, xmm2, xmm3
    vfnmsub231ss xmm1, xmm2, xmm3
    vfnmsub132ss xmm1{k1}{z}, xmm2, xmm3
    vfnmsub213ss xmm1{k1}{z}, xmm2, xmm3
    vfnmsub231ss xmm1{k1}{z}, xmm2, xmm3
    vfpclasspd k2{k1}, xmm2, 0x1
    vfpclasspd k2{k1}, ymm2, 0x1
    vfpclasspd k2{k1}, zmm2, 0x1
    vfpclassph k1{k2}, xmm1, 0x1
    vfpclassph k1{k2}, ymm1, 0x1
    vfpclassph k1{k2}, zmm1, 0x1
    vfpclassps k2{k1}, xmm2, 0x1
    vfpclassps k2{k1}, ymm2, 0x1
    vfpclassps k2{k1}, zmm2, 0x1
    vfpclasssd k2{k1}, xmm2, 0x1
    vfpclasssh k1{k2}, xmm1, 0x1
    vfpclassss k2{k1}, xmm2, 0x1
    vgatherdpd xmm1, [rax+xmm14*1], xmm2
    vgatherqpd xmm1, [rax+xmm14*1], xmm2
    vgatherdpd ymm1, [rax+xmm14*1], ymm2
    vgatherqpd ymm1, [rax+ymm14*1], ymm2
    vgatherdps xmm1{k1}, [rax+xmm14*1]
    vgatherdps ymm1{k1}, [rax+ymm14*1]
    vgatherdps zmm1{k1}, [rax+zmm14*1]
    vgatherdpd xmm1{k1}, [rax+xmm14*1]
    vgatherdpd ymm1{k1}, [rax+xmm14*1]
    vgatherdpd zmm1{k1}, [rax+ymm14*1]
    vgatherdps xmm1, [rax+xmm14*1], xmm2
    vgatherqps xmm1, [rax+xmm14*1], xmm2
    vgatherdps ymm1, [rax+ymm14*1], ymm2
    vgatherqps xmm1, [rax+ymm14*1], xmm2
    vgatherqps xmm1{k1}, [rax+xmm14*1]
    vgatherqps xmm1{k1}, [rax+ymm14*1]
    vgatherqps ymm1{k1}, [rax+zmm14*1]
    vgatherqpd xmm1{k1}, [rax+xmm14*1]
    vgatherqpd ymm1{k1}, [rax+ymm14*1]
    vgatherqpd zmm1{k1}, [rax+zmm14*1]
    vgetexppd xmm1{k1}{z}, xmm2
    vgetexppd ymm1{k1}{z}, ymm2
    vgetexppd zmm1{k1}{z}, zmm2
    vgetexpph xmm1{k1}{z}, xmm2
    vgetexpph ymm1{k1}{z}, ymm2
    vgetexpph zmm1{k1}{z}, zmm2
    vgetexpps xmm1{k1}{z}, xmm2
    vgetexpps ymm1{k1}{z}, ymm2
    vgetexpps zmm1{k1}{z}, zmm2
    vgetexpsd xmm1{k1}{z}, xmm2, xmm3
    vgetexpsh xmm1{k1}{z}, xmm2, xmm3
    vgetexpss xmm1{k1}{z}, xmm2, xmm3
    vgetmantpd xmm1{k1}{z}, xmm2, 0x1
    vgetmantpd ymm1{k1}{z}, ymm2, 0x1
    vgetmantpd zmm1{k1}{z}, zmm2, 0x1
    vgetmantph xmm1{k1}{z}, xmm2, 0x1
    vgetmantph ymm1{k1}{z}, ymm2, 0x1
    vgetmantph zmm1{k1}{z}, zmm2, 0x1
    vgetmantps xmm1{k1}{z}, xmm2, 0x1
    vgetmantps ymm1{k1}{z}, ymm2, 0x1
    vgetmantps zmm1{k1}{z}, zmm2, 0x1
    vgetmantsd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vgetmantsh xmm1{k1}{z}, xmm2, xmm3, 0x1
    vgetmantss xmm1{k1}{z}, xmm2, xmm3, 0x1
    vinsertf128 ymm1, ymm2, xmm3, 0x1
    vinsertf32x4 ymm1{k1}{z}, ymm2, xmm3, 0x1
    vinsertf32x4 zmm1{k1}{z}, zmm2, xmm3, 0x1
    vinsertf64x2 ymm1{k1}{z}, ymm2, xmm3, 0x1
    vinsertf64x2 zmm1{k1}{z}, zmm2, xmm3, 0x1
    vinsertf32x8 zmm1{k1}{z}, zmm2, ymm3, 0x1
    vinsertf64x4 zmm1{k1}{z}, zmm2, ymm3, 0x1
    vinserti128 ymm1, ymm2, xmm3, 0x1
    vinserti32x4 ymm1{k1}{z}, ymm2, xmm3, 0x1
    vinserti32x4 zmm1{k1}{z}, zmm2, xmm3, 0x1
    vinserti64x2 ymm1{k1}{z}, ymm2, xmm3, 0x1
    vinserti64x2 zmm1{k1}{z}, zmm2, xmm3, 0x1
    vinserti32x8 zmm1{k1}{z}, zmm2, ymm3, 0x1
    vinserti64x4 zmm1{k1}{z}, zmm2, ymm3, 0x1
    vmaskmovps xmm1, xmm2, [rax]
    vmaskmovps ymm1, ymm2, [rax]
    vmaskmovpd xmm1, xmm2, [rax]
    vmaskmovpd ymm1, ymm2, [rax]
    vmaskmovps [rax], xmm1, xmm2
    vmaskmovps [rax], ymm1, ymm2
    vmaskmovpd [rax], xmm1, xmm2
    vmaskmovpd [rax], ymm1, ymm2
    vmaxph xmm1{k1}{z}, xmm2, xmm3
    vmaxph ymm1{k1}{z}, ymm2, ymm3
    vmaxph zmm1{k1}{z}, zmm2, zmm3
    vmaxsh xmm1{k1}{z}, xmm2, xmm3
    vminph xmm1{k1}{z}, xmm2, xmm3
    vminph ymm1{k1}{z}, ymm2, ymm3
    vminph zmm1{k1}{z}, zmm2, zmm3
    vminsh xmm1{k1}{z}, xmm2, xmm3
    vmovsh xmm1{k1}{z}, WORD PTR [rax]
    vmovsh WORD PTR [rax], xmm1
    vmovsh xmm1{k1}{z}, xmm2, xmm3
    vmovsh xmm1{k1}{z}, xmm2, xmm3
    vmovw xmm1, eax
    vmovw eax, xmm1
    vmulph xmm1{k1}{z}, xmm2, xmm3
    vmulph ymm1{k1}{z}, ymm2, ymm3
    vmulph zmm1{k1}{z}, zmm2, zmm3
    vmulsh xmm1{k1}{z}, xmm2, xmm3
    vp2intersectd k2, xmm2, xmm3
    vp2intersectd k2, ymm2, ymm3
    vp2intersectd k2, zmm2, zmm3
    vp2intersectq k2, xmm2, xmm3
    vp2intersectq k2, ymm2, ymm3
    vp2intersectq k2, zmm2, zmm3
    vpblendd xmm1, xmm2, xmm3, 0x1
    vpblendd ymm1, ymm2, ymm3, 0x1
    vpblendmb xmm1{k1}{z}, xmm2, xmm3
    vpblendmb ymm1{k1}{z}, ymm2, ymm3
    vpblendmb zmm1{k1}{z}, zmm2, zmm3
    vpblendmw xmm1{k1}{z}, xmm2, xmm3
    vpblendmw ymm1{k1}{z}, ymm2, ymm3
    vpblendmw zmm1{k1}{z}, zmm2, zmm3
    vpblendmd xmm1{k1}{z}, xmm2, xmm3
    vpblendmd ymm1{k1}{z}, ymm2, ymm3
    vpblendmd zmm1{k1}{z}, zmm2, zmm3
    vpblendmq xmm1{k1}{z}, xmm2, xmm3
    vpblendmq ymm1{k1}{z}, ymm2, ymm3
    vpblendmq zmm1{k1}{z}, zmm2, zmm3
    vpbroadcastb xmm1, xmm2
    vpbroadcastb ymm1, xmm2
    vpbroadcastb xmm1{k1}{z}, xmm2
    vpbroadcastb ymm1{k1}{z}, xmm2
    vpbroadcastb zmm1{k1}{z}, xmm2
    vpbroadcastw xmm1, xmm2
    vpbroadcastw ymm1, xmm2
    vpbroadcastw xmm1{k1}{z}, xmm2
    vpbroadcastw ymm1{k1}{z}, xmm2
    vpbroadcastw zmm1{k1}{z}, xmm2
    vpbroadcastd xmm1, xmm2
    vpbroadcastd ymm1, xmm2
    vpbroadcastd xmm1{k1}{z}, xmm2
    vpbroadcastd ymm1{k1}{z}, xmm2
    vpbroadcastd zmm1{k1}{z}, xmm2
    vpbroadcastq xmm1, xmm2
    vpbroadcastq ymm1, xmm2
    vpbroadcastq xmm1{k1}{z}, xmm2
    vpbroadcastq ymm1{k1}{z}, xmm2
    vpbroadcastq zmm1{k1}{z}, xmm2
    vbroadcasti32x2 xmm1{k1}{z}, xmm2
    vbroadcasti32x2 ymm1{k1}{z}, xmm2
    vbroadcasti32x2 zmm1{k1}{z}, xmm2
    vbroadcasti128 ymm1, [rax]
    vbroadcasti32x4 ymm1{k1}{z}, [rax]
    vbroadcasti32x4 zmm1{k1}{z}, [rax]
    vbroadcasti64x2 ymm1{k1}{z}, [rax]
    vbroadcasti64x2 zmm1{k1}{z}, [rax]
    vbroadcasti32x8 zmm1{k1}{z}, [rax]
    vbroadcasti64x4 zmm1{k1}{z}, [rax]
    vpbroadcastb xmm1{k1}{z}, eax
    vpbroadcastb ymm1{k1}{z}, eax
    vpbroadcastb zmm1{k1}{z}, eax
    vpbroadcastw xmm1{k1}{z}, eax
    vpbroadcastw ymm1{k1}{z}, eax
    vpbroadcastw zmm1{k1}{z}, eax
    vpbroadcastd xmm1{k1}{z}, eax
    vpbroadcastd ymm1{k1}{z}, eax
    vpbroadcastd zmm1{k1}{z}, eax
    vpbroadcastq xmm1{k1}{z}, rax
    vpbroadcastq ymm1{k1}{z}, rax
    vpbroadcastq zmm1{k1}{z}, rax
    vpbroadcastmb2q xmm1, k1
    vpbroadcastmb2q ymm1, k1
    vpbroadcastmb2q zmm1, k1
    vpbroadcastmw2d xmm1, k1
    vpbroadcastmw2d ymm1, k1
    vpbroadcastmw2d zmm1, k1
    vpcmpb k1{k2}, xmm2, xmm3, 0x1
    vpcmpb k1{k2}, ymm2, ymm3, 0x1
    vpcmpb k1{k2}, zmm2, zmm3, 0x1
    vpcmpub k1{k2}, xmm2, xmm3, 0x1
    vpcmpub k1{k2}, ymm2, ymm3, 0x1
    vpcmpub k1{k2}, zmm2, zmm3, 0x1
    vpcmpd k1{k2}, xmm2, xmm3, 0x1
    vpcmpd k1{k2}, ymm2, ymm3, 0x1
    vpcmpd k1{k2}, zmm2, zmm3, 0x1
    vpcmpud k1{k2}, xmm2, xmm3, 0x1
    vpcmpud k1{k2}, ymm2, ymm3, 0x1
    vpcmpud k1{k2}, zmm2, zmm3, 0x1
    vpcmpq k1{k2}, xmm2, xmm3, 0x1
    vpcmpq k1{k2}, ymm2, ymm3, 0x1
    vpcmpq k1{k2}, zmm2, zmm3, 0x1
    vpcmpuq k1{k2}, xmm2, xmm3, 0x1
    vpcmpuq k1{k2}, ymm2, ymm3, 0x1
    vpcmpuq k1{k2}, zmm2, zmm3, 0x1
    vpcmpw k1{k2}, xmm2, xmm3, 0x1
    vpcmpw k1{k2}, ymm2, ymm3, 0x1
    vpcmpw k1{k2}, zmm2, zmm3, 0x1
    vpcmpuw k1{k2}, xmm2, xmm3, 0x1
    vpcmpuw k1{k2}, ymm2, ymm3, 0x1
    vpcmpuw k1{k2}, zmm2, zmm3, 0x1
    vpcompressb [rax], xmm1
    vpcompressb xmm1{k1}{z}, xmm2
    vpcompressb [rax], ymm1
    vpcompressb ymm1{k1}{z}, ymm2
    vpcompressb [rax], zmm1
    vpcompressb zmm1{k1}{z}, zmm2
    vpcompressw [rax], xmm1
    vpcompressw xmm1{k1}{z}, xmm2
    vpcompressw [rax], ymm1
    vpcompressw ymm1{k1}{z}, ymm2
    vpcompressw [rax], zmm1
    vpcompressw zmm1{k1}{z}, zmm2
    vpcompressd xmm1{k1}{z}, xmm2
    vpcompressd ymm1{k1}{z}, ymm2
    vpcompressd zmm1{k1}{z}, zmm2
    vpcompressq xmm1{k1}{z}, xmm2
    vpcompressq ymm1{k1}{z}, ymm2
    vpcompressq zmm1{k1}{z}, zmm2
    vpconflictd xmm1{k1}{z}, xmm2
    vpconflictd ymm1{k1}{z}, ymm2
    vpconflictd zmm1{k1}{z}, zmm2
    vpconflictq xmm1{k1}{z}, xmm2
    vpconflictq ymm1{k1}{z}, ymm2
    vpconflictq zmm1{k1}{z}, zmm2
    vpdpbssd xmm1, xmm2, xmm3
    vpdpbssd ymm1, ymm2, ymm3
    vpdpbssds xmm1, xmm2, xmm3
    vpdpbssds ymm1, ymm2, ymm3
    vpdpbsud xmm1, xmm2, xmm3
    vpdpbsud ymm1, ymm2, ymm3
    vpdpbsuds xmm1, xmm2, xmm3
    vpdpbsuds ymm1, ymm2, ymm3
    vpdpbuud xmm1, xmm2, xmm3
    vpdpbuud ymm1, ymm2, ymm3
    vpdpbuuds xmm1, xmm2, xmm3
    vpdpbuuds ymm1, ymm2, ymm3
    vpdpbusd xmm1, xmm2, xmm3
    vpdpbusd ymm1, ymm2, ymm3
    vpdpbusd xmm1{k1}{z}, xmm2, xmm3
    vpdpbusd ymm1{k1}{z}, ymm2, ymm3
    vpdpbusd zmm1{k1}{z}, zmm2, zmm3
    vpdpbusds xmm1, xmm2, xmm3
    vpdpbusds ymm1, ymm2, ymm3
    vpdpbusds xmm1{k1}{z}, xmm2, xmm3
    vpdpbusds ymm1{k1}{z}, ymm2, ymm3
    vpdpbusds zmm1{k1}{z}, zmm2, zmm3
    vpdpwssd xmm1, xmm2, xmm3
    vpdpwssd ymm1, ymm2, ymm3
    vpdpwssd xmm1{k1}{z}, xmm2, xmm3
    vpdpwssd ymm1{k1}{z}, ymm2, ymm3
    vpdpwssd zmm1{k1}{z}, zmm2, zmm3
    vpdpwssds xmm1, xmm2, xmm3
    vpdpwssds ymm1, ymm2, ymm3
    vpdpwssds xmm1{k1}{z}, xmm2, xmm3
    vpdpwssds ymm1{k1}{z}, ymm2, ymm3
    vpdpwssds zmm1{k1}{z}, zmm2, zmm3
    vpdpwsud xmm1, xmm2, xmm3
    vpdpwsud ymm1, ymm2, ymm3
    vpdpwsuds xmm1, xmm2, xmm3
    vpdpwsuds ymm1, ymm2, ymm3
    vpdpwusd xmm1, xmm2, xmm3
    vpdpwusd ymm1, ymm2, ymm3
    vpdpwusds xmm1, xmm2, xmm3
    vpdpwusds ymm1, ymm2, ymm3
    vpdpwuud xmm1, xmm2, xmm3
    vpdpwuud ymm1, ymm2, ymm3
    vpdpwuuds xmm1, xmm2, xmm3
    vpdpwuuds ymm1, ymm2, ymm3
    vperm2f128 ymm1, ymm2, ymm3, 0x1
    vperm2i128 ymm1, ymm2, ymm3, 0x1
    vpermb xmm1{k1}{z}, xmm2, xmm3
    vpermb ymm1{k1}{z}, ymm2, ymm3
    vpermb zmm1{k1}{z}, zmm2, zmm3
    vpermd ymm1, ymm2, ymm3
    vpermd ymm1{k1}{z}, ymm2, ymm3
    vpermd zmm1{k1}{z}, zmm2, zmm3
    vpermw xmm1{k1}{z}, xmm2, xmm3
    vpermw ymm1{k1}{z}, ymm2, ymm3
    vpermw zmm1{k1}{z}, zmm2, zmm3
    vpermi2b xmm1{k1}{z}, xmm2, xmm3
    vpermi2b ymm1{k1}{z}, ymm2, ymm3
    vpermi2b zmm1{k1}{z}, zmm2, zmm3
    vpermi2w xmm1{k1}{z}, xmm2, xmm3
    vpermi2w ymm1{k1}{z}, ymm2, ymm3
    vpermi2w zmm1{k1}{z}, zmm2, zmm3
    vpermi2d xmm1{k1}{z}, xmm2, xmm3
    vpermi2d ymm1{k1}{z}, ymm2, ymm3
    vpermi2d zmm1{k1}{z}, zmm2, zmm3
    vpermi2q xmm1{k1}{z}, xmm2, xmm3
    vpermi2q ymm1{k1}{z}, ymm2, ymm3
    vpermi2q zmm1{k1}{z}, zmm2, zmm3
    vpermi2ps xmm1{k1}{z}, xmm2, xmm3
    vpermi2ps ymm1{k1}{z}, ymm2, ymm3
    vpermi2ps zmm1{k1}{z}, zmm2, zmm3
    vpermi2pd xmm1{k1}{z}, xmm2, xmm3
    vpermi2pd ymm1{k1}{z}, ymm2, ymm3
    vpermi2pd zmm1{k1}{z}, zmm2, zmm3
    vpermilpd xmm1, xmm2, xmm3
    vpermilpd ymm1, ymm2, ymm3
    vpermilpd xmm1{k1}{z}, xmm2, xmm3
    vpermilpd ymm1{k1}{z}, ymm2, ymm3
    vpermilpd zmm1{k1}{z}, zmm2, zmm3
    vpermilpd xmm1, xmm2, 0x1
    vpermilpd ymm1, ymm2, 0x1
    vpermilpd xmm1{k1}{z}, xmm2, 0x1
    vpermilpd ymm1{k1}{z}, ymm2, 0x1
    vpermilpd zmm1{k1}{z}, zmm2, 0x1
    vpermilps xmm1, xmm2, xmm3
    vpermilps xmm1, xmm2, 0x1
    vpermilps ymm1, ymm2, ymm3
    vpermilps ymm1, ymm2, 0x1
    vpermilps xmm1{k1}{z}, xmm2, xmm3
    vpermilps ymm1{k1}{z}, ymm2, ymm3
    vpermilps zmm1{k1}{z}, zmm2, zmm3
    vpermilps xmm1{k1}{z}, xmm2, 0x1
    vpermilps ymm1{k1}{z}, ymm2, 0x1
    vpermpd ymm1, ymm2, 0x1
    vpermpd ymm1{k1}{z}, ymm2, 0x1
    vpermpd zmm1{k1}{z}, zmm2, 0x1
    vpermpd ymm1{k1}{z}, ymm2, ymm3
    vpermpd zmm1{k1}{z}, zmm2, zmm3
    vpermps ymm1, ymm2, ymm3
    vpermps ymm1{k1}{z}, ymm2, ymm3
    vpermps zmm1{k1}{z}, zmm2, zmm3
    vpermq ymm1, ymm2, 0x1
    vpermq ymm1{k1}{z}, ymm2, 0x1
    vpermq zmm1{k1}{z}, zmm2, 0x1
    vpermq ymm1{k1}{z}, ymm2, ymm3
    vpermq zmm1{k1}{z}, zmm2, zmm3
    vpermt2b xmm1{k1}{z}, xmm2, xmm3
    vpermt2b ymm1{k1}{z}, ymm2, ymm3
    vpermt2b zmm1{k1}{z}, zmm2, zmm3
    vpermt2w xmm1{k1}{z}, xmm2, xmm3
    vpermt2w ymm1{k1}{z}, ymm2, ymm3
    vpermt2w zmm1{k1}{z}, zmm2, zmm3
    vpermt2d xmm1{k1}{z}, xmm2, xmm3
    vpermt2d ymm1{k1}{z}, ymm2, ymm3
    vpermt2d zmm1{k1}{z}, zmm2, zmm3
    vpermt2q xmm1{k1}{z}, xmm2, xmm3
    vpermt2q ymm1{k1}{z}, ymm2, ymm3
    vpermt2q zmm1{k1}{z}, zmm2, zmm3
    vpermt2ps xmm1{k1}{z}, xmm2, xmm3
    vpermt2ps ymm1{k1}{z}, ymm2, ymm3
    vpermt2ps zmm1{k1}{z}, zmm2, zmm3
    vpermt2pd xmm1{k1}{z}, xmm2, xmm3
    vpermt2pd ymm1{k1}{z}, ymm2, ymm3
    vpermt2pd zmm1{k1}{z}, zmm2, zmm3
    vpexpandb xmm1{k1}{z}, [rax]
    vpexpandb xmm1{k1}{z}, xmm2
    vpexpandb ymm1{k1}{z}, [rax]
    vpexpandb ymm1{k1}{z}, ymm2
    vpexpandb zmm1{k1}{z}, [rax]
    vpexpandb zmm1{k1}{z}, zmm2
    vpexpandw xmm1{k1}{z}, [rax]
    vpexpandw xmm1{k1}{z}, xmm2
    vpexpandw ymm1{k1}{z}, [rax]
    vpexpandw ymm1{k1}{z}, ymm2
    vpexpandw zmm1{k1}{z}, [rax]
    vpexpandw zmm1{k1}{z}, zmm2
    vpexpandd xmm1{k1}{z}, xmm2
    vpexpandd ymm1{k1}{z}, ymm2
    vpexpandd zmm1{k1}{z}, zmm2
    vpexpandq xmm1{k1}{z}, xmm2
    vpexpandq ymm1{k1}{z}, ymm2
    vpexpandq zmm1{k1}{z}, zmm2
    vpgatherdd xmm1{k1}, [rax+xmm14*1]
    vpgatherdd ymm1{k1}, [rax+ymm14*1]
    vpgatherdd zmm1{k1}, [rax+zmm14*1]
    vpgatherdq xmm1{k1}, [rax+xmm14*1]
    vpgatherdq ymm1{k1}, [rax+xmm14*1]
    vpgatherdq zmm1{k1}, [rax+ymm14*1]
    vpgatherdd xmm1, [rax+xmm14*1], xmm2
    vpgatherqd xmm1, [rax+xmm14*1], xmm2
    vpgatherdd ymm1, [rax+ymm14*1], ymm2
    vpgatherqd xmm1, [rax+ymm14*1], xmm2
    vpgatherdq xmm1, [rax+xmm14*1], xmm2
    vpgatherqq xmm1, [rax+xmm14*1], xmm2
    vpgatherdq ymm1, [rax+xmm14*1], ymm2
    vpgatherqq ymm1, [rax+ymm14*1], ymm2
    vpgatherqd xmm1{k1}, [rax+xmm14*1]
    vpgatherqd xmm1{k1}, [rax+ymm14*1]
    vpgatherqd ymm1{k1}, [rax+zmm14*1]
    vpgatherqq xmm1{k1}, [rax+xmm14*1]
    vpgatherqq ymm1{k1}, [rax+ymm14*1]
    vpgatherqq zmm1{k1}, [rax+zmm14*1]
    vplzcntd xmm1{k1}{z}, xmm2
    vplzcntd ymm1{k1}{z}, ymm2
    vplzcntd zmm1{k1}{z}, zmm2
    vplzcntq xmm1{k1}{z}, xmm2
    vplzcntq ymm1{k1}{z}, ymm2
    vplzcntq zmm1{k1}{z}, zmm2
    vpmadd52huq xmm1, xmm2, xmm3
    vpmadd52huq ymm1, ymm2, ymm3
    vpmadd52huq xmm1{k1}{z}, xmm2, xmm3
    vpmadd52huq ymm1{k1}{z}, ymm2, ymm3
    vpmadd52huq zmm1{k1}{z}, zmm2, zmm3
    vpmadd52luq xmm1, xmm2, xmm3
    vpmadd52luq ymm1, ymm2, ymm3
    vpmadd52luq xmm1{k1}{z}, xmm2, xmm3
    vpmadd52luq ymm1{k1}{z}, ymm2, ymm3
    vpmadd52luq zmm1{k1}{z}, zmm2, zmm3
    vpmaskmovd xmm1, xmm2, [rax]
    vpmaskmovd ymm1, ymm2, [rax]
    vpmaskmovq xmm1, xmm2, [rax]
    vpmaskmovq ymm1, ymm2, [rax]
    vpmaskmovd [rax], xmm1, xmm2
    vpmaskmovd [rax], ymm1, ymm2
    vpmaskmovq [rax], xmm1, xmm2
    vpmaskmovq [rax], ymm1, ymm2
    vpmovb2m k1, xmm1
    vpmovb2m k1, ymm1
    vpmovb2m k1, zmm1
    vpmovw2m k1, xmm1
    vpmovw2m k1, ymm1
    vpmovw2m k1, zmm1
    vpmovd2m k1, xmm1
    vpmovd2m k1, ymm1
    vpmovd2m k1, zmm1
    vpmovq2m k1, xmm1
    vpmovq2m k1, ymm1
    vpmovq2m k1, zmm1
    vpmovdb xmm1{k1}{z}, xmm2
    vpmovsdb xmm1{k1}{z}, xmm2
    vpmovusdb xmm1{k1}{z}, xmm2
    vpmovdb xmm1{k1}{z}, ymm2
    vpmovsdb xmm1{k1}{z}, ymm2
    vpmovusdb xmm1{k1}{z}, ymm2
    vpmovdb xmm1{k1}{z}, zmm2
    vpmovsdb xmm1{k1}{z}, zmm2
    vpmovusdb xmm1{k1}{z}, zmm2
    vpmovdw xmm1{k1}{z}, xmm2
    vpmovsdw xmm1{k1}{z}, xmm2
    vpmovusdw xmm1{k1}{z}, xmm2
    vpmovdw xmm1{k1}{z}, ymm2
    vpmovsdw xmm1{k1}{z}, ymm2
    vpmovusdw xmm1{k1}{z}, ymm2
    vpmovdw ymm1{k1}{z}, zmm2
    vpmovsdw ymm1{k1}{z}, zmm2
    vpmovusdw ymm1{k1}{z}, zmm2
    vpmovm2b xmm1, k1
    vpmovm2b ymm1, k1
    vpmovm2b zmm1, k1
    vpmovm2w xmm1, k1
    vpmovm2w ymm1, k1
    vpmovm2w zmm1, k1
    vpmovm2d xmm1, k1
    vpmovm2d ymm1, k1
    vpmovm2d zmm1, k1
    vpmovm2q xmm1, k1
    vpmovm2q ymm1, k1
    vpmovm2q zmm1, k1
    vpmovqb xmm1{k1}{z}, xmm2
    vpmovsqb xmm1{k1}{z}, xmm2
    vpmovusqb xmm1{k1}{z}, xmm2
    vpmovqb xmm1{k1}{z}, ymm2
    vpmovsqb xmm1{k1}{z}, ymm2
    vpmovusqb xmm1{k1}{z}, ymm2
    vpmovqb xmm1{k1}{z}, zmm2
    vpmovsqb xmm1{k1}{z}, zmm2
    vpmovusqb xmm1{k1}{z}, zmm2
    vpmovqd xmm1{k1}{z}, xmm2
    vpmovsqd xmm1{k1}{z}, xmm2
    vpmovusqd xmm1{k1}{z}, xmm2
    vpmovqd xmm1{k1}{z}, ymm2
    vpmovsqd xmm1{k1}{z}, ymm2
    vpmovusqd xmm1{k1}{z}, ymm2
    vpmovqd ymm1{k1}{z}, zmm2
    vpmovsqd ymm1{k1}{z}, zmm2
    vpmovusqd ymm1{k1}{z}, zmm2
    vpmovqw xmm1{k1}{z}, xmm2
    vpmovsqw xmm1{k1}{z}, xmm2
    vpmovusqw xmm1{k1}{z}, xmm2
    vpmovqw xmm1{k1}{z}, ymm2
    vpmovsqw xmm1{k1}{z}, ymm2
    vpmovusqw xmm1{k1}{z}, ymm2
    vpmovqw xmm1{k1}{z}, zmm2
    vpmovsqw xmm1{k1}{z}, zmm2
    vpmovusqw xmm1{k1}{z}, zmm2
    vpmovwb xmm1{k1}{z}, xmm2
    vpmovswb xmm1{k1}{z}, xmm2
    vpmovuswb xmm1{k1}{z}, xmm2
    vpmovwb xmm1{k1}{z}, ymm2
    vpmovswb xmm1{k1}{z}, ymm2
    vpmovuswb xmm1{k1}{z}, ymm2
    vpmovwb ymm1{k1}{z}, zmm2
    vpmovswb ymm1{k1}{z}, zmm2
    vpmovuswb ymm1{k1}{z}, zmm2
    vpmultishiftqb xmm1{k1}{z}, xmm2, xmm3
    vpmultishiftqb ymm1{k1}{z}, ymm2, ymm3
    vpmultishiftqb zmm1{k1}{z}, zmm2, zmm3
    vpopcntb xmm1{k1}{z}, xmm2
    vpopcntb ymm1{k1}{z}, ymm2
    vpopcntb zmm1{k1}{z}, zmm2
    vpopcntw xmm1{k1}{z}, xmm2
    vpopcntw ymm1{k1}{z}, ymm2
    vpopcntw zmm1{k1}{z}, zmm2
    vpopcntd xmm1{k1}{z}, xmm2
    vpopcntd ymm1{k1}{z}, ymm2
    vpopcntd zmm1{k1}{z}, zmm2
    vpopcntq xmm1{k1}{z}, xmm2
    vpopcntq ymm1{k1}{z}, ymm2
    vpopcntq zmm1{k1}{z}, zmm2
    vprolvd xmm1{k1}{z}, xmm2, xmm3
    vprold xmm1{k1}{z}, xmm2, 0x1
    vprolvq xmm1{k1}{z}, xmm2, xmm3
    vprolq xmm1{k1}{z}, xmm2, 0x1
    vprolvd ymm1{k1}{z}, ymm2, ymm3
    vprold ymm1{k1}{z}, ymm2, 0x1
    vprolvq ymm1{k1}{z}, ymm2, ymm3
    vprolq ymm1{k1}{z}, ymm2, 0x1
    vprolvd zmm1{k1}{z}, zmm2, zmm3
    vprold zmm1{k1}{z}, zmm2, 0x1
    vprolvq zmm1{k1}{z}, zmm2, zmm3
    vprolq zmm1{k1}{z}, zmm2, 0x1
    vprorvd xmm1{k1}{z}, xmm2, xmm3
    vprord xmm1{k1}{z}, xmm2, 0x1
    vprorvq xmm1{k1}{z}, xmm2, xmm3
    vprorq xmm1{k1}{z}, xmm2, 0x1
    vprorvd ymm1{k1}{z}, ymm2, ymm3
    vprord ymm1{k1}{z}, ymm2, 0x1
    vprorvq ymm1{k1}{z}, ymm2, ymm3
    vprorq ymm1{k1}{z}, ymm2, 0x1
    vprorvd zmm1{k1}{z}, zmm2, zmm3
    vprord zmm1{k1}{z}, zmm2, 0x1
    vprorvq zmm1{k1}{z}, zmm2, zmm3
    vprorq zmm1{k1}{z}, zmm2, 0x1
    vpscatterdd [rax+xmm14*1]{k1}, xmm1
    vpscatterdd [rax+ymm14*1]{k1}, ymm1
    vpscatterdd [rax+zmm14*1]{k1}, zmm1
    vpscatterdq [rax+xmm14*1]{k1}, xmm1
    vpscatterdq [rax+xmm14*1]{k1}, ymm1
    vpscatterdq [rax+ymm14*1]{k1}, zmm1
    vpscatterqd [rax+xmm14*1]{k1}, xmm1
    vpscatterqd [rax+ymm14*1]{k1}, xmm1
    vpscatterqd [rax+zmm14*1]{k1}, ymm1
    vpscatterqq [rax+xmm14*1]{k1}, xmm1
    vpscatterqq [rax+ymm14*1]{k1}, ymm1
    vpscatterqq [rax+zmm14*1]{k1}, zmm1
    vpshldw xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpshldw ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpshldw zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpshldd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpshldd ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpshldd zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpshldq xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpshldq ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpshldq zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpshldvw xmm1{k1}{z}, xmm2, xmm3
    vpshldvw ymm1{k1}{z}, ymm2, ymm3
    vpshldvw zmm1{k1}{z}, zmm2, zmm3
    vpshldvd xmm1{k1}{z}, xmm2, xmm3
    vpshldvd ymm1{k1}{z}, ymm2, ymm3
    vpshldvd zmm1{k1}{z}, zmm2, zmm3
    vpshldvq xmm1{k1}{z}, xmm2, xmm3
    vpshldvq ymm1{k1}{z}, ymm2, ymm3
    vpshldvq zmm1{k1}{z}, zmm2, zmm3
    vpshrdw xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpshrdw ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpshrdw zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpshrdd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpshrdd ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpshrdd zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpshrdq xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpshrdq ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpshrdq zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpshrdvw xmm1{k1}{z}, xmm2, xmm3
    vpshrdvw ymm1{k1}{z}, ymm2, ymm3
    vpshrdvw zmm1{k1}{z}, zmm2, zmm3
    vpshrdvd xmm1{k1}{z}, xmm2, xmm3
    vpshrdvd ymm1{k1}{z}, ymm2, ymm3
    vpshrdvd zmm1{k1}{z}, zmm2, zmm3
    vpshrdvq xmm1{k1}{z}, xmm2, xmm3
    vpshrdvq ymm1{k1}{z}, ymm2, ymm3
    vpshrdvq zmm1{k1}{z}, zmm2, zmm3
    vpshufbitqmb k1{k2}, xmm2, xmm3
    vpshufbitqmb k1{k2}, ymm2, ymm3
    vpshufbitqmb k1{k2}, zmm2, zmm3
    vpsllvd xmm1, xmm2, xmm3
    vpsllvq xmm1, xmm2, xmm3
    vpsllvd ymm1, ymm2, ymm3
    vpsllvq ymm1, ymm2, ymm3
    vpsllvw xmm1{k1}{z}, xmm2, xmm3
    vpsllvw ymm1{k1}{z}, ymm2, ymm3
    vpsllvw zmm1{k1}{z}, zmm2, zmm3
    vpsllvd xmm1{k1}{z}, xmm2, xmm3
    vpsllvd ymm1{k1}{z}, ymm2, ymm3
    vpsllvd zmm1{k1}{z}, zmm2, zmm3
    vpsllvq xmm1{k1}{z}, xmm2, xmm3
    vpsllvq ymm1{k1}{z}, ymm2, ymm3
    vpsllvq zmm1{k1}{z}, zmm2, zmm3
    vpsravd xmm1, xmm2, xmm3
    vpsravd ymm1, ymm2, ymm3
    vpsravw xmm1{k1}{z}, xmm2, xmm3
    vpsravw ymm1{k1}{z}, ymm2, ymm3
    vpsravw zmm1{k1}{z}, zmm2, zmm3
    vpsravd xmm1{k1}{z}, xmm2, xmm3
    vpsravd ymm1{k1}{z}, ymm2, ymm3
    vpsravd zmm1{k1}{z}, zmm2, zmm3
    vpsravq xmm1{k1}{z}, xmm2, xmm3
    vpsravq ymm1{k1}{z}, ymm2, ymm3
    vpsravq zmm1{k1}{z}, zmm2, zmm3
    vpsrlvd xmm1, xmm2, xmm3
    vpsrlvq xmm1, xmm2, xmm3
    vpsrlvd ymm1, ymm2, ymm3
    vpsrlvq ymm1, ymm2, ymm3
    vpsrlvw xmm1{k1}{z}, xmm2, xmm3
    vpsrlvw ymm1{k1}{z}, ymm2, ymm3
    vpsrlvw zmm1{k1}{z}, zmm2, zmm3
    vpsrlvd xmm1{k1}{z}, xmm2, xmm3
    vpsrlvd ymm1{k1}{z}, ymm2, ymm3
    vpsrlvd zmm1{k1}{z}, zmm2, zmm3
    vpsrlvq xmm1{k1}{z}, xmm2, xmm3
    vpsrlvq ymm1{k1}{z}, ymm2, ymm3
    vpsrlvq zmm1{k1}{z}, zmm2, zmm3
    vpternlogd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpternlogd ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpternlogd zmm1{k1}{z}, zmm2, zmm3, 0x1
    vpternlogq xmm1{k1}{z}, xmm2, xmm3, 0x1
    vpternlogq ymm1{k1}{z}, ymm2, ymm3, 0x1
    vpternlogq zmm1{k1}{z}, zmm2, zmm3, 0x1
    vptestmb k2{k1}, xmm2, xmm3
    vptestmb k2{k1}, ymm2, ymm3
    vptestmb k2{k1}, zmm2, zmm3
    vptestmw k2{k1}, xmm2, xmm3
    vptestmw k2{k1}, ymm2, ymm3
    vptestmw k2{k1}, zmm2, zmm3
    vptestmd k2{k1}, xmm2, xmm3
    vptestmd k2{k1}, ymm2, ymm3
    vptestmd k2{k1}, zmm2, zmm3
    vptestmq k2{k1}, xmm2, xmm3
    vptestmq k2{k1}, ymm2, ymm3
    vptestmq k2{k1}, zmm2, zmm3
    vptestnmb k2{k1}, xmm2, xmm3
    vptestnmb k2{k1}, ymm2, ymm3
    vptestnmb k2{k1}, zmm2, zmm3
    vptestnmw k2{k1}, xmm2, xmm3
    vptestnmw k2{k1}, ymm2, ymm3
    vptestnmw k2{k1}, zmm2, zmm3
    vptestnmd k2{k1}, xmm2, xmm3
    vptestnmd k2{k1}, ymm2, ymm3
    vptestnmd k2{k1}, zmm2, zmm3
    vptestnmq k2{k1}, xmm2, xmm3
    vptestnmq k2{k1}, ymm2, ymm3
    vptestnmq k2{k1}, zmm2, zmm3
    vrangepd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrangepd ymm1{k1}{z}, ymm2, ymm3, 0x1
    vrangepd zmm1{k1}{z}, zmm2, zmm3, 0x1
    vrangeps xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrangeps ymm1{k1}{z}, ymm2, ymm3, 0x1
    vrangeps zmm1{k1}{z}, zmm2, zmm3, 0x1
    vrangesd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrangess xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrcp14pd xmm1{k1}{z}, xmm2
    vrcp14pd ymm1{k1}{z}, ymm2
    vrcp14pd zmm1{k1}{z}, zmm2
    vrcp14ps xmm1{k1}{z}, xmm2
    vrcp14ps ymm1{k1}{z}, ymm2
    vrcp14ps zmm1{k1}{z}, zmm2
    vrcp14sd xmm1{k1}{z}, xmm2, xmm3
    vrcp14ss xmm1{k1}{z}, xmm2, xmm3
    vrcpph xmm1{k1}{z}, xmm2
    vrcpph ymm1{k1}{z}, ymm2
    vrcpph zmm1{k1}{z}, zmm2
    vrcpsh xmm1{k1}{z}, xmm2, xmm3
    vreducepd xmm1{k1}{z}, xmm2, 0x1
    vreducepd ymm1{k1}{z}, ymm2, 0x1
    vreducepd zmm1{k1}{z}, zmm2, 0x1
    vreduceph xmm1{k1}{z}, xmm2, 0x1
    vreduceph ymm1{k1}{z}, ymm2, 0x1
    vreduceph zmm1{k1}{z}, zmm2, 0x1
    vreduceps xmm1{k1}{z}, xmm2, 0x1
    vreduceps ymm1{k1}{z}, ymm2, 0x1
    vreduceps zmm1{k1}{z}, zmm2, 0x1
    vreducesh xmm1{k1}{z}, xmm2, xmm3, 0x1
    vreducess xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrndscalepd xmm1{k1}{z}, xmm2, 0x1
    vrndscalepd ymm1{k1}{z}, ymm2, 0x1
    vrndscalepd zmm1{k1}{z}, zmm2, 0x1
    vrndscaleph xmm1{k1}{z}, xmm2, 0x1
    vrndscaleph ymm1{k1}{z}, ymm2, 0x1
    vrndscaleph zmm1{k1}{z}, zmm2, 0x1
    vrndscaleps xmm1{k1}{z}, xmm2, 0x1
    vrndscaleps ymm1{k1}{z}, ymm2, 0x1
    vrndscaleps zmm1{k1}{z}, zmm2, 0x1
    vrndscalesd xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrndscalesh xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrndscaless xmm1{k1}{z}, xmm2, xmm3, 0x1
    vrsqrt14pd xmm1{k1}{z}, xmm2
    vrsqrt14pd ymm1{k1}{z}, ymm2
    vrsqrt14pd zmm1{k1}{z}, zmm2
    vrsqrt14ps xmm1{k1}{z}, xmm2
    vrsqrt14ps ymm1{k1}{z}, ymm2
    vrsqrt14ps zmm1{k1}{z}, zmm2
    vrsqrt14sd xmm1{k1}{z}, xmm2, xmm3
    vrsqrt14ss xmm1{k1}{z}, xmm2, xmm3
    vrsqrtph xmm1{k1}{z}, xmm2
    vrsqrtph ymm1{k1}{z}, ymm2
    vrsqrtph zmm1{k1}{z}, zmm2
    vrsqrtsh xmm1{k1}{z}, xmm2, xmm3
    vscalefpd xmm1{k1}{z}, xmm2, xmm3
    vscalefpd ymm1{k1}{z}, ymm2, ymm3
    vscalefpd zmm1{k1}{z}, zmm2, zmm3
    vscalefph xmm1{k1}{z}, xmm2, xmm3
    vscalefph ymm1{k1}{z}, ymm2, ymm3
    vscalefph zmm1{k1}{z}, zmm2, zmm3
    vscalefps xmm1{k1}{z}, xmm2, xmm3
    vscalefps ymm1{k1}{z}, ymm2, ymm3
    vscalefps zmm1{k1}{z}, zmm2, zmm3
    vscalefsd xmm1{k1}{z}, xmm2, xmm3
    vscalefsh xmm1{k1}{z}, xmm2, xmm3
    vscalefss xmm1{k1}{z}, xmm2, xmm3
    vscatterdps [rax+xmm14*1]{k1}, xmm1
    vscatterdps [rax+ymm14*1]{k1}, ymm1
    vscatterdps [rax+zmm14*1]{k1}, zmm1
    vscatterdpd [rax+xmm14*1]{k1}, xmm1
    vscatterdpd [rax+ymm14*1]{k1}, ymm1
    vscatterdpd [rax+zmm14*1]{k1}, zmm1
    vscatterqps [rax+xmm14*1]{k1}, xmm1
    vscatterqps [rax+ymm14*1]{k1}, xmm1
    vscatterqps [rax+zmm14*1]{k1}, ymm1
    vscatterqpd [rax+xmm14*1]{k1}, xmm1
    vscatterqpd [rax+ymm14*1]{k1}, ymm1
    vscatterqpd [rax+zmm14*1]{k1}, zmm1
    vsha512msg1 ymm1, xmm2
    vsha512msg2 ymm1, ymm2
    vsha512rnds2 ymm1, ymm2, xmm3
    vshuff32x4 ymm1{k1}{z}, ymm2, ymm3, 0x1
    vshuff32x4 zmm1{k1}{z}, zmm2, zmm3, 0x1
    vshuff64x2 ymm1{k1}{z}, ymm2, ymm3, 0x1
    vshuff64x2 zmm1{k1}{z}, zmm2, zmm3, 0x1
    vshufi32x4 ymm1{k1}{z}, ymm2, ymm3, 0x1
    vshufi32x4 zmm1{k1}{z}, zmm2, zmm3, 0x1
    vshufi64x2 ymm1{k1}{z}, ymm2, ymm3, 0x1
    vshufi64x2 zmm1{k1}{z}, zmm2, zmm3, 0x1
    vsm3msg1 xmm1, xmm2, xmm3
    vsm3msg2 xmm1, xmm2, xmm3
    vsm3rnds2 xmm1, xmm2, xmm3, 0x1
    vsm4key4 xmm1, xmm2, xmm3
    vsm4key4 ymm1, ymm2, ymm3
    vsm4rnds4 xmm1, xmm2, xmm3
    vsm4rnds4 ymm1, ymm2, ymm3
    vsqrtph xmm1{k1}{z}, xmm2
    vsqrtph ymm1{k1}{z}, ymm2
    vsqrtph zmm1{k1}{z}, zmm2
    vsqrtsh xmm1{k1}{z}, xmm2, xmm3
    vsubph xmm1{k1}{z}, xmm2, xmm3
    vsubph ymm1{k1}{z}, ymm2, ymm3
    vsubph zmm1{k1}{z}, zmm2, zmm3
    vsubsh xmm1{k1}{z}, xmm2, xmm3
    vtestps xmm1, xmm2
    vtestps ymm1, ymm2
    vtestpd xmm1, xmm2
    vtestpd ymm1, ymm2
    vucomish xmm1, xmm2
    vzeroall
    vzeroupper
    wait
    fwait
    wbinvd
    wbnoinvd
    wrfsbase eax
    wrfsbase rax
    wrgsbase eax
    wrgsbase rax
    wrmsr
    wrmsrlist
    wrmsrns
    wrpkru
    wrssd DWORD PTR [rax], eax
    wrssq QWORD PTR [rax], rax
    wrussd DWORD PTR [rax], eax
    wrussq QWORD PTR [rax], rax
    xabort 0x1
    xadd al, al
    xadd BYTE PTR [rax], al
    xadd ax, ax
    xadd WORD PTR [rax], ax
    xadd eax, eax
    xadd DWORD PTR [rax], eax
    xadd rax, rax
    xadd QWORD PTR [rax], rax
    xbegin 1f
    xbegin 1f
    xchg ax, ax
    xchg ax, ax
    xchg eax, eax
    xchg rax, rax
    xchg eax, eax
    xchg rax, rax
    xchg al, al
    xchg BYTE PTR [rax], al
    xchg al, al
    xchg al, BYTE PTR [rax]
    xchg ax, ax
    xchg WORD PTR [rax], ax
    xchg ax, ax
    xchg ax, WORD PTR [rax]
    xchg eax, eax
    xchg DWORD PTR [rax], eax
    xchg rax, rax
    xchg QWORD PTR [rax], rax
    xchg eax, eax
    xchg eax, DWORD PTR [rax]
    xchg rax, rax
    xchg rax, QWORD PTR [rax]
    xend
    xgetbv
    xlatb
    xlatb
    xlatb
    xor al, 0x1
    xor ax, 0x1
    xor eax, 0x1
    xor rax, 0x1
    xor al, 0x1
    xor BYTE PTR [rax], 0x1
    xor ax, 0x1
    xor WORD PTR [rax], 0x1
    xor eax, 0x1
    xor DWORD PTR [rax], 0x1
    xor rax, 0x1
    xor QWORD PTR [rax], 0x1
    xor ax, 0x1
    xor WORD PTR [rax], 0x1
    xor eax, 0x1
    xor DWORD PTR [rax], 0x1
    xor rax, 0x1
    xor QWORD PTR [rax], 0x1
    xor al, al
    xor BYTE PTR [rax], al
    xor ax, ax
    xor WORD PTR [rax], ax
    xor eax, eax
    xor DWORD PTR [rax], eax
    xor rax, rax
    xor QWORD PTR [rax], rax
    xor ax, ax
    xor ax, WORD PTR [rax]
    xor eax, eax
    xor eax, DWORD PTR [rax]
    xor rax, rax
    xor rax, QWORD PTR [rax]
    xorpd xmm1, xmm2
    vxorpd xmm1, xmm2, xmm3
    vxorpd ymm1, ymm2, ymm3
    vxorpd xmm1{k1}{z}, xmm2, xmm3
    vxorpd ymm1{k1}{z}, ymm2, ymm3
    vxorpd zmm1{k1}{z}, zmm2, zmm3
    xorps xmm1, xmm2
    vxorps xmm1, xmm2, xmm3
    vxorps ymm1, ymm2, ymm3
    vxorps xmm1{k1}{z}, xmm2, xmm3
    vxorps ymm1{k1}{z}, ymm2, ymm3
    vxorps zmm1{k1}{z}, zmm2, zmm3
    xresldtrk
    xrstor [rax]
    xrstor64 [rax]
    xrstors [rax]
    xrstors64 [rax]
    xsave [rax]
    xsave64 [rax]
    xsavec [rax]
    xsavec64 [rax]
    xsaveopt [rax]
    xsaveopt64 [rax]
    xsaves [rax]
    xsaves64 [rax]
    xsetbv
    xsusldtrk
    xtest
    getsec
    getsec
    getsec
    getsec
    getsec
    getsec
    getsec
    getsec
    prefetchwt1 BYTE PTR [rax]
    v4fmaddps zmm1{k1}{z}, zmm2, [rax]
    v4fnmaddps zmm1{k1}{z}, zmm2, [rax]
    v4fmaddss xmm1{k1}{z}, xmm2, [rax]
    v4fnmaddss xmm1{k1}{z}, xmm2, [rax]
    vexp2pd zmm1{k1}{z}, zmm2
    vexp2ps zmm1{k1}{z}, zmm2
    vgatherpf0dps [rax+zmm14*1]{k1}
    vgatherpf0qps [rax+zmm14*1]{k1}
    vgatherpf0dpd [rax+ymm14*1]{k1}
    vgatherpf0qpd [rax+zmm14*1]{k1}
    vgatherpf1dps [rax+zmm14*1]{k1}
    vgatherpf1qps [rax+zmm14*1]{k1}
    vgatherpf1dpd [rax+ymm14*1]{k1}
    vgatherpf1qpd [rax+zmm14*1]{k1}
    vp4dpwssds zmm1{k1}{z}, zmm2, [rax]
    vp4dpwssd zmm1{k1}{z}, zmm2, [rax]
    vrcp28pd zmm1{k1}{z}, zmm2
    vrcp28sd xmm1{k1}{z}, xmm2, xmm3
    vrcp28ps zmm1{k1}{z}, zmm2
    vrcp28ss xmm1{k1}{z}, xmm2, xmm3
    vrsqrt28pd zmm1{k1}{z}, zmm2
    vrsqrt28sd xmm1{k1}{z}, xmm2, xmm3
    vrsqrt28ps zmm1{k1}{z}, zmm2
    vrsqrt28ss xmm1{k1}{z}, xmm2, xmm3
    vscatterpf0dps [rax+zmm14*1]{k1}
    vscatterpf0qps [rax+zmm14*1]{k1}
    vscatterpf0dpd [rax+ymm14*1]{k1}
    vscatterpf0qpd [rax+zmm14*1]{k1}
    vscatterpf1dps [rax+zmm14*1]{k1}
    vscatterpf1qps [rax+zmm14*1]{k1}
    vscatterpf1dpd [rax+ymm14*1]{k1}
    vscatterpf1qpd [rax+zmm14*1]{k1}
1:
