<script setup>
import { computed } from "vue";
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
    <p
      class="mb-0 font-weight-bolder"
      :class="isNavFixed ? 'text-dark' : 'text-white'"
      style="font-size: 2rem;"
    >
      물류 통계 현황
  </p>
  </nav>
</template>
