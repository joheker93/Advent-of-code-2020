import re
##PARSING
memVals = []
for line in open("inp14.txt").read().splitlines():

    x = re.fullmatch(r"mask = ([10X]+)",line)
    if x:
        mask = (x.group(1))
    x = re.fullmatch(r"mem\[(\d+)\] = (\d+)",line)
    if x:
        mem = x.group(1)
        val = x.group(2)
        memVals.append((mask,mem,val))

##PART 1
mems = {}

def calc(mask,val):
    r = ""
    z = zip(mask,val)
    for top, bot in z:
        if top == "1" or top == "0":
            r = r + top
        elif top == "X":
            r = r + bot
    return r

for mask, mem, val in memVals:
    nv = calc(mask,format(int (val),"036b"))
    mems[mem] = nv

for k in mems:
    mems[k] = int(mems[k],2)

print(sum(mems.values()))

## PART 2
from itertools import product

def calc2(mask,val):
    r = ""
    z = zip(mask,val)
    for top, bot in z:
        if(top == '0'):
            r = r + bot
        else:
            r = r + top
    return r

mems2 = {}
for mask, mem, val in memVals:
    nv = calc2(mask,format(int(mem),"036b"))
    inpval = calc(mask,format(int(val),"036b"))
    seq = list(nv)
    ls = ['X']
    ind = [i for i, c in enumerate(seq) if c in ls]
    local = []
    for t in product (['1','0'], repeat=len(ind)):
        for i, c in zip(ind,t):
            seq[i] = c
        local.append(''.join(seq))

    for m in local:
        mems2[m] = int(val)

print (sum([r  for r in mems2.values()]))
