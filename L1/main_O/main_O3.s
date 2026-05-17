	.file	"main.c"
	.text
	.p2align 4,,15
	.globl	factorial_iter
	.def	factorial_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_iter
factorial_iter:
	subq	$56, %rsp
	.seh_stackalloc	56
	movaps	%xmm6, (%rsp)
	.seh_savexmm	%xmm6, 0
	movaps	%xmm7, 16(%rsp)
	.seh_savexmm	%xmm7, 16
	movaps	%xmm8, 32(%rsp)
	.seh_savexmm	%xmm8, 32
	.seh_endprologue
	cmpl	$1, %ecx
	jle	.L7
	leal	-2(%rcx), %eax
	leal	-1(%rcx), %r8d
	cmpl	$5, %eax
	jbe	.L8
	movl	%r8d, %edx
	xorl	%eax, %eax
	pxor	%xmm7, %xmm7
	movdqa	.LC0(%rip), %xmm3
	movdqa	.LC1(%rip), %xmm4
	shrl	$2, %edx
	movdqa	.LC2(%rip), %xmm8
	.p2align 4,,10
.L4:
	movdqa	%xmm7, %xmm0
	movdqa	%xmm3, %xmm5
	movdqa	%xmm3, %xmm6
	pcmpgtd	%xmm3, %xmm0
	addl	$1, %eax
	paddd	%xmm8, %xmm3
	cmpl	%edx, %eax
	punpckldq	%xmm0, %xmm5
	punpckhdq	%xmm0, %xmm6
	movdqa	%xmm5, %xmm1
	movdqa	%xmm6, %xmm0
	psrlq	$32, %xmm1
	movdqa	%xmm5, %xmm2
	psrlq	$32, %xmm0
	pmuludq	%xmm5, %xmm0
	pmuludq	%xmm6, %xmm1
	pmuludq	%xmm6, %xmm2
	paddq	%xmm0, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm2, %xmm1
	movdqa	%xmm4, %xmm2
	movdqa	%xmm1, %xmm0
	psrlq	$32, %xmm2
	movdqa	%xmm1, %xmm5
	psrlq	$32, %xmm0
	pmuludq	%xmm4, %xmm0
	pmuludq	%xmm2, %xmm1
	pmuludq	%xmm4, %xmm5
	paddq	%xmm1, %xmm0
	psllq	$32, %xmm0
	movdqa	%xmm5, %xmm4
	paddq	%xmm0, %xmm4
	jne	.L4
	movdqa	%xmm4, %xmm3
	movdqa	%xmm4, %xmm1
	movdqa	%xmm4, %xmm2
	psrldq	$8, %xmm3
	movl	%r8d, %r9d
	movdqa	%xmm3, %xmm0
	psrlq	$32, %xmm1
	andl	$-4, %r9d
	psrlq	$32, %xmm0
	leal	2(%r9), %edx
	cmpl	%r9d, %r8d
	pmuludq	%xmm3, %xmm1
	pmuludq	%xmm4, %xmm0
	pmuludq	%xmm3, %xmm2
	paddq	%xmm0, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm2, %xmm1
	movq	%xmm1, %rax
	je	.L1
.L3:
	movslq	%edx, %r8
	imulq	%r8, %rax
	leal	1(%rdx), %r8d
	cmpl	%r8d, %ecx
	jl	.L1
	movslq	%r8d, %r8
	imulq	%r8, %rax
	leal	2(%rdx), %r8d
	cmpl	%r8d, %ecx
	jl	.L1
	movslq	%r8d, %r8
	imulq	%r8, %rax
	leal	3(%rdx), %r8d
	cmpl	%r8d, %ecx
	jl	.L1
	movslq	%r8d, %r8
	imulq	%r8, %rax
	leal	4(%rdx), %r8d
	cmpl	%r8d, %ecx
	jl	.L1
	movslq	%r8d, %r8
	addl	$5, %edx
	imulq	%r8, %rax
	cmpl	%edx, %ecx
	jl	.L1
	movslq	%edx, %rdx
	imulq	%rdx, %rax
