# ld creates an executable stack (in 2022)

This is a testcase for a weird linker issue which creates binaries with executable stacks. If you compile an object from assembler and link it to an object compiled from C, the binary will have an executable stack by default. That is pretty uncool from a security point of view if not intended. For me it caused my code to malfunction and I had to debug it "with tweezers" for 2 days.

Normally ld should output a warning if the stack is made executable, but there is no such warning here.

From https://sourceware.org/binutils/docs-2.39/ld/Options.html#index-_002d_002dwarn_002dexecstack
```txt
On the other hand the linker will normally warn if the stack is made executable because one or more of the input files need an execuable stack and neither of the -z execstack or -z noexecstack command line options have been specified. This warning can be disabled via the --no-warn-execstack option.
```

tl;dr if linking objects compiled from asm into your binary, set `-z noexecstack` to make sure you don't end up with an executable stack.

Reported to the gcc and binutils bugtracker 05th of December 2022.
