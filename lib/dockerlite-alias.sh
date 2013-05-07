dl_cmd alias "display a convenient alias to run dockerlite"
dl_alias () {
    echo "alias dl='sudo "$(readlink -f "$(dirname "$0")")/dockerlite"'"
}