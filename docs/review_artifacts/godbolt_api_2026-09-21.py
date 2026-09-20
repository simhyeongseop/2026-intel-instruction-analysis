import json, subprocess, sys

def run(compiler, source, args=""):
    body = json.dumps({
        "source": source,
        "options": {"userArguments": args,
                    "filters": {"binary": False, "intel": True, "labels": True,
                                "directives": True, "commentOnly": True}},
        "lang": "assembly", "allowStoreCodeDebug": False,
    })
    out = subprocess.run(
        ["curl", "-s", "-m", "60", f"https://godbolt.org/api/compiler/{compiler}/compile",
         "-H", "Content-Type: application/json", "-H", "Accept: application/json", "-d", body],
        capture_output=True, text=True).stdout
    try:
        d = json.loads(out)
    except Exception:
        return {"raw": out[:300]}
    return {"code": d.get("code"),
            "asm": [l.get("text") for l in d.get("asm", []) if l.get("text", "").strip()],
            "stderr": [l.get("text") for l in d.get("stderr", [])]}

if __name__ == "__main__":
    src = ".intel_syntax noprefix\n.text\nlss rcx, tbyte ptr [rax]\n"
    for c in ("gnuas142", "gnuas151", "gnuassnapshot"):
        print("=====", c)
        print(json.dumps(run(c, src), ensure_ascii=False, indent=1)[:700])
