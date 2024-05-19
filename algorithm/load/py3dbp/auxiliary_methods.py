from decimal import Decimal
from .constants import Axis


def rectIntersect(item1, item2, x, y):
    d1 = item1.getDimension()
    d2 = item2.getDimension()

    cx1 = item1.position[2 if x == 3 else x] + d1[2 if x == 3 else x] / 2
    cy1 = item1.position[2 if y == 3 else y] + d1[2 if y == 3 else y] / 2
    cx2 = item2.position[2 if x == 3 else x] + d2[2 if x == 3 else x] / 2
    cy2 = item2.position[2 if y == 3 else y] + d2[2 if y == 3 else y] / 2

    ix = max(cx1, cx2) - min(cx1, cx2)
    iy = max(cy1, cy2) - min(cy1, cy2)
    return ix < (d1[2 if x == 3 else x]+d2[2 if x == 3 else x])/2 and iy < (d1[2 if y == 3 else y]+d2[2 if y == 3 else y])/2



def intersect(item1, item2):
    return (
        rectIntersect(item1, item2, Axis.WIDTH, Axis.HEIGHT) and
        rectIntersect(item1, item2, Axis.HEIGHT, Axis.DEPTH) and
        rectIntersect(item1, item2, Axis.WIDTH, Axis.DEPTH)
    )


def getLimitNumberOfDecimals(number_of_decimals):
    return Decimal('1.{}'.format('0' * number_of_decimals))

def set2Decimal(value, number_of_decimals=0):
    number_of_decimals = getLimitNumberOfDecimals(number_of_decimals)
    #사용할 소수 자릿수
    return Decimal(value).quantize(number_of_decimals)