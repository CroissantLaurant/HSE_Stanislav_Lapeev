roman_num = {'CM': 900, 'CD': 400, 'XC': 90, 'XL': 40, 'IX': 9, 'IV': 4, 'M': 1000, 'D': 500, 'C': 100, 'L': 50, 'X': 10, 'V': 5, 'I': 1}

def to_arab(s):
    total = 0
    prev_value = 0
    for char in reversed(s):
        value = roman_num[char]
        if value < prev_value:
            total -= value
        else:
            total += value
        prev_value = value
    return total

if __name__ == '__main__':
    roman_numeral = input("Введите римское число: ")
    result = to_arab(roman_numeral)
    print(f"Римское число {roman_numeral}, по-арабски: {result}")
