# C Project Template

Template files that might be useful in a C project.

This repository is broken into sections, each of which is a directory.

## Sections

### scripts/

These are shell, `m4` and `awk` scripts that could be useful on a C project
*that doesn't use a pre-existing make system* (like CMAKE, autotools, ...) or
alongside GNU make itself. This is **not** a proper substitute for these make
systems, rather just a collection of small scripts that emulate what those
systems do.

### src/

Source directory for C *source* (`.c`) and *header* (`.h`) files. These are
generally utils that are too small to compile to a library, but you could use
`CPROJ.MAKE` (aka the scripts for the make system in `scripts/`) to compile them
to a library.

# Documentation

For documentation for a specific section, go to that section and read the
`README.md` file there.

# License

This repository is licensed under the [MIT
License](https://opensource.org/licenses/MIT).
