"""시험에 쓰는 도구 경로를 한곳에서 정한다.

기본값(2026-10-12 사용자 결정: 두 어셈블러를 최신 판으로):
- GNU Binutils 2.47 (2026-07-26 출시): ~/opt/binutils-2.47/bin  (소스에서 빌드)
- LLVM 23.1.3 (2026-10-06 출시):     ~/opt/llvm-23.1.3/bin     (공식 Linux-X64 바이너리)
환경 변수 BINUTILS_BIN, LLVM_BIN으로 바꿀 수 있다. 폴더가 없으면 PATH의 같은 이름 도구를 쓴다.
어느 판을 썼는지는 실행 기록(instruction_check.environment)에 경로와 --version 첫 줄로 남는다.
"""

import os

BINUTILS_BIN = os.environ.get("BINUTILS_BIN", os.path.expanduser("~/opt/binutils-2.47/bin"))
LLVM_BIN = os.environ.get("LLVM_BIN", os.path.expanduser("~/opt/llvm-23.1.3/bin"))


def _tool(folder, name):
    path = os.path.join(folder, name)
    return path if os.access(path, os.X_OK) else name


AS = _tool(BINUTILS_BIN, "as")
LD = _tool(BINUTILS_BIN, "ld")
OBJDUMP = _tool(BINUTILS_BIN, "objdump")
OBJCOPY = _tool(BINUTILS_BIN, "objcopy")
READELF = _tool(BINUTILS_BIN, "readelf")
CLANG = _tool(LLVM_BIN, "clang")
LLVM_MC = _tool(LLVM_BIN, "llvm-mc")

# 실행 기록에 남길 도구 이름 -> 경로
ALL = {"as": AS, "ld": LD, "objdump": OBJDUMP, "objcopy": OBJCOPY, "readelf": READELF,
       "clang": CLANG, "llvm-mc": LLVM_MC}
