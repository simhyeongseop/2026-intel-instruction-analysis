.intel_syntax noprefix
// Stage3 negative set (N1: gather aliasing #UD, N2: VP2INTERSECT odd-k)

    vgatherdpd xmm2, [rax+xmm2*1], xmm3
    vgatherqpd xmm2, [rax+xmm2*1], xmm3
    vgatherdpd ymm2, [rax+xmm2*1], ymm3
    vgatherqpd ymm2, [rax+ymm2*1], ymm3
    vgatherdps xmm2{k1}, [rax+xmm2*1]
    vgatherdps ymm2{k1}, [rax+ymm2*1]
    vgatherdps zmm2{k1}, [rax+zmm2*1]
    vgatherdpd xmm2{k1}, [rax+xmm2*1]
    vgatherdpd ymm2{k1}, [rax+xmm2*1]
    vgatherdpd zmm2{k1}, [rax+ymm2*1]
    vgatherdps xmm2, [rax+xmm2*1], xmm3
    vgatherqps xmm2, [rax+xmm2*1], xmm3
    vgatherdps ymm2, [rax+ymm2*1], ymm3
    vgatherqps xmm2, [rax+ymm2*1], xmm3
    vgatherqps xmm2{k1}, [rax+xmm2*1]
    vgatherqps xmm2{k1}, [rax+ymm2*1]
    vgatherqps ymm2{k1}, [rax+zmm2*1]
    vgatherqpd xmm2{k1}, [rax+xmm2*1]
    vgatherqpd ymm2{k1}, [rax+ymm2*1]
    vgatherqpd zmm2{k1}, [rax+zmm2*1]
    vpgatherdd xmm2{k1}, [rax+xmm2*1]
    vpgatherdd ymm2{k1}, [rax+ymm2*1]
    vpgatherdd zmm2{k1}, [rax+zmm2*1]
    vpgatherdq xmm2{k1}, [rax+xmm2*1]
    vpgatherdq ymm2{k1}, [rax+xmm2*1]
    vpgatherdq zmm2{k1}, [rax+ymm2*1]
    vpgatherdd xmm2, [rax+xmm2*1], xmm3
    vpgatherqd xmm2, [rax+xmm2*1], xmm3
    vpgatherdd ymm2, [rax+ymm2*1], ymm3
    vpgatherqd xmm2, [rax+ymm2*1], xmm3
    vpgatherdq xmm2, [rax+xmm2*1], xmm3
    vpgatherqq xmm2, [rax+xmm2*1], xmm3
    vpgatherdq ymm2, [rax+xmm2*1], ymm3
    vpgatherqq ymm2, [rax+ymm2*1], ymm3
    vpgatherqd xmm2{k1}, [rax+xmm2*1]
    vpgatherqd xmm2{k1}, [rax+ymm2*1]
    vpgatherqd ymm2{k1}, [rax+zmm2*1]
    vpgatherqq xmm2{k1}, [rax+xmm2*1]
    vpgatherqq ymm2{k1}, [rax+ymm2*1]
    vpgatherqq zmm2{k1}, [rax+zmm2*1]
    vp2intersectd k1, xmm2, xmm3
    vp2intersectd k1, ymm2, ymm3
    vp2intersectd k1, zmm2, zmm3
    vp2intersectq k1, xmm2, xmm3
    vp2intersectq k1, ymm2, ymm3
    vp2intersectq k1, zmm2, zmm3
