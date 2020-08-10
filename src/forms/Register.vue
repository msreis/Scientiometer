<template>
  <v-container class="register flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card outlined>
          <v-card-title headline>
            Nova conta
          </v-card-title>
          <v-form
            ref="form"
            v-model="form_valid"
            lazy-validation
            class="ma-4"
          >
            <v-text-field
              v-model="form_data.username"
              label="Usuário"
              outlined
              prepend-inner-icon="mdi-account"
              valid
            />

            <v-text-field
              ref="password"
              v-model="form_data.password"
              :append-icon="show_pass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show_pass ? 'text' : 'password'"
              label="Senha"
              outlined
              prepend-inner-icon="mdi-key"
              valid
              @click:append="show_pass = !show_pass"
            />

            <v-text-field
              v-model="form_data.password_confirmation"
              :append-icon="show_pass ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show_pass ? 'text' : 'password'"
              label="Repetir Senha"
              outlined
              prepend-inner-icon="mdi-key"
              valid
              @click:append="show_pass = !show_pass"
            />

            <v-select
              v-model="form_data.profile_id"
              :items="profiles"
              label="Perfil"
              outlined
              prepend-inner-icon="mdi-account-badge-horizontal"
              valid
            />

            <v-btn @click="createAccount">
              Criar conta
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
  name: 'RegisterForm',
  data: () => ({
    form_valid: false,
    form_data: {
      username: '',
      password: '',
      password_confirmation: '',
      profile_id: 0
    },
    show_pass: false,
    profiles: []
  }),

  mounted () {
    console.log('mounted')
    this.getProfiles()
  },

  methods: {
    async getProfiles () {
      console.log('getting profiles')
      const response = await axios.get(process.env.VUE_APP_BACKENDURL + '/profiles')
      if (response) {
        this.profiles = response.data.map(profile => {
          return { text: profile.name, value: profile.id }
        })
      }
    },

    async createAccount () {
      console.log('Create account')
      const response = await axios.post(process.env.VUE_APP_BACKENDURL + '/accounts', {
        ...this.form_data
      })
      console.log(response)
    }
  }
}
</script>
