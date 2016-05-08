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
        pushl $0
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
		# setup
		pushl %ebp
		movl %esp, %ebp
		subl $4, %esp		# create space for local var

		# load params
		movl 8(%ebp), %ebx		# base
		movl 12(%ebp), %ecx		# power

		# return 1 if power is 0
		cmpl $0, %ecx
		je power_zero

		# store base into initial result
		movl %ebx, -4(%ebp)
		jmp power_loop_start

	power_zero:
		movl $1, -4(%ebp)
		jmp end_power

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
		movl -4(%ebp), %eax		# put result into %eax
		movl %ebp, %esp			# dispose loc vars
		popl %ebp				# restore base pointer to prev value
		ret						# pop return address and use it to return


