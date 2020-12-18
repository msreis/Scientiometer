<template>
  <v-app>
    <v-app-bar
      app
      class="primary"
    >
      <v-btn
        text
        icon
        @click="drawer = !drawer"
      >
        <v-icon>mdi-menu</v-icon>
      </v-btn>
      <v-toolbar-title class="headline text-uppercase">
        <span v-if="logged_in">
          Olá,
          <span class="font-weight-bold">{{ username }}</span>
        </span>
        <span v-else>Scientiometer</span>
      </v-toolbar-title>
      <v-spacer />
      <v-btn
        v-if="logged_in"
        @click="logout"
      >
        Sair
      </v-btn>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      app
      class="top"
    >
      <v-img
        src="./assets/logo.jpg"
      />
      <v-list>
        <v-list-item
          v-for="link in links"
          :key="link.text"
          route
          :to="link.route"
          class="primary--text"
        >
          <v-list-item-avatar>
            <v-icon>{{ link.icon }}</v-icon>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title>{{ link.text }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-spacer />
        <v-list-item>
          <v-list-item-avatar>
            <v-icon>{{ $vuetify.theme.dark?"mdi-weather-night":"mdi-weather-sunny" }}</v-icon>
          </v-list-item-avatar>
          <v-list-item-action-text class="body-1">
            Tema Escuro
          </v-list-item-action-text>
          <v-list-item-action>
            <v-switch v-model="dark_theme" />
          </v-list-item-action>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-content>
      <router-view />
    </v-content>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'App',
  components: {},
  computed: {
    ...mapGetters({
      username: 'session/username',
      logged_in: 'session/logged_in',
      access_level: 'session/access_level'
    }),
    dark_theme: {
      get () {
        return this.$store.getters['general/dark_theme']
      },
      set (theme) {
        this.$store.commit('general/setDarkTheme', theme)
        this.$vuetify.theme.dark = this.dark_theme
      }
    },
    links () {
      const logged_in = this.logged_in
      const access_level = this.access_level
      return this.links_list.filter(function (link) { return (!link.if || eval(link.if)) })
    }
  },
  mounted () {
    this.$vuetify.theme.dark = this.dark_theme
  },
  data: () => ({
    drawer: true,
    links_list: [
      { icon: 'mdi-home', text: 'Home', route: '/' },
      { icon: 'mdi-account', text: 'Perfil', route: '/profile', if: 'logged_in' },
      { icon: 'mdi-account-key', text: 'Entrar', route: '/login', if: '!logged_in' },
      { icon: 'mdi-playlist-star', text: 'Minhas Submissões', route: '/my_submissions', if: 'logged_in' },
      { icon: 'mdi-playlist-edit', text: 'Submissões', route: '/review', if: 'access_level == 2 || access_level == 4' },
      { icon: 'mdi-playlist-check', text: 'Sumário de Submissões', route: '/summary', if: 'access_level >= 3' },
      { icon: 'mdi-ballot', text: 'Preencher', route: '/fill', if: 'logged_in' }
    ]
  }),
  methods: {
    logout () {
      this.$store.dispatch('session/logout', '')
      this.$router.push('/')
    }
  }
}
</script>
<style>
.top {
  z-index: 11;
}
</style>
