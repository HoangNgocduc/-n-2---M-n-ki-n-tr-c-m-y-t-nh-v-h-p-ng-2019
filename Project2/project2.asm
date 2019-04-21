.data
	time: .asciiz "07/06/1997"
	time_1: .asciiz "--/--/----"
	time_2: .asciiz "01/01/0001"
	p_canchi: .asciiz "          "
	
	p_day: .space 3
	p_month: .space 3
	p_year: .space 5
	title: "==============================KIEN TRUC MAY TINH VA HOP NGU===========================================\nHoTen: Hoang Ngoc Duc\nMSSV: 1512123\n==> Vui long Nhap ngay, thang, nam \n"
	# prompt
	prompt1: .asciiz "\n+ DAY: "
	prompt2: .asciiz "\n+ MONTH: "
	prompt3: .asciiz "\n+ YEAR: "
	prompt4: .asciiz "\nKhoang cach tu ngay  "
	prompt5: .asciiz " den ngay "
	prompt6: .asciiz " la "
	prompt7: .asciiz " ngay."
	prompt8: .asciiz "\nHai nam nhuan gan voi "
	prompt9: .asciiz " nhat la "
	prompt10: .asciiz " va "
	prompt11: .asciiz " la nam "

	#loi
	errorMessage: "\ndu lieu nhap vao khong hop le! Xin vui long kiem tra lai. "
	notifResusts: "\nket qua la: "
	dayOfmonths: .word 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
	# menu
	menu: .asciiz "\n====================================MENU===============================================================\n1. Xuat chuoi Time theo dinh dang DD/MM/YEAR\n2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n\tA. MM/DD/YYYY\n\tB. Month DD, YYYY\n\tC. DD Month, YYYY\n3. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n4. Cho biet ngay vua nhap la ngay thu may trong tuan\n5. Cho biet ngay vua nhap la thu may ke tu ngay 1/1/1\n6. cho biet can chi cua nam vua nhap\n7. cho biet khoang thoi gian giua TIME_1 va TIME_2\n8 Cho biet 2 nam nhuan gan nhat voi nam nam trong chuoi time\n9. Nhap input tu file input.txt xuat toan bo cac chuc nang tren ra file output.txt\n========================================================================================================\n"	 
	option: .asciiz "Nhap chuc nang: "
	menutable: .word o1, o2, o3, o4, o5, o6, o7, o8, o9
	type: .asciiz "Loai (A/B/C): "
	jump: .word m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12 
	# months
	jan: .asciiz "January"
	feb: .asciiz "February"
	mar: .asciiz "March"
	apr: .asciiz "April"
	may: .asciiz "May"
	jun: .asciiz "June"
	jul: .asciiz "July"
	aug: .asciiz "August"
	sep: .asciiz "September"
	oct: .asciiz "October"
	nov: .asciiz "November"
	dec: .asciiz "December"
	
	convert_time: .space 20
	leap: .asciiz " la nam nhuan."
	notleap: .asciiz "  La Nam Thuong."
	daysOfWeek: .word cn, t2, t3, t4, t5, t6, t7
	sun: .asciiz " la chu nhat"
	mon: .asciiz " la thu hai"
	tue: .asciiz " la thu ba"
	wed: .asciiz " la thu tu"
	thu: .asciiz " la thu nam"
	fri: .asciiz " la thu sau"
	sat: .asciiz " la thu bay"
	# can 
	arrCan: .word can1, can2, can3, can4, can5, can6, can7, can8, can9, can10
	giap: .asciiz "Giap"
	at: .asciiz "At"
	binh: .asciiz "Binh"
	dinh: .asciiz "Dinh"
	mau: .asciiz "Mau"
	ky: .asciiz "Ky"
	canh: .asciiz "Canh"
	tan: .asciiz "Tan"
	nham: .asciiz "Nham"
	quy: .asciiz "Quy"
	# chi
	arrChi: .word chi1, chi2, chi3, chi4, chi5, chi6, chi7, chi8, chi9, chi10, chi11, chi12
	ty: .asciiz "Ty"
	suu: .asciiz "Suu"
	dan: .asciiz "Dan"
	mao: .asciiz "Mao"
	thin: .asciiz "Thin"
	ty.: .asciiz "Ty."
	ngo: .asciiz "Ngo"
	mui: .asciiz "Mui"
	than: .asciiz "Than"
	dau: .asciiz "Dau"
	tuat: .asciiz "Tuat"
	hoi: .asciiz "Hoi"
