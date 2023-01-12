###########################################################################
#  Name: Marlon Alejandro
#  NSHE ID: 5002573038	
#  Section: 1003
#  Assignment: MIPS #5
#  Description: Recursion w/ MIPS


###########################################################################
#  data segment

.data

# -----
#  Constants

TRUE = 1
FALSE = 0
COORD_MAX = 100

# -----
#  Variables for main

hdr:		.ascii	"\n**********************************************\n"
		.ascii	"\nMIPS Assignment #5\n"
		.asciiz	"Count Grid Paths Program\n"

startRow:	.word	0
startCol:	.word	0
endRow:		.word	0
endCol:		.word	0

totalCount:	.word	0

endMsg:		.ascii	"\nYou have reached recursive nirvana.\n"
		.asciiz	"Program Terminated.\n"

# -----
#  Local variables for prtResults() function.

cntMsg1:	.asciiz	"\nFrom a start coordinate of ("
cntMsgComma:	.asciiz	","
cntMsg2:	.asciiz	"), to an end coordinate of ("
cntMsg3:	.asciiz	"), \nthere are "
cntMsg4:	.asciiz	" ways traverse the grid.\n"

# -----
#  Local variables for readCoords() function.

strtRowPmt:	.asciiz	"  Enter Start Coordinates ROW: "
strtColPmt:	.asciiz	"  Enter Start Coordinates COL: "

endRowPmt:	.asciiz	"  Enter End Coordinates ROW: "
endColPmt:	.asciiz	"  Enter End Coordinates COL: "

err0:		.ascii	"\nError, invalid coordinate value.\n"
		.asciiz	"Please re-enter.\n"

err1:		.ascii	"\nError, end coordinates must be > then "
		.ascii	"the start coordinates. \n"
		.asciiz	"Please re-enter.\n"

spc:		.asciiz	"   "

# -----
#  Local variables for prtNewline function.

newLine:	.asciiz	"\n"


###########################################################################
#  text/code segment

.text
.globl main
.ent main
main:

# -----
#  Display program header.

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  Function to read and return initial coordinates.

	la	$a0, startRow
	la	$a1, startCol
	la	$a2, endRow
	la	$a3, endCol
	jal	readCoords

# -----
#  countPaths - determine the number of possible
#		paths through a two-dimensional grid.
#	returns integer answer.

#  HLL Call:
#	totalCount = countPaths(startRow, startCol, endRow, endCol)

	lw	$a0, startRow
	lw	$a1, startCol
	lw	$a2, endRow
	lw	$a3, endCol
	jal	countPaths
	sw	$v0, totalCount

# ----
#  Display results (formatted).

	lw	$a0, startRow
	lw	$a1, startCol
	lw	$a2, endRow
	lw	$a3, endCol
	subu	$sp, $sp, 4
	lw	$t0, totalCount
	sw	$t0, ($sp)
	jal	prtResults
	addu	$sp, $sp, 4

# -----
#  Done, show message and terminate program.

	li	$v0, 4
	la	$a0, endMsg
	syscall

	li	$v0, 10
	syscall					# all done...
.end main

# =========================================================================
#  Very simple function to print a new line.
#	Note, this routine is optional.

.globl	prtNewline
.ent	prtNewline
prtNewline:
	la	$a0, newLine
	li	$v0, 4
	syscall

	jr	$ra
.end	prtNewline

# =========================================================================
#  Function to print final results (formatted).

# -----
#    Arguments:
#	startRow, value
#	startCol, value
#	endRow, value
#	endCol, value
#	totalCount, value
#    Returns:

.globl	prtResults
.ent	prtResults
prtResults:


	#	YOUR CODE GOES HERE

	subu $sp, $sp, 28 	#stack based argument 
	sw $ra, ($sp) 		#set said argument 
	sw $fp, 4($sp) 
	sw $s0, 8($sp) 
	sw $s1, 12($sp) 
	sw $s2, 16($sp) 
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	addu $fp, $sp,	28 


	move $s0, $a0	#start row
	move $s1, $a1	#start col
	move $s2, $a2	#end row
	move $s3, $a3	#end col
	lw $s4, ($fp)	##num of rows

	jal prtNewline

	la	$a0, cntMsg1
	li	$v0, 4
	syscall

	move $a0, $s0
	li	$v0, 1
	syscall
	#start row
	la	$a0, cntMsgComma
	li	$v0, 4
	syscall

	move $a0, $s1
	li	$v0, 1
	syscall
	#start col
	la	$a0, cntMsg2
	li	$v0, 4
	syscall	

	move $a0, $s2
	li	$v0, 1
	syscall
	#end row
	la	$a0, cntMsgComma
	li	$v0, 4
	syscall	

	move $a0, $s3
	li	$v0, 1
	syscall
	#end col
	la	$a0, cntMsg3
	li	$v0, 4
	syscall	

	move $a0, $s4
	li	$v0, 1
	syscall
	#pathways
	la	$a0, cntMsg4
	li	$v0, 4
	syscall	
	
	lw $ra, ($sp) 
	lw $fp, 4($sp)
	lw $s0, 8($sp) 
	lw $s1, 12($sp) 
	lw $s2, 16($sp) 
	lw $s3, 20($sp) 
	lw $s4, 24($sp)
	addu $sp, $sp, 28

	jr	$ra
.end	prtResults

