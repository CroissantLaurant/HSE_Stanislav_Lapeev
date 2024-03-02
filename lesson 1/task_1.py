
a = 1
b = 2.0
c = True


d = "hello"


e = [1, 2, 3, 4, 5]
f = (1, 2, 3, 4, 5)
g = {1, 2, 3, 4, 5}


h = {1: 2, 3: 4}


id(a)


print("hi")




a = input("Введите число: ")


if a.isdigit():
    seconds = int(a)
    minutes = seconds
    hours = minutes / 60
    print(seconds)
    print(minutes)
    print(hours)
else:
    print("Ошибка, вводите цифры")



a = input("Введите число от 1 до 9: ")


if a.isdigit() and 0 < int(a) < 10:
    b = int(a) + int(a+a) + int(a+a+a)
    print(b)
else:
    print("Ошибка, вы ввели некорректную информацию")