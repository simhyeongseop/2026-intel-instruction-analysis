# MOV 88/89/8A/8B 44개 사례 검토 — Sol 초안 근거 요약 (2026-10-09)

산출물: `sol_draft.csv` (44행, 열 순서는 지시와 같음). 같은 폴더의 다른 파일은 열지 않았다.
코드·데이터·기존 산출물은 수정하지 않았다.

## 1. 대상 확인

- `out/generator_audit_2026-10-09_mode_address/combos.csv`에서 mnemonic=MOV이고 opcode에서 `REX.W + `를 뗀 첫 토큰이 88/89/8A/8B인 행을 골랐다. 정확히 **44개**다.
- SDM 행 8개(row_id 1087~1094)의 사례 수: MR 행(1087~1090)은 각 6개, RM 행(1091~1094)은 각 5개다.
  RM 행에 하나가 적은 이유: `distinct_register_combos`(m3_combine.py 636)가 RM 형식에서 만드는
  `[cl, byte ptr [eax]]`가 기본 조합과 같아 버려진다. MR 형식에서는 reg 자리만 바뀐 `[byte ptr [eax], dl]`이 새로 생긴다.
- 44개 모두 input_status=checked, input_violations·input_unverified 빈 값, test_kind=normal, mode_support=Valid.

## 2. 판정 총계

| 항목 | 합치 | 불일치 | 미확인 | 해당 없음 |
|---|---|---|---|---|
| static_verdict | 44 | 0 | 0 | 0 |
| encoding_verdict | 36 | 8 | 0 | 0 |
| check_count / check_kind / check_width / check_mode | 44 | 0 | 0 | 0 |
| check_direction | 28 | 0 | 16 | 0 |
| check_address | 16 | 0 | 12 | 16 |
| check_specific | 33 | 0 | 0 | 11 |

- encoding 불일치 8개: RM 행의 레지스터-레지스터 사례 전부
  (1666 `mov cl, cl`, 21611 `mov cl, dl`, 1668 `mov cx, cx`, 21612 `mov cx, dx`, 1670 `mov ecx, ecx`, 21613 `mov ecx, edx`,
  1672 `mov rcx, rcx`, 21614 `mov rcx, rdx`). as·clang 모두 88/89(MR) opcode를 냈다. 목표 8A/8B 바이트는 나오지 않았다.
  이것을 도구 결함이라고 판정하지 않는다. 생성된 문자열이 방향 쌍 중 하나를 지정할 수 없다는 생성 입력의 한계로 본다.
- check_direction 미확인 16개: 레지스터-레지스터 사례 전부(MR 8 + RM 8). MR 쪽 8개의 encoding '합치'는 도구가 기본으로
  MR을 고른 데서 나온 결과이므로 행을 지정했다는 증거가 아니다(CSV에 단서를 적었다).
- check_address 미확인 12개: `[eax]` 사례 전부(64비트 모드에서 67H로 32비트 주소를 쓰는 사례).
- 바이트 판정은 저장 관측 바이트를 검토용 작은 디코더(scratchpad, 66/67/REX + 1바이트 opcode + ModRM/SIB/disp)로 직접 풀어서 했다.
  저장 audit의 `encoding_status`를 그대로 옮기지 않았다. 디코더가 계산한 목표 바이트(예: `66 8b ca`, `48 8b ca`)는
  새 실측 `{load}` 결과와 같았다. 다만 디코더는 REX.R/X/B를 해석하지 않는다. 이번 44개의 REX는 모두 48이라 영향이 없다.
- 저장 audit 자체도 `unverified_fields`에 `ModRM_register_operands`를 남겨 두었다. reg/r-m 레지스터 자리는 이번 검토에서 처음 확인한 것이다.

## 3. 관측 연결

- 저장 관측: `out/generator_audit_2026-09-29_description_fix/encoding_audit.csv`(as·clang 각 44행).
  manifest.json에는 시각 필드가 없다. 파일 수정 시각은 2026-09-29 13:29 +0900이다.
  도구는 GNU as 2.42(`--64 -mintel64`), Ubuntu clang 18.1.3(`-target x86_64-linux-gnu -c -x assembler`), objdump 2.42.
- 44개 모두 combo_id·row_id·source 문자열·source_hash·form_hash·constraint_hash가 10-09 snapshot과 같다.
  09-29와 10-09 combos.csv에서 값이 다른 열은 generator_revision(v3→v4)뿐이다. 두 snapshot의 tests.s 해당 줄도 (revision 태그를 빼면) 같다.
  **연결 불일치는 없다.**
