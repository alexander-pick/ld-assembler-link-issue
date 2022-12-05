# ld is silently creating executable stacks (in 2022)

This is a testcase for a weird linker issue which creates binaries with executable stack. If you compile an object from assembler and link it to an object compiled from C, the binary will have an executable stack by default. 

That is pretty uncool from a security point of view if not intended. For me it caused my code to malfunction and I had to debug it "with tweezers" for 2 days.

Normally `ld` should output a warning if the stack is made executable, but there is no such warning here. 

Ref.: https://sourceware.org/binutils/docs-2.39/ld/Options.html#index-_002d_002dwarn_002dexecstack

> On the other hand the linker will normally warn if the stack is made executable because one or more of the input
>  files need an execuable stack and neither of the -z execstack or -z noexecstack command line options have been
>  specified. This warning can be disabled via the --no-warn-execstack option.

There is another info in this doc which I was given as an explanation:

> Note: ELF format input files specify that they need an executable stack by having a .note.GNU-stack section 
> with the executable bit set in its section flags. They can specify that they do not need an executable stack by
> having that section, but without the executable flag bit set. If an input file does not have a .note.GNU
> stack section present then the default behaviour is target specific. For some targets, then absence of such a
> section implies that an executable stack is required. This is often a problem for hand crafted assembler files.

The feedback I got so far related to this issue was, that it "legacy assembly code might still
use an executable stack". I requested that the missing warning is added in my report to `binutils`.

tl;dr if linking objects compiled from asm into your binary, set `-z noexecstack` to make sure you don't end up with an executable stack.

Reported to the `gcc` and `binutils` bugtracker 05th of December 2022.
