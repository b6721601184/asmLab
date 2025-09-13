.data 
my_string : .string "Result is: "
new_line : .string "\n"

.text

main:
# call fact(10)
addi sp, sp, -4 # allocate 4 bytes on the stack
li x19, 10 # x19=10
sw x19, 0(sp) # push x19(10) on the stack
jal ra, fact # call fact
addi sp, sp, 4 # deallocate 4 bytes on the stack
mv x18, a0 # result = fact

#print my_string
addi a0, x0, 4 #put code 4 to a0
la a1, my_string #put address of my_string to a1
ecall

#print result in x18
addi a0,x0, 1 #put code 1 to a0
add a1, x0, x18 #put value of result in a0
ecall

#print newline
addi a0, x0, 4
la a1, new_line
ecall

# exit sys call
addi a0, x0, 10 # exit call OS emulation
add a1, x0, x0 # exit call OS emulation
ecall # exit call OS emulation

fact:
lw x18, 0(sp)
bne x18, x0, recursive_part # if n != 0 return to recursive part
li a0, 1
jr ra

recursive_part:
#save ra on the stack
addi sp, sp, -4
sw ra, 0(sp)

#save n on to the stack
addi sp, sp, -4
sw x18, 0(sp)

#fact n-1
addi x20, x18, -1  #x20 = n-1
addi sp, sp, -4
sw x20, 0(sp)
jal fact
add x21, x0, a0 #get result from fact and put it to temp (x21)
addi sp, sp, 4 #deallocate 4 bytes from the stack

#restore n from the stack
lw x18, 0(sp)
addi sp, sp, 4  #deallocate 4 bytes from the stack
mul x19, x21, x18 #result = fact n-1 * n

#return result 
add a0, x0, x19 #put result in x19 to a0

#restore ra from the stack and return
lw ra, 0(sp)
addi sp, sp, 4
jr ra

