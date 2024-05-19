<script setup>
import { computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useAuthStore } from "@/store/auth";

import SidenavItem from "./SidenavItem.vue";
import SidenavCard from "./SidenavCard.vue";

const getRoute = () => {
  const route = useRoute();
  const routeArr = route.path.split("/");
  return routeArr[1];
};

const authStore = useAuthStore();
const router = useRouter();

const isLogin = computed(() => !!authStore.token);

const logout = () => {
  if (!confirm('로그아웃 하시겠습니까?')) return;
    authStore.logout();
    console.log('로그아웃');
    router.push({ path: '/' });
};
</script>
<template>
  <div
    class="collapse navbar-collapse w-auto h-auto h-100"
    id="sidenav-collapse-main"
  >
    <ul class="navbar-nav">
      <li class="nav-item">
        <sidenav-item
          to="/dashboard"
          :class="getRoute() === 'dashboard' ? 'active' : ''"
          :navText="'Dashboard'"
        >
          <template v-slot:icon>
            <i class="ni ni-tv-2 text-primary text-sm opacity-10"></i>
          </template>
        </sidenav-item>
      </li>

      <li class="nav-item">
        <sidenav-item
          to="/tables"
          :class="getRoute() === 'tables' ? 'active' : ''"
          :navText="'실시간 입고/출고'"
        >
          <template v-slot:icon>
            <i
              class="ni ni-calendar-grid-58 text-warning text-sm opacity-10"
            ></i>
          </template>
        </sidenav-item>
      </li>

      <li class="nav-item">
        <sidenav-item
          to="/workers"
          :class="getRoute() === 'billing' ? 'active' : ''"
          :navText="'배송기사 리스트'"
        >
          <template v-slot:icon>
            <i class="ni ni-credit-card text-success text-sm opacity-10"></i>
          </template>
        </sidenav-item>
      </li>

      <li class="mt-3 nav-item">

        <h6
          class="text-xs ps-4 text-uppercase font-weight-bolder opacity-6"
          :class="'ms-2'"
        >
          ACCOUNT PAGES
        </h6>
      </li>
      <li v-if="isLogin" class="nav-item">
        <sidenav-item
          to="/"
          :class="getRoute() === 'signin' ? 'active' : ''"
          :navText="'로그아웃'"
          @click="logout()"
        >
          <template v-slot:icon>
            <i class="ni ni-single-copy-04 text-danger text-sm opacity-10"></i>
          </template>
        </sidenav-item>
      </li>
    </ul>
  </div>

  <div class="pt-3 mx-3 mt-3 sidenav-footer">
    <sidenav-card
      :card="{
        title: 'Need Help?',
        description: 'Please check our docs',
        links: [
          {
            label: 'Documentation',
            route:
              'https://www.creative-tim.com/learning-lab/vue/overview/argon-dashboard/',
            color: 'dark',
          },
          {
            label: 'Buy now',
            route:
              'https://www.creative-tim.com/product/vue-argon-dashboard-pro?ref=vadp',
            color: 'success',
          },
        ],
      }"
    />
  </div>
</template>
