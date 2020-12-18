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
            Coordenação de Cursos Ministrados
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
                  <validation-provider
                    v-slot="{ errors, valid }"
                    rules="required"
                  >
                    <v-text-field
                      v-model="form_data.name"
                      label="Nome do Curso"
                      outlined
                      prepend-inner-icon="mdi-teach"
                      :error-messages="errors"
                      :success="valid"
                    />
                  </validation-provider>
                </v-col>
                <v-col class="col-4">
                  <validation-provider
                    v-slot="{ errors, valid }"
                    rules="required|numeric"
                  >
                    <v-text-field
                      v-model="form_data.workload"
                      label="Carga Horária Total (em horas)"
                      outlined
                      prepend-inner-icon="mdi-clock"
                      :error-messages="errors"
                      :success="valid"
                    />
                  </validation-provider>
                </v-col>
              </v-row>
              <v-row>
                <v-col>
                  <data-select
                    v-model="form_data.course_classification"
                    icon="mdi-poll"
                    label="Classificação"
                    resource="course_classifications"
                    show-value="classification"
                    object
                  />
                </v-col>

                <v-col class="col-6">
                  <data-select
                    v-model="form_data.coordination_degree"
                    icon="mdi-office-building"
                    label="Nível do Curso"
                    resource="coordination_degrees"
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
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import DataSelect from '../components/DataSelect'

export default {
  name: 'NewCourseCoordination',

  components: {
    ValidationObserver,
    ValidationProvider,
    DataSelect
  },

  props: ['form_data'],

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Nome', value: 'name' },
      { text: 'Carga Horária Total', value: 'workload' },
      { text: 'Classificação', value: 'course_classification_classification' },
      { text: 'Nível', value: 'coordination_degree_degree' }
    ],
    index: 0
  }),

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (this.form_data.name &&
        this.form_data.workload &&
        this.form_data.course_classification &&
        this.form_data.coordination_degree
      ) {
        this.form_data.items = []
        this.items.push({
          index: this.index,
          ...this.form_data,
          course_classification_id: this.form_data.course_classification.value,
          course_classification_classification: this.form_data.course_classification.text,
          coordination_degree_id: this.form_data.coordination_degree.value,
          coordination_degree_degree: this.form_data.coordination_degree.text
        })
        this.form_data.items = this.items
        this.$refs.form.reset()
        this.index++
      }
    },
    removeSelected () {
      for (let i = 0; i < this.selected.length; i++) {
        this.items = this.items.filter(item => { return item.index !== this.selected[i].index })
      }
    }
  }
}
</script>
