#!/usr/bin/env bash

###             NOTE (20220910)            ###
# this is TEMPORARY. Use it with caution     #
# until I get around to building a C version #

[[ -z $GIT ]] && GIT=git

_usage() {
    echo "Usage:       mkcproj.sh <cproj location> <name>
Description: Makes a cproj-like project and git repository
Variables:
		GIT=[git command]
"
}

_init () {
		if [[ -z $1 ]]
		then
				echo "[ !! ] Missing \`cproj' location"
				exit 1
		elif [[ -z $2 ]]
		then
				echo "[ !! ] Missing project name"
				exit 1
		fi

		CPROJ=$1
		NAME=$2

		echo "[ GIT ] Initing the repository as $NAME"
		$GIT init $NAME

		pushd $NAME

		echo "[ .. ] Making directories"
		mkdir --verbose src scripts unit make $NAME
		mkdir --verbose -p make/m4 make/sed make/awk \
					scripts/m4 scripts/sed scripts/awk

		echo "[ .. ] Touching files"
		touch .gitignore README.md LICENSE
		cat > .gitignore <<EOF
configure.in
Makefile.in
make/*.mk
EOF

		echo "[ .. ] Setting the make system"
		cp --verbose $CPROJ/scripts/configure.in $CPROJ/scripts/mkconfigure.sh scripts
		cp --verbose $CPROJ/scripts/configure.m4 scripts/m4
		cp --verbose $CPROJ/scripts/make-script.sh scripts/
		cp --verbose $CPROJ/scripts/Makefile.in .
		cp --verbose $CPROJ/scripts/targets.m4 $CPROJ/scripts/inline.m4 make/m4
		ln --verbose -s scripts/configure configure
		popd

		echo "[ OK ] DONE!"
}

# TODO: make this in C to use GPLD's argparser to set up an specific cproj instance
case $1 in
	'-h'|'--help')
	    _usage
	    exit 1;;
	'-v'|'--version')
			echo "mkcproj.sh v1.0.0"
			exit 0;;
	*)
			_init $@;;
esac

echo '[ OK ] Done'
