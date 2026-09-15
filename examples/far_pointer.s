# 80비트 포인터를 objdump가 어떻게 표시하는지 확인하는 예제.
.intel_syntax noprefix
lss rcx, tbyte ptr [eax]
