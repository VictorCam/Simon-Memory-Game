TITLE ExtraCredit     (ExtraCredit.asm)

; Author: Victor Daniel Campa
; Course / Project ID  CS271 Extra Credit                Date: 3/14/19
; Description: Simon is a memory based game that is a sequence of numbers the user should memorize each time the user gets one right it increments by 1 and repeats the sequence with the new value
; Instructions: When the input is 2 or more DO NOT ENTER YOUR ENTIRE SEQUENCE ON THE SAME INPUT!

;Comment Block Information
;Victor Daniel Campa
;campav@oregonstate.edu
;CS271-400
;Extra Credit
;3/14/19

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data

NUM1 BYTE "      _      ",0		;ascii art for 1 part 1
NUM2 BYTE "     / \     ",0		;ascii art for 1 part 2
NUM3 BYTE "     | |     ",0		;ascii art for 1 part 3
NUM4 BYTE "     | |     ",0		;ascii art for 1 part 4
NUM5 BYTE "     \_/     ",0		;ascii art for 1 part 5

NUM6  BYTE "    ____     ",0	;ascii art for 2 part 1
NUM7  BYTE "   /_   \    ",0	;ascii art for 2 part 2
NUM8  BYTE "    /   /    ",0	;ascii art for 2 part 3
NUM9  BYTE "   /   /_    ",0	;ascii art for 2 part 4
NUM10 BYTE "   \____/    ",0	;ascii art for 2 part 5

NUM11 BYTE "   _____     ",0	;ascii part for 3 part 1
NUM12 BYTE "   \__  \    ",0	;ascii part for 3 part 2
NUM13 BYTE "     /  |    ",0	;ascii part for 3 part 3
NUM14 BYTE "    _\  |    ",0	;ascii part for 3 part 4
NUM15 BYTE "   /____/    ",0	;ascii part for 3 part 5

NUM16 BYTE"       _     ",0		;ascii part for 4 part 1
NUM17 BYTE"   /\_/ |    ",0		;ascii part for 4 part 2
NUM18 BYTE"   \_   |    ",0		;ascii part for 4 part 3
NUM19 BYTE"      | |    ",0		;ascii part for 4 part 4
NUM20 BYTE"      \_|    ",0		;ascii part for 4 part 5

loc_arr DWORD 1										;location array that keeps track of when the program should stop turing lights on
loc_arr2 DWORD 1									;location array 2 that keeps track of when the program should stop asking user inputs
rarray WORD 200 DUP(?)								;random array that will be filled with random numbers up to 200
iarray WORD 200 DUP(?)								;input array that will be filled with user inputs up to 200
entertemp DWORD ?									;temporary value that will be used for the introduction of the game
userinput  BYTE "Enter a number: ",0				;Ask user to enter a number from the sequence
RIP BYTE "WRONG SEQUENCE GAMEOVER!",0				;Tell user that they entered the wrong sequence and gameover
error BYTE "Please enter a number between 1-4",0	;Tell user that input should be 1-4 only 

pressenter BYTE "[PRESS ENTER TO START]: ",0	;Ask user to press enter to start the game (even if they enter values it still works)

tintro	BYTE "INTRODUCTION:",0																									;declared title introduction
game	BYTE "Welcome to the game of Simon. This game is about remembering a random sequence.",0								;declared general info 1
game1	BYTE "The game will start by lighting up a square. Make sure to remember that sequence.",0								;declared general info 2
game2	BYTE "If you remember the sequence correctly the board will be printed again.",0										;declared general info 3
game3	BYTE "You will be given the sequence again starting from the beginning. Go as far as you can remember! Good Luck!",0	;declared general info 4

trules	BYTE "RULES:",0																											;delcared title rules
rule	BYTE "Memorize the sequence given according to the lights.",0															;declared title info 1
rule1	BYTE "Each time you get your sequence correct. The board will repeat the sequence from the beginning.",0				;declared title info 2
rule2	BYTE "You won't just enter the new sequence only you will enter your entire sequence according to the lights",0			;declared title info 3

tnote	BYTE "NOTE:",0																											;declared things to note
note	BYTE "Make sure you enter a single number when being asked to enter a number.",0										;declared things to note 1
note1	BYTE "Only your first thing on your input will be accepted anything else after a space will be ignored.",0				;delcared things to note 2
note2	BYTE "Wait for the the program to ask you to enter a number.",0															;delcared things to note 3

