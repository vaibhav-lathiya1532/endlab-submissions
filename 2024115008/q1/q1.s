	.file	"q1.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	%rsp, %rax
	movq	%rax, %rbx
	leaq	-68(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-68(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -40(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L2:
	cmpq	%rdx, %rsp
	je	.L3
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L2
.L3:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L4
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L4:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -32(%rbp)
	movl	$0, -64(%rbp)
	jmp	.L5
.L6:
	movl	-64(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	addl	$1, -64(%rbp)
.L5:
	movl	-68(%rbp), %eax
	cmpl	%eax, -64(%rbp)
	jl	.L6
	movl	$0, -60(%rbp)
	movl	$0, -56(%rbp)
	movl	$0, -52(%rbp)
	jmp	.L7
.L9:
	movq	-32(%rbp), %rax
	movl	-52(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %ecx
	movq	-32(%rbp), %rax
	movl	-60(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	cmpl	%eax, %ecx
	jle	.L8
	movl	-52(%rbp), %eax
	movl	%eax, -60(%rbp)
	addl	$1, -56(%rbp)
.L8:
	addl	$1, -52(%rbp)
.L7:
	movl	-68(%rbp), %eax
	cmpl	%eax, -52(%rbp)
	jl	.L9
	movq	-32(%rbp), %rax
	movl	-60(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, -44(%rbp)
	movq	-32(%rbp), %rax
	movl	-60(%rbp), %edx
	movslq	%edx, %rdx
	movl	$-2147483648, (%rax,%rdx,4)
	movl	$0, -60(%rbp)
	movl	$0, -48(%rbp)
	jmp	.L10
.L12:
	movq	-32(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %ecx
	movq	-32(%rbp), %rax
	movl	-60(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	cmpl	%eax, %ecx
	jle	.L11
	movq	-32(%rbp), %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	cmpl	%eax, -44(%rbp)
	je	.L11
	movl	-48(%rbp), %eax
	movl	%eax, -60(%rbp)
.L11:
	addl	$1, -48(%rbp)
.L10:
	movl	-68(%rbp), %eax
	cmpl	%eax, -48(%rbp)
	jl	.L12
	movq	-32(%rbp), %rax
	movl	-60(%rbp), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	%rbx, %rsp
	movl	$0, %eax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
