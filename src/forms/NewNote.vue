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
            Observações
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
                <v-textarea
                  v-model="form_data.note"
                  label="Observação"
                  outlined
                  prepend-inner-icon="mdi-account-details"
                  :error-messages="errors"
                  :success="valid"
                />
              </validation-provider>

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

export default {
  name: 'NewNote',

  components: {
    ValidationObserver,
    ValidationProvider
  },

  props: {
    form_data: {}
  },

  data: () => ({
    items: [],
    selected: [],
    headers: [{ text: 'Observação', value: 'note' }],
    index: 0
  }),
  mounted () {
    this.items = this.form_data.items || []
  },
  methods: {
    addToTable () {
      if (this.form_data.note) {
        this.form_data['items'] = null
        this.items.push({ index: this.index, ...this.form_data })
        this.$refs.form.reset()
        this.form_data['items'] = this.items
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
