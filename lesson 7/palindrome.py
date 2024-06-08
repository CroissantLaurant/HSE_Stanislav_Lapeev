
def is_palindrome(x: int) -> bool:
    return str(x) == str(x)[::-1] if x >= 0 else False


print(is_palindrome(123454321))
