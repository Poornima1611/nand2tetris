// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// Psudo code
// n = RAM[0]
// RAM[2] = 0

// i = n
// while (i > 0) {
//	RAM[2] = RAM[2] + RAM[1]
//	i = i - 1
// }


@0
D = A
@product
M = D	// product = 0

@R0
D = M 	// load RAM[0]

@i
M = D	// i = RAM[0]


(LOOP)
@i
D = M
@OUTOFTHELOOP
D;JEQ			// if M is zero, goto OUTOFTHELOOP

@R1
D = M 		// D = RAM[1]

@product
M = M + D	// product += RAM[1]

@i
M = M - 1	// i = i - 1

@LOOP
0;JMP

(OUTOFTHELOOP)
@product
D = M 		// D = product

@R2
M = D 		// RAM[2] = product

(END)
@END
0;JMP





