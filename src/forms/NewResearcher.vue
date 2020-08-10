<template>
  <v-container class="register flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <ValidationObserver
          ref="obs"
          v-slot="{ invalid, validated, passes, validate }"
        >
          <v-card outlined>
            <v-card-title headline>
              Cadastro Pesquisador
            </v-card-title>
            <v-form
              ref="form"
              v-model="form_valid"
              lazy-validation
              class="pa-4"
            >
              <ValidationProvider
                v-slot="{ errors, valid }"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.name"
                  outlined
                  label="Nome"
                  prepend-inner-icon="mdi-face"
                  :error-messages="errors"
                  :success="valid"
                />
              </ValidationProvider>

              <data-select
                v-model="form_data.role_foundation_level_id"
                icon="mdi-account-badge"
                label="Nível PQ ou Cargo Fundação"
                resource="role_foundation_levels"
                show-value="description"
                rules="required"
              />

              <data-select
                v-model="form_data.title_id"
                icon="mdi-certificate"
                label="Título"
                resource="titles"
                show-value="name"
                rules="required"
              />

              <data-select
                v-model="form_data.laboratory_id"
                icon="mdi-office-building"
                label="Laboratório"
                resource="laboratories"
                show-value="name"
                rules="required"
              />

              <data-select
                v-model="form_data.post_doc_type_id"
                icon="mdi-post"
                label="Tipo de Pósdoc"
                resource="post_doc_types"
                show-value="postdoc_type"
                rules="required"
              />

              <ValidationProvider
                v-slot="{ errors, valid }"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.researcher_id"
                  label="Researcher ID"
                  outlined
                  prepend-inner-icon="mdi-numeric"
                  :error-messages="errors"
                  :success="valid"
                />
              </ValidationProvider>

              <ValidationProvider
                v-slot="{ errors, valid }"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.orcid"
                  v-mask="`####-####-####-###X`"
                  label="ORCID"
                  outlined
                  prepend-inner-icon="mdi-numeric"
                  :error-messages="errors"
                  :success="valid"
                />
              </ValidationProvider>

              <ValidationProvider
                v-slot="{ errors, valid }"
                rules="required|email"
              >
                <v-text-field
                  v-model="form_data.email"
                  label="E-mail"
                  outlined
                  prepend-inner-icon="mdi-email"
                  :error-messages="errors"
                  :success="valid"
                />
              </ValidationProvider>

              <v-menu
                ref="menu"
                v-model="menu"
                :close-on-content-click="false"
                min-width="290px"
                offset-y
                transition="scale-transition"
              >
                <template v-slot:activator="{ on }">
                  <ValidationProvider
                    v-slot="{ errors, valid }"
                    rules="required"
                  >
                    <v-text-field
                      v-model="form_data.ingress_date"
                      label="Data de Ingresso"
                      outlined
                      prepend-inner-icon="mdi-calendar"
                      readonly
                      :error-messages="errors"
                      :success="valid"
                      v-on="on"
                    />
                  </ValidationProvider>
                </template>

                <v-date-picker
                  ref="picker"
                  v-model="form_data.ingress_date"
                  :max="new Date().toISOString().substr(0, 10)"
                  min="1950-01-01"
                  locale="PT-BR"
                />
              </v-menu>
            </v-form>
          </v-card>
        </ValidationObserver>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios'
import DataSelect from '../components/DataSelect.vue'
import { mask } from 'vue-the-mask'
import { ValidationObserver, ValidationProvider } from 'vee-validate'

export default {
  name: 'RegisterForm',
  components: {
    DataSelect,
    ValidationProvider,
    ValidationObserver
  },

  directives: { mask },

  props: ['form_data'],

  data: () => ({
    form_valid: false,
    menu: false
  }),

  watch: {
    menu (val) {
      val && setTimeout(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },

  methods: {
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
