import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import store from "./store";
import router from "./router";
import "./assets/css/nucleo-icons.css";
import "./assets/css/nucleo-svg.css";
import ArgonDashboard from "./argon-dashboard";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate"; //새로고침시 데이터 유지를 위한 설정

const app = createApp(App);

const pinia = createPinia();
pinia.use(piniaPluginPersistedstate); //새로고침시 데이터 유지를 위한 설정

app.use(pinia);
app.use(store);
app.use(router);
app.use(ArgonDashboard);
app.mount("#app");