.text
	.globl main
main:
	li $v0,4
	la $a0,title
	syscall

	con:
	la	$a0, time
	jal	Menu

	EOP:
	li	$v0, 10
	syscall
Menu:
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$t0, 4($sp)

	jal	prompt
	sw	$v0, 0($sp)	
	
	li	$v0, 4
	la	$a0, menu
	syscall
	la	$a0, option
	syscall

	la $v0, 5
	syscall
	
	addi	$v0, $v0, -1
	sll	$v0, $v0, 2
	la	$t0, menutable
	add	$t0, $t0, $v0
	lw	$t0, ($t0)
	jr	$t0
o1:	
	jal	Notification
	lw	$a0, ($sp)
	li	$v0, 4
	syscall
	j Menu.break
o2:
	li	$v0, 4
	la	$a0, type
	syscall

	li	$v0, 12
	syscall

	lw 	$a0, ($sp)
	move 	$a1, $v0
	jal 	convert
	sw 	$v0, ($sp)

	jal Notification
		
	li	 $v0, 4
	lw 	$a0, ($sp)
	syscall
	j Menu.break
	
o3:
	jal	Notification
	lw 	$a0, ($sp)
 	jal	year
	move	$a0, $v0
	li	$v0, 1
	syscall

	lw	$a0, ($sp)
	jal	leapyear
	beq	$v0, $0, o3.khongnhuan
	la	$a0, leap
	li	$v0, 4
	syscall
	j	Menu.break
o3.khongnhuan:
	la	$a0, notleap
	li	$v0, 4
	syscall
	j	Menu.break
	
o4:
	jal	Notification

	lw 	$a0, ($sp)
	li	$v0, 4
	syscall

	lw	$a0, ($sp)
	jal	weekday
	move	$a0, $v0
	li	$v0, 4
	syscall
	j	Menu.break
o5:
	la	$a0, time_2
	jal	RataDieDay
	move	$a1, $v0
	
	lw	$a0, ($sp)
	jal	RataDieDay
	move	$a0, $v0

	sub	$a0, $a0, $a1
	addi 	$a0,$a0,1	# cong sai so
	bgt	$a0, $zero,o5.printf
	li	$t0, -1
	mult	$a0, $t0
	mflo	$a0
	j 	o5.printf
o5.printf:
	move	 $t0,$a0
	jal	 Notification
	
	li	 $v0,4
	la 	$a0, prompt4
	syscall
	
	la 	$a0, time_2
	li 	$v0, 4
	syscall
	
	li 	$v0,4
	la 	$a0, prompt5
	syscall
	
	la	$a0, time
	li 	$v0, 4
	syscall
	
	li 	$v0,4
	la 	$a0, prompt6
	syscall
	
	move	$a0,$t0
	li 	$v0,1
	syscall
	
	li 	$v0,4
	la	 $a0, prompt7
	syscall
	
	j	Menu.break
o6:
	jal Notification
	lw	$a0, ($sp)
	jal 	year
	move	$a0,$v0
	li	$v0,1
	syscall
	
	li	$v0,4
	la	$a0, prompt11
	syscall

	lw	$a0, ($sp)
	jal	CanChi
	
	la 	$a0 , p_canchi
	li 	$v0, 4
	syscall

	j	Menu.break
o7:
	la	$a0, time_1
	jal	prompt
	move	$a0, $v0
	jal	RataDieDay
	move	$a1, $v0

	lw	$a0, ($sp)
	jal	RataDieDay
	move	$a0, $v0
	
	sub	$a0, $a0, $a1
	bgt	$a0, $zero,o7.printf
	li	$t0, -1
	mult	$a0, $t0
	mflo	$a0
	j 	o7.printf
