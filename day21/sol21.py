import re
table = {}
ingred_all = []
for line in open('inp21.txt','r').read().splitlines():
    x = re.fullmatch(r"([\w ]+)\(contains ([\w, ]+)\)",line)
    ingredients = x.group(1).split()
    allergens = x.group(2).replace(' ','').split(',')
    for i in ingredients:
        ingred_all.append(i)
    for allergen in allergens:
        if allergen in table:
            table[allergen] = [x for x in table[allergen] if x in ingredients]
        else:
            table[allergen] = ingredients

print(table)
for i,_ in enumerate(ingred_all):
    for t in table:
       if len(table[t]) == 1:
            for j in table:
                if table[t][0] in table[j] and j != t:
                    table[j].remove(table[t][0])

bads = [i for i in ingred_all if i not in [y for x in list(table.values()) for y in x if y == x[0]]]
print(len(bads))
print(','.join([x for y in sorted(table.keys()) for x in table[y]]))
