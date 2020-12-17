
l = [0,14,1,3,7,9]
s = l[len(l) - 1]
turn = len(l)+1
d = {}
print(d)
for i in range(0,len(l)):
    d[l[i]] = (i+1,i+1)

print (d)
#### Change to <= 2020 for part1
while (turn <=30000000):

    guess = s
    low,high = d[guess]
    if low == high:
        s = 0
        if s in d:
            slow,shigh = d[s]
            d[s] = (shigh,turn)
        else:
            d[s] = (turn,turn)
    elif low != high:
        s = high - low
        if s in d:
            slow2,shigh2 = d[s]
            d[s] = (shigh2,turn)
        else:
            d[s] = (turn,turn)
    turn+=1

print(s)

