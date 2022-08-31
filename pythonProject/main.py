# disclaimer! first ever time using python :I

def printStars():
    print('Python task1:')
    numRows = int(input('enter number of rows: '))
    maxLength = 2 * numRows + 1
    for i in range(numRows):
        numStarToPrint = 1 + 2 * i
        string = (maxLength // 2 - i - 1) * ' ' + '*' * numStarToPrint
        print(string)


def printSum():
    print('Python task2:')
    string = input('type text here : ')
    stringArr = string.split()
    numArr = []
    for text in stringArr:
        if text.isnumeric():
            numArr.append(int(text))

    result = 0

    for i in numArr:
        result += i

    print(len(numArr), 'integers found!')
    print('Sum -', result)


printStars()
printSum()