- 10-09 snapshot은 assemble_scope=none이다. encoding_audit.csv에는 헤더만 있고 관측은 없다.
- 새 실측(검토 중 2026-10-09 16:13 +0900 실행): 레지스터-레지스터 8개 소스에 접두 없음/`{load}`/`{store}`를 붙여 조립했다.
  as 2.42에서는 `{load}`→8A/8B, `{store}`→88/89가 나왔다. clang 18.1.3은 두 접두를 `unknown prefix`로 거부했다.
  접두가 없을 때의 바이트는 저장 관측과 같았다. CPU 실행은 하지 않았다.

## 4. 공통 규칙(common_rules.csv)에 대한 이견

1. **OPEN-02 (방향 쌍의 reg-reg 형식)**
   - 결론에는 동의한다. 문자열만으로는 행이 정해지지 않는다.
   - 다만 "목표 인코딩은 미확인"이라는 해석에는 동의하지 않는다. 바이트 관측이 있으므로 RM 행 8개는 **불일치**라고 확정할 수 있다.
     미확인으로 남길 것은 "그것이 결함인가"이다.
   - MR 행 8개는 바이트상 합치이지만 이 합치는 도구 기본값에 기댄 것이다. 판정을 둘로 나눠 적어야 한다.
   - 원문 근거로 든 2.1.2는 "opcode 안에 방향 필드가 있을 수 있다"는 일반 서술뿐이다. d비트의 구체적 정의는 Appendix B에 있으며 이번 범위에서 읽지 않았다.
   - conflicts 열의 "도구 선택 지시 미검증"에 대한 새 실측이 있다. as 2.42는 `{load}`/`{store}`로 고를 수 있지만 clang 18은 거부한다.
     따라서 두 도구가 공유하는 렌더링으로는 RM reg-reg 행을 맞출 방법이 아직 없다. 도구 문서 근거는 확인하지 않았다.
2. **ADDR-01 (64비트 모드의 [eax])**
   - 미확인 상태 유지에 동의한다.
   - 다만 conflicts 열이 놓친 원문이 있다. 2.2.1.4(파일 41쪽, 2-11)는 "the address-size default (64 bits in 64-bit mode)"라고 쓴다.
     즉 64비트 모드의 기본 주소 크기 64는 Vol.2에 명시되어 있다. 이 문장은 MOV moffs 문맥에 있다.
   - 부족한 것은 "67H가 일반 base 주소를 32비트로 바꾸고 잘라 zero-extend한다"는 일반 규정이다.
   - 3.1.1.5의 N.S. 설명(파일 109쪽)도 64비트 모드에서 address override prefix 사용을 언급한다. 하지만 N.S. 행에만 해당하므로 근거가 되지 못한다.
   - ModR/M 바이트 해석 자체(Table 2-2의 [EAX] = mod 00, r/m 000)는 2.2.1.3("existing 32-bit ModR/M and SIB encodings")으로 뒷받침된다.
     그래서 이번 검토에서는 encoding은 합치, 주소 의미만 미확인으로 나눴다.
3. **REX-01 (REX와 AH~BH)**
   - Table 3-1은 `+rb/+rw/+rd/+ro`처럼 opcode 하위 3비트에 레지스터를 넣는 경우의 표이다(3.1.1.1에서 표를 부르는 문장도 그렇다).
     ModR/M reg/r-m 자리의 근거로는 MOV 각주 1과 2.2.1.2(파일 39쪽 "REX prefixes provide an additional addressing capability for byte-registers")가 더 직접적이다.
   - 해석 열의 "인코딩할 수 없는 입력"은 과하다. 각주 1의 표현은 "REX가 있으면 같은 번호가 SPL/BPL/SIL/DIL에 접근한다"이다.
     바이트열은 존재하고, AH 이름으로 그 바이트를 쓸 수 없을 뿐이다. 따라서 "그 문자열을 인코딩할 수 없는 입력"으로 고쳐 쓰는 편이 정확하다.
   - 이번 44개에는 이 조건이 생기지 않는다(cl/dl만 사용).
4. **누락**
   - DB(`data/db/isa_db.csv`)에서 `r/m81`·`r81`의 각주 번호 1이 지워져 있다. 그래서 MOV 각주 1(REX/AH)이 행과 연결되지 않는다.
     규칙 REX-01이 이를 대신하지만 DB 쪽 연결은 없다.
   - 이 SDM 판의 MOV 표에는 `REX + 88 /r` 행이 없고 각주로만 처리되어 있다. 44개 선택 기준과 충돌하지는 않는다.
