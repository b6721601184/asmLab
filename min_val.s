.data
arr: .word 64, 25, 12, 22, 11, 3, 12, 55, 4, 28

.text
la   x18, arr          # base address of arr
addi x19, x0, 10       # n = 10

# min_val = arr[0]
lw   x21, 0(x18)       # x21 = min_val
addi x20, x0, 1        # i = 1

start_loop:
  bge  x20, x19, exit_loop   # if i >= n exit

  slli x22, x20, 2           # offset = i*4
  add  x23, x18, x22
  lw   x24, 0(x23)           # x24 = arr[i]

  blt  x24, x21, update_min  # if arr[i] < min_val, update
  j    cont

update_min:
  mv   x21, x24              # min_val = arr[i]

cont:
  addi x20, x20, 1           # i++
  j    start_loop

exit_loop:
# x21 contains the min value
addi x0, x0, 0            # end of program

