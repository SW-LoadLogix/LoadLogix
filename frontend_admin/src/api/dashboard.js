// import { ref } from 'vue';
// import { defineStore } from 'pinia';
// import axios from '@/utils/adminAxios';

// const apiUrl = process.env.VUE_APP_API_URL+'/admin';

// export const useDashboard = defineStore('dashboard', () => {
//     /* 택배 수 조회 */
//     const goodsCount = ref({});
//     const getGoodsCount = async () => {
//     const { data } = await axios.get(`${apiUrl}/good-counts`);
//     console.log('택배 수 조회의 응답 데이터', data);
//     goodsCount.value = data.result;
//   };

//   /* 물류센터 초기 세팅 */
//   const initialSet = async (areaCounts) => {
//     console.log('initialSet() 물류센터 초기 세팅');
//     return await axios.put(`${apiUrl}/settings`, areaCounts);
//   };

//   /* 저장소별 물품 개수 조회 */
//   const rackStoreGoodsCounts = ref([]);
//   const getRackStoreGoodsCount = async () => {
//     const { data } = await axios.get(`${apiUrl}/racks`);
//     console.log('저장소별 물품 개수 조회의 응답 데이터 : ', data);
//     rackStoreGoodsCounts.value = data.result;
//   };

//   /* 일별 출고량 조회 */
//   const dayGoodsCount = ref([]);
//   const getDayGoodsCount = async () => {
//     const { data } = await axios.get(`${apiUrl}/day-counts`);
//     console.log('일별 출고량 조회의 응답 데이터 : ', data);
//     dayGoodsCount.value = data.result;
//   };

//   /* 실시간 물품 리스트 조회 */
//   const goods = ref([]);
//   const getGoods = async () => {
//     const { data } = await axios.get(`${apiUrl}/goods`);
//     console.log('실시간 물품 리스트 조회의 응답 데이터 : ', data);
//     goods.value = data.result;
//   };

//   /* 상자 규격별 택배 수 조회 */
//   const goodsCountByBoxType = ref([]);
//   const getGoodsCountByBoxType = async () => {
//     const { data } = await axios.get(`${apiUrl}/types`);
//     console.log('상자 규격별 택배 수 조회의 응답 데이터 : ', data);
//     goodsCountByBoxType.value = data.result;
//   };

//    /* 배송기사 리스트 조회 */
//    const workers = ref([]);
//    const getWorkers = async () => {
//      const { data } = await axios.get(`${apiUrl}/workers`);
//      console.log('배송기사 리스트 조회의 응답 데이터 : ', data);
//      workers.value = data.result;
//    };

//    /* 실시간 출고 리스트 조회 */
//    const loadedGoods = ref([]);
//    const getLoadedGoods = async () => {
//      const { data } = await axios.get(`${apiUrl}/loads`);
//      console.log('실시간 출고 리스트 조회의 응답 데이터 : ', data);
//      loadedGoods.value = data.result;
//    };

//    /////
//    const getGoodsCount1 = async () => {
//     console.log("ddd");
//     return await axios.get(apiUrl + `/good-counts`);
//    };


//   return {
//     goodsCount,
//     getGoodsCount,
//     initialSet,
//     rackStoreGoodsCounts,
//     getRackStoreGoodsCount,
//     dayGoodsCount,
//     getDayGoodsCount,
//     goods,
//     getGoods,
//     goodsCountByBoxType,
//     getGoodsCountByBoxType,
//     workers,
//     getWorkers,
//     loadedGoods,
//     getLoadedGoods,

//     getGoodsCount1
//   };
// });

import axios from "axios";

const apiUrl = process.env.VUE_APP_API_URL+'/admin';
   const getGoodsCount = async () => {
    console.log("ddd");
    return await axios.get(apiUrl + `/good-counts`);
   };
export {
  getGoodsCount

};
