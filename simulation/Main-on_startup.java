try {
GoodsImpl goodsService = GoodsImpl.getGoodsDao();
List<GoodsDto> goodsDto = goodsService.getGoods();
    System.out.println(goodsDto.toString());
        } catch(SQLException e) {
        e.printStackTrace();
  }
