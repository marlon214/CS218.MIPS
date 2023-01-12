###########################################################################
#  Name: Marlon Alejandro
#  NSHE ID: 5002573038 
#  Section: 1003 
#  Assignment: MIPS #3
#  Description: Hexagonal Prisms calculations w/ MIPS Stack based Args

#  MIPS assembly language main program and functions:

#  * MIPS assembly language function, prtHeaders() to 
#    display some headers as per assignment format example.

#  * MIPS assembly language function, surfaceAreas(), 
#    to calculate the surface area for each hexagonal prism
#    in a series of hexagonal prisms
#    NOTE: this function must call the shellSort() function.

#  * MIPS assembly language function, shellSort(), to sort
#    the surface areas array (small to large).

#  * MIPS assembly language function, surfaceAreasStats(),
#    that will find the minimum, maximum, median, and
#    average (float) of the diagonals array.

#  * MIPS assembly language function, displayStats(), to
#    display the areas[] array statistical information:
#    minimum, maximum, median, and average (float)
#    in the format shown in the example.  The numbers should
#    be printed six (6) per line (see example).

#####################################################################
#  data segment

.data

# -----
#  Data declarations for main.

bases1:		.word	129, 127, 125, 123, 121, 129, 127, 125, 123, 121
		.word	122, 124, 126, 128, 120
apothems1:	.word	 44,  42,  41,  45,  44,  43,  42,  47,  48,  49
		.word	 42,  40,  46,  48,  40
heights1:	.word	119, 117, 115, 113, 111, 119, 117, 115, 113, 111
		.word	112, 114, 116, 118, 110
areas1:		.space	60
len1:		.word	15
min1:		.word	0
med1:		.word	0
max1:		.word	0
fAve1:		.double	0.0

bases2:		.word	155, 165, 153, 164, 178, 169, 152, 166, 159, 151
		.word	157, 151, 167, 151, 167, 157, 157, 161, 161, 159
		.word	152, 159, 155, 159, 153, 155, 151, 152, 154, 159
		.word	156, 152, 152, 151, 156, 160, 164, 158, 168, 162
		.word	167, 157, 169, 154, 153, 154, 155, 156, 155, 154
		.word	161, 163, 156, 169, 161, 152, 160, 168, 151, 159
		.word	169, 164, 167, 169, 162, 164, 156, 168, 162, 163
		.word	152, 161, 166, 167, 156
apothems2:	.word	 52,  81,  86,  67,  55,  60,  51,  63,  52,  55
		.word	 54,  62,  54,  86,  67,  54,  56,  50,  56,  63
		.word	 62,  63,  52,  79,  54,  61,  71,  88,  56,  57
		.word	 63,  55,  61,  79,  58,  69,  72,  84,  60,  61
		.word	 50,  54,  56,  67,  64,  65,  56,  59,  58,  62
		.word	 51,  53,  54,  66,  60,  66,  85,  67,  60,  66
		.word	 52,  75,  77,  62,  57,  57,  77,  89,  58,  54
		.word	 60,  51,  53,  52,  55
heights2:	.word	145, 155, 143, 154, 168, 159, 142, 156, 149, 141
		.word	147, 141, 157, 141, 157, 147, 147, 151, 151, 149
		.word	142, 149, 145, 149, 143, 145, 141, 142, 144, 149
		.word	146, 142, 142, 141, 146, 150, 154, 148, 158, 152
		.word	157, 147, 159, 144, 143, 144, 145, 146, 145, 144
		.word	151, 153, 146, 159, 151, 142, 150, 158, 141, 149
		.word	159, 144, 147, 149, 152, 154, 146, 148, 152, 153
		.word	142, 151, 156, 157, 146
areas2:		.space	300
len2:		.word	75
min2:		.word	0
med2:		.word	0
max2:		.word	0
fAve2:		.double	0.0

apothems3:	.word	153, 152, 151, 151, 151, 154, 152, 156, 168, 153
		.word	152, 159, 155, 159, 151, 165, 159, 152, 154, 159
		.word	150, 154, 156, 167, 154, 145, 156, 139, 158, 152
		.word	151, 153, 156, 159, 161, 162, 164, 168, 171, 175
		.word	179, 184, 137, 189, 162, 151, 154, 166, 152, 143
		.word	151, 163, 164, 156, 150, 166, 185, 177, 160, 156
		.word	164, 165, 155, 172, 162, 161, 163, 166, 166, 153
		.word	178, 169, 161, 152, 163, 163, 196, 161, 159, 166
		.word	156, 189, 159, 147, 176, 164, 164, 166, 174, 152
