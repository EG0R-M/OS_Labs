	.file	"main.c"
	.text
	.globl	factorial_iter
	.def	factorial_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_iter
factorial_iter:
	.seh_endprologue
	movl	$2, %edx
	movl	$1, %eax
.L2:
	cmpl	%edx, %ecx
	jl	.L5
	imulq	%rdx, %rax
	incq	%rdx
	jmp	.L2
.L5:
	ret
	.seh_endproc
	.globl	factorial_rec
	.def	factorial_rec;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_rec
factorial_rec:
	.seh_endprologue
	movl	$1, %eax
	movslq	%ecx, %rdx
.L8:
	cmpl	$1, %ecx
	jle	.L9
	imulq	%rdx, %rax
	decl	%ecx
	decq	%rdx
	jmp	.L8
.L9:
	ret
	.seh_endproc
	.globl	fibonacci_iter
	.def	fibonacci_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci_iter
fibonacci_iter:
	.seh_endprologue
	cmpl	$1, %ecx
	movslq	%ecx, %rax
	jle	.L10
	movl	$2, %edx
	movl	$1, %r8d
	xorl	%r9d, %r9d
.L11:
	leaq	(%r9,%r8), %rax
	incl	%edx
	movq	%r8, %r9
	cmpl	%edx, %ecx
	movq	%rax, %r8
	jge	.L11
.L10:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "\320\222\321\213\321\207\320\270\321\201\320\273\320\265\320\275\320\270\321\217 \320\264\320\273\321\217 n = %d\12\0"
.LC1:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\320\270\321\202\320\265\321\200\320\260\321\202\320\270\320\262\320\275\320\276): %llu\12\0"
.LC2:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\321\200\320\265\320\272\321\203\321\200\321\201\320\270\320\262\320\275\320\276): %llu\12\0"
.LC3:
	.ascii "\320\247\320\270\321\201\320\273\320\276 \320\244\320\270\320\261\320\276\320\275\320\260\321\207\321\207\320\270: %llu\12\0"
	.section	.text.startup,"x"
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	$10, %ebx
	movl	%ecx, %edi
	movq	%rdx, %rsi
	call	__main
	decl	%edi
	jle	.L16
	movq	8(%rsi), %rcx
	call	atoi
	movl	%eax, %ebx
.L16:
	leaq	.LC0(%rip), %rcx
	movl	%ebx, %edx
	call	printf
	movl	%ebx, %ecx
	call	factorial_iter
	leaq	.LC1(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	movl	%ebx, %ecx
	call	factorial_rec
	leaq	.LC2(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	movl	%ebx, %ecx
	call	fibonacci_iter
	leaq	.LC3(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	atoi;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
