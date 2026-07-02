.intel_syntax noprefix
// Stage3 axis C (EVEX disp8*N boundary: C1 multiple / C2 disp32 / C3 max)

    vaddpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vaddpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vaddpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vaddpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vaddpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vaddpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vaddpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vaddpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vaddpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaddps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vaddps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vaddps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vaddps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vaddps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vaddps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vaddps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vaddps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vaddps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaddsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vaddsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vaddsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vaddss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vaddss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vaddss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vaesdec xmm1, xmm2, XMMWORD PTR [rax+0x10]
    vaesdec xmm1, xmm2, XMMWORD PTR [rax+0x8]
    vaesdec xmm1, xmm2, XMMWORD PTR [rax+0x7f0]
    vaesdec ymm1, ymm2, YMMWORD PTR [rax+0x20]
    vaesdec ymm1, ymm2, YMMWORD PTR [rax+0x10]
    vaesdec ymm1, ymm2, YMMWORD PTR [rax+0xfe0]
    vaesdec zmm1, zmm2, ZMMWORD PTR [rax+0x40]
    vaesdec zmm1, zmm2, ZMMWORD PTR [rax+0x20]
    vaesdec zmm1, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaesdeclast xmm1, xmm2, XMMWORD PTR [rax+0x10]
    vaesdeclast xmm1, xmm2, XMMWORD PTR [rax+0x8]
    vaesdeclast xmm1, xmm2, XMMWORD PTR [rax+0x7f0]
    vaesdeclast ymm1, ymm2, YMMWORD PTR [rax+0x20]
    vaesdeclast ymm1, ymm2, YMMWORD PTR [rax+0x10]
    vaesdeclast ymm1, ymm2, YMMWORD PTR [rax+0xfe0]
    vaesdeclast zmm1, zmm2, ZMMWORD PTR [rax+0x40]
    vaesdeclast zmm1, zmm2, ZMMWORD PTR [rax+0x20]
    vaesdeclast zmm1, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaesenc xmm1, xmm2, XMMWORD PTR [rax+0x10]
    vaesenc xmm1, xmm2, XMMWORD PTR [rax+0x8]
    vaesenc xmm1, xmm2, XMMWORD PTR [rax+0x7f0]
    vaesenc ymm1, ymm2, YMMWORD PTR [rax+0x20]
    vaesenc ymm1, ymm2, YMMWORD PTR [rax+0x10]
    vaesenc ymm1, ymm2, YMMWORD PTR [rax+0xfe0]
    vaesenc zmm1, zmm2, ZMMWORD PTR [rax+0x40]
    vaesenc zmm1, zmm2, ZMMWORD PTR [rax+0x20]
    vaesenc zmm1, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaesenclast xmm1, xmm2, XMMWORD PTR [rax+0x10]
    vaesenclast xmm1, xmm2, XMMWORD PTR [rax+0x8]
    vaesenclast xmm1, xmm2, XMMWORD PTR [rax+0x7f0]
    vaesenclast ymm1, ymm2, YMMWORD PTR [rax+0x20]
    vaesenclast ymm1, ymm2, YMMWORD PTR [rax+0x10]
    vaesenclast ymm1, ymm2, YMMWORD PTR [rax+0xfe0]
    vaesenclast zmm1, zmm2, ZMMWORD PTR [rax+0x40]
    vaesenclast zmm1, zmm2, ZMMWORD PTR [rax+0x20]
    vaesenclast zmm1, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vandnpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vandnpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vandnpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vandnpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vandnpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vandnpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vandnpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vandnpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vandnpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vandnps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vandnps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vandnps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vandnps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vandnps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vandnps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vandnps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vandnps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vandnps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vandpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vandpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vandpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vandpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vandpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vandpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vandpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vandpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vandpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vandps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vandps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vandps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vandps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vandps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vandps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vandps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vandps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vandps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vcmppd k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vcmppd k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vcmppd k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vcmppd k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vcmppd k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vcmppd k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vcmppd k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vcmppd k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vcmppd k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vcmpps k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vcmpps k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vcmpps k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vcmpps k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vcmpps k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vcmpps k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vcmpps k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vcmpps k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vcmpps k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vcmpsd k1{k2}, xmm2, QWORD PTR [rax+0x8], 0x1
    vcmpsd k1{k2}, xmm2, QWORD PTR [rax+0x4], 0x1
    vcmpsd k1{k2}, xmm2, QWORD PTR [rax+0x3f8], 0x1
    vcmpss k1{k2}, xmm2, DWORD PTR [rax+0x4], 0x1
    vcmpss k1{k2}, xmm2, DWORD PTR [rax+0x2], 0x1
    vcmpss k1{k2}, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vcomisd xmm1, QWORD PTR [rax+0x8]
    vcomisd xmm1, QWORD PTR [rax+0x4]
    vcomisd xmm1, QWORD PTR [rax+0x3f8]
    vcomiss xmm1, DWORD PTR [rax+0x4]
    vcomiss xmm1, DWORD PTR [rax+0x2]
    vcomiss xmm1, DWORD PTR [rax+0x1fc]
    vcvtdq2pd xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtdq2pd xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtdq2pd xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtdq2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtdq2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtdq2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtdq2pd zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtdq2pd zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtdq2pd zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtdq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtdq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtdq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtdq2ps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtdq2ps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtdq2ps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtdq2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtdq2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtdq2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtpd2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtpd2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtpd2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtpd2dq xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtpd2dq xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtpd2dq xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtpd2dq ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtpd2dq ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtpd2dq ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtpd2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtpd2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtpd2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtpd2ps xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtpd2ps xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtpd2ps xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtpd2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtpd2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtpd2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtps2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtps2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtps2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtps2dq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtps2dq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtps2dq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtps2dq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtps2dq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtps2dq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtps2pd xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtps2pd xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtps2pd xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtps2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtps2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtps2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtps2pd zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtps2pd zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtps2pd zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtsd2si eax, QWORD PTR [rax+0x8]
    vcvtsd2si eax, QWORD PTR [rax+0x4]
    vcvtsd2si eax, QWORD PTR [rax+0x3f8]
    vcvtsd2si rax, QWORD PTR [rax+0x8]
    vcvtsd2si rax, QWORD PTR [rax+0x4]
    vcvtsd2si rax, QWORD PTR [rax+0x3f8]
    vcvtsd2ss xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vcvtsd2ss xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vcvtsd2ss xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax+0x4]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax+0x2]
    vcvtsi2sd xmm1, xmm2, DWORD PTR [rax+0x1fc]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax+0x8]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax+0x4]
    vcvtsi2sd xmm1, xmm2, QWORD PTR [rax+0x3f8]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax+0x4]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax+0x2]
    vcvtsi2ss xmm1, xmm2, DWORD PTR [rax+0x1fc]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax+0x8]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax+0x4]
    vcvtsi2ss xmm1, xmm2, QWORD PTR [rax+0x3f8]
    vcvtss2sd xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vcvtss2sd xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vcvtss2sd xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vcvtss2si eax, DWORD PTR [rax+0x4]
    vcvtss2si eax, DWORD PTR [rax+0x2]
    vcvtss2si eax, DWORD PTR [rax+0x1fc]
    vcvtss2si rax, DWORD PTR [rax+0x4]
    vcvtss2si rax, DWORD PTR [rax+0x2]
    vcvtss2si rax, DWORD PTR [rax+0x1fc]
    vcvttpd2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttpd2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttpd2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttpd2dq xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttpd2dq xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttpd2dq xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttpd2dq ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttpd2dq ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttpd2dq ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttps2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttps2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttps2dq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttps2dq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttps2dq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttps2dq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttps2dq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttps2dq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttps2dq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttsd2si eax, QWORD PTR [rax+0x8]
    vcvttsd2si eax, QWORD PTR [rax+0x4]
    vcvttsd2si eax, QWORD PTR [rax+0x3f8]
    vcvttsd2si rax, QWORD PTR [rax+0x8]
    vcvttsd2si rax, QWORD PTR [rax+0x4]
    vcvttsd2si rax, QWORD PTR [rax+0x3f8]
    vcvttss2si eax, DWORD PTR [rax+0x4]
    vcvttss2si eax, DWORD PTR [rax+0x2]
    vcvttss2si eax, DWORD PTR [rax+0x1fc]
    vcvttss2si rax, DWORD PTR [rax+0x4]
    vcvttss2si rax, DWORD PTR [rax+0x2]
    vcvttss2si rax, DWORD PTR [rax+0x1fc]
    vdivpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vdivpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vdivpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vdivpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vdivpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vdivpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vdivpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vdivpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vdivpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vdivps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vdivps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vdivps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vdivps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vdivps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vdivps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vdivps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vdivps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vdivps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vdivsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vdivsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vdivsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vdivss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vdivss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vdivss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vextractps DWORD PTR [rax+0x4], xmm1, 0x1
    vextractps DWORD PTR [rax+0x2], xmm1, 0x1
    vextractps DWORD PTR [rax+0x1fc], xmm1, 0x1
    vgf2p8affineinvqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vgf2p8affineinvqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vgf2p8affineinvqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vgf2p8affineinvqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vgf2p8affineinvqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vgf2p8affineinvqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vgf2p8affineinvqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vgf2p8affineinvqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vgf2p8affineinvqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vgf2p8affineqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vgf2p8affineqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vgf2p8affineqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vgf2p8affineqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vgf2p8affineqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vgf2p8affineqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vgf2p8affineqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vgf2p8affineqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vgf2p8affineqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vgf2p8mulb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vgf2p8mulb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vgf2p8mulb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vgf2p8mulb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vgf2p8mulb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vgf2p8mulb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vgf2p8mulb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vgf2p8mulb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vgf2p8mulb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vinsertps xmm1, xmm2, DWORD PTR [rax+0x4], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rax+0x2], 0x1
    vinsertps xmm1, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vmaxpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vmaxpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vmaxpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vmaxpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vmaxpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vmaxpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vmaxpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vmaxpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vmaxpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vmaxps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vmaxps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vmaxps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vmaxps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vmaxps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vmaxps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vmaxps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vmaxps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vmaxps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vmaxsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vmaxsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vmaxsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vmaxss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vmaxss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vmaxss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vminpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vminpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vminpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vminpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vminpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vminpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vminpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vminpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vminpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vminps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vminps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vminps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vminps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vminps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vminps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vminps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vminps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vminps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vminsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vminsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vminsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vminss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vminss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vminss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vmovapd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovapd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovapd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovapd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovapd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovapd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovapd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovapd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovapd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovapd XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovapd XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovapd XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovapd YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovapd YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovapd YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovapd ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovapd ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovapd ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovaps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovaps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovaps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovaps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovaps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovaps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovaps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovaps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovaps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovaps XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovaps XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovaps XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovaps YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovaps YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovaps YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovaps ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovaps ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovaps ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovddup xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vmovddup xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vmovddup xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vmovddup ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovddup ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovddup ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovddup zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovddup zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovddup zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovd xmm1, DWORD PTR [rax+0x4]
    vmovd xmm1, DWORD PTR [rax+0x2]
    vmovd xmm1, DWORD PTR [rax+0x1fc]
    vmovq xmm1, QWORD PTR [rax+0x8]
    vmovq xmm1, QWORD PTR [rax+0x4]
    vmovq xmm1, QWORD PTR [rax+0x3f8]
    vmovd DWORD PTR [rax+0x4], xmm1
    vmovd DWORD PTR [rax+0x2], xmm1
    vmovd DWORD PTR [rax+0x1fc], xmm1
    vmovq QWORD PTR [rax+0x8], xmm1
    vmovq QWORD PTR [rax+0x4], xmm1
    vmovq QWORD PTR [rax+0x3f8], xmm1
    vmovdqa32 xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovdqa32 xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovdqa32 xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovdqa32 ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovdqa32 ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovdqa32 ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovdqa32 zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovdqa32 zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovdqa32 zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovdqa32 XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovdqa32 XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovdqa32 XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovdqa32 YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovdqa32 YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovdqa32 YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovdqa32 ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovdqa32 ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovdqa32 ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovdqa64 xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovdqa64 xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovdqa64 xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovdqa64 ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovdqa64 ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovdqa64 ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovdqa64 zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovdqa64 zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovdqa64 zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovdqa64 XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovdqa64 XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovdqa64 XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovdqa64 YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovdqa64 YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovdqa64 YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovdqa64 ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovdqa64 ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovdqa64 ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovdqu8 xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovdqu8 xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovdqu8 xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovdqu8 ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovdqu8 ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovdqu8 ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovdqu8 zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovdqu8 zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovdqu8 zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovdqu8 XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovdqu8 XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovdqu8 XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovdqu8 YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovdqu8 YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovdqu8 YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovdqu8 ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovdqu8 ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovdqu8 ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovdqu16 xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovdqu16 xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovdqu16 xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovdqu16 ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovdqu16 ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovdqu16 ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovdqu16 zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovdqu16 zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovdqu16 zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovdqu16 XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovdqu16 XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovdqu16 XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovdqu16 YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovdqu16 YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovdqu16 YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovdqu16 ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovdqu16 ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovdqu16 ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovdqu32 ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovdqu32 ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovdqu32 ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovdqu32 zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovdqu32 zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovdqu32 zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovdqu32 XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovdqu32 XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovdqu32 XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovdqu32 YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovdqu32 YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovdqu32 YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovdqu32 ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovdqu32 ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovdqu32 ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovdqu64 xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovdqu64 xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovdqu64 xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovdqu64 ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovdqu64 ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovdqu64 ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovdqu64 zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovdqu64 zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovdqu64 zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovdqu64 XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovdqu64 XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovdqu64 XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovdqu64 YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovdqu64 YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovdqu64 YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovdqu64 ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovdqu64 ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovdqu64 ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovhpd xmm2, xmm1, QWORD PTR [rax+0x8]
    vmovhpd xmm2, xmm1, QWORD PTR [rax+0x4]
    vmovhpd xmm2, xmm1, QWORD PTR [rax+0x3f8]
    vmovhpd QWORD PTR [rax+0x8], xmm1
    vmovhpd QWORD PTR [rax+0x4], xmm1
    vmovhpd QWORD PTR [rax+0x3f8], xmm1
    vmovhps xmm2, xmm1, QWORD PTR [rax+0x8]
    vmovhps xmm2, xmm1, QWORD PTR [rax+0x4]
    vmovhps xmm2, xmm1, QWORD PTR [rax+0x3f8]
    vmovhps QWORD PTR [rax+0x8], xmm1
    vmovhps QWORD PTR [rax+0x4], xmm1
    vmovhps QWORD PTR [rax+0x3f8], xmm1
    vmovlpd xmm2, xmm1, QWORD PTR [rax+0x8]
    vmovlpd xmm2, xmm1, QWORD PTR [rax+0x4]
    vmovlpd xmm2, xmm1, QWORD PTR [rax+0x3f8]
    vmovlpd QWORD PTR [rax+0x8], xmm1
    vmovlpd QWORD PTR [rax+0x4], xmm1
    vmovlpd QWORD PTR [rax+0x3f8], xmm1
    vmovlps xmm2, xmm1, QWORD PTR [rax+0x8]
    vmovlps xmm2, xmm1, QWORD PTR [rax+0x4]
    vmovlps xmm2, xmm1, QWORD PTR [rax+0x3f8]
    vmovlps QWORD PTR [rax+0x8], xmm1
    vmovlps QWORD PTR [rax+0x4], xmm1
    vmovlps QWORD PTR [rax+0x3f8], xmm1
    vmovntdq XMMWORD PTR [rax+0x10], xmm1
    vmovntdq XMMWORD PTR [rax+0x8], xmm1
    vmovntdq XMMWORD PTR [rax+0x7f0], xmm1
    vmovntdq YMMWORD PTR [rax+0x20], ymm1
    vmovntdq YMMWORD PTR [rax+0x10], ymm1
    vmovntdq YMMWORD PTR [rax+0xfe0], ymm1
    vmovntdq ZMMWORD PTR [rax+0x40], zmm1
    vmovntdq ZMMWORD PTR [rax+0x20], zmm1
    vmovntdq ZMMWORD PTR [rax+0x1fc0], zmm1
    vmovntdqa xmm1, XMMWORD PTR [rax+0x10]
    vmovntdqa xmm1, XMMWORD PTR [rax+0x8]
    vmovntdqa xmm1, XMMWORD PTR [rax+0x7f0]
    vmovntdqa ymm1, YMMWORD PTR [rax+0x20]
    vmovntdqa ymm1, YMMWORD PTR [rax+0x10]
    vmovntdqa ymm1, YMMWORD PTR [rax+0xfe0]
    vmovntdqa zmm1, ZMMWORD PTR [rax+0x40]
    vmovntdqa zmm1, ZMMWORD PTR [rax+0x20]
    vmovntdqa zmm1, ZMMWORD PTR [rax+0x1fc0]
    vmovntpd XMMWORD PTR [rax+0x10], xmm1
    vmovntpd XMMWORD PTR [rax+0x8], xmm1
    vmovntpd XMMWORD PTR [rax+0x7f0], xmm1
    vmovntpd YMMWORD PTR [rax+0x20], ymm1
    vmovntpd YMMWORD PTR [rax+0x10], ymm1
    vmovntpd YMMWORD PTR [rax+0xfe0], ymm1
    vmovntpd ZMMWORD PTR [rax+0x40], zmm1
    vmovntpd ZMMWORD PTR [rax+0x20], zmm1
    vmovntpd ZMMWORD PTR [rax+0x1fc0], zmm1
    vmovntps XMMWORD PTR [rax+0x10], xmm1
    vmovntps XMMWORD PTR [rax+0x8], xmm1
    vmovntps XMMWORD PTR [rax+0x7f0], xmm1
    vmovntps YMMWORD PTR [rax+0x20], ymm1
    vmovntps YMMWORD PTR [rax+0x10], ymm1
    vmovntps YMMWORD PTR [rax+0xfe0], ymm1
    vmovntps ZMMWORD PTR [rax+0x40], zmm1
    vmovntps ZMMWORD PTR [rax+0x20], zmm1
    vmovntps ZMMWORD PTR [rax+0x1fc0], zmm1
    vmovq QWORD PTR [rax+0x8], xmm2
    vmovq QWORD PTR [rax+0x4], xmm2
    vmovq QWORD PTR [rax+0x3f8], xmm2
    vmovsd xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vmovsd xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vmovsd xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vmovsd QWORD PTR [rax+0x8]{k1}, xmm1
    vmovsd QWORD PTR [rax+0x4]{k1}, xmm1
    vmovsd QWORD PTR [rax+0x3f8]{k1}, xmm1
    vmovshdup xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovshdup xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovshdup xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovshdup ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovshdup ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovshdup ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovshdup zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovshdup zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovshdup zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovsldup xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovsldup xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovsldup xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovsldup ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovsldup ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovsldup ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovsldup zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovsldup zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovsldup zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovss xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vmovss xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vmovss xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vmovss DWORD PTR [rax+0x4]{k1}, xmm1
    vmovss DWORD PTR [rax+0x2]{k1}, xmm1
    vmovss DWORD PTR [rax+0x1fc]{k1}, xmm1
    vmovupd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovupd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovupd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovupd XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovupd XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovupd XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovupd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovupd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovupd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovupd YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovupd YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovupd YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovupd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovupd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovupd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovupd ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovupd ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovupd ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmovups xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vmovups xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vmovups xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vmovups ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vmovups ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vmovups ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vmovups zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vmovups zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vmovups zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vmovups XMMWORD PTR [rax+0x10]{k1}, xmm1
    vmovups XMMWORD PTR [rax+0x8]{k1}, xmm1
    vmovups XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vmovups YMMWORD PTR [rax+0x20]{k1}, ymm1
    vmovups YMMWORD PTR [rax+0x10]{k1}, ymm1
    vmovups YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vmovups ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vmovups ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vmovups ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vmulpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vmulpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vmulpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vmulpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vmulpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vmulpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vmulpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vmulpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vmulpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vmulps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vmulps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vmulps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vmulps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vmulps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vmulps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vmulps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vmulps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vmulps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vmulsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vmulsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vmulsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vmulss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vmulss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vmulss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vorpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vorpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vorpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vorpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vorpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vorpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vorpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vorpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vorpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vorps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vorps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vorps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vorps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vorps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vorps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vorps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vorps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vorps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpabsb xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpabsb xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpabsb xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpabsb ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpabsb ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpabsb ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpabsb zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpabsb zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpabsb zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpabsw xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpabsw xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpabsw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpabsw ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpabsw ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpabsw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpabsw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpabsw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpabsw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpabsd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpabsd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpabsd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpabsd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpabsd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpabsd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpabsd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpabsd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpabsd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpabsq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpabsq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpabsq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpabsq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpabsq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpabsq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpabsq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpabsq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpabsq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpacksswb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpacksswb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpacksswb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpacksswb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpacksswb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpacksswb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpacksswb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpacksswb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpacksswb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpackssdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpackssdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpackssdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpackssdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpackssdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpackssdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpackssdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpackssdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpackssdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpackusdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpackusdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpackusdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpackusdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpackusdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpackusdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpackusdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpackusdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpackusdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpackuswb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpackuswb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpackuswb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpackuswb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpackuswb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpackuswb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpackuswb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpackuswb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpackuswb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddusb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddusb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddusb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddusb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddusb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddusb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddusb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddusb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddusb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpaddusw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpaddusw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpaddusw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpaddusw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpaddusw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpaddusw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpaddusw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpaddusw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpaddusw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpalignr xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpalignr xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpalignr xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpalignr ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpalignr ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpalignr ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpalignr zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpalignr zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpalignr zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpandd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpandd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpandd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpandd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpandd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpandd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpandd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpandd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpandd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpandq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpandq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpandq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpandq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpandq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpandq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpandq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpandq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpandq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpandnd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpandnd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpandnd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpandnd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpandnd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpandnd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpandnd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpandnd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpandnd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpandnq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpandnq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpandnq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpandnq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpandnq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpandnq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpandnq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpandnq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpandnq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpavgb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpavgb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpavgb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpavgb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpavgb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpavgb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpavgb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpavgb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpavgb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpavgw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpavgw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpavgw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpavgw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpavgw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpavgw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpavgw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpavgw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpavgw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpclmulqdq xmm1, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpclmulqdq xmm1, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpclmulqdq xmm1, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpclmulqdq ymm1, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpclmulqdq ymm1, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpclmulqdq ymm1, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpclmulqdq zmm1, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpclmulqdq zmm1, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpclmulqdq zmm1, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpeqd k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpeqd k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpeqd k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpeqd k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpeqd k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpeqd k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpeqd k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpeqd k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpeqd k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpeqb k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpeqb k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpeqb k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpeqb k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpeqb k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpeqb k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpeqb k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpeqb k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpeqb k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpeqw k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpeqw k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpeqw k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpeqw k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpeqw k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpeqw k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpeqw k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpeqw k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpeqw k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpeqq k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpeqq k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpeqq k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpeqq k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpeqq k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpeqq k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpeqq k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpeqq k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpeqq k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpgtd k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpgtd k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpgtd k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpgtd k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpgtd k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpgtd k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpgtd k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpgtd k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpgtd k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpgtb k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpgtb k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpgtb k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpgtb k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpgtb k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpgtb k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpgtb k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpgtb k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpgtb k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpgtw k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpgtw k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpgtw k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpgtw k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpgtw k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpgtw k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpgtw k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpgtw k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpgtw k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpcmpgtq k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpcmpgtq k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpcmpgtq k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpcmpgtq k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpcmpgtq k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpcmpgtq k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpcmpgtq k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpcmpgtq k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpcmpgtq k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpextrb BYTE PTR [rax+0x1], xmm2, 0x1
    vpextrb BYTE PTR [rax+0x7f], xmm2, 0x1
    vpextrd DWORD PTR [rax+0x4], xmm2, 0x1
    vpextrd DWORD PTR [rax+0x2], xmm2, 0x1
    vpextrd DWORD PTR [rax+0x1fc], xmm2, 0x1
    vpextrq QWORD PTR [rax+0x8], xmm2, 0x1
    vpextrq QWORD PTR [rax+0x4], xmm2, 0x1
    vpextrq QWORD PTR [rax+0x3f8], xmm2, 0x1
    vpextrw WORD PTR [rax+0x2], xmm2, 0x1
    vpextrw WORD PTR [rax+0x1], xmm2, 0x1
    vpextrw WORD PTR [rax+0xfe], xmm2, 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rax+0x1], 0x1
    vpinsrb xmm1, xmm2, BYTE PTR [rax+0x7f], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax+0x4], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax+0x2], 0x1
    vpinsrd xmm1, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax+0x8], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax+0x4], 0x1
    vpinsrq xmm1, xmm2, QWORD PTR [rax+0x3f8], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax+0x2], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax+0x1], 0x1
    vpinsrw xmm1, xmm2, WORD PTR [rax+0xfe], 0x1
    vpmaddubsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaddubsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaddubsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaddubsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaddubsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaddubsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaddubsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaddubsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaddubsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaddwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaddwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaddwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaddwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaddwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaddwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaddwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaddwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaddwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxsd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxsd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxsd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxsd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxsd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxsd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxsd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxsd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxsd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxsq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxsq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxsq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxsq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxsq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxsq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxsq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxsq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxsq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxub xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxub xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxub xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxub ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxub ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxub ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxub zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxub zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxub zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxud xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxud xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxud xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxud ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxud ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxud ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxud zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxud zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxud zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmaxuq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmaxuq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmaxuq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmaxuq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmaxuq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmaxuq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmaxuq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmaxuq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmaxuq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminsd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminsd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminsd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminsd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminsd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminsd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminsd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminsd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminsd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminsq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminsq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminsq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminsq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminsq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminsq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminsq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminsq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminsq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminub xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminub xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminub xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminub ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminub ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminub ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminub zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminub zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminub zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminud xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminud xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminud xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminud ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminud ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminud ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminud zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminud zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminud zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpminuq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpminuq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpminuq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpminuq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpminuq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpminuq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpminuq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpminuq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpminuq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmovsxbw xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovsxbw xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovsxbw xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovsxbw ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovsxbw ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovsxbw ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovsxbw zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpmovsxbw zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpmovsxbw zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpmovsxbd xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vpmovsxbd xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vpmovsxbd xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpmovsxbd ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovsxbd ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovsxbd ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovsxbd zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovsxbd zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovsxbd zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovsxbq xmm1{k1}{z}, WORD PTR [rax+0x2]
    vpmovsxbq xmm1{k1}{z}, WORD PTR [rax+0x1]
    vpmovsxbq xmm1{k1}{z}, WORD PTR [rax+0xfe]
    vpmovsxbq ymm1{k1}{z}, DWORD PTR [rax+0x4]
    vpmovsxbq ymm1{k1}{z}, DWORD PTR [rax+0x2]
    vpmovsxbq ymm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpmovsxbq zmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovsxbq zmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovsxbq zmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovsxwd xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovsxwd xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovsxwd xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovsxwd ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovsxwd ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovsxwd ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovsxwd zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpmovsxwd zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpmovsxwd zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpmovsxwq xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vpmovsxwq xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vpmovsxwq xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpmovsxwq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovsxwq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovsxwq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovsxwq zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovsxwq zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovsxwq zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovsxdq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovsxdq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovsxdq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovsxdq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovsxdq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovsxdq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovsxdq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpmovsxdq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpmovsxdq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpmovzxbw ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovzxbw ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovzxbw ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovzxbw zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpmovzxbw zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpmovzxbw zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpmovzxbd xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vpmovzxbd xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vpmovzxbd xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpmovzxbd ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovzxbd ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovzxbd ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovzxbd zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovzxbd zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovzxbd zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovzxbq xmm1{k1}{z}, WORD PTR [rax+0x2]
    vpmovzxbq xmm1{k1}{z}, WORD PTR [rax+0x1]
    vpmovzxbq xmm1{k1}{z}, WORD PTR [rax+0xfe]
    vpmovzxbq ymm1{k1}{z}, DWORD PTR [rax+0x4]
    vpmovzxbq ymm1{k1}{z}, DWORD PTR [rax+0x2]
    vpmovzxbq ymm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpmovzxbq zmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovzxbq zmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovzxbq zmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovzxwd xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovzxwd xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovzxwd xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovzxwd ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovzxwd ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovzxwd ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovzxwd zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpmovzxwd zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpmovzxwd zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpmovzxwq xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vpmovzxwq xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vpmovzxwq xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpmovzxwq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovzxwq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovzxwq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovzxwq zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovzxwq zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovzxwq zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovzxdq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpmovzxdq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpmovzxdq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpmovzxdq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpmovzxdq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpmovzxdq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpmovzxdq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpmovzxdq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpmovzxdq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpmuldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmuldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmuldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmuldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmuldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmuldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmuldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmuldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmuldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmulhrsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmulhrsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmulhrsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmulhrsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmulhrsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmulhrsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmulhrsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmulhrsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmulhrsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmulhuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmulhuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmulhuw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmulhuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmulhuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmulhuw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmulhuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmulhuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmulhuw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmulhw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmulhw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmulhw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmulhw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmulhw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmulhw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmulhw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmulhw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmulhw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmulld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmulld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmulld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmulld ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmulld ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmulld ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmulld zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmulld zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmulld zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmullq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmullq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmullq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmullq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmullq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmullq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmullq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmullq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmullq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmullw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmullw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmullw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmullw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmullw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmullw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmullw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmullw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmullw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmuludq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmuludq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmuludq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmuludq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmuludq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmuludq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmuludq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmuludq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmuludq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpord xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpord xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpord xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpord ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpord ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpord ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpord zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpord zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpord zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vporq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vporq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vporq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vporq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vporq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vporq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vporq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vporq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vporq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsadbw xmm1, xmm2, XMMWORD PTR [rax+0x10]
    vpsadbw xmm1, xmm2, XMMWORD PTR [rax+0x8]
    vpsadbw xmm1, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsadbw ymm1, ymm2, YMMWORD PTR [rax+0x20]
    vpsadbw ymm1, ymm2, YMMWORD PTR [rax+0x10]
    vpsadbw ymm1, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsadbw zmm1, zmm2, ZMMWORD PTR [rax+0x40]
    vpsadbw zmm1, zmm2, ZMMWORD PTR [rax+0x20]
    vpsadbw zmm1, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshufb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshufb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshufb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshufb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshufb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshufb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshufb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshufb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshufb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshufd xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpshufd xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpshufd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpshufd ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpshufd ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpshufd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpshufd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpshufd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpshufd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshufhw xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpshufhw xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpshufhw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpshufhw ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpshufhw ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpshufhw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpshufhw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpshufhw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpshufhw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshuflw xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpshuflw xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpshuflw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpshuflw ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpshuflw ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpshuflw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpshuflw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpshuflw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpshuflw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpslldq xmm1, XMMWORD PTR [rax+0x10], 0x1
    vpslldq xmm1, XMMWORD PTR [rax+0x8], 0x1
    vpslldq xmm1, XMMWORD PTR [rax+0x7f0], 0x1
    vpslldq ymm1, YMMWORD PTR [rax+0x20], 0x1
    vpslldq ymm1, YMMWORD PTR [rax+0x10], 0x1
    vpslldq ymm1, YMMWORD PTR [rax+0xfe0], 0x1
    vpslldq zmm1, ZMMWORD PTR [rax+0x40], 0x1
    vpslldq zmm1, ZMMWORD PTR [rax+0x20], 0x1
    vpslldq zmm1, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsllw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsllw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsllw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsllw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsllw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsllw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsllw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsllw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsllw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsllw xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsllw xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsllw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsllw ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsllw ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsllw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsllw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsllw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsllw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpslld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpslld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpslld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpslld ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpslld ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpslld ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpslld zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpslld zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpslld zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpslld xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpslld xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpslld xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpslld ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpslld ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpslld ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpslld zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpslld zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpslld zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsllq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsllq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsllq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsllq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsllq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsllq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsllq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsllq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsllq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsllq xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsllq xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsllq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsllq ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsllq ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsllq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsllq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsllq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsllq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsraw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsraw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsraw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsraw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsraw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsraw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsraw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsraw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsraw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsraw xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsraw xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsraw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsraw ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsraw ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsraw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsraw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsraw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsraw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsrad xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrad xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrad xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrad ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsrad ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsrad ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsrad zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsrad zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsrad zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsrad xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsrad xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsrad xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsrad ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsrad ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsrad ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsrad zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsrad zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsrad zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsraq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsraq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsraq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsraq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsraq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsraq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsraq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsraq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsraq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsraq xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsraq xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsraq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsraq ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsraq ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsraq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsraq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsraq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsraq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsrldq xmm1, XMMWORD PTR [rax+0x10], 0x1
    vpsrldq xmm1, XMMWORD PTR [rax+0x8], 0x1
    vpsrldq xmm1, XMMWORD PTR [rax+0x7f0], 0x1
    vpsrldq ymm1, YMMWORD PTR [rax+0x20], 0x1
    vpsrldq ymm1, YMMWORD PTR [rax+0x10], 0x1
    vpsrldq ymm1, YMMWORD PTR [rax+0xfe0], 0x1
    vpsrldq zmm1, ZMMWORD PTR [rax+0x40], 0x1
    vpsrldq zmm1, ZMMWORD PTR [rax+0x20], 0x1
    vpsrldq zmm1, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsrlw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrlw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrlw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsrlw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsrlw ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsrlw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsrlw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsrlw zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlw xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsrlw xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsrlw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsrlw ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsrlw ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsrlw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsrlw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsrlw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsrlw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsrld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrld xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrld ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsrld ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsrld ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsrld zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsrld zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsrld zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsrld xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsrld xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsrld xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsrld ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsrld ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsrld ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsrld zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsrld zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsrld zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsrlq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrlq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrlq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10]
    vpsrlq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8]
    vpsrlq ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0]
    vpsrlq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vpsrlq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vpsrlq zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlq xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpsrlq xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpsrlq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpsrlq ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpsrlq ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpsrlq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpsrlq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpsrlq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpsrlq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpsubb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubsb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubsb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubsb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubsw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubsw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubsw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubusb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubusb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubusb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubusb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubusb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubusb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubusb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubusb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubusb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsubusw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsubusw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsubusw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsubusw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsubusw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsubusw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsubusw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsubusw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsubusw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpckhbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpckhbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpckhbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpckhwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpckhwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpckhwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpckhdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpckhdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpckhdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpckhqdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpckhqdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpckhqdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpckhbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpckhbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpckhbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpckhwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpckhwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpckhwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpckhdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpckhdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpckhdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpckhqdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpckhqdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpckhqdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpckhbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpckhbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpckhbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpckhwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpckhwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpckhwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpckhdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpckhdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpckhdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpckhqdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpckhqdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpckhqdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpcklbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpcklbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpcklbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpcklwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpcklwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpcklwd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpckldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpckldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpckldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpcklqdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpunpcklqdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpunpcklqdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpunpcklbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpcklbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpcklbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpcklwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpcklwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpcklwd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpckldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpckldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpckldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpcklqdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpunpcklqdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpunpcklqdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpunpcklbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpcklbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpcklbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpcklwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpcklwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpcklwd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpckldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpckldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpckldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpunpcklqdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpunpcklqdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpunpcklqdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpxord xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpxord xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpxord xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpxord ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpxord ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpxord ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpxord zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpxord zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpxord zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpxorq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpxorq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpxorq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpxorq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpxorq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpxorq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpxorq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpxorq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpxorq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vshufpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vshufpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vshufpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vshufpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vshufpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vshufpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vshufpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vshufpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vshufpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vshufps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vshufps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vshufps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vshufps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vshufps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vshufps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vshufps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vshufps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vshufps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vsqrtpd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vsqrtpd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vsqrtpd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vsqrtpd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vsqrtpd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vsqrtpd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vsqrtpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vsqrtpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vsqrtpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vsqrtps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vsqrtps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vsqrtps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vsqrtps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vsqrtps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vsqrtps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vsqrtps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vsqrtps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vsqrtps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vsqrtsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vsqrtsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vsqrtsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vsqrtss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vsqrtss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vsqrtss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vsubpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vsubpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vsubpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vsubpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vsubpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vsubpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vsubpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vsubpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vsubpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vsubps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vsubps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vsubps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vsubps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vsubps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vsubps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vsubps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vsubps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vsubps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vsubsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vsubsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vsubsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vsubss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vsubss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vsubss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vucomisd xmm1, QWORD PTR [rax+0x8]
    vucomisd xmm1, QWORD PTR [rax+0x4]
    vucomisd xmm1, QWORD PTR [rax+0x3f8]
    vucomiss xmm1, DWORD PTR [rax+0x4]
    vucomiss xmm1, DWORD PTR [rax+0x2]
    vucomiss xmm1, DWORD PTR [rax+0x1fc]
    vunpckhpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vunpckhpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vunpckhpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vunpckhpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vunpckhpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vunpckhpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vunpckhpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vunpckhpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vunpckhpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vunpckhps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vunpckhps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vunpckhps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vunpckhps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vunpckhps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vunpckhps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vunpckhps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vunpckhps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vunpckhps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vunpcklpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vunpcklpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vunpcklpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vunpcklpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vunpcklpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vunpcklpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vunpcklpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vunpcklpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vunpcklpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vunpcklps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vunpcklps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vunpcklps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vunpcklps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vunpcklps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vunpcklps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vunpcklps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vunpcklps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vunpcklps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaddph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vaddph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vaddph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vaddph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vaddph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vaddph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vaddph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vaddph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vaddph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vaddsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vaddsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vaddsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    valignd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    valignd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    valignd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    valignq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    valignq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    valignq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    valignd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    valignd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    valignd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    valignq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    valignq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    valignq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    valignd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    valignd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    valignd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    valignq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    valignq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    valignq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vblendmpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vblendmpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vblendmpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vblendmpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vblendmpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vblendmpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vblendmpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vblendmpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vblendmpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vblendmps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vblendmps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vblendmps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vblendmps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vblendmps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vblendmps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vblendmps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vblendmps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vblendmps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vbroadcastsd ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcastsd ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcastsd ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcastsd zmm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcastsd zmm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcastsd zmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcastf32x2 ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcastf32x2 ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcastf32x2 ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcastf32x2 zmm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcastf32x2 zmm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcastf32x2 zmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcastss xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vbroadcastss xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vbroadcastss xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vbroadcastss ymm1{k1}{z}, DWORD PTR [rax+0x4]
    vbroadcastss ymm1{k1}{z}, DWORD PTR [rax+0x2]
    vbroadcastss ymm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vbroadcastss zmm1{k1}{z}, DWORD PTR [rax+0x4]
    vbroadcastss zmm1{k1}{z}, DWORD PTR [rax+0x2]
    vbroadcastss zmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vbroadcastf32x4 ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcastf32x4 ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcastf32x4 ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcastf32x4 zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcastf32x4 zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcastf32x4 zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcastf64x2 ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcastf64x2 ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcastf64x2 ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcastf64x2 zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcastf64x2 zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcastf64x2 zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcastf32x8 zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vbroadcastf32x8 zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vbroadcastf32x8 zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vbroadcastf64x4 zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vbroadcastf64x4 zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vbroadcastf64x4 zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcmpph k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vcmpph k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vcmpph k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vcmpph k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vcmpph k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vcmpph k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vcmpph k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vcmpph k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vcmpph k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vcmpsh k1{k2}, xmm2, WORD PTR [rax+0x2], 0x1
    vcmpsh k1{k2}, xmm2, WORD PTR [rax+0x1], 0x1
    vcmpsh k1{k2}, xmm2, WORD PTR [rax+0xfe], 0x1
    vcomish xmm1, WORD PTR [rax+0x2]
    vcomish xmm1, WORD PTR [rax+0x1]
    vcomish xmm1, WORD PTR [rax+0xfe]
    vcompresspd XMMWORD PTR [rax+0x10]{k1}, xmm2
    vcompresspd XMMWORD PTR [rax+0x8]{k1}, xmm2
    vcompresspd XMMWORD PTR [rax+0x7f0]{k1}, xmm2
    vcompresspd YMMWORD PTR [rax+0x20]{k1}, ymm2
    vcompresspd YMMWORD PTR [rax+0x10]{k1}, ymm2
    vcompresspd YMMWORD PTR [rax+0xfe0]{k1}, ymm2
    vcompresspd ZMMWORD PTR [rax+0x40]{k1}, zmm2
    vcompresspd ZMMWORD PTR [rax+0x20]{k1}, zmm2
    vcompresspd ZMMWORD PTR [rax+0x1fc0]{k1}, zmm2
    vcompressps XMMWORD PTR [rax+0x10]{k1}, xmm2
    vcompressps XMMWORD PTR [rax+0x8]{k1}, xmm2
    vcompressps XMMWORD PTR [rax+0x7f0]{k1}, xmm2
    vcompressps YMMWORD PTR [rax+0x20]{k1}, ymm2
    vcompressps YMMWORD PTR [rax+0x10]{k1}, ymm2
    vcompressps YMMWORD PTR [rax+0xfe0]{k1}, ymm2
    vcompressps ZMMWORD PTR [rax+0x40]{k1}, zmm2
    vcompressps ZMMWORD PTR [rax+0x20]{k1}, zmm2
    vcompressps ZMMWORD PTR [rax+0x1fc0]{k1}, zmm2
    vcvtdq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtdq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtdq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtdq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtdq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtdq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtdq2ph ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtdq2ph ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtdq2ph ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtne2ps2bf16 xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vcvtne2ps2bf16 xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vcvtne2ps2bf16 xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vcvtne2ps2bf16 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vcvtne2ps2bf16 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vcvtne2ps2bf16 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vcvtne2ps2bf16 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vcvtne2ps2bf16 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vcvtne2ps2bf16 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vcvtneps2bf16 xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtneps2bf16 xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtneps2bf16 xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtneps2bf16 xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtneps2bf16 xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtneps2bf16 xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtneps2bf16 ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtneps2bf16 ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtneps2bf16 ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtpd2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtpd2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtpd2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtpd2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtpd2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtpd2ph xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtpd2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtpd2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtpd2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtpd2qq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtpd2qq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtpd2qq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtpd2qq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtpd2qq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtpd2qq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtpd2qq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtpd2qq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtpd2qq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtpd2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtpd2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtpd2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtpd2udq xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtpd2udq xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtpd2udq xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtpd2udq ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtpd2udq ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtpd2udq ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtpd2uqq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtpd2uqq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtpd2uqq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtpd2uqq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtpd2uqq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtpd2uqq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtpd2uqq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtpd2uqq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtpd2uqq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtph2dq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2dq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2dq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2dq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2dq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2dq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2dq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtph2dq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtph2dq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtph2pd xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vcvtph2pd xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vcvtph2pd xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vcvtph2pd ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2pd ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2pd ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2pd zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2pd zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2pd zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2ps xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2ps xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2ps xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2ps ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2ps ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2ps ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2ps zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtph2ps zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtph2ps zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtph2psx xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2psx xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2psx xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2psx ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2psx ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2psx ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2psx zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtph2psx zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtph2psx zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtph2qq xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vcvtph2qq xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vcvtph2qq xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vcvtph2qq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2qq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2qq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2qq zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2qq zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2qq zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2udq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2udq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2udq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2udq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2udq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2udq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2udq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtph2udq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtph2udq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtph2uqq xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vcvtph2uqq xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vcvtph2uqq xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vcvtph2uqq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtph2uqq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtph2uqq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtph2uqq zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2uqq zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2uqq zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2uw xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2uw xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2uw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2uw ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtph2uw ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtph2uw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtph2uw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtph2uw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtph2uw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtph2w xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtph2w xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtph2w xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtph2w ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtph2w ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtph2w ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtph2w zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtph2w zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtph2w zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtps2ph QWORD PTR [rax+0x8]{k1}, xmm2, 0x1
    vcvtps2ph QWORD PTR [rax+0x4]{k1}, xmm2, 0x1
    vcvtps2ph QWORD PTR [rax+0x3f8]{k1}, xmm2, 0x1
    vcvtps2ph XMMWORD PTR [rax+0x10]{k1}, ymm2, 0x1
    vcvtps2ph XMMWORD PTR [rax+0x8]{k1}, ymm2, 0x1
    vcvtps2ph XMMWORD PTR [rax+0x7f0]{k1}, ymm2, 0x1
    vcvtps2ph YMMWORD PTR [rax+0x20]{k1}, zmm2, 0x1
    vcvtps2ph YMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vcvtps2ph YMMWORD PTR [rax+0xfe0]{k1}, zmm2, 0x1
    vcvtps2phx xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtps2phx xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtps2phx xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtps2phx xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtps2phx xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtps2phx xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtps2phx ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtps2phx ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtps2phx ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtps2qq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtps2qq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtps2qq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtps2qq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtps2qq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtps2qq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtps2qq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtps2qq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtps2qq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtps2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtps2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtps2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtps2udq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtps2udq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtps2udq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtps2udq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtps2udq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtps2udq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtps2uqq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtps2uqq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtps2uqq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtps2uqq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtps2uqq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtps2uqq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtps2uqq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtps2uqq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtps2uqq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtqq2pd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtqq2pd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtqq2pd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtqq2pd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtqq2pd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtqq2pd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtqq2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtqq2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtqq2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtqq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtqq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtqq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtqq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtqq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtqq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtqq2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtqq2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtqq2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtqq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtqq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtqq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtqq2ps xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtqq2ps xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtqq2ps xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtqq2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtqq2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtqq2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtsd2sh xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vcvtsd2sh xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vcvtsd2sh xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vcvtsd2usi eax, QWORD PTR [rax+0x8]
    vcvtsd2usi eax, QWORD PTR [rax+0x4]
    vcvtsd2usi eax, QWORD PTR [rax+0x3f8]
    vcvtsd2usi rax, QWORD PTR [rax+0x8]
    vcvtsd2usi rax, QWORD PTR [rax+0x4]
    vcvtsd2usi rax, QWORD PTR [rax+0x3f8]
    vcvtsh2sd xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vcvtsh2sd xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vcvtsh2sd xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vcvtsh2si eax, WORD PTR [rax+0x2]
    vcvtsh2si eax, WORD PTR [rax+0x1]
    vcvtsh2si eax, WORD PTR [rax+0xfe]
    vcvtsh2si rax, WORD PTR [rax+0x2]
    vcvtsh2si rax, WORD PTR [rax+0x1]
    vcvtsh2si rax, WORD PTR [rax+0xfe]
    vcvtsh2ss xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vcvtsh2ss xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vcvtsh2ss xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vcvtsh2usi eax, WORD PTR [rax+0x2]
    vcvtsh2usi eax, WORD PTR [rax+0x1]
    vcvtsh2usi eax, WORD PTR [rax+0xfe]
    vcvtsh2usi rax, WORD PTR [rax+0x2]
    vcvtsh2usi rax, WORD PTR [rax+0x1]
    vcvtsh2usi rax, WORD PTR [rax+0xfe]
    vcvtsi2sh xmm1, xmm2, DWORD PTR [rax+0x4]
    vcvtsi2sh xmm1, xmm2, DWORD PTR [rax+0x2]
    vcvtsi2sh xmm1, xmm2, DWORD PTR [rax+0x1fc]
    vcvtsi2sh xmm1, xmm2, QWORD PTR [rax+0x8]
    vcvtsi2sh xmm1, xmm2, QWORD PTR [rax+0x4]
    vcvtsi2sh xmm1, xmm2, QWORD PTR [rax+0x3f8]
    vcvtss2sh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vcvtss2sh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vcvtss2sh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vcvtss2usi eax, DWORD PTR [rax+0x4]
    vcvtss2usi eax, DWORD PTR [rax+0x2]
    vcvtss2usi eax, DWORD PTR [rax+0x1fc]
    vcvtss2usi rax, DWORD PTR [rax+0x4]
    vcvtss2usi rax, DWORD PTR [rax+0x2]
    vcvtss2usi rax, DWORD PTR [rax+0x1fc]
    vcvttpd2qq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttpd2qq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttpd2qq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttpd2qq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttpd2qq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttpd2qq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttpd2qq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttpd2qq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttpd2qq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttpd2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttpd2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttpd2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttpd2udq xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttpd2udq xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttpd2udq xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttpd2udq ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttpd2udq ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttpd2udq ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttpd2uqq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttpd2uqq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttpd2uqq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttpd2uqq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttpd2uqq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttpd2uqq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttpd2uqq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttpd2uqq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttpd2uqq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttph2dq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvttph2dq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvttph2dq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvttph2dq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttph2dq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttph2dq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttph2dq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttph2dq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttph2dq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttph2qq xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vcvttph2qq xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vcvttph2qq xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vcvttph2qq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvttph2qq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvttph2qq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvttph2qq zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttph2qq zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttph2qq zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttph2udq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvttph2udq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvttph2udq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvttph2udq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttph2udq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttph2udq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttph2udq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttph2udq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttph2udq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttph2uqq xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vcvttph2uqq xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vcvttph2uqq xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vcvttph2uqq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvttph2uqq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvttph2uqq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvttph2uqq zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttph2uqq zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttph2uqq zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttph2uw xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttph2uw xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttph2uw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttph2uw ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttph2uw ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttph2uw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttph2uw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttph2uw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttph2uw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttph2w xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttph2w xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttph2w xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttph2w ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttph2w ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttph2w ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttph2w zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttph2w zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttph2w zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttps2qq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvttps2qq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvttps2qq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvttps2qq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttps2qq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttps2qq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttps2qq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttps2qq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttps2qq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttps2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttps2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttps2udq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttps2udq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttps2udq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttps2udq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttps2udq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvttps2udq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvttps2udq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvttps2uqq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvttps2uqq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvttps2uqq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvttps2uqq ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvttps2uqq ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvttps2uqq ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvttps2uqq zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvttps2uqq zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvttps2uqq zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvttsd2usi eax, QWORD PTR [rax+0x8]
    vcvttsd2usi eax, QWORD PTR [rax+0x4]
    vcvttsd2usi eax, QWORD PTR [rax+0x3f8]
    vcvttsd2usi rax, QWORD PTR [rax+0x8]
    vcvttsd2usi rax, QWORD PTR [rax+0x4]
    vcvttsd2usi rax, QWORD PTR [rax+0x3f8]
    vcvttsh2si eax, WORD PTR [rax+0x2]
    vcvttsh2si eax, WORD PTR [rax+0x1]
    vcvttsh2si eax, WORD PTR [rax+0xfe]
    vcvttsh2si rax, WORD PTR [rax+0x2]
    vcvttsh2si rax, WORD PTR [rax+0x1]
    vcvttsh2si rax, WORD PTR [rax+0xfe]
    vcvttsh2usi eax, WORD PTR [rax+0x2]
    vcvttsh2usi eax, WORD PTR [rax+0x1]
    vcvttsh2usi eax, WORD PTR [rax+0xfe]
    vcvttsh2usi rax, WORD PTR [rax+0x2]
    vcvttsh2usi rax, WORD PTR [rax+0x1]
    vcvttsh2usi rax, WORD PTR [rax+0xfe]
    vcvttss2usi eax, DWORD PTR [rax+0x4]
    vcvttss2usi eax, DWORD PTR [rax+0x2]
    vcvttss2usi eax, DWORD PTR [rax+0x1fc]
    vcvttss2usi rax, DWORD PTR [rax+0x4]
    vcvttss2usi rax, DWORD PTR [rax+0x2]
    vcvttss2usi rax, DWORD PTR [rax+0x1fc]
    vcvtudq2pd xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vcvtudq2pd xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vcvtudq2pd xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vcvtudq2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtudq2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtudq2pd ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtudq2pd zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtudq2pd zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtudq2pd zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtudq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtudq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtudq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtudq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtudq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtudq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtudq2ph ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtudq2ph ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtudq2ph ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtudq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtudq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtudq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtudq2ps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtudq2ps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtudq2ps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtudq2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtudq2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtudq2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtuqq2pd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtuqq2pd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtuqq2pd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtuqq2pd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtuqq2pd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtuqq2pd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtuqq2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtuqq2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtuqq2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtuqq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtuqq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtuqq2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtuqq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtuqq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtuqq2ph xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtuqq2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtuqq2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtuqq2ph xmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtuqq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtuqq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtuqq2ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtuqq2ps xmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtuqq2ps xmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtuqq2ps xmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtuqq2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtuqq2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtuqq2ps ymm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtusi2sd xmm1, xmm2, DWORD PTR [rax+0x4]
    vcvtusi2sd xmm1, xmm2, DWORD PTR [rax+0x2]
    vcvtusi2sd xmm1, xmm2, DWORD PTR [rax+0x1fc]
    vcvtusi2sd xmm1, xmm2, QWORD PTR [rax+0x8]
    vcvtusi2sd xmm1, xmm2, QWORD PTR [rax+0x4]
    vcvtusi2sd xmm1, xmm2, QWORD PTR [rax+0x3f8]
    vcvtusi2sh xmm1, xmm2, DWORD PTR [rax+0x4]
    vcvtusi2sh xmm1, xmm2, DWORD PTR [rax+0x2]
    vcvtusi2sh xmm1, xmm2, DWORD PTR [rax+0x1fc]
    vcvtusi2sh xmm1, xmm2, QWORD PTR [rax+0x8]
    vcvtusi2sh xmm1, xmm2, QWORD PTR [rax+0x4]
    vcvtusi2sh xmm1, xmm2, QWORD PTR [rax+0x3f8]
    vcvtusi2ss xmm1, xmm2, DWORD PTR [rax+0x4]
    vcvtusi2ss xmm1, xmm2, DWORD PTR [rax+0x2]
    vcvtusi2ss xmm1, xmm2, DWORD PTR [rax+0x1fc]
    vcvtusi2ss xmm1, xmm2, QWORD PTR [rax+0x8]
    vcvtusi2ss xmm1, xmm2, QWORD PTR [rax+0x4]
    vcvtusi2ss xmm1, xmm2, QWORD PTR [rax+0x3f8]
    vcvtuw2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtuw2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtuw2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtuw2ph ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtuw2ph ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtuw2ph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtuw2ph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtuw2ph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtuw2ph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vcvtw2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vcvtw2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vcvtw2ph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vcvtw2ph ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vcvtw2ph ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vcvtw2ph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vcvtw2ph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vcvtw2ph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vcvtw2ph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vdbpsadbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vdbpsadbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vdbpsadbw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vdbpsadbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vdbpsadbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vdbpsadbw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vdbpsadbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vdbpsadbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vdbpsadbw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vdivph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vdivph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vdivph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vdivph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vdivph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vdivph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vdivph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vdivph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vdivph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vdivsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vdivsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vdivsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vdpbf16ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vdpbf16ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vdpbf16ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vdpbf16ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vdpbf16ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vdpbf16ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vdpbf16ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vdpbf16ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vdpbf16ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vexpandpd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vexpandpd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vexpandpd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vexpandpd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vexpandpd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vexpandpd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vexpandpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vexpandpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vexpandpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vexpandps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vexpandps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vexpandps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vexpandps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vexpandps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vexpandps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vexpandps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vexpandps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vexpandps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vextractf32x4 XMMWORD PTR [rax+0x10]{k1}, ymm2, 0x1
    vextractf32x4 XMMWORD PTR [rax+0x8]{k1}, ymm2, 0x1
    vextractf32x4 XMMWORD PTR [rax+0x7f0]{k1}, ymm2, 0x1
    vextractf32x4 XMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextractf32x4 XMMWORD PTR [rax+0x8]{k1}, zmm2, 0x1
    vextractf32x4 XMMWORD PTR [rax+0x7f0]{k1}, zmm2, 0x1
    vextractf64x2 XMMWORD PTR [rax+0x10]{k1}, ymm2, 0x1
    vextractf64x2 XMMWORD PTR [rax+0x8]{k1}, ymm2, 0x1
    vextractf64x2 XMMWORD PTR [rax+0x7f0]{k1}, ymm2, 0x1
    vextractf64x2 XMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextractf64x2 XMMWORD PTR [rax+0x8]{k1}, zmm2, 0x1
    vextractf64x2 XMMWORD PTR [rax+0x7f0]{k1}, zmm2, 0x1
    vextractf32x8 YMMWORD PTR [rax+0x20]{k1}, zmm2, 0x1
    vextractf32x8 YMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextractf32x8 YMMWORD PTR [rax+0xfe0]{k1}, zmm2, 0x1
    vextractf64x4 YMMWORD PTR [rax+0x20]{k1}, zmm2, 0x1
    vextractf64x4 YMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextractf64x4 YMMWORD PTR [rax+0xfe0]{k1}, zmm2, 0x1
    vextracti32x4 XMMWORD PTR [rax+0x10]{k1}, ymm2, 0x1
    vextracti32x4 XMMWORD PTR [rax+0x8]{k1}, ymm2, 0x1
    vextracti32x4 XMMWORD PTR [rax+0x7f0]{k1}, ymm2, 0x1
    vextracti32x4 XMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextracti32x4 XMMWORD PTR [rax+0x8]{k1}, zmm2, 0x1
    vextracti32x4 XMMWORD PTR [rax+0x7f0]{k1}, zmm2, 0x1
    vextracti64x2 XMMWORD PTR [rax+0x10]{k1}, ymm2, 0x1
    vextracti64x2 XMMWORD PTR [rax+0x8]{k1}, ymm2, 0x1
    vextracti64x2 XMMWORD PTR [rax+0x7f0]{k1}, ymm2, 0x1
    vextracti64x2 XMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextracti64x2 XMMWORD PTR [rax+0x8]{k1}, zmm2, 0x1
    vextracti64x2 XMMWORD PTR [rax+0x7f0]{k1}, zmm2, 0x1
    vextracti32x8 YMMWORD PTR [rax+0x20]{k1}, zmm2, 0x1
    vextracti32x8 YMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextracti32x8 YMMWORD PTR [rax+0xfe0]{k1}, zmm2, 0x1
    vextracti64x4 YMMWORD PTR [rax+0x20]{k1}, zmm2, 0x1
    vextracti64x4 YMMWORD PTR [rax+0x10]{k1}, zmm2, 0x1
    vextracti64x4 YMMWORD PTR [rax+0xfe0]{k1}, zmm2, 0x1
    vfcmaddcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfcmaddcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfcmaddcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfcmaddcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfcmaddcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfcmaddcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfcmaddcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfcmaddcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfcmaddcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfcmaddcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfcmaddcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfcmaddcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmaddcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmaddcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmaddcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfcmulcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfcmulcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfcmulcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfcmulcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfcmulcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfcmulcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfcmulcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfcmulcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfcmulcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmulcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmulcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmulcph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmulcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmulcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmulcph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmulcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmulcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmulcph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfcmulcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfcmulcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfcmulcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmulcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmulcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmulcsh xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfixupimmpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vfixupimmpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vfixupimmpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vfixupimmpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vfixupimmpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vfixupimmpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vfixupimmpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vfixupimmpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vfixupimmpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vfixupimmps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vfixupimmps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vfixupimmps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vfixupimmps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vfixupimmps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vfixupimmps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vfixupimmps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vfixupimmps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vfixupimmps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vfixupimmsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8], 0x1
    vfixupimmsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4], 0x1
    vfixupimmsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8], 0x1
    vfixupimmss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4], 0x1
    vfixupimmss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2], 0x1
    vfixupimmss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vfmadd132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmadd132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfmadd132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfmadd132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfmadd213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfmadd213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfmadd213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfmadd231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfmadd231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfmadd231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfmadd132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfmadd132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfmadd132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfmadd213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfmadd213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfmadd213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfmadd231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfmadd231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfmadd231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfnmadd132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfnmadd132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfnmadd132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfnmadd213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfnmadd213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfnmadd213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfnmadd231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfnmadd231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfnmadd231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfmadd132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmadd132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmadd132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmadd213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmadd213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmadd213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmadd231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmadd231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmadd231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmaddsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmaddsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmaddsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmaddsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmaddsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmaddsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmaddsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmaddsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmaddsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmaddsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsub132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfmsub132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfmsub132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfmsub213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfmsub213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfmsub213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfmsub231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfmsub231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfmsub231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfmsub132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfmsub132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfmsub132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfmsub213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfmsub213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfmsub213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfmsub231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfmsub231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfmsub231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfnmsub132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfnmsub132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfnmsub132sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfnmsub213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfnmsub213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfnmsub213sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfnmsub231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vfnmsub231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vfnmsub231sh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vfmsub132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmsub132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmsub132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmsub213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmsub213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmsub213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmsub231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfmsub231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfmsub231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfmsubadd132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd132ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd132ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd132ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd213ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd213ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd213ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd231ph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd231ph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd231ph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfmsubadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfmsubadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfmsubadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfmsubadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfmsubadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfmsubadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfmsubadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfmsubadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfmsubadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd132pd xmm0{k1}{z}, xmm1, XMMWORD PTR [rax+0x10]
    vfnmadd132pd xmm0{k1}{z}, xmm1, XMMWORD PTR [rax+0x8]
    vfnmadd132pd xmm0{k1}{z}, xmm1, XMMWORD PTR [rax+0x7f0]
    vfnmadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmadd231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmadd231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmadd231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmadd132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfnmadd132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfnmadd132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfnmadd213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfnmadd213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfnmadd213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfnmadd231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfnmadd231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfnmadd231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfnmadd132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfnmadd132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfnmadd132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfnmadd213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfnmadd213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfnmadd213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfnmadd231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfnmadd231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfnmadd231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfnmsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub132pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub213pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub231pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub132pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub213pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub231pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub132pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub213pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub231pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub132ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub213ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vfnmsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vfnmsub231ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vfnmsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub132ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub213ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vfnmsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vfnmsub231ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vfnmsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub132ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub213ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vfnmsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vfnmsub231ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vfnmsub132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfnmsub132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfnmsub132sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfnmsub213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfnmsub213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfnmsub213sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfnmsub231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vfnmsub231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vfnmsub231sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vfnmsub132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfnmsub132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfnmsub132ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfnmsub213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfnmsub213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfnmsub213ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfnmsub231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vfnmsub231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vfnmsub231ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vfpclasspd k2{k1}, XMMWORD PTR [rax+0x10], 0x1
    vfpclasspd k2{k1}, XMMWORD PTR [rax+0x8], 0x1
    vfpclasspd k2{k1}, XMMWORD PTR [rax+0x7f0], 0x1
    vfpclasspd k2{k1}, YMMWORD PTR [rax+0x20], 0x1
    vfpclasspd k2{k1}, YMMWORD PTR [rax+0x10], 0x1
    vfpclasspd k2{k1}, YMMWORD PTR [rax+0xfe0], 0x1
    vfpclasspd k2{k1}, ZMMWORD PTR [rax+0x40], 0x1
    vfpclasspd k2{k1}, ZMMWORD PTR [rax+0x20], 0x1
    vfpclasspd k2{k1}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vfpclassph k1{k2}, XMMWORD PTR [rax+0x10], 0x1
    vfpclassph k1{k2}, XMMWORD PTR [rax+0x8], 0x1
    vfpclassph k1{k2}, XMMWORD PTR [rax+0x7f0], 0x1
    vfpclassph k1{k2}, YMMWORD PTR [rax+0x20], 0x1
    vfpclassph k1{k2}, YMMWORD PTR [rax+0x10], 0x1
    vfpclassph k1{k2}, YMMWORD PTR [rax+0xfe0], 0x1
    vfpclassph k1{k2}, ZMMWORD PTR [rax+0x40], 0x1
    vfpclassph k1{k2}, ZMMWORD PTR [rax+0x20], 0x1
    vfpclassph k1{k2}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vfpclassps k2{k1}, XMMWORD PTR [rax+0x10], 0x1
    vfpclassps k2{k1}, XMMWORD PTR [rax+0x8], 0x1
    vfpclassps k2{k1}, XMMWORD PTR [rax+0x7f0], 0x1
    vfpclassps k2{k1}, YMMWORD PTR [rax+0x20], 0x1
    vfpclassps k2{k1}, YMMWORD PTR [rax+0x10], 0x1
    vfpclassps k2{k1}, YMMWORD PTR [rax+0xfe0], 0x1
    vfpclassps k2{k1}, ZMMWORD PTR [rax+0x40], 0x1
    vfpclassps k2{k1}, ZMMWORD PTR [rax+0x20], 0x1
    vfpclassps k2{k1}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vfpclasssd k2{k1}, QWORD PTR [rax+0x8], 0x1
    vfpclasssd k2{k1}, QWORD PTR [rax+0x4], 0x1
    vfpclasssd k2{k1}, QWORD PTR [rax+0x3f8], 0x1
    vfpclasssh k1{k2}, WORD PTR [rax+0x2], 0x1
    vfpclasssh k1{k2}, WORD PTR [rax+0x1], 0x1
    vfpclasssh k1{k2}, WORD PTR [rax+0xfe], 0x1
    vfpclassss k2{k1}, DWORD PTR [rax+0x4], 0x1
    vfpclassss k2{k1}, DWORD PTR [rax+0x2], 0x1
    vfpclassss k2{k1}, DWORD PTR [rax+0x1fc], 0x1
    vgetexppd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vgetexppd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vgetexppd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vgetexppd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vgetexppd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vgetexppd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vgetexppd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vgetexppd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vgetexppd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vgetexpph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vgetexpph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vgetexpph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vgetexpph ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vgetexpph ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vgetexpph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vgetexpph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vgetexpph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vgetexpph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vgetexpps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vgetexpps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vgetexpps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vgetexpps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vgetexpps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vgetexpps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vgetexpps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vgetexpps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vgetexpps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vgetexpsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vgetexpsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vgetexpsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vgetexpsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vgetexpsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vgetexpsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vgetexpss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vgetexpss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vgetexpss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vgetmantpd xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vgetmantpd xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vgetmantpd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vgetmantpd ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vgetmantpd ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vgetmantpd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vgetmantpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vgetmantpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vgetmantpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vgetmantph xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vgetmantph xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vgetmantph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vgetmantph ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vgetmantph ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vgetmantph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vgetmantph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vgetmantph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vgetmantph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vgetmantps xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vgetmantps xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vgetmantps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vgetmantps ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vgetmantps ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vgetmantps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vgetmantps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vgetmantps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vgetmantps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vgetmantsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8], 0x1
    vgetmantsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4], 0x1
    vgetmantsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8], 0x1
    vgetmantsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2], 0x1
    vgetmantsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1], 0x1
    vgetmantsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe], 0x1
    vgetmantss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4], 0x1
    vgetmantss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2], 0x1
    vgetmantss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vinsertf32x4 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10], 0x1
    vinsertf32x4 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8], 0x1
    vinsertf32x4 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinsertf32x4 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10], 0x1
    vinsertf32x4 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8], 0x1
    vinsertf32x4 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinsertf64x2 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10], 0x1
    vinsertf64x2 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8], 0x1
    vinsertf64x2 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinsertf64x2 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10], 0x1
    vinsertf64x2 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8], 0x1
    vinsertf64x2 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinsertf32x8 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x20], 0x1
    vinsertf32x8 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x10], 0x1
    vinsertf32x8 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0xfe0], 0x1
    vinsertf64x4 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x20], 0x1
    vinsertf64x4 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x10], 0x1
    vinsertf64x4 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0xfe0], 0x1
    vinserti32x4 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10], 0x1
    vinserti32x4 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8], 0x1
    vinserti32x4 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinserti32x4 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10], 0x1
    vinserti32x4 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8], 0x1
    vinserti32x4 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinserti64x2 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x10], 0x1
    vinserti64x2 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x8], 0x1
    vinserti64x2 ymm1{k1}{z}, ymm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinserti64x2 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10], 0x1
    vinserti64x2 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8], 0x1
    vinserti64x2 zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vinserti32x8 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x20], 0x1
    vinserti32x8 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x10], 0x1
    vinserti32x8 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0xfe0], 0x1
    vinserti64x4 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x20], 0x1
    vinserti64x4 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0x10], 0x1
    vinserti64x4 zmm1{k1}{z}, zmm2, YMMWORD PTR [rax+0xfe0], 0x1
    vmaxph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vmaxph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vmaxph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vmaxph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vmaxph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vmaxph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vmaxph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vmaxph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vmaxph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vmaxsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vmaxsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vmaxsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vminph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vminph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vminph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vminph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vminph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vminph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vminph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vminph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vminph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vminsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vminsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vminsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vmovsh xmm1{k1}{z}, WORD PTR [rax+0x2]
    vmovsh xmm1{k1}{z}, WORD PTR [rax+0x1]
    vmovsh xmm1{k1}{z}, WORD PTR [rax+0xfe]
    vmovsh WORD PTR [rax+0x2]{k1}, xmm1
    vmovsh WORD PTR [rax+0x1]{k1}, xmm1
    vmovsh WORD PTR [rax+0xfe]{k1}, xmm1
    vmovw xmm1, WORD PTR [rax+0x2]
    vmovw xmm1, WORD PTR [rax+0x1]
    vmovw xmm1, WORD PTR [rax+0xfe]
    vmovw WORD PTR [rax+0x2], xmm1
    vmovw WORD PTR [rax+0x1], xmm1
    vmovw WORD PTR [rax+0xfe], xmm1
    vmulph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vmulph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vmulph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vmulph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vmulph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vmulph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vmulph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vmulph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vmulph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vmulsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vmulsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vmulsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vp2intersectd k2, xmm2, XMMWORD PTR [rax+0x10]
    vp2intersectd k2, xmm2, XMMWORD PTR [rax+0x8]
    vp2intersectd k2, xmm2, XMMWORD PTR [rax+0x7f0]
    vp2intersectd k2, ymm2, YMMWORD PTR [rax+0x20]
    vp2intersectd k2, ymm2, YMMWORD PTR [rax+0x10]
    vp2intersectd k2, ymm2, YMMWORD PTR [rax+0xfe0]
    vp2intersectd k2, zmm2, ZMMWORD PTR [rax+0x40]
    vp2intersectd k2, zmm2, ZMMWORD PTR [rax+0x20]
    vp2intersectd k2, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vp2intersectq k2, xmm2, XMMWORD PTR [rax+0x10]
    vp2intersectq k2, xmm2, XMMWORD PTR [rax+0x8]
    vp2intersectq k2, xmm2, XMMWORD PTR [rax+0x7f0]
    vp2intersectq k2, ymm2, YMMWORD PTR [rax+0x20]
    vp2intersectq k2, ymm2, YMMWORD PTR [rax+0x10]
    vp2intersectq k2, ymm2, YMMWORD PTR [rax+0xfe0]
    vp2intersectq k2, zmm2, ZMMWORD PTR [rax+0x40]
    vp2intersectq k2, zmm2, ZMMWORD PTR [rax+0x20]
    vp2intersectq k2, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpblendmb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpblendmb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpblendmb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpblendmb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpblendmb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpblendmb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpblendmb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpblendmb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpblendmb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpblendmw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpblendmw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpblendmw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpblendmw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpblendmw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpblendmw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpblendmw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpblendmw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpblendmw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpblendmd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpblendmd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpblendmd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpblendmd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpblendmd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpblendmd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpblendmd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpblendmd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpblendmd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpblendmq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpblendmq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpblendmq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpblendmq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpblendmq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpblendmq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpblendmq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpblendmq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpblendmq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpbroadcastb xmm1{k1}{z}, BYTE PTR [rax+0x1]
    vpbroadcastb xmm1{k1}{z}, BYTE PTR [rax+0x7f]
    vpbroadcastb ymm1{k1}{z}, BYTE PTR [rax+0x1]
    vpbroadcastb ymm1{k1}{z}, BYTE PTR [rax+0x7f]
    vpbroadcastb zmm1{k1}{z}, BYTE PTR [rax+0x1]
    vpbroadcastb zmm1{k1}{z}, BYTE PTR [rax+0x7f]
    vpbroadcastw xmm1{k1}{z}, WORD PTR [rax+0x2]
    vpbroadcastw xmm1{k1}{z}, WORD PTR [rax+0x1]
    vpbroadcastw xmm1{k1}{z}, WORD PTR [rax+0xfe]
    vpbroadcastw ymm1{k1}{z}, WORD PTR [rax+0x2]
    vpbroadcastw ymm1{k1}{z}, WORD PTR [rax+0x1]
    vpbroadcastw ymm1{k1}{z}, WORD PTR [rax+0xfe]
    vpbroadcastw zmm1{k1}{z}, WORD PTR [rax+0x2]
    vpbroadcastw zmm1{k1}{z}, WORD PTR [rax+0x1]
    vpbroadcastw zmm1{k1}{z}, WORD PTR [rax+0xfe]
    vpbroadcastd xmm1{k1}{z}, DWORD PTR [rax+0x4]
    vpbroadcastd xmm1{k1}{z}, DWORD PTR [rax+0x2]
    vpbroadcastd xmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpbroadcastd ymm1{k1}{z}, DWORD PTR [rax+0x4]
    vpbroadcastd ymm1{k1}{z}, DWORD PTR [rax+0x2]
    vpbroadcastd ymm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpbroadcastd zmm1{k1}{z}, DWORD PTR [rax+0x4]
    vpbroadcastd zmm1{k1}{z}, DWORD PTR [rax+0x2]
    vpbroadcastd zmm1{k1}{z}, DWORD PTR [rax+0x1fc]
    vpbroadcastq xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpbroadcastq xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpbroadcastq xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpbroadcastq ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vpbroadcastq ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vpbroadcastq ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vpbroadcastq zmm1{k1}{z}, QWORD PTR [rax+0x8]
    vpbroadcastq zmm1{k1}{z}, QWORD PTR [rax+0x4]
    vpbroadcastq zmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcasti32x2 xmm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcasti32x2 xmm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcasti32x2 xmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcasti32x2 ymm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcasti32x2 ymm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcasti32x2 ymm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcasti32x2 zmm1{k1}{z}, QWORD PTR [rax+0x8]
    vbroadcasti32x2 zmm1{k1}{z}, QWORD PTR [rax+0x4]
    vbroadcasti32x2 zmm1{k1}{z}, QWORD PTR [rax+0x3f8]
    vbroadcasti32x4 ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcasti32x4 ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcasti32x4 ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcasti32x4 zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcasti32x4 zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcasti32x4 zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcasti64x2 ymm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcasti64x2 ymm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcasti64x2 ymm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcasti64x2 zmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vbroadcasti64x2 zmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vbroadcasti64x2 zmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vbroadcasti32x8 zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vbroadcasti32x8 zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vbroadcasti32x8 zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vbroadcasti64x4 zmm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vbroadcasti64x4 zmm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vbroadcasti64x4 zmm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpcmpb k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpb k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpb k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpb k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpb k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpb k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpb k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpb k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpb k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpub k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpub k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpub k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpub k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpub k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpub k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpub k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpub k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpub k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpd k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpd k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpd k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpd k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpd k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpd k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpd k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpd k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpd k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpud k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpud k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpud k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpud k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpud k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpud k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpud k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpud k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpud k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpq k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpq k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpq k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpq k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpq k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpq k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpq k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpq k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpq k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpuq k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpuq k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpuq k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpuq k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpuq k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpuq k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpuq k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpuq k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpuq k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpw k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpw k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpw k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpw k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpw k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpw k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpw k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpw k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpw k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcmpuw k1{k2}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpcmpuw k1{k2}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpcmpuw k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpcmpuw k1{k2}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpcmpuw k1{k2}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpcmpuw k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpcmpuw k1{k2}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpcmpuw k1{k2}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpcmpuw k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpcompressb XMMWORD PTR [rax+0x10]{k1}, xmm1
    vpcompressb XMMWORD PTR [rax+0x8]{k1}, xmm1
    vpcompressb XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vpcompressb YMMWORD PTR [rax+0x20]{k1}, ymm1
    vpcompressb YMMWORD PTR [rax+0x10]{k1}, ymm1
    vpcompressb YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vpcompressb ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vpcompressb ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vpcompressb ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vpcompressw XMMWORD PTR [rax+0x10]{k1}, xmm1
    vpcompressw XMMWORD PTR [rax+0x8]{k1}, xmm1
    vpcompressw XMMWORD PTR [rax+0x7f0]{k1}, xmm1
    vpcompressw YMMWORD PTR [rax+0x20]{k1}, ymm1
    vpcompressw YMMWORD PTR [rax+0x10]{k1}, ymm1
    vpcompressw YMMWORD PTR [rax+0xfe0]{k1}, ymm1
    vpcompressw ZMMWORD PTR [rax+0x40]{k1}, zmm1
    vpcompressw ZMMWORD PTR [rax+0x20]{k1}, zmm1
    vpcompressw ZMMWORD PTR [rax+0x1fc0]{k1}, zmm1
    vpcompressd XMMWORD PTR [rax+0x10]{k1}, xmm2
    vpcompressd XMMWORD PTR [rax+0x8]{k1}, xmm2
    vpcompressd XMMWORD PTR [rax+0x7f0]{k1}, xmm2
    vpcompressd YMMWORD PTR [rax+0x20]{k1}, ymm2
    vpcompressd YMMWORD PTR [rax+0x10]{k1}, ymm2
    vpcompressd YMMWORD PTR [rax+0xfe0]{k1}, ymm2
    vpcompressd ZMMWORD PTR [rax+0x40]{k1}, zmm2
    vpcompressd ZMMWORD PTR [rax+0x20]{k1}, zmm2
    vpcompressd ZMMWORD PTR [rax+0x1fc0]{k1}, zmm2
    vpcompressq XMMWORD PTR [rax+0x10]{k1}, xmm2
    vpcompressq XMMWORD PTR [rax+0x8]{k1}, xmm2
    vpcompressq XMMWORD PTR [rax+0x7f0]{k1}, xmm2
    vpcompressq YMMWORD PTR [rax+0x20]{k1}, ymm2
    vpcompressq YMMWORD PTR [rax+0x10]{k1}, ymm2
    vpcompressq YMMWORD PTR [rax+0xfe0]{k1}, ymm2
    vpcompressq ZMMWORD PTR [rax+0x40]{k1}, zmm2
    vpcompressq ZMMWORD PTR [rax+0x20]{k1}, zmm2
    vpcompressq ZMMWORD PTR [rax+0x1fc0]{k1}, zmm2
    vpconflictd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpconflictd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpconflictd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpconflictd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpconflictd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpconflictd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpconflictd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpconflictd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpconflictd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpconflictq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpconflictq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpconflictq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpconflictq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpconflictq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpconflictq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpconflictq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpconflictq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpconflictq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpdpbusd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpdpbusd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpdpbusd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpdpbusd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpdpbusd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpdpbusd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpdpbusd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpdpbusd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpdpbusd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpdpbusds xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpdpbusds xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpdpbusds xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpdpbusds ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpdpbusds ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpdpbusds ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpdpbusds zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpdpbusds zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpdpbusds zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpdpwssd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpdpwssd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpdpwssd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpdpwssd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpdpwssd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpdpwssd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpdpwssd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpdpwssd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpdpwssd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpdpwssds xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpdpwssds xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpdpwssds xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpdpwssds ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpdpwssds ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpdpwssds ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpdpwssds zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpdpwssds zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpdpwssds zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermi2b xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermi2b xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermi2b xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermi2b ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermi2b ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermi2b ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermi2b zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermi2b zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermi2b zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermi2w xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermi2w xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermi2w xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermi2w ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermi2w ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermi2w ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermi2w zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermi2w zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermi2w zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermi2d xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermi2d xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermi2d xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermi2d ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermi2d ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermi2d ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermi2d zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermi2d zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermi2d zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermi2q xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermi2q xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermi2q xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermi2q ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermi2q ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermi2q ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermi2q zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermi2q zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermi2q zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermi2ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermi2ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermi2ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermi2ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermi2ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermi2ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermi2ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermi2ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermi2ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermi2pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermi2pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermi2pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermi2pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermi2pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermi2pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermi2pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermi2pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermi2pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermilpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermilpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermilpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermilpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermilpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermilpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermilpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermilpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermilpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermilpd xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpermilpd xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpermilpd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpermilpd ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpermilpd ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpermilpd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpermilpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpermilpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpermilpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpermilps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermilps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermilps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermilps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermilps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermilps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermilps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermilps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermilps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermilps xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vpermilps xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vpermilps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vpermilps ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpermilps ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpermilps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpermpd ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpermpd ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpermpd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpermpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpermpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpermpd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpermpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermq ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vpermq ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vpermq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vpermq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vpermq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vpermq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpermq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermt2b xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermt2b xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermt2b xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermt2b ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermt2b ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermt2b ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermt2b zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermt2b zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermt2b zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermt2w xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermt2w xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermt2w xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermt2w ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermt2w ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermt2w ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermt2w zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermt2w zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermt2w zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermt2d xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermt2d xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermt2d xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermt2d ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermt2d ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermt2d ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermt2d zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermt2d zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermt2d zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermt2q xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermt2q xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermt2q xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermt2q ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermt2q ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermt2q ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermt2q zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermt2q zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermt2q zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermt2ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermt2ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermt2ps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermt2ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermt2ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermt2ps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermt2ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermt2ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermt2ps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpermt2pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpermt2pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpermt2pd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpermt2pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpermt2pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpermt2pd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpermt2pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpermt2pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpermt2pd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpexpandb xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpexpandb xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpexpandb xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpexpandb ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpexpandb ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpexpandb ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpexpandb zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpexpandb zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpexpandb zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpexpandw xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpexpandw xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpexpandw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpexpandw ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpexpandw ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpexpandw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpexpandw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpexpandw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpexpandw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpexpandd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpexpandd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpexpandd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpexpandd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpexpandd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpexpandd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpexpandd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpexpandd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpexpandd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpexpandq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpexpandq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpexpandq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpexpandq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpexpandq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpexpandq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpexpandq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpexpandq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpexpandq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vplzcntd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vplzcntd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vplzcntd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vplzcntd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vplzcntd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vplzcntd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vplzcntd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vplzcntd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vplzcntd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vplzcntq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vplzcntq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vplzcntq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vplzcntq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vplzcntq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vplzcntq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vplzcntq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vplzcntq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vplzcntq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpmadd52huq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmadd52huq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmadd52huq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmadd52huq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmadd52huq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmadd52huq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmadd52huq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmadd52huq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmadd52huq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmadd52luq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmadd52luq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmadd52luq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmadd52luq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmadd52luq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmadd52luq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmadd52luq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmadd52luq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmadd52luq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpmovdb DWORD PTR [rax+0x4]{k1}, xmm2
    vpmovdb DWORD PTR [rax+0x2]{k1}, xmm2
    vpmovdb DWORD PTR [rax+0x1fc]{k1}, xmm2
    vpmovsdb DWORD PTR [rax+0x4]{k1}, xmm2
    vpmovsdb DWORD PTR [rax+0x2]{k1}, xmm2
    vpmovsdb DWORD PTR [rax+0x1fc]{k1}, xmm2
    vpmovusdb DWORD PTR [rax+0x4]{k1}, xmm2
    vpmovusdb DWORD PTR [rax+0x2]{k1}, xmm2
    vpmovusdb DWORD PTR [rax+0x1fc]{k1}, xmm2
    vpmovdb QWORD PTR [rax+0x8]{k1}, ymm2
    vpmovdb QWORD PTR [rax+0x4]{k1}, ymm2
    vpmovdb QWORD PTR [rax+0x3f8]{k1}, ymm2
    vpmovsdb QWORD PTR [rax+0x8]{k1}, ymm2
    vpmovsdb QWORD PTR [rax+0x4]{k1}, ymm2
    vpmovsdb QWORD PTR [rax+0x3f8]{k1}, ymm2
    vpmovusdb QWORD PTR [rax+0x8]{k1}, ymm2
    vpmovusdb QWORD PTR [rax+0x4]{k1}, ymm2
    vpmovusdb QWORD PTR [rax+0x3f8]{k1}, ymm2
    vpmovdb XMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovdb XMMWORD PTR [rax+0x8]{k1}, zmm2
    vpmovdb XMMWORD PTR [rax+0x7f0]{k1}, zmm2
    vpmovsdb XMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovsdb XMMWORD PTR [rax+0x8]{k1}, zmm2
    vpmovsdb XMMWORD PTR [rax+0x7f0]{k1}, zmm2
    vpmovusdb XMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovusdb XMMWORD PTR [rax+0x8]{k1}, zmm2
    vpmovusdb XMMWORD PTR [rax+0x7f0]{k1}, zmm2
    vpmovdw QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovdw QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovdw QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovsdw QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovsdw QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovsdw QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovusdw QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovusdw QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovusdw QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovdw XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovdw XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovdw XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovsdw XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovsdw XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovsdw XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovusdw XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovusdw XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovusdw XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovdw YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovdw YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovdw YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovsdw YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovsdw YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovsdw YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovusdw YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovusdw YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovusdw YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovqb WORD PTR [rax+0x2]{k1}, xmm2
    vpmovqb WORD PTR [rax+0x1]{k1}, xmm2
    vpmovqb WORD PTR [rax+0xfe]{k1}, xmm2
    vpmovsqb WORD PTR [rax+0x2]{k1}, xmm2
    vpmovsqb WORD PTR [rax+0x1]{k1}, xmm2
    vpmovsqb WORD PTR [rax+0xfe]{k1}, xmm2
    vpmovusqb WORD PTR [rax+0x2]{k1}, xmm2
    vpmovusqb WORD PTR [rax+0x1]{k1}, xmm2
    vpmovusqb WORD PTR [rax+0xfe]{k1}, xmm2
    vpmovqb DWORD PTR [rax+0x4]{k1}, ymm2
    vpmovqb DWORD PTR [rax+0x2]{k1}, ymm2
    vpmovqb DWORD PTR [rax+0x1fc]{k1}, ymm2
    vpmovsqb DWORD PTR [rax+0x4]{k1}, ymm2
    vpmovsqb DWORD PTR [rax+0x2]{k1}, ymm2
    vpmovsqb DWORD PTR [rax+0x1fc]{k1}, ymm2
    vpmovusqb DWORD PTR [rax+0x4]{k1}, ymm2
    vpmovusqb DWORD PTR [rax+0x2]{k1}, ymm2
    vpmovusqb DWORD PTR [rax+0x1fc]{k1}, ymm2
    vpmovqb QWORD PTR [rax+0x8]{k1}, zmm2
    vpmovqb QWORD PTR [rax+0x4]{k1}, zmm2
    vpmovqb QWORD PTR [rax+0x3f8]{k1}, zmm2
    vpmovsqb QWORD PTR [rax+0x8]{k1}, zmm2
    vpmovsqb QWORD PTR [rax+0x4]{k1}, zmm2
    vpmovsqb QWORD PTR [rax+0x3f8]{k1}, zmm2
    vpmovusqb QWORD PTR [rax+0x8]{k1}, zmm2
    vpmovusqb QWORD PTR [rax+0x4]{k1}, zmm2
    vpmovusqb QWORD PTR [rax+0x3f8]{k1}, zmm2
    vpmovqd XMMWORD PTR [rax+0x10]{k1}, xmm2
    vpmovqd XMMWORD PTR [rax+0x8]{k1}, xmm2
    vpmovqd XMMWORD PTR [rax+0x7f0]{k1}, xmm2
    vpmovsqd QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovsqd QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovsqd QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovusqd QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovusqd QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovusqd QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovqd XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovqd XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovqd XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovsqd XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovsqd XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovsqd XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovusqd XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovusqd XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovusqd XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovqd YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovqd YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovqd YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovsqd YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovsqd YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovsqd YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovusqd YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovusqd YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovusqd YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovqw DWORD PTR [rax+0x4]{k1}, xmm2
    vpmovqw DWORD PTR [rax+0x2]{k1}, xmm2
    vpmovqw DWORD PTR [rax+0x1fc]{k1}, xmm2
    vpmovsqw DWORD PTR [rax+0x4]{k1}, xmm2
    vpmovsqw DWORD PTR [rax+0x2]{k1}, xmm2
    vpmovsqw DWORD PTR [rax+0x1fc]{k1}, xmm2
    vpmovusqw DWORD PTR [rax+0x4]{k1}, xmm2
    vpmovusqw DWORD PTR [rax+0x2]{k1}, xmm2
    vpmovusqw DWORD PTR [rax+0x1fc]{k1}, xmm2
    vpmovqw QWORD PTR [rax+0x8]{k1}, ymm2
    vpmovqw QWORD PTR [rax+0x4]{k1}, ymm2
    vpmovqw QWORD PTR [rax+0x3f8]{k1}, ymm2
    vpmovsqw QWORD PTR [rax+0x8]{k1}, ymm2
    vpmovsqw QWORD PTR [rax+0x4]{k1}, ymm2
    vpmovsqw QWORD PTR [rax+0x3f8]{k1}, ymm2
    vpmovusqw QWORD PTR [rax+0x8]{k1}, ymm2
    vpmovusqw QWORD PTR [rax+0x4]{k1}, ymm2
    vpmovusqw QWORD PTR [rax+0x3f8]{k1}, ymm2
    vpmovqw XMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovqw XMMWORD PTR [rax+0x8]{k1}, zmm2
    vpmovqw XMMWORD PTR [rax+0x7f0]{k1}, zmm2
    vpmovsqw XMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovsqw XMMWORD PTR [rax+0x8]{k1}, zmm2
    vpmovsqw XMMWORD PTR [rax+0x7f0]{k1}, zmm2
    vpmovusqw XMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovusqw XMMWORD PTR [rax+0x8]{k1}, zmm2
    vpmovusqw XMMWORD PTR [rax+0x7f0]{k1}, zmm2
    vpmovwb QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovwb QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovwb QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovswb QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovswb QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovswb QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovuswb QWORD PTR [rax+0x8]{k1}, xmm2
    vpmovuswb QWORD PTR [rax+0x4]{k1}, xmm2
    vpmovuswb QWORD PTR [rax+0x3f8]{k1}, xmm2
    vpmovwb XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovwb XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovwb XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovswb XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovswb XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovswb XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovuswb XMMWORD PTR [rax+0x10]{k1}, ymm2
    vpmovuswb XMMWORD PTR [rax+0x8]{k1}, ymm2
    vpmovuswb XMMWORD PTR [rax+0x7f0]{k1}, ymm2
    vpmovwb YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovwb YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovwb YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovswb YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovswb YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovswb YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmovuswb YMMWORD PTR [rax+0x20]{k1}, zmm2
    vpmovuswb YMMWORD PTR [rax+0x10]{k1}, zmm2
    vpmovuswb YMMWORD PTR [rax+0xfe0]{k1}, zmm2
    vpmultishiftqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpmultishiftqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpmultishiftqb xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpmultishiftqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpmultishiftqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpmultishiftqb ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpmultishiftqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpmultishiftqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpmultishiftqb zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpopcntb xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpopcntb xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpopcntb xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpopcntb ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpopcntb ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpopcntb ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpopcntb zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpopcntb zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpopcntb zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpopcntw xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpopcntw xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpopcntw xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpopcntw ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpopcntw ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpopcntw ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpopcntw zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpopcntw zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpopcntw zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpopcntd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpopcntd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpopcntd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpopcntd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpopcntd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpopcntd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpopcntd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpopcntd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpopcntd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vpopcntq xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vpopcntq xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vpopcntq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vpopcntq ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vpopcntq ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vpopcntq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vpopcntq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vpopcntq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vpopcntq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vprolvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vprolvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vprolvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vprold xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vprold xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vprold xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vprolvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vprolvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vprolvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vprolq xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vprolq xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vprolq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vprolvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vprolvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vprolvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vprold ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vprold ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vprold ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vprolvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vprolvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vprolvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vprolq ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vprolq ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vprolq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vprolvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vprolvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vprolvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vprold zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vprold zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vprold zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vprolvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vprolvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vprolvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vprolq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vprolq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vprolq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vprorvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vprorvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vprorvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vprord xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vprord xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vprord xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vprorvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vprorvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vprorvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vprorq xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vprorq xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vprorq xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vprorvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vprorvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vprorvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vprord ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vprord ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vprord ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vprorvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vprorvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vprorvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vprorq ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vprorq ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vprorq ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vprorvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vprorvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vprorvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vprord zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vprord zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vprord zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vprorvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vprorvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vprorvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vprorq zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vprorq zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vprorq zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshldw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpshldw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpshldw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpshldw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpshldw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpshldw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpshldw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpshldw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpshldw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshldd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpshldd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpshldd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpshldd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpshldd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpshldd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpshldd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpshldd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpshldd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpshldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpshldq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpshldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpshldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpshldq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpshldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpshldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpshldq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshldvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshldvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshldvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshldvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshldvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshldvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshldvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshldvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshldvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshldvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshldvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshldvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshldvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshldvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshldvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshldvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshldvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshldvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshldvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshldvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshldvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshldvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshldvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshldvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshldvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshldvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshldvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshrdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpshrdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpshrdw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpshrdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpshrdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpshrdw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpshrdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpshrdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpshrdw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshrdd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpshrdd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpshrdd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpshrdd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpshrdd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpshrdd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpshrdd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpshrdd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpshrdd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshrdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpshrdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpshrdq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpshrdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpshrdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpshrdq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpshrdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpshrdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpshrdq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpshrdvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshrdvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshrdvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshrdvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshrdvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshrdvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshrdvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshrdvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshrdvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshrdvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshrdvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshrdvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshrdvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshrdvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshrdvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshrdvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshrdvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshrdvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshrdvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpshrdvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpshrdvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshrdvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpshrdvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpshrdvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshrdvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshrdvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshrdvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpshufbitqmb k1{k2}, xmm2, XMMWORD PTR [rax+0x10]
    vpshufbitqmb k1{k2}, xmm2, XMMWORD PTR [rax+0x8]
    vpshufbitqmb k1{k2}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpshufbitqmb k1{k2}, ymm2, YMMWORD PTR [rax+0x20]
    vpshufbitqmb k1{k2}, ymm2, YMMWORD PTR [rax+0x10]
    vpshufbitqmb k1{k2}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpshufbitqmb k1{k2}, zmm2, ZMMWORD PTR [rax+0x40]
    vpshufbitqmb k1{k2}, zmm2, ZMMWORD PTR [rax+0x20]
    vpshufbitqmb k1{k2}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsllvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsllvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsllvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsllvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsllvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsllvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsllvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsllvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsllvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsllvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsllvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsllvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsllvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsllvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsllvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsllvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsllvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsllvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsllvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsllvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsllvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsllvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsllvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsllvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsllvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsllvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsllvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsravw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsravw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsravw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsravw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsravw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsravw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsravw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsravw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsravw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsravd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsravd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsravd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsravd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsravd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsravd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsravd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsravd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsravd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsravq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsravq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsravq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsravq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsravq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsravq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsravq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsravq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsravq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsrlvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrlvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrlvw xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsrlvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsrlvw ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsrlvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsrlvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsrlvw zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsrlvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrlvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrlvd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsrlvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsrlvd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsrlvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsrlvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsrlvd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpsrlvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vpsrlvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vpsrlvq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vpsrlvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vpsrlvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vpsrlvq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vpsrlvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vpsrlvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vpsrlvq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vpternlogd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpternlogd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpternlogd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpternlogd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpternlogd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpternlogd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpternlogd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpternlogd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpternlogd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vpternlogq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vpternlogq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vpternlogq xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vpternlogq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vpternlogq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vpternlogq ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vpternlogq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vpternlogq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vpternlogq zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vptestmb k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestmb k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestmb k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestmb k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestmb k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestmb k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestmb k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestmb k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestmb k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestmw k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestmw k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestmw k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestmw k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestmw k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestmw k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestmw k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestmw k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestmw k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestmd k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestmd k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestmd k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestmd k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestmd k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestmd k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestmd k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestmd k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestmd k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestmq k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestmq k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestmq k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestmq k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestmq k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestmq k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestmq k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestmq k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestmq k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestnmb k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestnmb k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestnmb k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestnmb k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestnmb k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestnmb k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestnmb k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestnmb k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestnmb k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestnmw k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestnmw k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestnmw k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestnmw k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestnmw k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestnmw k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestnmw k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestnmw k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestnmw k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestnmd k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestnmd k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestnmd k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestnmd k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestnmd k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestnmd k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestnmd k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestnmd k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestnmd k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vptestnmq k2{k1}, xmm2, XMMWORD PTR [rax+0x10]
    vptestnmq k2{k1}, xmm2, XMMWORD PTR [rax+0x8]
    vptestnmq k2{k1}, xmm2, XMMWORD PTR [rax+0x7f0]
    vptestnmq k2{k1}, ymm2, YMMWORD PTR [rax+0x20]
    vptestnmq k2{k1}, ymm2, YMMWORD PTR [rax+0x10]
    vptestnmq k2{k1}, ymm2, YMMWORD PTR [rax+0xfe0]
    vptestnmq k2{k1}, zmm2, ZMMWORD PTR [rax+0x40]
    vptestnmq k2{k1}, zmm2, ZMMWORD PTR [rax+0x20]
    vptestnmq k2{k1}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vrangepd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vrangepd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vrangepd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vrangepd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vrangepd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vrangepd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vrangepd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vrangepd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vrangepd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vrangeps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10], 0x1
    vrangeps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8], 0x1
    vrangeps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0], 0x1
    vrangeps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vrangeps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vrangeps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vrangeps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vrangeps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vrangeps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vrangesd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8], 0x1
    vrangesd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4], 0x1
    vrangesd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8], 0x1
    vrangess xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4], 0x1
    vrangess xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2], 0x1
    vrangess xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vrcp14pd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vrcp14pd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vrcp14pd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vrcp14pd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vrcp14pd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vrcp14pd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vrcp14pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrcp14pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrcp14pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrcp14ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vrcp14ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vrcp14ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vrcp14ps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vrcp14ps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vrcp14ps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vrcp14ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrcp14ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrcp14ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrcp14sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vrcp14sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vrcp14sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vrcp14ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vrcp14ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vrcp14ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vrcpph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vrcpph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vrcpph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vrcpph ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vrcpph ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vrcpph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vrcpph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrcpph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrcpph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrcpsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vrcpsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vrcpsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vreducepd xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vreducepd xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vreducepd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vreducepd ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vreducepd ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vreducepd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vreducepd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vreducepd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vreducepd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vreduceph xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vreduceph xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vreduceph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vreduceph ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vreduceph ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vreduceph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vreduceph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vreduceph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vreduceph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vreduceps xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vreduceps xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vreduceps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vreduceps ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vreduceps ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vreduceps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vreduceps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vreduceps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vreduceps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vreducesh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2], 0x1
    vreducesh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1], 0x1
    vreducesh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe], 0x1
    vreducess xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4], 0x1
    vreducess xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2], 0x1
    vreducess xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vrndscalepd xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vrndscalepd xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vrndscalepd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vrndscalepd ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vrndscalepd ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vrndscalepd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vrndscalepd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vrndscalepd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vrndscalepd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vrndscaleph xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vrndscaleph xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vrndscaleph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vrndscaleph ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vrndscaleph ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vrndscaleph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vrndscaleph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vrndscaleph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vrndscaleph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vrndscaleps xmm1{k1}{z}, XMMWORD PTR [rax+0x10], 0x1
    vrndscaleps xmm1{k1}{z}, XMMWORD PTR [rax+0x8], 0x1
    vrndscaleps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0], 0x1
    vrndscaleps ymm1{k1}{z}, YMMWORD PTR [rax+0x20], 0x1
    vrndscaleps ymm1{k1}{z}, YMMWORD PTR [rax+0x10], 0x1
    vrndscaleps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0], 0x1
    vrndscaleps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40], 0x1
    vrndscaleps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20], 0x1
    vrndscaleps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0], 0x1
    vrndscalesd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8], 0x1
    vrndscalesd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4], 0x1
    vrndscalesd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8], 0x1
    vrndscalesh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2], 0x1
    vrndscalesh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1], 0x1
    vrndscalesh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe], 0x1
    vrndscaless xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4], 0x1
    vrndscaless xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2], 0x1
    vrndscaless xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc], 0x1
    vrsqrt14pd xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vrsqrt14pd xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vrsqrt14pd xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vrsqrt14pd ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vrsqrt14pd ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vrsqrt14pd ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vrsqrt14pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrsqrt14pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrsqrt14pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrsqrt14ps xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vrsqrt14ps xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vrsqrt14ps xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vrsqrt14ps ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vrsqrt14ps ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vrsqrt14ps ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vrsqrt14ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrsqrt14ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrsqrt14ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrsqrt14sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vrsqrt14sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vrsqrt14sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vrsqrt14ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vrsqrt14ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vrsqrt14ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vrsqrtph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vrsqrtph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vrsqrtph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vrsqrtph ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vrsqrtph ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vrsqrtph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vrsqrtph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrsqrtph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrsqrtph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrsqrtsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vrsqrtsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vrsqrtsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vscalefpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vscalefpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vscalefpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vscalefpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vscalefpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vscalefpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vscalefpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vscalefpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vscalefpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vscalefph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vscalefph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vscalefph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vscalefph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vscalefph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vscalefph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vscalefph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vscalefph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vscalefph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vscalefps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vscalefps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vscalefps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vscalefps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vscalefps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vscalefps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vscalefps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vscalefps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vscalefps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vscalefsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vscalefsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vscalefsd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vscalefsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vscalefsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vscalefsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vscalefss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vscalefss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vscalefss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vshuff32x4 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vshuff32x4 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vshuff32x4 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vshuff32x4 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vshuff32x4 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vshuff32x4 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vshuff64x2 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vshuff64x2 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vshuff64x2 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vshuff64x2 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vshuff64x2 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vshuff64x2 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vshufi32x4 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vshufi32x4 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vshufi32x4 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vshufi32x4 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vshufi32x4 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vshufi32x4 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vshufi64x2 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20], 0x1
    vshufi64x2 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10], 0x1
    vshufi64x2 ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0], 0x1
    vshufi64x2 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40], 0x1
    vshufi64x2 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20], 0x1
    vshufi64x2 zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0], 0x1
    vsqrtph xmm1{k1}{z}, XMMWORD PTR [rax+0x10]
    vsqrtph xmm1{k1}{z}, XMMWORD PTR [rax+0x8]
    vsqrtph xmm1{k1}{z}, XMMWORD PTR [rax+0x7f0]
    vsqrtph ymm1{k1}{z}, YMMWORD PTR [rax+0x20]
    vsqrtph ymm1{k1}{z}, YMMWORD PTR [rax+0x10]
    vsqrtph ymm1{k1}{z}, YMMWORD PTR [rax+0xfe0]
    vsqrtph zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vsqrtph zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vsqrtph zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vsqrtsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vsqrtsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vsqrtsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vsubph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vsubph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vsubph xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vsubph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vsubph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vsubph ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vsubph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vsubph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vsubph zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vsubsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x2]
    vsubsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0x1]
    vsubsh xmm1{k1}{z}, xmm2, WORD PTR [rax+0xfe]
    vucomish xmm1, WORD PTR [rax+0x2]
    vucomish xmm1, WORD PTR [rax+0x1]
    vucomish xmm1, WORD PTR [rax+0xfe]
    vxorpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vxorpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vxorpd xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vxorpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vxorpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vxorpd ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vxorpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vxorpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vxorpd zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    vxorps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    vxorps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    vxorps xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vxorps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x20]
    vxorps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0x10]
    vxorps ymm1{k1}{z}, ymm2, YMMWORD PTR [rax+0xfe0]
    vxorps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x40]
    vxorps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x20]
    vxorps zmm1{k1}{z}, zmm2, ZMMWORD PTR [rax+0x1fc0]
    v4fmaddps zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    v4fmaddps zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    v4fmaddps zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    v4fnmaddps zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    v4fnmaddps zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    v4fnmaddps zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    v4fmaddss xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    v4fmaddss xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    v4fmaddss xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    v4fnmaddss xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x10]
    v4fnmaddss xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x8]
    v4fnmaddss xmm1{k1}{z}, xmm2, XMMWORD PTR [rax+0x7f0]
    vexp2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vexp2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vexp2pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vexp2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vexp2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vexp2ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vp4dpwssds zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vp4dpwssds zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vp4dpwssds zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vp4dpwssd zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x10]
    vp4dpwssd zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x8]
    vp4dpwssd zmm1{k1}{z}, zmm2, XMMWORD PTR [rax+0x7f0]
    vrcp28pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrcp28pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrcp28pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrcp28sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vrcp28sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vrcp28sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vrcp28ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrcp28ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrcp28ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrcp28ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vrcp28ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vrcp28ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
    vrsqrt28pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrsqrt28pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrsqrt28pd zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrsqrt28sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x8]
    vrsqrt28sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x4]
    vrsqrt28sd xmm1{k1}{z}, xmm2, QWORD PTR [rax+0x3f8]
    vrsqrt28ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x40]
    vrsqrt28ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x20]
    vrsqrt28ps zmm1{k1}{z}, ZMMWORD PTR [rax+0x1fc0]
    vrsqrt28ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x4]
    vrsqrt28ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x2]
    vrsqrt28ss xmm1{k1}{z}, xmm2, DWORD PTR [rax+0x1fc]
