




def func_1_factorial(number: int) -> int | float:
    start = 1
    result = 1
    for i in range(number):
        result = result * start
        start += 1
    return result




def func_2_max_number(*args) -> int | float:
    max_ = 0
    for i in args:
        if i > max_:
            max_ = i
    return max_




def func_3_triangle_square(leg_1: int, leg_2: int) -> int | float:
    return (leg_1 * leg_2) / 2




def task_1():
    a, b, c = 15, randint(1, 99), randint(1, 99)
    print(f"Факториал числа a({a}) - {func_1_factorial(a)}")
    print(f"Из чисел a = {a}, b = {b}, c = {c} самое большое - {func_2_max_number(a, b, c)}")
    print(f"Из чисел a = {a}, b = {b}, c = {c} самое большое - {max((a, b, c))}")
    print(f"Катет a = {a} см, катет b = {b} см, площадь треугольника равна - {func_3_triangle_square(a, b)}")

