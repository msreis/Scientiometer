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
            Bolsas de Produtividade
          </v-card-title>

          <v-card class="ma-4">
            <v-data-table
              ref="table"
              v-model="selected"
              :headers="headers"
              :items="items"
              hide-default-footer
              item-key="index"
              show-select
              @click:row="show_selected"
            />

            <v-btn
              :color="selected.length == 0 ? '': 'error'"
              :disabled="items.length == 0"
              class="ma-4"
              @click="removeSelected()"
            >
              Remover
            </v-btn>
          </v-card>

          <v-form
            ref="form"
            v-model="form_valid"
            lazy-validation
            class="ma-4"
          >
            <v-row>
              <v-col class="col-8">
                <data-select
                  v-model="form_data.cnpq_level"
                  icon="mdi-poll"
                  label="Nível de bolsa CNPQ"
                  resource="cnpq_levels"
                  show-value="level"
                  object
                />
              </v-col>
              <v-col>
                <v-checkbox
                  v-model="form_data.is_fb"
                  label="Bolsa da Fundação Butantan"
                />
              </v-col>
            </v-row>

            <v-row>
              <v-col>
                <validation-provider
                  v-slot="{ errors, valid }"
                  rules="required"
                >
                  <year-picker
                    v-model="form_data.validity_start"
                    :max="new Date().toISOString().substr(0, 10)"
                    min="1950-01-01"
                    label="Início da vigência"
                    :error-messages="errors"
                    :success="valid"
                  />
                </validation-provider>
              </v-col>

              <v-col>
                <validation-provider
                  v-slot="{ errors, valid }"
                  rules="required"
                >
                  <year-picker
                    v-model="form_data.validity_end"
                    :max="max_end_date"
                    :min="form_data.validity_start"
                    label="Término da vigência"
                    :error-messages="errors"
                    :success="valid"
                  />
                </validation-provider>
              </v-col>
            </v-row>

            <v-btn @click="addToTable()">
              Adicionar Novo
            </v-btn>
          </v-form>
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
import DataSelect from '../components/DataSelect'
import YearPicker from '../components/YearPicker.vue'
import { DateTime } from 'luxon'
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'NewProdGrant',

  components: {
    DataSelect,
    YearPicker,
    ValidationProvider
  },

  props: {
    propObj: {
      default: false
    },
    form_data: {}
  },

  data: () => ({
    form_valid: false,
    headers: [{
      text: 'Nível',
      value: 'cnpq_level.text'
    }],
    items: [],
    index: 0,
    selected: []
  }),

  computed: {
    max_end_date () {
      let dt = DateTime.local()
      dt = dt.plus({ years: 30 })
      return dt.toISO()
    }
  },

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (
        this.form_data.cnpq_level &&
        this.form_data.validity_start &&
        this.form_data.validity_end
      ) {
        this.form_data['items'] = null
        this.items.push({
          index: this.index,
          ...this.form_data
        })
        this.form_data['items'] = this.items
        this.$refs.form.reset()
        this.index++
      }
    },
    show_selected (item) {
      this.$refs.form.reset()
      this.form_data = item
    },
    removeSelected () {
      for (let i = 0; i < this.selected.length; i++) {
        this.items = this.items.filter(item => {
          return item.index !== this.selected[i].index
        })
      }
    }
  }
}
</script>
