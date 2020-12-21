import numpy as np

def borders(grid):
    bords = []
    for i in range(4):
        grid  = np.rot90(grid)
        bords.append(grid[0].tolist())

    grid = np.flipud(grid).tolist()

    for i in range(4):
        grid = np.rot90(grid).tolist()
        bords.append(grid[0])
    return bords

grids = []
for l in open('inp20.txt','r').read().split('\n\n'):
    tile = l.splitlines()[0]
    grid = [list(sub) for sub in l.splitlines()[1:]]
    grids.append((tile,grid))


### PART 1
count = 0
counts = []

for tile,grid in grids:
    bords = borders(grid)
    for tile2,grid2 in grids:
        bords2 = borders(grid2)
        for b1 in bords:
            for b2 in bords2:
                if b1 == b2 and tile != tile2:
                    count+=1
    counts.append((tile,count))
    count = 0


print(np.prod([int(t[5:-1]) for t,_ in sorted(counts,key=lambda x:x[1])][:4]))
