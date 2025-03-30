// on startup
public static void startup{
        try{
        settingInputs = client.getInputSettingInfo();
        // 구역 별 적재 물품 개수 저장
        nextId = settingInputs.getAgentId();
        settingGoodsCountPerArea.add(0);
        checkGoodsForArea.add(0);
        nextId = settingInputs.getAgentId();
        for(Integer count : settingInputs.getGoodsCountPerArea()) {
            settingGoodsCountPerArea.add(count);
            checkGoodsForArea.add(0);
        }

        }catch(Exception e){
            System.err.println(e);
        }


        for(int i=1;i<goodsPerArea.length;i++){
            goodsPerArea[i] = new ArrayList<Long>();
        }

        //SSE
        SSEListener sseListener = new SSEListener(this);
        Thread thread = new Thread(sseListener);
        thread.start();
}

// advanced java - Additional class code
class Main{
    public void startSSEListener() {
        SSEListener listener = new SSEListener(this);
        new Thread(listener).start();
    }

    public void startPick(LoadStartResponse response){
        System.out.println(response.getAgentIds());
        List<Agent> agents = null;
        Enter<Goods> enter = null;
        switch (response.getAreaId()) {
            case 1:
                agents = storage1.getAgents();
                enter = enter1;
                break;
            case 2:
            case 3:
                agents = storage2.getAgents();
                enter = enter2;
                break;
            case 4:
                agents = storage3.getAgents();
                enter = enter3;
                break;
            case 5:
            case 6:
                agents = storage4.getAgents();
                enter = enter4;
                break;
            case 7:
                agents = storage5.getAgents();
                enter = enter5;
                break;
            case 8:
            case 9:
                agents = storage6.getAgents();
                enter = enter6;
                break;
        }

        // 리스트 정렬 확인
        Collections.sort(agents, (a1, a2) -> Long.compare(((Goods)a1).agentId, ((Goods)a2).agentId));

        List<Goods> pickList = new ArrayList<>();

        // 이진탐색으로 agent 찾아 pick
        for(Long agentId : response.getAgentIds()){

            Goods newGoods = new Goods();
            newGoods.agentId = agentId;
            int index = Collections.binarySearch(agents, newGoods, (a1, a2) -> Long.compare(((Goods)a1).agentId, ((Goods)a2).agentId));
            if (index >= 0) {
                Goods goods = (Goods) agents.get(index);
                goods.toConveyorLine = response.getConveyNo();
                pickList.add(goods);
                // try {
                //     semaphore.acquire();
                // } finally {
                //     semaphore.release();
                // }
            } else {
                System.out.println("Agent ID " + agentId + " not found.");
            }
        }
        for(Goods pick : pickList){
            enter.take(pick);
        }
    }


    int[] goodsCntForVehicle = new int[5];
    boolean[] readyVehicleToConvey = new boolean[5];

    // 저장소 데이터를 저장하기 위한 배열 리스트
    List<Long>[] goodsPerArea = goodsPerArea = new List[10];

    // 멀티 스레드 접근 제어를 위한 세마포어
    //private final Semaphore semaphore = new Semaphore(1);


    public Color getRandomColor() {
        Random random = new Random();
        int r = random.nextInt(256);
        int g = random.nextInt(256);
        int b = random.nextInt(256);
        return new Color(r, g, b);
    }
}
