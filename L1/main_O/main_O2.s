	.file	"main.c"
	.text
	.p2align 4,,15
	.globl	factorial_iter
	.def	factorial_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_iter
factorial_iter:
	.seh_endprologue
	cmpl	$1, %ecx
	jle	.L4
	subl	$2, %ecx
	movl	$2, %edx
	movl	$1, %eax
	addq	$3, %rcx
	.p2align 4,,10
.L3:
	imulq	%rdx, %rax
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	jne	.L3
	ret
	.p2align 4,,10
.L4:
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	factorial_rec
	.def	factorial_rec;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_rec
factorial_rec:
	.seh_endprologue
	movl	$1, %eax
	cmpl	$1, %ecx
	jle	.L7
	leal	-2(%rcx), %eax
	movslq	%ecx, %r8
	leaq	-1(%r8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	movl	$1, %eax
	jmp	.L10
	.p2align 4,,10
.L11:
	subq	$1, %rdx
.L10:
	imulq	%r8, %rax
	cmpq	%rcx, %rdx
	movq	%rdx, %r8
	jne	.L11
.L7:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	fibonacci_iter
	.def	fibonacci_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci_iter
fibonacci_iter:
	.seh_endprologue
	cmpl	$1, %ecx
	movslq	%ecx, %rax
	jle	.L12
	addl	$1, %ecx
	movl	$2, %r8d
	movl	$1, %edx
	xorl	%r9d, %r9d
	.p2align 4,,10
.L15:
	leaq	(%r9,%rdx), %rax
	addl	$1, %r8d
	movq	%rdx, %r9
	cmpl	%r8d, %ecx
	movq	%rax, %rdx
	jne	.L15
.L12:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "\320\222\321\213\321\207\320\270\321\201\320\273\320\265\320\275\320\270\321\217 \320\264\320\273\321\217 n = %d\12\0"
	.align 8
.LC1:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\320\270\321\202\320\265\321\200\320\260\321\202\320\270\320\262\320\275\320\276): %llu\12\0"
	.align 8
.LC2:
	.ascii "\320\247\320\270\321\201\320\273\320\276 \320\244\320\270\320\261\320\276\320\275\320\260\321\207\321\207\320\270: %llu\12\0"
	.align 8
.LC3:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\321\200\320\265\320\272\321\203\321\200\321\201\320\270\320\262\320\275\320\276): %llu\12\0"
	.section	.text.startup,"x"
	.p2align 4,,15
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx
	movq	%rdx, %rsi
	call	__main
	cmpl	$1, %ebx
	jg	.L18
	movl	$10, %edx
	movl	$10, %ebx
	leaq	.LC0(%rip), %rcx
	call	printf
.L19:
	movl	$2, %eax
	movl	$1, %edx
	.p2align 4,,10
.L21:
	imulq	%rax, %rdx
	addq	$1, %rax
	cmpl	%eax, %ebx
	jge	.L21
	leaq	.LC1(%rip), %rcx
	call	printf
	leal	-2(%rbx), %edx
	movslq	%ebx, %rcx
	leaq	-1(%rcx), %rax
	movq	%rax, %r8
	subq	%rdx, %r8
	movl	$1, %edx
	jmp	.L23
	.p2align 4,,10
.L29:
	subq	$1, %rax
.L23:
	imulq	%rcx, %rdx
	cmpq	%r8, %rax
	movq	%rax, %rcx
	jne	.L29
	leaq	.LC3(%rip), %rcx
	addl	$1, %ebx
	call	printf
	movl	$2, %ecx
	movl	$1, %eax
	xorl	%r8d, %r8d
	.p2align 4,,10
.L24:
	leaq	(%r8,%rax), %rdx
	addl	$1, %ecx
	movq	%rax, %r8
	cmpl	%ebx, %ecx
	movq	%rdx, %rax
	jne	.L24
.L25:
	leaq	.LC2(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L18:
	movq	8(%rsi), %rcx
	call	atoi
	leaq	.LC0(%rip), %rcx
	movl	%eax, %ebx
	movl	%eax, %edx
	call	printf
	cmpl	$1, %ebx
	jg	.L19
	leaq	.LC1(%rip), %rcx
	movl	$1, %edx
	call	printf
	movl	$1, %edx
	leaq	.LC3(%rip), %rcx
	call	printf
	movslq	%ebx, %rdx
	jmp	.L25
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	atoi;	.scl	2;	.type	32;	.endef
