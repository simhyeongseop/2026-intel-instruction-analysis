#!/bin/bash
# 실제 도구 실행 출력을 발표용 텍스트로 남긴다. 줄 형식: "$ 명령" 다음 출력.
export PATH=$HOME/opt/binutils-2.47/bin:$HOME/opt/llvm-23.1.3/bin:$PATH
W=$(mktemp -d); cd $W
hdr='.intel_syntax noprefix'
gas(){ printf '%s\n%s\n' "$hdr" "$1" > a.s; as --64 -mintel64 -o a.o a.s 2>&1 | sed -n '2p' | sed 's/^a.s:[0-9]*: //'; }
gdis(){ objdump -d -M "$1,intel64" a.o | awk -F'\t' '/^ +[0-9a-f]+:/{gsub(/ +$/,"",$2); gsub(/ +/," ",$3); print "  " $2 "   " $3}'; }
mcasm(){ echo "$2" | llvm-mc -triple=x86_64 $1 -show-encoding 2>&1 | grep -v '\.text' | sed -E 's/^\s+//; s/\s+# encoding:/   # encoding:/; s/\t/ /g' | head -3; }
mcdis(){ echo "$2" | llvm-mc -triple=x86_64 --disassemble $1 2>&1 | grep -v '\.text' | sed -E 's/^\s+//; s/\t/ /g'; }

c1(){ # 라벨 분기
echo "\$ as (Intel)   ja .Ltarget        # .Ltarget = 이 명령 자리"
printf '%s\n.Ltarget:\nja .Ltarget\n' "$hdr" > a.s; as --64 -mintel64 -o a.o a.s; gdis intel
echo "\$ 푼 글자 그대로 다시 as:   ja 0x0        # 0x0 = 주소 0"
printf '%s\nja 0x0\n' "$hdr" > a.s; as --64 -mintel64 -o a.o a.s; gdis intel
echo "\$ 숫자를 라벨로 되돌려 다시 as:   ja .Ltarget"
printf '%s\n.Ltarget:\nja .Ltarget\n' "$hdr" > a.s; as --64 -mintel64 -o a.o a.s; gdis intel
}
c2(){ # FWORD
echo "\$ as (Intel)   lss rcx, tbyte ptr [rax]      # 매뉴얼: REX.W 0F B2  LSS r64,m16:64"
gas 'lss rcx, tbyte ptr [rax]'; gdis intel
echo "\$ objdump 글자를 다시 as로:  lss rcx,FWORD PTR [rax]"
printf '%s\n%s\n' "$hdr" 'lss rcx,FWORD PTR [rax]' > a.s; as --64 -mintel64 -o a.o a.s 2>&1 | sed -n '2p' | sed 's/^a.s:[0-9]*: /  /'
}
c3(){ # 적는 법
echo "\$ llvm-mc (Intel)   adc al, 0x12"; mcasm "-x86-asm-syntax=intel -output-asm-variant=1" 'adc al, 0x12'
echo "\$ llvm-mc (Intel)   cmovng cx, dx"; mcasm "-x86-asm-syntax=intel -output-asm-variant=1" 'cmovng cx, dx'
echo "\$ as + objdump (Intel)   mov eax, [rbp]"; gas 'mov eax, [rbp]'; gdis intel
}
c4(){ # VPCMP
echo "\$ as (Intel)   vpcmpb k0, xmm0, xmm1, 0x0      # 매뉴얼: EVEX 0F3A 3F /r ib"
gas 'vpcmpb k0, xmm0, xmm1, 0x0'; gdis intel
echo "\$ 다시 as:   vpcmpeqb k0,xmm0,xmm1"
gas 'vpcmpeqb k0,xmm0,xmm1'; gdis intel
}
c5(){ # 먼 CALL
echo "\$ llvm-mc (Intel)   call fword ptr [rax]      # 매뉴얼: FF /3  CALL m16:32 (먼 호출)"
mcasm "-x86-asm-syntax=intel -output-asm-variant=1" 'call fword ptr [rax]'
echo "\$ llvm-mc 풀기 (Intel)   ff 18"; echo "  $(mcdis -output-asm-variant=1 '0xff 0x18')"
echo "\$ 다시 조립:   call [rax]"
mcasm "-x86-asm-syntax=intel -output-asm-variant=1" 'call [rax]'
echo "\$ llvm-mc 풀기 (AT&T)   ff 18"; echo "  $(mcdis '' '0xff 0x18')"
}
c6(){ # 크기 사라짐
for b in "0x66 0x9c" "0x0f 0xa0"; do
echo "\$ llvm-mc 풀기 (Intel)   $b"; t=$(mcdis -output-asm-variant=1 "$b"); echo "  $t"
echo "\$ 다시 조립:   $t"; mcasm "-x86-asm-syntax=intel -output-asm-variant=1" "$t"; done
echo "\$ llvm-mc 풀기 (AT&T)   0x66 0x9c"; echo "  $(mcdis '' '0x66 0x9c')"
}
c7(){ # 같은 소스, clang Intel만 16비트
for s in 'push fs' 'iret'; do
echo "\$ as (Intel)   $s"; gas "$s"; gdis intel
echo "\$ llvm-mc (Intel)   $s"; mcasm "-x86-asm-syntax=intel -output-asm-variant=1 -show-inst" "$s" | sed -E 's/# <MCInst #[0-9]+ /# 고른 정의: /; s/>$//'
done
a='push %fs'; echo "\$ llvm-mc (AT&T)   $a"; mcasm "-show-inst" "$a" | sed -E 's/# <MCInst #[0-9]+ /# 고른 정의: /; s/>$//'
}
c8(){ # rn-sae
s='vcvtsi2sd xmm0, xmm1, rcx, {rn-sae}'
echo "\$ as (Intel)   $s      # 매뉴얼 표: r/m64{er}"; gas "$s"; gdis intel
echo "\$ llvm-mc (Intel)   $s"; mcasm "-x86-asm-syntax=intel -output-asm-variant=1" "$s" | head -1
s='vcvtsi2sd xmm0, xmm1, {rn-sae}, rcx'
echo "\$ llvm-mc (Intel)   $s"; mcasm "-x86-asm-syntax=intel -output-asm-variant=1" "$s"
}
"$1"
