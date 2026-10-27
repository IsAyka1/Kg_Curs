#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
root="$PWD"
if [[ ! -f build/Kg_Curs.exe ]]; then
    ./build.sh
fi
python3 scripts/prepare_models.py
for asset in textures/drossel.bmp textures/background.bmp textures/tex_ball.bmp \
    shaders/v.vert shaders/frac.frag shaders/cassini.frag shaders/light.frag shaders/textureShader.frag; do
    if [[ ! -s "OpenGLrememberProj/$asset" ]]; then
        printf 'Отсутствует ресурс: OpenGLrememberProj/%s\n' "$asset" >&2
        exit 1
    fi
done
export WINEPREFIX="$root/.wine"
export WINEARCH=win64
export WINEDEBUG="${WINEDEBUG:--all}"
export WINEDLLOVERRIDES="mscoree,mshtml="
export LANG=ru_RU.UTF-8
if [[ -x .tools/root/usr/lib/wine/wine64 ]]; then
    wine="$root/.tools/root/usr/lib/wine/wine64"
    export WINELOADER="$wine"
    export WINESERVER="$root/.tools/root/usr/lib/wine/wineserver64"
    export WINEDLLPATH="$root/.tools/root/usr/lib/x86_64-linux-gnu/wine"
    export LD_LIBRARY_PATH="$root/.tools/root/usr/lib/x86_64-linux-gnu/wine/x86_64-unix:$root/.tools/root/usr/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    mkdir -p "$WINEPREFIX/drive_c/windows/system32"
    cp "$root/.tools/root/usr/x86_64-w64-mingw32/lib/zlib1.dll" "$WINEPREFIX/drive_c/windows/system32/zlib1.dll"
else
    wine=wine
fi
cd OpenGLrememberProj
exec "$wine" ../build/Kg_Curs.exe "$@"
