List<GoodsDto> allGoods = getAllGoods();
    for (GoodsDto goods : allGoods) {
Box box = new Box();
box.id = goods.getId();
box.width = goods.getWidth();
box.length = goods.getLength();
box.height = goods.getHeight();
box.weight = goods.getWeight();
box.userId = goods.getUserId();
box.areaId = goods.getAreaId();

		boxCollection.add(box);
	}
