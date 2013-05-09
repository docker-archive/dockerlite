_dl_metadata () {
    ACTION=$1
    CLASS=$2
    OBJECT=$3
    KEY=$4
    VALUE=$5
    JUNK=$6
    [ "$JUNK" ] && _dl_error "extra arguments: '$JUNK' (check your quotes)"
    MDPATH="$DOCKERLITE_ROOT/$CLASS/$OBJECT/metadata/$KEY"
    case "$ACTION" in
	get)
	    [ -f "$MDPATH" ] && cat "$MDPATH"
	    ;;
	set)
	    echo "$VALUE" > "$MDPATH"
	    ;;
	*)
	    _dl_error "unknown metadata verb '$ACTION'"
	    ;;
    esac
}

_dl_seti () { _dl_metadata set images "$@"; }
_dl_geti () { _dl_metadata get images "$@"; }
_dl_setc () { _dl_metadata set containers "$@"; }
_dl_getc () { _dl_metadata get containers "$@"; }
