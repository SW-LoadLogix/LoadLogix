import time
from py3dbp import Packer, Bin, Item, Painter

boxSize = [(22, 22, 9), (27, 27, 15),(35, 35, 10), (34,34, 21), (41,41, 28), (48, 48, 34)]

start = time.time()

box = Bin(
    WHD=(170,370,210),
    max_weight=250
)

packer = Packer()

packer.addBin(box)


packer.addItem(Item(
        name='a',
        WHD=boxSize[5],
        weight=9,
        target=1,
    ))

packer.addItem(Item(
        name='b',
        WHD=boxSize[5],
        weight=5,
        target=2,
    ))
packer.addItem(Item(
        name='c',
        WHD=boxSize[5],
        weight=9,
        target=3,
    ))
packer.addItem(Item(
        name='d',
        WHD=boxSize[5],
        weight=9,
        target=4,
    ))
packer.addItem(Item(
        name='e',
        WHD=boxSize[5],
        weight=9,
        target=5,
    ))
packer.addItem(Item(
        name='f',
        WHD=boxSize[5],
        weight=9,
        target=6,
    ))
packer.addItem(Item(
        name='g',
        WHD=boxSize[5],
        weight=9,
        target=7,
    ))
packer.addItem(Item(
        name='h',
        WHD=boxSize[5],
        weight=9,
        target=8,
    ))
packer.addItem(Item(
        name='i',
        WHD=boxSize[5],
        weight=9,
        target=9,
    ))
packer.addItem(Item(
        name='j',
        WHD=boxSize[5],
        weight=9,
        target=10,
    ))
packer.addItem(Item(
        name='k',
        WHD=boxSize[5],
        weight=9,
        target=11,
    ))
packer.addItem(Item(
        name='l',
        WHD=boxSize[5],
        weight=9,
        target=12,
    ))
packer.addItem(Item(
        name='n',
        WHD=boxSize[5],
        weight=9,
        target=13,
    ))
packer.addItem(Item(
        name='m',
        WHD=boxSize[5],
        weight=9,
        target=14,
    ))
packer.addItem(Item(
        name='o',
        WHD=boxSize[5],
        weight=9,
        target=15,
    ))
packer.addItem(Item(
        name='p',
        WHD=boxSize[5],
        weight=9,
        target=16,
    ))
packer.addItem(Item(
        name='q',
        WHD=boxSize[5],
        weight=9,
        target=17,
    ))
packer.addItem(Item(
        name='r',
        WHD=boxSize[5],
        weight=9,
        target=18,
    ))
packer.addItem(Item(
        name='s',
        WHD=boxSize[5],
        weight=9,
        target=19,
    ))
packer.addItem(Item(
        name='t',
        WHD=boxSize[5],
        weight=9,
        target=20,
    ))
packer.addItem(Item(
        name='u',
        WHD=boxSize[5],
        weight=9,
        target=21,
    ))
packer.addItem(Item(
        name='v',
        WHD=boxSize[5],
        weight=9,
        target=22,
    ))
packer.addItem(Item(
        name='w',
        WHD=boxSize[5],
        weight=9,
        target=23,
    ))

packer.addItem(Item(
        name='x',
        WHD=boxSize[5],
        weight=9,
        target=23,
    ))
packer.addItem(Item(
        name='y',
        WHD=boxSize[4],
        weight=9,
        target=23,
    ))
packer.addItem(Item(
        name='z',
        WHD=boxSize[5],
        weight=9,
        target=23,
    ))

packer.pack2(
    number_of_decimals=0
)


# print result
for box in packer.bins:

    volume = box.width * box.height * box.depth
    print(":::::::::::", box.string())

    print("FITTED ITEMS:")
    volume_t = 0
    volume_f = 0
    unfitted_name = ''

    # '''
    for item in box.items:
        print("name : ",item.name)
        print("position : ",item.position)
        print("W*H*D : ",str(item.width) +'*'+ str(item.height) +'*'+ str(item.depth))
        print("volume : ",float(item.width) * float(item.height) * float(item.depth))
        print("weight : ",float(item.weight))
        print("floor : ", float(item.floor))
        volume_t += float(item.width) * float(item.height) * float(item.depth)
        print("***************************************************")
    print("***************************************************")
    # '''
    print("UNFITTED ITEMS:")
    for item in box.unfitted_items:
        print("name : ",item.name)
        print("W*H*D : ",str(item.width) +'*'+ str(item.height) +'*'+ str(item.depth))
        print("volume : ",float(item.width) * float(item.height) * float(item.depth))
        print("weight : ",float(item.weight))
        print("floor : ", float(item.floor))
        print("denyInfo : ", item.denyInfo)
        volume_f += float(item.width) * float(item.height) * float(item.depth)
        unfitted_name += '{},'.format(item.name)
        print("***************************************************")
    print("***************************************************")
    print('space utilization : {}%'.format(round(volume_t / float(volume) * 100 ,2)))
    print('residual volumn : ', float(volume) - volume_t )
    print('unpack item : ',unfitted_name)
    print('unpack item volumn : ',volume_f)
    print("gravity distribution : ",box.gravity)
    # '''

    # 데이터 변환
    boxes_data = []
    for item in box.items:
        box_info = {
            "name": item.name,
            "endPosition": [{"x": float(item.position[0] ), "y": float(item.position[1]), "z": float(item.position[2])}],
            "size": [{"x": float(item.width), "y": float(item.height), "z": float(item.depth)}]
        }
        boxes_data.append(box_info)
    result = {"boxes": boxes_data}
    print(result)
    # json_result = json.dumps(result, indent=4)
    # print(json_result)

    stop = time.time()
    print('used time : ',stop - start)

    # draw results
    painter = Painter(box)
    fig = painter.plotBoxAndItems(
        title="test",
        alpha=0.2,
        write_num=True,
        fontsize=10
    )
fig.show()