# =========================================================================
#  Prompt for and read start and end coordinates.
#  Also, must ensure that:
#	each value is between 0 and COORD_MAX
#	start coordinates are < end coordinates

# -----
#    Arguments:
#	startRow, address
#	startCol, address
#	endRow, address
#	endCol, address
#    Returns:
#	startRow, startCol, endRow, endCol via reference

.globl	readCoords
.ent	readCoords
readCoords:


	#	YOUR CODE GOES HERE
	# la	$a0, startRow
	# la	$a1, startCol
	# la	$a2, endRow
	# la	$a3, endCol
	# jal	readCoords
	subu $sp, $sp, 24 	
	sw $ra, ($sp) 		
	sw $fp, 4($sp) 
	sw $s0, 8($sp) 
	sw $s1, 12($sp) 
	sw $s2, 16($sp) 
	sw $s3, 20($sp)
	addu $fp, $sp,	24 
	#Dont forget to push
	startRead:
		move $s0, $a0	#sav register
		move $s1, $a1	#start col
		move $s2, $a2	#end row
		move $s3, $a3	#end col

	#STDIN- 0	STDOUT-1	STDERR-2
	startRows:
		la $a0, strtRowPmt	
		li $v0, 4			#print string
		syscall
		# read in from terminal

		la $v0, 5	# read user entered int
		syscall
		###Validate return value
		## reprompt if wrong loop
		bgt	$v0, COORD_MAX, invalidCoordSR	#greater than
		blt	$v0, 0, invalidCoordSR		#less than
		sw $v0, ($s0) #return value

	startColumn:
		la $a0, strtColPmt	
		li $v0, 4			#print string
		syscall

		la $v0, 5	# read user entered int
		syscall
		bgt	$v0, COORD_MAX, invalidCoordSC	#greater than
		blt	$v0, 0, invalidCoordSC		#less than
		sw $v0, ($s1) #return value


	endRows:
		la $a0, endRowPmt	
		li $v0, 4			#print string
		syscall

		la $v0, 5	# read user entered int
		syscall
		bgt	$v0, COORD_MAX, invalidCoordER	#greater than
		blt	$v0, 0, invalidCoordER		#less than
		sw $v0, ($s2) #return value


	endColumn:
		la $a0, endColPmt	
		li $v0, 4			#print string
		syscall

		la $v0, 5	# read user entered int
		syscall
		bgt	$v0, COORD_MAX, invalidCoordEC	#greater than
		blt	$v0, 0, invalidCoordEC		#less than
		sw $v0, ($s3) #return value

	j checkRead

	invalidCoordSR:
		la $a0, err0	
		li $v0, 4			#print string
		syscall
		j startRows

	invalidCoordSC:
		la $a0, err0	
		li $v0, 4			#print string
		syscall
		j startColumn

	invalidCoordER:
		la $a0, err0	
		li $v0, 4			#print string
		syscall		
		j endRows

	invalidCoordEC:
		la $a0, err0	
		li $v0, 4			#print string
		syscall
		j endColumn

	startEndErr:
		la $a0, err1	
		li $v0, 4			#print string
		syscall
		j startRead

	startAtEnd:
		bge $s1, $s3, startEndErr
		j finishCheck

	checkRead:
		#s0- sr	s1-sc s2-er s3- ec
		lw $s0, ($s0)
		lw $s1, ($s1)
		lw $s2, ($s2)
		lw $s3, ($s3)
		bgt $s0, $s2, startEndErr
		beq $s0, $s2, startAtEnd

	finishCheck:
		bgt $s1, $s3, startEndErr


	lw $ra, ($sp) 
	lw $fp, 4($sp)
	lw $s0, 8($sp) 
	lw $s1, 12($sp) 
	lw $s2, 16($sp) 
	lw $s3, 20($sp) 
	addu $sp, $sp, 24
	jr	$ra
.end	readCoords

#####################################################################
#  Function to recursivly determine the number of possible
#  paths through a two-dimensional grid.
#  Only allowed moves are one step to the right or one step down.  

#  HLL Call:
#	totalCount = countPaths(startRow, startCol, endRow, endCol)

# -----
#  Arguments:
#	startRow, value
#	startCol, value
#	endRow, value
#	endCol, value

#  Returns:
#	$v0 - paths count

.globl	countPaths
.ent	countPaths
countPaths:
	subu $sp, $sp, 16	
	sw $ra, ($sp) 		
	sw $fp, 4($sp) 
	sw $s0, 8($sp) 
	sw $s1, 12($sp) 
	addu $fp, $sp,	16

	move $s0, $a0	#start row
	move $s1, $a1	#start col
		
#	YOUR CODE GOES HERE
	moveDown:
		beq $s0, $a2, moveRight
		addu $a0, $a0, 1
		jal countPaths

	move $a0, $s0	#start row
	move $a1, $s1	#start col

	moveRight:
		beq $s1, $a3, atEnd
		addu $a1, $a1, 1
		jal countPaths

	atEnd:
		bne $s0, $a2, finish
		bne $s1, $a3, finish
		la $t0, totalCount
		lw $t1, ($t0)
		add $t1, $t1, 1
		sw $t1, ($t0)

	finish:
	la $t0, totalCount
	lw $v0, ($t0)
	lw $ra, ($sp) 
	lw $fp, 4($sp)
	lw $s0, 8($sp) 
	lw $s1, 12($sp)  
	addu $sp, $sp, 16
	jr	$ra
.end countPaths

#####################################################################

