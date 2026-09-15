"""이전 PoC 명령의 호환 진입점. 실제 현재 판정은 CASE_REVIEW 문서를 따른다."""
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from scripts.asm_linter import main

CASES = {'udb_mnemonic': 'udb', 'lss_objdump': 'lss rcx, tbyte ptr [eax]',
         'lfs_objdump': 'lfs rcx, tbyte ptr [eax]', 'lgs_objdump': 'lgs rcx, tbyte ptr [eax]'}

if __name__ == '__main__':
    if len(sys.argv) == 1:
        raise SystemExit(main(['--demo']))
    if sys.argv[1] in CASES:
        raise SystemExit(main([CASES[sys.argv[1]]] + sys.argv[2:]))
    raise SystemExit(main(sys.argv[1:]))
