import json
import requests
import time
from py3dbp import Packer, Bin, Item, Painter

boxSize = [(22, 22, 9), (27, 27, 15), (35, 35, 10), (34, 34, 21), (41, 41, 28), (48, 48, 34)]
while (True):
    def event_stream(url):
        with requests.get(url, stream=True) as response:
            for line in response.iter_lines():
                if line:
                    # print(line)
                    yield line.decode('utf-8')


    try:
        if __name__ == "__main__":
            #로컬테스트
            url = 'http://localhost:8081/api/load'
            #백서버
            # url = 'http://192.168.31.245:8081/api/load/task'
            for event in event_stream(url):
                start = time.time()
                # 서버로 부터 받은 json 객체 변환
                print(event)
                # json_str = event.split('data:')[1]
                event_data = json.loads(event)

                if not event_data['result']:
                    print("json 비어있습니다")
                    time.sleep(3)
                else:
                    packer = Packer()
                    taskId = event_data['result']['task_id']
                    # print(event_data)
                    box = Bin(
                        WHD=(event_data['result']['car']['width'], event_data['result']['car']['height'],
                             event_data['result']['car']['depth']),
                        max_weight=event_data['result']['car']['max_weight']
                    )
                    packer.addBin(box)
                    deliverOrder = event_data['result']['building_id_order']

                    for item in event_data['result']['goods']:
                        packer.addItem(Item(
                            name=item['goods_id'],
                            WHD=boxSize[int(item['type'][1])-1],
                            weight=item['weight'],
                            target=deliverOrder.index(item["building_id"]),
                        ))
                        # print(item['goods_id'],"를 추가완료")

                    # print(deliverOrder)
                    packer.pack2(
                        number_of_decimals=0
                    )
                    # json 형식으로 만들기
                    goods = []
                    for item in packer.bins[0].items:
                        goods.append({
                            "goods_id": item.name,
                            "position": {
                                "x": int(item.position[0]),
                                "y": int(item.position[1]),
                                "z": int(item.position[2])
                            },
                        })

                    result = {
                        "task_id": taskId,
                        "goods": goods
                    }

                    loadResponse = json.dumps(result, indent=4)
                    print(loadResponse)

                    for box in packer.bins:

                        volume = box.width * box.height * box.depth
                        print(":::::::::::", box.string())

                        print("FITTED ITEMS:")
                        volume_t = 0
                        volume_f = 0
                        unfitted_name = ''

                        # '''
                        for item in box.items:
                            print("name : ", item.name)
                            print("position : ", item.position)
                            print("W*H*D : ", str(item.width) + '*' + str(item.height) + '*' + str(item.depth))
                            print("volume : ", float(item.width) * float(item.height) * float(item.depth))
                            print("weight : ", float(item.weight))
                            print("floor : ", float(item.floor))
                            volume_t += float(item.width) * float(item.height) * float(item.depth)
                            print("***************************************************")
                        print("***************************************************")
                        # '''
                        print("UNFITTED ITEMS:")
                        for item in box.unfitted_items:
                            print("name : ", item.name)
                            print("W*H*D : ", str(item.width) + '*' + str(item.height) + '*' + str(item.depth))
                            print("volume : ", float(item.width) * float(item.height) * float(item.depth))
                            print("weight : ", float(item.weight))
                            print("floor : ", float(item.floor))
                            print("denyInfo : ", item.denyInfo)
                            volume_f += float(item.width) * float(item.height) * float(item.depth)
                            unfitted_name += '{},'.format(item.name)
                            print("***************************************************")
                        print("***************************************************")
                        print('space utilization : {}%'.format(round(volume_t / float(volume) * 100, 2)))
                        print('residual volumn : ', float(volume) - volume_t)
                        print('unpack item : ', unfitted_name)
                        print('unpack item volumn : ', volume_f)
                        print("gravity distribution : ", box.gravity)

                    stop = time.time()
                    print('used time : ', stop - start)

                    # draw results
                    painter = Painter(box)
                    fig = painter.plotBoxAndItems(
                        title="test",
                        alpha=0.2,
                        write_num=True,
                        fontsize=10
                    )
                    fig.show()
                    # 로컬테스트
                    post_url = 'http://localhost:8081/api/load'
                    # 백서버
                    # post_url = 'http://192.168.31.245:8081/api/load/task/result'

                    # POST 요청 보내기
                    response = requests.post(post_url, data=loadResponse, headers={'Content-Type': 'application/json'})
                    if response.status_code == 200:
                        print('Post successful')
                    else:
                        print(f'Post failed: {response.status_code}')
                    time.sleep(5)
    except Exception as e:
        print(f'오류 발생: {e}')
        time.sleep(5)