T1 BYTE"   __  _ __ __  __  __  _ _  ",0					;ascii art text title
T2 BYTE" /' _/| |  V  |/__\|  \| / \ ",0					;ascii art text title 2
T3 BYTE" `._`.| | \_/ | \/ | | ' \_/ ",0					;ascii art text title 3
T4 BYTE" |___/|_|_| |_|\__/|_|\__(_) ",0					;ascii art text title 4


;this is the 4 boxes for the simon the memory based game
S1	 BYTE "+-------------+           +-------------+",0
S2   BYTE "|             |           |             |",0
S3   BYTE "|             |           |             |",0
S4   BYTE "|             |           |             |",0
S5   BYTE "|             |           |             |",0
S6	 BYTE "|             |           |             |",0
S7   BYTE "+-------------+           +-------------+",0
S8	 BYTE "                                         ",0
S9	 BYTE "                                         ",0
S10	 BYTE "+-------------+           +-------------+",0
S11  BYTE "|             |           |             |",0
S12  BYTE "|             |           |             |",0
S13  BYTE "|             |           |             |",0
S14  BYTE "|             |           |             |",0
S15	 BYTE "|             |           |             |",0
S16  BYTE "+-------------+           +-------------+",0
		
drowDelay = 700					;time delay is 0.7 sec

.code
main PROC						;main procedure
;*******************************************************************
;call randomize, and OFFSET rarray and iarray and clear ecx
;*******************************************************************
    call	RANDOMIZE			;re-seeds random number generator
    mov edi, OFFSET rarray		;making random array equal to edi
    mov esi, OFFSET iarray		;making input array equal to esi
	xor ecx, ecx				;clearing ecx to 0



;*******************************************************************
;printing the name of the game, introduction, rules, and notes
;*******************************************************************
		mov		edx,OFFSET T1			;moving ascii art to edx
		call	WriteString				;printing ascii art
		call	crlf					;new line

		mov		edx,OFFSET T2			;moving ascii art to edx
		call	WriteString				;printing ascii art
		call	crlf					;new line

		mov		edx,OFFSET T3			;moving ascii art to edx
		call	WriteString				;printing ascii art
		call	crlf					;new line

		mov		edx,OFFSET T4			;moving ascii art to edx
		call	WriteString				;printing ascii art

		call	crlf					;new line
		call	crlf					;new line
		call	crlf					;new line


		mov		eax, (red*16)			;moves the color red which is mult by 16 to highlight the color
		call	SetTextColor			;set the color to red
		mov		edx,OFFSET tintro		;title of introduction and is red
		call	WriteString
		call	crlf					;new line

		mov		eax, white				;moves white to eax
		call	SetTextColor			;changes the color to white

		mov		edx,OFFSET game			;display what this game is part 1
		call	WriteString				;print general game instruction part 1
		call	crlf					;new line

		mov		edx,OFFSET game1		;display what this game is part 2
		call	WriteString				;print general game instruction part 2
		call	crlf					;new line

		mov		edx,OFFSET game2		;display what this game is part 3
		call	WriteString				;print general game instruction part 3
		call	crlf					;new line

		mov		edx,OFFSET game3		;display what this game is part 4
		call	WriteString				;print general game instruction part 4

		call	crlf					;new line
		call	crlf					;new line
		call	crlf					;new line

		mov		eax, (lightblue*16)		;moves the color lightblue which is mult by 16 to highlight the color
		call	SetTextColor			;set the color to lightblue
		mov		edx,OFFSET trules		;title of rules is lightblue
		call	WriteString
		call	crlf					;new line

		mov		eax, white				;moves white to eax
		call	SetTextColor			;changes the color to white

		mov		edx,OFFSET rule			;instructions how to play the game part 1
		call	WriteString				;print instruction part 1

		call	crlf					;new line

		mov		edx,OFFSET rule1		;instruction how to play the game part 2
		call	WriteString				;print instruction part 2

		call	crlf					;new line

		mov		edx,OFFSET rule2		;instruction how to play the game part 3
		call	WriteString				;print instruction part 3

		call	crlf					;new line
		call	crlf					;new line
		call	crlf					;new line

		mov		eax, (yellow*16)		;moves the color yellow which is mult by 16 to highlight the color
		call	SetTextColor			;set the color to yellow
		mov		edx,OFFSET tnote		;title of note is yellow
		call	WriteString
		call	crlf					;new line

		mov		eax, white				;moves white to eax
		call	SetTextColor			;changes the color to white

		mov		edx,OFFSET note			;some tiny things user should note part 1
		call	WriteString				;printing the note

		call	crlf					;new line

		mov		edx,OFFSET note1		;some tiny things user should note part 2
		call	WriteString				;printing the note

		call	crlf					;new line

		mov		edx,OFFSET note2		;some tiny things user should note part 3
		call	WriteString				;printing the note

		call	crlf					;new line
		call	crlf					;new line
		call	crlf					;new line



