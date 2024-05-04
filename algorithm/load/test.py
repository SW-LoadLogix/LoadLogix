import json
import requests
import time
from py3dbp import Packer, Bin, Item, Painter
from decimal import Decimal
boxSize = [(22, 22, 9), (27, 27, 15),(35,35, 10), (34,34, 21), (41,41, 28), (48, 48, 34)]
while (True):
    def event_stream(url):
        with requests.get(url, stream=True) as response:
            for line in response.iter_lines():
                if line:
                    # print(line)
                    yield line.decode('utf-8')
    try:
        if __name__ == "__main__":
            url = 'http://localhost:8081/api/load'
            for event in event_stream(url):
                start = time.time()
                #서버로 부터 받은 json 객체 변환
                print(event)
                # json_str = event.split('data:')[1]
                event_data = json.loads(event)

                if not event_data:
                    print("json 비어있습니다")
                    time.sleep(5)
                else:
                    packer = Packer()
                    taskId = event_data['taskId']
                    # print(event_data)
                    box = Bin(
                        WHD=(event_data['car']['width'], event_data['car']['height'], event_data['car']['depth']),
                        max_weight=event_data['car']['weight']
                    )
                    packer.addBin(box)
                    deliverOrder = event_data['buildingIdOrder']
                    for item in event_data['goods']:
                        packer.addItem(Item(
                            name=item['goodsId'],
                            WHD=boxSize[int(item['type'][1])],
                            weight=item['weight'],
                            type = item['type'],
                            target=deliverOrder.index(item["buildingId"]),
                        ))

                    # print(deliverOrder)
                    packer.pack(
                        number_of_decimals=0
                    )
                    #json 형식으로 만들기
                    goods = []
                    for item in packer.bins[0].items:
                        goods.append({
                            "goods_id": item.name,
                            "position":{
                                "x" :int(item.position[0]),
                                "y": int(item.position[1]),
                                "z": int(item.position[2])
                            },
                            "type":item.type
                        })


                    result = {
                        "task_id": taskId,
                        "goods" : goods
                    }
                    loadResponse = json.dumps(result, indent=4)
                    print(loadResponse)

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
                    # Post 요청을 보낼 URL
                    post_url = 'http://localhost:8081/api/load'

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