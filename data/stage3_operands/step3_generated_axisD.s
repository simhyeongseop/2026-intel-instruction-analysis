.intel_syntax noprefix
// Stage3 axis D (EVEX broadcast form D3: [rax]{1toK})

    vaddpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vaddpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vaddpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vaddps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vaddps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vaddps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vandnpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vandnpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vandnpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vandnps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vandnps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vandnps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vandpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vandpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vandpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vandps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vandps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vandps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vcmppd k1{k2}, xmm2, [rax]{1to2}, 0x1
    vcmppd k1{k2}, ymm2, [rax]{1to4}, 0x1
    vcmppd k1{k2}, zmm2, [rax]{1to8}, 0x1
    vcmpps k1{k2}, xmm2, [rax]{1to4}, 0x1
    vcmpps k1{k2}, ymm2, [rax]{1to8}, 0x1
    vcmpps k1{k2}, zmm2, [rax]{1to16}, 0x1
    vcvtdq2pd xmm1{k1}{z}, [rax]{1to2}
    vcvtdq2pd ymm1{k1}{z}, [rax]{1to4}
    vcvtdq2pd zmm1{k1}{z}, [rax]{1to8}
    vcvtdq2ps xmm1{k1}{z}, [rax]{1to4}
    vcvtdq2ps ymm1{k1}{z}, [rax]{1to8}
    vcvtdq2ps zmm1{k1}{z}, [rax]{1to16}
    vcvtpd2dq xmm1{k1}{z}, [rax]{1to2}
    vcvtpd2dq xmm1{k1}{z}, [rax]{1to4}
    vcvtpd2dq ymm1{k1}{z}, [rax]{1to8}
    vcvtpd2ps xmm1{k1}{z}, [rax]{1to2}
    vcvtpd2ps xmm1{k1}{z}, [rax]{1to4}
    vcvtpd2ps ymm1{k1}{z}, [rax]{1to8}
    vcvtps2dq xmm1{k1}{z}, [rax]{1to4}
    vcvtps2dq ymm1{k1}{z}, [rax]{1to8}
    vcvtps2dq zmm1{k1}{z}, [rax]{1to16}
    vcvtps2pd xmm1{k1}{z}, [rax]{1to2}
    vcvtps2pd ymm1{k1}{z}, [rax]{1to4}
    vcvtps2pd zmm1{k1}{z}, [rax]{1to8}
    vcvttpd2dq xmm1{k1}{z}, [rax]{1to2}
    vcvttpd2dq xmm1{k1}{z}, [rax]{1to4}
    vcvttpd2dq ymm1{k1}{z}, [rax]{1to8}
    vcvttps2dq xmm1{k1}{z}, [rax]{1to4}
    vcvttps2dq ymm1{k1}{z}, [rax]{1to8}
    vcvttps2dq zmm1{k1}{z}, [rax]{1to16}
    vdivpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vdivpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vdivpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vdivps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vdivps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vdivps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vgf2p8affineinvqb xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vgf2p8affineinvqb ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vgf2p8affineinvqb zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vgf2p8affineqb xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vgf2p8affineqb ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vgf2p8affineqb zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vmaxpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vmaxpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vmaxpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vmaxps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vmaxps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vmaxps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vminpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vminpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vminpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vminps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vminps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vminps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vmulpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vmulpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vmulpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vmulps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vmulps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vmulps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vorpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vorpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vorpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vorps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vorps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vorps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpabsd xmm1{k1}{z}, [rax]{1to4}
    vpabsd ymm1{k1}{z}, [rax]{1to8}
    vpabsd zmm1{k1}{z}, [rax]{1to16}
    vpabsq xmm1{k1}{z}, [rax]{1to2}
    vpabsq ymm1{k1}{z}, [rax]{1to4}
    vpabsq zmm1{k1}{z}, [rax]{1to8}
    vpackssdw xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpackssdw ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpackssdw zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpackusdw xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpackusdw ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpackusdw zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpaddd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpaddq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpaddd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpaddq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpaddd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpaddq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpandd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpandd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpandd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpandq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpandq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpandq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpandnd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpandnd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpandnd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpandnq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpandnq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpandnq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpcmpeqd k1{k2}, xmm2, [rax]{1to4}
    vpcmpeqd k1{k2}, ymm2, [rax]{1to8}
    vpcmpeqd k1{k2}, zmm2, [rax]{1to16}
    vpcmpeqq k1{k2}, xmm2, [rax]{1to2}
    vpcmpeqq k1{k2}, ymm2, [rax]{1to4}
    vpcmpeqq k1{k2}, zmm2, [rax]{1to8}
    vpcmpgtd k1{k2}, xmm2, [rax]{1to4}
    vpcmpgtd k1{k2}, ymm2, [rax]{1to8}
    vpcmpgtd k1{k2}, zmm2, [rax]{1to16}
    vpcmpgtq k1{k2}, xmm2, [rax]{1to2}
    vpcmpgtq k1{k2}, ymm2, [rax]{1to4}
    vpcmpgtq k1{k2}, zmm2, [rax]{1to8}
    vpmaxsd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpmaxsd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpmaxsd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpmaxsq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmaxsq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmaxsq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpmaxud xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpmaxud ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpmaxud zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpmaxuq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmaxuq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmaxuq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpminsd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpminsd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpminsd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpminsq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpminsq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpminsq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpminud xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpminud ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpminud zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpminuq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpminuq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpminuq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpmuldq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmuldq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmuldq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpmulld xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpmulld ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpmulld zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpmullq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmullq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmullq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpmuludq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmuludq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmuludq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpord xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpord ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpord zmm1{k1}{z}, zmm2, [rax]{1to16}
    vporq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vporq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vporq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpshufd xmm1{k1}{z}, [rax]{1to4}, 0x1
    vpshufd ymm1{k1}{z}, [rax]{1to8}, 0x1
    vpshufd zmm1{k1}{z}, [rax]{1to16}, 0x1
    vpslld xmm1{k1}{z}, [rax]{1to4}, 0x1
    vpslld ymm1{k1}{z}, [rax]{1to8}, 0x1
    vpslld zmm1{k1}{z}, [rax]{1to16}, 0x1
    vpsllq xmm1{k1}{z}, [rax]{1to2}, 0x1
    vpsllq ymm1{k1}{z}, [rax]{1to4}, 0x1
    vpsllq zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpsrad xmm1{k1}{z}, [rax]{1to4}, 0x1
    vpsrad ymm1{k1}{z}, [rax]{1to8}, 0x1
    vpsrad zmm1{k1}{z}, [rax]{1to16}, 0x1
    vpsraq xmm1{k1}{z}, [rax]{1to2}, 0x1
    vpsraq ymm1{k1}{z}, [rax]{1to4}, 0x1
    vpsraq zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpsrld xmm1{k1}{z}, [rax]{1to4}, 0x1
    vpsrld ymm1{k1}{z}, [rax]{1to8}, 0x1
    vpsrld zmm1{k1}{z}, [rax]{1to16}, 0x1
    vpsrlq xmm1{k1}{z}, [rax]{1to2}, 0x1
    vpsrlq ymm1{k1}{z}, [rax]{1to4}, 0x1
    vpsrlq zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpsubd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpsubd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpsubd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpsubq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpsubq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpsubq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpunpckhdq xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpunpckhqdq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpunpckhdq ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpunpckhqdq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpunpckhdq zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpunpckhqdq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpunpckldq xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpunpcklqdq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpunpckldq ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpunpcklqdq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpunpckldq zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpunpcklqdq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpxord xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpxord ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpxord zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpxorq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpxorq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpxorq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vshufpd xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vshufpd ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vshufpd zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vshufps xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    vshufps ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vshufps zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vsqrtpd xmm1{k1}{z}, [rax]{1to2}
    vsqrtpd ymm1{k1}{z}, [rax]{1to4}
    vsqrtpd zmm1{k1}{z}, [rax]{1to8}
    vsqrtps xmm1{k1}{z}, [rax]{1to4}
    vsqrtps ymm1{k1}{z}, [rax]{1to8}
    vsqrtps zmm1{k1}{z}, [rax]{1to16}
    vsubpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vsubpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vsubpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vsubps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vsubps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vsubps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vunpckhpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vunpckhpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vunpckhpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vunpckhps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vunpckhps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vunpckhps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vunpcklpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vunpcklpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vunpcklpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vunpcklps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vunpcklps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vunpcklps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vaddph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vaddph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vaddph zmm1{k1}{z}, zmm2, [rax]{1to32}
    valignd xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    valignq xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    valignd ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    valignq ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    valignd zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    valignq zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vblendmpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vblendmpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vblendmpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vblendmps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vblendmps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vblendmps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vcmpph k1{k2}, xmm2, [rax]{1to8}, 0x1
    vcmpph k1{k2}, ymm2, [rax]{1to16}, 0x1
    vcmpph k1{k2}, zmm2, [rax]{1to32}, 0x1
    vcvtdq2ph xmm1{k1}{z}, [rax]{1to4}
    vcvtdq2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtdq2ph ymm1{k1}{z}, [rax]{1to16}
    vcvtne2ps2bf16 xmm1{k1}{z}, xmm2, [rax]{1to4}
    vcvtne2ps2bf16 ymm1{k1}{z}, ymm2, [rax]{1to8}
    vcvtne2ps2bf16 zmm1{k1}{z}, zmm2, [rax]{1to16}
    vcvtneps2bf16 xmm1{k1}{z}, [rax]{1to4}
    vcvtneps2bf16 xmm1{k1}{z}, [rax]{1to8}
    vcvtneps2bf16 ymm1{k1}{z}, [rax]{1to16}
    vcvtpd2ph xmm1{k1}{z}, [rax]{1to2}
    vcvtpd2ph xmm1{k1}{z}, [rax]{1to4}
    vcvtpd2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtpd2qq xmm1{k1}{z}, [rax]{1to2}
    vcvtpd2qq ymm1{k1}{z}, [rax]{1to4}
    vcvtpd2qq zmm1{k1}{z}, [rax]{1to8}
    vcvtpd2udq xmm1{k1}{z}, [rax]{1to2}
    vcvtpd2udq xmm1{k1}{z}, [rax]{1to4}
    vcvtpd2udq ymm1{k1}{z}, [rax]{1to8}
    vcvtpd2uqq xmm1{k1}{z}, [rax]{1to2}
    vcvtpd2uqq ymm1{k1}{z}, [rax]{1to4}
    vcvtpd2uqq zmm1{k1}{z}, [rax]{1to8}
    vcvtph2dq xmm1{k1}{z}, [rax]{1to4}
    vcvtph2dq ymm1{k1}{z}, [rax]{1to8}
    vcvtph2dq zmm1{k1}{z}, [rax]{1to16}
    vcvtph2pd xmm1{k1}{z}, [rax]{1to2}
    vcvtph2pd ymm1{k1}{z}, [rax]{1to4}
    vcvtph2pd zmm1{k1}{z}, [rax]{1to8}
    vcvtph2psx xmm1{k1}{z}, [rax]{1to4}
    vcvtph2psx ymm1{k1}{z}, [rax]{1to8}
    vcvtph2psx zmm1{k1}{z}, [rax]{1to16}
    vcvtph2qq xmm1{k1}{z}, [rax]{1to2}
    vcvtph2qq ymm1{k1}{z}, [rax]{1to4}
    vcvtph2qq zmm1{k1}{z}, [rax]{1to8}
    vcvtph2udq xmm1{k1}{z}, [rax]{1to4}
    vcvtph2udq ymm1{k1}{z}, [rax]{1to8}
    vcvtph2udq zmm1{k1}{z}, [rax]{1to16}
    vcvtph2uqq xmm1{k1}{z}, [rax]{1to2}
    vcvtph2uqq ymm1{k1}{z}, [rax]{1to4}
    vcvtph2uqq zmm1{k1}{z}, [rax]{1to8}
    vcvtph2uw xmm1{k1}{z}, [rax]{1to8}
    vcvtph2uw ymm1{k1}{z}, [rax]{1to16}
    vcvtph2uw zmm1{k1}{z}, [rax]{1to32}
    vcvtph2w xmm1{k1}{z}, [rax]{1to8}
    vcvtph2w ymm1{k1}{z}, [rax]{1to16}
    vcvtph2w zmm1{k1}{z}, [rax]{1to32}
    vcvtps2phx xmm1{k1}{z}, [rax]{1to4}
    vcvtps2phx xmm1{k1}{z}, [rax]{1to8}
    vcvtps2phx ymm1{k1}{z}, [rax]{1to16}
    vcvtps2qq xmm1{k1}{z}, [rax]{1to2}
    vcvtps2qq ymm1{k1}{z}, [rax]{1to4}
    vcvtps2qq zmm1{k1}{z}, [rax]{1to8}
    vcvtps2udq xmm1{k1}{z}, [rax]{1to4}
    vcvtps2udq ymm1{k1}{z}, [rax]{1to8}
    vcvtps2udq zmm1{k1}{z}, [rax]{1to16}
    vcvtps2uqq xmm1{k1}{z}, [rax]{1to2}
    vcvtps2uqq ymm1{k1}{z}, [rax]{1to4}
    vcvtps2uqq zmm1{k1}{z}, [rax]{1to8}
    vcvtqq2pd xmm1{k1}{z}, [rax]{1to2}
    vcvtqq2pd ymm1{k1}{z}, [rax]{1to4}
    vcvtqq2pd zmm1{k1}{z}, [rax]{1to8}
    vcvtqq2ph xmm1{k1}{z}, [rax]{1to2}
    vcvtqq2ph xmm1{k1}{z}, [rax]{1to4}
    vcvtqq2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtqq2ps xmm1{k1}{z}, [rax]{1to2}
    vcvtqq2ps xmm1{k1}{z}, [rax]{1to4}
    vcvtqq2ps ymm1{k1}{z}, [rax]{1to8}
    vcvttpd2qq xmm1{k1}{z}, [rax]{1to2}
    vcvttpd2qq ymm1{k1}{z}, [rax]{1to4}
    vcvttpd2qq zmm1{k1}{z}, [rax]{1to8}
    vcvttpd2udq xmm1{k1}{z}, [rax]{1to2}
    vcvttpd2udq xmm1{k1}{z}, [rax]{1to4}
    vcvttpd2udq ymm1{k1}{z}, [rax]{1to8}
    vcvttpd2uqq xmm1{k1}{z}, [rax]{1to2}
    vcvttpd2uqq ymm1{k1}{z}, [rax]{1to4}
    vcvttpd2uqq zmm1{k1}{z}, [rax]{1to8}
    vcvttph2dq xmm1{k1}{z}, [rax]{1to4}
    vcvttph2dq ymm1{k1}{z}, [rax]{1to8}
    vcvttph2dq zmm1{k1}{z}, [rax]{1to16}
    vcvttph2qq xmm1{k1}{z}, [rax]{1to2}
    vcvttph2qq ymm1{k1}{z}, [rax]{1to4}
    vcvttph2qq zmm1{k1}{z}, [rax]{1to8}
    vcvttph2udq xmm1{k1}{z}, [rax]{1to4}
    vcvttph2udq ymm1{k1}{z}, [rax]{1to8}
    vcvttph2udq zmm1{k1}{z}, [rax]{1to16}
    vcvttph2uqq xmm1{k1}{z}, [rax]{1to2}
    vcvttph2uqq ymm1{k1}{z}, [rax]{1to4}
    vcvttph2uqq zmm1{k1}{z}, [rax]{1to8}
    vcvttph2uw xmm1{k1}{z}, [rax]{1to8}
    vcvttph2uw ymm1{k1}{z}, [rax]{1to16}
    vcvttph2uw zmm1{k1}{z}, [rax]{1to32}
    vcvttph2w xmm1{k1}{z}, [rax]{1to8}
    vcvttph2w ymm1{k1}{z}, [rax]{1to16}
    vcvttph2w zmm1{k1}{z}, [rax]{1to32}
    vcvttps2qq xmm1{k1}{z}, [rax]{1to2}
    vcvttps2qq ymm1{k1}{z}, [rax]{1to4}
    vcvttps2qq zmm1{k1}{z}, [rax]{1to8}
    vcvttps2udq xmm1{k1}{z}, [rax]{1to4}
    vcvttps2udq ymm1{k1}{z}, [rax]{1to8}
    vcvttps2udq zmm1{k1}{z}, [rax]{1to16}
    vcvttps2uqq xmm1{k1}{z}, [rax]{1to2}
    vcvttps2uqq ymm1{k1}{z}, [rax]{1to4}
    vcvttps2uqq zmm1{k1}{z}, [rax]{1to8}
    vcvtudq2pd xmm1{k1}{z}, [rax]{1to2}
    vcvtudq2pd ymm1{k1}{z}, [rax]{1to4}
    vcvtudq2pd zmm1{k1}{z}, [rax]{1to8}
    vcvtudq2ph xmm1{k1}{z}, [rax]{1to4}
    vcvtudq2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtudq2ph ymm1{k1}{z}, [rax]{1to16}
    vcvtudq2ps xmm1{k1}{z}, [rax]{1to4}
    vcvtudq2ps ymm1{k1}{z}, [rax]{1to8}
    vcvtudq2ps zmm1{k1}{z}, [rax]{1to16}
    vcvtuqq2pd xmm1{k1}{z}, [rax]{1to2}
    vcvtuqq2pd ymm1{k1}{z}, [rax]{1to4}
    vcvtuqq2pd zmm1{k1}{z}, [rax]{1to8}
    vcvtuqq2ph xmm1{k1}{z}, [rax]{1to2}
    vcvtuqq2ph xmm1{k1}{z}, [rax]{1to4}
    vcvtuqq2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtuqq2ps xmm1{k1}{z}, [rax]{1to2}
    vcvtuqq2ps xmm1{k1}{z}, [rax]{1to4}
    vcvtuqq2ps ymm1{k1}{z}, [rax]{1to8}
    vcvtuw2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtuw2ph ymm1{k1}{z}, [rax]{1to16}
    vcvtuw2ph zmm1{k1}{z}, [rax]{1to32}
    vcvtw2ph xmm1{k1}{z}, [rax]{1to8}
    vcvtw2ph ymm1{k1}{z}, [rax]{1to16}
    vcvtw2ph zmm1{k1}{z}, [rax]{1to32}
    vdivph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vdivph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vdivph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vdpbf16ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vdpbf16ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vdpbf16ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfcmaddcph xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfcmaddcph ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfcmaddcph zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmaddcph xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmaddcph ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmaddcph zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfcmulcph xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfcmulcph ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfcmulcph zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmulcph xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmulcph ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmulcph zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfixupimmpd xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vfixupimmpd ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vfixupimmpd zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vfixupimmps xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    vfixupimmps ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vfixupimmps zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vfmadd132pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmadd213pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmadd231pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmadd132pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmadd213pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmadd231pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmadd132pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmadd213pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmadd231pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmadd132ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmadd132ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmadd132ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmadd213ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmadd213ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmadd213ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmadd231ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmadd231ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmadd231ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfnmadd132ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfnmadd132ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfnmadd132ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfnmadd213ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfnmadd213ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfnmadd213ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfnmadd231ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfnmadd231ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfnmadd231ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmadd132ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmadd213ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmadd231ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmadd132ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmadd213ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmadd231ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmadd132ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmadd213ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmadd231ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmaddsub213pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmaddsub231pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmaddsub132pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmaddsub213pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmaddsub231pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmaddsub132pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmaddsub213pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmaddsub231pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmaddsub132pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmaddsub132ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmaddsub132ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmaddsub132ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmaddsub213ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmaddsub213ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmaddsub213ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmaddsub231ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmaddsub231ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmaddsub231ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmaddsub213ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmaddsub231ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmaddsub132ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmaddsub213ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmaddsub231ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmaddsub132ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmaddsub213ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmaddsub231ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmaddsub132ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmsub132pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmsub213pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmsub231pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmsub132pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmsub213pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmsub231pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmsub132pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmsub213pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmsub231pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmsub132ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmsub132ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmsub132ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmsub213ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmsub213ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmsub213ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmsub231ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmsub231ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmsub231ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfnmsub132ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfnmsub132ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfnmsub132ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfnmsub213ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfnmsub213ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfnmsub213ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfnmsub231ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfnmsub231ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfnmsub231ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmsub132ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmsub213ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmsub231ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmsub132ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmsub213ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmsub231ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmsub132ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmsub213ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmsub231ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmsubadd132pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmsubadd213pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmsubadd231pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfmsubadd132pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmsubadd213pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmsubadd231pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfmsubadd132pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmsubadd213pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmsubadd231pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfmsubadd132ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmsubadd132ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmsubadd132ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmsubadd213ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmsubadd213ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmsubadd213ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmsubadd231ph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vfmsubadd231ph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vfmsubadd231ph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vfmsubadd132ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmsubadd213ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmsubadd231ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfmsubadd132ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmsubadd213ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmsubadd231ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfmsubadd132ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmsubadd213ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfmsubadd231ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfnmadd132pd xmm0{k1}{z}, xmm1, [rax]{1to2}
    vfnmadd213pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfnmadd231pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfnmadd132pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfnmadd213pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfnmadd231pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfnmadd132pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfnmadd213pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfnmadd231pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfnmadd132ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfnmadd213ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfnmadd231ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfnmadd132ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfnmadd213ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfnmadd231ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfnmadd132ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfnmadd213ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfnmadd231ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfnmsub132pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfnmsub213pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfnmsub231pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vfnmsub132pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfnmsub213pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfnmsub231pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vfnmsub132pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfnmsub213pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfnmsub231pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vfnmsub132ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfnmsub213ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfnmsub231ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vfnmsub132ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfnmsub213ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfnmsub231ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vfnmsub132ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfnmsub213ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfnmsub231ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vfpclasspd k2{k1}, [rax]{1to2}, 0x1
    vfpclasspd k2{k1}, [rax]{1to4}, 0x1
    vfpclasspd k2{k1}, [rax]{1to8}, 0x1
    vfpclassph k1{k2}, [rax]{1to8}, 0x1
    vfpclassph k1{k2}, [rax]{1to16}, 0x1
    vfpclassph k1{k2}, [rax]{1to32}, 0x1
    vfpclassps k2{k1}, [rax]{1to4}, 0x1
    vfpclassps k2{k1}, [rax]{1to8}, 0x1
    vfpclassps k2{k1}, [rax]{1to16}, 0x1
    vgetexppd xmm1{k1}{z}, [rax]{1to2}
    vgetexppd ymm1{k1}{z}, [rax]{1to4}
    vgetexppd zmm1{k1}{z}, [rax]{1to8}
    vgetexpph xmm1{k1}{z}, [rax]{1to8}
    vgetexpph ymm1{k1}{z}, [rax]{1to16}
    vgetexpph zmm1{k1}{z}, [rax]{1to32}
    vgetexpps xmm1{k1}{z}, [rax]{1to4}
    vgetexpps ymm1{k1}{z}, [rax]{1to8}
    vgetexpps zmm1{k1}{z}, [rax]{1to16}
    vgetmantpd xmm1{k1}{z}, [rax]{1to2}, 0x1
    vgetmantpd ymm1{k1}{z}, [rax]{1to4}, 0x1
    vgetmantpd zmm1{k1}{z}, [rax]{1to8}, 0x1
    vgetmantph xmm1{k1}{z}, [rax]{1to8}, 0x1
    vgetmantph ymm1{k1}{z}, [rax]{1to16}, 0x1
    vgetmantph zmm1{k1}{z}, [rax]{1to32}, 0x1
    vgetmantps xmm1{k1}{z}, [rax]{1to4}, 0x1
    vgetmantps ymm1{k1}{z}, [rax]{1to8}, 0x1
    vgetmantps zmm1{k1}{z}, [rax]{1to16}, 0x1
    vmaxph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vmaxph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vmaxph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vminph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vminph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vminph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vmulph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vmulph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vmulph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vp2intersectd k2, xmm2, [rax]{1to4}
    vp2intersectd k2, ymm2, [rax]{1to8}
    vp2intersectd k2, zmm2, [rax]{1to16}
    vp2intersectq k2, xmm2, [rax]{1to2}
    vp2intersectq k2, ymm2, [rax]{1to4}
    vp2intersectq k2, zmm2, [rax]{1to8}
    vpblendmd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpblendmd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpblendmd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpblendmq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpblendmq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpblendmq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpcmpd k1{k2}, xmm2, [rax]{1to4}, 0x1
    vpcmpd k1{k2}, ymm2, [rax]{1to8}, 0x1
    vpcmpd k1{k2}, zmm2, [rax]{1to16}, 0x1
    vpcmpud k1{k2}, xmm2, [rax]{1to4}, 0x1
    vpcmpud k1{k2}, ymm2, [rax]{1to8}, 0x1
    vpcmpud k1{k2}, zmm2, [rax]{1to16}, 0x1
    vpcmpq k1{k2}, xmm2, [rax]{1to2}, 0x1
    vpcmpq k1{k2}, ymm2, [rax]{1to4}, 0x1
    vpcmpq k1{k2}, zmm2, [rax]{1to8}, 0x1
    vpcmpuq k1{k2}, xmm2, [rax]{1to2}, 0x1
    vpcmpuq k1{k2}, ymm2, [rax]{1to4}, 0x1
    vpcmpuq k1{k2}, zmm2, [rax]{1to8}, 0x1
    vpconflictd xmm1{k1}{z}, [rax]{1to4}
    vpconflictd ymm1{k1}{z}, [rax]{1to8}
    vpconflictd zmm1{k1}{z}, [rax]{1to16}
    vpconflictq xmm1{k1}{z}, [rax]{1to2}
    vpconflictq ymm1{k1}{z}, [rax]{1to4}
    vpconflictq zmm1{k1}{z}, [rax]{1to8}
    vpdpbusd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpdpbusd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpdpbusd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpdpbusds xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpdpbusds ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpdpbusds zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpdpwssd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpdpwssd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpdpwssd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpdpwssds xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpdpwssds ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpdpwssds zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermi2d xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpermi2d ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermi2d zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermi2q xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpermi2q ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermi2q zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpermi2ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpermi2ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermi2ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermi2pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpermi2pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermi2pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpermilpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpermilpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermilpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpermilpd xmm1{k1}{z}, [rax]{1to2}, 0x1
    vpermilpd ymm1{k1}{z}, [rax]{1to4}, 0x1
    vpermilpd zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpermilps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpermilps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermilps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermilps xmm1{k1}{z}, [rax]{1to4}, 0x1
    vpermilps ymm1{k1}{z}, [rax]{1to8}, 0x1
    vpermpd ymm1{k1}{z}, [rax]{1to4}, 0x1
    vpermpd zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpermpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpermps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermq ymm1{k1}{z}, [rax]{1to4}, 0x1
    vpermq zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpermq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpermt2d xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpermt2d ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermt2d zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermt2q xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpermt2q ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermt2q zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpermt2ps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpermt2ps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpermt2ps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpermt2pd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpermt2pd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpermt2pd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vplzcntd xmm1{k1}{z}, [rax]{1to4}
    vplzcntd ymm1{k1}{z}, [rax]{1to8}
    vplzcntd zmm1{k1}{z}, [rax]{1to16}
    vplzcntq xmm1{k1}{z}, [rax]{1to2}
    vplzcntq ymm1{k1}{z}, [rax]{1to4}
    vplzcntq zmm1{k1}{z}, [rax]{1to8}
    vpmadd52huq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmadd52huq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmadd52huq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpmadd52luq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmadd52luq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmadd52luq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpmultishiftqb xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpmultishiftqb ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpmultishiftqb zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpopcntd xmm1{k1}{z}, [rax]{1to4}
    vpopcntd ymm1{k1}{z}, [rax]{1to8}
    vpopcntd zmm1{k1}{z}, [rax]{1to16}
    vpopcntq xmm1{k1}{z}, [rax]{1to2}
    vpopcntq ymm1{k1}{z}, [rax]{1to4}
    vpopcntq zmm1{k1}{z}, [rax]{1to8}
    vprolvd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vprold xmm1{k1}{z}, [rax]{1to4}, 0x1
    vprolvq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vprolq xmm1{k1}{z}, [rax]{1to2}, 0x1
    vprolvd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vprold ymm1{k1}{z}, [rax]{1to8}, 0x1
    vprolvq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vprolq ymm1{k1}{z}, [rax]{1to4}, 0x1
    vprolvd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vprold zmm1{k1}{z}, [rax]{1to16}, 0x1
    vprolvq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vprolq zmm1{k1}{z}, [rax]{1to8}, 0x1
    vprorvd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vprord xmm1{k1}{z}, [rax]{1to4}, 0x1
    vprorvq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vprorq xmm1{k1}{z}, [rax]{1to2}, 0x1
    vprorvd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vprord ymm1{k1}{z}, [rax]{1to8}, 0x1
    vprorvq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vprorq ymm1{k1}{z}, [rax]{1to4}, 0x1
    vprorvd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vprord zmm1{k1}{z}, [rax]{1to16}, 0x1
    vprorvq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vprorq zmm1{k1}{z}, [rax]{1to8}, 0x1
    vpshldd xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    vpshldd ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vpshldd zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vpshldq xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vpshldq ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vpshldq zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vpshldvd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpshldvd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpshldvd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpshldvq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpshldvq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpshldvq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpshrdd xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    vpshrdd ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vpshrdd zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vpshrdq xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vpshrdq ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vpshrdq zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vpshrdvd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpshrdvd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpshrdvd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpshrdvq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpshrdvq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpshrdvq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpsllvd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpsllvd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpsllvd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpsllvq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpsllvq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpsllvq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpsravd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpsravd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpsravd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpsravq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpsravq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpsravq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpsrlvd xmm1{k1}{z}, xmm2, [rax]{1to4}
    vpsrlvd ymm1{k1}{z}, ymm2, [rax]{1to8}
    vpsrlvd zmm1{k1}{z}, zmm2, [rax]{1to16}
    vpsrlvq xmm1{k1}{z}, xmm2, [rax]{1to2}
    vpsrlvq ymm1{k1}{z}, ymm2, [rax]{1to4}
    vpsrlvq zmm1{k1}{z}, zmm2, [rax]{1to8}
    vpternlogd xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    vpternlogd ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vpternlogd zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vpternlogq xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vpternlogq ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vpternlogq zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vptestmd k2{k1}, xmm2, [rax]{1to4}
    vptestmd k2{k1}, ymm2, [rax]{1to8}
    vptestmd k2{k1}, zmm2, [rax]{1to16}
    vptestmq k2{k1}, xmm2, [rax]{1to2}
    vptestmq k2{k1}, ymm2, [rax]{1to4}
    vptestmq k2{k1}, zmm2, [rax]{1to8}
    vptestnmd k2{k1}, xmm2, [rax]{1to4}
    vptestnmd k2{k1}, ymm2, [rax]{1to8}
    vptestnmd k2{k1}, zmm2, [rax]{1to16}
    vptestnmq k2{k1}, xmm2, [rax]{1to2}
    vptestnmq k2{k1}, ymm2, [rax]{1to4}
    vptestnmq k2{k1}, zmm2, [rax]{1to8}
    vrangepd xmm1{k1}{z}, xmm2, [rax]{1to2}, 0x1
    vrangepd ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vrangepd zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vrangeps xmm1{k1}{z}, xmm2, [rax]{1to4}, 0x1
    vrangeps ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vrangeps zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vrcp14pd xmm1{k1}{z}, [rax]{1to2}
    vrcp14pd ymm1{k1}{z}, [rax]{1to4}
    vrcp14pd zmm1{k1}{z}, [rax]{1to8}
    vrcp14ps xmm1{k1}{z}, [rax]{1to4}
    vrcp14ps ymm1{k1}{z}, [rax]{1to8}
    vrcp14ps zmm1{k1}{z}, [rax]{1to16}
    vrcpph xmm1{k1}{z}, [rax]{1to8}
    vrcpph ymm1{k1}{z}, [rax]{1to16}
    vrcpph zmm1{k1}{z}, [rax]{1to32}
    vreducepd xmm1{k1}{z}, [rax]{1to2}, 0x1
    vreducepd ymm1{k1}{z}, [rax]{1to4}, 0x1
    vreducepd zmm1{k1}{z}, [rax]{1to8}, 0x1
    vreduceph xmm1{k1}{z}, [rax]{1to8}, 0x1
    vreduceph ymm1{k1}{z}, [rax]{1to16}, 0x1
    vreduceph zmm1{k1}{z}, [rax]{1to32}, 0x1
    vreduceps xmm1{k1}{z}, [rax]{1to4}, 0x1
    vreduceps ymm1{k1}{z}, [rax]{1to8}, 0x1
    vreduceps zmm1{k1}{z}, [rax]{1to16}, 0x1
    vrndscalepd xmm1{k1}{z}, [rax]{1to2}, 0x1
    vrndscalepd ymm1{k1}{z}, [rax]{1to4}, 0x1
    vrndscalepd zmm1{k1}{z}, [rax]{1to8}, 0x1
    vrndscaleph xmm1{k1}{z}, [rax]{1to8}, 0x1
    vrndscaleph ymm1{k1}{z}, [rax]{1to16}, 0x1
    vrndscaleph zmm1{k1}{z}, [rax]{1to32}, 0x1
    vrndscaleps xmm1{k1}{z}, [rax]{1to4}, 0x1
    vrndscaleps ymm1{k1}{z}, [rax]{1to8}, 0x1
    vrndscaleps zmm1{k1}{z}, [rax]{1to16}, 0x1
    vrsqrt14pd xmm1{k1}{z}, [rax]{1to2}
    vrsqrt14pd ymm1{k1}{z}, [rax]{1to4}
    vrsqrt14pd zmm1{k1}{z}, [rax]{1to8}
    vrsqrt14ps xmm1{k1}{z}, [rax]{1to4}
    vrsqrt14ps ymm1{k1}{z}, [rax]{1to8}
    vrsqrt14ps zmm1{k1}{z}, [rax]{1to16}
    vrsqrtph xmm1{k1}{z}, [rax]{1to8}
    vrsqrtph ymm1{k1}{z}, [rax]{1to16}
    vrsqrtph zmm1{k1}{z}, [rax]{1to32}
    vscalefpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vscalefpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vscalefpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vscalefph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vscalefph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vscalefph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vscalefps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vscalefps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vscalefps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vshuff32x4 ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vshuff32x4 zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vshuff64x2 ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vshuff64x2 zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vshufi32x4 ymm1{k1}{z}, ymm2, [rax]{1to8}, 0x1
    vshufi32x4 zmm1{k1}{z}, zmm2, [rax]{1to16}, 0x1
    vshufi64x2 ymm1{k1}{z}, ymm2, [rax]{1to4}, 0x1
    vshufi64x2 zmm1{k1}{z}, zmm2, [rax]{1to8}, 0x1
    vsqrtph xmm1{k1}{z}, [rax]{1to8}
    vsqrtph ymm1{k1}{z}, [rax]{1to16}
    vsqrtph zmm1{k1}{z}, [rax]{1to32}
    vsubph xmm1{k1}{z}, xmm2, [rax]{1to8}
    vsubph ymm1{k1}{z}, ymm2, [rax]{1to16}
    vsubph zmm1{k1}{z}, zmm2, [rax]{1to32}
    vxorpd xmm1{k1}{z}, xmm2, [rax]{1to2}
    vxorpd ymm1{k1}{z}, ymm2, [rax]{1to4}
    vxorpd zmm1{k1}{z}, zmm2, [rax]{1to8}
    vxorps xmm1{k1}{z}, xmm2, [rax]{1to4}
    vxorps ymm1{k1}{z}, ymm2, [rax]{1to8}
    vxorps zmm1{k1}{z}, zmm2, [rax]{1to16}
    vexp2pd zmm1{k1}{z}, [rax]{1to8}
    vexp2ps zmm1{k1}{z}, [rax]{1to16}
    vrcp28pd zmm1{k1}{z}, [rax]{1to8}
    vrcp28ps zmm1{k1}{z}, [rax]{1to16}
    vrsqrt28pd zmm1{k1}{z}, [rax]{1to8}
    vrsqrt28ps zmm1{k1}{z}, [rax]{1to16}
