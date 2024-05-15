import copy
import matplotlib.pyplot as plt
from .auxiliary_methods import intersect, set2Decimal
from .constants import Axis
from matplotlib.patches import Rectangle
import mpl_toolkits.mplot3d.art3d as art3d
import numpy as np
import math


START_POSITION = [0, 0, 0]
DEFAULT_NUMBER_OF_DECIMALS = 0


#denyInfo : 1(크기 넘침), 2(무게 넘침
class Item:
    def __init__(self, name, WHD, weight, target, floor=0, denyInfo=0, originDepth = 0):
        self.name = name
        self.width = WHD[0]
        self.height = WHD[1]
        self.depth = WHD[2]
        self.weight = weight
        self.position = START_POSITION
        self.number_of_decimals = DEFAULT_NUMBER_OF_DECIMALS
        self.target = target
        self.floor = floor
        self.denyInfo = denyInfo
        self.originDepth = originDepth

    def formatNumbers(self, number_of_decimals):
        ''' '''
        self.width = set2Decimal(self.width, number_of_decimals)
        self.height = set2Decimal(self.height, number_of_decimals)
        self.depth = set2Decimal(self.depth, number_of_decimals)
        self.weight = set2Decimal(self.weight, number_of_decimals)
        self.number_of_decimals = number_of_decimals

    def getVolume(self):
        return set2Decimal(self.width * self.height * self.depth, self.number_of_decimals)

    def getArea(self):
        return set2Decimal(self.width * self.height, self.number_of_decimals)

    def getDimension(self):
        return [self.width, self.height, self.depth]

    def getWeight(self):
        return self.weight


class Bin:
    def __init__(self, WHD, max_weight):
        self.width = WHD[0]
        self.height = WHD[1]
        self.depth = WHD[2]
        self.max_weight = max_weight
        self.items = []
        self.unfitted_items = []
        self.number_of_decimals = DEFAULT_NUMBER_OF_DECIMALS
        # used to put gravity distribution
        self.gravity = []
        self.maxBoxSize = []

    def formatNumbers(self, number_of_decimals):
        self.width = set2Decimal(self.width, number_of_decimals)
        self.height = set2Decimal(self.height, number_of_decimals)
        self.depth = set2Decimal(self.depth, number_of_decimals)
        self.max_weight = set2Decimal(self.max_weight, number_of_decimals)
        self.number_of_decimals = number_of_decimals

        def getVolume(self):
            return set2Decimal(
                self.width * self.height * self.depth, self.number_of_decimals
            )
    def string(self):
        return "(%sx%sx%s, max_weight:%s) vol(%s)" % (
            self.width, self.height, self.depth, self.max_weight,
            self.getVolume()
        )

    def getVolume(self):
        return set2Decimal(
            self.width * self.height * self.depth, self.number_of_decimals
        )

    def getTotalWeight(self):
        total_weight = 0
        for item in self.items:
            total_weight += item.weight
        return set2Decimal(total_weight, self.number_of_decimals)

    def putItem(self, item, pivot, ib=None,axis=None):
        valid_item_position = item.position
        item.position = pivot
        dimension = item.getDimension()
        #범위 검사
        if(
                pivot[0] < 0 or
                self.width < pivot[0] + dimension[0] or
                self.height < pivot[1] + dimension[1] or
                self.depth < pivot[2] + dimension[2]
        ):
            item.denyInfo = 1
            return False

        fit = True
        # 박스 크기 검사
        for current_item_in_bin in self.items:
            if intersect(current_item_in_bin, item):
                fit = False
                item.denyInfo = 1
                break

        if fit:
            #무게 검사
            if self.getTotalWeight() + item.weight > self.max_weight:
                fit = False
                item.denyInfo = 2
                return fit

            if fit:
                if(axis is None):
                    item.floor = 1
                elif(axis == 0):
                    item.floor = ib.floor + 1
                else:
                    item.floor = ib.floor
                self.items.append(copy.deepcopy(item))
                item.denyInfo = 0

        else:
            item.position = valid_item_position

        return fit

    def clearBin(self):
        ''' clear item which in bin '''
        self.items = []
        self.fit_items = np.array([[0, self.width, 0, self.height, 0, 0]])
        self.unfitted_items = []
        return

