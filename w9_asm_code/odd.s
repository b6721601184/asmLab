main:
# is_odd(53)
li   x19, 222    # x19=53
addi sp sp -4   # allocate 4 bytes on the stack
sw   x19,0 (sp) # push x19 9=53) on the stack
jal  is_odd     # call is_odd
addi sp, sp, 4  # deallocate 4 bytes on the stack

# result = is_odd
add  x18, x0 ,a0

# exit cleanly
addi a0, x0, 10 # exit call OS emulation
add  a1, x0, x0 # exit call OS emulation
ecall           # exit call OS emulation

is_odd:
lw   x18, 0(sp)
andi x19, x18, 0x1       # temp1 = x & 0x1
li   x20, 1              # temp2 = 1
bne  x19, x20, else_part # if temp1 != temp2 (temp1 != 1) goto else_part
li   a0, 1               # true returm 1
jr   ra
else_part:
li   a0, 0
jr   ra                  #false return 0