<script setup>
import { computed } from "vue";
import { useStore } from "vuex";
const store = useStore();

const layout = computed(() => store.state.layout);
defineProps({
  card: {
    type: Object,
    required: true,
    title: String,
    description: String,
    links: {
      type: Array,
      label: String,
      route: String,
      color: String,
    },
  },
});
</script>
<template>
  <div
    v-show="layout !== 'landing'"
    class="card card-plain shadow-none"
    id="sidenavCard"
    style="margin-top: 100px;"
  >


    <a
      href="https://loadlogix.store"
      target="_blank"
      class="mb-3 btn btn-dark btn-sm w-100"
    >
      기사 전용 사이트로 이동
    </a>
  </div>
</template>