o7.printf:
	move	 $t0,$a0
	jal	 Notification
	
	li	 $v0,4
	la 	$a0, prompt4
	syscall
	
	la 	$a0, time
	li 	$v0, 4
	syscall
	
	li 	$v0,4
	la 	$a0, prompt5
	syscall
	
	la	$a0, time_1
	li 	$v0, 4
	syscall
	
	li 	$v0,4
	la 	$a0, prompt6
	syscall
	
	move	$a0,$t0
	li 	$v0,1
	syscall
	
	li 	$v0,4
	la	 $a0, prompt7
	syscall
	
	j	Menu.break
	
o8:
	lw	$a0, 0($sp)
	jal	leapyear # 1: nam nhuan, 0: ko phai nam nhuan
	move	$t0, $v0 
	
	jal	year
	move	$a0, $v0
	
	bne	$t0, $0, o8.leapyear 

	li	$t0, 4		
	div	$v0, $t0	# 2019 mod 4 = 3
	mfhi	$v0
	li 	$t0,4	
	sub	$t0, $t0, $v0	
	add 	$a0,$a0,$t0	# 2019 - (4-1) = 2020
	j 	o8.leapyear
o8.leapyear:
	move	$t0, $a0
	jal Notification
	
	li $v0,4
	la $a0, prompt8 
	syscall
	
	la $a0, time
	jal year
	
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,4
	la $a0, prompt9 
	syscall

	move $a0,$t0	
	addi	$a0, $a0, -4	
	li	$v0, 1
	syscall
	
	li $v0,4
	la $a0, prompt10 
	syscall
	
	move $a0,$t0
	addi	$a0, $a0,4	
	li	$v0, 1
	syscall
	j	Menu.break

o9:
	Menu.break:
	lw	$ra, 8($sp)
	lw	$t0, 4($sp)
	lw	$v0, 0($sp)

	addi	$sp, $sp, 12
	jr 	$ra

#------------------------------------------------------------
prompt:
	addi	$sp, $sp, -36 
	sw	$ra, 32($sp)
	sw	$a0, 28($sp)
	sw	$t0, 24($sp)
	sw	$t1, 20($sp)
	sw	$t2, 16($sp)
	sw	$a0, 12($sp)
	sw	$a1, 8($sp)
	sw	$a2, 4($sp)
	sw	$a3, 0($sp)

prompt_again:
	li	$v0, 4
	la	$a0, prompt1
	syscall
	
	la	$v0, 8
	la	$a0, p_day
	li	$a1, 3	
	syscall
	move	$t0, $a0

	li	$v0, 4
	la	$a0, prompt2
	syscall
	
	la	$v0, 8
	la	$a0, p_month
	li	$a1, 3	
	syscall
	move	$t1, $a0

	li	$v0, 4
	la	$a0, prompt3
	syscall
	
	la	$v0, 8
	la	$a0, p_year
	li	$a1, 5
	syscall
	move	$t2, $a0

	lw	$a3, 12($sp)
	move	$a0, $t0 
	move	$a1, $t1
	move	$a2, $t2
	jal	date	
	move	$a0, $v0
	move	$t0, $v0
	jal	checkdate
	bne	$v0, $0, excepted 

	la	$a0, errorMessage
	li	$v0, 4
	syscall
	j	prompt_again


	excepted:
	move	$v0, $t0
		

	lw	$ra, 32($sp)
	lw	$a0, 28($sp)
	lw	$t0, 24($sp)
	lw	$t1, 20($sp)
	lw	$t2, 16($sp)
	lw	$a0, 12($sp)
	lw	$a1, 8($sp)
	lw	$a2, 4($sp)
	lw	$a3, 0($sp)
	addi	$sp, $sp, 36

	jr 	$ra
	
