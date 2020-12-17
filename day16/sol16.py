import re
ranges = []
your = []
others = []
c = 0

##Part 1
for line in open("inp16.txt","r").read().splitlines():
    x = re.fullmatch(r"([\D\s]+): (\d+)-(\d+) or (\d+)-(\d+)",line)
    if x:
        ranges.append((int(x.group(2)),int(x.group(3))))
        ranges.append((int(x.group(4)),int(x.group(5))))

    y = re.search(r"your ticket:([\d+,]+)",line)
    if y:
        your = y.string[12:].split(',')
    z = re.fullmatch(r"([\d+,]+)",line)
    if z:
        others.append(z.string.split(','))

dic = {}
for l,r in ranges:
    for i in range(l,r):
        dic[i] = True

nots = []
for y in your:
    if (not int(y) in dic):
        nots.append(y)

for o in others:
    for k in o:
        if(int(k) not in dic):
            nots.append(k)

print (sum([int(c) for c in nots]))

