# fparse

A small, standalone, modern fortran input file parser.

## Features

- Block-based input files with `block` ... `end`
- Case-insensitive blocks and keys
- `#` comments
- Line continuation with `\`
- `@include` for splitting inputs across files
- Schema-driven validation with defaults
- Immediate stop on any invalid input or missing required item

## Input file format

```
# comment lines start with #
BLOCK_NAME
[key] value
[another_key] value1 value2 \
              value3 value4
end

@include other_input.in
```

- Blocks are started by a line containing the block name.
- Blocks end with a line containing `end` (case-insensitive).
- Keys are written as `[key] value` and are case-insensitive.
- `#` starts a comment anywhere on a line.
- A trailing `\` joins the next line to the current value.
- `@include filename` inserts another file at that location.

## Integration as a git submodule

Recommended layout in your target project:

```
my_project/
    src/
    fparse/          # this repo as a submodule
```

add the submodule:

```
git submodule add <fparse_repo_url> src/fparse
```

Other locations also work (e.g., `vendor/fparse/` or `libs/fparse/`). the key
point is that you compile the fparse sources along with your own sources.

## How to use in your code

1. Define a schema in your code using `init_schema`, `add_block`, and `add_key`.
2. Parse an input file with `parse_input`.
3. Read values using typed getters like `get_integer`, `get_real`, or lists.

Example (simplified from `examples/example_main.f90`):

```fortran
program main
    use fparse
    implicit none

    type(schema_type) :: schema
    type(input_tree_type) :: tree
    integer :: nelecs

    call init_schema(schema)
    call add_block(schema, 'TARGET', .true.)
    call add_key(schema, 'TARGET', 'nelecs', .true., .false., '')

    call parse_input(schema, 'data.in', tree, 6)
    call get_integer(schema, tree, 'TARGET', 'nelecs', nelecs, 6)
end program main
```

## Compiling and linking in your project

fparse is not a separate library by default. you compile the fparse source
files together with your project. any build system is fine as long as it:

- compiles `src/fparse_*.f90`
- puts `.mod` files in a location used by your compiler
- links the resulting object files into your final executable

Example gfortran command line:

```
gfortran -c src/fparse/src/fparse_types.f90 -J build -I build
... compile remaining fparse sources ...
... compile your project sources ...

gfortran <all objects> -o my_exe
```

If you already use a build directory, direct both your project and fparse
modules there (the `-J` and `-I` flags handle module output and search paths).

## Provided example

This repo includes `compile/Makefile` which builds the example program and
puts all outputs in `build/`:

```
make -C compile
./build/example_main
```

## Include files

Use `@include other.in` to include another file. the included path is resolved
relative to the including file unless it is an absolute path.

## Line continuation

a trailing `\` joins the next non-empty line into the current value.

## Error handling

the parser stops immediately on any invalid input and prints a message with
source file and line number. required blocks/keys are enforced by the schema.

## Required vs optional keys and defaults

each key in the schema has:

- `required`: if true, missing input stops the program.
- `has_default`: if true and the key is missing, the default is used.
- `default_value`: a string used when `has_default` is true.

Example:

```fortran
call add_key(schema, 'OPTIONS', 'mode', .false., .true., 'standard')
call add_key(schema, 'OPTIONS', 'flags', .false., .false., '')
```

In this example, `mode` is optional and defaults to `standard`, while `flags`
is optional and has no default. if an optional key is missing and has no
default, the getter can return a `found = .false.` flag.

## API overview

- schema construction: `init_schema`, `add_block`, `add_key`
- parsing: `parse_input`
- getters: `get_string`, `get_integer`, `get_real`, `get_logical`
- list getters: `get_string_list`, `get_integer_list`, `get_real_list`
- presence checks: `has_block`, `has_key`