#------------------------------------------------------------	
#--------------Bat dau chuc nang 1---------------------------
date: 
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$a0, 12($sp)
	sw	$a1, 8($sp)
	sw	$a2, 4($sp)
	sw	$a3, 0($sp)


	move	$a0, $a3
	lw	$a1, 12($sp)
	jal	strcpy
	move	$a0, $v0

	li	$t0, 47
	sb	$t0, 2($a0)
	
	la	$a0, 3($a0)
	lw	$a1, 8($sp)
	jal	strcpy
	la	$a0, -3($v0)
	
	li	$t0, 47
	sb	$t0, 5($a0)
	
	la	$a0, 6($a0)
	lw	$a1, 4($sp)
	
	jal	strcpy
	la	$a0, -6($v0)

	move	$v0, $a0
	

	lw	$ra, 16($sp)
	lw	$a0, 12($sp)
	lw	$a1, 8($sp)
	lw	$a2, 4($sp)
	lw	$a3, 0($sp)
	addi	$sp, $sp, 20
	
	jr	$ra
	
#--------------Ket thuc chuc nang 1---------------------------
#---------------------------------------------------------
strcpy:
	addi 	$sp, $sp, -16
	sw	$ra, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$t0, 0($sp)

	la	$s0, ($a0)  
	la	$s1, ($a1) 
LOOP:
	lb 	$t0, 0($s1)
	beq	$t0, $0, END
	sb	$t0, ($s0)
	addi	$s0, $s0, 1
	addi 	$s1, $s1, 1
	j	LOOP
END:
	
	la	$v0, ($a0)


	lw	$ra, 12($sp)
	lw	$s0, 8($sp)
	lw	$s1, 4($sp)
	lw	$t0, 0($sp)
	addi 	$sp, $sp, 16

	jr 	$ra

# --------------------------------------------
#---------------------------------------------------
checkdate:
	addi	$sp, $sp, -32
	sw	$a0, 28($sp)
	sw	$ra, 24($sp)
	sw	$t0, 20($sp)
	sw	$t1, 16($sp)
	sw	$t2, 12($sp)
	sw	$t3, 8($sp)
	sw	$t4, 4($sp)
	sw	$s0, 0($sp)

	jal	day
	move	$t0, $v0
	
	jal	month
	move	$t1, $v0
	
	lw	$a0, 28($sp)
	jal	year
	move	$t2, $v0

	li	$t3, 13
	bge $t1,$t3,invalid  # if(thang>=13)
	
	
	la	$s0, dayOfmonths
	addi	$t4, $t1, -1
	sll	$t4, $t4, 2
	add	$s0, $s0, $t4
	lw	$s0, ($s0)	# s0 = so ngay cua thang do

	li	$t4, 2
	bne	$t1, $t4, checkday	# if (thang != 2) 
	lw	$a0, 28($sp)
	jal	leapyear
	beq	$v0, $0, checkday  		# if (khong la nam nhuan)
	addi	$s0, $s0, 1 # 28 + 1 = 29 tiep tuc kiem tra
	j 	checkday
	checkday:			 
		bgt	$t0, $s0, invalid # ngay nhap > ngay cua thang
		j	valid
	invalid:
		li	$v0, 0
		j	end
	valid:	
		li	$v0, 1
end:
	lw	$a0, 28($sp)
	lw	$ra, 24($sp)
	lw	$t0, 20($sp)
	lw	$t1, 16($sp)
	lw	$t2, 12($sp)
	lw	$t3, 8($sp)
	lw	$t4, 4($sp)
	lw	$s0, 0($sp)
	addi	$sp, $sp, 32

	jr 	$ra
	
#-------------------------------------------------
# --------------------------------------------
day:
	addi 	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$t0, 4($sp)
	sw	$t1, 0($sp)

	lb	$t0, 0($a0)
	addi	$t0, $t0, -48
	
	li	$t1, 10
	mult	$t0, $t1
	mflo	$t0
	
	lb 	$t1, 1($a0)
	addi	$t1, $t1, -48
	add	$t0, $t0, $t1

	move	$v0, $t0

	lw	$ra, 8($sp)
	lw	$t0, 4($sp)
	lw	$t1, 0($sp)
	addi 	$sp, $sp, 12
	
	jr	$ra

# --------------------------------------------
# --------------------------------------------
month:
	addi 	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$a0, 3($a0)
	jal	day
	move	$v0, $v0

	lw	$ra, 0($sp)
	addi 	$sp, $sp, 4
	
	jr	$ra