.L1:
	movaps	(%rsp), %xmm6
	movaps	16(%rsp), %xmm7
	movaps	32(%rsp), %xmm8
	addq	$56, %rsp
	ret
	.p2align 4,,10
.L7:
	movl	$1, %eax
	jmp	.L1
.L8:
	movl	$2, %edx
	movl	$1, %eax
	jmp	.L3
	.seh_endproc
	.p2align 4,,15
	.globl	factorial_rec
	.def	factorial_rec;	.scl	2;	.type	32;	.endef
	.seh_proc	factorial_rec
factorial_rec:
	subq	$56, %rsp
	.seh_stackalloc	56
	movaps	%xmm6, (%rsp)
	.seh_savexmm	%xmm6, 0
	movaps	%xmm7, 16(%rsp)
	.seh_savexmm	%xmm7, 16
	movaps	%xmm8, 32(%rsp)
	.seh_savexmm	%xmm8, 32
	.seh_endprologue
	movl	$1, %eax
	cmpl	$1, %ecx
	jle	.L11
	leal	-2(%rcx), %eax
	leal	-1(%rcx), %edx
	cmpl	$5, %eax
	jbe	.L18
	movd	%ecx, %xmm7
	movl	%edx, %r8d
	xorl	%eax, %eax
	movdqa	.LC1(%rip), %xmm4
	pshufd	$0, %xmm7, %xmm3
	paddd	.LC3(%rip), %xmm3
	shrl	$2, %r8d
	pxor	%xmm7, %xmm7
	movdqa	.LC4(%rip), %xmm8
	.p2align 4,,10
.L15:
	movdqa	%xmm7, %xmm0
	movdqa	%xmm3, %xmm5
	movdqa	%xmm3, %xmm6
	pcmpgtd	%xmm3, %xmm0
	addl	$1, %eax
	paddd	%xmm8, %xmm3
	cmpl	%r8d, %eax
	punpckldq	%xmm0, %xmm5
	punpckhdq	%xmm0, %xmm6
	movdqa	%xmm5, %xmm1
	movdqa	%xmm6, %xmm0
	psrlq	$32, %xmm1
	movdqa	%xmm5, %xmm2
	psrlq	$32, %xmm0
	pmuludq	%xmm5, %xmm0
	pmuludq	%xmm6, %xmm1
	pmuludq	%xmm6, %xmm2
	paddq	%xmm0, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm2, %xmm1
	movdqa	%xmm4, %xmm2
	movdqa	%xmm1, %xmm0
	psrlq	$32, %xmm2
	movdqa	%xmm1, %xmm5
	psrlq	$32, %xmm0
	pmuludq	%xmm4, %xmm0
	pmuludq	%xmm2, %xmm1
	pmuludq	%xmm4, %xmm5
	paddq	%xmm1, %xmm0
	psllq	$32, %xmm0
	movdqa	%xmm5, %xmm4
	paddq	%xmm0, %xmm4
	jne	.L15
	movdqa	%xmm4, %xmm3
	movdqa	%xmm4, %xmm0
	movdqa	%xmm4, %xmm1
	psrldq	$8, %xmm3
	movl	%edx, %r8d
	movdqa	%xmm3, %xmm2
	psrlq	$32, %xmm0
	andl	$-4, %r8d
	psrlq	$32, %xmm2
	subl	%r8d, %ecx
	cmpl	%r8d, %edx
	pmuludq	%xmm3, %xmm0
	pmuludq	%xmm2, %xmm4
	pmuludq	%xmm3, %xmm1
	paddq	%xmm4, %xmm0
	psllq	$32, %xmm0
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rax
	je	.L11
	leal	-1(%rcx), %edx
