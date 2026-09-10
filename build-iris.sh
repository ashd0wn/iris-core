#!/usr/bin/env bash
# ==============================================================================
#  build-iris.sh -- Iris binary build script (called by deploy.sh)
#  Usage: ./build-iris.sh <iris-ui-build-dir> <output-binary-path>
#  Example: ./build-iris.sh ../iris-ui/build /opt/iris/iris-server
# ==============================================================================
set -euo pipefail

UI_BUILD_DIR="${1:-../iris-ui/build}"
OUTPUT_BIN="${2:-/opt/iris/iris-server}"
OUTPUT_DIR="$(dirname "$OUTPUT_BIN")"
SCRIPT_DIR="$(cd "$(dirname "$0")" ; pwd)"

echo "[iris-core] Building with embedded UI..."
echo "  UI build : $UI_BUILD_DIR"
echo "  Output   : $OUTPUT_BIN"

if [[ ! -d "$UI_BUILD_DIR" ]]; then
    echo "[ERROR] iris-ui build not found at: $UI_BUILD_DIR"
    exit 1
fi

if [[ ! -f "$UI_BUILD_DIR/index.html" ]]; then
    echo "[ERROR] index.html not found -- iris-ui build may be incomplete"
    exit 1
fi

echo "[iris-core] Copying UI build into app/ui/dist/..."
cd "$SCRIPT_DIR"
rm -rf app/ui/dist/*
mkdir -p app/ui/dist
cp -r "$UI_BUILD_DIR/." app/ui/dist/

echo "[iris-core] Downloading Go modules..."
go mod download

echo "[iris-core] Compiling (go build -tags embed)..."
go build \
    -tags embed \
    -ldflags="-s -w" \
    -o "$OUTPUT_BIN" \
    ./main.go

echo "[iris-core] Copying mime.types..."
mkdir -p "$OUTPUT_DIR"
cp mime.types "$OUTPUT_DIR/mime.types"

echo "[iris-core] Done!"
ls -lh "$OUTPUT_BIN"