# --------------------------------------------
# --------------------------------------------

year:
	addi 	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$t0, 4($sp)
	sw	$t1, 0($sp)

	la	$a0, 6($a0)
	jal	day
	move	$t0, $v0
	
	li	$t1, 100
	mult	$t0, $t1
	mflo	$t0

	la	$a0, 2($a0)
	jal	day
	add	$t0, $t0, $v0

	move	$v0, $t0

	lw	$ra, 8($sp)
	lw	$t0, 4($sp)
	lw	$t1, 0($sp)
	addi 	$sp, $sp, 12
	
	jr	$ra

# ------------------------------------------------
# ------------------------------------------------
leapyear:
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$t0, 4($sp)
	sw	$a0, 0($sp)
	
	jal	year
	move	$a0, $v0
	

	li	$t0, 400
	div	$a0, $t0
	mfhi	$t0
	beq 	$t0, $0, true	# du = 0 <=> chia het cho 400 -> true
	
	li	$t0, 4
	div	$a0, $t0
	mfhi	$t0
	bne 	$t0, $0, false	# du != 0 <=> khong chia het 4 -> false		
	
	li	$t0, 100
	div	$a0, $t0
	mfhi	$t0
	beq	$t0, $0, false	# du !=0 <=> khong chia het 100 + chia het 4 -> true
	
	
	true:
		li	$v0, 1
		j	leapyear.break
	false:
		li	$v0, 0
		j	leapyear.break
	
	leapyear.break:
	lw	$ra, 8($sp)
	lw	$t0, 4($sp)
	lw	$a0, 0($sp)
	
	addi	$sp, $sp, 12

	jr	$ra
#------------------------------------------------------------
Notification:
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	
	li $v0,4
	la $a0,notifResusts
	syscall
	
	lw	$ra, ($sp)	
	addi	$sp, $sp, 4
	jr	$ra
#------------------------------------------------------------
#--------------Bat dau chuc nang 2---------------------------
convert:
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$t0, 12($sp)
	sw	$t1, 8($sp)
	sw	$s0, 4($sp)
	sw	$s1, 0($sp)
	
	bne 	$a1, 'A', B  
	# s0 = 'MM'
	la	$s0, p_month
	
	lb	$t0, 3($a0)
	sb	$t0, ($s0)

	lb	$t0, 4($a0)
	sb	$t0, 1($s0)
	
	# s1 = 'DD'
	la	$s1, p_day
	
	lb	$t0, ($a0)
	sb	$t0, ($s1)

	lb	$t0, 1($a0)
	sb	$t0, 1($s1)

	# $a0 = strcpy($a0, $s0)
	la 	$a1, ($s0)
	jal 	strcpy
	move 	$a0, $v0
 
	la	$a0, 3($a0)

	# $a0 = strcpy($a0, $s1)
	la 	$a1, ($s1)
	jal 	strcpy
	la 	$a0, -3($v0)
	j 	convert.break	
B:
	bne	$a1, 'B', C 

	jal	nameOfMonth
	move	$a1, $v0

	move	$a0, $v0
	jal	strlength
	move	$t0, $v0

	la	$a0, convert_time
	jal	strcpy
	move	$a0, $v0

	add	$a0, $a0, $t0
	
	li	$t1, ' '
	sb	$t1, ($a0)
	
	la	$s0, time

	addi	$a0, $a0, 1
	lb	$t1, ($s0)
	sb	$t1, ($a0)

	addi	$a0, $a0, 1
	addi	$s0, $s0, 1
	lb	$t1, ($s0)
	sb	$t1, ($a0)

	addi	$a0, $a0, 1
	li	$t1, ','
	sb	$t1, ($a0)
	
	addi	$a0, $a0, 1
	li	$t1, ' '
	sb	$t1, ($a0)
	
	addi	$a0, $a0, 1
	la	$a1, time
	addi	$a1, $a1, 6
	jal	strcpy


	sub	$a0, $a0, $t0
	addi	$a0, $a0, -5

	j 	convert.break 
