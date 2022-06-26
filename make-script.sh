#!/usr/bin/env bash

case $1 in
	'-h'|'--help')
		printf 'Usage:       
Description:
Variables:   
Note:        Make sure to call this script from the repository root
'
		exit 1
		;;
esac

# Script message
echo '[ .. ] '

# Info message
echo "[ INFO ] "

# Script body
# ...

echo '[ OK ] Done'
