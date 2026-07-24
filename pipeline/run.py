"""
전체 파이프라인(1~7단계)을 순서대로 실행하는 도구.

사용법:
    python3 pipeline/run.py            # 1단계(extractor)부터 끝까지
    python3 pipeline/run.py combiner   # 3단계(combiner)부터 끝까지
                                        # (이전 단계 산출물이 이미 있다고 가정)

각 단계는 이미 만들어진 pipeline/mN_*.py를 그대로 서브프로세스로 실행한다.
한 단계라도 실패하면(returncode != 0) 그 자리에서 멈춘다 — 이후 단계는
앞 단계 산출물에 의존하므로 계속 진행해도 의미가 없다.

이 스크립트는 "정답지 대조·회귀 검증"은 하지 않는다. 그건 verifier(에이전트)의
역할이다(CLAUDE.md 4절). run.py는 순서대로 돌리는 것만 담당하는 단순 실행기.
"""

import subprocess
import sys

STAGES = [
    ("extractor", "pipeline/m1_extract.py"),
    ("tokenizer", "pipeline/m2_tokenize.py"),
    ("combiner", "pipeline/m3_combine.py"),
    ("generator", "pipeline/m4_generate.py"),
    ("assembler", "pipeline/m5_assemble.py"),
    ("roundtrip", "pipeline/m6_roundtrip.py"),
    ("triage", "pipeline/m7_triage.py"),
]


def find_start_index(start_name):
    """모듈 이름으로 시작 지점을 찾는다. 인자가 없으면 처음부터."""
    if not start_name:
        return 0
    for index, (name, _) in enumerate(STAGES):
        if name == start_name:
            return index
    names = ", ".join(name for name, _ in STAGES)
    print(f"알 수 없는 모듈 이름: {start_name}")
    print(f"사용 가능한 이름: {names}")
    sys.exit(1)


def main():
    start_name = sys.argv[1] if len(sys.argv) > 1 else None
    start_index = find_start_index(start_name)

    for name, script in STAGES[start_index:]:
        print(f"=== [{name}] {script} 실행 ===")
        result = subprocess.run([sys.executable, script])
        if result.returncode != 0:
            print(f"[{name}] 실패(returncode={result.returncode}) — 파이프라인 중단")
            sys.exit(result.returncode)

    print("전체 파이프라인 완료.")


if __name__ == "__main__":
    main()
