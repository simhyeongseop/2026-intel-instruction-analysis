# Stage 1 Extractor 커버리지 리포트

- 스캔한 명령어 레퍼런스 페이지 수: 2284
- 추출된 표 행(row) 수: 4219
- 추출된 고유 mnemonic 수: 1611
- 목차(TOC)에서 뽑은 명령어(계열) 이름 수: 1147
- 추출 결과에 없는 이름 수: 30 (그중 cc-계열 placeholder: 7)

## 조건부 접미사(cc) 계열 placeholder (버그 아님, 참고용)
CMOVCC, CMPCCXADD, FCMOVCC, JCC, LOOPCC, PREFETCHH, SETCC

## 실제 누락 의심 목록 (0 이어야 함)
PABSQ, PMAXSQ, PMAXUQ, PMINSQ, PMINUQ, PMOVSX, PMOVZX, PMULLQ, PSRAQ, REPNZ, REPZ, UD, VBROADCAST, VCOMPRESSW, VMASKMOV, VPBROADCAST, VPBROADCASTM, VPMASKMOV, VPOPCNT, VPSHLD, VPSHLDV, VPSHRD, VPSHRDV

## 알려진 제한사항 (수동 확인 결과, 실제 파이프라인 버그 아님)
- 위 목록 대부분은 목차가 '섹션 제목'(예: VPBROADCAST, PMOVSX, VPSHLD, UD)만 적어둔 경우다.
  실제 표에는 VPBROADCASTB/W/D/Q, PMOVSXBW, VPSHLDD/Q/W, UD0/UD1/UD2 처럼 구체적인
  니모닉으로 나뉘어 있고, 그 구체 니모닉들은 isa_db.csv 에 정상적으로 들어있다(직접 확인함).
- PABSQ/PMAXSQ/PMAXUQ/PMINSQ/PMINUQ/PMULLQ/PSRAQ 는 목차엔 바로 옆 형제(PABSB/W/D 등)와
  같이 적혀 있지만, 실제로는 V 접두사 붙은 형태(VPABSQ 등)만 존재하고 맨몸 형태는 표에 없다.
- REPNZ/REPZ 라는 이름 자체는 TOC 상의 별칭 표기(REPE/REPZ, REPNE/REPNZ)일 뿐이고,
  실제 opcode 표(PDF p.1266/1268/1270)는 REP / REPE / REPNE 라는 이름으로 존재하며
  isa_db.csv 에 정상적으로 포함되어 있다(직접 확인함).
- VCOMPRESSW 는 목차 원문이 'VPCOMPRESSB/VCOMPRESSW'(PDF p.17)로 적혀 있어 P 가 빠진
  것으로 보이는 목차 자체의 표기 문제이고, 실제 opcode 표에는 VPCOMPRESSW 로 등재되어
  있으며 isa_db.csv 에 정상적으로 포함되어 있다(직접 확인함).