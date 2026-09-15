"""2026-09-14 근거로 재심한 사례. 과거 category/verdict/cause는 별도 열로 보존."""
EVIDENCE = 'docs/CASE_REVIEW_2026-09-14.md'
REVIEW = {
    '1527': ('lss rcx, tbyte ptr [eax]', 'far_pointer_display', 'disassembly_defect', 'confirmed', 'bug',
             'GNU objdump 2.42: REX.W + 0F B2 /r의 80비트 포인터를 FWORD PTR(48비트)로 표시. '
             'SDM PDF 658 본문·바이트 해독·r16/r32 대조 및 재어셈블 거부로 확인. CPU 오동작 주장이 아님.'),
    '1532': ('lfs rcx, tbyte ptr [eax]', 'far_pointer_display', 'disassembly_defect', 'confirmed', 'bug',
             'GNU objdump 2.42: REX.W + 0F B4 /r의 80비트 포인터를 FWORD PTR로 표시. LSS와 같은 표시 결함 유형.'),
    '1535': ('lgs rcx, tbyte ptr [eax]', 'far_pointer_display', 'disassembly_defect', 'confirmed', 'bug',
             'GNU objdump 2.42: REX.W + 0F B5 /r의 80비트 포인터를 FWORD PTR로 표시. LSS와 같은 표시 결함 유형.'),
    '4597': ('udb', 'udb_support', 'support_gap', 'observed', 'unsure',
             'SDM PDF 1436은 UDB를 D6 opcode·Operation #UD로 명시한다. GNU as 2.42와 Clang 18.1.3의 '
             '니모닉 거부는 재현됨. 해당 버전의 지원 약속 위반 근거가 없어 구현 버그로 합산하지 않음.'),
    '1683': ('mov ds, qword ptr [eax]', 'mov_sreg_memory', 'support_gap', 'resolved_observation', 'false_alarm',
             'qword ptr 거부는 양 도구에서 재현되나 구현 결함의 근거가 되지 않는다. '
             '실제 CPU에서 8E/66+8E/48+8E 모두 읽기 가능한 2바이트로 DS 로드에 성공, 1바이트면 보호 페이지 접근으로 실패. '
             '이 환경의 접근 범위는 2바이트이며 SDM r/m64 표기만으로 8바이트 읽기 요구를 추론한 주장을 철회. '
             '매뉴얼의 8C/8E 표기 차이 자체와 모든 CPU의 동작까지 해결했다고 주장하지 않음.'),
    '1516': ('lar ecx, rcx', 'lar_lsl_notation', 'equivalent_representation', 'resolved_observation', 'false_alarm',
             '기존 비대칭 문법 거부가 구현 버그라는 주장을 철회한 상태를 유지. '
             'SDM PDF 651 본문은 32/64비트 동작이 동일하다고 명시하며 source는 하위16비트만 사용. '
             '대칭 r64 소스의 REX.W 생략도 동작 오류 근거가 아님. 과거의 REX.W 단일 비트 논증과 각주 위치 설명은 정정.'),
    '1571': ('lsl rcx, ecx', 'lar_lsl_notation', 'equivalent_representation', 'resolved_observation', 'false_alarm',
             'LSL PDF 691 본문은 32/64비트 동작이 동일하다고 명시한다. '
             'source selector는 하위16비트만 사용. CPU 성공/실패 대조에서도 목적지와 ZF가 동일. '
             '대칭 r64 소스의 REX.W 생략을 인코딩 동작 버그로 집계하지 않음.'),
}


def apply_review(rows, assembly_rows):
    sources = {r['combo_id']: r['asm_line'].lower().replace(' ', '') for r in assembly_rows}
    for row in rows:
        row.update(legacy_category=row['category'], legacy_verdict=row['verdict'],
                   legacy_diff_cause=row['diff_cause'], finding_type='legacy_classification',
                   review_status='not_reassessed', case_id='', evidence='')
        combo = row['source'].split('/')[-1]
        case = REVIEW.get(combo)
        if not case:
            continue
        source, case_id, kind, status, verdict, cause = case
        if sources.get(combo) != source.replace(' ', ''):
            raise ValueError('재심 ID와 소스 불일치: combo %s. 판정을 새 입력에 전이할 수 없습니다.' % combo)
        row.update(category=case_id, verdict=verdict, diff_cause=cause, finding_type=kind,
                   review_status=status, case_id=case_id, evidence=EVIDENCE)
    return rows