bases3:		.word	 81,  58,  65,  53,  62,  50,  68,  81,  64,  62
		.word	 45,  72,  86,  62,  63,  69,  66,  52,  68,  51
		.word	 82,  55,  56,  57,  55,  44,  56,  40,  66,  63
		.word	 63,  52,  41,  41,  61,  44,  52,  56,  68,  63
		.word	 62,  69,  55,  49,  64,  55,  49,  52,  54,  59
		.word	 60,  54,  56,  87,  64,  35,  36,  39,  58,  72
		.word	 51,  53,  56,  59,  61,  72,  74,  68,  51,  75
		.word	 79,  84,  49,  62,  87,  74,  66,  61,  62,  63
		.word	 51,  63,  44,  46,  61,  66, 105,  57,  50,  56
heights3:	.word	143, 142, 141, 141, 141, 144, 142, 146, 158, 143
		.word	142, 149, 145, 149, 141, 155, 149, 142, 144, 149
		.word	140, 144, 146, 157, 144, 135, 146, 129, 148, 142
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	169, 174, 127, 179, 152, 141, 144, 156, 142, 133
		.word	141, 153, 154, 146, 140, 156, 175, 167, 150, 146
		.word	154, 155, 145, 162, 152, 141, 142, 156, 156, 143
		.word	168, 159, 151, 142, 153, 141, 176, 151, 149, 156
		.word	146, 179, 149, 137, 146, 154, 154, 156, 164, 142

areas3:		.space	360
len3:		.word	90
min3:		.word	0
med3:		.word	0
max3:		.word	0
fAve3:		.double	0.0

apothems4:	.word	155, 154, 153, 167, 163, 164, 164, 166, 174, 152
		.word	176, 162, 162, 161, 156, 160, 164, 188, 188, 202
		.word	192, 205, 167, 162, 167, 157, 177, 189, 198, 204
		.word	164, 162, 184, 196, 207, 164, 166, 160, 166, 163
		.word	162, 161, 166, 197, 204, 160, 161, 163, 162, 155
		.word	167, 197, 209, 161, 163, 164, 165, 166, 185, 204
		.word	159, 166, 172, 161, 167, 187, 207, 203, 185, 164
		.word	174, 151, 152, 163, 176, 164, 156, 163, 166, 173
		.word	161, 168, 187, 153, 188, 162, 161, 160, 165, 160
		.word	167, 154, 160, 182, 164, 165, 166, 172, 168, 202
		.word	163, 162, 156, 186, 161, 166, 174, 175, 205, 166
		.word	167, 163, 163, 150, 165, 161, 164, 168, 163, 162
		.word	179, 166, 172, 137, 167, 167, 169, 187, 185, 164
		.word	191, 165, 165, 162, 167, 165, 160, 169, 162, 164
		.word	171, 162, 161, 162, 181, 169, 164, 162, 165, 161
bases4:		.word	 63,  62,  56,  86,  60,  66,  74,  75,  65,  66
		.word	 81,  57,  60,  37,  84,  75,  61,  77,  71,  69
		.word	 63,  62,  56,  66,  60,  66,  74,  66,  65,  62
		.word	 61,  73,  63,  60,  65,  69,  65,  68,  63,  65
		.word	 74,  51,  52,  63,  76,  64,  56,  63,  66,  73
		.word	 37,  74,  60,  82,  64,  65,  66,  72,  68,  72
		.word	 61,  63,  63,  60,  67,  61,  65,  68,  63,  65
		.word	 67,  36,  72,  67,  67,  77,  79,  87,  85,  64
		.word	 63,  64,  62,  53,  86,  64,  66,  62,  66,  73
		.word	 64,  69,  62,  63,  60,  71,  62,  69,  69,  62
		.word	 65,  66,  72,  67,  67,  67,  69,  87,  85,  54
		.word	 89,  63,  66,  50,  65,  62,  64,  68,  63,  62
		.word	 71,  82,  61,  63,  66,  79,  64,  62,  65,  61
		.word	 74,  64,  64,  53,  86,  64,  66,  62,  66,  73
		.word	 59,  54,  64,  64,  77,  53,  69,  71,  75,  66
heights4:	.word	145, 144, 143, 157, 153, 154, 154, 156, 164, 142
		.word	166, 152, 152, 151, 146, 150, 154, 178, 178, 192
		.word	182, 195, 157, 152, 157, 147, 167, 179, 188, 194
		.word	154, 152, 174, 186, 197, 154, 156, 150, 156, 153
		.word	152, 151, 156, 187, 190, 150, 151, 153, 152, 145
		.word	157, 187, 199, 151, 153, 154, 155, 156, 175, 194
		.word	149, 156, 162, 151, 157, 177, 199, 197, 175, 154
		.word	164, 141, 142, 153, 166, 154, 146, 153, 156, 163
		.word	151, 158, 177, 143, 178, 152, 151, 150, 155, 150
		.word	157, 144, 150, 172, 154, 155, 156, 162, 158, 192
		.word	153, 152, 146, 176, 151, 156, 164, 165, 195, 156
		.word	157, 153, 153, 140, 155, 151, 154, 158, 153, 152
		.word	169, 156, 162, 127, 157, 157, 159, 177, 175, 154
		.word	181, 155, 155, 152, 157, 155, 150, 159, 152, 154
		.word	161, 152, 151, 152, 171, 159, 154, 152, 155, 151
