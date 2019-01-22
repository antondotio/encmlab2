		.data
greeting:	.asciiz "Hello ENCM 369!\n"

	
		.text
		la $a0, greeting
		addi $v0, $zero, 4
		syscall
		
		addi $v0, $zero, 10
		syscall
		 	