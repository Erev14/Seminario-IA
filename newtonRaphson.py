import math
def newtonRaphson(f: staticmethod, fi: staticmethod, x: float, iterate: int) -> float:
    xi = x
    xii = 0

    for i in range(0, iterate):
        if(fi(xi) == 0):
            return None
        xii = xi - (f(xi) / fi(xi))
        xi = xii

    return xii

def seq(start: int, stop: int, step: int or float = 1) -> [float]:
    n = int(round((stop - start)/float(step)))
    if n > 1:
        return([start + step*i for i in range(n+1)])
    elif n == 1:
        return([start])
    else:
        return([])

def drange(start: int, stop: int, step: int or float = 1) -> [float]:
    return [float('%g' % x) for x in seq(start, stop, step)]

def operate(f, fi, start: int, stop:int, iterate: int, step: int or float = 1):
    ceros = []
    count = 0
    for x in drange(start, stop, step):
        res = newtonRaphson(f, fi, x, iterate)
        print(res)
        if res != None:
            if count > 0:
                if round(ceros[count - 1], 5) != round(res, 5):
                    if res not in ceros:
                        ceros.append(res)
                        count += 1
            else:
                ceros.append(res)
                count += 1

    ceros.sort()
    print(ceros)

    for n in ceros:
        generate = fi(n)
        print(generate)
        if generate > 0:
            print("minimo")
        elif generate < 0:
            print("maximo")

f = lambda x: (4 * x**3) + (15 * x**2) + (8 * x) - 4
fi = lambda x: (12 * x**2) + (30 * x) + 8
operate(f,fi, -4, 1, 50, 0.1)

f = lambda x: (2 * math.cos(2 * x))
fi = lambda x: (-4 * math.sin(2 * x))
operate(f,fi, -4, 4, 20, 1)


# sin x + x cosx -5 5
# f = lambda x: ((2 * math.cos(x)) - (x * math.sin(x)))
# fi = lambda x: ((-3 * math.sin(x)) - x * math.cos(x))
# operate(f,fi, -5, 5, 50, .5)