5. **PFX-01**
   - 동의한다. 2.2.1.2의 "If a 66H override is used with REX and REX.W = 0, the operand size is 16 bits"와
     r/m16 정의("operand-size attribute is 16 bits")를 같이 인용하면 근거가 더 단단해진다.
6. **MODE-01**: MOV 표는 "64-Bit Mode"와 "Compat/Leg Mode" 두 열로 나뉘어 있다(슬래시 표기가 아님). 예외 열의 설명과 맞는다. DB에는 Compat 열이 없다.
7. SYM-03 비고처럼 `byte/word/dword/qword ptr`은 도구 문법이다. SDM에는 대응 근거가 없다. check_width에서 "도구 문법"으로 따로 표시했다.

## 5. 생성 경로에 대한 관찰

- 생성 경로는 다음과 같다. 상세 줄 번호는 CSV code_refs 열에 있다.
  - 기본 조합: `expand_token`(378) → `expand_reg_or_mem`(341) → `memory_candidate`(292)이 `MEM_DEFAULT="[eax]"`(147)와 `MEM_SIZE_TO_PTR`(106)를 쓴다.
  - 변형: `build_variants`(529)가 `VARIANT_MEM_SIB`(204)와 `VARIANT_MEM_RIP`(205)로 바꾼다.
  - 슬롯 구분: `distinct_register_combos`(636)가 만든다.
  - 출력: `m4_generate.render_intel`(72)이 문자열을 그대로 붙인다.
- `generation_contract.validate_generated`(118)는 오퍼랜드를 하나씩 형식 대조한다.
  - 방향 쌍의 reg-reg 모호성, 64비트 모드 `[eax]`의 주소 크기, REX/AH 제약은 검사하지 않는다.
  - 그래서 44개 모두 `checked`로 나온다. `checked`는 "행 인코딩에 도달 가능"을 뜻하지 않는다.
- 기본 조합의 `cl, cl` 같은 같은 레지스터 반복은 reg/r-m 자리가 바뀌어도 바이트(c9)가 같다. 자리 배치 검증력이 없다.
  slot 구분 변형(21603~)이 이를 보완하지만, RM 메모리 형식에는 구분 변형이 없다.
- MR 행과 RM 행이 같은 소스 문자열을 공유한다(`mov cl, cl`이 1658과 1666, `mov cl, dl`이 21603과 21611 등 8쌍).
  같은 문자열이 두 행의 사례로 동시에 들어 있다는 점을 집계에서 주의해야 한다.

## 6. 판단이 어려웠던 지점

- MR reg-reg 8개의 encoding 판정. 바이트는 목표와 같으므로 '합치'로 두었다. 그러나 근거는 도구의 기본 선택이고 소스가 행을 지정한 것이 아니다.
  '미확인'으로 두는 견해도 가능하다. 주 검토와 비교할 때 이 8개를 따로 보기를 권한다.
- RM reg-reg 8개를 '불일치'로 둔 것. 바이트 사실로서 불일치이며, 의미상 같은 이동이다. 발견 유형(생성 입력 한계 vs 도구 결함)은 확정하지 않았다.
- `[eax]`의 67H를 encoding 판정에 넣을지. 지시된 목표 필드(opcode, REX.W/66H, ModR/M 자리)에 67H가 없으므로 encoding은 합치로 두고, 주소 의미만 check_address에서 미확인으로 분리했다.

## 7. 확인하지 못한 조건

- CPU 실행 의미(이동 결과, #GP/#SS/#PF/#AC 예외, LOCK 시 #UD). 실행하지 않았다.
- 64비트 모드에서 67H가 일반 base 주소에 미치는 효과의 원문 근거(Vol.1 3.3.7 계열, 이번 범위 밖).
- Appendix B의 opcode d/w 비트 정의(방향 필드의 구체적 근거).
- GNU as `{load}`/`{store}`의 공식 문서 근거와 clang의 대체 문법 유무. 새 실측만 있다.
- 생성되지 않은 조건: AH/BH/CH/DH, SPL/BPL/SIL/DIL, R8~R15(REX.R/REX.B), REX와 AH 충돌 입력, 16비트 주소(67H in 32-bit) 등.
- objdump 역어셈블 표시(roundtrip)는 이번 검토 범위 밖이다.
