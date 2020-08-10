<template>
  <v-container class="register flex-column justify-around">
    <v-snackbar
      v-model="snackbar.show"
      top
      :color="snackbar.color"
      :timeout="timeout"
    >
      {{ snackbar.message }}
      <v-btn
        dark
        text
        @click="snackbar.show = false"
      >
        Fechar
      </v-btn>
    </v-snackbar>
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card outlined>
          <v-card-title headline>
            Perfil
          </v-card-title>
          <v-form
            ref="form"
            lazy-validation
            class="pa-4"
          >
            <v-text-field
              v-model="username"
              label="Usuário"
              disabled
              prepend-inner-icon="mdi-face"
              outlined
            />
            <v-text-field
              v-model="current_password"
              :append-icon="show_pass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show_pass ? 'text' : 'password'"
              label="Senha atual"
              outlined
              prepend-inner-icon="mdi-key"
              @click:append="show_pass = !show_pass"
            />
            <v-text-field
              v-model="password"
              :append-icon="show_pass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show_pass ? 'text' : 'password'"
              label="Nova senha"
              outlined
              prepend-inner-icon="mdi-key"
              @click:append="show_pass = !show_pass"
            />
            <v-btn
              color="primary"
              :disabled="loading"
              :loading="loading"
              centered
              @click="updateAccount"
            >
              Atualizar
            </v-btn>
          </v-form>
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>

import axios from 'axios'

export default {
  name: 'Profile',
  data: () => ({
    timeout: 2500,
    loading: false,
    current_password: null,
    password: null,
    show_pass: false,
    username: '',
    id: '',
    snackbar: {
      show: false,
      color: null,
      message: null
    }
  }),
  mounted () {
    this.username = this.$store.state.session.username
    this.id = this.$store.state.session.id
  },
  methods: {
    updateAccount () {
      this.loading = true
      axios.put(process.env.VUE_APP_BACKENDURL + '/accounts/' + this.id, {
        'current_password': this.current_password,
        'password': this.password
      })
        .then(() => this.handleSuccess())
        .catch(() => this.handleError())
    },
    handleSuccess () {
      this.snackbar.show = true
      this.snackbar.color = 'alert'
      this.snackbar.message = 'Atualizado com sucesso'
      this.loading = false
      this.reset_form()
    },
    handleError () {
      this.snackbar.show = true
      this.snackbar.color = 'error'
      this.snackbar.message = 'Erro. Tente novamente'
      this.loading = false
      this.reset_form()
    },
    reset_form () {
      this.current_password = null
      this.password = null
    }
  }
}
</script>