len4:		.word	150
areas4:		.space	600
min4:		.word	0
med4:		.word	0
max4:		.word	0
fAve4:		.double	0.0

apothems5:	.word	862, 169, 165, 169, 171, 165, 189, 172, 154, 159
		.word	172, 175, 167, 162, 177, 157, 187, 179, 178, 184
		.word	169, 164, 166, 167, 174, 165, 186, 179, 158, 192
		.word	151, 153, 156, 169, 161, 162, 184, 178, 171, 185
		.word	169, 163, 164, 166, 160, 166, 185, 197, 175, 196
		.word	162, 161, 186, 197, 190, 160, 181, 193, 172, 185
		.word	157, 163, 163, 160, 175, 161, 184, 198, 173, 182
		.word	161, 163, 164, 166, 170, 166, 185, 197, 180, 206
		.word	144, 162, 184, 196, 187, 164, 186, 160, 186, 173
		.word	192, 175, 167, 162, 167, 167, 187, 199, 188, 204
		.word	169, 161, 169, 161, 169, 161, 189, 191, 189, 201
		.word	163, 163, 163, 160, 165, 169, 183, 198, 183, 175
		.word	161, 165, 167, 173, 176, 178, 181, 197, 194, 176
		.word	162, 169, 165, 179, 161, 175, 189, 192, 194, 179
		.word	451, 453, 466, 459, 461, 472, 484, 478, 491, 485
		.word	362, 362, 362, 362, 362, 372, 382, 372, 392, 382
		.word	362, 362, 362, 362, 372, 372, 382, 372, 362, 382
		.word	272, 275, 267, 262, 277, 277, 287, 279, 288, 284
		.word	162, 169, 165, 169, 171, 175, 189, 172, 174, 199
		.word	162, 164, 168, 171, 175, 171, 282, 577, 271, 191
		.word	151, 153, 166, 159, 181, 172, 184, 178, 171, 275
bases5:		.word	103,  84,  87,  89,  82,  74,  76,  78,  72,  83
		.word	 60,  64,  66,  67,  64,  65,  66,  69,  58,  82
		.word	 55,  85,  65,  62,  67,  65,  60,  69,  62,  64
		.word	 60,  61,  69,  69,  50,  65,  71,  74,  68,  83
		.word	 61,  63,  63,  66,  55,  66,  75,  77,  81,  86
		.word	 54,  64,  64,  53,  86,  64,  66,  62,  66,  73
		.word	 64,  62,  67,  76,  87,  64,  66,  60,  46,  63
		.word	 79,  84,  87,  89,  92,  74,  76,  78,  82,  83
		.word	 65,  62,  66,  65,  50,  67,  73,  89,  62,  84
		.word	 66,  62,  62,  61,  56,  60,  64,  88,  68,  82
		.word	 67,  67,  67,  67,  57,  67,  77,  87,  67,  87
		.word	 67,  77,  69,  61,  63,  64,  65,  66,  85,  84
		.word	 64,  62,  84   76,  77,  64,  66,  60,  46,  63
		.word	 72,  75,  67,  62,  67,  57,  77,  69,  68,  83
		.word	 95,  92, 106, 105,  70,  97,  33,  79,  52,  94
		.word	 99, 100, 101, 102,  99, 101, 110, 104, 102, 100
		.word	 93, 102, 102, 109, 100, 107, 111, 105, 108, 101
		.word	 92,  74,  75,  77,  61,  78,  83,  86,  96, 103
		.word	 91,  73,  84, 106, 110,  36, 105, 107, 109, 106
		.word	 69,  61,  69,  41,  59,  61,  79,  81,  89,  81
		.word	 51,  53,  56,  59,  61,  33,  88,  92,  31,  97
heights5:	.word	852, 159, 155, 159, 151, 155, 159, 152, 144, 149
		.word	162, 165, 157, 152, 157, 147, 167, 159, 168, 174
		.word	159, 154, 156, 157, 154, 155, 156, 159, 148, 172
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	159, 153, 154, 156, 140, 156, 175, 187, 155, 156
		.word	152, 151, 176, 187, 170, 150, 151, 153, 152, 145
		.word	147, 153, 153, 140, 165, 151, 154, 158, 153, 152
		.word	151, 153, 154, 156, 140, 156, 175, 187, 160, 196
		.word	134, 152, 174, 186, 167, 154, 156, 150, 156, 153
		.word	182, 165, 157, 152, 157, 147, 167, 179, 168, 194
		.word	159, 151, 159, 151, 149, 151, 169, 171, 169, 191
		.word	153, 153, 153, 150, 155, 159, 143, 148, 153, 155
		.word	151, 155, 157, 163, 166, 168, 171, 177, 164, 176
		.word	152, 159, 155, 159, 151, 155, 159, 142, 144, 149
		.word	441, 443, 446, 449, 451, 452, 454, 458, 461, 465
		.word	352, 352, 352, 352, 352, 352, 352, 352, 352, 352
		.word	352, 352, 352, 352, 352, 352, 352, 352, 352, 352
		.word	262, 265, 257, 252, 257, 247, 267, 259, 268, 274
		.word	152, 159, 155, 159, 151, 155, 159, 152, 154, 159
		.word	152, 154, 158, 161, 165, 121, 232, 567, 211, 121
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 265
areas5:		.space	840
len5:		.word	210
min5:		.word	0
med5:		.word	0
max5:		.word	0
fAve5:		.double	0.0

