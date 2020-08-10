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
            Extensão de Auxílio
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

          <ValidationObserver
            ref="obs"
            v-slot="{ invalid, validated, passes, validate }"
          >
            <v-form
              ref="form"
              lazy-validation
              class="ma-4"
            >
              <v-row>
                <v-col>
                  <data-select
                    v-model="form_data.grant"
                    icon="mdi-numeric"
                    label="Número de Processo"
                    resource="grants"
                    show-value="process_number"
                    object
                  />
                </v-col>
              </v-row>

              <v-row>
                <v-col>
                  <year-picker
                    v-model="form_data.validity_start"
                    label="Início de Vigência da Extensão"
                    :max="max_start_date"
                  />
                </v-col>
                <v-col>
                  <year-picker
                    v-model="form_data.validity_end"
                    label="Fim de Vigência"
                    :max="max_end_date"
                  />
                </v-col>
              </v-row>

              <v-row>
                <v-col>
                  <validation-provider
                    v-slot="{ errors, valid }"
                    rules="required"
                  >
                    <v-text-field
                      v-model.lazy="form_data.value_brl"
                      :error-messages="errors"
                      :success="valid"
                      label="Valor BRL"
                      outlined
                      prepend-inner-icon="mdi-currency-brl"
                    />
                  </validation-provider>
                </v-col>
                <v-col>
                  <validation-provider
                    v-slot="{ errors, valid }"
                    rules="required"
                  >
                    <v-text-field
                      v-model.lazy="form_data.value_usd"
                      :error-messages="errors"
                      :success="valid"
                      label="Valor USD"
                      outlined
                      prepend-inner-icon="mdi-currency-usd"
                    />
                  </validation-provider>
                </v-col>
              </v-row>
              <v-btn @click="addToTable()">
                Adicionar Novo
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
import { DateTime } from 'luxon'

// Components
import DataSelect from '../components/DataSelect.vue'
import YearPicker from '../components/YearPicker.vue'

export default {
  name: 'NewGrantExtension',

  components: {
    ValidationObserver,
    ValidationProvider,
    DataSelect,
    YearPicker
  },

  props: {
    form_data: {}
  },

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Processo', value: 'process_number' },
      { text: 'Início Vigência', value: 'validity_start' },
      { text: 'Fim Vigência', value: 'validity_end' },
      { text: 'Valor BRL', value: 'value_brl' },
      { text: 'Valor USD', value: 'value_usd' }
    ],
    index: 0
  }),

  computed: {
    max_end_date () {
      return DateTime.local()
        .plus({ years: 30 })
        .toISO()
    },
    max_start_date () {
      return DateTime.local()
        .plus({ years: 5 })
        .toISO()
    }
  },

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (
        this.form_data.value_brl &&
        this.form_data.value_usd &&
        this.form_data.validity_start &&
        this.form_data.validity_end &&
        this.form_data.grant
      ) {
        this.form_data['items'] = null
        this.items.push({
          index: this.index,
          ...this.form_data,
          process_number: this.form_data.grant.text,
          grant_id: this.form_data.grant.value
        })
        this.form_data['items'] = this.items
        this.$refs.form.reset()
        this.index++
      }
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
