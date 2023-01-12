###########################################################################
#  Name: Marlon Alejandro
#  NSHE ID: 5002573038 
#  Section: 1003 
#  Assignment: MIPS #2
#  Description: Volume of hexagonal prism w/ Mips


###########################################################
#  data segment

.data

apothems:	.word	  110,   114,   113,   137,   154
		.word	  131,   113,   120,   161,   136
		.word	  114,   153,   144,   119,   142
		.word	  127,   141,   153,   162,   110
		.word	  119,   128,   114,   110,   115
		.word	  115,   111,   122,   133,   170
		.word	  115,   123,   115,   163,   126
		.word	  124,   133,   110,   161,   115
		.word	  114,   134,   113,   171,   181
		.word	  138,   173,   129,   117,   193
		.word	  125,   124,   113,   117,   123
		.word	  134,   134,   156,   164,   142
		.word	  206,   212,   112,   131,   246
		.word	  150,   154,   178,   188,   192
		.word	  182,   195,   117,   112,   127
		.word	  117,   167,   179,   188,   194
		.word	  134,   152,   174,   186,   197
		.word	  104,   116,   112,   136,   153
		.word	  132,   151,   136,   187,   190
		.word	  120,   111,   123,   132,   145

bases:		.word	  233,   214,   273,   231,   215
		.word	  264,   273,   274,   223,   256
		.word	  157,   187,   199,   111,   123
		.word	  124,   125,   126,   175,   194
		.word	  149,   126,   162,   131,   127
		.word	  177,   199,   197,   175,   114
		.word	  244,   252,   231,   242,   256
		.word	  164,   141,   142,   173,   166
		.word	  104,   146,   123,   156,   163
		.word	  121,   118,   177,   143,   178
		.word	  112,   111,   110,   135,   110
		.word	  127,   144,   210,   172,   124
		.word	  125,   116,   162,   128,   192
		.word	  215,   224,   236,   275,   246
		.word	  213,   223,   253,   267,   235
		.word	  204,   229,   264,   267,   234
		.word	  216,   213,   264,   253,   265
		.word	  226,   212,   257,   267,   234
		.word	  217,   214,   217,   225,   253
		.word	  223,   273,   215,   206,   213

heights:	.word	  117,   114,   115,   172,   124
		.word	  125,   116,   162,   138,   192
		.word	  111,   183,   133,   130,   127
		.word	  111,   115,   158,   113,   115
		.word	  117,   126,   116,   117,   227
		.word	  177,   199,   177,   175,   114
		.word	  194,   124,   112,   143,   176
		.word	  134,   126,   132,   156,   163
		.word	  124,   119,   122,   183,   110
		.word	  191,   192,   129,   129,   122
		.word	  135,   226,   162,   137,   127
		.word	  127,   159,   177,   175,   144
		.word	  179,   153,   136,   140,   235
		.word	  112,   154,   128,   113,   132
		.word	  161,   192,   151,   213,   126
		.word	  169,   114,   122,   115,   131
		.word	  194,   124,   114,   143,   176
		.word	  134,   126,   122,   156,   163
		.word	  149,   144,   114,   134,   167
		.word	  143,   129,   161,   165,   136

hexVolumes:	.space	400

len:		.word	100

volMin:		.word	0
volEMid:	.word	0
volMax:		.word	0
volSum:		.word	0
volAve:		.word	0

LN_CNTR	= 4


# -----

hdr:	.ascii	"MIPS Assignment #2 \n"
	.ascii	"  Hexagonal Volumes Program:\n"
	.ascii	"  Also finds minimum, middle value, maximum, \n"
	.asciiz	"  sum, and average for the volumes.\n\n"

a1_st:	.asciiz	"\nHexagon Volumes Minimum = "
a2_st:	.asciiz	"\nHexagon Volumes Est Med  = "
a3_st:	.asciiz	"\nHexagon Volumes Maximum = "
a4_st:	.asciiz	"\nHexagon Volumes Sum     = "
a5_st:	.asciiz	"\nHexagon Volumes Average = "

