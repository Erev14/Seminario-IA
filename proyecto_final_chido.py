#!/usr/local/bin/python3
'''
SSPIA1 Proyecto Final: función de correlación cruzada
Mejia Blanco Erick 211408613
'''

import numpy as np
import matplotlib.pyplot as plt
from math import sqrt
from random import random
import cv2 as cv


def diferential_evolution(fobj, bounds, mut=0.8, crossp=0.7, popsize=20, its=1000) -> (list, float):
    dimensions = len(bounds)
    pop = np.random.rand(popsize, dimensions)
    min_b, max_b = np.asarray(bounds).T
    diff = np.fabs(min_b - max_b)
    pop_denorm = min_b + pop * diff
    fitness = np.asarray([fobj(ind) for ind in pop_denorm])
    best_idx = np.argmin(fitness)
    best = pop_denorm[best_idx]
    for i in range(its):
        for j in range(popsize):
            idxs = [idx for idx in range(popsize) if idx != j]
            a, b, c = pop[np.random.choice(idxs, 3, replace=False)]
            mutant = np.clip(a + mut * (b - c), 0, 1)
            cross_points = np.random.rand(dimensions) < crossp
            if not np.any(cross_points):
                cross_points[np.random.randint(0, dimensions)] = True
            trial = np.where(cross_points, mutant, pop[j])
            trial_denorm = min_b + trial * diff
            f = fobj(trial_denorm)
            if f < fitness[j]:
                fitness[j] = f
                pop[j] = trial
                if f < fitness[best_idx]:
                    best_idx = j
                    best = trial_denorm
        yield best, fitness[best_idx]


def ncc(image: np.ndarray, template: np.ndarray, x: int, y: int) -> float:
    [h, w] = template.shape
    image_sum = 0.0
    template_sum = 0.0
    sum_2 = 0.0

    sub_matrix = image[y:y+h, x:x+w]
    image_sum = np.sum(np.float_power(sub_matrix, 2))
    template_sum = np.sum(np.float_power(template, 2))
    sum_2 = np.sum(np.multiply(sub_matrix, template, dtype=float))

    return sum_2/(sqrt(float(image_sum))*sqrt(float(template_sum)))


def fobj(ncc, image: np.ndarray, template: np.ndarray):
    return lambda vars: ncc(image=image, template=template, x=int(vars[1]), y=int(vars[0]))


image = cv.imread('Image_3.bmp')
template = cv.imread('Template.bmp')
image_gray = cv.cvtColor(image, cv.COLOR_RGB2GRAY)
template_gray = cv.cvtColor(template, cv.COLOR_RGB2GRAY)
[image_h, image_w] = image_gray.shape
[template_h, template_w] = template_gray.shape

bounds = [(0, image_h - template_h), (0, image_w - template_w)]

val_max = -1
xp = 0
yp = 0

algo = fobj(ncc=ncc, image=image_gray, template=template_gray)

print(bounds)
print([(image_h, image_w), (template_h, template_w)])
print(algo([260, 290]))


it = list(diferential_evolution(fobj=fobj(ncc=ncc, image=image_gray,
                                          template=template_gray), bounds=bounds, its=1000))

print(it[-1])
bst, fitnes = it[-1]
print('bst', bst)
print('fitnes', fitnes)
val_max = fitnes
xp = int(bst[0])
yp = int(bst[1])

print((xp, yp))
print((xp+template_w, yp+template_h))
image_result = cv.rectangle(image_gray, (xp, yp),
                            (xp+template_w, yp+template_h), (255, 0, 0), 5)
plt.imshow(image_result, cmap="gray")
plt.show()
