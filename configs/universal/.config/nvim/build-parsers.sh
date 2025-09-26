#!/usr/bin/env bash
set -e

declare -A GRAMMARS=(
  ["https://github.com/hansumane/tree-sitter-c.git"]="420dd222adbb8055115786832bac04f071c85329"

  ["https://github.com/tree-sitter/tree-sitter-bash.git"]="a06c2e4415e9bc0346c6b86d401879ffb44058f7"
  ["https://github.com/ram02z/tree-sitter-fish.git"]="f435b0bd772578c70e5d158b85267bb886316f88"
  ["https://github.com/tree-sitter/tree-sitter-json.git"]="001c28d7a29832b06b0e831ec77845553c89b56d"
  ["https://github.com/joelspadin/tree-sitter-devicetree.git"]="e78bf56f206cb47bee28a217423acb651e076848"
  ["https://github.com/Hubro/tree-sitter-yang.git"]="2c0e6be8dd4dcb961c345fa35c309ad4f5bd3502"

  ["https://github.com/tree-sitter/tree-sitter-python.git"]="293fdc02038ee2bf0e2e206711b69c90ac0d413f"
  ["https://github.com/tree-sitter/tree-sitter-go.git"]="2346a3ab1bb3857b48b29d779a1ef9799a248cd7"
  ["https://github.com/tree-sitter/tree-sitter-rust.git"]="77a3747266f4d621d0757825e6b11edcbf991ca5"
)

[[ ! -d './temp' ]] || rm -rf './temp'
mkdir -p './parser' './temp'

for url in "${!GRAMMARS[@]}" ; do
  commit="${GRAMMARS[$url]}"
  name="$(basename "$url" .git)"
  lang="$(echo "$name" | sed 's/^tree-sitter-//')"
  dir="./temp/$name"

  git clone --filter=blob:none --depth=1 "$url" "$dir"

  cd "$dir"
    git fetch --depth=1 origin "$commit"
    git checkout -b build "$commit"
    tree-sitter generate
    tree-sitter build
  cd -

  mv "$dir/$lang.so" './parser'
done

rm -rf './temp'
