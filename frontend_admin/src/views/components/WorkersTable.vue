<script setup>
import { ref } from 'vue';
import {
  getWorkers
} from "@/api/dashboard.js";

const workers = ref([]);
const getWorkersRequest = async () => {
  const { data } = await getWorkers();
  workers.value = data.result;
  console.log(workers.value);
};

getWorkersRequest();
</script>
<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card mb-4">
          <div class="card-header pb-0">
            <h6>기사 리스트</h6>
          </div>
          <div class="card-body px-0 pt-0 pb-2">
            <div class="table-responsive p-0" style="max-height: 800px; overflow-y: auto;">
              <table class="table align-items-center mb-0">
                <!-- 테이블 상단 -->
                <thead>
                  <tr>
                    <th
                      class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                      담당 기사
                    </th>
                    <th
                      class="align-middle text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                      구역
                    </th>
                    <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                      할당 받은 택배
                    </th>
                    <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                      상태
                    </th>
                  </tr>
                </thead>
                <!-- 리스트 시작 -->
                <tbody>
                  <tr v-for="worker in workers" :key="worker.name">
                    <!-- 담당 기사 -->
                    <td class="align-middle text-center">
                      <div class="d-flex px-2 py-1 justify-content-center">
                        <div>
                          <img src="../../assets/img/profile.png" class="avatar avatar-sm me-3" alt="user" />
                        </div>
                        <div class="d-flex flex-column justify-content-center">
                          <p class="text-sm font-weight-bold mb-0">{{ worker.name }}</p>
                        </div>
                      </div>
                    </td>
                    <!-- 구역 -->
                    <td class="align-middle text-center">
                      <p class="text-sm font-weight-bold mb-0">{{ worker.area_name }}</p>
                    </td>
                    <!-- 할당 받은 택배 -->
                    <td class="align-middle text-center">
                      <p class="text-sm font-weight-bold mb-0">{{ worker.total_count }}개</p>
                    </td>
                    <!-- 상태 -->
                    <td class="align-middle text-center">
                      <span v-if="worker.ready" class="badge badge-sm bg-gradient-success">준비 완료</span>
                      <span v-else class="badge badge-sm bg-gradient-secondary">대기</span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
