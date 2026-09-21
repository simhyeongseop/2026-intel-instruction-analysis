# 파이프라인 건전성 점검

이 표는 절차상 오류만 본다. 명령어의 옳고 그름은 사람이 판단한다.

| 상태 | 내용 |
|---|---|
| OK | combos.csv ↔ tests.s 일치 (23,323행) |
| OK | 기준선 7,278행의 combo_id 유지 |
| OK | 재심 고정 사례 7건의 소스 유지 |
| OK | asm_result.csv(5단계) 이 현재 tests.s 기준 (23,323행) |
| OK | clang_result.csv(8단계) 이 현재 tests.s 기준 (23,323행) |
| OK | out/objects: 오브젝트 23,219개 |
| OK | out/clang_objects: 오브젝트 23,157개 |
| WARN | triage 미재심 10,109건 / unsure 47건 (확정으로 보고하지 말 것) |
| WARN | 체크리스트 판정 미기입 1,558/1,558행 |
| OK | 마지막 실행 20260920T233325021698Z.json: lint(completed) |
