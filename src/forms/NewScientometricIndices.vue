<template>
  <v-container class="flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card outlined>
          <v-card-title headline>
            Índices Cientométricos
          </v-card-title>
          <v-form
            ref="form"
            v-model="form_valid"
            lazy-validation
            class="ma-4"
          >
            <v-row>
              <v-col>
                <validation-provider
                  v-slot="{ errors, valid }"
                  rules="required|numeric"
                >
                  <v-text-field
                    v-model="form_data.citations_wos"
                    label="Total de citações WoS"
                    outlined
                    prepend-inner-icon="mdi-counter"
                    :error-messages="errors"
                    :success="valid"
                  />
                </validation-provider>
              </v-col>

              <v-col>
                <validation-provider
                  v-slot="{ errors, valid }"
                  rules="required|numeric"
                >
                  <v-text-field
                    v-model="form_data.citations_gs"
                    label="Tot. cit. Google Scholar"
                    outlined
                    prepend-inner-icon="mdi-counter"
                    :error-messages="errors"
                    :success="valid"
                  />
                </validation-provider>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <validation-provider
                  v-slot="{ errors, valid }"
                  rules="required|numeric"
                >
                  <v-text-field
                    v-model="form_data.h_index_wos"
                    label="Índice H WoS"
                    outlined
                    prepend-inner-icon="mdi-numeric"
                    :error-messages="errors"
                    :success="valid"
                  />
                </validation-provider>
              </v-col>

              <v-col>
                <validation-provider
                  v-slot="{ errors, valid }"
                  rules="required|numeric"
                >
                  <v-text-field
                    v-model="form_data.h_index_gs"
                    label="Índice H Google Scholar"
                    outlined
                    prepend-inner-icon="mdi-numeric"
                    :error-messages="errors"
                    :success="valid"
                  />
                </validation-provider>
              </v-col>
            </v-row>

            <data-select
              v-model="form_data.primary_line_of_research_id"
              label="Linha de Pesquisa Primára"
              outlined
              icon="mdi-file-tree"
              show-value="name"
              resource="line_of_researches"
            />

            <data-select
              v-model="form_data.secondary_line_of_research_id"
              label="Linha de Pesquisa Secundária"
              outlined
              icon="mdi-file-tree"
              show-value="name"
              resource="line_of_researches"
            />
          </v-form>
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
import createItem from '../plugins/createItem'
import { ValidationProvider } from 'vee-validate'
import DataSelect from '../components/DataSelect'

export default {
  name: 'NewLaboratory',
  components: {
    ValidationProvider,
    DataSelect
  },

  props: ['form_data'],

  data: () => ({
    form_valid: false
  }),

  methods: {
    create () {
      const response = createItem(this.form_data, 'laboratories')
      console.log(response)
    }
  }
}
</script>
