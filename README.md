# C Project template

Template files that might be useful in a C project.

## scripts/

### configure

Mock-up of an [autotools](https://en.wikipedia.org/wiki/GNU_Autotools) configure file. It doesn't
actually use the autotools, instead it uses common
posix utilities + m4.

Change the following variables:

- `SET_FLAGS` : double-dashed variables for the `Flags.mk` file. Those variables are written
              all in uppercase in the Makefile, but are passed lowercase in the configure
              script.
- `SET_FLAG_PREFIX` : m4 prefix for the variables.
- `INCLUDE_FLAGS` : one-dashed/plused include variables for the Makefile.
- `INCLUDE_FLAG_PREFIX` : m4 prefix for the variables.
- `CALLEES` : target scripts minus the `.sh` postfix.
- `BUILDS_CALL` : target call command (one per target script).

It is recommended to change the `--help` message after changing any of the variables
as it does not autogenerate.

### make-script.sh

`configure`'s target template. Change the `--help` message and script body.

### targets.m4

Makefile target m4 template for binaries and libraries.
It uses `CC`, `CFLAGS` and `AR`, `ARFLAGS` as `make` variables.

It sets up an `include` interface with the following macros:

#### Target

```m4
target(`target_name')dnl
target_bin(`target_binaries...')dnl
target_obj(`target_objects...')dnl
target_lib(`tagets_libaries...')dnl
target_gen
```

#### Library

```m4
library(`library_name')dnl
library_obj(`libary_objects...`)dnl
library_gen
```

All values the have `...` are comma separated. It is
also assumed that binaries are stored with `bin` prefix
and libraries are stored with `lib` prefix.

### inline.m4

Generic inlined m4 macro substitution for source files.

Macros are prefixed by `M4FLAG_src` and the call to the m4 binary
passes the `M4ARG_file` macro as the filename. Eg:

```sh
m4 -DM4ARG_file=main.c.in inline.m4 > main.c
```

#### Macro functions
- `setall(x,y)` : sets all intances of `x` to `y` for all files.
- `setfor(f,X)` : sets all intances of `x1` to `x2` in the pair `X` for file `f`.
- `unsetfor(f,X)` : unsets all intances of `x` in the list `X` for file `f`.

For directories with C sources, documentation will be available inside their directories.
