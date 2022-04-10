.section .data
	str:
		.string "So co 3 chu so: "
	inc:
		.string "Tang dan"
	dec:
		.string "Khong tang dan"
	equal:
		.string "Bang nhau"
	enter:
		.string "\n"
		
.section .bss
	.lcomm num,0
	
.section .text
	.globl _start
_start:
	#Xuat man hinh "So co 3 chu so: "
	movl $4, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl $16, %edx
	int $0x80
	
	#Nhap 
	movl $3, %eax
	movl $0, %ebx
	movl $num, %ecx
	movl $4, %edx
	int $0x80
	
	#Lay chu so dau tien
	xorl %eax, %eax #Empty thanh ghi
	movl $num, %eax
	xorb %bl, %bl
	movb (%eax), %bl #Lay ky tu dau tien
	int $0x80
	
	#Lay chu so thu 2
	xorl %eax, %eax
	movl $num, %eax
	xorb %cl ,%cl 
	movb 1(%eax), %cl #Lay ky tu thu hai 
	int $0x80
	
	#Lay chu so thu 3
	xorl %eax, %eax
	movl $num, %eax
	xorb %dl, %dl
	movb 2(%eax), %dl #Lay ky tu thu ba 
	int $0x80
	
	#So sanh
	cmpb %cl, %bl #So sanh ki tu 1(bl) va ki tu 2(cl)
	jl .L1 # a(bl) < b(cl), nhay toi .L1
	cmpb %cl, %bl 
	jg .dec #a(bl) > b(cl)
	cmpb %cl, %bl
	je .L3 #a(bl) = b(cl)

.L1:
	cmpb %dl, %cl #So sanh
	jle .inc #b(cl) <= c(dl) thi nhay toi .inc
	jmp .dec #Nhay toi .dec 

.L2:
	cmpb %dl, %cl #So sanh
	jne .dec #b(cl) != c(dl) thi nhay toi .dec
	jmp .inc #Nhay toi .inc

.L3:
	cmpb %dl, %cl #So sanh
	jl .inc #b(cl) < c(dl) thi nhay toi .inc
	cmpb %dl, %cl #So sanh
	jg .dec ##b(cl) > c(dl) thi nhay toi .dec
	jmp .equal #Nhay toi .equal

#Xuat "Khong tang dan"
.dec: 
	movl $4, %eax
	movl $1, %ebx
	movl $dec, %ecx 
	movl $14, %edx
	int $0x80
	jmp .L0 #nhay toi exit

#Xuat "Bang nhau"
.equal:
	movl $4, %eax
	movl $1, %ebx
	movl $equal, %ecx
	movl $9, %edx
	int $0x80
	jmp .L0
	
#Xuat "Tang dan"
.inc:
	movl $4, %eax
	movl $1, %ebx
	movl $inc, %ecx #in ra man hinh tang dan
	movl $8, %edx
	int $0x80
	jmp .L0 #nhay toi exit

#Xuat enter va thoat chuong trinh
.L0:
	#xuong dong
	movl $4, %eax
	movl $1, %ebx
	movl $enter, %ecx
	movl $2, %edx
	int $0x80
	
	movl $1, %eax
	int $0x80