.L13:
	movslq	%ecx, %r8
	imulq	%r8, %rax
	cmpl	$1, %edx
	je	.L11
	leal	-2(%rcx), %r8d
	movslq	%edx, %rdx
	imulq	%rdx, %rax
	cmpl	$1, %r8d
	je	.L11
	leal	-3(%rcx), %edx
	movslq	%r8d, %r8
	imulq	%r8, %rax
	cmpl	$1, %edx
	je	.L11
	leal	-4(%rcx), %r8d
	movslq	%edx, %rdx
	imulq	%rdx, %rax
	cmpl	$1, %r8d
	je	.L11
	movslq	%r8d, %r8
	subl	$5, %ecx
	imulq	%r8, %rax
	movslq	%ecx, %rcx
	imulq	%rcx, %rax
.L11:
	movaps	(%rsp), %xmm6
	movaps	16(%rsp), %xmm7
	movaps	32(%rsp), %xmm8
	addq	$56, %rsp
	ret
.L18:
	movl	$1, %eax
	jmp	.L13
	.seh_endproc
	.p2align 4,,15
	.globl	fibonacci_iter
	.def	fibonacci_iter;	.scl	2;	.type	32;	.endef
	.seh_proc	fibonacci_iter
fibonacci_iter:
	.seh_endprologue
	cmpl	$1, %ecx
	movslq	%ecx, %rax
	jle	.L31
	addl	$1, %ecx
	movl	$2, %r8d
	movl	$1, %edx
	xorl	%r9d, %r9d
	.p2align 4,,10
.L34:
	leaq	(%r9,%rdx), %rax
	addl	$1, %r8d
	movq	%rdx, %r9
	cmpl	%r8d, %ecx
	movq	%rax, %rdx
	jne	.L34
.L31:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC5:
	.ascii "\320\222\321\213\321\207\320\270\321\201\320\273\320\265\320\275\320\270\321\217 \320\264\320\273\321\217 n = %d\12\0"
	.align 8
.LC6:
	.ascii "\320\247\320\270\321\201\320\273\320\276 \320\244\320\270\320\261\320\276\320\275\320\260\321\207\321\207\320\270: %llu\12\0"
	.align 8
.LC7:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\321\200\320\265\320\272\321\203\321\200\321\201\320\270\320\262\320\275\320\276): %llu\12\0"
	.align 8
.LC8:
	.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\320\270\321\202\320\265\321\200\320\260\321\202\320\270\320\262\320\275\320\276): %llu\12\0"
	.section	.text.startup,"x"
	.p2align 4,,15
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
	subq	$96, %rsp
	.seh_stackalloc	96
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	movaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	movaps	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	movaps	%xmm9, 80(%rsp)
	.seh_savexmm	%xmm9, 80
	.seh_endprologue
	movl	%ecx, %ebx
	movq	%rdx, %rsi
	call	__main
	cmpl	$1, %ebx
	jg	.L37
	movl	$10, %edx
	movl	$10, %ebx
	movl	$9, %edi
	leaq	.LC5(%rip), %rcx
	call	printf
	movl	$9, %r8d
.L38:
	movl	%r8d, %edx
	xorl	%eax, %eax
	pxor	%xmm7, %xmm7
	movdqa	.LC1(%rip), %xmm9
	movdqa	.LC0(%rip), %xmm6
	shrl	$2, %edx
	movdqa	.LC2(%rip), %xmm8
	.p2align 4,,10
