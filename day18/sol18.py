## Shunting yard algorithm for expressions
## p1 runs with same precedence on operators
## p2 runs with precedence + > precedence *

def p1precedence(op):
    if op == '+' or op == '*':
        return 1
    return 0

def p2precedence(op):
    if op == '+':
        return 2
    if op == '*':
        return 1

    return 0

def evaluate(tokens,prec):
    values = []
    ops = []
    i = 0

    while i < len(tokens):
        if tokens[i] == '(':
            ops.append(tokens[i])

        elif tokens[i].isdigit():
            val = 0

            while (i < len(tokens) and tokens[i].isdigit()):

                val = (val * 10) + int(tokens[i])
                i += 1

            values.append(val)
            i-=1

        elif tokens[i] == ')':

            while len(ops) != 0 and ops[-1] != '(':
                val2 = values.pop()
                val1 = values.pop()
                op = ops.pop()
                res = 0
                if op =='+': res = val1+val2
                if op =='*': res = val1*val2
                values.append(res)

            ops.pop()

        else:
            while (len(ops) != 0 and prec(ops[-1]) >= prec(tokens[i])):

                val2 = values.pop()
                val1 = values.pop()
                op = ops.pop()
                if op =='+': res = val1+val2
                if op =='*': res = val1*val2

                values.append(res)

            ops.append(tokens[i])

        i += 1

    while len(ops) != 0:
        val2 = values.pop()
        val1 = values.pop()
        op = ops.pop()
        if op =='+' :res = val1+val2
        if op == '*':res = val1*val2
        values.append(res)

    return values[-1]

p1 = []
p2 = []
for line in open('inp18.txt','r').read().replace(' ','').splitlines():
    p1.append(evaluate(line,p1precedence))
    p2.append(evaluate(line,p2precedence))

print(sum(p1))
print(sum(p2))
