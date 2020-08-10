<template>
  <v-container class="register flex-column justify-around">
    <v-snackbar
      v-model="show_snackbar"
      top
      color="error"
      timeout="2500"
    >
      Usuário ou senha inválida
      <v-btn
        dark
        text
        @click="show_snackbar = false"
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
            Login
          </v-card-title>
          <ValidationObserver
            v-slot="{ handleSubmit }"
            @submit.prevent
          >
            <v-form
              ref="form"
              v-model="form_valid"
              class="ma-4"
              lazy-validation
            >
              <ValidationProvider
                v-slot="{errors, valid}"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.username"
                  :error-messages="errors"
                  :success="valid"
                  label="Usuário"
                  autofocus
                  outlined
                  prepend-inner-icon="mdi-account"
                />
              </ValidationProvider>
              <ValidationProvider
                v-slot="{errors, valid}"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.password"
                  :error-messages="errors"
                  :success="valid"
                  :append-icon="show_pass ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="show_pass ? 'text' : 'password'"
                  label="Senha"
                  outlined
                  prepend-inner-icon="mdi-key"
                  valid
                  @click:append="show_pass = !show_pass"
                  @keyup.enter="login"
                />
              </ValidationProvider>
              <v-btn
                :disabled="loading"
                :loading="loading"
                centered
                @click="handleSubmit(login)"
              >
                Login
              </v-btn>
            </v-form>
          </ValidationObserver>
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import axios from 'axios'

export default {
  name: 'LoginForm',
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data: () => ({
    form_valid: true,
    show_pass: false,
    form_data: {
      username: '',
      password: ''
    },
    select_id: 0,
    loading: false,
    show_snackbar: false
  }),
  methods: {
    login () {
      this.loading = true
      axios.post(process.env.VUE_APP_BACKENDURL + '/auth/login', {
        ...this.form_data
      }).then((response) => {
        this.show_snackbar = false
        this.$store.dispatch('session/login', response.data)
        this.$router.push('/')
      })
        .catch(() => {
          this.handleError()
          this.loading = false
        })
    },
    handleError () {
      this.show_snackbar = true
      this.resetPassword()
    },
    resetPassword () {
      this.form_data.password = ''
    }
  }
}
</script>
