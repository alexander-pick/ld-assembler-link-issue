# LD creating executable stacks (in 2022)

This is a testcase for a weird linker issue which creates binaries with executable stacks. If you compile an object from assembler and link it to an object compiled from C, the binary will have an executable stack. 

Normally LD should put out a warning if the stack is made executable, but there is no such warning here.

https://sourceware.org/binutils/docs-2.39/ld/Options.html#index-_002d_002dwarn_002dexecstack
```
On the other hand the linker will normally warn if the stack is made executable because one or more of the input files need an execuable stack and neither of the -z execstack or -z noexecstack command line options have been specified. This warning can be disabled via the --no-warn-execstack option.
```
