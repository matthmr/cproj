#ifndef LOCK_ERR
#  define LOCK_ERR

// you might be able to get away with defining this, just as long as you don't
// use the `STRING' or `MSG' macros
#  ifndef LOCK_ERR_UTILS
#    include <include/utils.h>
#  endif

#  define ERR_STRING(mod, msg) \
  STRING("[ !! ] " mod ": " msg)

#  define ERR_MSG(mod, msg) \
  MSG("[ !! ] " mod ": " msg "\n")

/** NOTE: when using with `<include/utils.h>', a false assertion can inherit the
    error from its expression. The form is:

   assert(expression..., OR_ERR());

   this expects that the functions of `expression' call `err()' themselves, and
   that that call is the one that logs/prints the error to STDOUT
*/

#  define OR_ERR(x) \
  err(0)

enum ecode {
  EOK = 0,

  /**
    Usage:

    E<SHORT-ERROR-DESCRIPTION>

    Example:

    EOOM,
    EARGINV,
    ...
   */

  EOK_END,
};

#  define ECODE_BEGIN (EOK)
#  define ECODE_END   (EOK_END)
#  define ERROR       (-1u)

#  if ECODE_LEN == ERROR
#    error "[ !! ] libvsl: Too many errors (how did this even happen?)"
#  endif

int err(enum ecode code);

#endif
