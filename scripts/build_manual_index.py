"""매뉴얼 색인 생성 CLI.

    ~/pdftools_venv/bin/python scripts/build_manual_index.py

pdfplumber가 필요하다. PDF가 바뀌면 다시 실행해야 한다(색인은 PDF 해시로 검사한다).
"""

import argparse
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from pipeline import manual_index


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--pdf", default=manual_index.PDF_PATH)
    parser.add_argument("--index-dir", default=manual_index.INDEX_DIR)
    parser.add_argument("--force", action="store_true", help="최신 색인이어도 다시 만든다")
    parser.add_argument("--reuse-pages", action="store_true",
                        help="같은 PDF 해시의 저장된 페이지 원문으로 절 구분만 다시 계산한다")
    args = parser.parse_args()

    state, detail = manual_index.index_state(args.index_dir, args.pdf)
    if state == "current" and not args.force:
        print("색인이 이미 현재 PDF와 맞는다. 다시 만들려면 --force.")
        print(json.dumps(detail["manifest"], ensure_ascii=False, indent=1))
        return 0
    print("색인 생성 시작: %s -> %s (%s)" % (args.pdf, args.index_dir, detail.get("reason", "")))

    def progress(done, total):
        print("  %d/%d 페이지" % (done, total), flush=True)

    manifest = manual_index.build_index(args.pdf, args.index_dir, progress=progress,
                                          reuse_pages=args.reuse_pages)
    print(json.dumps(manifest, ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