# -----
#  Variables for main.

asstHeader:	.ascii	"\nMIPS Assignment #3\n"
		.asciiz	"Hexagonal Prism Surface Areas Program\n\n"

# -----
#  Variables/constants for prtHeaders() procedure.

hdrTitle:	.ascii	"\n*******************************************************************"
		.asciiz	"\nHexagonal Prisms "
hdrLength:	.asciiz	"\nLength: "

hdrStats:	.asciiz	"\nSurface Areas - Stats: \n"
hdrVolumes:	.asciiz	"\n\nSurface Areas - Values: \n"

# -----
#  Variables/constants for surfaceAreas() function (if any).


# -----
#  Variables/constants for shellSort() function (if any).


# -----
#  Variables/constants for areasStats() function.


# -----
#  Variables/constants for displayStats() function.

NUMS_PER_ROW = 6

spc:		.asciiz	"     "
newLine:	.asciiz	"\n"

str1:		.asciiz	"   min  = "
str2:		.asciiz	"\n   max  = "
str3:		.asciiz	"\n   med  = "
str4:		.asciiz	"\n   ave = "

#####################################################################
#  text/code segment

# -----
#  Basic flow:
#	for each data set:
#	  * display headers
#	  * calculate surface areas, including sort
#	  * calculate surface areas stats (min, max, med, sum, and fAve)
#	  * display surface areas and surface areas stats

.text
.globl	main
main:

# --------------------------------------------------------
#  Display Program Header.

	la	$a0, asstHeader
	li	$v0, 4
	syscall					# print header
	li	$s0, 1				# counter, data set number

# --------------------------------------------------------
#  Data Set #1

	move	$a0, $s0
	lw	$a1, len1
	jal	prtHeaders
	add	$s0, $s0, 1

#  Hexagonal Prisms surface areas calculation function
#  Note, function also calls the shellSort() function to
#  sort the surface araes array.
#	surfaceAreas(apothems, bases, heights, len, diags)

	la	$a0, apothems1
	la	$a1, bases1
	la	$a2, heights1
	lw	$a3, len1
	subu	$sp, $sp, 4
	la	$t0, areas1
	sw	$t0, ($sp)			# arg 5, on stack
	jal	surfaceAreas
	addu	$sp, $sp, 4			# clear stack

#  Generate surface areas stats.
#  Note, function also calls the findSum() and findAverage() functions.
#	diagonalsStats(diags, len, min, max, med, fAve)

	la	$a0, areas1			# arg 1
	lw	$a1, len1			# arg 2
	la	$a2, min1			# arg 3
	la	$a3, max1			# arg 4
	subu	$sp, $sp, 8
	la	$t0, med1
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t6, fAve1
	sw	$t6, 4($sp)			# arg 6, on stack
	jal	surfaceAreasStats
	addu	$sp, $sp, 8			# clear stack

#  Display final surface areas array stats.
#	displayStats(diags, len, min, max, med, fAve)

	la	$a0, areas1			# arg 1
	lw	$a1, len1			# arg 2
	lw	$a2, min1			# arg 3
	lw	$a3, max1			# arg 4
	subu	$sp, $sp, 8
	lw	$t0, med1
	sw	$t0, ($sp)			# arg 5, on stack
	l.d	$f6, fAve1
	s.d	$f6, 4($sp)			# arg 6, on stack
	jal	showAreasStats
	addu	$sp, $sp, 8			# clear stack

# --------------------------------------------------------
#  Data Set #2

	move	$a0, $s0
	lw	$a1, len2
	jal	prtHeaders
	add	$s0, $s0, 1

#  Hexagonal Prisms surface areas calculation function
#  Note, function also calls the shellSort() function to
#  sort the surface araes array.
#	surfaceAreas(apothems, bases, heights, len, diags)

	la	$a0, apothems2
	la	$a1, bases2
	la	$a2, heights2
	lw	$a3, len2
	subu	$sp, $sp, 4
	la	$t0, areas2
	sw	$t0, ($sp)			# arg 5, on stack
	jal	surfaceAreas
	addu	$sp, $sp, 4			# clear stack

