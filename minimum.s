.section .data
	data_items:
		.long 3,67,34,222,45,2,54,34,44,33,22,11,66,0

.section .text
	.global _start

	_start:
		movl $0, %edi
		movl data_items(,%edi,4), %ebx

	start_loop:
		incl %edi
		movl data_items(, %edi, 4), %eax
		cmpl $0, %eax
		je loop_exit

		cmpl %ebx, %eax
		jge start_loop

		movl %eax, %ebx

	loop_exit:
		movl $1, %eax
		int $0x80
