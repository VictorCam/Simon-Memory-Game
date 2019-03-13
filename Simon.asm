TITLE ExtraCredit     (ExtraCredit.asm)

; Author: Victor Daniel Campa
; Course / Project ID  CS271 Extra Credit                Date: 3/13/19
; Description: Simon is a memory based game that is a sequence of numbers the user should memorize each time the user gets one right it increments by 1 and repeats the sequence with the new value
; Instructions: When the input is 2 or more DO NOT ENTER YOUR ENTIRE SEQUENCE ON THE SAME INPUT OR YOU WILL GAME OVER!

;Comment Block Information
;Victor Daniel Campa
;campav@oregonstate.edu
;CS271-400
;Extra Credit
;3/13/19

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
number_1		BYTE	 "[1]", 0				;value that will be lit up
number_2		BYTE	 "[2]", 0				;value that will be lit up
number_3		BYTE	 "[3]", 0				;value that will be lit up
number_4		BYTE     "[4]", 0				;value that will be lit up
loc_arr DWORD 1									;location array that keeps track of when the program should stop turing lights on
loc_arr2 DWORD 1								;location array 2 that keeps track of when the program should stop asking user inputs
rarray WORD 200 DUP(?)							;random array that will be filled with random numbers up to 200
iarray WORD 200 DUP(?)							;input array that will be filled with user inputs up to 200
entertemp DWORD ?								;temporary value that will be used for the introduction of the game
userinput  BYTE "Enter a number: ",0			;Ask user to enter a number from the sequence
RIP BYTE "WRONG SEQUENCE GAMEOVER!",0			;Tell user that they entered the wrong sequence and gameover

pressenter BYTE "[PRESS ENTER TO START]: ",0	;Ask user to press enter to start the game (even if they enter values it still works)

tintro	BYTE "INTRODUCTION:",0																	;declared title introduction
game	BYTE "Welcome to SIMON the memory based game this game is about",0						;declared general info 1
game1	BYTE "remembering sequences a board will print and light up a value and",0				;declared general info 2
game2	BYTE "then you repeat what was entered afterwards the sequence will get +1 longer",0	;declared general info 3
game3	BYTE "and you will be asked to remeber the longer sequence",0							;declared general info 4

trules	BYTE "RULES:",0																			;delcared title rules
rule	BYTE "press any input or just enter to start afterwards you will be given",0			;declared title info 1
rule1	BYTE "a sequence starting from 1 and each time you get the sequence right the",0		;declared title info 2
rule2	BYTE "board will repeat its previous sequence and give you a new value",0				;declared title info 3

tnote	BYTE "NOTE:",0																			;declared things to note
note	BYTE "make sure you enter a single number when being asked to enter a number",0			;declared things to note 2
note2	BYTE "wait for the the program to ask for you to input for the next value", 0			;delcared things to note 3

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

		mov		edx,OFFSET note2		;some tiny things user should note part 2
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

	mGotoxy 6, 4						;position of the value [1] in x,y
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white
	mov		edx,OFFSET number_1			;moves the string "[1]" to edx
	call	WriteString					;prints the number "[1]" at position 6, 3

	mGotoxy 32, 4						;position of the value [2] in x,y
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white
	mov		edx,OFFSET number_2			;moves the string "[2]" to edx
	call	WriteString					;prints the number "[2]" at position 32, 3

	mGotoxy 6, 13						;position of the value [3] in x,y
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white
	mov		edx,OFFSET number_3			;moves the string "[3]" to edx
	call	WriteString					;prints the number "[3]" at position 6, 12

	mGotoxy 32, 13						;position of the value [4] in x,y
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white
	mov		edx,OFFSET number_4			;moves the string "[4]" to edx
	call	WriteString					;prints the number "[4]" at position 32, 12

	mov eax, drowDelay					;drowDelay = 700 so 700 is moved to eax which is 0.7 seconds
	call Delay							;delayed by 0.7 seconds

	jmp location						;jmp into the location to determine which color to press



;**************************************************************************************************
;jumps 1,2,3,4 correspond to the colors that will be activated and they positions they should be in
;**************************************************************************************************
jmp1:
	mov		eax, (red*16)				;moves the color red which is mult by 16 to highlight the color
	call	SetTextColor				;set the color to red
	mGotoxy 6, 4						;position of the value [1] in x,y
	mov		edx,OFFSET number_1			;moves the stirng "[1]" to edx
	call	WriteString					;prints the number "[1]" to position  6, 3
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white
	jmp		stop						;jump to stop determine next light

jmp2:
	mov		eax, (lightblue*16)			;moves the color lightblue which is mult by 16 to highlight the color
	call	SetTextColor				;set the color to lightblue
	mGotoxy 32, 4						;position of the value [2] in x,y
	mov		edx,OFFSET number_2			;moves of the value "[2]" to edx
	call	WriteString					;prints the number "[2]"
	mov		eax, white					;moves white to eax
	call	SetTextColor				;changes the color to white
	jmp		stop						;jump to stop determine next light

jmp3:
	mov		eax, (yellow*16)			;moves the color yellow which is mult by 16 to highlight the color
	call	SetTextColor				;set the color to yellow
	mGotoxy 6, 13						;position of the value [3] in x,y
	mov		edx,OFFSET number_3			;moves of the value "[3]" to edx
	call	WriteString					;prints the number "[3]"
	mov		eax,white					;moves white to eax
	call	SetTextColor				;changes the color to white
	jmp		stop						;jump to stop determine next light

jmp4:
	mov		eax, (green*16)				;moves the color green which is mult by 16 to highlight the color
	call	SetTextColor				;set the color to green
	mGotoxy 32, 13						;position of the value [4] in x,y
	mov		edx,OFFSET number_4			;moves of the value "[4]" to edx
	call	WriteString					;prints the number "[4]"
	mov		eax, white					;prints the color white
	call	SetTextColor				;sets the color to white
	jmp		stop						;jump to stop determine next light
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



;*******************************************************************************
;lets user enter a value and check if the sequence they are entering is correct
;*******************************************************************************
NEXTARR:
	mov		edx,OFFSET userinput		;moves user information to edx
	call	WriteString					;prints the user information for input

	call	ReadDec						;we read in the number from 1-4 and store it into the array
	mov		[esi + ecx * 2], al			;moves al to the value of input array
	
    mov		al, [esi + ecx * 2]			;moves the value of input array into register al
	
	
	cmp		al, [edi + ecx * 2]			;compare the same index of random array and input array
	je		EQUAL						;if they are equal they don't make them gameover
	jmp		UNEQUAL						;if not equal then we jump to UNEQUAL and let the user know they failed

UNEQUAL:
	mov		eax, (red*16)				;moves red mult by 16 to eax
	call	SetTextColor				;makes the text highlighted red
	mov		edx, OFFSET RIP				;move the gameover string to edx 
	call	writeString					;prints the string to the user
	mov		eax, white					;moves white to eax
	call	SetTextColor				;sets the color to white
	jmp		gameover					;jump to the gameover screen and end the program

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
	
gameover:
	call	crlf						;new line

main ENDP								;end the main procedure

END main								;end main