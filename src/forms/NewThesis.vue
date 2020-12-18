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
            Teses, dissertações e TCCs
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
              <data-select
                v-model="form_data.advisement"
                icon="mdi-account"
                label="Aluno"
                resource="adv_by_res"
                show-value="name"
                object
              />
              <v-row>
                <v-col>
                  <v-text-field
                    v-model="form_data.delivery_date"
                    label="Data de entrega/apresentação"
                    outlined
                    prepend-inner-icon="mdi-calendar"
                    disabled
                  />
                </v-col>
                <v-col>
                  <v-date-picker
                    ref="picker"
                    v-model="form_data.delivery_date"
                    landscape
                    min="2010-01-01"
                    locale="PT-BR"
                  />
                </v-col>
              </v-row>
              <data-select
                v-model="form_data.institution"
                icon="mdi-office-building"
                label="Instituição"
                resource="institutions"
                show-value="name"
                object
              />

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
import { ValidationObserver } from 'vee-validate'
import DataSelect from '../components/DataSelect'
import { DateTime } from 'luxon'

export default {
  name: 'NewThesis',

  components: {
    ValidationObserver,
    DataSelect
  },
  props: ['form_data'],

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Aluno', value: 'name' },
      { text: 'Instituição', value: 'institution.text' },
      { text: 'Entrega/apresentação', value: 'delivery_date' }
    ],
    index: 0
  }),

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (
        this.form_data.advisement &&
        this.form_data.institution &&
        this.form_data.delivery_date
      ) {
        this.form_data['items'] = null
        this.items.push({
          index: this.index,
          name: this.form_data.advisement.text,
          institution: this.form_data.institution.text,
          ...this.form_data
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
