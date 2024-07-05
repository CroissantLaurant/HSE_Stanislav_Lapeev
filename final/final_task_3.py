def mono(nums):
    increasing = decreasing = True
    for i in range(1, len(nums)):
        if nums[i] < nums[i-1]:
            increasing = False
        if nums[i] > nums[i-1]:
            decreasing = False
    return increasing or decreasing
if __name__ == '__main__':
    input_str = input("Введите последовательность: ")
    nums = list(map(int, input_str.split()))
    result = mono(nums)
    print(f"Последовательность {'монотонна' if result else 'не монотонна'}")
