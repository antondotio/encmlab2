
# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciiz	"***About to exit. main returned "
exit_msg_2:
	.asciiz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust $sp, then call main
	addi	$t0, $zero, -32		# $t0 = 0xffffffe0
	and	$sp, $sp, $t0		# round $sp down to multiple of 32
	jal	main
	nop
	
	# when main is done, print its return value, then halt the program
	sw	$v0, main_rv	
	la	$a0, exit_msg_1
	addi	$v0, $zero, 4
	syscall
	nop
	lw	$a0, main_rv
	addi	$v0, $zero, 1
	syscall
	nop
	la	$a0, exit_msg_2
	addi	$v0, $zero, 4
	syscall
	nop
	addi	$v0, $zero, 10
	syscall
	nop	
# END of start-up & clean-up code.

# Below is the stub for main. Edit it to give main the desired behaviour.

        
        .data
        .globl foo
foo:    .word 0xd3, 0xe3, 0xf3, 0xc3, 0x83, 0x93, 0xa3, 0xb3
        .globl bar
bar:    .word 0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x30, 0x10

# int main(void)
#
# local variable        register
#       int *p          $s0
#       int *q          $s1
#       int *stop       $s2
#       int max         $s3
#       int j           $s4
#       int *m          $s5
#       int n           $s6
	
	.text
	.globl	main

main:
        la      $s5, foo                # m = foo
        addi    $s4, $zero, 4           # j = 1
        addi    $t0, $zero, 32          # $t0 = 8
        add     $s3, $zero, $zero       # max = 0

for_start:
        slt     $t1, $s4, $t0           # $t1 = if($s4 < $t0)
        beq     $t1, $zero, for_end     # if($t1 == 0)  goto for_end
        add     $t2, $s5, $s4           # $t2 = foo[j]

        slt     $t3, $s3, $t2           # $t3 = if(max < foo[j])
        beq     $t3, $zero, if_end      # if($t3 == 0) goto if_end
        add     $s3, $zero, $t2         # max = foo[j]

if_end:
        addi    $s4, $s4, 4             # j++
        j       for_start               # goto for_start        

for_end:     
        la      $s0, bar                # p = bar
        addi    $s1, $s5, 32            # q = foo + 8
        addi    $s2, $s0, 32            # stop = p + 8
        lw      $s3, ($t0)              # max = foo[0]

do_start:      
        addi	$s1, $s1, -4	        # q--
        lw      $t4, ($s0)              # $t4 = *p
        sw      $t4, ($s1)              # *q = *p
        addi    $s0, $s0, 4             # p++
        bne     $s0, $s2, do_end        # if(p == stop) goto do_end
        j       do_start                # goto do_start

do_end:   

end:
	add	$v0, $zero, $zero	# return value from main = 0
	jr	$ra
