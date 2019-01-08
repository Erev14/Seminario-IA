
"""
Seminario de Solucion de Problemas de Inteligencia Artificial 1
Mejia Blanco Erick  211408613
Practica 1
"""

f = lambda x: (4 * x**3) + (15 * x**2) + (8 * x) - 4
fi = lambda x: (12 * x**2) + (30 * x) + 8


def newtonRaphson(f: staticmethod, fi: staticmethod,x: float) -> float:
    xi = x
    xii = 0

    for i in range(0, 50):
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

# print([float('%g' % x) for x in seq(-4, 2, 0.1)])

res = [ newtonRaphson(f, fi, x) for x in drange(-4, 2, 0.1) ]

print('='*50)
print(res)

print(list(map(lambda x: fi(x),res)))

print(newtonRaphson(f=lambda x: x * x - 2, fi=lambda x: 2 * x, x=1))

# def drange(start, stop, step):
#     r = start
#     while r < stop:
#         print(r)
#         yield r
#         r += step

# i0=drange(-4.0, 2.0, 0.1)

# print(["%g" % x for x in i0])

# print(newtonRaphson(f, fi, -4))

# x=10
# y=2
# a = [p/x for p in range(-4, int(x*y))]
# print(a)
# [0.0, 0.01, 0.02, 0.03, ..., 1.97, 1.98, 1.99]
