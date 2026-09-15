"""로컬 SDM에서 재심 대상 페이지를 검색·추출한다 (PDFium 별도 필요)."""
import argparse
import hashlib
import json
import re
from pathlib import Path


def main():
    import pypdfium2 as pdfium

    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pdf', type=Path, default=root / 'intel_manual.pdf')
    parser.add_argument('--output', type=Path, default=root / 'tmp/pdfs')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    doc = pdfium.PdfDocument(str(args.pdf))
    pages = []
    headings = re.compile(r'(?m)^(?:LAR|LSL|MOV|LDS/LES/LFS/LGS/LSS)\s*[—–-]')
    for index in range(len(doc)):
        page = doc[index]
        textpage = page.get_textpage()
        text = textpage.get_text_range()
        if re.search(r'\bUDB\b', text) or headings.search(text):
            pages.append(index + 1)
        # 검색용 원문은 tmp에만 둔다. 페이지 경계와 번호를 보존한다.
        with (args.output / 'manual_text.txt').open('a' if index else 'w', encoding='utf-8') as handle:
            handle.write('\n\n=== PDF PAGE %d ===\n%s' % (index + 1, text))
        textpage.close()
        page.close()
    print('matched PDF pages:', pages, flush=True)
    for number in pages:
        page = doc[number - 1]
        tp = page.get_textpage()
        (args.output / ('page_%d.txt' % number)).write_text(tp.get_text_range(), encoding='utf-8')
        page.render(scale=1.5).to_pil().save(args.output / ('page_%d.png' % number))
        tp.close()
        page.close()
    (args.output / 'manifest.json').write_text(json.dumps({
        'pdf_sha256': hashlib.sha256(args.pdf.read_bytes()).hexdigest(),
        'page_count': len(doc), 'matched_pdf_pages': pages,
    }, indent=2), encoding='utf-8')
    doc.close()


if __name__ == '__main__':
    main()
