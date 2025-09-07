.data
source: .word 3, 1, 4, 1, 5, 9, 0
dest: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
la x18, source # load starting address of spource to x18
la x19, dest # load starting address of dest to x19

add x20, x0, x0 # k=0

start_loop:
slli x21, x20, 2 # x21 = k*4 left shifting by 2 is multiplying by 4
add x22, x18, x21 # x22 = starting address of source + k*4
lw x23, 0(x22) # x23 = source[k]
beq x23, x0, exit_loop

#dest[k] = source[k]
add x24, x19, x21 # x24 = starting address of dest + k*4
sw x23, 0(x24) # dest[k] = x23 = source[k]

addi x20, x20, 1 # k++
j start_loop

exit_loop:
add x0, x0, x0