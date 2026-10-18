.intel_syntax noprefix
.text

# objdump가 출력한 대로 쓴 것
lss rcx,FWORD PTR [rax]
lfs edx,FWORD PTR [rax]
lgs ebx,FWORD PTR [rax]
