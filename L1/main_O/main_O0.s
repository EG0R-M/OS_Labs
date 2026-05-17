	.file	"main.c"
	.text
	.globl	factorial_iter
	.def	factorial_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_iter
factorial_iter:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	$1, -8(%rbp)
	movl	$2, -12(%rbp)
	jmp	.L2
.L3:
	movl	-12(%rbp), %eax
	cltq
	movq	-8(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L2:
	movl	-12(%rbp), %eax
	cmpl	16(%rbp), %eax
	jle	.L3
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	factorial_rec
	.def	factorial_rec;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_rec
factorial_rec:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	%ecx, -64(%rbp)
	cmpl	$1, -64(%rbp)
	jg	.L6
	movl	$1, %eax
	jmp	.L7
.L6:
	movl	-64(%rbp), %eax
	movslq	%eax, %rbx
	movl	-64(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %ecx
	call	factorial_rec
	imulq	%rbx, %rax
.L7:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	fibonacci_iter
	.def	fibonacci_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci_iter
fibonacci_iter:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	cmpl	$1, 16(%rbp)
	jg	.L9
	movl	16(%rbp), %eax
	cltq
	jmp	.L10
.L9:
	movq	$0, -8(%rbp)
	movq	$1, -16(%rbp)
	movl	$2, -20(%rbp)
	jmp	.L11
.L12:
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	addl	$1, -20(%rbp)
.L11:
	movl	-20(%rbp), %eax
	cmpl	16(%rbp), %eax
	jle	.L12
	movq	-16(%rbp), %rax
.L10:
	addq	$32, %rsp
	popq	%rbp
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
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\321\200\320\265\320\272\321\203\321\200\321\201\320\270\320\262\320\275\320\276): %llu\12\0"
	.align 8
.LC3:
	.ascii "\320\247\320\270\321\201\320\273\320\276 \320\244\320\270\320\261\320\276\320\275\320\260\321\207\321\207\320\270: %llu\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	movl	$10, -4(%rbp)
	cmpl	$1, 16(%rbp)
	jle	.L14
	movq	24(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	atoi
	movl	%eax, -4(%rbp)
.L14:
	movl	-4(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	call	factorial_iter
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	call	factorial_rec
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	call	fibonacci_iter
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	atoi;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