class Packer:
    def __init__(self):
        self.bins = []
        self.items = []
        self.unfit_items = []
        self.total_items = 0
        self.floorVolume =0

    def addBin(self, bin):
        return self.bins.append(bin)

    def addItem(self, item):
        self.total_items = len(self.items) + 1
        return self.items.append(item)

    def pack2Bin(self, bin, item):
        fitted = False
        # first put item on (0,0,0) , if corner exist ,first add corner in box.
        if not bin.items:
            response = bin.putItem(item, START_POSITION)

            if not response:
                bin.unfitted_items.append(item)
            return
        sameItem = []
        for bin_item in bin.items:
            if bin_item.target == item.target:
                sameItem.append(bin_item)
        if sameItem:
            for axis in range(0, 4):
                items_in_bin = sameItem
                for ib in items_in_bin:
                    pivot = [0, 0, 0]
                    w, h, d = ib.getDimension()
                    if axis == Axis.WIDTH:
                        # print(ib.name, "의 옆으로", item.name, "를 적재")
                        pivot = [ib.position[0] + w, ib.position[1], ib.position[2]]
                    elif axis == Axis.HEIGHT:
                        # print(ib.name, "의 앞으로", item.name, "를 적재")
                        pivot = [ib.position[0], ib.position[1] + h, ib.position[2]]
                    elif axis == Axis.DEPTH:
                        # print(ib.name, "의 위로", item.name)
                        pivot = [ib.position[0], ib.position[1], ib.position[2] + d]
                    elif axis == Axis.LEFT:
                        # print(ib.name, "의 왼쪽으로", item.name)
                        pivot = [ib.position[0]-item.width, ib.position[1] , ib.position[2]]

                    if bin.putItem(item, pivot, ib, axis):
                        fitted = True
                        break
                if fitted:
                    break
        else:
            baseItem = []
            for bin_item in bin.items:
                if bin_item.floor == 1:
                    baseItem.append(bin_item)
            items_in_bin = baseItem
            for axis in range(1,4):
                for ib in items_in_bin:
                    pivot = [0, 0, 0]
                    w, h, d = ib.getDimension()
                    if axis == Axis.WIDTH:
                        # print(ib.name, "의 옆으로", item.name, "를 적재")
                        pivot = [ib.position[0] + w, ib.position[1], ib.position[2]]
                    elif axis == Axis.HEIGHT:
                        # print(ib.name, "의 앞으로", item.name, "를 적재")
                        pivot = [ib.position[0], ib.position[1] + h, ib.position[2]]
                    elif axis == Axis.LEFT:
                        # print(ib.name, "의 왼쪽으로", item.name, "를 적재, 밑의 공간 : ", ib.target, "쌓으려는 공간: ", item.target)
                        pivot = [ib.position[0] - item.width, ib.position[1], ib.position[2]]
                    if bin.putItem(item, pivot, ib, axis):
                        fitted = True
                        break
                if fitted:
                    break
        if not fitted:
            bin.unfitted_items.append(item)

    def pack2Bin2(self, bin, item):
        fitted = False
        # first put item on (0,0,0) , if corner exist ,first add corner in box.
        if not bin.items:
            response = bin.putItem(item, START_POSITION)

            if not response:
                bin.unfitted_items.append(item)
            return

        for axis in range(0, 4):
            items_in_bin = bin.items
            for ib in items_in_bin:
                pivot = [0, 0, 0]
                w, h, d = ib.getDimension()
                if axis == Axis.DEPTH:
                    # print(ib.name, "의 위로", item.name)
                    pivot = [ib.position[0], ib.position[1], ib.position[2] + d]
                elif axis == Axis.WIDTH:
                    # print(ib.name, "의 옆으로", item.name, "를 적재")
                    pivot = [ib.position[0] + w, ib.position[1], ib.position[2]]
                elif axis == Axis.LEFT:
                    # print(ib.name, "의 왼쪽으로", item.name)
                    pivot = [ib.position[0]-item.width, ib.position[1], ib.position[2]]
                elif axis == Axis.HEIGHT:
                    # print(ib.name, "의 앞으로", item.name, "를 적재")
                    pivot = [ib.position[0], ib.position[1] + h, ib.position[2]]

                if bin.putItem(item, pivot, ib, axis):
                    fitted = True
                    break
            if fitted:
                break
        if not fitted:
            bin.unfitted_items.append(item)

    def pack(self, number_of_decimals=DEFAULT_NUMBER_OF_DECIMALS):
        self.items.sort(key=lambda item: (-item.target, item.weight, -item.getArea()))

        for idx, bin in enumerate(self.bins):
            # pack item to bin
            for item in self.items:
                self.pack2Bin(bin, item)

        flag = False
        for item in self.bins[0].unfitted_items:
            #범위를 초과하여 적재를 못한 물품이 있는지 검사
            if item.denyInfo == 1:
                flag = True
                break
        if flag:
            print("!!!!!!!!!!!!!!!!!2번째 로직 실행!!!!!!!!!!!!!!!!!!!!!!!")
            self.bins[0].clearBin()
            for item in self.items:
                self.pack2Bin2(self.bins[0], item)

    def pack2(self, number_of_decimals=DEFAULT_NUMBER_OF_DECIMALS):
        totalVolume = 0.0
        maxDepth = self.get_item_with_max_depth()
        # Decimal로 변경
        for item in self.items:
            item.formatNumbers(number_of_decimals)
            totalVolume += float(item.getVolume())

        totalVolume = math.ceil(totalVolume / 10) * 10
        # totalVolume /= float(self.items[0].getVolume())
        self.bins[0].originDepth = self.bins[0].depth

        floor = math.ceil(totalVolume/self.floorVolume)*1.8
        self.bins[0].depth = maxDepth * floor if maxDepth * floor < self.bins[0].depth else self.bins[0].depth

        # Item : sorted by volumn -> sorted by loadbear -> sorted by level -> binding
        self.items.sort(key=lambda item: (-item.target, -item.getArea(), item.weight))

        for idx, bin in enumerate(self.bins):
            # pack item to bin
            for item in self.items:
                self.pack2Bin2(bin, item)
        self.bins[0].depth = self.bins[0].originDepth

    def get_item_with_max_depth(self):
        if not self.items:
            return None
        # max() 함수를 사용하여 items 리스트에서 가장 깊이가 큰 Item을 찾습니다.
        item = max(self.items, key=lambda item: item.depth)
        rCnt = 0
        cCnt = 0
        for row in range(item.width, self.bins[0].width, item.width):
            rCnt += 1
        for col in range(item.height, self.bins[0].height, item.height):
            cCnt += 1
        self.floorVolume = item.width * item.height * item.depth * rCnt * cCnt
        return item.depth
