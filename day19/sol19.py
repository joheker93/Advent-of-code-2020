from lark import Lark


##Constructing a context free grammar to parse with lark

[ruleP1,inpP1] = open('inp19.txt','r').read().split('\n\n')
[ruleP2,inpP2] = open('inp19p2.txt','r').read().split('\n\n')

def go(ruleP,inpP):
        inpstrs = inpP.splitlines()
        gram = ''
        for rule in ruleP.splitlines():

                k, v = rule.split(':')
                ks = ''
                for digs in k:
                        ks+= 'w' + digs

                if ks == 'w0':
                        ks = 'start'
                vs = ks + ':'
                for val in v:
                        if val.isdigit():
                                vs+= 'w' + val
                        else:
                                vs = vs + val
                gram += vs + '\n'

        p = Lark(gram,parser='earley')
        count = 0
        for s in inpstrs:
                try:
                        p.parse(s)
                        count +=1
                except: pass
        return count

print(go(ruleP1,inpP1))
print(go(ruleP2,inpP2))