;*******************************************************************
;printing out the instructions to start the game
;*******************************************************************
	mov		edx,OFFSET pressenter	;press enter to start the game prompt
	call	WriteString				;prints the prompt to the user

	mov		ebx, entertemp			;let the user any 
	call	ReadDec					;read the user input or when they just press enter
	call	Clrscr					;clear screen when entered



;*******************************************************************
;fill the whole random array with values according to the size
;*******************************************************************
keepfill:
	mov		eax, 4					;get the range from 0-4
	call	RandomRange				;used to determine a range
	add		eax, 1					;added one to get the random range to be between 1-4 now

	mov		[edi + ecx * 2], eax	;store the random value from eax to random range in rarray


	inc ecx							;increments ecx for the location of rarray when jumping back
    cmp ecx, LENGTHOF rarray		;compare the length of the random array to ecx and
	jne keepfill					;if its not equal keep filling random values else registers are cleared and we begin to the square/numbers/etc

	xor	eax, eax					;clearing eax to 0
	xor ecx, ecx					;clearing ecx to 0



;*******************************************************************
;begin printing square board
;*******************************************************************
printsquare:
	call	crlf			;new line
	mov		edx,OFFSET S1	;moves part of board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S2	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S3	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S4	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S5	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S6	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S7	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S8	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S9	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S10	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S11	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S12	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S13	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S14	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S15	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line

	mov		edx,OFFSET S16	;moves part of the board to edx
	call	WriteString		;prints part of board on screen
	call	crlf			;new line



;*******************************************************************
;reset the value back to white and determine positions 
;*******************************************************************
determinenext:
	mov eax, 450						;moves 450 to eax
	call Delay							;time gets delayed by 0.45 seconds

	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white

	mGotoxy 1, 2						;position of the value [1] in x,y
	mov		edx,OFFSET num1				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 2
	mGotoxy 1, 3						;position of the value [1] in x,y
	mov		edx,OFFSET num2				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 3
	mGotoxy 1, 4						;position of the value [1] in x,y
	mov		edx,OFFSET num3				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 4
	mGotoxy 1, 5						;position of the value [1] in x,y
	mov		edx,OFFSET num4				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 5
	mGotoxy 1, 6						;position of the value [1] in x,y
	mov		edx,OFFSET num5				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 6

	mGotoxy 27, 2						;position of the value [1] in x,y
	mov		edx,OFFSET num6				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 2
	mGotoxy 27, 3						;position of the value [1] in x,y
	mov		edx,OFFSET num7				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 3
	mGotoxy 27, 4						;position of the value [1] in x,y
	mov		edx,OFFSET num8				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 4
	mGotoxy 27, 5						;position of the value [1] in x,y
	mov		edx,OFFSET num9				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 5
	mGotoxy 27, 6						;position of the value [1] in x,y
	mov		edx,OFFSET num10			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 6

	mGotoxy 1, 11						;position of the value [1] in x,y
	mov		edx,OFFSET num11			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 11
	mGotoxy 1, 12						;position of the value [1] in x,y
	mov		edx,OFFSET num12			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 12
	mGotoxy 1, 13						;position of the value [1] in x,y
	mov		edx,OFFSET num13			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 13
	mGotoxy 1, 14						;position of the value [1] in x,y
	mov		edx,OFFSET num14			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 14
	mGotoxy 1, 15						;position of the value [1] in x,y
	mov		edx,OFFSET num15			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 15

	mGotoxy 27, 11						;position of the value [1] in y,x
	mov		edx,OFFSET num16			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 11
	mGotoxy 27, 12						;position of the value [1] in x,y
	mov		edx,OFFSET num17			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 12
	mGotoxy 27, 13						;position of the value [1] in x,y
	mov		edx,OFFSET num18			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 13
	mGotoxy 27, 14						;position of the value [1] in x,y
	mov		edx,OFFSET num19			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 14
	mGotoxy 27, 15						;position of the value [1] in x,y
	mov		edx,OFFSET num20			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 15

	mov eax, drowDelay					;drowDelay = 700 so 700 is moved to eax which is 0.7 seconds
	call Delay							;delayed by 0.7 seconds

	jmp location						;jmp into the location to determine which color to press



