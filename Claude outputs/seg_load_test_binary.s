.text
# LSS r64, m80 (REX.W + 0F B2 /r)
# 바이트: 48 0f b2 08 (ModRM: 08 = [rax])
.byte 0x48, 0x0f, 0xb2, 0x08

# LFS r32, m48 (0F B4 /r)
# 바이트: 0f b4 10 (ModRM: 10 = [rax])
.byte 0x0f, 0xb4, 0x10

# LGS r32, m48 (0F B5 /r)
# 바이트: 0f b5 18 (ModRM: 18 = [rax])
.byte 0x0f, 0xb5, 0x18
