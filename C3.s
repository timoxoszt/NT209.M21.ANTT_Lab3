.section .data
  input:
   .string "Nhap vao nam sinh: "
  age:
   .string "So tuoi: "
  yes:
   .string "Thuoc tuoi Doan "
  no:
   .string "Khong thuoc tuoi Doan "
  year:
   .int 2022
  enter:
   .string "\n"
  zero:
   .string "0"
   
.section .bss
   .lcomm x,4
   .lcomm y,2
   .lcomm z,2
   
.section .text
   .globl _start
_start:
#Xuat dong "Nhap vao nam sinh: " ra man hinh
   movl $19, %edx
   movl $input, %ecx
   movl $4, %eax
   movl $1, %ebx
   int $0x80

#Nhap x
   movl $3,%eax
   movl $0, %ebx
   movl $x,%ecx
   movl $5, %edx
   int $0x80


#Xuat dong "So tuoi: " ra man hinh
   movl $9, %edx 
   movl $age, %ecx
   movl $4,%eax
   movl $1,%ebx
   int $0x80
  
#Chuyen ki tu dau tien cua chuoi thanh so, sau do *1000
   xorl %eax, %eax
   xorl %ecx, %ecx
   xorb %cl, %cl
   movl $x, %eax
   movb (%eax), %cl
   subb $'0', %cl
   imul $1000, %ecx
   int $0x80
 
#Chuyen ki tu thu hai cua chuoi thanh so, sau do *100
   xorl %edx, %edx
   xorl %eax, %eax
   xorb %dl, %dl
   movl $x, %eax
   movb 1(%eax), %dl
   subb $'0', %dl
   imul $100, %edx
   int $0x80

#cong 2 gia tri va luu vao thanh ghi %ecx
   addl %edx, %ecx
   int $0x80

#Chuyen ki tu thu ba cua chuoi thanh so, sau do *10
   xorl %eax, %eax
   xorl %ebx, %ebx
   xorb %bl, %bl
   movl $x, %eax
   movb 2(%eax), %bl
   subb $'0', %bl
   imul $10, %ebx
   int $0x80
   
#Cong ki tu thu ba vao thanh ghi %ecx va luu lai 
   addl %ebx, %ecx
   int $0x80

#Chuyen ki tu thu tu cua chuoi thanh so
   xorl %eax, %eax
   xorl %edx, %edx
   xorb %dl, %dl
   movl $x, %eax
   movb 3(%eax),%dl
   subb $'0', %dl
   int $0x80

#Cong ki tu thu tu vao thanh ghi %ecx va luu lai 
   addl %edx, %ecx
   int $0x80

#Luu year = 2022 vao thanh ghi %edx, sau do so sanh voi nam sinh, neu nam sinh >= year nhay toi _more, neu khong thi lay year - nam sinh de ra so tuoi 
   xor %edx, %edx
   movl year, %edx
   
   cmpl %edx, %ecx
   jge _more
   
   subl %ecx, %edx

#Tach gia tri trong thanh ghi %edx thanh 2 gia tri
   movl %edx, %eax  
   xor %edx, %edx
   xor %ebx,%ebx
   movl $10, %ebx
   div %ebx
   addl $'0', %edx
   addl $'0', %eax
   #Luu 2 gia tri vua tach vao y
   movl $y, %ebx
   movl %eax, (%ebx)
   movl %edx, 1(%ebx)
   int $0x80

#Xuat 2 ki tu ra man hinh, 2 ki tu duoc luu vao y 
   movl $4, %eax
   movl $1, %ebx
   movl $y, %ecx
   movl $2, %edx
   int $0x80
   
#Xuat xuong dong
   movl $4, %eax
   movl $1, %ebx
   movl $enter, %ecx
   movl $2, %edx
   int $0x80

#Lay gia tri trong y gan vao thanh ghi %eax
   xorl %eax, %eax
   xorl %ebx, %ebx
   xorb %bl, %bl
   movl $y,%eax
   movb (%eax),%bl
   subb $'0', %bl
   imul $10, %ebx #Lay ki tu dau tien bang cach *10
   int $0x80

#Lay ki tu thu hai
   xorl %eax, %eax
   xorl %edx, %edx
   xorb %dl, %dl
   movl $y, %eax
   movb 1(%eax),%dl
   subb $'0', %dl
   int $0x80
 
#Cong hai gia tri vua nhan duoc va luu vao thanh ghi edx
   addl %ebx, %edx

#So sanh %edx(so tuoi hien tai) voi 16, %edx >= 16 nhay toi _compare30, nguoc lai nhay toi _false

   cmpl $16, %edx
   jge _compare30  
   jmp _false

#Truong hop nam sinh >=year(2022), xuat tuoi = 0 va nhay toi _false
_more:
   movl $4, %eax
   movl $1, %ebx
   movl $zero, %ecx
   movl $1, %edx
   int $0x80   
   
   movl $4, %eax
   movl $1, %ebx
   movl $enter, %ecx
   movl $2, %edx
   int $0x80
   jmp _false
   
#Neu tuoi hien tai <= 30 thi nhay toi _true, nguoc lai nhay toi _false
_compare30:
   cmpl $30, %edx
   jle _true
   jmp _false

#Xuat ra man hinh "Thuoc tuoi Doan" va nhay toi _exit
_true:
   movl $16,%edx 
   movl $yes, %ecx
   movl $4,%eax
   movl $1,%ebx
   int $0x80
   jmp _exit   

#Xuat ra man hinh "Khong thuoc tuoi Doan" va nhay toi _exit
_false:
   movl $22,%edx 
   movl $no, %ecx
   movl $4,%eax
   movl $1,%ebx
   int $0x80
   jmp _exit   

#Xuong dong va thoat
_exit:
   movl $4, %eax
   movl $1, %ebx
   movl $enter, %ecx
   movl $2, %edx
   int $0x80

   movl $1, %eax
   int $0x80

