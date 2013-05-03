# list available commands and their help
dl_help () {
    cd $(_dl_sourcedir)
    for FILE in dockerlite-*.sh
    do
	CMD=$FILE
	CMD=${CMD%.sh}
	CMD=${CMD#dockerlite-}
	printf "%-10s %s\n" $CMD "$(head -n 1 $FILE)"
    done
}
