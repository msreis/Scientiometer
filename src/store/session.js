import { DateTime } from 'luxon'

export const sessionModule = {
  namespaced: true,
  state: {
    token: '',
    username: '',
    logged_until: null,
    access_level: 0,
    laboratory: '',
    id: ''
  },
  getters: {
    logged_in (state) {
      return DateTime.fromISO(state.logged_until) >= DateTime.local()
    },
    token (state) {
      if (DateTime.fromISO(state.logged_until) < DateTime.local()) {
        return ''
      }
      return state.token
    },
    username (state) {
      if (DateTime.fromISO(state.logged_until) < DateTime.local()) {
        return ''
      }
      return state.username
    },
    access_level (state) {
      if (DateTime.fromISO(state.logged_until) < DateTime.local()) {
        return 0
      }
      return state.access_level
    },
    laboratory (state) {
      if (DateTime.fromISO(state.logged_until) < DateTime.local()) {
        return ''
      }
      return state.laboratory
    },
    id (state) {
      if (DateTime.fromISO(state.logged_until) < DateTime.local()) {
        return ''
      }
      return state.id
    }
  },
  mutations: {
    storeJwt (state, token) {
      state.token = token
    },
    setUsername (state, username) {
      state.username = username
    },
    setLoggedIn (state, until) {
      state.logged_until = until
    },
    setPermission (state, perm) {
      state.access_level = perm
    },
    setLaboratory (state, lab) {
      state.laboratory = lab
    },
    setId (state, id) {
      state.id = id
    }
  },
  actions: {
    login ({ commit, state }, payload) {
      commit('storeJwt', payload.token)
      commit('setUsername', payload.username)
      commit('setLoggedIn', payload.exp)
      commit('setPermission', payload.permission)
      commit('setLaboratory', payload.laboratory)
      commit('setId', payload.id)
    },
    logout ({ commit }, payload) {
      commit('storeJwt', '')
      commit('setUsername', '')
      commit('setLoggedIn', null)
      commit('setPermission', 0)
      commit('setLaboratory', '')
      commit('setId', '')
    }
  }
}
