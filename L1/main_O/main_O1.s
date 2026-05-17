	.file	"main.c"
	.text
	.globl	factorial_iter
	.def	factorial_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_iter
factorial_iter:
	.seh_endprologue
	cmpl	$1, %ecx
	jle	.L4
	leal	-2(%rcx), %ecx
	addq	$3, %rcx
	movl	$2, %edx
	movl	$1, %eax
.L3:
	imulq	%rdx, %rax
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	jne	.L3
.L1:
	ret
.L4:
	movl	$1, %eax
	jmp	.L1
	.seh_endproc
	.globl	factorial_rec
	.def	factorial_rec;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_rec
factorial_rec:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %ebx
	movl	$1, %eax
	cmpl	$1, %ecx
	jle	.L6
	leal	-1(%rcx), %ecx
	call	factorial_rec
	movslq	%ebx, %rcx
	imulq	%rcx, %rax
.L6:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	fibonacci_iter
	.def	fibonacci_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci_iter
fibonacci_iter:
	.seh_endprologue
	movslq	%ecx, %rax
	cmpl	$1, %ecx
	jle	.L9
	addl	$1, %ecx
	movl	$2, %r8d
	movl	$1, %edx
	movl	$0, %r9d
.L12:
	leaq	(%r9,%rdx), %rax
	addl	$1, %r8d
	movq	%rdx, %r9
	movq	%rax, %rdx
	cmpl	%r8d, %ecx
	jne	.L12
.L9:
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
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, %esi
	movq	%rdx, %rdi
	call	__main
	movl	$10, %ebx
	cmpl	$1, %esi
	jg	.L17
.L15:
	movl	%ebx, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	%ebx, %ecx
	call	factorial_iter
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	%ebx, %ecx
	call	factorial_rec
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	movl	%ebx, %ecx
	call	fibonacci_iter
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L17:
	movq	8(%rdi), %rcx
	call	atoi
	movl	%eax, %ebx
	jmp	.L15
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	atoi;	.scl	2;	.type	32;	.endef
