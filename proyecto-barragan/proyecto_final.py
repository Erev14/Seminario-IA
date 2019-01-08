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
import os

'''
pruebas con ncc
(260, 290, 0.9999449334683644)
(323, 372)
'''


def ncc(image: np.ndarray, template: np.ndarray, x: int, y: int) -> float:
    [h, w] = template.shape
    image_sum = 0.0
    template_sum = 0.0
    sum_2 = 0.0

    sub_matrix = image[y:y+h, x:x+w]
    image_sum = np.sum(np.float_power(sub_matrix, 2))
    template_sum = np.sum(np.float_power(template, 2))
    sum_2 = np.sum(np.multiply(sub_matrix, template, dtype=float))

    # print("image_sum", image_sum)
    # print("template_sum", template_sum)
    # print("sum2", sum_2)

    # print("sum", np.sum(np.float_power(sub_matrix, 2)))
    # print("template", np.sum(np.float_power(template, 2)))
    # print("sum2", np.sum(np.multiply(sub_matrix, template, dtype=float)))

    # for i in range(0, w):
    #     for j in range(0, h):
    #         image_sum += float(image[y+j, x+i]**2)
    #         template_sum += float(template[j, i]**2)
    #         sum_2 += float(image[y+j, x+i])*float(template[j, i])
    # print("image_sum", image_sum)
    # print("template_sum", template_sum)
    # print("sum2", sum_2)

    return sum_2/(sqrt(float(image_sum))*sqrt(float(template_sum)))


image = cv.imread('Image_3.bmp')
template = cv.imread('Template.bmp')

image_gray = cv.cvtColor(image, cv.COLOR_RGB2GRAY)
template_gray = cv.cvtColor(template, cv.COLOR_RGB2GRAY)

[image_h, image_w] = image_gray.shape
[template_h, template_w] = template_gray.shape

print(image_h)
print(image_w)
print(template_h)
print(template_w)

val_max = -1
xp = 0
yp = 0


for y in range(0, (image_h-template_h)):
    for x in range(0, (image_w-template_w)):
        val = ncc(image_gray, template_gray, x, y)
        if val > val_max:
            val_max = val
            xp = x
            yp = y

# plt.imshow(image_gray, cmap='gray')
# plt.show()
# plt.imshow(template_gray, cmap='gray')
# plt.show()

# plt.imshow(image, aspect='equal')
# plt.show()
# plt.imshow(template)

# image_result = cv.rectangle(image_gray, (250, 290),
#                             (330, 400), (255, 0, 0), 5)
# image_result = cv.rectangle(image_gray, (250, 290),
#                             (330, 400), (255, 0, 0), -1)

print((xp, yp, val_max))
print((xp+template_w, yp+template_h))
image_result = cv.rectangle(image_gray, (xp, yp),
                            (xp+template_w, yp+template_h), (255, 0, 0), 5)
plt.imshow(image_result, cmap="gray")
plt.show()
