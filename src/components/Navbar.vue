<template>
  <v-app>
    <v-app-bar app>
      <v-btn
        text
        icon
        color="blue-grey"
        @click="true"
      >
        <v-icon>mdi-menu</v-icon>
      </v-btn>
      <v-toolbar-title class="headline text-uppercase blue-grey--text">
        <span>Olá, </span>
        <span class="font-weight-bold">{{ username }}</span>
      </v-toolbar-title>
    </v-app-bar>
  </v-app>
</template>

<script>
export default {
  name: 'Navbar',
  data: () => ({
    username: 'Researcher'
  })
}
</script>