;**************************************************************************************************
;jumps 1,2,3,4 correspond to the colors that will be activated and they positions they should be in
;**************************************************************************************************
jmp1:
	mov		eax, (red*16)				;moves red and is mult by 16 to eax
	call	SetTextColor				;changes the color to red

	mGotoxy 1, 2						;position of the value [1] in x,y
	mov		edx,OFFSET num1				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 2
	mGotoxy 1, 3						;position of the value [1] in x,y
	mov		edx,OFFSET num2				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 3
	mGotoxy 1, 4						;position of the value [1] in x,y
	mov		edx,OFFSET num3				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 4
	mGotoxy 1, 5						;position of the value [1] in x,y
	mov		edx,OFFSET num4				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 5
	mGotoxy 1, 6						;position of the value [1] in x,y
	mov		edx,OFFSET num5				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 6
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white

	jmp		stop						;jump to stop determine next light

jmp2:
	mov		eax, (blue*16)				;moves blue and is mult by 16 to eax
	call	SetTextColor				;changes the color to blue

	mGotoxy 27, 2						;position of the value [1] in x,y
	mov		edx,OFFSET num6				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 2
	mGotoxy 27, 3						;position of the value [1] in x,y
	mov		edx,OFFSET num7				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 3
	mGotoxy 27, 4						;position of the value [1] in x,y
	mov		edx,OFFSET num8				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 4
	mGotoxy 27, 5						;position of the value [1] in x,y
	mov		edx,OFFSET num9				;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 5
	mGotoxy 27, 6						;position of the value [1] in x,y
	mov		edx,OFFSET num10			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 6
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white

	jmp		stop						;jump to stop determine next light

jmp3:
	mov		eax, (yellow*16)			;moves yellow and is mult by 16 to eax
	call	SetTextColor				;changes the color to yellow

	mGotoxy 1, 11						;position of the value [1] in x,y
	mov		edx,OFFSET num11			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 11
	mGotoxy 1, 12						;position of the value [1] in x,y
	mov		edx,OFFSET num12			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 12
	mGotoxy 1, 13						;position of the value [1] in x,y
	mov		edx,OFFSET num13			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 13
	mGotoxy 1, 14						;position of the value [1] in x,y
	mov		edx,OFFSET num14			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 14
	mGotoxy 1, 15						;position of the value [1] in x,y
	mov		edx,OFFSET num15			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 1, 15
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white

	jmp		stop						;jump to stop determine next light

jmp4:
	mov		eax, (green*16)				;moves green and is mult by 16 to eax
	call	SetTextColor				;changes the color to green

	mGotoxy 27, 11						;position of the value [1] in y,x
	mov		edx,OFFSET num16			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 11
	mGotoxy 27, 12						;position of the value [1] in x,y
	mov		edx,OFFSET num17			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 12
	mGotoxy 27, 13						;position of the value [1] in x,y
	mov		edx,OFFSET num18			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 13
	mGotoxy 27, 14						;position of the value [1] in x,y
	mov		edx,OFFSET num19			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 14
	mGotoxy 27, 15						;position of the value [1] in x,y
	mov		edx,OFFSET num20			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 27, 15
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white

	jmp		stop						;jump to stop determine next light

;*******************************************************************************
;determine if a new light needs to be printed or not
;*******************************************************************************
stop:
    inc		ecx							;increment ecx
	call	crlf						;new line
    cmp		ecx, loc_arr2				;compare ecx to location_array 2 which will determine when its time for the value the lights to stop
    jne		determinenext				;if its not equal then print a new color
	jmp		newlight					;if there is no more lights to light up jump to the newlight

