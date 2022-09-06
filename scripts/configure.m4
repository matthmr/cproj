define(`_buildn', 0)dnl
define(`buildn_0', 0)dnl
define(`_buildindex', 0)dnl
dnl
define(`procname', $1_$2)dnl
dnl
define(`expandql',`ifelse($1, `',, `"$1" expandql(shift($@))')')dnl
define(`expandvar',`ifelse($1, `',, `$1=\"`$'$1\" expandvar(shift($@))')')dnl
define(`expandcall',`ifelse(_buildindex, buildindex,, `procname(`M4_GEN_BUILDS_CALL', _buildindex) define(`_buildindex', incr(_buildindex)) expandcall(shift($@))')')dnl
dnl
define(`set_flags', `define(`M4_GEN_SET_FLAGS', `expandql($@)')')dnl
define(`set_flag_prefix', `define(`M4_GEN_SET_FLAG_PREFIX', $1)')dnl
dnl
define(`include_flags', `define(`M4_GEN_INCLUDE_FLAGS', `expandql($@)')')dnl
define(`include_flag_prefix', `define(`M4_GEN_INCLUDE_FLAG_PREFIX', $1)')dnl
dnl
define(`callees', `define(`M4_GEN_CALLEES', `expandql($@)')')dnl
dnl
define(`builds_call', `define(`buildindex', procname(`buildn', _buildn)) define(procname(`M4_GEN_BUILDS_CALL', buildindex), "`expandvar($@)' scripts/`$'{CALLEES[buildindex]}.sh") define(`_buildn', incr(_buildn)) define(procname(`buildn', _buildn), _buildn)')dnl
dnl
define(`genconfig_call', `expandcall(`M4_GEN_BUILDS_CALL', buildindex)')dnl
define(`genconfig_default',`ifelse(`shell', `#!/usr/bin/', `define(`shell', `#!/usr/bin/sh')',) ifdef(`M4_GEN_SET_FLAGS',, `define(`M4_GEN_SET_FLAGS', `')') ifdef(`M4_GEN_SET_FLAG_PREFIX',, `define(`M4_GEN_SET_FLAG_PREFIX', `M4_FLAG_')') ifdef(`M4_GEN_INCLUDE_FLAGS',, `define(`M4_GEN_INCLUDE_FLAGS', `')') ifdef(`M4_GEN_INCLUDE_FLAG_PREFIX',, `define(`M4_GEN_INCLUDE_FLAG_PREFIX', `M4_INCLUDE_')')')dnl
dnl
define(`shell', `#!/usr/bin/'$1`')dnl
define(`genconfig', `define(`buildindex', incr(buildindex)) genconfig_default define(`M4_GEN_BUILDS_CALL', genconfig_call)
include(M4_SRC)')dnl
include(M4_TEMPLATE)dnl
