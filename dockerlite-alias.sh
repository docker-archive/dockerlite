# run eval $(dockerlite alias) in your shell to set dl alias
dl_alias () {
    echo "alias dl='sudo "$(readlink -f "$(dirname "$0")")/dockerlite"'"
}