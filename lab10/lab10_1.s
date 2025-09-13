.data 
my_string : .string "Hello, World!"
new_line : .string "\n"

.text
main: 
addi x18,x0, 10 #x = 10

#print my_string
addi a0, x0, 4 #put code 4 to a0
la a1, my_string #put address of my_string to a1
ecall 

#print new_line
addi a0, x0, 4 #put code 4 to a0        
la a1, new_line #put address of new_line to a1
ecall #print new_line

#print x
addi a0,x0, 1 #put code 1 to a0
add a1, x0, x18 #put value of x in a0
ecall

#print new_line
addi a0, x0, 4 #put code 4 to a0
la a1, new_line #put address of new_line to a1
ecall #print new_line

#exit with code zero
addi a0, x0, 10 #put code 10 to a0
add a1, x0, x0 #put exit code 0 to a1
ecall #exit
