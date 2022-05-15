


def getLong(longitude):
    return 10 + ((90 - 10) / (2.464319 - 2.228314)) * (longitude - 2.228314)

def getLat(latitude):
    return 10 + ((90 - 10) / (48.946111 - 48.768769)) * (latitude - 48.768769)



print(getLong(2.36496559829082))
print(getLat(48.8199024461617))


print(getLong(2.36930823722325))
print(getLat(48.8213573623076))
