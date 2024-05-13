import { ref } from 'vue';
import { defineStore } from 'pinia';
import axios from '@/utils/adminAxios';

export const useDashboardStore = defineStore('dashboard', () => {
    /* 택배 수 조회 */
    const goodsCount = ref({});
    const getGoodsCount = async () => {
    const { data } = await axios.get(`/api/admin/good-counts`);
    console.log('택배 수 조회의 응답 데이터', data);
    goodsCount.value = data.result;
  };

  /* 물류센터 초기 세팅 */
  const initialSet = async (areaCounts) => {
    console.log('initialSet() 물류센터 초기 세팅');
    return await axios.put(`/api/admin/settings`, areaCounts);
  };

  /* 저장소별 물품 개수 조회 */
  const rackStoreGoodsCounts = ref([]);
  const getRackStoreGoodsCount = async () => {
    const { data } = await axios.get(`/api/admin/racks`);
    console.log('저장소별 물품 개수 조회의 응답 데이터 : ', data);
    rackStoreGoodsCounts.value = data.result;
  };

  /* 일별 출고량 조회 */
  const dayGoodsCount = ref([]);
  const getDayGoodsCount = async () => {
    const { data } = await axios.get(`/api/admin/day-counts`);
    console.log('일별 출고량 조회의 응답 데이터 : ', data);
    dayGoodsCount.value = data.result;
  };

  /* 실시간 물품 리스트 조회 */
  const goods = ref([]);
  const getGoods = async () => {
    const { data } = await axios.get(`/api/admin/goods`);
    console.log('실시간 물품 리스트 조회의 응답 데이터 : ', data);
    goods.value = data.result;
  };

  /* 상자 규격별 택배 수 조회 */
  const goodsCountByBoxType = ref([]);
  const getGoodsCountByBoxType = async () => {
    const { data } = await axios.get(`/api/admin/types`);
    console.log('상자 규격별 택배 수 조회의 응답 데이터 : ', data);
    goodsCountByBoxType.value = data.result;
  };

   /* 배송기사 리스트 조회 */
   const workers = ref([]);
   const getWorkers = async () => {
     const { data } = await axios.get(`/api/admin/workers`);
     console.log('배송기사 리스트 조회의 응답 데이터 : ', data);
     workers.value = data.result;
   };

   /* 실시간 출고 리스트 조회 */
   const loadedGoods = ref([]);
   const getLoadedGoods = async () => {
     const { data } = await axios.get(`/api/admin/loads`);
     console.log('실시간 출고 리스트 조회의 응답 데이터 : ', data);
     loadedGoods.value = data.result;
   };

  return {
    goodsCount,
    getGoodsCount,
    initialSet,
    rackStoreGoodsCounts,
    getRackStoreGoodsCount,
    dayGoodsCount,
    getDayGoodsCount,
    goods,
    getGoods,
    goodsCountByBoxType,
    getGoodsCountByBoxType,
    workers,
    getWorkers,
    loadedGoods,
    getLoadedGoods
  };
});
