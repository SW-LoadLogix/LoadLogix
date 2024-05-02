from py3dbp import Packer, Bin, Item, Painter
import time
start = time.time()

packer = Packer()

boxSize = [(22, 22, 9), (27, 27, 15), (35,35, 10), (34,34, 10), (41,41, 28), (48, 48, 34),(54,54,34)]

box = Bin(
    WHD=(170,370,210),
    max_weight=250
)

packer.addBin(box)


packer.addItem(Item(
        name='a',
        WHD=boxSize[5],
        weight=9,
        target=1,
        floor=0
    ))

packer.addItem(Item(
        name='b',
        WHD=boxSize[5],
        weight=9,
        target=2,
        floor=0
    ))
packer.addItem(Item(
        name='c',
        WHD=boxSize[5],
        weight=9,
        target=21,
        floor=0
    ))

packer.addItem(Item(
        name='d',
        WHD=boxSize[5],
        weight=9,
        target=3,
        floor=0
    ))

packer.addItem(Item(
        name='e',
        WHD=boxSize[5],
        weight=9,
        target=4,
        floor=0
    ))

packer.addItem(Item(
        name='f',
        WHD=boxSize[5],
        weight=9,
        target=5,
        floor=0
    ))

packer.addItem(Item(
        name='g',
        WHD=boxSize[5],
        weight=9,
        target=6,
        floor=0
    ))
packer.addItem(Item(
        name='h',
        WHD=boxSize[5],
        weight=9,
        target=7,
        floor=0
    ))
packer.addItem(Item(
        name='i',
        WHD=boxSize[5],
        weight=9,
        target=8,
        floor=0
    ))
packer.addItem(Item(
        name='j',
        WHD=boxSize[5],
        weight=9,
        target=9,
        floor=0
    ))
packer.addItem(Item(
        name='k',
        WHD=boxSize[5],
        weight=9,
        target=10,
        floor=0
    ))
packer.addItem(Item(
        name='l',
        WHD=boxSize[5],
        weight=9,
        target=11,
        floor=0
    ))
packer.addItem(Item(
        name='n',
        WHD=boxSize[5],
        weight=9,
        target=12,
        floor=0
    ))
packer.addItem(Item(
        name='m',
        WHD=boxSize[5],
        weight=9,
        target=13,
        floor=0
    ))
packer.addItem(Item(
        name='o',
        WHD=boxSize[5],
        weight=9,
        target=14,
        floor=0
    ))
packer.addItem(Item(
        name='p',
        WHD=boxSize[5],
        weight=9,
        target=15,
        floor=0
    ))

packer.addItem(Item(
        name='q',
        WHD=boxSize[5],
        weight=9,
        target=16,
        floor=0
    ))

packer.addItem(Item(
        name='r',
        WHD=boxSize[5],
        weight=9,
        target=17,
        floor=0
    ))
packer.addItem(Item(
        name='s',
        WHD=boxSize[5],
        weight=9,
        target=18,
        floor=0
    ))
packer.addItem(Item(
        name='t',
        WHD=boxSize[5],
        weight=9,
        target=19,
        floor=0
    ))
packer.addItem(Item(
        name='u',
        WHD=boxSize[5],
        weight=9,
        target=20,
        floor=0
    ))

packer.addItem(Item(
        name='v',
        WHD=boxSize[5],
        weight=9,
        target=22,
        floor=0
    ))
packer.addItem(Item(
        name='w',
        WHD=boxSize[5],
        weight=9,
        target=23,
        floor=0
    ))

packer.addItem(Item(
        name='x',
        WHD=boxSize[5],
        weight=9,
        target=24,
        floor=0
    ))

packer.pack(
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