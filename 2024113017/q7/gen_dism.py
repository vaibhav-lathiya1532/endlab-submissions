for num in range(100000):
    num_str = str(num)
    num_dis = 0
    num_len = 1
    for j in num_str:
        num_dis += (int(j)**num_len)
        num_len += 1
    if num == num_dis:
        print(num)