.L41:
	movdqa	%xmm7, %xmm1
	movdqa	%xmm6, %xmm4
	movdqa	%xmm6, %xmm5
	pcmpgtd	%xmm6, %xmm1
	addl	$1, %eax
	paddd	%xmm8, %xmm6
	cmpl	%eax, %edx
	punpckhdq	%xmm1, %xmm5
	punpckldq	%xmm1, %xmm4
	movdqa	%xmm5, %xmm3
	movdqa	%xmm4, %xmm1
	psrlq	$32, %xmm1
	movdqa	%xmm4, %xmm2
	psrlq	$32, %xmm3
	pmuludq	%xmm4, %xmm3
	pmuludq	%xmm5, %xmm1
	pmuludq	%xmm5, %xmm2
	paddq	%xmm3, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm2, %xmm1
	movdqa	%xmm9, %xmm2
	movdqa	%xmm1, %xmm0
	psrlq	$32, %xmm2
	movdqa	%xmm1, %xmm3
	psrlq	$32, %xmm0
	pmuludq	%xmm9, %xmm0
	pmuludq	%xmm2, %xmm1
	pmuludq	%xmm9, %xmm3
	paddq	%xmm1, %xmm0
	psllq	$32, %xmm0
	paddq	%xmm0, %xmm3
	movdqa	%xmm3, %xmm9
	jne	.L41
	psrldq	$8, %xmm3
	movdqa	%xmm9, %xmm1
	movdqa	%xmm9, %xmm2
	movdqa	%xmm3, %xmm0
	psrlq	$32, %xmm1
	movl	%r8d, %eax
	psrlq	$32, %xmm0
	andl	$-4, %eax
	pmuludq	%xmm3, %xmm1
	leal	2(%rax), %ecx
	cmpl	%r8d, %eax
	pmuludq	%xmm9, %xmm0
	pmuludq	%xmm3, %xmm2
	paddq	%xmm0, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm2, %xmm1
	movq	%xmm1, %rdx
	je	.L42
.L40:
	movslq	%ecx, %rax
	imulq	%rax, %rdx
	leal	1(%rcx), %eax
	cmpl	%ebx, %eax
	jg	.L42
	cltq
	imulq	%rax, %rdx
	leal	2(%rcx), %eax
	cmpl	%ebx, %eax
	jg	.L42
	cltq
	imulq	%rax, %rdx
	leal	3(%rcx), %eax
	cmpl	%ebx, %eax
	jg	.L42
	cltq
	imulq	%rax, %rdx
	leal	4(%rcx), %eax
	cmpl	%ebx, %eax
	jg	.L42
	cltq
	addl	$5, %ecx
	imulq	%rax, %rdx
	cmpl	%ebx, %ecx
	jg	.L42
	movslq	%ecx, %rcx
	imulq	%rcx, %rdx
.L42:
	leaq	.LC8(%rip), %rcx
	movl	%ebx, %esi
	call	printf
	leal	-2(%rbx), %eax
	cmpl	$5, %eax
	jbe	.L51
	movd	%ebx, %xmm7
	movl	%edi, %edx
	xorl	%eax, %eax
	movdqa	.LC1(%rip), %xmm9
	pshufd	$0, %xmm7, %xmm6
	paddd	.LC3(%rip), %xmm6
	shrl	$2, %edx
	pxor	%xmm7, %xmm7
	movdqa	.LC4(%rip), %xmm8
	.p2align 4,,10
