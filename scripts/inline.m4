define(`keyundef', `ifelse(`$1', `', `', `undefine(`M4FLAG_src_$1')dnl
keyundef(shift($@))')')dnl
define(`keyvaldef', `ifelse(`$1', `', `', `define(`M4FLAG_src_$1', `$2')dnl
keyvaldef(shift(shift($@)))')')dnl
define(`setall', `define(`M4FLAG_src_$1', `$2')')dnl
define(`setfor', `ifelse(M4ARG_file, `$1.in', `keyvaldef(shift($@))', `')')dnl
define(`unsetfor', `ifelse(M4ARG_file, `$1.in', `keyundef(shift($@))', `')')dnl
dnl
dnl definitions go here
dnl
undefine(`keyvaldef')dnl
undefine(`keyundef')dnl
undefine(`setall')dnl
undefine(`setfor')dnl
undefine(`unsetfor')dnl
changequote(`@{', `}@')dnl
include(M4ARG_file)dnl
