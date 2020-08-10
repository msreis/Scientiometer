export const generalModule = {
  namespaced: true,
  state: {
    step: 1,
    dark_theme: false
  },
  getters: {
    step (state) {
      return state.step
    },
    dark_theme (state) {
      return state.dark_theme
    }
  },
  mutations: {
    step (state, step) {
      state.step = step
    },
    setDarkTheme (state, theme) {
      state.dark_theme = theme
    }
  }
}
