addi x18, x18, 0 #a=0
addi x19, x19, 1 #b=1
addi x20, x20, 8 #n=8
bne x20, x0, else_if_label #if !=0
add x21, x0, x18
j exit_else_if

else_if_label:
addi x24, x0, 1 #x24=1
bne x20, x24, else_label #if i!=1 goto else_label
add x21, x0, x19 #fib_n=b
j exit_else_if

else_label:
addi x22, x22, 2 #i=2
start_loop:
bgt x22, x20, exit_loop #if i>n goto exit loop
add x23, x18, x19 #c=a+b
add x18, x0, x19 #a=b
add x19, x0, x23 #b=c
addi x22, x22, 1 #i++
j start_loop
exit_loop:
add x21, x0, x19

exit_else_if:
add x23, x0, x0