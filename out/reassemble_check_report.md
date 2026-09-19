# 바이트 라운드트립 검증 (10단계 reassemble_check)

roundtrip(6단계)에서 'different'로 나온 각 줄에 대해, objdump가 보여준
역어셈블 텍스트를 다시 GNU as로 어셈블해서 원본과 바이트가 같은지 확인했다.

대상: 9377건

| 카테고리 | 건수 | 의미 |
|---|---|---|
| byte_roundtrip_same | 9237 | 재어셈블 바이트가 원본과 동일 - 바이트 보존 관측. 원본 의미/false_alarm 확정과는 구분 |
| byte_roundtrip_diff | 7 | 재어셈블 바이트가 원본과 다름 - 진짜 의미 차이일 가능성, 개별 확인 필요 |
| relative_target_reassembly_artifact | 99 | 상대분기 라벨->절대주소 표시를 재어셈블하면 relocation이 생겨 바이트가 달라짐 - 이 방법으로는 디스어셈블러 버그 여부 판정 불가 |
| reassemble_failed | 34 | objdump 텍스트를 그대로 다시 어셈블 못 함(예: {evex} 태그, 세그먼트 접두어 등) |

## byte_roundtrip_diff 사례 (최대 50건)

| combo_id | mnemonic | asm_line | objdump_line | orig_bytes | reassembled_bytes |
|---|---|---|---|---|---|
| 3334 | prefetchit0 | `prefetchit0 byte ptr [eax]` | `nop    DWORD PTR [eax]` | `670f1838` | `670f1f00` |
| 11862 | prefetchit0 | `prefetchit0 byte ptr [rax+rbx*4+0x10]` | `nop    DWORD PTR [rax+rbx*4+0x10]` | `0f187c9810` | `0f1f449810` |
| 3335 | prefetchit1 | `prefetchit1 byte ptr [eax]` | `nop    DWORD PTR [eax]` | `670f1830` | `670f1f00` |
| 11864 | prefetchit1 | `prefetchit1 byte ptr [rax+rbx*4+0x10]` | `nop    DWORD PTR [rax+rbx*4+0x10]` | `0f18749810` | `0f1f449810` |
| 4568 | tileloadd | `tileloadd tmm0, [eax]` | `tileloadd tmm0,[eax+eiz*1]` | `67c4e27b4b0420` | `67c4e27b4b842000000000` |
| 4569 | tileloaddt1 | `tileloaddt1 tmm0, [eax]` | `tileloaddt1 tmm0,[eax+eiz*1]` | `67c4e2794b0420` | `67c4e2794b842000000000` |
| 4571 | tilestored | `tilestored [eax], tmm0` | `tilestored [eax+eiz*1],tmm0` | `67c4e27a4b0420` | `67c4e27a4b842000000000` |

