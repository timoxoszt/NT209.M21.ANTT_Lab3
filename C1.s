.section .data 
	text: .string "Enter a character: "
	enter: .string "\n"
	chuhoa: .string "Chu hoa"
	chuthuong: .string "Chu thuong"
	check: .string "Khong hop le"
	
.section .bss
	.lcomm x,0
	
.section .text
	.globl _start
_start:
	#Xuat string "Enter a character: "
	movl $4, %eax
	movl $1, %ebx
	movl $text, %ecx
	movl $19, %edx
	int $0x80
	
	#Nhap
	movl $3, %eax
	movl $0, %ebx
	movl $x, %ecx
	movl $2, %edx
	int $0x80

	#If else
	movb (x), %cl #Gan gia tri x vua nhap vao thanh ghi %cl
	cmpb $97, %cl #So sanh gia tri trong thanh ghi %cl voi 97(a)
	jge _L1       #Neu x >= 97 thi nhay sang .L1
	cmpb $65, %cl #So sanh gia tri trong thanh ghi %cl voi 65(A)
	jge _L3       #Neu x >= 65 thi nhay sang .L2
	jmp _Else     #Truong hop con lai, xuat "Khong hop le"

	_L1:
		cmpb $122, %cl #So sanh voi 122(z)
		jle _Not_Cap   #Neu x <= 122 thi xuat "Chu thuong"
		jmp _Else      #Neu khong dung thi xuat "Khong hop le"
		
	_L3: 
		cmpb $90, %cl #So sanh voi 90(Z)
		jle _Cap      #Neu x <= 90 thi xuat "Chu hoa"
		jmp _Else     #Neu khong dung thi xuat "Khong hop le"
		
	#Chu thuong
	_Not_Cap:
		#Xuat dong "Chu thuong" ra man hinh
		movl $4, %eax
		movl $1, %ebx
		movl $chuthuong, %ecx
		movl $10, %edx
		int $0x80
		
		#Xuong dong
		movl $4, %eax
		movl $1, %ebx
		movl $enter, %ecx
		movl $2, %edx
		int $0x80
		
		movl $1, %eax
		int $0x80
		
	#Chu hoa
	_Cap:
		#Xuat dong "Chu hoa" ra man hinh
		movl $4, %eax
		movl $1, %ebx
		movl $chuhoa, %ecx
		movl $7, %edx
		int $0x80
		
		#Xuong dong
		movl $4, %eax
		movl $1, %ebx
		movl $enter, %ecx
		movl $2, %edx
		int $0x80
		
		movl $1, %eax
		int $0x80
		
	_Else:
		#Xuat dong "Khong hop le" ra man hinh
		movl $4, %eax
		movl $1, %ebx
		movl $check, %ecx
		movl $12, %edx
		int $0x80
		
		#Xuong dong
		movl $4, %eax
		movl $1, %ebx
		movl $enter, %ecx
		movl $2, %edx
		int $0x80
		
		movl $1, %eax
		int $0x80
