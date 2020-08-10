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
            Credenciamento em Programas de Pós-Graduação
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
                v-model="form_data.postgraduate_program"
                icon="mdi-script"
                label="Programa"
                resource="postgraduate_programs"
                show-value="name"
                object
              />
              <v-row>
                <v-col>
                  <data-select
                    v-model="form_data.institution"
                    icon="mdi-office-building"
                    label="Instituição"
                    resource="institutions"
                    show-value="name"
                    object
                  />
                </v-col>

                <v-col>
                  <data-select
                    v-model="form_data.degree"
                    icon="mdi-certificate"
                    label="Nível"
                    resource="course_degrees"
                    show-value="degree"
                    object
                  />
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
import { ValidationObserver } from 'vee-validate'
import DataSelect from '../components/DataSelect'

export default {
  name: 'NewAccreditation',

  components: {
    ValidationObserver,
    DataSelect
  },
  props: ['form_data'],

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Nome', value: 'name' },
      { text: 'Instituição', value: 'institution' }
    ],
    index: 0
  }),

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (
        this.form_data.postgraduate_program &&
        this.form_data.institution &&
        this.form_data.degree
      ) {
        this.form_data['items'] = null
        this.items.push({
          index: this.index,
          name: this.form_data.postgraduate_program.text,
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
