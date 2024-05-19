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


# denyInfo : 1(크기 넘침), 2(무게 넘침
class Item:
    def __init__(self, name, WHD, weight, target, floor=0, denyInfo=0, originDepth=0):
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
        self.fit_items = np.array([[0, WHD[0], 0, WHD[1], 0, 0]])
        self.unfitted_items = []
        self.number_of_decimals = DEFAULT_NUMBER_OF_DECIMALS
        # used to put gravity distribution
        self.gravity = []
        self.maxBoxSize = []
        # 밑에 상자가 지지해야할 비율
        self.support_surface_ratio = 0
        self.fix_point = True
        self.check_stable = True

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

    def putItem(self, item, pivot, ib=None, axis=None):
        valid_item_position = item.position
        item.position = pivot
        dimension = item.getDimension()
        # 범위 검사
        if (
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
            # 무게 검사
            if self.getTotalWeight() + item.weight > self.max_weight:
                fit = False
                item.denyInfo = 2
                return fit

            if fit:
                if (axis is None):
                    item.floor = 1
                elif (axis == 0):
                    item.floor = ib.floor + 1
                else:
                    item.floor = ib.floor
                self.items.append(copy.deepcopy(item))
                item.denyInfo = 0

        else:
            item.position = valid_item_position

        return fit

    def putItem3(self, item, pivot):
        valid_item_position = item.position
        item.position = pivot
        dimension = item.getDimension()
        # 범위 검사
        if (
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
            # 무게 검사
            if self.getTotalWeight() + item.weight > self.max_weight:
                fit = False
                item.denyInfo = 2
                return fit

            # fix point float prob
            if self.fix_point:

                [w, h, d] = dimension
                [x, y, z] = [float(pivot[0]), float(pivot[1]), float(pivot[2])]
                if item.name == "e":
                    print("hello")
                for i in range(3):
                    # fix height
                    y = self.checkHeight([x, x + float(w), y, y + float(h), z, z + float(d)])
                    # fix width
                    x = self.checkWidth([x, x + float(w), y, y + float(h), z, z + float(d)])
                    # fix depth
                    z = self.checkDepth([x, x + float(w), y, y + float(h), z, z + float(d)])

                # check stability on item
                # rule :
                # 1. Define a support ratio, if the ratio below the support surface does not exceed this ratio, compare the second rule.
                # 2. If there is no support under any vertices of the bottom of the item, then fit = False.
                if self.check_stable:
                    # Cal the surface area of item.
                    item_area_lower = int(dimension[0] * dimension[1])
                    # Cal the surface area of the underlying support.
                    support_area_upper = 0
                    for i in self.fit_items:
                        # Verify that the lower support surface area is greater than the upper support surface area * support_surface_ratio.
                        if z == i[5]:
                            area = len(set([j for j in range(int(x), int(x + int(w)))]) & set(
                                [j for j in range(int(i[0]), int(i[1]))])) * \
                                   len(set([j for j in range(int(y), int(y + int(h)))]) & set(
                                       [j for j in range(int(i[2]), int(i[3]))]))
                            support_area_upper += area

                    # 규칙 1: 지지 비율 규칙 검사
                    item_ratio = support_area_upper / item_area_lower
                    if item_ratio < self.support_surface_ratio:
                        four_vertices = [[x, y], [x + float(w), y], [x, y + float(h)], [x + float(w), y + float(h)]]
                        #  If any vertices is not supported, fit = False.
                        c = [False, False, False, False]
                        for i in self.fit_items:
                            if z == i[5]:
                                for jdx, j in enumerate(four_vertices):
                                    if (i[0] <= j[0] <= i[1]) and (i[2] <= j[1] <= i[3]):
                                        c[jdx] = True
                        if False in c:
                            item.position = valid_item_position
                            fit = False
                            return fit
                if item.name == "a":
                    print("hello")
                self.fit_items = np.append(self.fit_items,
                                           np.array([[x, x + float(w), y, y + float(h), z, z + float(d)]]), axis=0)
                item.position = [set2Decimal(x), set2Decimal(y), set2Decimal(z)]

            if fit:
                self.items.append(copy.deepcopy(item))
                item.denyInfo = 0

        else:
            item.position = valid_item_position

        return fit

    def checkDepth(self, unfix_point):
        ''' fix item position z '''
        z_ = [[0, 0], [float(self.depth), float(self.depth)]]
        for j in self.fit_items:
            # creat x set
            x_bottom = set([i for i in range(int(j[0]), int(j[1]))])
            x_top = set([i for i in range(int(unfix_point[0]), int(unfix_point[1]))])
            # creat y set
            y_bottom = set([i for i in range(int(j[2]), int(j[3]))])
            y_top = set([i for i in range(int(unfix_point[2]), int(unfix_point[3]))])
            # find intersection on x set and y set.
            if len(x_bottom & x_top) != 0 and len(y_bottom & y_top) != 0:
                z_.append([float(j[4]), float(j[5])])
        top_depth = unfix_point[5] - unfix_point[4]
        # find diff set on z_.
        z_ = sorted(z_, key=lambda z_: z_[1])
        for j in range(len(z_) - 1):
            if z_[j + 1][0] - z_[j][1] >= top_depth:
                return z_[j][1]
        return unfix_point[4]

    def checkWidth(self, unfix_point):
        ''' fix item position x '''
        x_ = [[0, 0], [float(self.width), float(self.width)]]
        for j in self.fit_items:
            # creat z set
            z_bottom = set([i for i in range(int(j[4]), int(j[5]))])
            z_top = set([i for i in range(int(unfix_point[4]), int(unfix_point[5]))])
            # creat y set
            y_bottom = set([i for i in range(int(j[2]), int(j[3]))])
            y_top = set([i for i in range(int(unfix_point[2]), int(unfix_point[3]))])
            # find intersection on z set and y set.
            if len(z_bottom & z_top) != 0 and len(y_bottom & y_top) != 0:
                x_.append([float(j[0]), float(j[1])])
        top_width = unfix_point[1] - unfix_point[0]
        # find diff set on x_bottom and x_top.
        x_ = sorted(x_, key=lambda x_: x_[1])
        for j in range(len(x_) - 1):
            if x_[j + 1][0] - x_[j][1] >= top_width:
                return x_[j][1]
        return unfix_point[0]

    def checkHeight(self, unfix_point):
        '''fix item position y '''
        y_ = [[0, 0], [float(self.height), float(self.height)]]
        for j in self.fit_items:
            # creat x set
            x_bottom = set([i for i in range(int(j[0]), int(j[1]))])
            x_top = set([i for i in range(int(unfix_point[0]), int(unfix_point[1]))])
            # creat z set
            z_bottom = set([i for i in range(int(j[4]), int(j[5]))])
            z_top = set([i for i in range(int(unfix_point[4]), int(unfix_point[5]))])
            # find intersection on x set and z set.
            if len(x_bottom & x_top) != 0 and len(z_bottom & z_top) != 0:
                y_.append([float(j[2]), float(j[3])])
        top_height = unfix_point[3] - unfix_point[2]
        # find diff set on y_bottom and y_top.
        y_ = sorted(y_, key=lambda y_: y_[1])
        for j in range(len(y_) - 1):
            if y_[j + 1][0] - y_[j][1] >= top_height:
                return y_[j][1]

        return unfix_point[2]

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
        self.floorVolume = 0

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
                        pivot = [ib.position[0] - item.width, ib.position[1], ib.position[2]]

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
            for axis in range(1, 4):
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
                    pivot = [ib.position[0] - item.width, ib.position[1], ib.position[2]]
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

    def pack2Bin3(self, bin, item, support_surface_ratio):
        ''' pack item to bin '''
        fitted = False
        bin.support_surface_ratio = support_surface_ratio

        # first put item on (0,0,0) , if corner exist ,first add corner in box.
        if not bin.items:
            response = bin.putItem3(item, item.position)

            if not response:
                bin.unfitted_items.append(item)
            return

        for axis in range(0, 3):
            items_in_bin = bin.items
            for ib in items_in_bin:
                pivot = [0, 0, 0]
                w, h, d = ib.getDimension()
                if axis == Axis.WIDTH:
                    pivot = [ib.position[0] + w, ib.position[1], ib.position[2]]
                elif axis == Axis.DEPTH:
                    pivot = [ib.position[0], ib.position[1], ib.position[2] + d]
                elif axis == Axis.HEIGHT:
                    pivot = [ib.position[0], ib.position[1] + h, ib.position[2]]

                if bin.putItem3(item, pivot):
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
            # 범위를 초과하여 적재를 못한 물품이 있는지 검사
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

        floor = math.ceil(totalVolume / self.floorVolume) * 1.8
        self.bins[0].depth = maxDepth * floor if maxDepth * floor < self.bins[0].depth else self.bins[0].depth

        # Item : sorted by volumn -> sorted by loadbear -> sorted by level -> binding
        self.items.sort(key=lambda item: (-item.target, -item.getArea(), item.weight))

        for idx, bin in enumerate(self.bins):
            # pack item to bin
            for item in self.items:
                self.pack2Bin2(bin, item)
        self.bins[0].depth = self.bins[0].originDepth

    def pack3(self, support_rate, number_of_decimals=DEFAULT_NUMBER_OF_DECIMALS):
        # Decimal로 변경
        for item in self.items:
            item.formatNumbers(number_of_decimals)
        # Item : sorted by volumn -> sorted by loadbear -> sorted by level -> binding
        self.items.sort(key=lambda item: (-item.target, -item.getArea(), item.weight))

        for idx, bin in enumerate(self.bins):
            # pack item to bin
            for item in self.items:
                self.pack2Bin3(bin, item, support_rate)

    def get_item_with_max_depth(self):
        if not self.items:
            return None
        # max() 함수를 사용하여 items 리스트에서 가장 깊이가 큰 Item을 찾는다.
        item = max(self.items, key=lambda item: item.depth)
        print(item.height, item.width, item.depth)
        rCnt = 0
        cCnt = 0
        for row in range(item.width, self.bins[0].width+1, item.width):
            rCnt += 1
        for col in range(item.height, self.bins[0].height+1, item.height):
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
            if (item.floor <= 1.0):
                color = "#0000FF"
            elif (item.floor <= 2.0):
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
        # elev=0, azim=90 -> 트렁크 방향
        axGlob.view_init(elev=0, azim=180)
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
