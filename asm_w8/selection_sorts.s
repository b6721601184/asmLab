.data
arr: .word 64, 25, 12, 22, 11, 3, 12, 55, 4, 28

.text
la   x18, arr          # base address of arr
addi x19, x0, 10       # n = 10

addi x20, x0, 0        # i = 0
start_loop_i:
    addi x24, x19, -1 
    bge  x20, x24, end_loop_i   # if i >= n-1 exit
    add  x23, x20, x0           # min_index = i
    
    addi x21, x20, 1            # j = i+1
    
    start_loop_j:
        bge  x21, x19, end_loop_j   # if j >= n → exit inner loop

        # load arr[j] into t1
        slli t0, x21, 2         # t0 = j * 4
        add  t0, x18, t0        # t0 = &arr[j]
        lw   t1, 0(t0)          # t1 = arr[j]

        # load arr[min_idx] into t3
        slli t2, x23, 2         # t2 = min_idx * 4
        add  t2, x18, t2        # t2 = &arr[min_idx]
        lw   t3, 0(t2)          # t3 = arr[min_idx]

        # compare arr[j] < arr[min_idx] ?
        bge  t1, t3, skip_update
        add  x23, x21, x0       # min_idx = j
        
        skip_update:
        addi x21, x21, 1        # j++
        j    start_loop_j

    end_loop_j:
    
    # Perform swap between arr[i] and arr[min_index]
    slli t0, x20, 2            # t0 = i * 4
    add  t0, x18, t0           # t0 = &arr[i]
    lw   t1, 0(t0)            # t1 = arr[i]
    
    slli t2, x23, 2           # t2 = min_idx * 4
    add  t2, x18, t2          # t2 = &arr[min_index]
    lw   t3, 0(t2)            # t3 = arr[min_index]
    
    sw   t3, 0(t0)            # arr[i] = arr[min_index]
    sw   t1, 0(t2)            # arr[min_index] = arr[i]
    
    addi x20, x20, 1          # i++
    j    start_loop_i

end_loop_i:
