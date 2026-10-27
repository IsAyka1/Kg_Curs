#!/usr/bin/env bash
# Ubuntu 24.04 x86_64: install tools inside this project without root access.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
mkdir -p .tools/packages .tools/root
(
    cd .tools/packages
    apt-get download binutils-mingw-w64-x86-64 g++-mingw-w64-x86-64-posix \
        gcc-mingw-w64-base gcc-mingw-w64-x86-64-posix \
        gcc-mingw-w64-x86-64-posix-runtime libcapi20-3t64 libwine \
        libz-mingw-w64 mingw-w64-common mingw-w64-x86-64-dev wine64 fonts-wine
)
for package in .tools/packages/*.deb; do
    dpkg-deb -x "$package" .tools/root
done
# Make the local Wine wrapper resolve its executable beside itself.
cat > .tools/root/usr/lib/wine/wineserver <<'SH'
#!/bin/sh
exec "$(dirname -- "$0")/wineserver64" -p0 "$@"
SH
chmod +x .tools/root/usr/lib/wine/wineserver
cp .tools/root/usr/x86_64-w64-mingw32/lib/zlib1.dll \
    .tools/root/usr/lib/x86_64-linux-gnu/wine/x86_64-windows/zlib1.dll
printf 'Локальные инструменты готовы. Выполните ./build.sh, затем ./run.sh\n'
