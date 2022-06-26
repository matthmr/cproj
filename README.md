# C Project template
Little template files that might be useful in a C project.

## configure

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

## make-script.sh

`configure`'s target template. Change the `--help` message and script body.
