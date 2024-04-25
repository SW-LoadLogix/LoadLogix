if (!goodsList.isEmpty()) {
        Goods goods = goodsList.remove(0);
        queue.onEnter(goods);
        System.out.println(goods.id+" "+goods.width);
}