newLn:	.asciiz	"\n"
blnks:	.asciiz	"  "

###########################################################
#  text/code segment

# --------------------
#  Compute volumes:
#  Then find middle, max, sum, and average for volumes.

.text
.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# -------------------------------------------------------


#	YOUR CODE GOES HERE
# la - load address
# l(datatype) - load (datatype value) (lw)
# li- load immediate
# unsigned values
# arithmitic- addu, mul, divu

# load array addresses
la $t0, hexVolumes
la $t1, apothems		 
la $t2, bases
la $t3, heights
li $s1, 0		# index
lw $s0, len

# hexVolume [i] = ( 3 ∗ apothems[ i] ∗ bases [i] ∗ heights [i] )) 
Volume:
	mul $t4, $s1, 4		# memory
	addu $t5, $t0, $t4	# address of current Volume	
	addu $t6, $t1, $t4	# address of current apoth
	addu $t7, $t2, $t4	# address of current base
	addu $t8, $t3, $t4	# address of current height

	lw $t6, ($t6)
	lw $t7, ($t7)
	lw $t8, ($t8)

	mul $s2, $t6, $t7	# volume results
	mul $s2, $s2, $t8
	mul $s2, $s2, 3

	sw  $s2, ($t5)		# stores volume

	addu $s1, $s1, 1

	bne $s1, $s0, Volume

# la $t2, hexAreas
li $t3, 0	# index
li $t9, 0	# sum
sum:
	mul $t4, $t3, 4		# memory
	addu $t8, $t0, $t4	# address of current Volume
	lw $t7, ($t8)
	addu $t9, $t9, $t7 # sum

	addu $t3, $t3, 1

	bne $t3, $s0, sum

sw $t9, volSum
divu $t9, $t9, $s0
sw $t9, volAve
			
# min, max, mid 
la $t2, hexVolumes

li $t3, 0		# index
lw $t6, ($t0)	# min value
lw $t9, ($t0)	# max
lw $s0, len

min:
	mul $t4, $t3, 4		# memory
	addu $t8, $t2, $t4	# address of current area
	lw $t7, ($t8)
	bltu $t6, $t7, max	# if current min is less than our current index
	move $t6, $t7
max:
	bgtu $t9, $t7, next	# if current max is greater than our current index
	move $t9, $t7
next:
	addu $t3, $t3, 1
	bne $t3, $s0, min

	sw $t6, volMin
	sw $t9, volMax

# (first + last + mid) / 3

la $t8, hexVolumes
lw $t4, ($t8)		# 1st element

lw $t2, len
sub $t2, $t2, 1
mul $t2, $t2, 4
addu $t8, $t8, $t2
lw $t8, ($t8)
addu $t4, $t4, $t8	# last element

la $t8, hexVolumes
lw $t2, len
divu $t3, $t2,2
mul $t3, $t3, 4
addu $t8, $t8, $t3
lw $t7, ($t8)
addu $t4, $t4, $t7
subu $t8, $t8, 4
lw $t7, ($t8)
addu $t4, $t4, $t7
divu $t4, $t4, 4

sw $t4, volEMid


# print 
la $t2, hexVolumes
li $t3, 0 			# index 
li $t7, 4
j printLoop

newLine:
	beq $t3, $s0, finish
	li $t7, 4
	la	$a0, newLn		# new line
	li	$v0, 4
	syscall

printLoop:
	la $a0, blnks
	li $v0, 4
	syscall

	mul $t4, $t3, 4		# memory
	addu $t8, $t2, $t4	# address of current volume
	addu $t3, $t3, 1
	sub, $t7, $t7, 1
	lw $a0, ($t8)
	li $v0, 1
	syscall
	remu $t7, $t3, 4
	beq $t7, 0, newLine
	bltu $t3, $s0 printLoop

finish:







##########################################################
#  Display results.

	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, volMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "med = "

	lw	$a0, volEMid
	li	$v0, 1
	syscall				# print mid

# -----
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, volMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, volSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, volAve
	li	$v0, 1
	syscall				# print average

# -----
#  Done, terminate program.

endit:
	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main
