[t,b] = open('inp13.txt','r').read().splitlines()
stamp  = int (t)
stripbusses = [int(s) for s in b.split(',') if s.isdigit()]
xbusses = b.split(',')

def runPast(goal, source):
    ns = source
    while(ns < goal):
        ns+=source

    diff = abs(goal - ns)
    return (diff,source)


### PART 1
l = []

for bs in stripbusses:
    l.append(runPast(stamp,bs))

(x,y) = sorted(l,key = lambda x : x[0])[0]
print (x*y)


### PART 2:
t,s = 0,1
p2 = [(int(i), j) for j, i in enumerate(xbusses) if i != 'x']
for id, min in p2:
    while(t+min) % id != 0:
        t+=s
    s*=id

print(t)


