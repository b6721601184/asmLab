addi x18, x0, 10 #n=10
addi x19, x0, 0 #sum=0
addi x20, x0, 0 #i=0
start_loop:
bge x20, x18, exit_loop #if i>=n goto exit_loop
add x19, x9, x20 #sum = sum+i
addi x19, x19, 1 #sum=sum+i+1
addi x20, x20, 1 #i++
j start_loop
exit_loop:
addi x18, x18, 1 #n++