#  Generate surface areas stats.
#  Note, function also calls the findSum() and findAverage() functions.
#	diagonalsStats(diags, len, min, max, med, fAve)

	la	$a0, areas2			# arg 1
	lw	$a1, len2			# arg 2
	la	$a2, min2			# arg 3
	la	$a3, max2			# arg 4
	subu	$sp, $sp, 8
	la	$t0, med2
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t6, fAve2
	sw	$t6, 4($sp)			# arg 6, on stack
	jal	surfaceAreasStats
	addu	$sp, $sp, 8			# clear stack

#  Display final surface areas array stats.
#	displayStats(diags, len, min, max, med, fAve)

	la	$a0, areas2			# arg 1
	lw	$a1, len2			# arg 2
	lw	$a2, min2			# arg 3
	lw	$a3, max2			# arg 4
	subu	$sp, $sp, 8
	lw	$t0, med2
	sw	$t0, ($sp)			# arg 5, on stack
	l.d	$f6, fAve2
	s.d	$f6, 4($sp)			# arg 6, on stack
	jal	showAreasStats
	addu	$sp, $sp, 8			# clear stack

# --------------------------------------------------------
#  Data Set #3

	move	$a0, $s0
	lw	$a1, len3
	jal	prtHeaders
	add	$s0, $s0, 1

# #  Hexagonal Prisms surface areas calculation function
# #  Note, function also calls the shellSort() function to
# #  sort the surface araes array.
# #	surfaceAreas(apothems, bases, heights, len, diags)

	la	$a0, apothems3
	la	$a1, bases3
	la	$a2, heights3
	lw	$a3, len3
	subu	$sp, $sp, 4
	la	$t0, areas3
	sw	$t0, ($sp)			# arg 5, on stack
	jal	surfaceAreas
	addu	$sp, $sp, 4			# clear stack

#  Generate surface areas stats.
#  Note, function also calls the findSum() and findAverage() functions.
#	diagonalsStats(diags, len, min, max, med, fAve)

	la	$a0, areas3			# arg 1
	lw	$a1, len3			# arg 2
	la	$a2, min3			# arg 3
	la	$a3, max3			# arg 4
	subu	$sp, $sp, 8
	la	$t0, med3
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t6, fAve3
	sw	$t6, 4($sp)			# arg 6, on stack
	jal	surfaceAreasStats
	addu	$sp, $sp, 8			# clear stack

# #  Display final surface areas array stats.
# #	displayStats(diags, len, min, max, med, fAve)

	la	$a0, areas3			# arg 1
	lw	$a1, len3			# arg 2
	lw	$a2, min3			# arg 3
	lw	$a3, max3			# arg 4
	subu	$sp, $sp, 8
	lw	$t0, med3
	sw	$t0, ($sp)			# arg 5, on stack
	l.d	$f6, fAve3
	s.d	$f6, 4($sp)			# arg 6, on stack
	jal	showAreasStats
	addu	$sp, $sp, 8			# clear stack

# --------------------------------------------------------
#  Data Set #4

	move	$a0, $s0
	lw	$a1, len4
	jal	prtHeaders
	add	$s0, $s0, 1

# #  Hexagonal Prisms surface areas calculation function
# #  Note, function also calls the shellSort() function to
# #  sort the surface araes array.
# #	surfaceAreas(apothems, bases, heights, len, diags)

	la	$a0, apothems4
	la	$a1, bases4
	la	$a2, heights4
	lw	$a3, len4
	subu	$sp, $sp, 4
	la	$t0, areas4
	sw	$t0, ($sp)			# arg 5, on stack
	jal	surfaceAreas
	addu	$sp, $sp, 4			# clear stack

#  Generate surface areas stats.
#  Note, function also calls the findSum() and findAverage() functions.
#	diagonalsStats(diags, len, min, max, med, fAve)

	la	$a0, areas4			# arg 1
	lw	$a1, len4			# arg 2
	la	$a2, min4			# arg 3
	la	$a3, max4			# arg 4
	subu	$sp, $sp, 8
	la	$t0, med4
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t6, fAve4
	sw	$t6, 4($sp)			# arg 6, on stack
	jal	surfaceAreasStats
	addu	$sp, $sp, 8			# clear stack

# #  Display final surface areas array stats.
# #	displayStats(diags, len, min, max, med, fAve)

	la	$a0, areas4			# arg 1
	lw	$a1, len4			# arg 2
	lw	$a2, min4			# arg 3
	lw	$a3, max4			# arg 4
	subu	$sp, $sp, 8
	lw	$t0, med4
	sw	$t0, ($sp)			# arg 5, on stack
	l.d	$f6, fAve4
	s.d	$f6, 4($sp)			# arg 6, on stack
	jal	showAreasStats
	addu	$sp, $sp, 8			# clear stack

# --------------------------------------------------------
#  Data Set #5

	move	$a0, $s0
	lw	$a1, len5
	jal	prtHeaders
	add	$s0, $s0, 1

