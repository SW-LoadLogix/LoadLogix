<script setup>
import { ref } from 'vue';
import {
  getGoods
} from "@/api/dashboard.js";

const formatTimestamp = (timestamp) => {
  const date = new Date(timestamp);
  const formattedDate = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')} ${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}:${date.getSeconds().toString().padStart(2, '0')}`;
  return formattedDate;
};

const goods = ref([]);
const getGoodsRequest = async () => {
  const { data } = await getGoods();
  goods.value = data.result;
  for (let i = 0; i < goods.value.length; i++) {
    goods.value[i].created_at = formatTimestamp(goods.value[i].created_at);
  }
  console.log(goods.value);
};

getGoodsRequest();
</script>
<template>
  <div class="card">
    <div class="card-header pb-0">
      <h6>실시간 입고</h6>
    </div>
    <div class="card-body px-0 pt-0 pb-2">
      <div class="table-responsive p-0" style="max-height: 400px; overflow-y: auto;">
        <table class="table align-items-center mb-0">
          <!-- 테이블 상단 -->
          <thead>
            <tr>
              <th
                class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
              >
                구역
              </th>
              <th
                class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2"
              >
                주소
              </th>
              <th
                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
              >
                담당 기사
              </th>
              <th
                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
              >
                무게
              </th>
              <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                박스 타입
              </th>
              <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                입고 시각
              </th>
            </tr>
          </thead>
          <!-- 리스트 시작 -->
          <tbody>
            <tr v-for="good in goods" :key="good.worker_id">
              <!-- 구역 -->
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{good.area_name}}</p>
              </td>
              <!-- 주소 -->
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.address }}</p>
              </td>
              <!-- 담당 기사 -->
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{good.worker_id}}</p>
              </td>
              <!-- 무게 -->
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{good.weight}}g</p>
              </td>
              <!-- 박스 타입 -->
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.box_type }}</p>
              </td>
              <!-- 입고 시각 -->
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{good.created_at}}</p>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
