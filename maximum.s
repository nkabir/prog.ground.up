.section .data
list_1:
	.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
list_2:
	.long 1,2,4,3,8,2,0
list_3:
	.long 33,66,12,34,888,7,0

.section .text

.global _start
_start:
	pushl list_3
	pushl list_2
	pushl list_1
	call max
	addl $12, %esp
	movl $1, %eax
	int $0x80

.type max, @function
max:
	movl $0, %edi
	movl list_1(,%edi,4), %eax
	movl %eax, %ebx

start_loop:
	cmpl $0, %eax
	je loop_exit
	incl %edi
	movl list_1(,%edi,4), %eax
	cmpl %ebx, %eax
	jle start_loop
	movl %eax, %ebx
	jmp start_loop

loop_exit:
	ret
