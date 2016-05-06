.section .data

.section .text

.global _start
	_start:
		# do first calc and save the answer
		pushl $3
		pushl $2
		call power
		addl $8, %esp

		# save answer
		pushl %eax

		# do second calc
		pushl $2
		pushl $5
		call power
		addl $8, %esp

		# put prev answer into %ebx
		popl %ebx

		# add both together and store into %ebx
		addl %eax, %ebx

		# do third call
		pushl %ebx
        pushl $3
        pushl $3
        call power
        addl $8, %esp

		# sum
		popl %ebx
		addl %eax, %ebx

		# exit with answer as return status
		movl $1, %eax
		int $0x80

.type power,  @function
	power:
		# ?
		pushl %ebp
		movl %esp, %ebp
		subl $4, %esp

		# load params
		movl 8(%ebp), %ebx
		movl 12(%ebp), %ecx
		movl %ebx, -4(%ebp)

	power_loop_start:
		# have we looped down to 1?
		cmpl $1, %ecx
		je end_power

		# multiply prev result by base and store
		movl -4(%ebp), %eax
		imull %ebx, %eax
		movl %eax, -4(%ebp)

		# go again
		decl %ecx
		jmp power_loop_start

	end_power:
		movl -4(%ebp), %eax
		movl %ebp, %esp
		popl %ebp
		ret


