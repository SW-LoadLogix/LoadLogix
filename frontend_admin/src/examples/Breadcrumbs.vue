<script setup>
import { computed, ref, onMounted  } from "vue";
import { useStore } from "vuex";

const store = useStore();
const isNavFixed = computed(() => store.state.isNavFixed);

defineProps({
  currentPage: {
    type: String,
    default: "",
  },
  currentDirectory: {
    type: String,
    default: "",
  },
});

// 현재 날짜를 저장할 변수 생성
const formattedDate = ref('');

// 컴포넌트가 마운트될 때 실행되는 함수 정의
onMounted(() => {
  // 현재 날짜를 가져와 변수에 저장하는 함수 호출
  getCurrentDate();
});

// 현재 날짜를 가져와 변수에 저장하는 함수 정의
function getCurrentDate() {
  const today = new Date();
  const year = today.getFullYear();
  const month = String(today.getMonth() + 1).padStart(2, '0');
  const day = String(today.getDate()).padStart(2, '0');
  formattedDate.value = `${year}년 ${month}월 ${day}일`;
}
</script>
<template>
  <nav aria-label="breadcrumb">
    <!-- <ol
      class="px-0 pt-1 pb-0 mb-0 bg-transparent breadcrumb"
      :class="`' me-sm-6' ${
        isNavFixed ? 'text-dark' : 'text-white'
      }`"
    >
      <li class="text-sm breadcrumb-item">
        <a
          :class="isNavFixed ? 'text-dark' : 'text-white'"
          class="opacity-8"
          href="#"
          >Pages</a
        >
      </li>
      <li
        class="text-sm breadcrumb-item active"
        :class="isNavFixed ? 'text-dark' : 'text-white'"
        aria-current="page"
      >
        {{ currentPage }}
      </li>
    </ol> -->
  <p class="mb-0 font-weight-bolder text-white">{{ formattedDate }}</p>
  <p
      class="mb-0 font-weight-bolder"
      :class="isNavFixed ? 'text-dark' : 'text-white'"
      style="font-size: 2rem;"
    >
      물류 통계 현황
  </p>
  </nav>
</template>
