import Vue from 'vue'
import Vuex from 'vuex'
import { sessionModule } from './store/session'
import { generalModule } from './store/general'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    session: sessionModule,
    general: generalModule
  },
  plugins: [createPersistedState()]
})