newlight:
	mov		eax, 450					;move eax to 450 which is equal to 0.45 seconds
	call	Delay						;delay the table so the user has enough time to new light
	call	Clrscr						;clears the whole screen

	inc		loc_arr2					;increments location array 2 so when it goes back we added a new light
	xor		ecx, ecx					;reset ecx to 0
	jmp		NEXTARR						;jump to next array which will ask the user to enter the sequence shown to them


		
;*******************************************************************
;determines the location to jump to light the color
;*******************************************************************
location:
	mov ax, [edi + ecx * 2]	;the register + the position * the number of bytes the data type is = the literal number in the array moved to ax
	call	crlf				;new line

	cmp		ax, 4 				;compare array values
	je		jmp4				;jump to print light 4
	cmp		ax, 3				;compare array values
	je		jmp3				;jump to print light 3
	cmp		ax, 2				;compare array values
	je		jmp2				;jump to print light 2
	cmp		ax, 1				;compare array values
	je		jmp1				;jump to print light 1
	jmp		gameover			;if the randomly array fails to get caught from 1-4 [WHICH IT WON'T] give the user a gameover



;*************************************************************************************************
;lets user enter a value and check if the sequence they are entering is equal to the random array
;*************************************************************************************************
BADINPUT:
	mov		edx,OFFSET error			;moves user information to edx
	call	WriteString					;prints the user information for bad input

	call	crlf						;new line
	call	crlf						;new line
NEXTARR:
	mov		edx,OFFSET userinput		;moves user information to edx
	call	WriteString					;prints the user information for input

	call	ReadDec						;we read in the number from 1-4 and store it into the array
	mov		[esi + ecx * 2], al			;moves al to the value of input array
	
    mov		al, [esi + ecx * 2]			;moves the value of input array into register al
	
	
	cmp		al, [edi + ecx * 2]			;compare the same index of random array and input array
	je		EQUAL						;if they are equal then don't make them gameover
	jmp		UNEQUAL						;if not equal then we jump to UNEQUAL and first check if they did enter 1-4 then let the user know they failed if they did enter 1-4

;***********************************************************************************************
;if not equal check if it is between 1-4 if its anything else reprompt user else game over user
;***********************************************************************************************
UNEQUAL:
	xor		ah, ah						;reset ah to 0
	add		ah, 1						;add 1 to ah
	cmp		al, ah						;compare 1 to the users input
	je		badsequence					;if it is the right number that they entered the wrong sequence 

	xor		ah, ah						;reset ah to 0
	add		ah, 2						;add 2 to ah
	cmp		al, ah						;compare 2 to the users input
	je		badsequence					;if it is the right number that they entered the wrong sequence

	xor		ah, ah						;reset ah to 0
	add		ah, 3						;add 3 to ah
	cmp		al, ah						;compare 2 to the users input
	je		badsequence					;if it is the right number that they entered the wrong sequence

	xor		ah, ah						;reset ah to 0
	add		ah, 4						;add 4 to ah
	cmp		al, ah						;compare 2 to the users input
	je		badsequence					;if it is the right number that they entered the wrong sequence

	jmp		BADINPUT					;if user entered bad input tell user to enter again

badsequence:
	mov		eax, (red*16)				;moves red mult by 16 to eax
	call	SetTextColor				;makes the text highlighted red
	mov		edx, OFFSET RIP				;move the gameover string to edx 
	call	writeString					;prints the string to the user
	mov		eax, white					;moves white to eax
	call	SetTextColor				;sets the color to white
	jmp		gameover					;jump to the gameover screen and end the program

;***********************************************************************************************
;determine if the sequence is complete if not keep asking user for input
;***********************************************************************************************
EQUAL:
	call	Clrscr						;clears the screen
    inc		ecx							;increments ecx
    cmp		ecx, loc_arr				;compare ecx to location_array which will determine when its time for the inputs to stop
    jne		NEXTARR						;if its not equal then ask the user another input
	jmp		NEWARR						;if there is no more to enter in the sequence jump to NEWARR

NEWARR:
	inc		loc_arr						;increments the location array
	xor		ecx, ecx					;resets ecx to 0
	jmp		printsquare					;goes back to printsquare to print the next new light
	
gameover:								;if user enters number wrong game over the user by jumping here
	call	crlf						;new line

main ENDP								;end the main procedure

END main								;end main