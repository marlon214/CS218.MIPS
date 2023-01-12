###########################################################################
#  Name: Marlon Alejandro
#  NSHE ID: 5002573038 
#  Section: 1003 
#  Assignment: MIPS #1
#  Description: Area of Hexagons w/ Mips


################################################################################
#  data segment

.data

sideLens:
	.word	  15,   25,   33,   44,   58,   69,   72,   86,   99,  101
	.word	 369,  374,  377,  379,  382,  384,  386,  388,  392,  393
	.word	 501,  513,  524,  536,  540,  556,  575,  587,  590,  596
	.word	 634,  652,  674,  686,  697,  704,  716,  720,  736,  753
	.word	 107,  121,  137,  141,  157,  167,  177,  181,  191,  199
	.word	 102,  113,  122,  139,  144,  151,  161,  178,  186,  197
	.word	   1,    2,    3,    4,    5,    6,    7,    8,    9,   10
	.word	 202,  209,  215,  219,  223,  225,  231,  242,  244,  249
	.word	 203,  215,  221,  239,  248,  259,  262,  274,  280,  291
	.word	 251,  253,  266,  269,  271,  272,  280,  288,  291,  299
	.word	1469, 2474, 3477, 4479, 5482, 5484, 6486, 7788, 8492

apothemLens:
	.word	  32,   51,   76,   87,   90,  100,  111,  123,  132,  145
	.word	 634,  652,  674,  686,  697,  704,  716,  720,  736,  753
	.word	 782,  795,  807,  812,  827,  847,  867,  879,  888,  894
	.word	 102,  113,  122,  139,  144,  151,  161,  178,  186,  197
	.word	1782, 2795, 3807, 3812, 4827, 5847, 6867, 7879, 7888, 1894
	.word	 206,  212,  222,  231,  246,  250,  254,  278,  288,  292
	.word	 332,  351,  376,  387,  390,  400,  411,  423,  432,  445
	.word	  10,   12,   14,   15,   16,   22,   25,   26,   28,   29
	.word	 400,  404,  406,  407,  424,  425,  426,  429,  448,  492
	.word	 457,  487,  499,  501,  523,  524,  525,  526,  575,  594
	.word	1912, 2925, 3927, 4932, 5447, 5957, 6967, 7979, 7988

hexAreas:
	.space	436

len:	.word	109

haMin:	.word	0
haEMid:	.word	0
haMax:	.word	0
haSum:	.word	0
haAve:	.word	0

LN_CNTR	= 7

# -----

hdr:	.ascii	"MIPS Assignment #1 \n"
	.ascii	"Program to calculate area of each hexagon in a series "
	.ascii	"of hexagons. \n"
	.ascii	"Also finds min, est mid, max, sum, and average for the "
	.asciiz	"hexagon areas. \n\n"

new_ln:	.asciiz	"\n"
blnks:	.asciiz	"  "

a1_st:	.asciiz	"\nHexagon min = "
a2_st:	.asciiz	"\nHexagon emid = "
a3_st:	.asciiz	"\nHexagon max = "
a4_st:	.asciiz	"\nHexagon sum = "
a5_st:	.asciiz	"\nHexagon ave = "


###########################################################
#  text/code segment

.text
.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# --------------------------------------------------
#	YOUR CODE GOES HERE
# la - load address
# l(datatype) - load (datatype value) (lw)
# li- load immediate
# unsigned values
# arithmitic- addu, mul, divu

# load array addresses
la $t0, sideLens		 
la $t1, apothemLens
la $t2, hexAreas

li $t3, 0	# index
lw $s0, len

# hexArea= 6 * (sideL * apotL)/2) 
hexArea:
	mul $t4, $t3, 4		# memory
	addu $t5, $t0, $t4	# address of current side	
	addu $t6, $t1, $t4	# address of current apoth
	lw $t5, ($t5)
	lw $t6, ($t6)
	mul $t7, $t5, $t6
	divu $t7, $t7, 2
	mul $t7, $t7, 6

	addu $t8, $t2, $t4	# address of current area
	sw $t7, ($t8)

	addu $t3, $t3, 1

	bne $t3, $s0, hexArea

# la $t2, hexAreas
li $t3, 0	# index
sum:
	mul $t4, $t3, 4		# memory
	addu $t8, $t2, $t4	# address of current area
	lw $t7, ($t8)
	addu $t9, $t9, $t7 # sum

	addu $t3, $t3, 1

	bne $t3, $s0, sum

sw $t9, haSum
divu $t9, $t9, $s0
sw $t9, haAve
			
# min, max, mid 
# la $t2, hexAreas

li $t3, 0		# index
lw $t6, ($t2)	# min value
min:
	mul $t4, $t3, 4		# memory
	addu $t8, $t2, $t4	# address of current area
	lw $t7, ($t8)
	bltu $t6, $t7, next
	move $t6, $t7
next:
	addu $t3, $t3, 1
	bne $t3, $s0, min
	sw $t6, haMin

# (first + last + mid) / 3

la $t8, hexAreas
lw $t4, ($t8)

lw $t2, len
sub $t2, $t2, 1
mul $t2, $t2, 4
addu $t8, $t8, $t2
lw $t8, ($t8)
sw $t8, haMax
addu $t4, $t4, $t8

la $t8, hexAreas
lw $t2, len
divu $t3, $t2,2
mul $t3, $t3, 4
addu $t8, $t8, $t3
lw $t8, ($t8)
addu $t4, $t4, $t8
divu $t4, $t4, 3

sw $t4, haEMid


# print 
la $t2, hexAreas
li $t3, 0 			# index 

newLine:
	li $t7, 7
	la	$a0, new_ln		# new line
	li	$v0, 4
	syscall

printLoop:
	la $a0, blnks
	li $v0, 4
	syscall

	mul $t4, $t3, 4		# memory
	addu $t8, $t2, $t4	# address of current area
	addu $t3, $t3, 1
	sub, $t7, $t7, 1
	lw $a0, ($t8)
	li $v0, 1
	syscall

	beqz $t7, newLine
	bne $s0, $t3, printLoop

#  Display results.

	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall
	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, haMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "emid = "

	lw	$a0, haEMid
	li	$v0, 1
	syscall				# print emid

# -----
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, haMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, haSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, haAve
	li	$v0, 1
	syscall				# print average

# -----
#  Done, terminate program.

endit:
	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main