#  Hexagonal Prisms surface areas calculation function
#  Note, function also calls the shellSort() function to
#  sort the surface araes array.
#	surfaceAreas(apothems, bases, heights, len, diags)

	la	$a0, apothems5
	la	$a1, bases5
	la	$a2, heights5
	lw	$a3, len5
	subu	$sp, $sp, 4
	la	$t0, areas5
	sw	$t0, ($sp)			# arg 5, on stack
	jal	surfaceAreas
	addu	$sp, $sp, 4			# clear stack

#  Generate surface areas stats.
#  Note, function also calls the findSum() and findAverage() functions.
#	diagonalsStats(diags, len, min, max, med, fAve)

	la	$a0, areas5			# arg 1
	lw	$a1, len5			# arg 2
	la	$a2, min5			# arg 3
	la	$a3, max5			# arg 4
	subu	$sp, $sp, 8
	la	$t0, med5
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t6, fAve5
	sw	$t6, 4($sp)			# arg 6, on stack
	jal	surfaceAreasStats
	addu	$sp, $sp, 8			# clear stack

# #  Display final surface areas array stats.
# #	displayStats(diags, len, min, max, med, fAve)

	la	$a0, areas5			# arg 1
	lw	$a1, len5			# arg 2
	lw	$a2, min5			# arg 3
	lw	$a3, max5			# arg 4
	subu	$sp, $sp, 8
	lw	$t0, med5
	sw	$t0, ($sp)			# arg 5, on stack
	l.d	$f6, fAve5
	s.d	$f6, 4($sp)			# arg 6, on stack
	jal	showAreasStats
	addu	$sp, $sp, 8			# clear stack

# --------------------------------------------------------
#  Done, terminate program.

	li	$v0, 10
	syscall					# au revoir...
.end

#####################################################################
#  Display headers.

.globl	prtHeaders
prtHeaders:
	sub	$sp, $sp, 8
	sw	$s0, ($sp)
	sw	$s1, 4($sp)

	move	$s0, $a0
	move	$s1, $a1

	la	$a0, hdrTitle
	li	$v0, 4
	syscall

	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, hdrLength
	li	$v0, 4
	syscall

	move	$a0, $s1
	li	$v0, 1
	syscall

	lw	$s0, ($sp)
	lw	$s1, 4($sp)
	add	$sp, $sp, 8

	jr	$ra
.end	prtHeaders

#####################################################################
#  MIPS assembly language function to calculate the
#  surface area for each hexagonal prism in a series of hexagonal prisms.

#  Note, this function also calls the shellSort() function
#        after the surface areas are calculated.

#    Arguments:
#	$a0	- starting address of the apothems array 1 
#	$a1	- starting address of the bases array	 2 
#	$a2	- starting address of the heights array	 3 
#	$a3	- length								 4 
#	($fp)	- starting address of the areas array 5 

#    Returns:
#	areas[] surface areas array via passed address

#	YOUR CODE GOES HERE
.globl surfaceAreas
.ent surfaceAreas
surfaceAreas:  
	subu $sp, $sp, 8 	
	sw $ra, ($sp) 		 
	addu $fp, $sp,	8 

	move $t9, $a0		#apothems 
	move $t8, $a1 		#heights 
	move $t7, $a2		#base
	lw $t5, ($fp) 		#areas
	li $t3, 0 			#index 

	#areas[i]=6×bases[i]×(apothems[i]+heights[i])

	area: 
		lw $t0, ($t9) 		
		lw $t1, ($t8) 		
		lw $t2, ($t7) 		
		addu $t0, $t0, $t2	
		mul $t0, $t0, $t1	
		mul $t0, $t0, 6 	
		sw $t0, ($t5) 		

		addu $t3, $t3, 1 

		addu $t9, $t9, 4 	 
		addu $t8, $t8, 4
		addu $t7, $t7, 4
		addu $t5, $t5, 4 	

		bne $t3, $a3, area

		#sort surfaceArea array
		lw $a0, ($fp) 		
		move $a1, $a3		
		jal shellSort 		 

	lw $ra, ($sp) 
	lw $fp, 4($sp)
	addu $sp, $sp, 8

	jr $ra 
