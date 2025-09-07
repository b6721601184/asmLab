.text
.globl main

main:
    # call foo(3,5)
    addi sp, sp, -8   # allocate 8 bytes on the stack
    li   x20, 3    # x20=3
    sw   x20, 0(sp) # push x20(3) on the stack
    li   x21, 5    # x21=5
    sw   x21, 4(sp) # push x21(5) on the stack
    jal  ra, foo  # call foo
    addi sp, sp, 8   # deallocate 8 bytes on the stack
    mv   x18, a0      # result1 = foo

    #save result1 on the stack
    addi sp, sp, -4   # allocate 4 bytes on the stack
    sw   x18, 0(sp) # push result1 on the stack

    # call foo(4,12)
    addi sp, sp, -8   # allocate 8 bytes on the stack
    li   x20, 4    # x20=4
    sw   x20, 0(sp) # push x20(4) on the stack
    li   x21, 12   # x21=12
    sw   x21, 4(sp) # push x21(12) on the stack
    jal  ra, foo  # call foo
    addi sp, sp, 8   # deallocate 8 bytes on the stack
    mv   x19, a0      # result2 = foo

    #restore result1 from the stack
    lw   x18, 0(sp) # load result1 from stack
    addi sp, sp, 4   # deallocate 4 bytes on the stack

    # result1 = result1 + result2
    add  x18, x18, x19

    # exit sys call
    addi a0, x0, 10 # exit call OS emulation
    add  a1, x0, x0 # exit call OS emulation
    ecall           # exit call OS emulation

foo:
    lw   x18, 0(sp) # load first argument from stack x18 = arg1/x
    lw   x19, 4(sp) # load second argument from stack x19 = arg2/n
    li   x21, 0  # x21/sum = 0
    li   x20, 0   # x20/i = 0

    start_loop:
        bge  x20, x19, end_loop # if i >= arg2 goto end_loop
        add  x21, x21, x18      # sum = sum + arg1
        addi x20, x20, 1        # i = i + 1
        j    start_loop         # goto start_loop

    end_loop:
        mv   a0, x21            # return sum in a0
        jr   ra                 # return