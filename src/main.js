import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import { setAxiosStore } from './axios-setup'
import './registerServiceWorker'
import './vee-validate'
import vuetify from './plugins/vuetify'
import VueTheMask from 'vue-the-mask'
import money from 'v-money'

Vue.config.productionTip = false

setAxiosStore(store)

Vue.use(VueTheMask)
Vue.use(money)

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
