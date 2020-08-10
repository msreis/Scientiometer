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
            Participação em Atividades e Serviços
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
              <validation-provider
                v-slot="{ errors, valid }"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.description"
                  label="Atividade"
                  outlined
                  prepend-inner-icon="mdi-account-details"
                  :error-messages="errors"
                  :success="valid"
                />
              </validation-provider>

              <v-row>
                <v-col>
                  <data-select
                    v-model="form_data.activity_type_id"
                    icon="mdi-presentation"
                    label="Tipo de Atividade"
                    resource="activity_types"
                    show-value="name"
                  />
                </v-col>
              </v-row>

              <v-row>
                <v-col>
                  <validation-provider
                    v-slot="{ errors, valid }"
                    rules="required|numeric"
                  >
                    <v-text-field
                      v-model="form_data.workload"
                      label="Carga Horária Total"
                      outlined
                      prepend-inner-icon="mdi-clock"
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
                      v-model="form_data.duration"
                      label="Duração em Meses"
                      outlined
                      prepend-inner-icon="mdi-calendar"
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
  name: 'NewActivity',

  components: {
    ValidationObserver,
    ValidationProvider,
    DataSelect
  },

  props: {
    form_data: {}
  },

  data: () => ({
    items: [],
    selected: [],
    headers: [{ text: 'Atividade', value: 'description' }, { text: 'Carga Horária Total', value: 'workload' }],
    index: 0
  }),

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (this.form_data.description &&
        this.form_data.workload &&
        this.form_data.activity_type_id &&
        this.form_data.duration
      ) {
        this.form_data['items'] = null
        this.items.push({ index: this.index, ...this.form_data })
        this.form_data['items'] = this.items
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
