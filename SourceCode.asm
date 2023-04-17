
INCLUDE IRVINE32.inc

; ************************************************
; **************** Data Section ******************
; ************************************************
.DATA

;***********************************************
; ****** Strings of messages to display ********
;***********************************************

msg1	 BYTE 0AH
		 BYTE	"	--------------------------------------------", 0dh, 0ah
		 BYTE	"	--  WELCOME TO LIBRARY MANAGEMENT SYSTEM  --", 0dh, 0ah
		 BYTE	"	--------------------------------------------", 0dh, 0ah, 0ah
		 BYTE	"	1-> Register a Member", 0dh, 0ah
		 BYTE	"	2-> View Members", 0dh, 0ah
		 BYTE	"	3-> View Members From File", 0dh, 0ah
		 BYTE	"	4-> Add Book", 0dh, 0ah
		 BYTE	"	5-> View Books", 0dh, 0ah
		 BYTE	"	6-> View Books From Files", 0dh, 0ah
		 BYTE	"	7-> Exit Program", 0dh, 0ah
		 BYTE	"	Choose Your Option : ", 0
REG_MSG	 BYTE "	Enter Member's Name to register: ",0
VIEW_MEMBERS_MSG BYTE 0Ah,"	Viewing Registered Members: ",0AH, 0DH, 0
ADD_MSG			 BYTE "	Enter Book Name & Author Name to Add: ", 0dh, 0ah,
			 "	Separated By Comma:",0
VIEW_BOOKS_MSG BYTE 0Ah, "	Viewing Books in Library: ",  0dh, 0ah, 0
EXIT_MSG	   BYTE 0AH,
				    "	----------------- ",0dh, 0ah,
				    "	Exiting Program...",0dh, 0ah,
					"	See you again  :')",0dh, 0ah,
					"	------------------", 0
					
					
; variables to maniulate Books & Members

bool		   DWORD ?
MEMBERS_FILE   BYTE "MEMBERS.txt",0
BOOKS_FILE     BYTE "BOOKS.txt",0
filehandle     DWORD ?
BUFFER_SIZE = 5000
buffer_mem   BYTE buffer_size DUP (?)
buffer_book  BYTE buffer_size DUP (?)
bytesRead dword 1 dup(0)
REGISTER	 DWORD 1
VIEW_MEMBERS DWORD 2
VIEW_MF		 DWORD 3
ADD_BOOK	 DWORD 4
VIEW_BOOKS	 DWORD 5
VIEW_BF		 DWORD 6
EXITP		 DWORD 7	
MEMBER_SIZE = 20
MEMBER1 DB MEMBER_SIZE DUP (?)
MEMBER2 DB MEMBER_SIZE DUP (?)
MEMBER3 DB MEMBER_SIZE DUP (?)
MEMBER4 DB MEMBER_SIZE DUP (?)
MEMBER5 DB MEMBER_SIZE DUP (?)
MEMBER6 DB MEMBER_SIZE DUP (?)
NUM_MEMBERS DWORD 0
MEMBERS DD MEMBER1, MEMBER2, MEMBER3, MEMBER4, MEMBER5, MEMBER6, 0AH, 0DH, 0

BOOK_SIZE = 30
BOOK1 DB BOOK_SIZE DUP (?)
BOOK2 DB BOOK_SIZE DUP (?)
BOOK3 DB BOOK_SIZE DUP (?)
BOOK4 DB BOOK_SIZE DUP (?)
BOOK5 DB BOOK_SIZE DUP (?)
BOOK6 DB BOOK_SIZE DUP (?)
NUM_BOOKS DWORD 0
BOOKS DD BOOK1, BOOK2, BOOK3, BOOK4, BOOK5, BOOK6, 0AH, 0DH, 0


; **********************************************
; *************** Code Section *****************
; **********************************************

.CODE
MSG_DISPLAY proto, var: PTR DWORD
STRING_INPUT proto, var1: PTR DWORD
main PROC
	START:
	INVOKE MSG_DISPLAY,addr MSG1
	CALL READINT	; input for options

	CMP EAX, REGISTER
	JE REG_M		; jump to Register Member section
	CMP EAX, VIEW_MEMBERS
	JE VIEW_M		; jump to View Members section
	CMP EAX, VIEW_MF
	JE VIEW_MFILE		; jump to Add Book section
	CMP EAX, ADD_BOOK
	JE ADD_B		; jump to View Books section
	CMP EAX, VIEW_BOOKS
	JE VIEW_B		; calling function to display message
	CMP EAX, VIEW_BF
	JE VIEW_BFILE		; taking input in 2D array
		JMP EXIT_MENU

;----------------------------------------
;------------REGISTER MEMBERS------------
;----------------------------------------
	REG_M:
		INVOKE MSG_DISPLAY, ADDR REG_MSG
		;INVOKE STRING_INPUT, ADDR INPUT_STRING

	MOV ESI, OFFSET MEMBERS
	MOV EAX, MEMBER_SIZE
	MUL NUM_MEMBERS
	ADD ESI, EAX
	MOV EDX, ESI
	MOV ECX, MEMBER_SIZE
	CALL READSTRING
	INC NUM_MEMBERS

	;INVOKE CreateFile,
	;ADDR MEMBERS_FILE,
	;GENERIC_WRITE,
	;DO_NOT_SHARE, 
	;NULL, 
	;OPEN_ALWAYS, 
	;FILE_ATTRIBUTE_NORMAL, 
	;0
;
;cmp eax, INVALID_HANDLE_VALUE
	;je exit_1
	;mov filehandle, eax
;INVOKE SetFilePointer,
	 ;filehandle,
	;0, ; distance low
	;0, ; distance high
	;FILE_END
	;mov eax,filehandle
;
	;mov edx, offset BUFFER_MEM
	;mov ecx, 7
	;call READSTRING
	;mov eax, filehandle
	;call WriteToFile
;
	;INVOKE SetFilePointer,
	 ;filehandle,
	;0, ; distance low
	;0, ; distance high
	;FILE_END
;exit_1:
	;invoke CloseHandle, filehandle

		JMP START


