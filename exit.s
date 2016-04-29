.section .data

.section .text

.globl _start

_start:
	movl $1, %eax	# exit signal
	movl $1, %ebx	# status
	int $0x80		# kernel interrupt


