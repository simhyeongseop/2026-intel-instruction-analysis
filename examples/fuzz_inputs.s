# 각 줄을 독립적으로 검사하는 예제. 이 파일 자체를 CPU에서 실행하는 예제가 아니다.
.intel_syntax noprefix
mov eax, ebx
mov eax, rbx
lss rcx, tbyte ptr [eax]
lar rcx, rcx
udb
mov eax, dword ptr [external_symbol]
