nums = [2, 7, 0, 9, 1, 5, 8]

target = 4


def sum_of_two(nums, target):
    answer = 'No elements'
    for i in range(len(nums) - 1):
        for j in range(i + 1, len(nums) - 1):
            if target == nums[i] + nums[j]:
                answer = 'Elements: ' + str(i) + ' and ' + str(j)
    return answer


print(sum_of_two(nums, target))
