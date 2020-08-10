<template>
  <v-container class="flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
        sm="12"
      >
        <v-card outlined>
          <v-card-title headline>
            Cadastro de Alunos
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
            v-slot="{invalid, validated, passes, validate}"
          >
            <v-form
              ref="form"
              lazy-validation
              class="ma-4"
            >
              <validation-provider
                v-slot="{errors, valid}"
                rules="required"
              >
                <v-text-field
                  v-model.lazy="form_data.name"
                  :error-messages="errors"
                  :success="valid"
                  label="Nome do Aluno"
                  outlined
                  prepend-inner-icon="mdi-face"
                />
              </validation-provider>

              <data-select
                v-model="form_data.advisement_degree"
                icon="mdi-certificate"
                label="Nível"
                object
                resource="advisement_degrees"
                show-value="degree"
              />

              <v-row>
                <v-col>
                  <year-picker
                    v-model="form_data.validity_start"
                    label="Início de Vínculo Butantan"
                    :max="max_start_date"
                  />
                </v-col>
                <v-col>
                  <year-picker
                    v-model="form_data.validity_end"
                    label="Fim de Vínculo Butantan"
                    :max="max_end_date"
                  />
                </v-col>
              </v-row>

              <v-checkbox
                v-model="has_scholarship"
                label="Aluno possui(possuiu) bolsa"
                :value="zero"
              />

              <v-expansion-panels
                v-model="has_scholarship"
                class="mb-4"
                multiple
              >
                <v-expansion-panel>
                  <v-expansion-panel-header>Bolsas do Aluno</v-expansion-panel-header>
                  <v-expansion-panel-content class="pa-0">
                    <new-scholarship
                      ref="sch"
                      v-model="form_data.scholarships"
                    />
                  </v-expansion-panel-content>
                </v-expansion-panel>
              </v-expansion-panels>

              <v-row>
                <v-col class="col-2">
                  <v-checkbox
                    v-model="postdoc"
                    label="Orientado por Pósdoc"
                  />
                </v-col>
                <v-col>
                  <data-select
                    v-model="form_data.postdoc_id"
                    icon="mdi-teach"
                    label="Orientador Pósdoc"
                    resource="postdocs"
                    show-value="name"
                    :disabled="!postdoc"
                  />
                </v-col>
              </v-row>

              <v-btn @click="addToTable()">
                Adicionar Aluno
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

import YearPicker from '../components/YearPicker.vue'
import DataSelect from '../components/DataSelect.vue'
import NewScholarship from '../forms/NewScholarship.vue'

export default {
  name: 'NewAdvisement',

  components: {
    ValidationObserver,
    ValidationProvider,
    DataSelect,
    NewScholarship,
    YearPicker
  },

  props: ['form_data'],

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Nome', value: 'name' },
      { text: 'Nível', value: 'advisement_degree.text' },
      { text: 'Bolsas', value: 'nScholarships' }
    ],
    index: 0,
    has_scholarship: [],
    zero: 0,
    postdoc: false
  }),

  computed: {
    max_end_date () {
      return DateTime.local()
        .set({ day: 1, month: 1 })
        .plus({ years: 30 })
        .toISO()
    },
    max_start_date () {
      return DateTime.local()
        .set({ day: 1, month: 1 })
        .plus({ years: 5 })
        .toISO()
    }
  },

  mounted () {
    // Hack to declare method of child component while it is not loaded (i.e.
    // tab not opened, or not expanded)
    this.$refs.sch = {}
    this.$refs.sch.reset = () => {}
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (!this.form_data.scholarships) this.form_data.scholarships = []
      console.log(this.form_data)
      if (this.form_data.name && this.form_data.advisement_degree) {
        this.form_data.items = null
        this.items.push({
          index: this.index,
          ...this.form_data,
          nScholarships: this.form_data.scholarships.length,
          postdoc: this.postdoc
        })
        this.form_data.items = this.items
        this.$refs.form.reset()
        this.$refs.sch.reset()
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
