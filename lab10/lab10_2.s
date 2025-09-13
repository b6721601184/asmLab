.data 
my_string : .string "iteration"
new_line : .string "\n"

.text
main: addi x18,x0, 0 #i = 0
start_loop:
addi x19, x0, 5 #temp(x19) = 5
bge x18, x19, exit_loop

#print iteration
addi a0, x0, 4 #put code 4 to a0
la a1, my_string #put address of iteration to a1
ecall 

#print i 
addi a0,x0, 1 #put code 1 to a0
add a1, x0, x18 #put value of i in a0
ecall

#print new_line
addi a0, x0, 4 #put code 4 to a0        
la a1, new_line #put address of new_line to a1
ecall #print new_line

addi x18, x18, 1 # i++
j start_loop

exit_loop:
#exit with code zero
addi a0, x0, 10 #put code 10 to a0
add a1, x0, x0 #put exit code 0 to a1
ecall #exit