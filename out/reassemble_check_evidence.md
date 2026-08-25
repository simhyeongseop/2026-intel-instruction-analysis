# 10단계(바이트 라운드트립 검증) 핵심 발견 (codex 검증 반영, 정정본)

8회 미팅 후속 과제 2번("컴파일 성공 여부만 보지 말고 실제로 의도한 대로 변환됐는지 검증")의
결과다. `out/reassemble_check.csv`의 `byte_roundtrip_diff`(5건)를 직접 확인했다.

## ⚠️ 철회: "PREFETCHIT0/1을 objdump가 nop으로 표시" — 이건 버그가 아니라 정상 동작이었다

처음엔 이걸 "objdump가 니모닉을 못 알아본다"는 새 발견으로 썼는데, codex 검증에서 두 가지를
지적받고 확인해보니 **완전히 틀린 주장**이었다:
1. SDM은 PREFETCHIT0/PREFETCHIT1이 **RIP-relative 메모리 오퍼랜드에서만** 유효하고, 그 외
   주소 형식(우리 테스트처럼 `[eax]`, RIP-relative 아님)이면 **NOP로 동작한다고 명시**한다.
   즉 objdump가 "nop"으로 보여준 게 정확히 SDM이 정의한 동작이다.
2. 게다가 이건 이미 **`out/triage_report.md`(이전 라운드)에 정확히 이 이유로 `false_alarm`
   처리까지 돼 있던 것**이었다(270~273번째 줄) — "generator가 RIP-relative가 아닌 [eax]를
   써서 objdump가 'nop'으로 보여주는 것은 SDM에 문서화된 정상 동작... 버그 아님". 기존
   보고서를 먼저 확인했으면 안 낼 주장이었다.

**교훈:** 새 카테고리에서 "흥미로운 사례"를 볼 때마다, 그 니모닉이 이미 `out/triage_report.md`에
언급됐는지 먼저 검색해야 한다 — 이번엔 다행히 codex가 이 단계에서 바로 잡아줬다.

## 발견 — LSS/LFS/LGS의 REX.W(64비트) 형태를 objdump가 FWORD PTR(6바이트)로 잘못 표시함 (codex 검증 통과)

```
소스: lss rcx, m16:64 형태(REX.W 필요)   ->  as가 만든 바이트: 67 48 0f b2 08

objdump -d -M intel 결과:
  67 48 0f b2 08   lss    rcx,FWORD PTR [eax]
```
- ModRM `0x08` = `00 001 000` → reg=1(rcx), rm=0([eax]). `48`=REX.W. `data/db/isa_db.csv`
  (SDM p.658): `REX.W + 0F B2 /r  LSS r64,m16:64` — Valid. **인코딩은 SDM과 정확히 일치**
  (REX.W 있음, 올바른 opcode/ModRM) — codex가 바이트 크기 계산까지 재확인함.
- 문제는 크기 표시: m16:64(2바이트 셀렉터+8바이트 오프셋=10바이트)는 관례상 `TBYTE PTR`로
  표시돼야 하는데, objdump는 REX.W 유무와 무관하게 **항상 FWORD PTR(6바이트, m16:32에 해당하는
  크기)로 표시**한다 — REX.W가 있으면 크기가 달라져야 하는데 objdump가 이를 반영하지 않는다.
- **간접 증거:** 이 objdump 텍스트("lss rcx, fword ptr [eax]")를 그대로 다시 어셈블하면
  `as`가 **"incorrect register `rcx' used with `l' suffix"로 거부**한다(`out/reassemble_check.csv`의
  `reassemble_failed` 카테고리, combo 1527/1532/1535 — LSS/LFS/LGS 전부 동일 패턴; `l` 접미어는
  AT&T 표기 관례상 4바이트/32비트를 뜻하는데, `as`의 내부 타입 체크가 Intel-syntax 모드에서도
  이 관례로 FWORD를 취급한다는 뜻으로 보인다). 즉 `as` 자신도 "rcx엔 FWORD가 아니라 TBYTE가
  맞다"고 알고 있다는 뜻 — objdump의 표시만 잘못됐다는 걸 `as`가 역으로 확인해주는 셈이다.
- **의미:** LAR/LSL/MOV Sreg처럼 이 프로젝트가 이미 여러 번 발견한 "64비트 확장 레지스터
  폭 처리"의 또 다른 사례이지만, 이번엔 원인이 `as`(인코딩은 맞음)가 아니라 `objdump`(표시가
  틀림) 쪽이라는 게 다르다. **이 프로젝트에서 처음으로 확인된 "objdump 자체의 디스어셈블
  표시 결함" 후보다.**
