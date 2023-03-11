#include <unistd.h>

#include <include/err.h>

static const string_s emsg[] = {
  /**
    Usage:

    [<ERROR-CODE>]  = ERR_STRING("module...", "message..."),
   */
};

/** for now, this function is only called once and the entire
    program exits; there's no exception handling
 */
int err(enum ecode ecode) {
  static bool did_msg = false;
  static enum ecode pecode = 0;

  if (!did_msg) {
    did_msg = true;
    pecode  = ecode;

    /** we can still use the `err' module to backwards-comply with
        frontend implementations that don't; they just have to error
        with the `ERROR' macro and `err' will work normally */
    if (ecode >= ECODE_BEGIN && ecode <= ECODE_END) {
      write(STDERR_FILENO, emsg[ecode]._, emsg[ecode].size);
    }
  }

  return (int) pecode;
}
