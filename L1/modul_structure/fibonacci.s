	.file	"fibonacci.c"
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
	.p2align 4,,15
	.globl	fibonacci_rec
	.def	fibonacci_rec;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci_rec
fibonacci_rec:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	xorl	%edi, %edi
	cmpl	$1, %ecx
	jle	.L20
	leal	-2(%rcx), %ebp
	xorl	%edi, %edi
	leal	-3(%rcx), %ebx
	movl	%ebp, %eax
	leal	-1(%rcx), %esi
	andl	$-2, %eax
	subl	%eax, %ebx
.L19:
	movl	%esi, %ecx
	subl	$2, %esi
	call	fibonacci_rec
	addq	%rax, %rdi
	cmpl	%ebx, %esi
	jne	.L19
	movl	%ebp, %ecx
	andl	$1, %ecx
.L20:
	movslq	%ecx, %rcx
	leaq	(%rcx,%rdi), %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