- 이것도 PREFETCHIT0/1 실수를 반복하지 않기 위해 `out/triage_report.md`를 검색했다 — LSS/LFS/LGS
  (combo 1527/1532/1535)는 이미 `register_width/name_changed` 카테고리에 `verdict=unsure`로
  올라가 있었다("판단보류"). 즉 완전히 새로운 발견이 아니라 **이전에 판단보류였던 것을 이번
  라운드에서 원인(objdump의 REX.W 무시)까지 확정한 것**이다(codex 지적으로 정정).
  `pipeline/m7_triage.py`에 이 3건 전용 override를 추가해 `unsure` → `bug`(카테고리
  `objdump_farptr_size_ignores_rexw`)로 갱신했다.

## relative_target_reassembly_artifact(99건) — 원인 정정: short/near 선택이 아니라 relocation

원래 "as가 짧은 점프인지 몰라서 near(4바이트) 인코딩을 고른다"고 설명했는데, codex 검증
2라운드에 걸쳐 더 정확한 원인으로 정정됐다:
1. (1차 정정) `.Ltarget` 라벨이 사라지고 objdump가 보여준 절대주소 숫자(`0x0`)만 재어셈블
   대상으로 남으면, `as`는 그 값을 위치독립적으로 확정할 수 없어 **재배치(relocation)** 를
   생성한다 — `0x0`은 "심볼 참조"가 아니라 절대주소 상수이지만, GAS가 이걸 그 자리에서
   바로 확정 못 해서 재배치 정보를 남기는 것이다(codex 2차 검증에서 "심볼 참조"라는 표현이
   부정확하다고 재지적받아 "절대주소 상수"로 정정).
2. (2차 정정) "그러니 진짜 의미 차이가 아니다"도 엄밀히는 과장이었다 — 원본의 `.Ltarget`은
   섹션 내부 상대 라벨인데 재어셈블된 값은 절대주소이므로, 링크 이후 실제 의미가 달라질 수
   있다. 정확한 결론은 **"objdump가 라벨/섹션 문맥 정보를 잃어버리기 때문에, 이 카테고리의
   바이트 차이만으로는 디스어셈블러의 버그 여부를 판정할 수 없다"** — "안전하다"고 단정하지
   않고 "이 검증 방법으로는 판단이 안 된다"로 남긴다.

## 참고 — 나머지 byte_roundtrip_diff 3건과 reassemble_failed 26건
- TILELOADD/TILELOADDT1/TILESTORED(`[eax]` -> 재어셈블 시 `[eax+eiz*1]`로 disp32=0이 추가됨):
  유효주소 자체는 동일하다(같은 메모리 위치를 가리킴). 다만 "왜 as가 이 재파싱 경로에서
  최소 인코딩을 안 고르는지"는 원인을 확정하지 못했다 — "버그 아님"이라고 단정하지 않고
  "의미 차이는 없으나 비최소 인코딩의 정확한 원인은 미확인"으로 남긴다(codex 지적 반영).
- JECXZ/JRCXZ/LOOP/LOOPE/LOOPNE(`reassemble_failed`): 전부 short-only(8비트 변위) 명령어라
  절대주소 텍스트를 재어셈블할 때 `as`가 안전한 대체 인코딩이 없어 아예 에러를 낸다 —
  `relative_target_reassembly_artifact`(99건)와 같은 근본 원인(라벨→절대주소 표시 후
  relocation 처리), 이 검증 방법 자체의 한계다.
- MOVSXD(`cx,ecx`처럼 objdump가 이상한 폭 조합을 보여줌): 원인 미상, 후속 라운드에서 필요시
  추가 조사.
- VGATHERDPD 등 VEX gather 계열(`xmm0/(bad)`): SDM상 목적지/마스크/인덱스 레지스터가 겹치면
  **#UD(Invalid Opcode) 예외가 발생한다고 명시**돼 있다(codex 지적으로 "undefined behavior"
  라는 표현을 "#UD 예외"로 정정 — 이건 결과가 불확실한 게 아니라 항상 확실하게 예외가
  발생하는, 정의된 동작이다). combiner가 대표값 생성 시 레지스터를 재사용해서 이런 조합을
  만든 것으로 보임(기존에 이미 문서화된 combiner 한계와 같은 계열 - AVX512 EVEX gather는
  이전 라운드에서 고쳤지만 이 VEX(비-EVEX) 형태는 아직 반영 안 됨). 새 발견 아님, combiner
  개선 후보로만 기록.
