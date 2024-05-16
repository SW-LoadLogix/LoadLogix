<script setup>
import MiniStatisticsCard from "@/examples/Cards/MiniStatisticsCard.vue";
import GradientLineChart from "@/examples/Charts/GradientLineChart.vue";
import Carousel from "./components/Carousel.vue";
import CategoriesList from "./components/CategoriesList.vue";

import L1 from "@/assets/img/boxes/L1.png";
import L2 from "@/assets/img/boxes/L2.png";
import L3 from "@/assets/img/boxes/L3.png";
import L4 from "@/assets/img/boxes/L4.png";
import L5 from "@/assets/img/boxes/L5.png";
import L6 from "@/assets/img/boxes/L6.png";


// import ArgonInput from "@/components/ArgonInput.vue";
import ArgonButton from "@/components/ArgonButton.vue";

import { ref } from 'vue';
import {
  getGoodsCount, 
  getDayGoodsCount,
  getGoodsCountByBoxType,
  getRackStoreGoodsCount,
  initialSet,
  getAreaInfo
} from "@/api/dashboard.js";

const totalGoods = ref(0);
const enterGoods = ref(0);
const releaseGoods = ref(0);
const updateTime = ref(0);

const chartData = ref({
  labels: [],
  datasets: []
});
let isLoadingCount = ref(false);
let isLoadingChart = ref(false);
let isLoadingBoxes = ref(false);
let isLoadingStorage = ref(false);
let isLoadingArea = ref(false);


const boxTypes = {
  L1,L2,L3,L4,L5,L6
};

let boxes = [];
let storage = [];
let areaInfos = [];

function transformToChartData(inputData) {
  if (!inputData || !Array.isArray(inputData.amount)) {
    return {
      labels: [],
      datasets: []
    };
  }

  return {
    labels: inputData.amount.map(item => item.date),
    datasets: [
      {
        label: '출고량',
        data: inputData.amount.map(item => item.total),
      },
    ],
  };
}

function transformToStorageData(inputDataArray) {
  return inputDataArray.map(inputData => ({
    icon: {
      component: 'ni ni-app',
      background: 'dark',
    },
    label: `${inputData.rack_line}번 저장소` ,
    description: `실시간 저장 물품 : ${inputData.total_count}`,
  }));
}


const getGoodsCountRequest = async () => {
  // 물품 조회
  const { data } = await getGoodsCount();
  totalGoods.value = data.result.total_count;
  enterGoods.value = data.result.store_count;
  releaseGoods.value = data.result.load_count;
  updateTime.value = new Date().toLocaleTimeString();
  isLoadingCount.value = false;
};

const getDailyGoodsCountRequest = async () => {
  const {data} = await getDayGoodsCount();
  chartData.value = transformToChartData(data.result);
  isLoadingChart.value = true;
};

const getBoxTypeRequest = async () => {
  const {data} = await getGoodsCountByBoxType();
  boxes = data.result;
  isLoadingBoxes.value = true;
};

const getGoodsPerStoreRequest = async () => {
  const {data} = await getRackStoreGoodsCount();
  storage = transformToStorageData(data.result);
  isLoadingStorage.value = true;
}

const setReleaseCountRequest = async () => {
  await initialSet(areaInfos);
}

const getAreaInfoRequest = async () => {
  const {data} = await getAreaInfo();
  areaInfos = data.result;
  isLoadingArea.value = true;
}
getGoodsCountRequest();
getDailyGoodsCountRequest();
getBoxTypeRequest();
getGoodsPerStoreRequest();
getAreaInfoRequest();


