import axiosInstance from '@/utils/adminAxios';

  /* 택배 수 조회 */
   const getGoodsCount = async () => {
    return await axiosInstance.get(`/good-counts`);
   };

  /* 물류센터 초기 세팅 */
  const initialSet = async (areaSettingRequest) => {
    await axiosInstance.put(`/settings`, areaSettingRequest);
  };

  /* 저장소별 물품 개수 조회 */
  const getRackStoreGoodsCount = async () => {
    return await axiosInstance.get(`/racks`);
  };

  /* 일별 출고량 조회 */
  const getDayGoodsCount = async () => {
    return await axiosInstance.get(`/day-counts`);
  };

  /* 실시간 물품 리스트 조회 */
  const getGoods = async () => {
    console.log('실시간 물품 리스트 조회');
    return await axiosInstance.get(`/goods`);
  };

  /* 상자 규격별 택배 수 조회 */
  const getGoodsCountByBoxType = async () => {
    return await axiosInstance.get(`/types`);
  };

  /* 배송기사 리스트 조회 */
   const getWorkers = async () => {
     console.log('배송기사 리스트 조회');
     return await axiosInstance.get(`/workers`);
   };

  /* 실시간 출고 리스트 조회 */
   const getLoadedGoods = async () => {
    console.log('실시간 출고 리스트 조회');
     return await axiosInstance.get(`/loads`);
   };

   /* 구역 조회 */
   const getAreaInfo = async () => {
    return await axiosInstance.get('/area');
   }
export {
  getGoodsCount,
  initialSet,
  getRackStoreGoodsCount,
  getDayGoodsCount,
  getGoods,
  getGoodsCountByBoxType,
  getWorkers,
  getLoadedGoods,
  getAreaInfo
};
