#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
if [[ -x .tools/root/usr/bin/x86_64-w64-mingw32-g++-posix ]]; then
    compiler=".tools/root/usr/bin/x86_64-w64-mingw32-g++-posix"
    windres=".tools/root/usr/bin/x86_64-w64-mingw32-windres"
else
    compiler=x86_64-w64-mingw32-g++
    windres=x86_64-w64-mingw32-windres
fi
mkdir -p build
# Preserve the original UTF-16 Visual Studio resource file.
python3 - <<'PY'
from pathlib import Path
rc = Path('OpenGLrememberProj/OpenGLrememberProj.rc').read_text(encoding='utf-16')
rc = rc.replace('"resource.h"', '"Resource.h"')
Path('build/resources.rc').write_text(rc, encoding='utf-8')
PY
"$windres" --preprocessor="$compiler" --preprocessor-arg=-E --preprocessor-arg=-xc --preprocessor-arg=-DRC_INVOKED \
    --codepage=65001 -I OpenGLrememberProj -i build/resources.rc -o build/resources.o
"$compiler" -std=gnu++14 -O2 -static -mwindows \
    OpenGLrememberProj/*.cpp build/resources.o -lopengl32 -lglu32 -lgdi32 \
    -o build/Kg_Curs.exe
printf 'Готово: build/Kg_Curs.exe\n'