class Painter:

    def __init__(self, bins):
        self.items = bins.items
        self.width = bins.width
        self.height = bins.height
        self.depth = bins.depth

    def _plotCube(self, ax, x, y, z, dx, dy, dz, color='red', mode=2, linewidth=1, text="", fontsize=15, alpha=0.5):
        xx = [x, x, x + dx, x + dx, x]
        yy = [y, y + dy, y + dy, y, y]

        kwargs = {'alpha': 1, 'color': color, 'linewidth': linewidth}
        if mode == 1:
            ax.plot3D(xx, yy, [z] * 5, **kwargs)
            ax.plot3D(xx, yy, [z + dz] * 5, **kwargs)
            ax.plot3D([x, x], [y, y], [z, z + dz], **kwargs)
            ax.plot3D([x, x], [y + dy, y + dy], [z, z + dz], **kwargs)
            ax.plot3D([x + dx, x + dx], [y + dy, y + dy], [z, z + dz], **kwargs)
            ax.plot3D([x + dx, x + dx], [y, y], [z, z + dz], **kwargs)
        else:
            p = Rectangle((x, y), dx, dy, fc=color, ec='black', alpha=alpha)
            p2 = Rectangle((x, y), dx, dy, fc=color, ec='black', alpha=alpha)
            p3 = Rectangle((y, z), dy, dz, fc=color, ec='black', alpha=alpha)
            p4 = Rectangle((y, z), dy, dz, fc=color, ec='black', alpha=alpha)
            p5 = Rectangle((x, z), dx, dz, fc=color, ec='black', alpha=alpha)
            p6 = Rectangle((x, z), dx, dz, fc=color, ec='black', alpha=alpha)

            ax.add_patch(p)
            ax.add_patch(p2)
            ax.add_patch(p3)
            ax.add_patch(p4)
            ax.add_patch(p5)
            ax.add_patch(p6)

            if text != "":
                ax.text((x + dx / 2), (y + dy / 2), (z + dz / 2), str(text), color='black', fontsize=fontsize,
                        ha='center', va='center')

            art3d.pathpatch_2d_to_3d(p, z=z, zdir="z")
            art3d.pathpatch_2d_to_3d(p2, z=z + dz, zdir="z")
            art3d.pathpatch_2d_to_3d(p3, z=x, zdir="x")
            art3d.pathpatch_2d_to_3d(p4, z=x + dx, zdir="x")
            art3d.pathpatch_2d_to_3d(p5, z=y, zdir="y")
            art3d.pathpatch_2d_to_3d(p6, z=y + dy, zdir="y")

    def plotBoxAndItems(self, title="", alpha=1.0, write_num=False, fontsize=10):
        """ side effective. Plot the Bin and the items it contains. """
        fig = plt.figure()
        axGlob = plt.axes(projection='3d')

        # Remove grid
        axGlob.grid(False)

        # plot bin
        self._plotCube(axGlob, 0, 0, 0, float(self.width), float(self.height), float(self.depth), color='black', mode=1,
                       linewidth=2, text="")

        counter = 0
        for item in self.items:
            x, y, z = item.position
            [w, h, d] = item.getDimension()
            if(item.floor <= 1.0):
                color = "#0000FF"
            elif(item.floor<=2.0):
                color = "#00FF00"
            else:
                color = "#FF0000"
            text = item.name if write_num else ""

            self._plotCube(axGlob, float(x), float(y), float(z), float(w), float(h), float(d), color=color, mode=2,
                               text=text, fontsize=fontsize, alpha=alpha)

            counter = counter + 1

        plt.title(title)
        self.setAxesEqual(axGlob)

        # Adjust view angle
        # axGlob.view_init(elev=0, azim=90)  # 예시: elev=30, azim=60 값을 원하는 대로 변경
        axGlob.view_init(elev=30, azim=60)
        return plt

    def setAxesEqual(self, ax):
        x_limits = ax.get_xlim3d()
        y_limits = ax.get_ylim3d()
        z_limits = ax.get_zlim3d()

        x_range = abs(x_limits[1] - x_limits[0])
        x_middle = np.mean(x_limits)
        y_range = abs(y_limits[1] - y_limits[0])
        y_middle = np.mean(y_limits)
        z_range = abs(z_limits[1] - z_limits[0])
        z_middle = np.mean(z_limits)

        plot_radius = 0.5 * max([x_range, y_range, z_range])

        ax.set_xlim3d([x_middle - plot_radius, x_middle + plot_radius])
        ax.set_ylim3d([y_middle - plot_radius, y_middle + plot_radius])
        ax.set_zlim3d([z_middle - plot_radius, z_middle + plot_radius])