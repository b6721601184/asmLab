.data 
my_string1 : .string "My fib = : "
my_string2 : .string "My num = : "
new_line : .string "\n" 

.text
main:
addi x18, x0, 4 # my_num = 4
addi x20, x0, 12 # arg = 12

#save my num on stack
addi sp, sp, -4
sw x18, 0(sp) # push my_num on the stack

addi sp, sp, -4
sw x20, 0(sp) # push arg on the stack
jal fib_iter # call fib_iter
add x19, x0, a0 # my_fib = fib_iter(arg)
addi sp, sp, 4 # pop arg from the stack

#restore my num from stack
lw x18, 0(sp) # pop my_num from the stack
addi sp, sp, 4

addi x18, x18, 1 # my_num = my_num + 1

#print my_string1
addi a0, x0, 4 #put code 4 to a0
la a1, my_string1 #put address of my_string1 to a1
ecall

#print my_fib
addi a0,x0, 1 #put code 1 to a0
add a1, x0, x19 #put value of my_fib in a0
ecall

#print new_line
addi a0, x0, 4 #put code 4 to a0
la a1, new_line #put address of new_line to a1
ecall #print new_line

#print my_string2
addi a0, x0, 4 #put code 4 to a0
la a1, my_string2 #put address of my_string2 to a1
ecall

#print my_num
addi a0,x0, 1 #put code 1 to a0
add a1, x0, x18 #put value of my_num in a0
ecall

#print new_line
addi a0, x0, 4 #put code 4 to a0
la a1, new_line #put address of new_line to a1
ecall #print new_line

# exit sys call
addi a0, x0, 10 # exit call OS emulation
add a1, x0, x0 # exit call OS emulation
ecall # exit call OS emulation

fib_iter:
lw x21 , 0(sp) # arg = n
addi x18, x0, 0 # curr_fib = 0
addi x19, x0, 1 # next_fib = 1
add x22, x0, x21 # i = n

start_loop:
ble x22, x0, exit_loop # if x22 <= x0 then exit_loop
add x20, x18, x19 # temp = curr_fib + next_fib
add x18, x0, x19 # curr_fib = next_fib
add x19, x0, x20 # next_fib = temp
addi x22, x22, -1 # i--
j start_loop
exit_loop:
add a0, x0, x18 # return curr_fib in a0
jr ra # return

