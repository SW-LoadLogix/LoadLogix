<script setup>
import { computed } from "vue";
import { useStore } from "vuex";
import SidenavList from "./SidenavList.vue";
// import logo from "@/assets/img/logo-ct-dark.png";
// import logoWhite from "@/assets/img/logo-ct.png";
import loadLogixLogo from "@/assets/img/logos/logo.png";


const store = useStore();
const layout = computed(() => store.state.layout);
const sidebarType = computed(() => store.state.sidebarType);
const darkMode = computed(() => store.state.darkMode);
</script>
<template>
  <div
    v-show="layout === 'default'"
    class="min-height-300 position-absolute w-100"
    :class="`${darkMode ? 'bg-transparent' : 'bg-success'}`"
  />

  <aside
    class="my-3 overflow-auto border-0 sidenav navbar navbar-vertical navbar-expand-xs border-radius-xl"
    :class="`fixed-start ms-3    
      ${
        layout === 'landing' ? 'bg-transparent shadow-none' : ' '
      } ${sidebarType}`"
    id="sidenav-main"
  >
  <div
      class="sidenav-header"
      style="display: flex; align-items: center; justify-content: center; height: 100px;"
    >
      <router-link
        class="m-0 navbar-brand"
        style="display: flex; align-items: center; justify-content: center; height: 100%; width: 100%;"
        to="/"
      >
        <img
          :src="loadLogixLogo"
          style="max-width: 100%; max-height: 100%; object-fit: contain;"
          alt="LOADLOGIX"
        />
      </router-link>
    </div>

    <hr class="mt-0 horizontal dark" />

    <sidenav-list />
  </aside>
</template>
