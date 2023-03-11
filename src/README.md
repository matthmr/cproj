# CPROJ - src

C files that can be included from.

NOTE: when compiling against/with one of the files here, make sure you include
`src` (this directory) as a search include directory on your favorite C
compiler of choice. It's generally something like `-I<this-source-directory>`.

## include/

Header files that can be included from. Be sure to include `src/` as an include
directory.

### cli.h

ANSI escape sequence function-like macro definitions. The name of the macros are self-explanatory,
so no documentation will be written.

### pool.h

Simple memory pool templates, header-library.

#### Dev changes

To use `pool.h`, you must define two macros:

1. `POOL_ENTRY_T`: the type of the array on each pool
2. `POOL_AM`: the length or the array on each pool

example:

``` c
#define POOL_ENTRY_T int
#define POOL_AM      23

#include "pool.h"
```

#### Types

- `POOL_T`: the default pool type (only one per translation unit)
- `POOL_RET_T`: the default pool return type for functions (only one per
  translation unit)

#### Functions

- `POOL_RET_T pool_add_node(POOL_T* pp)`: get a new node in the pool
- `POOL_RET_T pool_from_idx(POOL_T* pp, uint c_idx)`: get a pool thread from an
  index

#### Variables

- `POOL`: the global memory pool base
- `POOLP`: the global memory pool base pointer

#### Locks

You can lock pool functionality so that the compiler doesn't complain about
unused functions.

- `LOCK_POOL_THREAD`: lock the first thread entry (`POOL`, `POOL_P`)
- `LOCK_POOL_DEF`: loc kthe function definitions

#### NOTE!

This library *will* conflict if it has multiple implementations per translation
unit. Make sure to separate them correctly.

### utils.h

Generic utils used throughout header and source files. You don't have to include
this explicitly as it's included by other source/headers in `CPROJ.SRC`.

### err.h

Simple error system in C. This makes it possible to bubble up errors from
assertions into parent stack functions.

#### Dev changes

Edit the `enum ecode` enum and add some errors.

example:

```c
enum ecode {
  EOK = 0,

  EFALSEASSERTION,
  EOUTOFMEMORY,
  // ...

  EOK_END,
};
```

The error messages are store in the internal variable of `err.c` (see its
documentation).

#### Functions

- `err`: called with the error code as the argument and keeps returning the
  error code until `main` is reached.

#### Macros

- `OR_ERR`: be called on a false assertion to bubble up the error code up the
  stack. This assumes the error code message has been dealt with by the
  expression that failed the assertion.
  example:
  ```c
  int always_fail(void) {
    return err(EALWAYS_FAIL); // assume this is defined
  }
  int main(void) {
    assert(always_fail() == 0, OR_ERR());
  }
  ```
  in the example above, the message is issue by `always_fail`, and the code
  bubbles up to `main`
- `ERR_MSG(mod, msg)`: generate an error string for `mod` module with `msg`
  message
- `ERR_STRING(mod, msg)`: generate an error **sized** string for `mod` module with `msg`
  message

#### NOTE!

This header does **not** support **error handling** (aka warnings that issue,
but the program continues executing), only **fatal error issuing**, where the
program **always** exits with the error code.

### cgen.h

C generation header. This exposes the interface for `cgen.c` in `CGEN.SRC`.

#### Overrides

- define: `CGEN_OUTBUF`: the amount of bytes for the output buffer (4096)
- define: `CGEN_AUTOGEN_NOTICE`: the auto-generated message as a cstring

#### Functions

- `cgen_notice`: display `CGEN_AUTOGEN_NOTICE`
- `cgen_string(char* string)`: buffer `string` to the output buffer. example:
  ```c
  cgen_string("hello world"); // -> hello world
  ```
- `cgen_itoa_string(uint num)`: buffer `num` as string to the output buffer.
  example:
  ```c
  cgen_itoa_string(2023); // -> 2023
  ```
- `cgen_flush`: flush the output buffer to stdout (used at the end)
- `cgen_index(uint idx)`: buffer `idx` as the value of an array index. example:
  ```c
  cgen_index(23); // -> [23]
  ```
- `cgen_field(char* name, enum cgen_typ typ, void* dat)`: generate a struct
  field `name` with the value of `dat`, explicited by `typ` (see `enum cgen_typ`
  in `cgen.h`). example:
  ```c
  cgen_field("name", CGEN_STRING, "john"); // -> .name = "john",
  ```
- `cgen_field_array(char* name, enum cgen_typ typ, void* dat, uint size)`:
  generate a struct field `name` with the value of `dat`, where each element is
  explicited by `typ`. example:
  ```c
  const char** names = {"john", "mary"};
  cgen_field_array("names", CGEN_STRING, (void*) names);
  // -> .names = {"john", "mary"};
  ```
- `cgen_close_field`: issue the *close field* token
- `cgen_string_from(char* string, uint size)`: generate an `stris` from a
  `string` and a `size` (at lot of functions from here on take `stris`s instead
  of `string`s)
- `cgen_itoa_for(uint num, string_is* stris)`: buffer `num` as string to `stris`
- `cgen_string_for(char* string, string_is* stris)`: buffer `string` to `stris`
- `cgen_flush_for(string_is* stris)`: flush `stris` to stdout
- `cgen_index_for(uint idx, string_is* stris)`: buffer `idx` as the value of an
  array index for `stris`

### debug.h

Simple debug C header.

#### Unlock

Define `DEBUG` as a macro on a source file or in your compiler to have debug
messaged stop being annulled.

#### Macros

- `DB_MSG(msg)`: write `msg` as a debug message
- `DB_MSG_SAFE(msg)`: safe version of `DB_MSG`
- `DB_BYT(byt)`: write `byt`s as debug
- `DB_FMT(msg, ...)`: use `msg` as a `printf` template for a debug message

## ./

### cgen.c

Source for the C generation header defined in `cgen.h`

### err.c

Source for the error system defined in `err.h`.

#### Internal data

- `emsg`: a string array for the error messages. Use the errors defined in `enum
  ecode` as array indices

# NOTE

Refer to the inline comments in the files.
