_dl_cmd alias "display a convenient alias to run dockerlite"
_dl_alias () {
    echo "alias dl='sudo "$(readlink -f "$(dirname "$0")")/dockerlite"'"
}