.end surfaceAreas
#####################################################################
#  Sort a list of numbers using shell sort algorithm.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	sorted list (via reference)
.globl shellSort
.ent shellSort
shellSort:
	#	YOUR CODE GOES HERE   	
	li $t9, 0            	
	li $t8, 0        	 	
	li $t7, 0            	
	li $t6, 0 				
	li $t5, 0				
	li $t4, 0
	li $t1, 1		#h = 1 
	# while ( (h*3+1) < length )
	loop1: 
		#imul ebx        ; h = 1;
		mul $t1, $t1, 3 					
		#inc eax            ; while ((h*3+1)<length){
		addu $t1, $t1, 1 					
		#cmp eax, esi    ; h = 3 * h + 1;
		#jl loop1        ; }
		blt $t1, $a1, loop1			

	loop2: 				# while(h>0)
		move $t9, $t1 	# 
		#bne $t1, 0, loop2	

	#**********outsideLoop****************
			
	loop3:	#for(i=h-1; i<length; i++)
		#cmp r8d, esi                ;i<length
		#jge loop6
		bge $t9, $a1, loop6 
		#mov r10, r8                    ; set i as our index
		move $t8, $t9 						
		#mov r9d, dword[rdi+r10*4]     ;tmp = lst[i]
		mul $t8, $t8, 4 					
		addu $t8, $t8, $a0 					
		lw $t4, ($t8)	
		#mov r11d, r8d                ; j=i					 
		move $t5, $t9 	

	#******2ndOutsideLoopDone*************

	# for ( j=i; (j >= h) && (lst[j-h] > tmp); j = j-h)
	loop4: 
		#cmp r11d, eax               ;j>=h
		#jl loop5
		blt $t5, $t1, loop5	#(j >= h)
		#mov r10, r11
		move $t6, $t5 					
		#sub r10, rax                ; set index to j-h
		subu $t7, $t6, $t1 				#j - h for array 
		#cmp dword[rdi+r10*4], r9d   ;;lst[j-h] > tmp
		#jle loop5
		mul $t7, $t7, 4 				
		addu $t7, $t7, $a0 				
		lw 	$t8, ($t7) 					 
		ble $t8, $t4, loop5	
		
	#********3rdLoop****************

		#mov r12d, dword[rdi+r10*4]
		mul $t6, $t6, 4 				
		addu $t6, $t6, $a0 				
		lw 	$t0, ($t6) 					
		#mov dword[rdi+r11*4], r12d  ;;lst[j] = lst[j-h]
		sw 	$t8, ($t6) 					#save lst[j]
		sw 	$t0, ($t7) 					# lst[j]=lst[j-h] to t0 

	#********3rdLoop****************

		#sub r11d, eax               ;j = j-h
		sub $t5, $t5, $t1 			
		#jmp loop4
		j loop4

	#******2ndOutsideLoopDone*************
		
	loop5: 
		#mov r10, r11            ; set index to j
		move $t6, $t5 					
		#mov dword[rdi+r10*4], r9d ;a[j] =tmp
		mul $t6, $t6, 4 				
		addu $t6, $t6, $a0 				
		sw $t4, ($t6) 					
		#inc r8d                    ;i++
		add $t9, $t9, 1 
		#jmp loop3				
		j loop3

	#**********outsideLoop****************

	loop6:
		#cdq                
		#idiv ebx                ; h=h/3
		divu $t1, $t1, 3 
		#jmp loop2                ; loop if h>0
		#j loop2
		bnez $t1, loop2	
		
	jr $ra 
.end shellSort
#####################################################################
#  Find sum function.
#	Find sum of passed array.

#    Arguments:
#	$a0   - address
#	$a1   - len

#    Returns:
#	$f0   - float average
.globl findSum
.ent findSum
findSum: 
	#	YOUR CODE GOES HERE
		
	move $t0, $a0			 
	li	$t1, 0				#index 
	li	$t2, 0	 			#sum

	sum:
		lw	$t3, ($t0) 		
		addu $t2, $t2, $t3 	
		addu $t0, $t0, 4 
		addu $t1, $t1, 1 
		bne $t1, $a1, sum
		move $v0, $t2  		#return value

	jr $ra 
.end findSum
#####################################################################
#  Find floating point average function.
#  Includes performing the required type conversions.
#  Note, must call findSum() function.

#    Arguments:
#	$a0   - integer 
#	$a1   - len

#    Returns:
#	$v0   - sum
.globl findAverage 
.ent findAverage
findAverage: 

	#	YOUR CODE GOES HERE
	#parameters hold values needs for the sum function call
	subu $sp, $sp, 8 		#preserve the stack 
	sw $ra, ($sp) 		
	sw $fp, 4($sp) 
	addu $fp, $sp,	8 

	jal findSum				#call sum function
	
	mtc1.d $v0, $f2  		#convert sum to float 
	cvt.d.w $f2, $f2		#float to double  

	mtc1.d $a1, $f4 		# length to float
	cvt.d.w $f4, $f4		# float to double  
	
	div.d $f0, $f2, $f4		#sum/length=average 

	lw $ra, ($sp) 
	lw $fp, 4($sp)
	addu $sp, $sp, 8

	jr $ra 
.end findAverage
#####################################################################
#  MIPS assembly language procedure, surfaceAreasStats() to find the
#    sum, average, minimum, maximum, median, and floating point
#    average of list.
#  Note, must call the findAverage() function.

# -----
#  HLL Call:
#	surfaceAreasStats(areas, len, min, max, med, fAve)

# -----
#    Arguments:
#	$a0	- starting address of the diagonals array
#	$a1	- list length
#	$a2	- addr of min
#	$a3	- addr of max
#	($fp)	- addr of med
#	4($fp)	- addr of fAve

