public static List<GoodsDto> getAllGoods(){
    List<GoodsDto> goodsData = null;
    try {
        GoodsImpl goodsService = GoodsImpl.getGoodsDao();
        goodsData = goodsService.getGoods();
    } catch(SQLException e) {
        e.printStackTrace();
    }
    return goodsData;
}