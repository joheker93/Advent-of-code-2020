EMP = 'L'
OCC = '#'
FLR = '.'

###PART 1
def adjacent(row, column, grid):
    for x in range(row - 1, row + 2):
        for y in range(column - 1, column + 2):
            if 0 <= x < len(grid) and 0 <= y < len(grid[0]) and (x, y) != (row, column):
                yield grid[x][y]

seats = open("inp11.txt","r").read().splitlines()

grid = seats
while True:
  new = []
  for r in range (len(grid)):
      new_line = []
      for c in range (len(grid[r])):
          seat = grid[r][c]
          near = [i for i in adjacent(r,c,grid)]
          if seat == 'L' and near.count('#') == 0:
              new_line.append('#')
          elif seat == '#' and near.count('#') >= 4:
              new_line.append('L')
          else:
              new_line.append(seat)
      new.append(new_line)
  if grid == new:
      print(sum(i.count('#') for i in new))
      break
  grid = new


###PART 2
def visible(row, column, grid):
    for x in range(-1, 2):
        for y in range(-1, 2):
            i = 1
            while 0 <= row + i * x < len(grid) and 0 <= column + i * y < len(grid[0]) and not x == y == 0:
                if grid[row + i * x][column + i * y] != '.':
                    yield grid[row + i * x][column + i * y]
                    break
                i += 1

seats = open('inp11.txt').read().splitlines()

grid = seats
while True:
  new = []
  for r in range (len(grid)):
      new_line = []
      for c in range (len(grid[r])):
          seat = grid[r][c]
          near = [i for i in visible(r,c,grid)]
          if seat == 'L' and near.count('#') == 0:
              new_line.append('#')
          elif seat == '#' and near.count('#') >= 5:
              new_line.append('L')
          else:
              new_line.append(seat)
      new.append(new_line)
  if grid == new:
      print(sum(i.count('#') for i in new))
      break
  grid = new