</script>
<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-lg-12">
        <div class="row">
          <div class="col-lg-3 col-md-6 col-12">
            <mini-statistics-card
              title="TOTAL GOODS"
              :value='`${totalGoods} 개`'
              description="실시간 전체 물품 개수"
              :icon="{
                component: 'ni ni-money-coins',
                background: 'bg-gradient-primary',
                shape: 'rounded-circle',
              }"
            />
          </div>
          <div class="col-lg-3 col-md-6 col-12">
            <mini-statistics-card
              title="WAREHOUSING"
              :value='`${enterGoods} 개`'
              description="실시간<span
                class='text-sm font-weight-bolder text-success'
                >입고</span> 물품 개수"
              :icon="{
                component: 'ni ni-world',
                background: 'bg-gradient-danger',
                shape: 'rounded-circle',
              }"
            />
          </div>
          <div class="col-lg-3 col-md-6 col-12">
            <mini-statistics-card
              title="Release Goods"
              :value='`${releaseGoods} 개`'
              description="실시간 <span
                class='text-sm font-weight-bolder text-danger'
                >출고</span> 물품 개수"
              :icon="{
                component: 'ni ni-paper-diploma',
                background: 'bg-gradient-success',
                shape: 'rounded-circle',
              }"
            />
          </div>
          <div class="col-lg-3 col-md-6 col-12" v-if="isLoadingCount">
            <mini-statistics-card
              title="Update Time"
              :value='`${updateTime}`'
              description="물류 공장 현황 반영 시간"
              :icon="{
                component: 'ni ni-cart',
                background: 'bg-gradient-warning',
                shape: 'rounded-circle',
              }"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-lg-7 mb-lg">
            <!-- line chart -->
            <div class="card z-index-2" v-if="isLoadingChart">
              <gradient-line-chart
                id="chart-line"
                title="Daily Shipping Volume"
                description="물류 공장의 실시간 일별 출고량"
                :chart=chartData
              />
            </div>
          </div>
          <div class="col-lg-5">
            <carousel />
          </div>
        </div>
        <div class="row mt-4" v-if="isLoadingBoxes">
          <div class="col-lg-7 mb-lg-0 mb-4">
            <div class="card">
              <div class="p-3 pb-0 card-header">
                <div class="d-flex justify-content-between">
                  <h6 class="mb-2">규격 별 물품 수</h6>
                </div>
              </div>
              <div class="table-responsive">
                <table class="table align-items-center">
                  <tbody>
                    <tr v-for="(box, index) in boxes" :key="index">
                      <td class="w-30">
                        <div class="px-2 py-1 d-flex align-items-center">
                          <div>
                            <img  style="max-width: 100px;" :src="boxTypes[box.type]" alt="Country flag" />
                          </div>
                          <div class="ms-4">
                            <p class="mb-0 text-xs font-weight-bold">
                              포장재 규격
                            </p>
                            <h6 class="mb-0 text-sm">{{ box.type }}</h6>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div class="text-center">
                          <p class="mb-0 text-xs font-weight-bold">너비</p>
                          <h6 class="mb-0 text-sm">{{ box.width }}</h6>
                        </div>
                      </td>
                      <td>
                        <div class="text-center">
                          <p class="mb-0 text-xs font-weight-bold">높이</p>
                          <h6 class="mb-0 text-sm">{{ box.height }}</h6>
                        </div>
                      </td>
                      <td class="text-sm align-middle">
                        <div class="text-center col">
                          <p class="mb-0 text-xs font-weight-bold">길이</p>
                          <h6 class="mb-0 text-sm">{{ box.length }}</h6>
                        </div>
                      </td>
                      <td class="text-sm align-middle">
                        <div class="text-center col">
                          <p class="mb-0 text-xs font-weight-bold">물품량</p>
                          <h6 class="mb-0 text-sm">{{ box.totalCount }}</h6>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="col-lg-5" style="height: 305px;" v-if=isLoadingStorage>
              <categories-list
                title = "실시간 물류 창고 저장소 현황"
                :categories=storage
              />
            <div class="py-4">
            <div class="row">
              <div class="col-md-12" style="height: 350px;">
                <div class="card" style="height: 100%;">
                  <div class="card-header pb-0">
                    <div class="d-flex align-items-center">
                      <p class="mb-0" style="font-weight: 900;">구역 당 물품 할당</p>
                      <argon-button @click="setReleaseCountRequest" color="success" size="sm" class="ms-auto"
                        >SAVE</argon-button>
                    </div>
                  </div>
                  <div class="card-body" v-if="isLoadingArea" style="overflow: auto;">
                    <div class="row-md-12" v-for="(area, index) in areaInfos" :key="index" style="display: flex; align-items: center; gap: 10px;">
                      
                        <label style="flex: 1; margin: 10px 0;" for="example-text-input" class="form-control-label">{{area.area_name}}</label>
                        <input style="flex: 1; margin: 10px 10px 10px 0;" class="form-control" type="text" :value=area.count v-model="area.count" />
                        <label style="flex: 1.5; margin: 10px 0;" for="example-text-input" class="form-control-label">Convey-Line</label>
                        <input style="flex: 0.5; margin: 10px 0;" class="form-control" type="text" :value=area.convey_no v-model="area.convey_no" />
                      
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        
          </div>
         </div>
      </div>
    </div>
  </div>
</template>
