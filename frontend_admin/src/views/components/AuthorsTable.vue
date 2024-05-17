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

const isLoading = ref(false);
const goods = ref([]);
const getGoodsRequest = async () => {
  isLoading.value = true;
  const { data } = await getGoods();
  goods.value = data.result;
  for (let i = 0; i < goods.value.length; i++) {
    goods.value[i].created_at = formatTimestamp(goods.value[i].created_at);
  }
  isLoading.value = false;
};

getGoodsRequest();
</script>
<template>
  <div class="card">
    <div class="card-header pb-0">
      <h6>실시간 입고</h6>
    </div>
    <div class="card-body px-0 pt-0 pb-2">
      <div v-if="isLoading" class="table-responsive p-0" style="max-height: 400px; overflow-y: auto;">
        <table class="table align-items-center mb-0">
          <thead>
            <tr>
              <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                담당 기사
              </th>
              <th class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                구역
              </th>
              <th
                class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                주소
              </th>
              <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
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
        </table>
        <div style="display: flex; justify-content: center; align-items: center; height: 50vh;">
          <div class="spinner-border text-primary" role="status">
            <span class="sr-only">Loading...</span>
          </div>
        </div>
      </div>
      <div v-else class="table-responsive p-0" style="max-height: 400px; overflow-y: auto;">
        <table class="table align-items-center mb-0">
          <thead>
            <tr>
              <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                담당 기사
              </th>
              <th class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                구역
              </th>
              <th
                class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                주소
              </th>
              <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
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
          <tbody>
            <tr v-for="good in goods" :key="good.worker_id">
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.worker_name }}</p>
              </td>
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.area_name }}</p>
              </td>
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.address }}</p>
              </td>
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.weight }}g</p>
              </td>
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.box_type }}</p>
              </td>
              <td class="align-middle text-center">
                <p class="text-sm font-weight-bold mb-0">{{ good.created_at }}</p>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
