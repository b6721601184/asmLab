.data 
my_string : .string "Result is: "
new_line : .string "\n"

.text

main:
# call foo(3,5)
ddi sp, sp, -8 # allocate 8 bytes on the stack
li x20, 3 # x20=3
sw x20, 0(sp) # push x20(3) on the stack
li x21, 5 # x21=5
sw x21, 4(sp) # push x21(5) on the stack
jal ra, foo # call foo
addi sp, sp, 8 # deallocate 8 bytes on the stack
mv x18, a0 # result = foo

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

foo:
addi sp, sp, -8
sw ra, 4(sp) # save return address
# load args from caller's frame
lw x18, 8(sp) # arg1 = x
lw x19, 12(sp) # arg2 = n
li x21, 0 # x21/sum = 0
li x20, 0 # x20/i = 0

start_loop:
bge x20, x19, end_loop # if i >= arg2 goto end_loop
add x21, x21, x18 # sum = sum + arg1
addi x20, x20, 1 # i = i + 1
j start_loop # goto start_loop

end_loop:
# call foo_bar(10) and add to sum
addi sp, sp, -4 # allocate stack space
li x22, 10 # x22/bar_arg = 10
sw x22, 0(sp) # push bar_arg on the stack
jal ra, foo_bar # call foo_bar
addi sp, sp, 4 # deallocate stack space

add x21, x21, a0 # sum = sum + foo_bar(bar_arg)
lw ra, 4(sp) # restore return address
addi sp, sp, 8 # pop frame
mv a0, x21 # return sum in a0
jr ra # return

foo_bar:
lw x18, 0(sp) # load first argument from stack x18 = n
li x19, 0 # x19/sum = 0
li x20, 0 # x20/i = 0

start_loop_bar:
bge x20, x18, end_loop_bar # if i >= n goto end_loop_bar
addi x20, x20, 1 # i = i + 1
add x19, x19, x20 # sum += i

j start_loop_bar
end_loop_bar:
mv a0, x19
jr ra








