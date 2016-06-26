// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

// color = 0
//
// (LISTENKBD)
// if RAM[KBD] != 0 {
//		if (color != -1) //black {
//			color = -1 // black	
//			goto CHANGECOLOR
//		}
//	} else {
//		if (color != 0) // white {
//			color = 0 // white
//			goto CHANGECOLOR
//		}
//	}

@0
D = A
@color
M = D	// color = 0

(LISTENKBD)
@KBD
D = M
@NOKEYPRESSED
D; JEQ			// if (RAM[KBD] == 0) goto NOTKEYPRESSED


(KEYPRESSED)
@color
D = M 	
@NOCHANGE
D; JNE			// if (color != 0) goto NOCHANGE

// key pressed and need to change the color

// make the screen black
@0
D = A - 1
@color
M = D			// color = -1; goto CHANGECOLOR
@CHANGECOLOR
0;JMP

(NOKEYPRESSED)
@color
D = M 	
@NOCHANGE
D; JEQ			// if (color == 0) goto NOCHANGE

// make the screen white
@0
D = A
@color
M = D			// color = 0; goto CHANGECOLOR
@CHANGECOLOR
0;JMP

(NOCHANGE)
@LISTENKBD		// goto LISTENKBD
0;JMP


// turn screen into black

// write -1/0 in 512 words starting from SCREEN, to make it black/white

// expects -1  or 0 in color variable
// (CHANGECOLOR)
// for (i = 0; i < 8K; i++) {
//		RAM[ SCREEN + i ] = color
//	} 
//  goto LISTENKBD

(CHANGECOLOR)
@0
D = A
@i
M = D	// i = 0

(LOOP)
@8192
D = A
@i
D = M - D
@UPDATEPIXEL
D; JLT		// if i < 8K goto UPDATEPIXEL

// complete 8K * 2 bytes filled with color; go back to listen Keyboard
@LISTENKBD
0; JMP


(UPDATEPIXEL)
@SCREEN
D = A 			// d = screen base address
@i
A = D + M 		// Adress = screen base addr + i
D = M 			// taking shortcut by changing between -1 and 0
M = !D          // updating with opposite value at (addr + i)

@i
M = M + 1	 	// i = i + 1

@LOOP
0;JMP