C:
	la	$a1, ($a0)	# time
	la	$a0, convert_time
	

	lb	$s0, 0($a1)
	sb	$s0, 0($a0)
	lb	$s0, 1($a1)
	sb	$s0, 1($a0)
	li	$s0, ' '
	sb	$s0, 2($a0)

	la	$a0, time
	jal	nameOfMonth
	move	$a1, $v0
	
	move	$a0, $v0
	jal	strlength
	move	$t0, $v0
	
	la 	$a0, convert_time
	la	$a0, 3($a0)
	jal	strcpy
	la	$a0, -3($v0)
	add	$a0, $a0, $t0
	addi	$a0, $a0, 3

	li	$t1, ','
	sb	$t1, 0($a0)
	
	addi	$a0, $a0, 1
	li	$t1, 32
	sb	$t1, ($a0)
	

	addi	$a0, $a0, 1
	la	$a1, time
	addi	$a1, $a1, 6
	jal	strcpy
	move	$a0, $v0
	
	sub 	$a0, $a0, $t0
	addi	$a0, $a0, -5

	j 	convert.break 	
convert.break:
	move	$v0, $a0
	lw	$ra, 16($sp)
	lw	$t0, 12($sp)
	lw	$t1, 8($sp)
	lw	$s0, 4($sp)
	lw	$s1, 0($sp)
	addi	$sp, $sp, 20

	jr 	$ra


#---------------------------------------------------------
#--------------------------------------------------------
nameOfMonth:
	addi	$sp, $sp, -12 
	sw	$a0, 8($sp)
	sw	$s0, 4($sp)
	sw	$ra, 0($sp)

	jal	month
	addi	$a0, $v0, -1
	
	la	$s0, jump
	sll	$a0, $a0, 2
	add	$a0, $a0, $s0
	lw	$a0, ($a0)
	jr	$a0

m1:
	la	$v0, jan
	j	END_SWITCH
m2:
	la	$v0, feb
j	END_SWITCH
m3:
	la	$v0, mar
m4:
	la	$v0, apr
j	END_SWITCH
m5:	
	la	$v0, may
j	END_SWITCH
m6:	
	la	$v0, jun
j	END_SWITCH
m7:
	la	$v0, jul
j	END_SWITCH
m8:
	la	$v0, aug
j	END_SWITCH
m9:
	la	$v0, sep 
j	END_SWITCH
m10:
	la	$v0, oct
j	END_SWITCH
m11:
	la	$v0, nov
j	END_SWITCH
m12:	
	la	$v0, dec
j	END_SWITCH
END_SWITCH:
	
	lw	$a0, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12 

	jr 	$ra

# -------------------------------------
#---------------------------------------------
strlength:
	addi	$sp, $sp, -12 
	sw	$ra, 8($sp)
	sw	$t0, 4($sp)
	sw	$t1, 0($sp)
	
	li	$t0, 0
continue:
	lb	$t1, ($a0)
	beq	$t1, $0, EOS
	addi	$t0, $t0, 1
	addi	$a0, $a0, 1
	j 	continue
EOS:
	la	$v0, ($t0)

	sw	$ra, 8($sp)
	sw	$t0, 4($sp)
	sw	$t1, 0($sp)
	addi	$sp, $sp, 12 

	jr 	$ra

#-----------------------------------------------
weekday:
	addi 	$sp, $sp, -32
	sw	$ra, 28($sp)
	sw	$a0, 24($sp)
	sw	$t0, 20($sp)
	sw	$t1, 16($sp)
	sw	$t2, 12($sp)
	sw	$t3, 8($sp)
	sw	$t4, 4($sp)
	sw	$s0, 0($sp)
	
	
	jal	year
	move	$t2, $v0

	lw	$a0, 24($sp)
	jal	day
	move	$t0, $v0
	
	lw	$a0, 24($sp)
	jal	month
	move	$t1, $v0

	li	$t3, 3
	slt	$t3, $t1, $t3 
	beq	$t3, $0, congthuc 
	addi	$t1, $t1, 12
	addi	$t2, $t2, -1
	j 	congthuc
