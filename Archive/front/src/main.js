
import Vue from "vue";
import VueRouter from "vue-router";
import RouterPrefetch from 'vue-router-prefetch'
import App from "./App";
import router from "./router/index";
import store from './store';

import BlackDashboard from "./plugins/blackDashboard";
import i18n from "./i18n"
Vue.use(BlackDashboard);
Vue.use(VueRouter);
Vue.use(RouterPrefetch);

new Vue({
  router,
  i18n,
  store,
  render: h => h(App)
}).$mount("#app");
