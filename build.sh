#!/bin/bash

set -eu

trap '[[ -d "$tmp_dir" ]] && rm -rf "$tmp_dir"' EXIT

check_file() {
    local file=$1
    if [[ ! -f "$file" ]]; then
        echo "Error: Cannot find $file" >&2
        exit 1
    fi
}

tmp_dir=$(mktemp -d -t fusion-plugin-XXXXXX)
root_dir=$(pwd)
wasm_path="$root_dir/target/wasm32-wasip2/release/name.wasm"

mode="debug"
cargo_flags=""

for arg in "$@"; do
  if [[ "$arg" == "--release" ]]; then
    mode="release"
    cargo_flags="--release"
  fi
done

echo "Mode: $MODE"

if [[ ! -d "$tmp_dir" ]]; then
  echo "Cannot create temporary directory"
  exit 1
fi

check_file "manifest.toml"
cp manifest.toml "$tmp_dir/manifest.toml"

if [[ -d "config" ]]; then
    cp -r "config" "$tmp_dir/"
fi

echo "Building WASM module..."

# Патч для автономности проекта, если он внутри чужого воркспейса
if ! grep -q "\[workspace\]" Cargo.toml; then
    printf "\n[workspace]\n" >> Cargo.toml
fi

cargo build --target wasm32-wasip2 $cargo_flags

check_file "$wasm_path"
cp "$wasm_path" "$tmp_dir/module.wasm"

echo "Creating plugin bundle..."
(
    cd "$tmp_dir"
    zip -qr "$root_dir/target/name.fus" .
)

echo "Success! Output: ./target/name.fus"
