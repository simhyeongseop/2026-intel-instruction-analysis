# 13회 발표 PPT 만들기

결과: [../13회_왕복비교.pptx](../13회_왕복비교.pptx) (16장, 발표자 노트에 대본)

| 파일 | 하는 일 |
|---|---|
| `review_table.py` | `out/round2_20261111/roundtrip_chain/`의 `diff_cases.csv`·`ltarget_check.csv`·`chain_table.csv`를 읽어 재검토 분류(완전 일치 / 적는 법만 다름 / 문제 아님 / 우리 설계 / 매뉴얼 허용 / LLVM 문제 / GNU 문제)로 다시 센다 → `review_table.json` |
| `capture.sh c1 … c8` | 장마다 예시를 GNU as 2.47(`--64 -mintel64`)·objdump(`-M intel,intel64`)·llvm-mc 23.1.3으로 실제 실행해 `cap/cN.txt`로 남긴다 |
| `render.py cap/cN_m.txt` | 캡처 글을 PNG로. `_m.txt`는 `cN.txt` 줄 끝에 색 표시(§R 빨강, §B 파랑)만 붙인 것 |
| `build.py` | python-pptx로 PPT를 만든다(`pip install python-pptx`) |

```bash
cd docs/presentation/deck_13
python3 review_table.py > review_table.json
for c in c1 c2 c3 c4 c5 c6 c7 c8; do ./capture.sh $c > cap/$c.txt; done   # 색 표시는 _m.txt에 손으로 유지
python3 render.py cap/c?_m.txt
python3 build.py
```

- 캡처의 `# 고른 정의: PUSHFS16` 줄은 `llvm-mc --show-inst` 출력(`<MCInst #3546 PUSHFS16>`)을 짧게 바꿔 적은 것이다.
- 예시는 모두 매뉴얼 표 행과 대조했다(장마다 아래 '매뉴얼' 줄). `pushfw`처럼 매뉴얼 철자가 아닌 생성 소스는 쓰지 않고 바이트(`66 9C`)부터 보였다.
- 재검토 분류의 합은 `chain_table.csv`의 길별 전체(104,623 / 104,623 / 105,592 / 105,592)와 같다.
