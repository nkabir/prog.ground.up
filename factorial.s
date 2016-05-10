.section .data

.section .text

.global _start

.global factorial

_start:
	pushl $5			# set param
	call factorial
	addl $4, %esp		# dispose param
	movl %eax, %ebx		# move answer to status
	movl $1, %eax
	int $0x80			# exit

.type factorial, @function

factorial:
	pushl %ebp				# save old %ebp
	movl %esp, %ebp			# place new %ebp
	movl 8(%ebp), %eax		# get first param, *return address at 4
	cmpl $1, %eax			# is param 1?
	je end_factorial		# if so end (returning 1)

	decl %eax				# otherwise decrement param
	pushl %eax				# push decremented param back into function
	call factorial			# call recursively, answer now in %eax
	movl 8(%ebp), %ebx		# put original param in %ebx
	imull %ebx, %eax		# return param * param-1 

end_factorial:
	movl %ebp, %esp			# move stack pointer to %ebp
	popl %ebp				# restore old %ebp
	ret						# return, popping the return address (restoring %esp)

