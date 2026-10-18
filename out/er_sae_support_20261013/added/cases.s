# 생성: pipeline/m2_generate.py. 한 줄씩 따로 조립한다(판정: pipeline/m3_check.py)
.intel_syntax noprefix
.Ltarget:
.set .Ltarget32, .Ltarget + 4096
.set .Ltarget16, .Ltarget + 4096
vaddpd zmm0, zmm1, zmm2, {rn-sae}  # case=51-8 row=51 expected=reach
vaddpd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=51-9 row=51 expected=reach
vaddpd zmm0, zmm1, zmm2, {rd-sae}  # case=51-10 row=51 expected=reach
vaddpd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=51-11 row=51 expected=reach
vaddpd zmm0, zmm1, zmm2, {ru-sae}  # case=51-12 row=51 expected=reach
vaddpd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=51-13 row=51 expected=reach
vaddpd zmm0, zmm1, zmm2, {rz-sae}  # case=51-14 row=51 expected=reach
vaddpd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=51-15 row=51 expected=reach
vaddps zmm0, zmm1, zmm2, {rn-sae}  # case=57-8 row=57 expected=reach
vaddps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=57-9 row=57 expected=reach
vaddps zmm0, zmm1, zmm2, {rd-sae}  # case=57-10 row=57 expected=reach
vaddps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=57-11 row=57 expected=reach
vaddps zmm0, zmm1, zmm2, {ru-sae}  # case=57-12 row=57 expected=reach
vaddps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=57-13 row=57 expected=reach
vaddps zmm0, zmm1, zmm2, {rz-sae}  # case=57-14 row=57 expected=reach
vaddps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=57-15 row=57 expected=reach
vaddsd xmm0, xmm1, xmm2, {rn-sae}  # case=60-6 row=60 expected=reach
vaddsd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=60-7 row=60 expected=reach
vaddsd xmm0, xmm1, xmm2, {rd-sae}  # case=60-8 row=60 expected=reach
vaddsd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=60-9 row=60 expected=reach
vaddsd xmm0, xmm1, xmm2, {ru-sae}  # case=60-10 row=60 expected=reach
vaddsd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=60-11 row=60 expected=reach
vaddsd xmm0, xmm1, xmm2, {rz-sae}  # case=60-12 row=60 expected=reach
vaddsd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=60-13 row=60 expected=reach
vaddss xmm0, xmm1, xmm2, {rn-sae}  # case=63-6 row=63 expected=reach
vaddss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=63-7 row=63 expected=reach
vaddss xmm0, xmm1, xmm2, {rd-sae}  # case=63-8 row=63 expected=reach
vaddss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=63-9 row=63 expected=reach
vaddss xmm0, xmm1, xmm2, {ru-sae}  # case=63-10 row=63 expected=reach
vaddss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=63-11 row=63 expected=reach
vaddss xmm0, xmm1, xmm2, {rz-sae}  # case=63-12 row=63 expected=reach
vaddss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=63-13 row=63 expected=reach
vcmppd k0, zmm0, zmm1, {sae}, 0x12  # case=395-9 row=395 expected=reach
vcmppd k0 {k1}, zmm0, zmm1, {sae}, 0x12  # case=395-10 row=395 expected=reach
vcmpps k0, zmm0, zmm1, {sae}, 0x12  # case=401-9 row=401 expected=reach
vcmpps k0 {k1}, zmm0, zmm1, {sae}, 0x12  # case=401-10 row=401 expected=reach
vcmpsd k0, xmm0, xmm1, {sae}, 0x12  # case=412-7 row=412 expected=reach
vcmpsd k0 {k1}, xmm0, xmm1, {sae}, 0x12  # case=412-8 row=412 expected=reach
vcmpss k0, xmm0, xmm1, {sae}, 0x12  # case=415-7 row=415 expected=reach
vcmpss k0 {k1}, xmm0, xmm1, {sae}, 0x12  # case=415-8 row=415 expected=reach
vcomisd xmm0, xmm1, {sae}  # case=424-4 row=424 expected=reach
vcomiss xmm0, xmm1, {sae}  # case=427-4 row=427 expected=reach
vcvtdq2ps zmm0, zmm1, {rn-sae}  # case=445-8 row=445 expected=reach
vcvtdq2ps zmm0 {k1}{z}, zmm1, {rn-sae}  # case=445-9 row=445 expected=reach
vcvtdq2ps zmm0, zmm1, {rd-sae}  # case=445-10 row=445 expected=reach
vcvtdq2ps zmm0 {k1}{z}, zmm1, {rd-sae}  # case=445-11 row=445 expected=reach
vcvtdq2ps zmm0, zmm1, {ru-sae}  # case=445-12 row=445 expected=reach
vcvtdq2ps zmm0 {k1}{z}, zmm1, {ru-sae}  # case=445-13 row=445 expected=reach
vcvtdq2ps zmm0, zmm1, {rz-sae}  # case=445-14 row=445 expected=reach
vcvtdq2ps zmm0 {k1}{z}, zmm1, {rz-sae}  # case=445-15 row=445 expected=reach
vcvtpd2dq ymm0, zmm1, {rn-sae}  # case=451-8 row=451 expected=reach
vcvtpd2dq ymm0 {k1}{z}, zmm1, {rn-sae}  # case=451-9 row=451 expected=reach
vcvtpd2dq ymm0, zmm1, {rd-sae}  # case=451-10 row=451 expected=reach
vcvtpd2dq ymm0 {k1}{z}, zmm1, {rd-sae}  # case=451-11 row=451 expected=reach
vcvtpd2dq ymm0, zmm1, {ru-sae}  # case=451-12 row=451 expected=reach
vcvtpd2dq ymm0 {k1}{z}, zmm1, {ru-sae}  # case=451-13 row=451 expected=reach
vcvtpd2dq ymm0, zmm1, {rz-sae}  # case=451-14 row=451 expected=reach
vcvtpd2dq ymm0 {k1}{z}, zmm1, {rz-sae}  # case=451-15 row=451 expected=reach
vcvtpd2ps ymm0, zmm1, {rn-sae}  # case=458-8 row=458 expected=reach
vcvtpd2ps ymm0 {k1}{z}, zmm1, {rn-sae}  # case=458-9 row=458 expected=reach
vcvtpd2ps ymm0, zmm1, {rd-sae}  # case=458-10 row=458 expected=reach
vcvtpd2ps ymm0 {k1}{z}, zmm1, {rd-sae}  # case=458-11 row=458 expected=reach
vcvtpd2ps ymm0, zmm1, {ru-sae}  # case=458-12 row=458 expected=reach
vcvtpd2ps ymm0 {k1}{z}, zmm1, {ru-sae}  # case=458-13 row=458 expected=reach
vcvtpd2ps ymm0, zmm1, {rz-sae}  # case=458-14 row=458 expected=reach
vcvtpd2ps ymm0 {k1}{z}, zmm1, {rz-sae}  # case=458-15 row=458 expected=reach
vcvtps2dq zmm0, zmm1, {rn-sae}  # case=466-8 row=466 expected=reach
vcvtps2dq zmm0 {k1}{z}, zmm1, {rn-sae}  # case=466-9 row=466 expected=reach
vcvtps2dq zmm0, zmm1, {rd-sae}  # case=466-10 row=466 expected=reach
vcvtps2dq zmm0 {k1}{z}, zmm1, {rd-sae}  # case=466-11 row=466 expected=reach
vcvtps2dq zmm0, zmm1, {ru-sae}  # case=466-12 row=466 expected=reach
vcvtps2dq zmm0 {k1}{z}, zmm1, {ru-sae}  # case=466-13 row=466 expected=reach
vcvtps2dq zmm0, zmm1, {rz-sae}  # case=466-14 row=466 expected=reach
vcvtps2dq zmm0 {k1}{z}, zmm1, {rz-sae}  # case=466-15 row=466 expected=reach
vcvtps2pd zmm0, ymm1, {sae}  # case=472-8 row=472 expected=reach
vcvtps2pd zmm0 {k1}{z}, ymm1, {sae}  # case=472-9 row=472 expected=reach
vcvtsd2si ecx, xmm0, {rn-sae}  # case=478-4 row=478 expected=reach
vcvtsd2si ecx, xmm0, {rd-sae}  # case=478-5 row=478 expected=reach
vcvtsd2si ecx, xmm0, {ru-sae}  # case=478-6 row=478 expected=reach
vcvtsd2si ecx, xmm0, {rz-sae}  # case=478-7 row=478 expected=reach
vcvtsd2si rcx, xmm0, {rn-sae}  # case=479-4 row=479 expected=reach
vcvtsd2si rcx, xmm0, {rd-sae}  # case=479-5 row=479 expected=reach
vcvtsd2si rcx, xmm0, {ru-sae}  # case=479-6 row=479 expected=reach
vcvtsd2si rcx, xmm0, {rz-sae}  # case=479-7 row=479 expected=reach
vcvtsd2ss xmm0, xmm1, xmm2, {rn-sae}  # case=482-6 row=482 expected=reach
vcvtsd2ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=482-7 row=482 expected=reach
vcvtsd2ss xmm0, xmm1, xmm2, {rd-sae}  # case=482-8 row=482 expected=reach
vcvtsd2ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=482-9 row=482 expected=reach
vcvtsd2ss xmm0, xmm1, xmm2, {ru-sae}  # case=482-10 row=482 expected=reach
vcvtsd2ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=482-11 row=482 expected=reach
vcvtsd2ss xmm0, xmm1, xmm2, {rz-sae}  # case=482-12 row=482 expected=reach
vcvtsd2ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=482-13 row=482 expected=reach
vcvtsi2sd xmm0, xmm1, rcx, {rn-sae}  # case=488-4 row=488 expected=reach
vcvtsi2sd xmm0, xmm1, rcx, {rd-sae}  # case=488-5 row=488 expected=reach
vcvtsi2sd xmm0, xmm1, rcx, {ru-sae}  # case=488-6 row=488 expected=reach
vcvtsi2sd xmm0, xmm1, rcx, {rz-sae}  # case=488-7 row=488 expected=reach
vcvtsi2ss xmm0, xmm1, ecx, {rn-sae}  # case=493-4 row=493 expected=reach
vcvtsi2ss xmm0, xmm1, ecx, {rd-sae}  # case=493-5 row=493 expected=reach
vcvtsi2ss xmm0, xmm1, ecx, {ru-sae}  # case=493-6 row=493 expected=reach
vcvtsi2ss xmm0, xmm1, ecx, {rz-sae}  # case=493-7 row=493 expected=reach
vcvtsi2ss xmm0, xmm1, rcx, {rn-sae}  # case=494-4 row=494 expected=reach
vcvtsi2ss xmm0, xmm1, rcx, {rd-sae}  # case=494-5 row=494 expected=reach
vcvtsi2ss xmm0, xmm1, rcx, {ru-sae}  # case=494-6 row=494 expected=reach
vcvtsi2ss xmm0, xmm1, rcx, {rz-sae}  # case=494-7 row=494 expected=reach
vcvtss2sd xmm0, xmm1, xmm2, {sae}  # case=497-6 row=497 expected=reach
vcvtss2sd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=497-7 row=497 expected=reach
vcvtss2si ecx, xmm0, {rn-sae}  # case=502-4 row=502 expected=reach
vcvtss2si ecx, xmm0, {rd-sae}  # case=502-5 row=502 expected=reach
vcvtss2si ecx, xmm0, {ru-sae}  # case=502-6 row=502 expected=reach
vcvtss2si ecx, xmm0, {rz-sae}  # case=502-7 row=502 expected=reach
vcvtss2si rcx, xmm0, {rn-sae}  # case=503-4 row=503 expected=reach
vcvtss2si rcx, xmm0, {rd-sae}  # case=503-5 row=503 expected=reach
vcvtss2si rcx, xmm0, {ru-sae}  # case=503-6 row=503 expected=reach
vcvtss2si rcx, xmm0, {rz-sae}  # case=503-7 row=503 expected=reach
vcvttpd2dq ymm0, zmm1, {sae}  # case=509-8 row=509 expected=reach
vcvttpd2dq ymm0 {k1}{z}, zmm1, {sae}  # case=509-9 row=509 expected=reach
vcvttps2dq zmm0, zmm1, {sae}  # case=516-8 row=516 expected=reach
vcvttps2dq zmm0 {k1}{z}, zmm1, {sae}  # case=516-9 row=516 expected=reach
vcvttsd2si ecx, xmm0, {sae}  # case=522-4 row=522 expected=reach
vcvttsd2si rcx, xmm0, {sae}  # case=523-4 row=523 expected=reach
vcvttss2si ecx, xmm0, {sae}  # case=528-4 row=528 expected=reach
vcvttss2si rcx, xmm0, {sae}  # case=529-4 row=529 expected=reach
vdivpd zmm0, zmm1, zmm2, {rn-sae}  # case=550-8 row=550 expected=reach
vdivpd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=550-9 row=550 expected=reach
vdivpd zmm0, zmm1, zmm2, {rd-sae}  # case=550-10 row=550 expected=reach
vdivpd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=550-11 row=550 expected=reach
vdivpd zmm0, zmm1, zmm2, {ru-sae}  # case=550-12 row=550 expected=reach
vdivpd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=550-13 row=550 expected=reach
vdivpd zmm0, zmm1, zmm2, {rz-sae}  # case=550-14 row=550 expected=reach
vdivpd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=550-15 row=550 expected=reach
vdivps zmm0, zmm1, zmm2, {rn-sae}  # case=556-8 row=556 expected=reach
vdivps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=556-9 row=556 expected=reach
vdivps zmm0, zmm1, zmm2, {rd-sae}  # case=556-10 row=556 expected=reach
vdivps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=556-11 row=556 expected=reach
vdivps zmm0, zmm1, zmm2, {ru-sae}  # case=556-12 row=556 expected=reach
vdivps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=556-13 row=556 expected=reach
vdivps zmm0, zmm1, zmm2, {rz-sae}  # case=556-14 row=556 expected=reach
vdivps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=556-15 row=556 expected=reach
vdivsd xmm0, xmm1, xmm2, {rn-sae}  # case=559-6 row=559 expected=reach
vdivsd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=559-7 row=559 expected=reach
vdivsd xmm0, xmm1, xmm2, {rd-sae}  # case=559-8 row=559 expected=reach
vdivsd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=559-9 row=559 expected=reach
vdivsd xmm0, xmm1, xmm2, {ru-sae}  # case=559-10 row=559 expected=reach
vdivsd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=559-11 row=559 expected=reach
vdivsd xmm0, xmm1, xmm2, {rz-sae}  # case=559-12 row=559 expected=reach
vdivsd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=559-13 row=559 expected=reach
vdivss xmm0, xmm1, xmm2, {rn-sae}  # case=562-6 row=562 expected=reach
vdivss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=562-7 row=562 expected=reach
vdivss xmm0, xmm1, xmm2, {rd-sae}  # case=562-8 row=562 expected=reach
vdivss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=562-9 row=562 expected=reach
vdivss xmm0, xmm1, xmm2, {ru-sae}  # case=562-10 row=562 expected=reach
vdivss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=562-11 row=562 expected=reach
vdivss xmm0, xmm1, xmm2, {rz-sae}  # case=562-12 row=562 expected=reach
vdivss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=562-13 row=562 expected=reach
vmaxpd zmm0, zmm1, zmm2, {sae}  # case=1054-8 row=1054 expected=reach
vmaxpd zmm0 {k1}{z}, zmm1, zmm2, {sae}  # case=1054-9 row=1054 expected=reach
vmaxps zmm0, zmm1, zmm2, {sae}  # case=1060-8 row=1060 expected=reach
vmaxps zmm0 {k1}{z}, zmm1, zmm2, {sae}  # case=1060-9 row=1060 expected=reach
vmaxsd xmm0, xmm1, xmm2, {sae}  # case=1063-6 row=1063 expected=reach
vmaxsd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=1063-7 row=1063 expected=reach
vmaxss xmm0, xmm1, xmm2, {sae}  # case=1066-6 row=1066 expected=reach
vmaxss xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=1066-7 row=1066 expected=reach
vminpd zmm0, zmm1, zmm2, {sae}  # case=1073-8 row=1073 expected=reach
vminpd zmm0 {k1}{z}, zmm1, zmm2, {sae}  # case=1073-9 row=1073 expected=reach
vminps zmm0, zmm1, zmm2, {sae}  # case=1079-8 row=1079 expected=reach
vminps zmm0 {k1}{z}, zmm1, zmm2, {sae}  # case=1079-9 row=1079 expected=reach
vminsd xmm0, xmm1, xmm2, {sae}  # case=1082-6 row=1082 expected=reach
vminsd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=1082-7 row=1082 expected=reach
vminss xmm0, xmm1, xmm2, {sae}  # case=1085-6 row=1085 expected=reach
vminss xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=1085-7 row=1085 expected=reach
vmulpd zmm0, zmm1, zmm2, {rn-sae}  # case=1395-8 row=1395 expected=reach
vmulpd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=1395-9 row=1395 expected=reach
vmulpd zmm0, zmm1, zmm2, {rd-sae}  # case=1395-10 row=1395 expected=reach
vmulpd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=1395-11 row=1395 expected=reach
vmulpd zmm0, zmm1, zmm2, {ru-sae}  # case=1395-12 row=1395 expected=reach
vmulpd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=1395-13 row=1395 expected=reach
vmulpd zmm0, zmm1, zmm2, {rz-sae}  # case=1395-14 row=1395 expected=reach
vmulpd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=1395-15 row=1395 expected=reach
vmulps zmm0, zmm1, zmm2, {rn-sae}  # case=1401-8 row=1401 expected=reach
vmulps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=1401-9 row=1401 expected=reach
vmulps zmm0, zmm1, zmm2, {rd-sae}  # case=1401-10 row=1401 expected=reach
vmulps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=1401-11 row=1401 expected=reach
vmulps zmm0, zmm1, zmm2, {ru-sae}  # case=1401-12 row=1401 expected=reach
vmulps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=1401-13 row=1401 expected=reach
vmulps zmm0, zmm1, zmm2, {rz-sae}  # case=1401-14 row=1401 expected=reach
vmulps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=1401-15 row=1401 expected=reach
vmulsd xmm0, xmm1, xmm2, {rn-sae}  # case=1404-6 row=1404 expected=reach
vmulsd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=1404-7 row=1404 expected=reach
vmulsd xmm0, xmm1, xmm2, {rd-sae}  # case=1404-8 row=1404 expected=reach
vmulsd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=1404-9 row=1404 expected=reach
vmulsd xmm0, xmm1, xmm2, {ru-sae}  # case=1404-10 row=1404 expected=reach
vmulsd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=1404-11 row=1404 expected=reach
vmulsd xmm0, xmm1, xmm2, {rz-sae}  # case=1404-12 row=1404 expected=reach
vmulsd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=1404-13 row=1404 expected=reach
vmulss xmm0, xmm1, xmm2, {rn-sae}  # case=1407-6 row=1407 expected=reach
vmulss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=1407-7 row=1407 expected=reach
vmulss xmm0, xmm1, xmm2, {rd-sae}  # case=1407-8 row=1407 expected=reach
vmulss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=1407-9 row=1407 expected=reach
vmulss xmm0, xmm1, xmm2, {ru-sae}  # case=1407-10 row=1407 expected=reach
vmulss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=1407-11 row=1407 expected=reach
vmulss xmm0, xmm1, xmm2, {rz-sae}  # case=1407-12 row=1407 expected=reach
vmulss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=1407-13 row=1407 expected=reach
vsqrtpd zmm0, zmm1, {rn-sae}  # case=2628-8 row=2628 expected=reach
vsqrtpd zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2628-9 row=2628 expected=reach
vsqrtpd zmm0, zmm1, {rd-sae}  # case=2628-10 row=2628 expected=reach
vsqrtpd zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2628-11 row=2628 expected=reach
vsqrtpd zmm0, zmm1, {ru-sae}  # case=2628-12 row=2628 expected=reach
vsqrtpd zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2628-13 row=2628 expected=reach
vsqrtpd zmm0, zmm1, {rz-sae}  # case=2628-14 row=2628 expected=reach
vsqrtpd zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2628-15 row=2628 expected=reach
vsqrtps zmm0, zmm1, {rn-sae}  # case=2634-8 row=2634 expected=reach
vsqrtps zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2634-9 row=2634 expected=reach
vsqrtps zmm0, zmm1, {rd-sae}  # case=2634-10 row=2634 expected=reach
vsqrtps zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2634-11 row=2634 expected=reach
vsqrtps zmm0, zmm1, {ru-sae}  # case=2634-12 row=2634 expected=reach
vsqrtps zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2634-13 row=2634 expected=reach
vsqrtps zmm0, zmm1, {rz-sae}  # case=2634-14 row=2634 expected=reach
vsqrtps zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2634-15 row=2634 expected=reach
vsqrtsd xmm0, xmm1, xmm2, {rn-sae}  # case=2637-6 row=2637 expected=reach
vsqrtsd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2637-7 row=2637 expected=reach
vsqrtsd xmm0, xmm1, xmm2, {rd-sae}  # case=2637-8 row=2637 expected=reach
vsqrtsd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2637-9 row=2637 expected=reach
vsqrtsd xmm0, xmm1, xmm2, {ru-sae}  # case=2637-10 row=2637 expected=reach
vsqrtsd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2637-11 row=2637 expected=reach
vsqrtsd xmm0, xmm1, xmm2, {rz-sae}  # case=2637-12 row=2637 expected=reach
vsqrtsd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2637-13 row=2637 expected=reach
vsqrtss xmm0, xmm1, xmm2, {rn-sae}  # case=2640-6 row=2640 expected=reach
vsqrtss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2640-7 row=2640 expected=reach
vsqrtss xmm0, xmm1, xmm2, {rd-sae}  # case=2640-8 row=2640 expected=reach
vsqrtss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2640-9 row=2640 expected=reach
vsqrtss xmm0, xmm1, xmm2, {ru-sae}  # case=2640-10 row=2640 expected=reach
vsqrtss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2640-11 row=2640 expected=reach
vsqrtss xmm0, xmm1, xmm2, {rz-sae}  # case=2640-12 row=2640 expected=reach
vsqrtss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2640-13 row=2640 expected=reach
vsubpd zmm0, zmm1, zmm2, {rn-sae}  # case=2682-8 row=2682 expected=reach
vsubpd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=2682-9 row=2682 expected=reach
vsubpd zmm0, zmm1, zmm2, {rd-sae}  # case=2682-10 row=2682 expected=reach
vsubpd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=2682-11 row=2682 expected=reach
vsubpd zmm0, zmm1, zmm2, {ru-sae}  # case=2682-12 row=2682 expected=reach
vsubpd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=2682-13 row=2682 expected=reach
vsubpd zmm0, zmm1, zmm2, {rz-sae}  # case=2682-14 row=2682 expected=reach
vsubpd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=2682-15 row=2682 expected=reach
vsubps zmm0, zmm1, zmm2, {rn-sae}  # case=2688-8 row=2688 expected=reach
vsubps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=2688-9 row=2688 expected=reach
vsubps zmm0, zmm1, zmm2, {rd-sae}  # case=2688-10 row=2688 expected=reach
vsubps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=2688-11 row=2688 expected=reach
vsubps zmm0, zmm1, zmm2, {ru-sae}  # case=2688-12 row=2688 expected=reach
vsubps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=2688-13 row=2688 expected=reach
vsubps zmm0, zmm1, zmm2, {rz-sae}  # case=2688-14 row=2688 expected=reach
vsubps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=2688-15 row=2688 expected=reach
vsubsd xmm0, xmm1, xmm2, {rn-sae}  # case=2691-6 row=2691 expected=reach
vsubsd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2691-7 row=2691 expected=reach
vsubsd xmm0, xmm1, xmm2, {rd-sae}  # case=2691-8 row=2691 expected=reach
vsubsd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2691-9 row=2691 expected=reach
vsubsd xmm0, xmm1, xmm2, {ru-sae}  # case=2691-10 row=2691 expected=reach
vsubsd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2691-11 row=2691 expected=reach
vsubsd xmm0, xmm1, xmm2, {rz-sae}  # case=2691-12 row=2691 expected=reach
vsubsd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2691-13 row=2691 expected=reach
vsubss xmm0, xmm1, xmm2, {rn-sae}  # case=2694-6 row=2694 expected=reach
vsubss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2694-7 row=2694 expected=reach
vsubss xmm0, xmm1, xmm2, {rd-sae}  # case=2694-8 row=2694 expected=reach
vsubss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2694-9 row=2694 expected=reach
vsubss xmm0, xmm1, xmm2, {ru-sae}  # case=2694-10 row=2694 expected=reach
vsubss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2694-11 row=2694 expected=reach
vsubss xmm0, xmm1, xmm2, {rz-sae}  # case=2694-12 row=2694 expected=reach
vsubss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2694-13 row=2694 expected=reach
vucomisd xmm0, xmm1, {sae}  # case=2734-4 row=2734 expected=reach
vucomiss xmm0, xmm1, {sae}  # case=2737-4 row=2737 expected=reach
vaddph zmm0, zmm1, zmm2, {rn-sae}  # case=2775-8 row=2775 expected=reach
vaddph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=2775-9 row=2775 expected=reach
vaddph zmm0, zmm1, zmm2, {rd-sae}  # case=2775-10 row=2775 expected=reach
vaddph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=2775-11 row=2775 expected=reach
vaddph zmm0, zmm1, zmm2, {ru-sae}  # case=2775-12 row=2775 expected=reach
vaddph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=2775-13 row=2775 expected=reach
vaddph zmm0, zmm1, zmm2, {rz-sae}  # case=2775-14 row=2775 expected=reach
vaddph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=2775-15 row=2775 expected=reach
vaddsh xmm0, xmm1, xmm2, {rn-sae}  # case=2776-6 row=2776 expected=reach
vaddsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2776-7 row=2776 expected=reach
vaddsh xmm0, xmm1, xmm2, {rd-sae}  # case=2776-8 row=2776 expected=reach
vaddsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2776-9 row=2776 expected=reach
vaddsh xmm0, xmm1, xmm2, {ru-sae}  # case=2776-10 row=2776 expected=reach
vaddsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2776-11 row=2776 expected=reach
vaddsh xmm0, xmm1, xmm2, {rz-sae}  # case=2776-12 row=2776 expected=reach
vaddsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2776-13 row=2776 expected=reach
vcmpph k0, zmm0, zmm1, {sae}, 0x12  # case=2815-9 row=2815 expected=reach
vcmpph k0 {k1}, zmm0, zmm1, {sae}, 0x12  # case=2815-10 row=2815 expected=reach
vcmpsh k0, xmm0, xmm1, {sae}, 0x12  # case=2816-7 row=2816 expected=reach
vcmpsh k0 {k1}, xmm0, xmm1, {sae}, 0x12  # case=2816-8 row=2816 expected=reach
vcomish xmm0, xmm1, {sae}  # case=2817-4 row=2817 expected=reach
vcvtdq2ph ymm0, zmm1, {rn-sae}  # case=2826-8 row=2826 expected=reach
vcvtdq2ph ymm0 {k1}{z}, zmm1, {rn-sae}  # case=2826-9 row=2826 expected=reach
vcvtdq2ph ymm0, zmm1, {rd-sae}  # case=2826-10 row=2826 expected=reach
vcvtdq2ph ymm0 {k1}{z}, zmm1, {rd-sae}  # case=2826-11 row=2826 expected=reach
vcvtdq2ph ymm0, zmm1, {ru-sae}  # case=2826-12 row=2826 expected=reach
vcvtdq2ph ymm0 {k1}{z}, zmm1, {ru-sae}  # case=2826-13 row=2826 expected=reach
vcvtdq2ph ymm0, zmm1, {rz-sae}  # case=2826-14 row=2826 expected=reach
vcvtdq2ph ymm0 {k1}{z}, zmm1, {rz-sae}  # case=2826-15 row=2826 expected=reach
vcvtpd2ph xmm0, zmm1, {rn-sae}  # case=2845-8 row=2845 expected=reach
vcvtpd2ph xmm0 {k1}{z}, zmm1, {rn-sae}  # case=2845-9 row=2845 expected=reach
vcvtpd2ph xmm0, zmm1, {rd-sae}  # case=2845-10 row=2845 expected=reach
vcvtpd2ph xmm0 {k1}{z}, zmm1, {rd-sae}  # case=2845-11 row=2845 expected=reach
vcvtpd2ph xmm0, zmm1, {ru-sae}  # case=2845-12 row=2845 expected=reach
vcvtpd2ph xmm0 {k1}{z}, zmm1, {ru-sae}  # case=2845-13 row=2845 expected=reach
vcvtpd2ph xmm0, zmm1, {rz-sae}  # case=2845-14 row=2845 expected=reach
vcvtpd2ph xmm0 {k1}{z}, zmm1, {rz-sae}  # case=2845-15 row=2845 expected=reach
vcvtpd2qq zmm0, zmm1, {rn-sae}  # case=2848-8 row=2848 expected=reach
vcvtpd2qq zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2848-9 row=2848 expected=reach
vcvtpd2qq zmm0, zmm1, {rd-sae}  # case=2848-10 row=2848 expected=reach
vcvtpd2qq zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2848-11 row=2848 expected=reach
vcvtpd2qq zmm0, zmm1, {ru-sae}  # case=2848-12 row=2848 expected=reach
vcvtpd2qq zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2848-13 row=2848 expected=reach
vcvtpd2qq zmm0, zmm1, {rz-sae}  # case=2848-14 row=2848 expected=reach
vcvtpd2qq zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2848-15 row=2848 expected=reach
vcvtpd2udq ymm0, zmm1, {rn-sae}  # case=2851-8 row=2851 expected=reach
vcvtpd2udq ymm0 {k1}{z}, zmm1, {rn-sae}  # case=2851-9 row=2851 expected=reach
vcvtpd2udq ymm0, zmm1, {rd-sae}  # case=2851-10 row=2851 expected=reach
vcvtpd2udq ymm0 {k1}{z}, zmm1, {rd-sae}  # case=2851-11 row=2851 expected=reach
vcvtpd2udq ymm0, zmm1, {ru-sae}  # case=2851-12 row=2851 expected=reach
vcvtpd2udq ymm0 {k1}{z}, zmm1, {ru-sae}  # case=2851-13 row=2851 expected=reach
vcvtpd2udq ymm0, zmm1, {rz-sae}  # case=2851-14 row=2851 expected=reach
vcvtpd2udq ymm0 {k1}{z}, zmm1, {rz-sae}  # case=2851-15 row=2851 expected=reach
vcvtpd2uqq zmm0, zmm1, {rn-sae}  # case=2854-8 row=2854 expected=reach
vcvtpd2uqq zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2854-9 row=2854 expected=reach
vcvtpd2uqq zmm0, zmm1, {rd-sae}  # case=2854-10 row=2854 expected=reach
vcvtpd2uqq zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2854-11 row=2854 expected=reach
vcvtpd2uqq zmm0, zmm1, {ru-sae}  # case=2854-12 row=2854 expected=reach
vcvtpd2uqq zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2854-13 row=2854 expected=reach
vcvtpd2uqq zmm0, zmm1, {rz-sae}  # case=2854-14 row=2854 expected=reach
vcvtpd2uqq zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2854-15 row=2854 expected=reach
vcvtph2dq zmm0, ymm1, {rn-sae}  # case=2857-8 row=2857 expected=reach
vcvtph2dq zmm0 {k1}{z}, ymm1, {rn-sae}  # case=2857-9 row=2857 expected=reach
vcvtph2dq zmm0, ymm1, {rd-sae}  # case=2857-10 row=2857 expected=reach
vcvtph2dq zmm0 {k1}{z}, ymm1, {rd-sae}  # case=2857-11 row=2857 expected=reach
vcvtph2dq zmm0, ymm1, {ru-sae}  # case=2857-12 row=2857 expected=reach
vcvtph2dq zmm0 {k1}{z}, ymm1, {ru-sae}  # case=2857-13 row=2857 expected=reach
vcvtph2dq zmm0, ymm1, {rz-sae}  # case=2857-14 row=2857 expected=reach
vcvtph2dq zmm0 {k1}{z}, ymm1, {rz-sae}  # case=2857-15 row=2857 expected=reach
vcvtph2pd zmm0, xmm1, {sae}  # case=2860-8 row=2860 expected=reach
vcvtph2pd zmm0 {k1}{z}, xmm1, {sae}  # case=2860-9 row=2860 expected=reach
vcvtph2ps zmm0, ymm1, {sae}  # case=2865-6 row=2865 expected=reach
vcvtph2ps zmm0 {k1}{z}, ymm1, {sae}  # case=2865-7 row=2865 expected=reach
vcvtph2psx zmm0, ymm1, {sae}  # case=2868-8 row=2868 expected=reach
vcvtph2psx zmm0 {k1}{z}, ymm1, {sae}  # case=2868-9 row=2868 expected=reach
vcvtph2qq zmm0, xmm1, {rn-sae}  # case=2871-8 row=2871 expected=reach
vcvtph2qq zmm0 {k1}{z}, xmm1, {rn-sae}  # case=2871-9 row=2871 expected=reach
vcvtph2qq zmm0, xmm1, {rd-sae}  # case=2871-10 row=2871 expected=reach
vcvtph2qq zmm0 {k1}{z}, xmm1, {rd-sae}  # case=2871-11 row=2871 expected=reach
vcvtph2qq zmm0, xmm1, {ru-sae}  # case=2871-12 row=2871 expected=reach
vcvtph2qq zmm0 {k1}{z}, xmm1, {ru-sae}  # case=2871-13 row=2871 expected=reach
vcvtph2qq zmm0, xmm1, {rz-sae}  # case=2871-14 row=2871 expected=reach
vcvtph2qq zmm0 {k1}{z}, xmm1, {rz-sae}  # case=2871-15 row=2871 expected=reach
vcvtph2udq zmm0, ymm1, {rn-sae}  # case=2874-8 row=2874 expected=reach
vcvtph2udq zmm0 {k1}{z}, ymm1, {rn-sae}  # case=2874-9 row=2874 expected=reach
vcvtph2udq zmm0, ymm1, {rd-sae}  # case=2874-10 row=2874 expected=reach
vcvtph2udq zmm0 {k1}{z}, ymm1, {rd-sae}  # case=2874-11 row=2874 expected=reach
vcvtph2udq zmm0, ymm1, {ru-sae}  # case=2874-12 row=2874 expected=reach
vcvtph2udq zmm0 {k1}{z}, ymm1, {ru-sae}  # case=2874-13 row=2874 expected=reach
vcvtph2udq zmm0, ymm1, {rz-sae}  # case=2874-14 row=2874 expected=reach
vcvtph2udq zmm0 {k1}{z}, ymm1, {rz-sae}  # case=2874-15 row=2874 expected=reach
vcvtph2uqq zmm0, xmm1, {rn-sae}  # case=2877-8 row=2877 expected=reach
vcvtph2uqq zmm0 {k1}{z}, xmm1, {rn-sae}  # case=2877-9 row=2877 expected=reach
vcvtph2uqq zmm0, xmm1, {rd-sae}  # case=2877-10 row=2877 expected=reach
vcvtph2uqq zmm0 {k1}{z}, xmm1, {rd-sae}  # case=2877-11 row=2877 expected=reach
vcvtph2uqq zmm0, xmm1, {ru-sae}  # case=2877-12 row=2877 expected=reach
vcvtph2uqq zmm0 {k1}{z}, xmm1, {ru-sae}  # case=2877-13 row=2877 expected=reach
vcvtph2uqq zmm0, xmm1, {rz-sae}  # case=2877-14 row=2877 expected=reach
vcvtph2uqq zmm0 {k1}{z}, xmm1, {rz-sae}  # case=2877-15 row=2877 expected=reach
vcvtph2uw zmm0, zmm1, {rn-sae}  # case=2880-8 row=2880 expected=reach
vcvtph2uw zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2880-9 row=2880 expected=reach
vcvtph2uw zmm0, zmm1, {rd-sae}  # case=2880-10 row=2880 expected=reach
vcvtph2uw zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2880-11 row=2880 expected=reach
vcvtph2uw zmm0, zmm1, {ru-sae}  # case=2880-12 row=2880 expected=reach
vcvtph2uw zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2880-13 row=2880 expected=reach
vcvtph2uw zmm0, zmm1, {rz-sae}  # case=2880-14 row=2880 expected=reach
vcvtph2uw zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2880-15 row=2880 expected=reach
vcvtph2w zmm0, zmm1, {rn-sae}  # case=2883-8 row=2883 expected=reach
vcvtph2w zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2883-9 row=2883 expected=reach
vcvtph2w zmm0, zmm1, {rd-sae}  # case=2883-10 row=2883 expected=reach
vcvtph2w zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2883-11 row=2883 expected=reach
vcvtph2w zmm0, zmm1, {ru-sae}  # case=2883-12 row=2883 expected=reach
vcvtph2w zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2883-13 row=2883 expected=reach
vcvtph2w zmm0, zmm1, {rz-sae}  # case=2883-14 row=2883 expected=reach
vcvtph2w zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2883-15 row=2883 expected=reach
vcvtps2ph ymm0, zmm1, {sae}, 0x12  # case=2888-7 row=2888 expected=reach
vcvtps2ph ymm0 {k1}{z}, zmm1, {sae}, 0x12  # case=2888-8 row=2888 expected=reach
vcvtps2phx ymm0, zmm1, {rn-sae}  # case=2891-8 row=2891 expected=reach
vcvtps2phx ymm0 {k1}{z}, zmm1, {rn-sae}  # case=2891-9 row=2891 expected=reach
vcvtps2phx ymm0, zmm1, {rd-sae}  # case=2891-10 row=2891 expected=reach
vcvtps2phx ymm0 {k1}{z}, zmm1, {rd-sae}  # case=2891-11 row=2891 expected=reach
vcvtps2phx ymm0, zmm1, {ru-sae}  # case=2891-12 row=2891 expected=reach
vcvtps2phx ymm0 {k1}{z}, zmm1, {ru-sae}  # case=2891-13 row=2891 expected=reach
vcvtps2phx ymm0, zmm1, {rz-sae}  # case=2891-14 row=2891 expected=reach
vcvtps2phx ymm0 {k1}{z}, zmm1, {rz-sae}  # case=2891-15 row=2891 expected=reach
vcvtps2qq zmm0, ymm1, {rn-sae}  # case=2894-8 row=2894 expected=reach
vcvtps2qq zmm0 {k1}{z}, ymm1, {rn-sae}  # case=2894-9 row=2894 expected=reach
vcvtps2qq zmm0, ymm1, {rd-sae}  # case=2894-10 row=2894 expected=reach
vcvtps2qq zmm0 {k1}{z}, ymm1, {rd-sae}  # case=2894-11 row=2894 expected=reach
vcvtps2qq zmm0, ymm1, {ru-sae}  # case=2894-12 row=2894 expected=reach
vcvtps2qq zmm0 {k1}{z}, ymm1, {ru-sae}  # case=2894-13 row=2894 expected=reach
vcvtps2qq zmm0, ymm1, {rz-sae}  # case=2894-14 row=2894 expected=reach
vcvtps2qq zmm0 {k1}{z}, ymm1, {rz-sae}  # case=2894-15 row=2894 expected=reach
vcvtps2udq zmm0, zmm1, {rn-sae}  # case=2897-8 row=2897 expected=reach
vcvtps2udq zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2897-9 row=2897 expected=reach
vcvtps2udq zmm0, zmm1, {rd-sae}  # case=2897-10 row=2897 expected=reach
vcvtps2udq zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2897-11 row=2897 expected=reach
vcvtps2udq zmm0, zmm1, {ru-sae}  # case=2897-12 row=2897 expected=reach
vcvtps2udq zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2897-13 row=2897 expected=reach
vcvtps2udq zmm0, zmm1, {rz-sae}  # case=2897-14 row=2897 expected=reach
vcvtps2udq zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2897-15 row=2897 expected=reach
vcvtps2uqq zmm0, ymm1, {rn-sae}  # case=2900-8 row=2900 expected=reach
vcvtps2uqq zmm0 {k1}{z}, ymm1, {rn-sae}  # case=2900-9 row=2900 expected=reach
vcvtps2uqq zmm0, ymm1, {rd-sae}  # case=2900-10 row=2900 expected=reach
vcvtps2uqq zmm0 {k1}{z}, ymm1, {rd-sae}  # case=2900-11 row=2900 expected=reach
vcvtps2uqq zmm0, ymm1, {ru-sae}  # case=2900-12 row=2900 expected=reach
vcvtps2uqq zmm0 {k1}{z}, ymm1, {ru-sae}  # case=2900-13 row=2900 expected=reach
vcvtps2uqq zmm0, ymm1, {rz-sae}  # case=2900-14 row=2900 expected=reach
vcvtps2uqq zmm0 {k1}{z}, ymm1, {rz-sae}  # case=2900-15 row=2900 expected=reach
vcvtqq2pd zmm0, zmm1, {rn-sae}  # case=2903-8 row=2903 expected=reach
vcvtqq2pd zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2903-9 row=2903 expected=reach
vcvtqq2pd zmm0, zmm1, {rd-sae}  # case=2903-10 row=2903 expected=reach
vcvtqq2pd zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2903-11 row=2903 expected=reach
vcvtqq2pd zmm0, zmm1, {ru-sae}  # case=2903-12 row=2903 expected=reach
vcvtqq2pd zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2903-13 row=2903 expected=reach
vcvtqq2pd zmm0, zmm1, {rz-sae}  # case=2903-14 row=2903 expected=reach
vcvtqq2pd zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2903-15 row=2903 expected=reach
vcvtqq2ph xmm0, zmm1, {rn-sae}  # case=2906-8 row=2906 expected=reach
vcvtqq2ph xmm0 {k1}{z}, zmm1, {rn-sae}  # case=2906-9 row=2906 expected=reach
vcvtqq2ph xmm0, zmm1, {rd-sae}  # case=2906-10 row=2906 expected=reach
vcvtqq2ph xmm0 {k1}{z}, zmm1, {rd-sae}  # case=2906-11 row=2906 expected=reach
vcvtqq2ph xmm0, zmm1, {ru-sae}  # case=2906-12 row=2906 expected=reach
vcvtqq2ph xmm0 {k1}{z}, zmm1, {ru-sae}  # case=2906-13 row=2906 expected=reach
vcvtqq2ph xmm0, zmm1, {rz-sae}  # case=2906-14 row=2906 expected=reach
vcvtqq2ph xmm0 {k1}{z}, zmm1, {rz-sae}  # case=2906-15 row=2906 expected=reach
vcvtqq2ps ymm0, zmm1, {rn-sae}  # case=2909-8 row=2909 expected=reach
vcvtqq2ps ymm0 {k1}{z}, zmm1, {rn-sae}  # case=2909-9 row=2909 expected=reach
vcvtqq2ps ymm0, zmm1, {rd-sae}  # case=2909-10 row=2909 expected=reach
vcvtqq2ps ymm0 {k1}{z}, zmm1, {rd-sae}  # case=2909-11 row=2909 expected=reach
vcvtqq2ps ymm0, zmm1, {ru-sae}  # case=2909-12 row=2909 expected=reach
vcvtqq2ps ymm0 {k1}{z}, zmm1, {ru-sae}  # case=2909-13 row=2909 expected=reach
vcvtqq2ps ymm0, zmm1, {rz-sae}  # case=2909-14 row=2909 expected=reach
vcvtqq2ps ymm0 {k1}{z}, zmm1, {rz-sae}  # case=2909-15 row=2909 expected=reach
vcvtsd2sh xmm0, xmm1, xmm2, {rn-sae}  # case=2910-6 row=2910 expected=reach
vcvtsd2sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2910-7 row=2910 expected=reach
vcvtsd2sh xmm0, xmm1, xmm2, {rd-sae}  # case=2910-8 row=2910 expected=reach
vcvtsd2sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2910-9 row=2910 expected=reach
vcvtsd2sh xmm0, xmm1, xmm2, {ru-sae}  # case=2910-10 row=2910 expected=reach
vcvtsd2sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2910-11 row=2910 expected=reach
vcvtsd2sh xmm0, xmm1, xmm2, {rz-sae}  # case=2910-12 row=2910 expected=reach
vcvtsd2sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2910-13 row=2910 expected=reach
vcvtsd2usi ecx, xmm0, {rn-sae}  # case=2911-4 row=2911 expected=reach
vcvtsd2usi ecx, xmm0, {rd-sae}  # case=2911-5 row=2911 expected=reach
vcvtsd2usi ecx, xmm0, {ru-sae}  # case=2911-6 row=2911 expected=reach
vcvtsd2usi ecx, xmm0, {rz-sae}  # case=2911-7 row=2911 expected=reach
vcvtsd2usi rcx, xmm0, {rn-sae}  # case=2912-4 row=2912 expected=reach
vcvtsd2usi rcx, xmm0, {rd-sae}  # case=2912-5 row=2912 expected=reach
vcvtsd2usi rcx, xmm0, {ru-sae}  # case=2912-6 row=2912 expected=reach
vcvtsd2usi rcx, xmm0, {rz-sae}  # case=2912-7 row=2912 expected=reach
vcvtsh2sd xmm0, xmm1, xmm2, {sae}  # case=2913-6 row=2913 expected=reach
vcvtsh2sd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=2913-7 row=2913 expected=reach
vcvtsh2si ecx, xmm0, {rn-sae}  # case=2914-4 row=2914 expected=reach
vcvtsh2si ecx, xmm0, {rd-sae}  # case=2914-5 row=2914 expected=reach
vcvtsh2si ecx, xmm0, {ru-sae}  # case=2914-6 row=2914 expected=reach
vcvtsh2si ecx, xmm0, {rz-sae}  # case=2914-7 row=2914 expected=reach
vcvtsh2si rcx, xmm0, {rn-sae}  # case=2915-4 row=2915 expected=reach
vcvtsh2si rcx, xmm0, {rd-sae}  # case=2915-5 row=2915 expected=reach
vcvtsh2si rcx, xmm0, {ru-sae}  # case=2915-6 row=2915 expected=reach
vcvtsh2si rcx, xmm0, {rz-sae}  # case=2915-7 row=2915 expected=reach
vcvtsh2ss xmm0, xmm1, xmm2, {sae}  # case=2916-6 row=2916 expected=reach
vcvtsh2ss xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=2916-7 row=2916 expected=reach
vcvtsh2usi ecx, xmm0, {rn-sae}  # case=2917-4 row=2917 expected=reach
vcvtsh2usi ecx, xmm0, {rd-sae}  # case=2917-5 row=2917 expected=reach
vcvtsh2usi ecx, xmm0, {ru-sae}  # case=2917-6 row=2917 expected=reach
vcvtsh2usi ecx, xmm0, {rz-sae}  # case=2917-7 row=2917 expected=reach
vcvtsh2usi rcx, xmm0, {rn-sae}  # case=2918-4 row=2918 expected=reach
vcvtsh2usi rcx, xmm0, {rd-sae}  # case=2918-5 row=2918 expected=reach
vcvtsh2usi rcx, xmm0, {ru-sae}  # case=2918-6 row=2918 expected=reach
vcvtsh2usi rcx, xmm0, {rz-sae}  # case=2918-7 row=2918 expected=reach
vcvtsi2sh xmm0, xmm1, ecx, {rn-sae}  # case=2919-4 row=2919 expected=reach
vcvtsi2sh xmm0, xmm1, ecx, {rd-sae}  # case=2919-5 row=2919 expected=reach
vcvtsi2sh xmm0, xmm1, ecx, {ru-sae}  # case=2919-6 row=2919 expected=reach
vcvtsi2sh xmm0, xmm1, ecx, {rz-sae}  # case=2919-7 row=2919 expected=reach
vcvtsi2sh xmm0, xmm1, rcx, {rn-sae}  # case=2920-4 row=2920 expected=reach
vcvtsi2sh xmm0, xmm1, rcx, {rd-sae}  # case=2920-5 row=2920 expected=reach
vcvtsi2sh xmm0, xmm1, rcx, {ru-sae}  # case=2920-6 row=2920 expected=reach
vcvtsi2sh xmm0, xmm1, rcx, {rz-sae}  # case=2920-7 row=2920 expected=reach
vcvtss2sh xmm0, xmm1, xmm2, {rn-sae}  # case=2921-6 row=2921 expected=reach
vcvtss2sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=2921-7 row=2921 expected=reach
vcvtss2sh xmm0, xmm1, xmm2, {rd-sae}  # case=2921-8 row=2921 expected=reach
vcvtss2sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=2921-9 row=2921 expected=reach
vcvtss2sh xmm0, xmm1, xmm2, {ru-sae}  # case=2921-10 row=2921 expected=reach
vcvtss2sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=2921-11 row=2921 expected=reach
vcvtss2sh xmm0, xmm1, xmm2, {rz-sae}  # case=2921-12 row=2921 expected=reach
vcvtss2sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=2921-13 row=2921 expected=reach
vcvtss2usi ecx, xmm0, {rn-sae}  # case=2922-4 row=2922 expected=reach
vcvtss2usi ecx, xmm0, {rd-sae}  # case=2922-5 row=2922 expected=reach
vcvtss2usi ecx, xmm0, {ru-sae}  # case=2922-6 row=2922 expected=reach
vcvtss2usi ecx, xmm0, {rz-sae}  # case=2922-7 row=2922 expected=reach
vcvtss2usi rcx, xmm0, {rn-sae}  # case=2923-4 row=2923 expected=reach
vcvtss2usi rcx, xmm0, {rd-sae}  # case=2923-5 row=2923 expected=reach
vcvtss2usi rcx, xmm0, {ru-sae}  # case=2923-6 row=2923 expected=reach
vcvtss2usi rcx, xmm0, {rz-sae}  # case=2923-7 row=2923 expected=reach
vcvttpd2qq zmm0, zmm1, {sae}  # case=2926-8 row=2926 expected=reach
vcvttpd2qq zmm0 {k1}{z}, zmm1, {sae}  # case=2926-9 row=2926 expected=reach
vcvttpd2udq ymm0, zmm1, {sae}  # case=2929-8 row=2929 expected=reach
vcvttpd2udq ymm0 {k1}{z}, zmm1, {sae}  # case=2929-9 row=2929 expected=reach
vcvttpd2uqq zmm0, zmm1, {sae}  # case=2932-8 row=2932 expected=reach
vcvttpd2uqq zmm0 {k1}{z}, zmm1, {sae}  # case=2932-9 row=2932 expected=reach
vcvttph2dq zmm0, ymm1, {sae}  # case=2935-8 row=2935 expected=reach
vcvttph2dq zmm0 {k1}{z}, ymm1, {sae}  # case=2935-9 row=2935 expected=reach
vcvttph2qq zmm0, xmm1, {sae}  # case=2938-8 row=2938 expected=reach
vcvttph2qq zmm0 {k1}{z}, xmm1, {sae}  # case=2938-9 row=2938 expected=reach
vcvttph2udq zmm0, ymm1, {sae}  # case=2941-8 row=2941 expected=reach
vcvttph2udq zmm0 {k1}{z}, ymm1, {sae}  # case=2941-9 row=2941 expected=reach
vcvttph2uqq zmm0, xmm1, {sae}  # case=2944-8 row=2944 expected=reach
vcvttph2uqq zmm0 {k1}{z}, xmm1, {sae}  # case=2944-9 row=2944 expected=reach
vcvttph2uw zmm0, zmm1, {sae}  # case=2947-8 row=2947 expected=reach
vcvttph2uw zmm0 {k1}{z}, zmm1, {sae}  # case=2947-9 row=2947 expected=reach
vcvttph2w zmm0, zmm1, {sae}  # case=2950-8 row=2950 expected=reach
vcvttph2w zmm0 {k1}{z}, zmm1, {sae}  # case=2950-9 row=2950 expected=reach
vcvttps2qq zmm0, ymm1, {sae}  # case=2953-8 row=2953 expected=reach
vcvttps2qq zmm0 {k1}{z}, ymm1, {sae}  # case=2953-9 row=2953 expected=reach
vcvttps2udq zmm0, zmm1, {sae}  # case=2956-8 row=2956 expected=reach
vcvttps2udq zmm0 {k1}{z}, zmm1, {sae}  # case=2956-9 row=2956 expected=reach
vcvttps2uqq zmm0, ymm1, {sae}  # case=2959-8 row=2959 expected=reach
vcvttps2uqq zmm0 {k1}{z}, ymm1, {sae}  # case=2959-9 row=2959 expected=reach
vcvttsd2usi ecx, xmm0, {sae}  # case=2960-4 row=2960 expected=reach
vcvttsd2usi rcx, xmm0, {sae}  # case=2961-4 row=2961 expected=reach
vcvttsh2si ecx, xmm0, {sae}  # case=2962-4 row=2962 expected=reach
vcvttsh2si rcx, xmm0, {sae}  # case=2963-4 row=2963 expected=reach
vcvttsh2usi ecx, xmm0, {sae}  # case=2964-4 row=2964 expected=reach
vcvttsh2usi rcx, xmm0, {sae}  # case=2965-4 row=2965 expected=reach
vcvttss2usi ecx, xmm0, {sae}  # case=2966-4 row=2966 expected=reach
vcvttss2usi rcx, xmm0, {sae}  # case=2967-4 row=2967 expected=reach
vcvtudq2ph ymm0, zmm1, {rn-sae}  # case=2973-8 row=2973 expected=reach
vcvtudq2ph ymm0 {k1}{z}, zmm1, {rn-sae}  # case=2973-9 row=2973 expected=reach
vcvtudq2ph ymm0, zmm1, {rd-sae}  # case=2973-10 row=2973 expected=reach
vcvtudq2ph ymm0 {k1}{z}, zmm1, {rd-sae}  # case=2973-11 row=2973 expected=reach
vcvtudq2ph ymm0, zmm1, {ru-sae}  # case=2973-12 row=2973 expected=reach
vcvtudq2ph ymm0 {k1}{z}, zmm1, {ru-sae}  # case=2973-13 row=2973 expected=reach
vcvtudq2ph ymm0, zmm1, {rz-sae}  # case=2973-14 row=2973 expected=reach
vcvtudq2ph ymm0 {k1}{z}, zmm1, {rz-sae}  # case=2973-15 row=2973 expected=reach
vcvtudq2ps zmm0, zmm1, {rn-sae}  # case=2976-8 row=2976 expected=reach
vcvtudq2ps zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2976-9 row=2976 expected=reach
vcvtudq2ps zmm0, zmm1, {rd-sae}  # case=2976-10 row=2976 expected=reach
vcvtudq2ps zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2976-11 row=2976 expected=reach
vcvtudq2ps zmm0, zmm1, {ru-sae}  # case=2976-12 row=2976 expected=reach
vcvtudq2ps zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2976-13 row=2976 expected=reach
vcvtudq2ps zmm0, zmm1, {rz-sae}  # case=2976-14 row=2976 expected=reach
vcvtudq2ps zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2976-15 row=2976 expected=reach
vcvtuqq2pd zmm0, zmm1, {rn-sae}  # case=2979-8 row=2979 expected=reach
vcvtuqq2pd zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2979-9 row=2979 expected=reach
vcvtuqq2pd zmm0, zmm1, {rd-sae}  # case=2979-10 row=2979 expected=reach
vcvtuqq2pd zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2979-11 row=2979 expected=reach
vcvtuqq2pd zmm0, zmm1, {ru-sae}  # case=2979-12 row=2979 expected=reach
vcvtuqq2pd zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2979-13 row=2979 expected=reach
vcvtuqq2pd zmm0, zmm1, {rz-sae}  # case=2979-14 row=2979 expected=reach
vcvtuqq2pd zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2979-15 row=2979 expected=reach
vcvtuqq2ph xmm0, zmm1, {rn-sae}  # case=2982-8 row=2982 expected=reach
vcvtuqq2ph xmm0 {k1}{z}, zmm1, {rn-sae}  # case=2982-9 row=2982 expected=reach
vcvtuqq2ph xmm0, zmm1, {rd-sae}  # case=2982-10 row=2982 expected=reach
vcvtuqq2ph xmm0 {k1}{z}, zmm1, {rd-sae}  # case=2982-11 row=2982 expected=reach
vcvtuqq2ph xmm0, zmm1, {ru-sae}  # case=2982-12 row=2982 expected=reach
vcvtuqq2ph xmm0 {k1}{z}, zmm1, {ru-sae}  # case=2982-13 row=2982 expected=reach
vcvtuqq2ph xmm0, zmm1, {rz-sae}  # case=2982-14 row=2982 expected=reach
vcvtuqq2ph xmm0 {k1}{z}, zmm1, {rz-sae}  # case=2982-15 row=2982 expected=reach
vcvtuqq2ps ymm0, zmm1, {rn-sae}  # case=2985-8 row=2985 expected=reach
vcvtuqq2ps ymm0 {k1}{z}, zmm1, {rn-sae}  # case=2985-9 row=2985 expected=reach
vcvtuqq2ps ymm0, zmm1, {rd-sae}  # case=2985-10 row=2985 expected=reach
vcvtuqq2ps ymm0 {k1}{z}, zmm1, {rd-sae}  # case=2985-11 row=2985 expected=reach
vcvtuqq2ps ymm0, zmm1, {ru-sae}  # case=2985-12 row=2985 expected=reach
vcvtuqq2ps ymm0 {k1}{z}, zmm1, {ru-sae}  # case=2985-13 row=2985 expected=reach
vcvtuqq2ps ymm0, zmm1, {rz-sae}  # case=2985-14 row=2985 expected=reach
vcvtuqq2ps ymm0 {k1}{z}, zmm1, {rz-sae}  # case=2985-15 row=2985 expected=reach
vcvtusi2sd xmm0, xmm1, rcx, {rn-sae}  # case=2987-4 row=2987 expected=reach
vcvtusi2sd xmm0, xmm1, rcx, {rd-sae}  # case=2987-5 row=2987 expected=reach
vcvtusi2sd xmm0, xmm1, rcx, {ru-sae}  # case=2987-6 row=2987 expected=reach
vcvtusi2sd xmm0, xmm1, rcx, {rz-sae}  # case=2987-7 row=2987 expected=reach
vcvtusi2sh xmm0, xmm1, ecx, {rn-sae}  # case=2988-4 row=2988 expected=reach
vcvtusi2sh xmm0, xmm1, ecx, {rd-sae}  # case=2988-5 row=2988 expected=reach
vcvtusi2sh xmm0, xmm1, ecx, {ru-sae}  # case=2988-6 row=2988 expected=reach
vcvtusi2sh xmm0, xmm1, ecx, {rz-sae}  # case=2988-7 row=2988 expected=reach
vcvtusi2sh xmm0, xmm1, rcx, {rn-sae}  # case=2989-4 row=2989 expected=reach
vcvtusi2sh xmm0, xmm1, rcx, {rd-sae}  # case=2989-5 row=2989 expected=reach
vcvtusi2sh xmm0, xmm1, rcx, {ru-sae}  # case=2989-6 row=2989 expected=reach
vcvtusi2sh xmm0, xmm1, rcx, {rz-sae}  # case=2989-7 row=2989 expected=reach
vcvtusi2ss xmm0, xmm1, ecx, {rn-sae}  # case=2990-4 row=2990 expected=reach
vcvtusi2ss xmm0, xmm1, ecx, {rd-sae}  # case=2990-5 row=2990 expected=reach
vcvtusi2ss xmm0, xmm1, ecx, {ru-sae}  # case=2990-6 row=2990 expected=reach
vcvtusi2ss xmm0, xmm1, ecx, {rz-sae}  # case=2990-7 row=2990 expected=reach
vcvtusi2ss xmm0, xmm1, rcx, {rn-sae}  # case=2991-4 row=2991 expected=reach
vcvtusi2ss xmm0, xmm1, rcx, {rd-sae}  # case=2991-5 row=2991 expected=reach
vcvtusi2ss xmm0, xmm1, rcx, {ru-sae}  # case=2991-6 row=2991 expected=reach
vcvtusi2ss xmm0, xmm1, rcx, {rz-sae}  # case=2991-7 row=2991 expected=reach
vcvtuw2ph zmm0, zmm1, {rn-sae}  # case=2994-8 row=2994 expected=reach
vcvtuw2ph zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2994-9 row=2994 expected=reach
vcvtuw2ph zmm0, zmm1, {rd-sae}  # case=2994-10 row=2994 expected=reach
vcvtuw2ph zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2994-11 row=2994 expected=reach
vcvtuw2ph zmm0, zmm1, {ru-sae}  # case=2994-12 row=2994 expected=reach
vcvtuw2ph zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2994-13 row=2994 expected=reach
vcvtuw2ph zmm0, zmm1, {rz-sae}  # case=2994-14 row=2994 expected=reach
vcvtuw2ph zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2994-15 row=2994 expected=reach
vcvtw2ph zmm0, zmm1, {rn-sae}  # case=2997-8 row=2997 expected=reach
vcvtw2ph zmm0 {k1}{z}, zmm1, {rn-sae}  # case=2997-9 row=2997 expected=reach
vcvtw2ph zmm0, zmm1, {rd-sae}  # case=2997-10 row=2997 expected=reach
vcvtw2ph zmm0 {k1}{z}, zmm1, {rd-sae}  # case=2997-11 row=2997 expected=reach
vcvtw2ph zmm0, zmm1, {ru-sae}  # case=2997-12 row=2997 expected=reach
vcvtw2ph zmm0 {k1}{z}, zmm1, {ru-sae}  # case=2997-13 row=2997 expected=reach
vcvtw2ph zmm0, zmm1, {rz-sae}  # case=2997-14 row=2997 expected=reach
vcvtw2ph zmm0 {k1}{z}, zmm1, {rz-sae}  # case=2997-15 row=2997 expected=reach
vdivph zmm0, zmm1, zmm2, {rn-sae}  # case=3003-8 row=3003 expected=reach
vdivph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3003-9 row=3003 expected=reach
vdivph zmm0, zmm1, zmm2, {rd-sae}  # case=3003-10 row=3003 expected=reach
vdivph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3003-11 row=3003 expected=reach
vdivph zmm0, zmm1, zmm2, {ru-sae}  # case=3003-12 row=3003 expected=reach
vdivph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3003-13 row=3003 expected=reach
vdivph zmm0, zmm1, zmm2, {rz-sae}  # case=3003-14 row=3003 expected=reach
vdivph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3003-15 row=3003 expected=reach
vdivsh xmm0, xmm1, xmm2, {rn-sae}  # case=3004-6 row=3004 expected=reach
vdivsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3004-7 row=3004 expected=reach
vdivsh xmm0, xmm1, xmm2, {rd-sae}  # case=3004-8 row=3004 expected=reach
vdivsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3004-9 row=3004 expected=reach
vdivsh xmm0, xmm1, xmm2, {ru-sae}  # case=3004-10 row=3004 expected=reach
vdivsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3004-11 row=3004 expected=reach
vdivsh xmm0, xmm1, xmm2, {rz-sae}  # case=3004-12 row=3004 expected=reach
vdivsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3004-13 row=3004 expected=reach
vfcmaddcph zmm0, zmm1, zmm2, {rn-sae}  # case=3032-8 row=3032 expected=reach
vfcmaddcph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3032-9 row=3032 expected=reach
vfcmaddcph zmm0, zmm1, zmm2, {rd-sae}  # case=3032-10 row=3032 expected=reach
vfcmaddcph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3032-11 row=3032 expected=reach
vfcmaddcph zmm0, zmm1, zmm2, {ru-sae}  # case=3032-12 row=3032 expected=reach
vfcmaddcph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3032-13 row=3032 expected=reach
vfcmaddcph zmm0, zmm1, zmm2, {rz-sae}  # case=3032-14 row=3032 expected=reach
vfcmaddcph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3032-15 row=3032 expected=reach
vfmaddcph zmm0, zmm1, zmm2, {rn-sae}  # case=3035-8 row=3035 expected=reach
vfmaddcph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3035-9 row=3035 expected=reach
vfmaddcph zmm0, zmm1, zmm2, {rd-sae}  # case=3035-10 row=3035 expected=reach
vfmaddcph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3035-11 row=3035 expected=reach
vfmaddcph zmm0, zmm1, zmm2, {ru-sae}  # case=3035-12 row=3035 expected=reach
vfmaddcph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3035-13 row=3035 expected=reach
vfmaddcph zmm0, zmm1, zmm2, {rz-sae}  # case=3035-14 row=3035 expected=reach
vfmaddcph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3035-15 row=3035 expected=reach
vfcmaddcsh xmm0, xmm1, xmm2, {rn-sae}  # case=3036-6 row=3036 expected=reach
vfcmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3036-7 row=3036 expected=reach
vfcmaddcsh xmm0, xmm1, xmm2, {rd-sae}  # case=3036-8 row=3036 expected=reach
vfcmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3036-9 row=3036 expected=reach
vfcmaddcsh xmm0, xmm1, xmm2, {ru-sae}  # case=3036-10 row=3036 expected=reach
vfcmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3036-11 row=3036 expected=reach
vfcmaddcsh xmm0, xmm1, xmm2, {rz-sae}  # case=3036-12 row=3036 expected=reach
vfcmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3036-13 row=3036 expected=reach
vfmaddcsh xmm0, xmm1, xmm2, {rn-sae}  # case=3037-6 row=3037 expected=reach
vfmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3037-7 row=3037 expected=reach
vfmaddcsh xmm0, xmm1, xmm2, {rd-sae}  # case=3037-8 row=3037 expected=reach
vfmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3037-9 row=3037 expected=reach
vfmaddcsh xmm0, xmm1, xmm2, {ru-sae}  # case=3037-10 row=3037 expected=reach
vfmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3037-11 row=3037 expected=reach
vfmaddcsh xmm0, xmm1, xmm2, {rz-sae}  # case=3037-12 row=3037 expected=reach
vfmaddcsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3037-13 row=3037 expected=reach
vfcmulcph zmm0, zmm1, zmm2, {rn-sae}  # case=3040-8 row=3040 expected=reach
vfcmulcph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3040-9 row=3040 expected=reach
vfcmulcph zmm0, zmm1, zmm2, {rd-sae}  # case=3040-10 row=3040 expected=reach
vfcmulcph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3040-11 row=3040 expected=reach
vfcmulcph zmm0, zmm1, zmm2, {ru-sae}  # case=3040-12 row=3040 expected=reach
vfcmulcph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3040-13 row=3040 expected=reach
vfcmulcph zmm0, zmm1, zmm2, {rz-sae}  # case=3040-14 row=3040 expected=reach
vfcmulcph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3040-15 row=3040 expected=reach
vfmulcph zmm0, zmm1, zmm2, {rn-sae}  # case=3043-8 row=3043 expected=reach
vfmulcph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3043-9 row=3043 expected=reach
vfmulcph zmm0, zmm1, zmm2, {rd-sae}  # case=3043-10 row=3043 expected=reach
vfmulcph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3043-11 row=3043 expected=reach
vfmulcph zmm0, zmm1, zmm2, {ru-sae}  # case=3043-12 row=3043 expected=reach
vfmulcph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3043-13 row=3043 expected=reach
vfmulcph zmm0, zmm1, zmm2, {rz-sae}  # case=3043-14 row=3043 expected=reach
vfmulcph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3043-15 row=3043 expected=reach
vfcmulcsh xmm0, xmm1, xmm2, {rn-sae}  # case=3044-6 row=3044 expected=reach
vfcmulcsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3044-7 row=3044 expected=reach
vfcmulcsh xmm0, xmm1, xmm2, {rd-sae}  # case=3044-8 row=3044 expected=reach
vfcmulcsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3044-9 row=3044 expected=reach
vfcmulcsh xmm0, xmm1, xmm2, {ru-sae}  # case=3044-10 row=3044 expected=reach
vfcmulcsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3044-11 row=3044 expected=reach
vfcmulcsh xmm0, xmm1, xmm2, {rz-sae}  # case=3044-12 row=3044 expected=reach
vfcmulcsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3044-13 row=3044 expected=reach
vfmulcsh xmm0, xmm1, xmm2, {rn-sae}  # case=3045-6 row=3045 expected=reach
vfmulcsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3045-7 row=3045 expected=reach
vfmulcsh xmm0, xmm1, xmm2, {rd-sae}  # case=3045-8 row=3045 expected=reach
vfmulcsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3045-9 row=3045 expected=reach
vfmulcsh xmm0, xmm1, xmm2, {ru-sae}  # case=3045-10 row=3045 expected=reach
vfmulcsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3045-11 row=3045 expected=reach
vfmulcsh xmm0, xmm1, xmm2, {rz-sae}  # case=3045-12 row=3045 expected=reach
vfmulcsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3045-13 row=3045 expected=reach
vfixupimmpd zmm0, zmm1, zmm2, {sae}, 0x12  # case=3048-9 row=3048 expected=reach
vfixupimmpd zmm0 {k1}{z}, zmm1, zmm2, {sae}, 0x12  # case=3048-10 row=3048 expected=reach
vfixupimmps zmm0, zmm1, zmm2, {sae}, 0x12  # case=3051-9 row=3051 expected=reach
vfixupimmps zmm0 {k1}{z}, zmm1, zmm2, {sae}, 0x12  # case=3051-10 row=3051 expected=reach
vfixupimmsd xmm0, xmm1, xmm2, {sae}, 0x12  # case=3052-7 row=3052 expected=reach
vfixupimmsd xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3052-8 row=3052 expected=reach
vfixupimmss xmm0, xmm1, xmm2, {sae}, 0x12  # case=3053-7 row=3053 expected=reach
vfixupimmss xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3053-8 row=3053 expected=reach
vfmadd132pd zmm0, zmm1, zmm2, {rn-sae}  # case=3066-8 row=3066 expected=reach
vfmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3066-9 row=3066 expected=reach
vfmadd132pd zmm0, zmm1, zmm2, {rd-sae}  # case=3066-10 row=3066 expected=reach
vfmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3066-11 row=3066 expected=reach
vfmadd132pd zmm0, zmm1, zmm2, {ru-sae}  # case=3066-12 row=3066 expected=reach
vfmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3066-13 row=3066 expected=reach
vfmadd132pd zmm0, zmm1, zmm2, {rz-sae}  # case=3066-14 row=3066 expected=reach
vfmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3066-15 row=3066 expected=reach
vfmadd213pd zmm0, zmm1, zmm2, {rn-sae}  # case=3067-8 row=3067 expected=reach
vfmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3067-9 row=3067 expected=reach
vfmadd213pd zmm0, zmm1, zmm2, {rd-sae}  # case=3067-10 row=3067 expected=reach
vfmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3067-11 row=3067 expected=reach
vfmadd213pd zmm0, zmm1, zmm2, {ru-sae}  # case=3067-12 row=3067 expected=reach
vfmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3067-13 row=3067 expected=reach
vfmadd213pd zmm0, zmm1, zmm2, {rz-sae}  # case=3067-14 row=3067 expected=reach
vfmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3067-15 row=3067 expected=reach
vfmadd231pd zmm0, zmm1, zmm2, {rn-sae}  # case=3068-8 row=3068 expected=reach
vfmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3068-9 row=3068 expected=reach
vfmadd231pd zmm0, zmm1, zmm2, {rd-sae}  # case=3068-10 row=3068 expected=reach
vfmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3068-11 row=3068 expected=reach
vfmadd231pd zmm0, zmm1, zmm2, {ru-sae}  # case=3068-12 row=3068 expected=reach
vfmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3068-13 row=3068 expected=reach
vfmadd231pd zmm0, zmm1, zmm2, {rz-sae}  # case=3068-14 row=3068 expected=reach
vfmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3068-15 row=3068 expected=reach
vfmadd132ph zmm0, zmm1, zmm2, {rn-sae}  # case=3071-8 row=3071 expected=reach
vfmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3071-9 row=3071 expected=reach
vfmadd132ph zmm0, zmm1, zmm2, {rd-sae}  # case=3071-10 row=3071 expected=reach
vfmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3071-11 row=3071 expected=reach
vfmadd132ph zmm0, zmm1, zmm2, {ru-sae}  # case=3071-12 row=3071 expected=reach
vfmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3071-13 row=3071 expected=reach
vfmadd132ph zmm0, zmm1, zmm2, {rz-sae}  # case=3071-14 row=3071 expected=reach
vfmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3071-15 row=3071 expected=reach
vfmadd213ph zmm0, zmm1, zmm2, {rn-sae}  # case=3074-8 row=3074 expected=reach
vfmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3074-9 row=3074 expected=reach
vfmadd213ph zmm0, zmm1, zmm2, {rd-sae}  # case=3074-10 row=3074 expected=reach
vfmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3074-11 row=3074 expected=reach
vfmadd213ph zmm0, zmm1, zmm2, {ru-sae}  # case=3074-12 row=3074 expected=reach
vfmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3074-13 row=3074 expected=reach
vfmadd213ph zmm0, zmm1, zmm2, {rz-sae}  # case=3074-14 row=3074 expected=reach
vfmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3074-15 row=3074 expected=reach
vfmadd231ph zmm0, zmm1, zmm2, {rn-sae}  # case=3077-8 row=3077 expected=reach
vfmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3077-9 row=3077 expected=reach
vfmadd231ph zmm0, zmm1, zmm2, {rd-sae}  # case=3077-10 row=3077 expected=reach
vfmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3077-11 row=3077 expected=reach
vfmadd231ph zmm0, zmm1, zmm2, {ru-sae}  # case=3077-12 row=3077 expected=reach
vfmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3077-13 row=3077 expected=reach
vfmadd231ph zmm0, zmm1, zmm2, {rz-sae}  # case=3077-14 row=3077 expected=reach
vfmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3077-15 row=3077 expected=reach
vfnmadd132ph zmm0, zmm1, zmm2, {rn-sae}  # case=3080-8 row=3080 expected=reach
vfnmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3080-9 row=3080 expected=reach
vfnmadd132ph zmm0, zmm1, zmm2, {rd-sae}  # case=3080-10 row=3080 expected=reach
vfnmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3080-11 row=3080 expected=reach
vfnmadd132ph zmm0, zmm1, zmm2, {ru-sae}  # case=3080-12 row=3080 expected=reach
vfnmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3080-13 row=3080 expected=reach
vfnmadd132ph zmm0, zmm1, zmm2, {rz-sae}  # case=3080-14 row=3080 expected=reach
vfnmadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3080-15 row=3080 expected=reach
vfnmadd213ph zmm0, zmm1, zmm2, {rn-sae}  # case=3083-8 row=3083 expected=reach
vfnmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3083-9 row=3083 expected=reach
vfnmadd213ph zmm0, zmm1, zmm2, {rd-sae}  # case=3083-10 row=3083 expected=reach
vfnmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3083-11 row=3083 expected=reach
vfnmadd213ph zmm0, zmm1, zmm2, {ru-sae}  # case=3083-12 row=3083 expected=reach
vfnmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3083-13 row=3083 expected=reach
vfnmadd213ph zmm0, zmm1, zmm2, {rz-sae}  # case=3083-14 row=3083 expected=reach
vfnmadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3083-15 row=3083 expected=reach
vfnmadd231ph zmm0, zmm1, zmm2, {rn-sae}  # case=3086-8 row=3086 expected=reach
vfnmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3086-9 row=3086 expected=reach
vfnmadd231ph zmm0, zmm1, zmm2, {rd-sae}  # case=3086-10 row=3086 expected=reach
vfnmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3086-11 row=3086 expected=reach
vfnmadd231ph zmm0, zmm1, zmm2, {ru-sae}  # case=3086-12 row=3086 expected=reach
vfnmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3086-13 row=3086 expected=reach
vfnmadd231ph zmm0, zmm1, zmm2, {rz-sae}  # case=3086-14 row=3086 expected=reach
vfnmadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3086-15 row=3086 expected=reach
vfmadd132ps zmm0, zmm1, zmm2, {rn-sae}  # case=3099-8 row=3099 expected=reach
vfmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3099-9 row=3099 expected=reach
vfmadd132ps zmm0, zmm1, zmm2, {rd-sae}  # case=3099-10 row=3099 expected=reach
vfmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3099-11 row=3099 expected=reach
vfmadd132ps zmm0, zmm1, zmm2, {ru-sae}  # case=3099-12 row=3099 expected=reach
vfmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3099-13 row=3099 expected=reach
vfmadd132ps zmm0, zmm1, zmm2, {rz-sae}  # case=3099-14 row=3099 expected=reach
vfmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3099-15 row=3099 expected=reach
vfmadd213ps zmm0, zmm1, zmm2, {rn-sae}  # case=3100-8 row=3100 expected=reach
vfmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3100-9 row=3100 expected=reach
vfmadd213ps zmm0, zmm1, zmm2, {rd-sae}  # case=3100-10 row=3100 expected=reach
vfmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3100-11 row=3100 expected=reach
vfmadd213ps zmm0, zmm1, zmm2, {ru-sae}  # case=3100-12 row=3100 expected=reach
vfmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3100-13 row=3100 expected=reach
vfmadd213ps zmm0, zmm1, zmm2, {rz-sae}  # case=3100-14 row=3100 expected=reach
vfmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3100-15 row=3100 expected=reach
vfmadd231ps zmm0, zmm1, zmm2, {rn-sae}  # case=3101-8 row=3101 expected=reach
vfmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3101-9 row=3101 expected=reach
vfmadd231ps zmm0, zmm1, zmm2, {rd-sae}  # case=3101-10 row=3101 expected=reach
vfmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3101-11 row=3101 expected=reach
vfmadd231ps zmm0, zmm1, zmm2, {ru-sae}  # case=3101-12 row=3101 expected=reach
vfmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3101-13 row=3101 expected=reach
vfmadd231ps zmm0, zmm1, zmm2, {rz-sae}  # case=3101-14 row=3101 expected=reach
vfmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3101-15 row=3101 expected=reach
vfmadd132sd xmm0, xmm1, xmm2, {rn-sae}  # case=3105-6 row=3105 expected=reach
vfmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3105-7 row=3105 expected=reach
vfmadd132sd xmm0, xmm1, xmm2, {rd-sae}  # case=3105-8 row=3105 expected=reach
vfmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3105-9 row=3105 expected=reach
vfmadd132sd xmm0, xmm1, xmm2, {ru-sae}  # case=3105-10 row=3105 expected=reach
vfmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3105-11 row=3105 expected=reach
vfmadd132sd xmm0, xmm1, xmm2, {rz-sae}  # case=3105-12 row=3105 expected=reach
vfmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3105-13 row=3105 expected=reach
vfmadd213sd xmm0, xmm1, xmm2, {rn-sae}  # case=3106-6 row=3106 expected=reach
vfmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3106-7 row=3106 expected=reach
vfmadd213sd xmm0, xmm1, xmm2, {rd-sae}  # case=3106-8 row=3106 expected=reach
vfmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3106-9 row=3106 expected=reach
vfmadd213sd xmm0, xmm1, xmm2, {ru-sae}  # case=3106-10 row=3106 expected=reach
vfmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3106-11 row=3106 expected=reach
vfmadd213sd xmm0, xmm1, xmm2, {rz-sae}  # case=3106-12 row=3106 expected=reach
vfmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3106-13 row=3106 expected=reach
vfmadd231sd xmm0, xmm1, xmm2, {rn-sae}  # case=3107-6 row=3107 expected=reach
vfmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3107-7 row=3107 expected=reach
vfmadd231sd xmm0, xmm1, xmm2, {rd-sae}  # case=3107-8 row=3107 expected=reach
vfmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3107-9 row=3107 expected=reach
vfmadd231sd xmm0, xmm1, xmm2, {ru-sae}  # case=3107-10 row=3107 expected=reach
vfmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3107-11 row=3107 expected=reach
vfmadd231sd xmm0, xmm1, xmm2, {rz-sae}  # case=3107-12 row=3107 expected=reach
vfmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3107-13 row=3107 expected=reach
vfmadd132sh xmm0, xmm1, xmm2, {rn-sae}  # case=3108-6 row=3108 expected=reach
vfmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3108-7 row=3108 expected=reach
vfmadd132sh xmm0, xmm1, xmm2, {rd-sae}  # case=3108-8 row=3108 expected=reach
vfmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3108-9 row=3108 expected=reach
vfmadd132sh xmm0, xmm1, xmm2, {ru-sae}  # case=3108-10 row=3108 expected=reach
vfmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3108-11 row=3108 expected=reach
vfmadd132sh xmm0, xmm1, xmm2, {rz-sae}  # case=3108-12 row=3108 expected=reach
vfmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3108-13 row=3108 expected=reach
vfmadd213sh xmm0, xmm1, xmm2, {rn-sae}  # case=3109-6 row=3109 expected=reach
vfmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3109-7 row=3109 expected=reach
vfmadd213sh xmm0, xmm1, xmm2, {rd-sae}  # case=3109-8 row=3109 expected=reach
vfmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3109-9 row=3109 expected=reach
vfmadd213sh xmm0, xmm1, xmm2, {ru-sae}  # case=3109-10 row=3109 expected=reach
vfmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3109-11 row=3109 expected=reach
vfmadd213sh xmm0, xmm1, xmm2, {rz-sae}  # case=3109-12 row=3109 expected=reach
vfmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3109-13 row=3109 expected=reach
vfmadd231sh xmm0, xmm1, xmm2, {rn-sae}  # case=3110-6 row=3110 expected=reach
vfmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3110-7 row=3110 expected=reach
vfmadd231sh xmm0, xmm1, xmm2, {rd-sae}  # case=3110-8 row=3110 expected=reach
vfmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3110-9 row=3110 expected=reach
vfmadd231sh xmm0, xmm1, xmm2, {ru-sae}  # case=3110-10 row=3110 expected=reach
vfmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3110-11 row=3110 expected=reach
vfmadd231sh xmm0, xmm1, xmm2, {rz-sae}  # case=3110-12 row=3110 expected=reach
vfmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3110-13 row=3110 expected=reach
vfnmadd132sh xmm0, xmm1, xmm2, {rn-sae}  # case=3111-6 row=3111 expected=reach
vfnmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3111-7 row=3111 expected=reach
vfnmadd132sh xmm0, xmm1, xmm2, {rd-sae}  # case=3111-8 row=3111 expected=reach
vfnmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3111-9 row=3111 expected=reach
vfnmadd132sh xmm0, xmm1, xmm2, {ru-sae}  # case=3111-10 row=3111 expected=reach
vfnmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3111-11 row=3111 expected=reach
vfnmadd132sh xmm0, xmm1, xmm2, {rz-sae}  # case=3111-12 row=3111 expected=reach
vfnmadd132sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3111-13 row=3111 expected=reach
vfnmadd213sh xmm0, xmm1, xmm2, {rn-sae}  # case=3112-6 row=3112 expected=reach
vfnmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3112-7 row=3112 expected=reach
vfnmadd213sh xmm0, xmm1, xmm2, {rd-sae}  # case=3112-8 row=3112 expected=reach
vfnmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3112-9 row=3112 expected=reach
vfnmadd213sh xmm0, xmm1, xmm2, {ru-sae}  # case=3112-10 row=3112 expected=reach
vfnmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3112-11 row=3112 expected=reach
vfnmadd213sh xmm0, xmm1, xmm2, {rz-sae}  # case=3112-12 row=3112 expected=reach
vfnmadd213sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3112-13 row=3112 expected=reach
vfnmadd231sh xmm0, xmm1, xmm2, {rn-sae}  # case=3113-6 row=3113 expected=reach
vfnmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3113-7 row=3113 expected=reach
vfnmadd231sh xmm0, xmm1, xmm2, {rd-sae}  # case=3113-8 row=3113 expected=reach
vfnmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3113-9 row=3113 expected=reach
vfnmadd231sh xmm0, xmm1, xmm2, {ru-sae}  # case=3113-10 row=3113 expected=reach
vfnmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3113-11 row=3113 expected=reach
vfnmadd231sh xmm0, xmm1, xmm2, {rz-sae}  # case=3113-12 row=3113 expected=reach
vfnmadd231sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3113-13 row=3113 expected=reach
vfmadd132ss xmm0, xmm1, xmm2, {rn-sae}  # case=3117-6 row=3117 expected=reach
vfmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3117-7 row=3117 expected=reach
vfmadd132ss xmm0, xmm1, xmm2, {rd-sae}  # case=3117-8 row=3117 expected=reach
vfmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3117-9 row=3117 expected=reach
vfmadd132ss xmm0, xmm1, xmm2, {ru-sae}  # case=3117-10 row=3117 expected=reach
vfmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3117-11 row=3117 expected=reach
vfmadd132ss xmm0, xmm1, xmm2, {rz-sae}  # case=3117-12 row=3117 expected=reach
vfmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3117-13 row=3117 expected=reach
vfmadd213ss xmm0, xmm1, xmm2, {rn-sae}  # case=3118-6 row=3118 expected=reach
vfmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3118-7 row=3118 expected=reach
vfmadd213ss xmm0, xmm1, xmm2, {rd-sae}  # case=3118-8 row=3118 expected=reach
vfmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3118-9 row=3118 expected=reach
vfmadd213ss xmm0, xmm1, xmm2, {ru-sae}  # case=3118-10 row=3118 expected=reach
vfmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3118-11 row=3118 expected=reach
vfmadd213ss xmm0, xmm1, xmm2, {rz-sae}  # case=3118-12 row=3118 expected=reach
vfmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3118-13 row=3118 expected=reach
vfmadd231ss xmm0, xmm1, xmm2, {rn-sae}  # case=3119-6 row=3119 expected=reach
vfmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3119-7 row=3119 expected=reach
vfmadd231ss xmm0, xmm1, xmm2, {rd-sae}  # case=3119-8 row=3119 expected=reach
vfmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3119-9 row=3119 expected=reach
vfmadd231ss xmm0, xmm1, xmm2, {ru-sae}  # case=3119-10 row=3119 expected=reach
vfmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3119-11 row=3119 expected=reach
vfmadd231ss xmm0, xmm1, xmm2, {rz-sae}  # case=3119-12 row=3119 expected=reach
vfmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3119-13 row=3119 expected=reach
vfmaddsub213pd zmm0, zmm1, zmm2, {rn-sae}  # case=3132-8 row=3132 expected=reach
vfmaddsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3132-9 row=3132 expected=reach
vfmaddsub213pd zmm0, zmm1, zmm2, {rd-sae}  # case=3132-10 row=3132 expected=reach
vfmaddsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3132-11 row=3132 expected=reach
vfmaddsub213pd zmm0, zmm1, zmm2, {ru-sae}  # case=3132-12 row=3132 expected=reach
vfmaddsub213pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3132-13 row=3132 expected=reach
vfmaddsub213pd zmm0, zmm1, zmm2, {rz-sae}  # case=3132-14 row=3132 expected=reach
vfmaddsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3132-15 row=3132 expected=reach
vfmaddsub231pd zmm0, zmm1, zmm2, {rn-sae}  # case=3133-8 row=3133 expected=reach
vfmaddsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3133-9 row=3133 expected=reach
vfmaddsub231pd zmm0, zmm1, zmm2, {rd-sae}  # case=3133-10 row=3133 expected=reach
vfmaddsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3133-11 row=3133 expected=reach
vfmaddsub231pd zmm0, zmm1, zmm2, {ru-sae}  # case=3133-12 row=3133 expected=reach
vfmaddsub231pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3133-13 row=3133 expected=reach
vfmaddsub231pd zmm0, zmm1, zmm2, {rz-sae}  # case=3133-14 row=3133 expected=reach
vfmaddsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3133-15 row=3133 expected=reach
vfmaddsub132pd zmm0, zmm1, zmm2, {rn-sae}  # case=3134-8 row=3134 expected=reach
vfmaddsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3134-9 row=3134 expected=reach
vfmaddsub132pd zmm0, zmm1, zmm2, {rd-sae}  # case=3134-10 row=3134 expected=reach
vfmaddsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3134-11 row=3134 expected=reach
vfmaddsub132pd zmm0, zmm1, zmm2, {ru-sae}  # case=3134-12 row=3134 expected=reach
vfmaddsub132pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3134-13 row=3134 expected=reach
vfmaddsub132pd zmm0, zmm1, zmm2, {rz-sae}  # case=3134-14 row=3134 expected=reach
vfmaddsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3134-15 row=3134 expected=reach
vfmaddsub132ph zmm0, zmm1, zmm2, {rn-sae}  # case=3137-8 row=3137 expected=reach
vfmaddsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3137-9 row=3137 expected=reach
vfmaddsub132ph zmm0, zmm1, zmm2, {rd-sae}  # case=3137-10 row=3137 expected=reach
vfmaddsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3137-11 row=3137 expected=reach
vfmaddsub132ph zmm0, zmm1, zmm2, {ru-sae}  # case=3137-12 row=3137 expected=reach
vfmaddsub132ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3137-13 row=3137 expected=reach
vfmaddsub132ph zmm0, zmm1, zmm2, {rz-sae}  # case=3137-14 row=3137 expected=reach
vfmaddsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3137-15 row=3137 expected=reach
vfmaddsub213ph zmm0, zmm1, zmm2, {rn-sae}  # case=3140-8 row=3140 expected=reach
vfmaddsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3140-9 row=3140 expected=reach
vfmaddsub213ph zmm0, zmm1, zmm2, {rd-sae}  # case=3140-10 row=3140 expected=reach
vfmaddsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3140-11 row=3140 expected=reach
vfmaddsub213ph zmm0, zmm1, zmm2, {ru-sae}  # case=3140-12 row=3140 expected=reach
vfmaddsub213ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3140-13 row=3140 expected=reach
vfmaddsub213ph zmm0, zmm1, zmm2, {rz-sae}  # case=3140-14 row=3140 expected=reach
vfmaddsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3140-15 row=3140 expected=reach
vfmaddsub231ph zmm0, zmm1, zmm2, {rn-sae}  # case=3143-8 row=3143 expected=reach
vfmaddsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3143-9 row=3143 expected=reach
vfmaddsub231ph zmm0, zmm1, zmm2, {rd-sae}  # case=3143-10 row=3143 expected=reach
vfmaddsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3143-11 row=3143 expected=reach
vfmaddsub231ph zmm0, zmm1, zmm2, {ru-sae}  # case=3143-12 row=3143 expected=reach
vfmaddsub231ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3143-13 row=3143 expected=reach
vfmaddsub231ph zmm0, zmm1, zmm2, {rz-sae}  # case=3143-14 row=3143 expected=reach
vfmaddsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3143-15 row=3143 expected=reach
vfmaddsub213ps zmm0, zmm1, zmm2, {rn-sae}  # case=3156-8 row=3156 expected=reach
vfmaddsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3156-9 row=3156 expected=reach
vfmaddsub213ps zmm0, zmm1, zmm2, {rd-sae}  # case=3156-10 row=3156 expected=reach
vfmaddsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3156-11 row=3156 expected=reach
vfmaddsub213ps zmm0, zmm1, zmm2, {ru-sae}  # case=3156-12 row=3156 expected=reach
vfmaddsub213ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3156-13 row=3156 expected=reach
vfmaddsub213ps zmm0, zmm1, zmm2, {rz-sae}  # case=3156-14 row=3156 expected=reach
vfmaddsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3156-15 row=3156 expected=reach
vfmaddsub231ps zmm0, zmm1, zmm2, {rn-sae}  # case=3157-8 row=3157 expected=reach
vfmaddsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3157-9 row=3157 expected=reach
vfmaddsub231ps zmm0, zmm1, zmm2, {rd-sae}  # case=3157-10 row=3157 expected=reach
vfmaddsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3157-11 row=3157 expected=reach
vfmaddsub231ps zmm0, zmm1, zmm2, {ru-sae}  # case=3157-12 row=3157 expected=reach
vfmaddsub231ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3157-13 row=3157 expected=reach
vfmaddsub231ps zmm0, zmm1, zmm2, {rz-sae}  # case=3157-14 row=3157 expected=reach
vfmaddsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3157-15 row=3157 expected=reach
vfmaddsub132ps zmm0, zmm1, zmm2, {rn-sae}  # case=3158-8 row=3158 expected=reach
vfmaddsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3158-9 row=3158 expected=reach
vfmaddsub132ps zmm0, zmm1, zmm2, {rd-sae}  # case=3158-10 row=3158 expected=reach
vfmaddsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3158-11 row=3158 expected=reach
vfmaddsub132ps zmm0, zmm1, zmm2, {ru-sae}  # case=3158-12 row=3158 expected=reach
vfmaddsub132ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3158-13 row=3158 expected=reach
vfmaddsub132ps zmm0, zmm1, zmm2, {rz-sae}  # case=3158-14 row=3158 expected=reach
vfmaddsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3158-15 row=3158 expected=reach
vfmsub132pd zmm0, zmm1, zmm2, {rn-sae}  # case=3171-8 row=3171 expected=reach
vfmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3171-9 row=3171 expected=reach
vfmsub132pd zmm0, zmm1, zmm2, {rd-sae}  # case=3171-10 row=3171 expected=reach
vfmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3171-11 row=3171 expected=reach
vfmsub132pd zmm0, zmm1, zmm2, {ru-sae}  # case=3171-12 row=3171 expected=reach
vfmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3171-13 row=3171 expected=reach
vfmsub132pd zmm0, zmm1, zmm2, {rz-sae}  # case=3171-14 row=3171 expected=reach
vfmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3171-15 row=3171 expected=reach
vfmsub213pd zmm0, zmm1, zmm2, {rn-sae}  # case=3172-8 row=3172 expected=reach
vfmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3172-9 row=3172 expected=reach
vfmsub213pd zmm0, zmm1, zmm2, {rd-sae}  # case=3172-10 row=3172 expected=reach
vfmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3172-11 row=3172 expected=reach
vfmsub213pd zmm0, zmm1, zmm2, {ru-sae}  # case=3172-12 row=3172 expected=reach
vfmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3172-13 row=3172 expected=reach
vfmsub213pd zmm0, zmm1, zmm2, {rz-sae}  # case=3172-14 row=3172 expected=reach
vfmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3172-15 row=3172 expected=reach
vfmsub231pd zmm0, zmm1, zmm2, {rn-sae}  # case=3173-8 row=3173 expected=reach
vfmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3173-9 row=3173 expected=reach
vfmsub231pd zmm0, zmm1, zmm2, {rd-sae}  # case=3173-10 row=3173 expected=reach
vfmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3173-11 row=3173 expected=reach
vfmsub231pd zmm0, zmm1, zmm2, {ru-sae}  # case=3173-12 row=3173 expected=reach
vfmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3173-13 row=3173 expected=reach
vfmsub231pd zmm0, zmm1, zmm2, {rz-sae}  # case=3173-14 row=3173 expected=reach
vfmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3173-15 row=3173 expected=reach
vfmsub132ph zmm0, zmm1, zmm2, {rn-sae}  # case=3176-8 row=3176 expected=reach
vfmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3176-9 row=3176 expected=reach
vfmsub132ph zmm0, zmm1, zmm2, {rd-sae}  # case=3176-10 row=3176 expected=reach
vfmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3176-11 row=3176 expected=reach
vfmsub132ph zmm0, zmm1, zmm2, {ru-sae}  # case=3176-12 row=3176 expected=reach
vfmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3176-13 row=3176 expected=reach
vfmsub132ph zmm0, zmm1, zmm2, {rz-sae}  # case=3176-14 row=3176 expected=reach
vfmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3176-15 row=3176 expected=reach
vfmsub213ph zmm0, zmm1, zmm2, {rn-sae}  # case=3179-8 row=3179 expected=reach
vfmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3179-9 row=3179 expected=reach
vfmsub213ph zmm0, zmm1, zmm2, {rd-sae}  # case=3179-10 row=3179 expected=reach
vfmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3179-11 row=3179 expected=reach
vfmsub213ph zmm0, zmm1, zmm2, {ru-sae}  # case=3179-12 row=3179 expected=reach
vfmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3179-13 row=3179 expected=reach
vfmsub213ph zmm0, zmm1, zmm2, {rz-sae}  # case=3179-14 row=3179 expected=reach
vfmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3179-15 row=3179 expected=reach
vfmsub231ph zmm0, zmm1, zmm2, {rn-sae}  # case=3182-8 row=3182 expected=reach
vfmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3182-9 row=3182 expected=reach
vfmsub231ph zmm0, zmm1, zmm2, {rd-sae}  # case=3182-10 row=3182 expected=reach
vfmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3182-11 row=3182 expected=reach
vfmsub231ph zmm0, zmm1, zmm2, {ru-sae}  # case=3182-12 row=3182 expected=reach
vfmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3182-13 row=3182 expected=reach
vfmsub231ph zmm0, zmm1, zmm2, {rz-sae}  # case=3182-14 row=3182 expected=reach
vfmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3182-15 row=3182 expected=reach
vfnmsub132ph zmm0, zmm1, zmm2, {rn-sae}  # case=3185-8 row=3185 expected=reach
vfnmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3185-9 row=3185 expected=reach
vfnmsub132ph zmm0, zmm1, zmm2, {rd-sae}  # case=3185-10 row=3185 expected=reach
vfnmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3185-11 row=3185 expected=reach
vfnmsub132ph zmm0, zmm1, zmm2, {ru-sae}  # case=3185-12 row=3185 expected=reach
vfnmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3185-13 row=3185 expected=reach
vfnmsub132ph zmm0, zmm1, zmm2, {rz-sae}  # case=3185-14 row=3185 expected=reach
vfnmsub132ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3185-15 row=3185 expected=reach
vfnmsub213ph zmm0, zmm1, zmm2, {rn-sae}  # case=3188-8 row=3188 expected=reach
vfnmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3188-9 row=3188 expected=reach
vfnmsub213ph zmm0, zmm1, zmm2, {rd-sae}  # case=3188-10 row=3188 expected=reach
vfnmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3188-11 row=3188 expected=reach
vfnmsub213ph zmm0, zmm1, zmm2, {ru-sae}  # case=3188-12 row=3188 expected=reach
vfnmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3188-13 row=3188 expected=reach
vfnmsub213ph zmm0, zmm1, zmm2, {rz-sae}  # case=3188-14 row=3188 expected=reach
vfnmsub213ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3188-15 row=3188 expected=reach
vfnmsub231ph zmm0, zmm1, zmm2, {rn-sae}  # case=3191-8 row=3191 expected=reach
vfnmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3191-9 row=3191 expected=reach
vfnmsub231ph zmm0, zmm1, zmm2, {rd-sae}  # case=3191-10 row=3191 expected=reach
vfnmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3191-11 row=3191 expected=reach
vfnmsub231ph zmm0, zmm1, zmm2, {ru-sae}  # case=3191-12 row=3191 expected=reach
vfnmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3191-13 row=3191 expected=reach
vfnmsub231ph zmm0, zmm1, zmm2, {rz-sae}  # case=3191-14 row=3191 expected=reach
vfnmsub231ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3191-15 row=3191 expected=reach
vfmsub132ps zmm0, zmm1, zmm2, {rn-sae}  # case=3204-8 row=3204 expected=reach
vfmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3204-9 row=3204 expected=reach
vfmsub132ps zmm0, zmm1, zmm2, {rd-sae}  # case=3204-10 row=3204 expected=reach
vfmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3204-11 row=3204 expected=reach
vfmsub132ps zmm0, zmm1, zmm2, {ru-sae}  # case=3204-12 row=3204 expected=reach
vfmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3204-13 row=3204 expected=reach
vfmsub132ps zmm0, zmm1, zmm2, {rz-sae}  # case=3204-14 row=3204 expected=reach
vfmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3204-15 row=3204 expected=reach
vfmsub213ps zmm0, zmm1, zmm2, {rn-sae}  # case=3205-8 row=3205 expected=reach
vfmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3205-9 row=3205 expected=reach
vfmsub213ps zmm0, zmm1, zmm2, {rd-sae}  # case=3205-10 row=3205 expected=reach
vfmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3205-11 row=3205 expected=reach
vfmsub213ps zmm0, zmm1, zmm2, {ru-sae}  # case=3205-12 row=3205 expected=reach
vfmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3205-13 row=3205 expected=reach
vfmsub213ps zmm0, zmm1, zmm2, {rz-sae}  # case=3205-14 row=3205 expected=reach
vfmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3205-15 row=3205 expected=reach
vfmsub231ps zmm0, zmm1, zmm2, {rn-sae}  # case=3206-8 row=3206 expected=reach
vfmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3206-9 row=3206 expected=reach
vfmsub231ps zmm0, zmm1, zmm2, {rd-sae}  # case=3206-10 row=3206 expected=reach
vfmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3206-11 row=3206 expected=reach
vfmsub231ps zmm0, zmm1, zmm2, {ru-sae}  # case=3206-12 row=3206 expected=reach
vfmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3206-13 row=3206 expected=reach
vfmsub231ps zmm0, zmm1, zmm2, {rz-sae}  # case=3206-14 row=3206 expected=reach
vfmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3206-15 row=3206 expected=reach
vfmsub132sd xmm0, xmm1, xmm2, {rn-sae}  # case=3210-6 row=3210 expected=reach
vfmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3210-7 row=3210 expected=reach
vfmsub132sd xmm0, xmm1, xmm2, {rd-sae}  # case=3210-8 row=3210 expected=reach
vfmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3210-9 row=3210 expected=reach
vfmsub132sd xmm0, xmm1, xmm2, {ru-sae}  # case=3210-10 row=3210 expected=reach
vfmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3210-11 row=3210 expected=reach
vfmsub132sd xmm0, xmm1, xmm2, {rz-sae}  # case=3210-12 row=3210 expected=reach
vfmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3210-13 row=3210 expected=reach
vfmsub213sd xmm0, xmm1, xmm2, {rn-sae}  # case=3211-6 row=3211 expected=reach
vfmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3211-7 row=3211 expected=reach
vfmsub213sd xmm0, xmm1, xmm2, {rd-sae}  # case=3211-8 row=3211 expected=reach
vfmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3211-9 row=3211 expected=reach
vfmsub213sd xmm0, xmm1, xmm2, {ru-sae}  # case=3211-10 row=3211 expected=reach
vfmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3211-11 row=3211 expected=reach
vfmsub213sd xmm0, xmm1, xmm2, {rz-sae}  # case=3211-12 row=3211 expected=reach
vfmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3211-13 row=3211 expected=reach
vfmsub231sd xmm0, xmm1, xmm2, {rn-sae}  # case=3212-6 row=3212 expected=reach
vfmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3212-7 row=3212 expected=reach
vfmsub231sd xmm0, xmm1, xmm2, {rd-sae}  # case=3212-8 row=3212 expected=reach
vfmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3212-9 row=3212 expected=reach
vfmsub231sd xmm0, xmm1, xmm2, {ru-sae}  # case=3212-10 row=3212 expected=reach
vfmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3212-11 row=3212 expected=reach
vfmsub231sd xmm0, xmm1, xmm2, {rz-sae}  # case=3212-12 row=3212 expected=reach
vfmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3212-13 row=3212 expected=reach
vfmsub132sh xmm0, xmm1, xmm2, {rn-sae}  # case=3213-6 row=3213 expected=reach
vfmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3213-7 row=3213 expected=reach
vfmsub132sh xmm0, xmm1, xmm2, {rd-sae}  # case=3213-8 row=3213 expected=reach
vfmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3213-9 row=3213 expected=reach
vfmsub132sh xmm0, xmm1, xmm2, {ru-sae}  # case=3213-10 row=3213 expected=reach
vfmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3213-11 row=3213 expected=reach
vfmsub132sh xmm0, xmm1, xmm2, {rz-sae}  # case=3213-12 row=3213 expected=reach
vfmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3213-13 row=3213 expected=reach
vfmsub213sh xmm0, xmm1, xmm2, {rn-sae}  # case=3214-6 row=3214 expected=reach
vfmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3214-7 row=3214 expected=reach
vfmsub213sh xmm0, xmm1, xmm2, {rd-sae}  # case=3214-8 row=3214 expected=reach
vfmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3214-9 row=3214 expected=reach
vfmsub213sh xmm0, xmm1, xmm2, {ru-sae}  # case=3214-10 row=3214 expected=reach
vfmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3214-11 row=3214 expected=reach
vfmsub213sh xmm0, xmm1, xmm2, {rz-sae}  # case=3214-12 row=3214 expected=reach
vfmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3214-13 row=3214 expected=reach
vfmsub231sh xmm0, xmm1, xmm2, {rn-sae}  # case=3215-6 row=3215 expected=reach
vfmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3215-7 row=3215 expected=reach
vfmsub231sh xmm0, xmm1, xmm2, {rd-sae}  # case=3215-8 row=3215 expected=reach
vfmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3215-9 row=3215 expected=reach
vfmsub231sh xmm0, xmm1, xmm2, {ru-sae}  # case=3215-10 row=3215 expected=reach
vfmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3215-11 row=3215 expected=reach
vfmsub231sh xmm0, xmm1, xmm2, {rz-sae}  # case=3215-12 row=3215 expected=reach
vfmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3215-13 row=3215 expected=reach
vfnmsub132sh xmm0, xmm1, xmm2, {rn-sae}  # case=3216-6 row=3216 expected=reach
vfnmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3216-7 row=3216 expected=reach
vfnmsub132sh xmm0, xmm1, xmm2, {rd-sae}  # case=3216-8 row=3216 expected=reach
vfnmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3216-9 row=3216 expected=reach
vfnmsub132sh xmm0, xmm1, xmm2, {ru-sae}  # case=3216-10 row=3216 expected=reach
vfnmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3216-11 row=3216 expected=reach
vfnmsub132sh xmm0, xmm1, xmm2, {rz-sae}  # case=3216-12 row=3216 expected=reach
vfnmsub132sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3216-13 row=3216 expected=reach
vfnmsub213sh xmm0, xmm1, xmm2, {rn-sae}  # case=3217-6 row=3217 expected=reach
vfnmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3217-7 row=3217 expected=reach
vfnmsub213sh xmm0, xmm1, xmm2, {rd-sae}  # case=3217-8 row=3217 expected=reach
vfnmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3217-9 row=3217 expected=reach
vfnmsub213sh xmm0, xmm1, xmm2, {ru-sae}  # case=3217-10 row=3217 expected=reach
vfnmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3217-11 row=3217 expected=reach
vfnmsub213sh xmm0, xmm1, xmm2, {rz-sae}  # case=3217-12 row=3217 expected=reach
vfnmsub213sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3217-13 row=3217 expected=reach
vfnmsub231sh xmm0, xmm1, xmm2, {rn-sae}  # case=3218-6 row=3218 expected=reach
vfnmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3218-7 row=3218 expected=reach
vfnmsub231sh xmm0, xmm1, xmm2, {rd-sae}  # case=3218-8 row=3218 expected=reach
vfnmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3218-9 row=3218 expected=reach
vfnmsub231sh xmm0, xmm1, xmm2, {ru-sae}  # case=3218-10 row=3218 expected=reach
vfnmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3218-11 row=3218 expected=reach
vfnmsub231sh xmm0, xmm1, xmm2, {rz-sae}  # case=3218-12 row=3218 expected=reach
vfnmsub231sh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3218-13 row=3218 expected=reach
vfmsub132ss xmm0, xmm1, xmm2, {rn-sae}  # case=3222-6 row=3222 expected=reach
vfmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3222-7 row=3222 expected=reach
vfmsub132ss xmm0, xmm1, xmm2, {rd-sae}  # case=3222-8 row=3222 expected=reach
vfmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3222-9 row=3222 expected=reach
vfmsub132ss xmm0, xmm1, xmm2, {ru-sae}  # case=3222-10 row=3222 expected=reach
vfmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3222-11 row=3222 expected=reach
vfmsub132ss xmm0, xmm1, xmm2, {rz-sae}  # case=3222-12 row=3222 expected=reach
vfmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3222-13 row=3222 expected=reach
vfmsub213ss xmm0, xmm1, xmm2, {rn-sae}  # case=3223-6 row=3223 expected=reach
vfmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3223-7 row=3223 expected=reach
vfmsub213ss xmm0, xmm1, xmm2, {rd-sae}  # case=3223-8 row=3223 expected=reach
vfmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3223-9 row=3223 expected=reach
vfmsub213ss xmm0, xmm1, xmm2, {ru-sae}  # case=3223-10 row=3223 expected=reach
vfmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3223-11 row=3223 expected=reach
vfmsub213ss xmm0, xmm1, xmm2, {rz-sae}  # case=3223-12 row=3223 expected=reach
vfmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3223-13 row=3223 expected=reach
vfmsub231ss xmm0, xmm1, xmm2, {rn-sae}  # case=3224-6 row=3224 expected=reach
vfmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3224-7 row=3224 expected=reach
vfmsub231ss xmm0, xmm1, xmm2, {rd-sae}  # case=3224-8 row=3224 expected=reach
vfmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3224-9 row=3224 expected=reach
vfmsub231ss xmm0, xmm1, xmm2, {ru-sae}  # case=3224-10 row=3224 expected=reach
vfmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3224-11 row=3224 expected=reach
vfmsub231ss xmm0, xmm1, xmm2, {rz-sae}  # case=3224-12 row=3224 expected=reach
vfmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3224-13 row=3224 expected=reach
vfmsubadd132pd zmm0, zmm1, zmm2, {rn-sae}  # case=3237-8 row=3237 expected=reach
vfmsubadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3237-9 row=3237 expected=reach
vfmsubadd132pd zmm0, zmm1, zmm2, {rd-sae}  # case=3237-10 row=3237 expected=reach
vfmsubadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3237-11 row=3237 expected=reach
vfmsubadd132pd zmm0, zmm1, zmm2, {ru-sae}  # case=3237-12 row=3237 expected=reach
vfmsubadd132pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3237-13 row=3237 expected=reach
vfmsubadd132pd zmm0, zmm1, zmm2, {rz-sae}  # case=3237-14 row=3237 expected=reach
vfmsubadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3237-15 row=3237 expected=reach
vfmsubadd213pd zmm0, zmm1, zmm2, {rn-sae}  # case=3238-8 row=3238 expected=reach
vfmsubadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3238-9 row=3238 expected=reach
vfmsubadd213pd zmm0, zmm1, zmm2, {rd-sae}  # case=3238-10 row=3238 expected=reach
vfmsubadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3238-11 row=3238 expected=reach
vfmsubadd213pd zmm0, zmm1, zmm2, {ru-sae}  # case=3238-12 row=3238 expected=reach
vfmsubadd213pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3238-13 row=3238 expected=reach
vfmsubadd213pd zmm0, zmm1, zmm2, {rz-sae}  # case=3238-14 row=3238 expected=reach
vfmsubadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3238-15 row=3238 expected=reach
vfmsubadd231pd zmm0, zmm1, zmm2, {rn-sae}  # case=3239-8 row=3239 expected=reach
vfmsubadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3239-9 row=3239 expected=reach
vfmsubadd231pd zmm0, zmm1, zmm2, {rd-sae}  # case=3239-10 row=3239 expected=reach
vfmsubadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3239-11 row=3239 expected=reach
vfmsubadd231pd zmm0, zmm1, zmm2, {ru-sae}  # case=3239-12 row=3239 expected=reach
vfmsubadd231pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3239-13 row=3239 expected=reach
vfmsubadd231pd zmm0, zmm1, zmm2, {rz-sae}  # case=3239-14 row=3239 expected=reach
vfmsubadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3239-15 row=3239 expected=reach
vfmsubadd132ph zmm0, zmm1, zmm2, {rn-sae}  # case=3242-8 row=3242 expected=reach
vfmsubadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3242-9 row=3242 expected=reach
vfmsubadd132ph zmm0, zmm1, zmm2, {rd-sae}  # case=3242-10 row=3242 expected=reach
vfmsubadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3242-11 row=3242 expected=reach
vfmsubadd132ph zmm0, zmm1, zmm2, {ru-sae}  # case=3242-12 row=3242 expected=reach
vfmsubadd132ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3242-13 row=3242 expected=reach
vfmsubadd132ph zmm0, zmm1, zmm2, {rz-sae}  # case=3242-14 row=3242 expected=reach
vfmsubadd132ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3242-15 row=3242 expected=reach
vfmsubadd213ph zmm0, zmm1, zmm2, {rn-sae}  # case=3245-8 row=3245 expected=reach
vfmsubadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3245-9 row=3245 expected=reach
vfmsubadd213ph zmm0, zmm1, zmm2, {rd-sae}  # case=3245-10 row=3245 expected=reach
vfmsubadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3245-11 row=3245 expected=reach
vfmsubadd213ph zmm0, zmm1, zmm2, {ru-sae}  # case=3245-12 row=3245 expected=reach
vfmsubadd213ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3245-13 row=3245 expected=reach
vfmsubadd213ph zmm0, zmm1, zmm2, {rz-sae}  # case=3245-14 row=3245 expected=reach
vfmsubadd213ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3245-15 row=3245 expected=reach
vfmsubadd231ph zmm0, zmm1, zmm2, {rn-sae}  # case=3248-8 row=3248 expected=reach
vfmsubadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3248-9 row=3248 expected=reach
vfmsubadd231ph zmm0, zmm1, zmm2, {rd-sae}  # case=3248-10 row=3248 expected=reach
vfmsubadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3248-11 row=3248 expected=reach
vfmsubadd231ph zmm0, zmm1, zmm2, {ru-sae}  # case=3248-12 row=3248 expected=reach
vfmsubadd231ph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3248-13 row=3248 expected=reach
vfmsubadd231ph zmm0, zmm1, zmm2, {rz-sae}  # case=3248-14 row=3248 expected=reach
vfmsubadd231ph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3248-15 row=3248 expected=reach
vfmsubadd132ps zmm0, zmm1, zmm2, {rn-sae}  # case=3261-8 row=3261 expected=reach
vfmsubadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3261-9 row=3261 expected=reach
vfmsubadd132ps zmm0, zmm1, zmm2, {rd-sae}  # case=3261-10 row=3261 expected=reach
vfmsubadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3261-11 row=3261 expected=reach
vfmsubadd132ps zmm0, zmm1, zmm2, {ru-sae}  # case=3261-12 row=3261 expected=reach
vfmsubadd132ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3261-13 row=3261 expected=reach
vfmsubadd132ps zmm0, zmm1, zmm2, {rz-sae}  # case=3261-14 row=3261 expected=reach
vfmsubadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3261-15 row=3261 expected=reach
vfmsubadd213ps zmm0, zmm1, zmm2, {rn-sae}  # case=3262-8 row=3262 expected=reach
vfmsubadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3262-9 row=3262 expected=reach
vfmsubadd213ps zmm0, zmm1, zmm2, {rd-sae}  # case=3262-10 row=3262 expected=reach
vfmsubadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3262-11 row=3262 expected=reach
vfmsubadd213ps zmm0, zmm1, zmm2, {ru-sae}  # case=3262-12 row=3262 expected=reach
vfmsubadd213ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3262-13 row=3262 expected=reach
vfmsubadd213ps zmm0, zmm1, zmm2, {rz-sae}  # case=3262-14 row=3262 expected=reach
vfmsubadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3262-15 row=3262 expected=reach
vfmsubadd231ps zmm0, zmm1, zmm2, {rn-sae}  # case=3263-8 row=3263 expected=reach
vfmsubadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3263-9 row=3263 expected=reach
vfmsubadd231ps zmm0, zmm1, zmm2, {rd-sae}  # case=3263-10 row=3263 expected=reach
vfmsubadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3263-11 row=3263 expected=reach
vfmsubadd231ps zmm0, zmm1, zmm2, {ru-sae}  # case=3263-12 row=3263 expected=reach
vfmsubadd231ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3263-13 row=3263 expected=reach
vfmsubadd231ps zmm0, zmm1, zmm2, {rz-sae}  # case=3263-14 row=3263 expected=reach
vfmsubadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3263-15 row=3263 expected=reach
vfnmadd132pd zmm0, zmm1, zmm2, {rn-sae}  # case=3276-8 row=3276 expected=reach
vfnmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3276-9 row=3276 expected=reach
vfnmadd132pd zmm0, zmm1, zmm2, {rd-sae}  # case=3276-10 row=3276 expected=reach
vfnmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3276-11 row=3276 expected=reach
vfnmadd132pd zmm0, zmm1, zmm2, {ru-sae}  # case=3276-12 row=3276 expected=reach
vfnmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3276-13 row=3276 expected=reach
vfnmadd132pd zmm0, zmm1, zmm2, {rz-sae}  # case=3276-14 row=3276 expected=reach
vfnmadd132pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3276-15 row=3276 expected=reach
vfnmadd213pd zmm0, zmm1, zmm2, {rn-sae}  # case=3277-8 row=3277 expected=reach
vfnmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3277-9 row=3277 expected=reach
vfnmadd213pd zmm0, zmm1, zmm2, {rd-sae}  # case=3277-10 row=3277 expected=reach
vfnmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3277-11 row=3277 expected=reach
vfnmadd213pd zmm0, zmm1, zmm2, {ru-sae}  # case=3277-12 row=3277 expected=reach
vfnmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3277-13 row=3277 expected=reach
vfnmadd213pd zmm0, zmm1, zmm2, {rz-sae}  # case=3277-14 row=3277 expected=reach
vfnmadd213pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3277-15 row=3277 expected=reach
vfnmadd231pd zmm0, zmm1, zmm2, {rn-sae}  # case=3278-8 row=3278 expected=reach
vfnmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3278-9 row=3278 expected=reach
vfnmadd231pd zmm0, zmm1, zmm2, {rd-sae}  # case=3278-10 row=3278 expected=reach
vfnmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3278-11 row=3278 expected=reach
vfnmadd231pd zmm0, zmm1, zmm2, {ru-sae}  # case=3278-12 row=3278 expected=reach
vfnmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3278-13 row=3278 expected=reach
vfnmadd231pd zmm0, zmm1, zmm2, {rz-sae}  # case=3278-14 row=3278 expected=reach
vfnmadd231pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3278-15 row=3278 expected=reach
vfnmadd132ps zmm0, zmm1, zmm2, {rn-sae}  # case=3291-8 row=3291 expected=reach
vfnmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3291-9 row=3291 expected=reach
vfnmadd132ps zmm0, zmm1, zmm2, {rd-sae}  # case=3291-10 row=3291 expected=reach
vfnmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3291-11 row=3291 expected=reach
vfnmadd132ps zmm0, zmm1, zmm2, {ru-sae}  # case=3291-12 row=3291 expected=reach
vfnmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3291-13 row=3291 expected=reach
vfnmadd132ps zmm0, zmm1, zmm2, {rz-sae}  # case=3291-14 row=3291 expected=reach
vfnmadd132ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3291-15 row=3291 expected=reach
vfnmadd213ps zmm0, zmm1, zmm2, {rn-sae}  # case=3292-8 row=3292 expected=reach
vfnmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3292-9 row=3292 expected=reach
vfnmadd213ps zmm0, zmm1, zmm2, {rd-sae}  # case=3292-10 row=3292 expected=reach
vfnmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3292-11 row=3292 expected=reach
vfnmadd213ps zmm0, zmm1, zmm2, {ru-sae}  # case=3292-12 row=3292 expected=reach
vfnmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3292-13 row=3292 expected=reach
vfnmadd213ps zmm0, zmm1, zmm2, {rz-sae}  # case=3292-14 row=3292 expected=reach
vfnmadd213ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3292-15 row=3292 expected=reach
vfnmadd231ps zmm0, zmm1, zmm2, {rn-sae}  # case=3293-8 row=3293 expected=reach
vfnmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3293-9 row=3293 expected=reach
vfnmadd231ps zmm0, zmm1, zmm2, {rd-sae}  # case=3293-10 row=3293 expected=reach
vfnmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3293-11 row=3293 expected=reach
vfnmadd231ps zmm0, zmm1, zmm2, {ru-sae}  # case=3293-12 row=3293 expected=reach
vfnmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3293-13 row=3293 expected=reach
vfnmadd231ps zmm0, zmm1, zmm2, {rz-sae}  # case=3293-14 row=3293 expected=reach
vfnmadd231ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3293-15 row=3293 expected=reach
vfnmadd132sd xmm0, xmm1, xmm2, {rn-sae}  # case=3297-6 row=3297 expected=reach
vfnmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3297-7 row=3297 expected=reach
vfnmadd132sd xmm0, xmm1, xmm2, {rd-sae}  # case=3297-8 row=3297 expected=reach
vfnmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3297-9 row=3297 expected=reach
vfnmadd132sd xmm0, xmm1, xmm2, {ru-sae}  # case=3297-10 row=3297 expected=reach
vfnmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3297-11 row=3297 expected=reach
vfnmadd132sd xmm0, xmm1, xmm2, {rz-sae}  # case=3297-12 row=3297 expected=reach
vfnmadd132sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3297-13 row=3297 expected=reach
vfnmadd213sd xmm0, xmm1, xmm2, {rn-sae}  # case=3298-6 row=3298 expected=reach
vfnmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3298-7 row=3298 expected=reach
vfnmadd213sd xmm0, xmm1, xmm2, {rd-sae}  # case=3298-8 row=3298 expected=reach
vfnmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3298-9 row=3298 expected=reach
vfnmadd213sd xmm0, xmm1, xmm2, {ru-sae}  # case=3298-10 row=3298 expected=reach
vfnmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3298-11 row=3298 expected=reach
vfnmadd213sd xmm0, xmm1, xmm2, {rz-sae}  # case=3298-12 row=3298 expected=reach
vfnmadd213sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3298-13 row=3298 expected=reach
vfnmadd231sd xmm0, xmm1, xmm2, {rn-sae}  # case=3299-6 row=3299 expected=reach
vfnmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3299-7 row=3299 expected=reach
vfnmadd231sd xmm0, xmm1, xmm2, {rd-sae}  # case=3299-8 row=3299 expected=reach
vfnmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3299-9 row=3299 expected=reach
vfnmadd231sd xmm0, xmm1, xmm2, {ru-sae}  # case=3299-10 row=3299 expected=reach
vfnmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3299-11 row=3299 expected=reach
vfnmadd231sd xmm0, xmm1, xmm2, {rz-sae}  # case=3299-12 row=3299 expected=reach
vfnmadd231sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3299-13 row=3299 expected=reach
vfnmadd132ss xmm0, xmm1, xmm2, {rn-sae}  # case=3303-6 row=3303 expected=reach
vfnmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3303-7 row=3303 expected=reach
vfnmadd132ss xmm0, xmm1, xmm2, {rd-sae}  # case=3303-8 row=3303 expected=reach
vfnmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3303-9 row=3303 expected=reach
vfnmadd132ss xmm0, xmm1, xmm2, {ru-sae}  # case=3303-10 row=3303 expected=reach
vfnmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3303-11 row=3303 expected=reach
vfnmadd132ss xmm0, xmm1, xmm2, {rz-sae}  # case=3303-12 row=3303 expected=reach
vfnmadd132ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3303-13 row=3303 expected=reach
vfnmadd213ss xmm0, xmm1, xmm2, {rn-sae}  # case=3304-6 row=3304 expected=reach
vfnmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3304-7 row=3304 expected=reach
vfnmadd213ss xmm0, xmm1, xmm2, {rd-sae}  # case=3304-8 row=3304 expected=reach
vfnmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3304-9 row=3304 expected=reach
vfnmadd213ss xmm0, xmm1, xmm2, {ru-sae}  # case=3304-10 row=3304 expected=reach
vfnmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3304-11 row=3304 expected=reach
vfnmadd213ss xmm0, xmm1, xmm2, {rz-sae}  # case=3304-12 row=3304 expected=reach
vfnmadd213ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3304-13 row=3304 expected=reach
vfnmadd231ss xmm0, xmm1, xmm2, {rn-sae}  # case=3305-6 row=3305 expected=reach
vfnmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3305-7 row=3305 expected=reach
vfnmadd231ss xmm0, xmm1, xmm2, {rd-sae}  # case=3305-8 row=3305 expected=reach
vfnmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3305-9 row=3305 expected=reach
vfnmadd231ss xmm0, xmm1, xmm2, {ru-sae}  # case=3305-10 row=3305 expected=reach
vfnmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3305-11 row=3305 expected=reach
vfnmadd231ss xmm0, xmm1, xmm2, {rz-sae}  # case=3305-12 row=3305 expected=reach
vfnmadd231ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3305-13 row=3305 expected=reach
vfnmsub132pd zmm0, zmm1, zmm2, {rn-sae}  # case=3318-8 row=3318 expected=reach
vfnmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3318-9 row=3318 expected=reach
vfnmsub132pd zmm0, zmm1, zmm2, {rd-sae}  # case=3318-10 row=3318 expected=reach
vfnmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3318-11 row=3318 expected=reach
vfnmsub132pd zmm0, zmm1, zmm2, {ru-sae}  # case=3318-12 row=3318 expected=reach
vfnmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3318-13 row=3318 expected=reach
vfnmsub132pd zmm0, zmm1, zmm2, {rz-sae}  # case=3318-14 row=3318 expected=reach
vfnmsub132pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3318-15 row=3318 expected=reach
vfnmsub213pd zmm0, zmm1, zmm2, {rn-sae}  # case=3319-8 row=3319 expected=reach
vfnmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3319-9 row=3319 expected=reach
vfnmsub213pd zmm0, zmm1, zmm2, {rd-sae}  # case=3319-10 row=3319 expected=reach
vfnmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3319-11 row=3319 expected=reach
vfnmsub213pd zmm0, zmm1, zmm2, {ru-sae}  # case=3319-12 row=3319 expected=reach
vfnmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3319-13 row=3319 expected=reach
vfnmsub213pd zmm0, zmm1, zmm2, {rz-sae}  # case=3319-14 row=3319 expected=reach
vfnmsub213pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3319-15 row=3319 expected=reach
vfnmsub231pd zmm0, zmm1, zmm2, {rn-sae}  # case=3320-8 row=3320 expected=reach
vfnmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3320-9 row=3320 expected=reach
vfnmsub231pd zmm0, zmm1, zmm2, {rd-sae}  # case=3320-10 row=3320 expected=reach
vfnmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3320-11 row=3320 expected=reach
vfnmsub231pd zmm0, zmm1, zmm2, {ru-sae}  # case=3320-12 row=3320 expected=reach
vfnmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3320-13 row=3320 expected=reach
vfnmsub231pd zmm0, zmm1, zmm2, {rz-sae}  # case=3320-14 row=3320 expected=reach
vfnmsub231pd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3320-15 row=3320 expected=reach
vfnmsub132ps zmm0, zmm1, zmm2, {rn-sae}  # case=3333-8 row=3333 expected=reach
vfnmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3333-9 row=3333 expected=reach
vfnmsub132ps zmm0, zmm1, zmm2, {rd-sae}  # case=3333-10 row=3333 expected=reach
vfnmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3333-11 row=3333 expected=reach
vfnmsub132ps zmm0, zmm1, zmm2, {ru-sae}  # case=3333-12 row=3333 expected=reach
vfnmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3333-13 row=3333 expected=reach
vfnmsub132ps zmm0, zmm1, zmm2, {rz-sae}  # case=3333-14 row=3333 expected=reach
vfnmsub132ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3333-15 row=3333 expected=reach
vfnmsub213ps zmm0, zmm1, zmm2, {rn-sae}  # case=3334-8 row=3334 expected=reach
vfnmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3334-9 row=3334 expected=reach
vfnmsub213ps zmm0, zmm1, zmm2, {rd-sae}  # case=3334-10 row=3334 expected=reach
vfnmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3334-11 row=3334 expected=reach
vfnmsub213ps zmm0, zmm1, zmm2, {ru-sae}  # case=3334-12 row=3334 expected=reach
vfnmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3334-13 row=3334 expected=reach
vfnmsub213ps zmm0, zmm1, zmm2, {rz-sae}  # case=3334-14 row=3334 expected=reach
vfnmsub213ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3334-15 row=3334 expected=reach
vfnmsub231ps zmm0, zmm1, zmm2, {rn-sae}  # case=3335-8 row=3335 expected=reach
vfnmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3335-9 row=3335 expected=reach
vfnmsub231ps zmm0, zmm1, zmm2, {rd-sae}  # case=3335-10 row=3335 expected=reach
vfnmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3335-11 row=3335 expected=reach
vfnmsub231ps zmm0, zmm1, zmm2, {ru-sae}  # case=3335-12 row=3335 expected=reach
vfnmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3335-13 row=3335 expected=reach
vfnmsub231ps zmm0, zmm1, zmm2, {rz-sae}  # case=3335-14 row=3335 expected=reach
vfnmsub231ps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3335-15 row=3335 expected=reach
vfnmsub132sd xmm0, xmm1, xmm2, {rn-sae}  # case=3339-6 row=3339 expected=reach
vfnmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3339-7 row=3339 expected=reach
vfnmsub132sd xmm0, xmm1, xmm2, {rd-sae}  # case=3339-8 row=3339 expected=reach
vfnmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3339-9 row=3339 expected=reach
vfnmsub132sd xmm0, xmm1, xmm2, {ru-sae}  # case=3339-10 row=3339 expected=reach
vfnmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3339-11 row=3339 expected=reach
vfnmsub132sd xmm0, xmm1, xmm2, {rz-sae}  # case=3339-12 row=3339 expected=reach
vfnmsub132sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3339-13 row=3339 expected=reach
vfnmsub213sd xmm0, xmm1, xmm2, {rn-sae}  # case=3340-6 row=3340 expected=reach
vfnmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3340-7 row=3340 expected=reach
vfnmsub213sd xmm0, xmm1, xmm2, {rd-sae}  # case=3340-8 row=3340 expected=reach
vfnmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3340-9 row=3340 expected=reach
vfnmsub213sd xmm0, xmm1, xmm2, {ru-sae}  # case=3340-10 row=3340 expected=reach
vfnmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3340-11 row=3340 expected=reach
vfnmsub213sd xmm0, xmm1, xmm2, {rz-sae}  # case=3340-12 row=3340 expected=reach
vfnmsub213sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3340-13 row=3340 expected=reach
vfnmsub231sd xmm0, xmm1, xmm2, {rn-sae}  # case=3341-6 row=3341 expected=reach
vfnmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3341-7 row=3341 expected=reach
vfnmsub231sd xmm0, xmm1, xmm2, {rd-sae}  # case=3341-8 row=3341 expected=reach
vfnmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3341-9 row=3341 expected=reach
vfnmsub231sd xmm0, xmm1, xmm2, {ru-sae}  # case=3341-10 row=3341 expected=reach
vfnmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3341-11 row=3341 expected=reach
vfnmsub231sd xmm0, xmm1, xmm2, {rz-sae}  # case=3341-12 row=3341 expected=reach
vfnmsub231sd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3341-13 row=3341 expected=reach
vfnmsub132ss xmm0, xmm1, xmm2, {rn-sae}  # case=3345-6 row=3345 expected=reach
vfnmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3345-7 row=3345 expected=reach
vfnmsub132ss xmm0, xmm1, xmm2, {rd-sae}  # case=3345-8 row=3345 expected=reach
vfnmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3345-9 row=3345 expected=reach
vfnmsub132ss xmm0, xmm1, xmm2, {ru-sae}  # case=3345-10 row=3345 expected=reach
vfnmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3345-11 row=3345 expected=reach
vfnmsub132ss xmm0, xmm1, xmm2, {rz-sae}  # case=3345-12 row=3345 expected=reach
vfnmsub132ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3345-13 row=3345 expected=reach
vfnmsub213ss xmm0, xmm1, xmm2, {rn-sae}  # case=3346-6 row=3346 expected=reach
vfnmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3346-7 row=3346 expected=reach
vfnmsub213ss xmm0, xmm1, xmm2, {rd-sae}  # case=3346-8 row=3346 expected=reach
vfnmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3346-9 row=3346 expected=reach
vfnmsub213ss xmm0, xmm1, xmm2, {ru-sae}  # case=3346-10 row=3346 expected=reach
vfnmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3346-11 row=3346 expected=reach
vfnmsub213ss xmm0, xmm1, xmm2, {rz-sae}  # case=3346-12 row=3346 expected=reach
vfnmsub213ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3346-13 row=3346 expected=reach
vfnmsub231ss xmm0, xmm1, xmm2, {rn-sae}  # case=3347-6 row=3347 expected=reach
vfnmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3347-7 row=3347 expected=reach
vfnmsub231ss xmm0, xmm1, xmm2, {rd-sae}  # case=3347-8 row=3347 expected=reach
vfnmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3347-9 row=3347 expected=reach
vfnmsub231ss xmm0, xmm1, xmm2, {ru-sae}  # case=3347-10 row=3347 expected=reach
vfnmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3347-11 row=3347 expected=reach
vfnmsub231ss xmm0, xmm1, xmm2, {rz-sae}  # case=3347-12 row=3347 expected=reach
vfnmsub231ss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3347-13 row=3347 expected=reach
vgetexppd zmm0, zmm1, {sae}  # case=3382-8 row=3382 expected=reach
vgetexppd zmm0 {k1}{z}, zmm1, {sae}  # case=3382-9 row=3382 expected=reach
vgetexpph zmm0, zmm1, {sae}  # case=3385-8 row=3385 expected=reach
vgetexpph zmm0 {k1}{z}, zmm1, {sae}  # case=3385-9 row=3385 expected=reach
vgetexpps zmm0, zmm1, {sae}  # case=3388-8 row=3388 expected=reach
vgetexpps zmm0 {k1}{z}, zmm1, {sae}  # case=3388-9 row=3388 expected=reach
vgetexpsd xmm0, xmm1, xmm2, {sae}  # case=3389-6 row=3389 expected=reach
vgetexpsd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=3389-7 row=3389 expected=reach
vgetexpsh xmm0, xmm1, xmm2, {sae}  # case=3390-6 row=3390 expected=reach
vgetexpsh xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=3390-7 row=3390 expected=reach
vgetexpss xmm0, xmm1, xmm2, {sae}  # case=3391-6 row=3391 expected=reach
vgetexpss xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=3391-7 row=3391 expected=reach
vgetmantpd zmm0, zmm1, {sae}, 0x12  # case=3394-9 row=3394 expected=reach
vgetmantpd zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=3394-10 row=3394 expected=reach
vgetmantph zmm0, zmm1, {sae}, 0x12  # case=3397-9 row=3397 expected=reach
vgetmantph zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=3397-10 row=3397 expected=reach
vgetmantps zmm0, zmm1, {sae}, 0x12  # case=3400-9 row=3400 expected=reach
vgetmantps zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=3400-10 row=3400 expected=reach
vgetmantsd xmm0, xmm1, xmm2, {sae}, 0x12  # case=3401-7 row=3401 expected=reach
vgetmantsd xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3401-8 row=3401 expected=reach
vgetmantsh xmm0, xmm1, xmm2, {sae}, 0x12  # case=3402-7 row=3402 expected=reach
vgetmantsh xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3402-8 row=3402 expected=reach
vgetmantss xmm0, xmm1, xmm2, {sae}, 0x12  # case=3403-7 row=3403 expected=reach
vgetmantss xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3403-8 row=3403 expected=reach
vmaxph zmm0, zmm1, zmm2, {sae}  # case=3428-8 row=3428 expected=reach
vmaxph zmm0 {k1}{z}, zmm1, zmm2, {sae}  # case=3428-9 row=3428 expected=reach
vmaxsh xmm0, xmm1, xmm2, {sae}  # case=3429-6 row=3429 expected=reach
vmaxsh xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=3429-7 row=3429 expected=reach
vminph zmm0, zmm1, zmm2, {sae}  # case=3432-8 row=3432 expected=reach
vminph zmm0 {k1}{z}, zmm1, zmm2, {sae}  # case=3432-9 row=3432 expected=reach
vminsh xmm0, xmm1, xmm2, {sae}  # case=3433-6 row=3433 expected=reach
vminsh xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=3433-7 row=3433 expected=reach
vmulph zmm0, zmm1, zmm2, {rn-sae}  # case=3442-8 row=3442 expected=reach
vmulph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=3442-9 row=3442 expected=reach
vmulph zmm0, zmm1, zmm2, {rd-sae}  # case=3442-10 row=3442 expected=reach
vmulph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=3442-11 row=3442 expected=reach
vmulph zmm0, zmm1, zmm2, {ru-sae}  # case=3442-12 row=3442 expected=reach
vmulph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=3442-13 row=3442 expected=reach
vmulph zmm0, zmm1, zmm2, {rz-sae}  # case=3442-14 row=3442 expected=reach
vmulph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=3442-15 row=3442 expected=reach
vmulsh xmm0, xmm1, xmm2, {rn-sae}  # case=3443-6 row=3443 expected=reach
vmulsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=3443-7 row=3443 expected=reach
vmulsh xmm0, xmm1, xmm2, {rd-sae}  # case=3443-8 row=3443 expected=reach
vmulsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=3443-9 row=3443 expected=reach
vmulsh xmm0, xmm1, xmm2, {ru-sae}  # case=3443-10 row=3443 expected=reach
vmulsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=3443-11 row=3443 expected=reach
vmulsh xmm0, xmm1, xmm2, {rz-sae}  # case=3443-12 row=3443 expected=reach
vmulsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=3443-13 row=3443 expected=reach
vrangepd zmm0, zmm1, zmm2, {sae}, 0x12  # case=3983-9 row=3983 expected=reach
vrangepd zmm0 {k1}{z}, zmm1, zmm2, {sae}, 0x12  # case=3983-10 row=3983 expected=reach
vrangeps zmm0, zmm1, zmm2, {sae}, 0x12  # case=3986-9 row=3986 expected=reach
vrangeps zmm0 {k1}{z}, zmm1, zmm2, {sae}, 0x12  # case=3986-10 row=3986 expected=reach
vrangesd xmm0, xmm1, xmm2, {sae}, 0x12  # case=3987-7 row=3987 expected=reach
vrangesd xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3987-8 row=3987 expected=reach
vrangess xmm0, xmm1, xmm2, {sae}, 0x12  # case=3988-7 row=3988 expected=reach
vrangess xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=3988-8 row=3988 expected=reach
vreducepd zmm0, zmm1, {sae}, 0x12  # case=4003-9 row=4003 expected=reach
vreducepd zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=4003-10 row=4003 expected=reach
vreduceph zmm0, zmm1, {sae}, 0x12  # case=4006-9 row=4006 expected=reach
vreduceph zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=4006-10 row=4006 expected=reach
vreduceps zmm0, zmm1, {sae}, 0x12  # case=4009-9 row=4009 expected=reach
vreduceps zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=4009-10 row=4009 expected=reach
vreducesd xmm0, xmm1, xmm2, {sae}, 0x12  # case=4010-7 row=4010 expected=reach
vreducesd xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=4010-8 row=4010 expected=reach
vreducesh xmm0, xmm1, xmm2, {sae}, 0x12  # case=4011-7 row=4011 expected=reach
vreducesh xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=4011-8 row=4011 expected=reach
vreducess xmm0, xmm1, xmm2, {sae}, 0x12  # case=4012-7 row=4012 expected=reach
vreducess xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=4012-8 row=4012 expected=reach
vrndscalepd zmm0, zmm1, {sae}, 0x12  # case=4015-9 row=4015 expected=reach
vrndscalepd zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=4015-10 row=4015 expected=reach
vrndscaleph zmm0, zmm1, {sae}, 0x12  # case=4018-9 row=4018 expected=reach
vrndscaleph zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=4018-10 row=4018 expected=reach
vrndscaleps zmm0, zmm1, {sae}, 0x12  # case=4021-9 row=4021 expected=reach
vrndscaleps zmm0 {k1}{z}, zmm1, {sae}, 0x12  # case=4021-10 row=4021 expected=reach
vrndscalesd xmm0, xmm1, xmm2, {sae}, 0x12  # case=4022-7 row=4022 expected=reach
vrndscalesd xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=4022-8 row=4022 expected=reach
vrndscalesh xmm0, xmm1, xmm2, {sae}, 0x12  # case=4023-7 row=4023 expected=reach
vrndscalesh xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=4023-8 row=4023 expected=reach
vrndscaless xmm0, xmm1, xmm2, {sae}, 0x12  # case=4024-7 row=4024 expected=reach
vrndscaless xmm0 {k1}{z}, xmm1, xmm2, {sae}, 0x12  # case=4024-8 row=4024 expected=reach
vscalefpd zmm0, zmm1, zmm2, {rn-sae}  # case=4039-8 row=4039 expected=reach
vscalefpd zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=4039-9 row=4039 expected=reach
vscalefpd zmm0, zmm1, zmm2, {rd-sae}  # case=4039-10 row=4039 expected=reach
vscalefpd zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=4039-11 row=4039 expected=reach
vscalefpd zmm0, zmm1, zmm2, {ru-sae}  # case=4039-12 row=4039 expected=reach
vscalefpd zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=4039-13 row=4039 expected=reach
vscalefpd zmm0, zmm1, zmm2, {rz-sae}  # case=4039-14 row=4039 expected=reach
vscalefpd zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=4039-15 row=4039 expected=reach
vscalefph zmm0, zmm1, zmm2, {rn-sae}  # case=4042-8 row=4042 expected=reach
vscalefph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=4042-9 row=4042 expected=reach
vscalefph zmm0, zmm1, zmm2, {rd-sae}  # case=4042-10 row=4042 expected=reach
vscalefph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=4042-11 row=4042 expected=reach
vscalefph zmm0, zmm1, zmm2, {ru-sae}  # case=4042-12 row=4042 expected=reach
vscalefph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=4042-13 row=4042 expected=reach
vscalefph zmm0, zmm1, zmm2, {rz-sae}  # case=4042-14 row=4042 expected=reach
vscalefph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=4042-15 row=4042 expected=reach
vscalefps zmm0, zmm1, zmm2, {rn-sae}  # case=4045-8 row=4045 expected=reach
vscalefps zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=4045-9 row=4045 expected=reach
vscalefps zmm0, zmm1, zmm2, {rd-sae}  # case=4045-10 row=4045 expected=reach
vscalefps zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=4045-11 row=4045 expected=reach
vscalefps zmm0, zmm1, zmm2, {ru-sae}  # case=4045-12 row=4045 expected=reach
vscalefps zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=4045-13 row=4045 expected=reach
vscalefps zmm0, zmm1, zmm2, {rz-sae}  # case=4045-14 row=4045 expected=reach
vscalefps zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=4045-15 row=4045 expected=reach
vscalefsd xmm0, xmm1, xmm2, {rn-sae}  # case=4046-6 row=4046 expected=reach
vscalefsd xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=4046-7 row=4046 expected=reach
vscalefsd xmm0, xmm1, xmm2, {rd-sae}  # case=4046-8 row=4046 expected=reach
vscalefsd xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=4046-9 row=4046 expected=reach
vscalefsd xmm0, xmm1, xmm2, {ru-sae}  # case=4046-10 row=4046 expected=reach
vscalefsd xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=4046-11 row=4046 expected=reach
vscalefsd xmm0, xmm1, xmm2, {rz-sae}  # case=4046-12 row=4046 expected=reach
vscalefsd xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=4046-13 row=4046 expected=reach
vscalefsh xmm0, xmm1, xmm2, {rn-sae}  # case=4047-6 row=4047 expected=reach
vscalefsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=4047-7 row=4047 expected=reach
vscalefsh xmm0, xmm1, xmm2, {rd-sae}  # case=4047-8 row=4047 expected=reach
vscalefsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=4047-9 row=4047 expected=reach
vscalefsh xmm0, xmm1, xmm2, {ru-sae}  # case=4047-10 row=4047 expected=reach
vscalefsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=4047-11 row=4047 expected=reach
vscalefsh xmm0, xmm1, xmm2, {rz-sae}  # case=4047-12 row=4047 expected=reach
vscalefsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=4047-13 row=4047 expected=reach
vscalefss xmm0, xmm1, xmm2, {rn-sae}  # case=4048-6 row=4048 expected=reach
vscalefss xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=4048-7 row=4048 expected=reach
vscalefss xmm0, xmm1, xmm2, {rd-sae}  # case=4048-8 row=4048 expected=reach
vscalefss xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=4048-9 row=4048 expected=reach
vscalefss xmm0, xmm1, xmm2, {ru-sae}  # case=4048-10 row=4048 expected=reach
vscalefss xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=4048-11 row=4048 expected=reach
vscalefss xmm0, xmm1, xmm2, {rz-sae}  # case=4048-12 row=4048 expected=reach
vscalefss xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=4048-13 row=4048 expected=reach
vsqrtph zmm0, zmm1, {rn-sae}  # case=4081-8 row=4081 expected=reach
vsqrtph zmm0 {k1}{z}, zmm1, {rn-sae}  # case=4081-9 row=4081 expected=reach
vsqrtph zmm0, zmm1, {rd-sae}  # case=4081-10 row=4081 expected=reach
vsqrtph zmm0 {k1}{z}, zmm1, {rd-sae}  # case=4081-11 row=4081 expected=reach
vsqrtph zmm0, zmm1, {ru-sae}  # case=4081-12 row=4081 expected=reach
vsqrtph zmm0 {k1}{z}, zmm1, {ru-sae}  # case=4081-13 row=4081 expected=reach
vsqrtph zmm0, zmm1, {rz-sae}  # case=4081-14 row=4081 expected=reach
vsqrtph zmm0 {k1}{z}, zmm1, {rz-sae}  # case=4081-15 row=4081 expected=reach
vsqrtsh xmm0, xmm1, xmm2, {rn-sae}  # case=4082-6 row=4082 expected=reach
vsqrtsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=4082-7 row=4082 expected=reach
vsqrtsh xmm0, xmm1, xmm2, {rd-sae}  # case=4082-8 row=4082 expected=reach
vsqrtsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=4082-9 row=4082 expected=reach
vsqrtsh xmm0, xmm1, xmm2, {ru-sae}  # case=4082-10 row=4082 expected=reach
vsqrtsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=4082-11 row=4082 expected=reach
vsqrtsh xmm0, xmm1, xmm2, {rz-sae}  # case=4082-12 row=4082 expected=reach
vsqrtsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=4082-13 row=4082 expected=reach
vsubph zmm0, zmm1, zmm2, {rn-sae}  # case=4085-8 row=4085 expected=reach
vsubph zmm0 {k1}{z}, zmm1, zmm2, {rn-sae}  # case=4085-9 row=4085 expected=reach
vsubph zmm0, zmm1, zmm2, {rd-sae}  # case=4085-10 row=4085 expected=reach
vsubph zmm0 {k1}{z}, zmm1, zmm2, {rd-sae}  # case=4085-11 row=4085 expected=reach
vsubph zmm0, zmm1, zmm2, {ru-sae}  # case=4085-12 row=4085 expected=reach
vsubph zmm0 {k1}{z}, zmm1, zmm2, {ru-sae}  # case=4085-13 row=4085 expected=reach
vsubph zmm0, zmm1, zmm2, {rz-sae}  # case=4085-14 row=4085 expected=reach
vsubph zmm0 {k1}{z}, zmm1, zmm2, {rz-sae}  # case=4085-15 row=4085 expected=reach
vsubsh xmm0, xmm1, xmm2, {rn-sae}  # case=4086-6 row=4086 expected=reach
vsubsh xmm0 {k1}{z}, xmm1, xmm2, {rn-sae}  # case=4086-7 row=4086 expected=reach
vsubsh xmm0, xmm1, xmm2, {rd-sae}  # case=4086-8 row=4086 expected=reach
vsubsh xmm0 {k1}{z}, xmm1, xmm2, {rd-sae}  # case=4086-9 row=4086 expected=reach
vsubsh xmm0, xmm1, xmm2, {ru-sae}  # case=4086-10 row=4086 expected=reach
vsubsh xmm0 {k1}{z}, xmm1, xmm2, {ru-sae}  # case=4086-11 row=4086 expected=reach
vsubsh xmm0, xmm1, xmm2, {rz-sae}  # case=4086-12 row=4086 expected=reach
vsubsh xmm0 {k1}{z}, xmm1, xmm2, {rz-sae}  # case=4086-13 row=4086 expected=reach
vucomish xmm0, xmm1, {sae}  # case=4091-4 row=4091 expected=reach
vexp2pd zmm0, zmm1, {sae}  # case=4191-8 row=4191 expected=reach
vexp2pd zmm0 {k1}{z}, zmm1, {sae}  # case=4191-9 row=4191 expected=reach
vexp2ps zmm0, zmm1, {sae}  # case=4192-8 row=4192 expected=reach
vexp2ps zmm0 {k1}{z}, zmm1, {sae}  # case=4192-9 row=4192 expected=reach
vrcp28pd zmm0, zmm1, {sae}  # case=4203-8 row=4203 expected=reach
vrcp28pd zmm0 {k1}{z}, zmm1, {sae}  # case=4203-9 row=4203 expected=reach
vrcp28sd xmm0, xmm1, xmm2, {sae}  # case=4204-6 row=4204 expected=reach
vrcp28sd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=4204-7 row=4204 expected=reach
vrcp28ps zmm0, zmm1, {sae}  # case=4205-8 row=4205 expected=reach
vrcp28ps zmm0 {k1}{z}, zmm1, {sae}  # case=4205-9 row=4205 expected=reach
vrcp28ss xmm0, xmm1, xmm2, {sae}  # case=4206-6 row=4206 expected=reach
vrcp28ss xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=4206-7 row=4206 expected=reach
vrsqrt28pd zmm0, zmm1, {sae}  # case=4207-8 row=4207 expected=reach
vrsqrt28pd zmm0 {k1}{z}, zmm1, {sae}  # case=4207-9 row=4207 expected=reach
vrsqrt28sd xmm0, xmm1, xmm2, {sae}  # case=4208-6 row=4208 expected=reach
vrsqrt28sd xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=4208-7 row=4208 expected=reach
vrsqrt28ps zmm0, zmm1, {sae}  # case=4209-8 row=4209 expected=reach
vrsqrt28ps zmm0 {k1}{z}, zmm1, {sae}  # case=4209-9 row=4209 expected=reach
vrsqrt28ss xmm0, xmm1, xmm2, {sae}  # case=4210-6 row=4210 expected=reach
vrsqrt28ss xmm0 {k1}{z}, xmm1, xmm2, {sae}  # case=4210-7 row=4210 expected=reach
