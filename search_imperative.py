
def search(array, number):
    length = len(array)
    found = False

    for i in range(length):
        if number == array[i]:
            found = True
    
    return found


if __name__ == "__main__":

    input = [1,2,3,4,5]
    element = 5
    res = search(input, element)
    print(res)