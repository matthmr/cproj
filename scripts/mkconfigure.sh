#!/usr/bin/env bash

_usage() {
    echo "Usage:       mkconfigure.sh <configure.m4> <template> <configure>
Description: Makes a \`./configure' make script from <template>
Variables:
	M4 : [m4-like command]
Note:        Make sure to call this script from the repository root"
}

case $1 in
	'-h'|'--help')
	    _usage
	    exit 1;;
esac

[[ -z $M4 ]] && M4=m4

if [[ $# -ne 3 ]]; then
    echo "[ !! ] Wrong number of arguments. See \`./mkconfigure.sh --help'"
    exit 1
else
    CONFIGURE=$1
    TEMPLATE=$2
    INFILE=$3
    FILE=${INFILE%%.*in}
    if [[ $INFILE = $FILE ]]; then
	echo "[ !! ] $FILE is not an infile"
	exit 1
    fi
fi

# Script message
echo "[ .. ] Generating \`${FILE}'"

# Info message
echo "[ INFO ] M4=$M4"
echo "[ INFO ] Running: $M4 -DM4_TEMPLATE=${TEMPLATE} -DM4_SRC=${INFILE} ${CONFIGURE} > ${FILE}"

# Script body
$M4 -DM4_TEMPLATE=${TEMPLATE} -DM4_SRC=${INFILE} ${CONFIGURE} > ${FILE}
chmod --verbose +x ${CONFIGURE}

echo '[ OK ] Done'
