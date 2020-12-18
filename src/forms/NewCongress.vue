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
            Participação em Congressos
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
                  v-model="form_data.name"
                  label="Nome do Congresso"
                  outlined
                  prepend-inner-icon="mdi-textbox"
                  :error-messages="errors"
                  :success="valid"
                />
              </validation-provider>

              <v-row>
                <v-col>
                  <country-select v-model="form_data.country" />
                </v-col>

                <v-col>
                  <data-select
                    v-model="form_data.congress_role_obj"
                    icon="mdi-presentation"
                    label="Tipo de Participação"
                    resource="congress_roles"
                    show-value="role"
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
import CountrySelect from '../components/CountrySelect'
import DataSelect from '../components/DataSelect'

export default {
  name: 'NewCongress',

  components: {
    ValidationObserver,
    ValidationProvider,
    CountrySelect,
    DataSelect
  },

  props: ['form_data'],

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Nome', value: 'name' },
      { text: 'Participação', value: 'role' },
      { text: 'País', value: 'country' }
    ],
    form_data: {},
    index: 0
  }),

  mounted () {
    this.items = this.form_data.items || []
  },

  methods: {
    addToTable () {
      if (this.form_data.name &&
        this.form_data.country &&
        this.form_data.congress_role_obj) {
        this.form_data['items'] = null
        this.items.push({
          index: this.index,
          ...this.form_data,
          role: this.form_data.congress_role_obj.text,
          congress_role_id: this.form_data.congress_role_obj.value })
        this.$refs.form.reset()
        this.index++
      }
      this.form_data['items'] = this.items
    },
    removeSelected () {
      for (let i = 0; i < this.selected.length; i++) {
        this.items = this.items.filter(item => { return item.index !== this.selected[i].index })
      }
    }
  }
}
</script>
