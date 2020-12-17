###Bruteforce solution, looked up help for this one to understand what to do

L = open("inp17.txt","r").read().splitlines()
print (L)

M = set()

for x,l in enumerate(L):
    for y,ch in enumerate(l):
        if ch == '#':
            M.add((x,y,0,0))

for _ in range(6):
    NM = set()
    print(len(M))
    for x in range(min(x for x,y,z,w in M)-1,max(x for x,y,z,w in M)+2):
        for y in range(min(y for x,y,z,w in M)-1,max(y for x,y,z,w in M)+2):
            for z in range(min(z for z,y,z,w in M)-1,max(z for x,y,z,w in M)+2):
                for w in range(min(w for x,y,z,w in M)-1,max(w for x,y,z,w in M)+2):
                    neighbors = 0
                    for nx in [-1,0,1]:
                        for ny in [-1,0,1]:
                            for nz in [-1,0,1]:
                                for nw in [-1,0,1]:
                                    if nx !=0 or ny !=0 or nz != 0 or nw!=0:
                                        if(x+nx,y+ny,z+nz,w+nw) in M:
                                            neighbors+=1
                    if(x,y,z,w) not in M and neighbors == 3:
                        NM.add((x,y,z,w))
                    if(x,y,z,w) in M and neighbors in [2,3]:
                        NM.add((x,y,z,w))
    M = NM
print(len(M))
