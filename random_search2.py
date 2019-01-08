#!/usr/local/bin/python3
from random import random
from matplotlib import pyplot as plot
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

"""
Seminario de Solucion de Problemas de Inteligencia Artificial 1
Mejia Blanco Erick  211408613
Ejercicio 3
"""
'''
|x_best= 2.083412042675219|
|y_best= 2.083412042675219|
|f_best= 0.013915137726505097|
'''


def seq(start: int, stop: int, step: int or float = 1) -> [float]:
    '''
    Give a range with can use float ranges
    '''
    n: int = int(round((stop - start)/float(step)))

    if n > 1:
        return [start + step*i for i in range(n+1)]
    elif n == 1:
        return [start]
    else:
        return []


def drange(start: int, stop: int, step: int or float = 1) -> [float]:
    '''
    Give an array range with decimal presition of one digit
    '''
    return [float('%g' % x) for x in seq(start, stop, step)]


def f(x: int or float, y: int or float) -> float: return (x-2)**2 + (y-2)**2


f_best: int = 9999999
x_best: int or float = 0
y_best: int or float = 0

x_l: int = -5
x_u: int = 5
y_l: int = -5
y_u: int = 5

for i in range(0, 100):
    r: float = random()
    x: float = x_l + (x_u - x_l)*r
    y: float = x_l + (x_u - x_l)*r
    f_val: float = f(x, y)

    if f_val < f_best:
        f_best = f_val
        x_best = x
        y_best = y

print(
    '|x_best= {x}| |y_best= {y}| |f_best= {f}|'.format_map({
        'x': x_best,
        'y': y_best,
        'f': f_best
    })
)

x = np.arange(x_l, x_u, 0.2)
y = np.arange(y_l, y_u, 0.2)

z: [float] = [f(x[i], y[i]) for i in range(0, (len(x) + len(y))//2)]
fig = plot.figure()
ax = Axes3D(fig)

# ax.plot_surface(x, y, z)

plot.show()