.L45:
	movdqa	%xmm7, %xmm1
	movdqa	%xmm6, %xmm4
	movdqa	%xmm6, %xmm5
	pcmpgtd	%xmm6, %xmm1
	addl	$1, %eax
	paddd	%xmm8, %xmm6
	cmpl	%eax, %edx
	punpckhdq	%xmm1, %xmm5
	punpckldq	%xmm1, %xmm4
	movdqa	%xmm5, %xmm3
	movdqa	%xmm4, %xmm1
	psrlq	$32, %xmm1
	movdqa	%xmm4, %xmm2
	psrlq	$32, %xmm3
	pmuludq	%xmm4, %xmm3
	pmuludq	%xmm5, %xmm1
	pmuludq	%xmm5, %xmm2
	paddq	%xmm3, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm2, %xmm1
	movdqa	%xmm9, %xmm2
	movdqa	%xmm1, %xmm0
	psrlq	$32, %xmm2
	movdqa	%xmm1, %xmm3
	psrlq	$32, %xmm0
	pmuludq	%xmm9, %xmm0
	pmuludq	%xmm2, %xmm1
	pmuludq	%xmm9, %xmm3
	paddq	%xmm1, %xmm0
	psllq	$32, %xmm0
	paddq	%xmm0, %xmm3
	movdqa	%xmm3, %xmm9
	jne	.L45
	psrldq	$8, %xmm3
	movdqa	%xmm9, %xmm0
	movdqa	%xmm9, %xmm1
	movdqa	%xmm3, %xmm2
	psrlq	$32, %xmm0
	movl	%edi, %eax
	psrlq	$32, %xmm2
	andl	$-4, %eax
	pmuludq	%xmm3, %xmm0
	subl	%eax, %ebx
	cmpl	%eax, %edi
	pmuludq	%xmm2, %xmm9
	pmuludq	%xmm3, %xmm1
	paddq	%xmm9, %xmm0
	psllq	$32, %xmm0
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rdx
	je	.L46
	leal	-1(%rbx), %edi
.L44:
	movslq	%ebx, %rax
	imulq	%rax, %rdx
	cmpl	$1, %edi
	je	.L46
	leal	-2(%rbx), %eax
	movslq	%edi, %rdi
	imulq	%rdi, %rdx
	cmpl	$1, %eax
	je	.L46
	leal	-3(%rbx), %ecx
	cltq
	imulq	%rax, %rdx
	cmpl	$1, %ecx
	je	.L46
	leal	-4(%rbx), %eax
	movslq	%ecx, %rcx
	imulq	%rcx, %rdx
	cmpl	$1, %eax
	je	.L46
	cltq
	subl	$5, %ebx
	imulq	%rax, %rdx
	movslq	%ebx, %rbx
	imulq	%rbx, %rdx
.L46:
	leaq	.LC7(%rip), %rcx
	call	printf
	leal	1(%rsi), %r9d
	movl	$2, %ecx
	xorl	%r8d, %r8d
	movl	$1, %eax
	.p2align 4,,10
.L47:
	leaq	(%r8,%rax), %rdx
	addl	$1, %ecx
	movq	%rax, %r8
	cmpl	%r9d, %ecx
	movq	%rdx, %rax
	jne	.L47
.L48:
	leaq	.LC6(%rip), %rcx
	call	printf
	nop
	movaps	32(%rsp), %xmm6
	xorl	%eax, %eax
	movaps	48(%rsp), %xmm7
	movaps	64(%rsp), %xmm8
	movaps	80(%rsp), %xmm9
	addq	$96, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
.L37:
	movq	8(%rsi), %rcx
	call	atoi
	leaq	.LC5(%rip), %rcx
	movl	%eax, %ebx
	movl	%eax, %edx
	call	printf
	cmpl	$1, %ebx
	jle	.L39
	leal	-1(%rbx), %edi
	cmpl	$7, %ebx
	movl	%edi, %r8d
	jg	.L38
	movl	$1, %edx
	movl	$2, %ecx
	jmp	.L40
.L39:
	leaq	.LC8(%rip), %rcx
	movl	$1, %edx
	call	printf
	movl	$1, %edx
	leaq	.LC7(%rip), %rcx
	call	printf
	movslq	%ebx, %rdx
	jmp	.L48
.L51:
	movl	$1, %edx
	jmp	.L44
	.seh_endproc
	.section .rdata,"dr"
	.align 16
.LC0:
	.long	2
	.long	3
	.long	4
	.long	5
	.align 16
.LC1:
	.quad	1
	.quad	1
	.align 16
.LC2:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC3:
	.long	0
	.long	-1
	.long	-2
	.long	-3
	.align 16
.LC4:
	.long	-4
	.long	-4
	.long	-4
	.long	-4
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	atoi;	.scl	2;	.type	32;	.endef