congthuc:
	move	$s0, $t0	# $s0 = ngay
	
	li	$t4, 2
	mult	$t1, $t4	# thang * 2
	mflo	$t0		# $t0 = thang * 2

	add	$s0, $s0, $t0	# $s0 = ngay + 2* thang

	addi	$t1, $t1, 1	# $t1 = thang + 1

	li	$t4, 3		
	mult	$t1, $t4	# (thang + 1) * 3
	mflo	$t1		# $t1 = (thang + 1) * 3

	li	$t4, 5
	div	$t1, $t4	# ((thang + 1) * 3) div 5
	mflo	$t1		# $t1 = ((thang + 1) * 3) div 5

	add	$s0, $s0, $t1  	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5
	
	add	$s0, $s0, $t2	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5 + nam
	li	$t4, 4
	div	$t2, $t4	# nam div 4
	mflo	$t2		# $t2 = nam div 4
	
	add	$s0, $s0, $t2 	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5 + nam + nam div 4

	li	$t4, 7
	div	$s0, $t4
	mfhi	$s0

	sll	$s0, $s0, 2
	la	$t0, daysOfWeek
	add	$t0, $t0, $s0
	lw	$t0, ($t0)
	jr	$t0
cn:	
	la	$v0, sun
	j 	EOW
t2:
	la	$v0, mon
	j 	EOW
t3:
	la	$v0, tue
	j 	EOW
t4:
	la	$v0, wed
	j 	EOW
t5:
	la	$v0, thu
	j 	EOW
t6:
	la	$v0, fri
	j 	EOW
t7:
	la	$v0, sat
	j 	EOW
EOW:
	lw	$ra, 28($sp)
	lw	$a0, 24($sp)
	lw	$t0, 20($sp)
	lw	$t1, 16($sp)
	lw	$t2, 12($sp)
	lw	$t3, 8($sp)
	lw	$t4, 4($sp)
	lw	$s0, 0($sp)
	addi 	$sp, $sp, 32
	
	jr	$ra
#---------------------------------------------------
#-------------------------------------------------
# thuat toan tham khao tai https://yvdinesh.quora.com/Rata-Die-Algorithm
RataDieDay:
	addi 	$sp, $sp, -28
	sw	$a0, 24($sp)
	sw	$ra, 20($sp)
	sw	$t0, 16($sp)
	sw	$t1, 12($sp)
	sw	$t2, 8($sp)
	sw	$t3, 4($sp)
	sw	$s0, 0($sp)
	
	jal	day
	move	$t0, $v0

	jal	month
	move	$t1, $v0

	lw	$a0, 24($sp)
	jal	year
	move	$t2, $v0

	
	move	$s0, $t2	# $s0 = year
	
	li	$t3, 365
	mult	$s0, $t3
	mflo	$s0		# $s0 = year*365

	li	$t3, 4
	div	$t2, $t3
	mflo	$t3		# $t3 = year/4
	
	add	$s0, $s0, $t3	# $s0 = year*365+year/4
	
	li	$t3, -100
	div	$t2, $t3
	mflo	$t3		# $t3 = -year/100
	
	add	$s0, $s0, $t3	# $s0 = year*365+year/4-year/100

	li	$t3, 400
	div	$t2, $t3
	mflo	$t3		# $t3 = year/400
	
	add	$s0, $s0, $t3	# $s0 = year*365+year/4-year/100+year/400
	
	li	$t3, 153
	mult	$t1, $t3
	mflo	$t1 		# $t1 = 153*month
	addi	$t1, $t1, -457	# $t1 = 153*month - 457

	li	$t3, 5
	div	$t1, $t3
	mflo	$t1		# $t1 = (153*month - 457)/5

	add	$s0, $s0, $t1	# $s0 = year*365+year/4-year/100+year/400+(153*month - 457)/5
	add	$s0, $s0, $t0	# $s0 = year*365+year/4-year/100+year/400+(153*month - 457)/5 + day

	addi 	$s0, $s0, -306	# $s0 = year*365+year/4-year/100+year/400+(153*month - 457)/5 + day

	move	$v0, $s0

	lw	$a0, 24($sp)
	lw	$ra, 20($sp)
	lw	$t0, 16($sp)
	lw	$t1, 12($sp)
	lw	$t2, 8($sp)
	lw	$t3, 4($sp)
	lw	$s0, 0($sp)
	
	addi 	$sp, $sp, 28

	jr	$ra