#    Returns (via reference):
#	min, max, med, fAve
.globl surfaceAreasStats
.ent surfaceAreasStats
surfaceAreasStats:
	#	YOUR CODE GOES HERE
	subu $sp, $sp, 12 
	sw $ra, ($sp) 		
	sw $fp, 4($sp)		#med
	sw $t8, 8($sp) 		#ave
	addu $fp, $sp, 12 

	#arguements  are already loaded for function call
	jal findAverage 
	mov.d $f12, $f0 	
	s.d $f12, 4($fp) 	

	#min/max
	lw $t4, ($a0)
	sw $t4, ($a2) 		#set min array[0]

	subu $t4, $a1, 1 
	mul $t4, $t4, 4
	addu $t4, $t4, $a0
	lw $t4, ($t4)
	sw $t4, ($a3) 		#set max array[length-1]


	#median
	lw $t0, ($fp) 		
	li $t1, 0
	move $t4, $a1
	rem $t4, $t4, 2 	#check even or odd
	beq $t4, 0, even	
	beq $t4, 1, odd 	

	even:				#average of middle values
		move $t5, $a0 
		move $t2, $a1 
		divu $t3, $t2, 2 
		subu $t3, $t3, 1 
		mul  $t3, $t3, 4 
		addu $t5, $t5, $t3 
		lw	 $t1, ($t5)

		move $t5, $a0 		
		move $t2, $a1 
		divu $t3, $t2, 2 
		mul  $t3, $t3, 4 
		addu $t5, $t5, $t3 
		lw 	 $t5, ($t5) 

		addu $t1, $t1, $t5	 
		divu $t1, $t1, 2 
		j done 

	odd: 				#middle value
		move $t5, $a0 		
		move $t2, $a1 
		divu $t3, $t2, 2 
		mul  $t3, $t3, 4 
		addu $t5, $t5, $t3 
		lw 	 $t1, ($t5) 

	done: 
		sw $t1, ($t0)	# store med

		lw $ra, ($sp) 		
		lw $fp, 4($sp)		#space for med 
		lw $t8, 8($sp) 		#space for ave  
		addu $sp, $sp, 12 

jr $ra 
.end surfaceAreasStats

#####################################################################
#  MIPS assembly language procedure, displayStats(), to display
#    the statistical information to console.

#  Note, due to the system calls, the saved registers must be used.
#	As such, push/pop saved registers altered.

# HLL Call
#	showAreasStats(diags, len, min, max, med, fAve)

# -----
#    Arguments:
#	$a0	- starting address of diags[]
#	$a1	- length
#	$a2	- min
#	$a3	- max
#	($fp)	- med
#	4($fp)	- fAve

#    Returns:
#	N/A
.globl showAreasStats
.ent showAreasStats
showAreasStats:
	#	YOUR CODE GOES HERE
	subu $sp, $sp, 20 
	sw $ra, ($sp) 		
	sw $fp, 4($sp)		#space for med 
	sw $s0, 8($sp) 		#space for ave 
	sw $s1, 12($sp) 
	sw $s2, 16($sp)   
	addu $fp, $sp, 20 

	move $s1, $a0 		#array address
	move $s2, $a1 		#len 
	li $s0, 0 			#index 

	#print header
	la $a0, hdrVolumes
	li $v0, 4
	syscall 
	li $s5, 6 
	j printLoop

	NewLine: 
		beq $s2, $s0, finish
		li $s5, 6 
		la $a0, newLine		#for space 
		li $v0, 4 
		syscall

	printLoop: 
		la $a0, spc
		li $v0, 4 
		syscall

		bge $s0, $s2, finish
		lw $s4, ($s1) 
		addu $s0, $s0, 1 
		addu $s1, $s1, 4 

		move $a0, $s4 
		li $v0, 1 
		syscall

		addu $s4, $s4, 1 
		subu $s5, $s5, 1 
		beqz $s5, NewLine
		bne $s2, $s0, printLoop

	finish: 

	# print a new line 
	la	$a0, newLine		
	li	$v0, 4
	syscall
	la	$a0, newLine		
	li	$v0, 4
	syscall


	#hdrStats string 
	la $a0, hdrStats
	li $v0, 4
	syscall 

	#min
	la	$a0, str1
	li	$v0, 4
	syscall				
	move $a0, $a2 
	li	$v0, 1
	syscall				

	#max 
	la	$a0, str2
	li	$v0, 4
	syscall				
	move $a0, $a3 
	li	$v0, 1
	syscall				

	#med 
	la	$a0, str3 
	li	$v0, 4
	syscall
	lw $a0, ($fp) 
	li	$v0, 1
	syscall			

	#ave
	la	$a0, str4
	li	$v0, 4
	syscall				
	li	$v0, 3
	syscall				

	#newline
	la	$a0, newLine		
	li	$v0, 4
	syscall
	syscall

	lw $ra, ($sp) 		
	lw $fp, 4($sp)		#space for med 
	lw $s0, 8($sp) 		#space for ave 
	lw $s1, 12($sp) 
	lw $s2, 16($sp)   
	addu $sp, $sp, 20 

	jr $ra 
.end showAreasStats
#####################################################################

