APIClient client = new APIClient();
try{
	List<GoodsDto> allGoods = client.getGoods();
	System.out.println(allGoods);
	
	for (GoodsDto g : allGoods) {
		Goods goods = new Goods();
		goods.id = goods.getId();	
		goods.width = g.getWidth();	
		goods.length = g.getLength();	
		goods.height = g.getHeight();	
		goods.weight = g.getWeight();	
	//	goods.userId = g.getUserId();	
	//	goods.areaId = g.getAreaId();	
		
		goodsList.add(goods);
	}
	System.out.println(goodsList);
}catch(Exception e){
	System.out.println(e);
}