#-------------------------------------------------
CanChi:
	addi 	$sp ,$sp, -16
	sw	$ra, ($sp)
	sw	$a1, 4($sp)	
	sw	$t0, 8($sp)
	sw	$t1, 12($sp)
		
	la 	$a0, time

	jal	year
	move	$a1, $v0
		
	jal	 Can
	move	$a1, $v0

	move	$a0, $v0
	jal	strlength
	move	$t0, $v0
	
	la	$a0, p_canchi
	jal	strcpy
	move	$a0, $v0
	
	add	$a0, $a0, $t0
	
	li	$t1, ' '
	sb	$t1, ($a0)
	addi	$t0,$t0,1
	
	la 	$a0, time

	jal	year
	move	$a1, $v0 
	
	jal	Chi
	move	$a1, $v0
	
	la	$a0, p_canchi
	add	$a0, $a0 ,$t0
	
	jal	strcpy
	move	$a0, $v0	
	
	lw	$ra, ($sp)
	lw	$a1, 4($sp)
	lw	$t0, 8($sp)
	lw	$t1, 12($sp)

	addi	$sp ,$sp, 16

	jr	$ra
#-------------------------------------------------
Can:	
	addi	$sp, $sp, -20
	sw	$ra, ($sp)
	sw	$t0, 4($sp)
	sw	$s0, 8($sp)
	sw	$a1, 12($sp)
	sw	$s1, 16($sp)

	la	$s0, arrCan
	addi	$a1,$a1, 6 # nam = name + 6
	li	$t0,10
	div	$a1,$a1,$t0
	mfhi	$s1	# $a1= (nam+6)%10

	
	sll	$s1, $s1, 2
	add	$s1, $s1, $s0
	lw	$s1, ($s1)
	jr	$s1
can1:
	la $v0, giap
	j can.break
can2:
	la $v0, at
	j can.break	
can3:
	la $v0, binh
	j can.break
can4:
	la $v0, dinh
	j can.break
can5:
	la $v0, mau
	j can.break
can6:
	la $v0, ky
	j can.break
can7:
	la $v0, canh
	j can.break
can8:
	la $v0, tan
	j can.break
can9:
	la $v0, nham
	j can.break
can10:
	la $v0, quy
	j can.break
	
can.break:	
	lw	$ra, ($sp)
	lw	$t0, 4($sp)
	lw	$s0, 8($sp)
	lw	$a1, 12($sp)
	lw	$s1, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
#-------------------------------------------------
Chi:	
	addi	$sp, $sp, -16
	sw	$ra, ($sp)
	sw	$t0, 4($sp)
	sw	$s0, 8($sp)
	sw	$s1, 12($sp)

	la	$s0, arrChi
	addi	$a1,$a1, 8 # nam = name + 6
	li	$t0,12
	div	$a1,$a1,$t0
	mfhi	$s1	# $a1= (nam+6)%10

	
	sll	$s1, $s1, 2
	add	$s1, $s1, $s0
	lw	$s1, ($s1)
	jr	$s1
chi1:
	la $v0, ty
	j chi.break
chi2:
	la $v0, suu
	j chi.break
chi3:
	la $v0, dan
	j chi.break
chi4:
	la $v0, mao
	j chi.break
chi5:
	la $v0, thin
	j chi.break
chi6:
	la $v0, ty.
	j chi.break
chi7:
	la $v0, ngo
	j chi.break
chi8:
	la $v0, mui
	j chi.break
chi9:
	la $v0, than
	j chi.break
chi10:
	la $v0, dau
	j chi.break
chi11:
	la $v0, tuat
	j chi.break
chi12:
	la $v0, hoi
	j chi.break
	
chi.break:	
	lw	$ra, ($sp)
	lw	$t0, 4($sp)
	lw	$s0, 8($sp)
	lw	$s1, 12($sp)
	addi	$sp, $sp, 16
	jr	$ra
#-------------------------------------------------