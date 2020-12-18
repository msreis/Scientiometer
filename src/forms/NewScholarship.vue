<template>
  <v-container class="flex-column justify-around">
    <v-card class="my-4">
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
      >
        <v-row>
          <v-col>
            <data-select
              v-model="formData.funding_agency"
              icon="mdi-office-building"
              label="Agência"
              resource="funding_agencies"
              show-value="name"
              object
            />
          </v-col>

          <v-col>
            <validation-provider
              v-slot="{ errors, valid }"
              rules="required"
            >
              <v-text-field
                v-model="formData.process_number"
                label="Número do Processo"
                outlined
                prepend-inner-icon="mdi-numeric"
                :error-messages="errors"
                :success="valid"
              />
            </validation-provider>
          </v-col>
        </v-row>

        <v-row>
          <v-col>
            <year-picker
              v-model="formData.validity_start"
              label="Início de Vigência"
              :max="max_start_date"
            />
          </v-col>
          <v-col>
            <year-picker
              v-model="formData.validity_end"
              label="Fim de Vigência"
              :max="max_end_date"
            />
          </v-col>
        </v-row>
        Vencimentos e reserva gasta referentes apenas a 2019.<br>
        Se bolsa acabou antes de 2019, deixar com 0s.
        <br>
        <v-row>
          <v-col>
            <validation-provider
              v-slot="{ errors, valid }"
              rules="required"
            >
              <v-text-field
                v-model.lazy="formData.value_BRL"
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
                v-model.lazy="formData.value_USD"
                :error-messages="errors"
                :success="valid"
                label="Valor USD"
                outlined
                prepend-inner-icon="mdi-currency-usd"
              />
            </validation-provider>
          </v-col>
        </v-row>

        <validation-provider
          v-slot="{ errors, valid }"
          rules="required"
        >
          <v-text-field
            v-model.lazy="formData.technical_reserve_BRL"
            :error-messages="errors"
            :success="valid"
            label="Reserva Técnica"
            outlined
            prepend-inner-icon="mdi-currency-brl"
          />
        </validation-provider>

        <v-btn @click="addToTable()">
          Adicionar Bolsa
        </v-btn>
      </v-form>
    </ValidationObserver>
  </v-container>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { DateTime } from 'luxon'

// Components
import DataSelect from '../components/DataSelect.vue'
import YearPicker from '../components/YearPicker.vue'

export default {
  name: 'NewScholarship',

  components: {
    ValidationObserver,
    ValidationProvider,
    DataSelect,
    YearPicker
  },

  props: { formData: { default: () => ({
        value_BRL: 0,
        value_USD: 0,
        technical_reserve_BRL: 0
      }) } },

  data: () => ({
    items: [],
    selected: [],
    headers: [
      { text: 'Processo', value: 'process_number' },
      { text: 'Agência', value: 'funding_agency_name' },
      { text: 'Início Vigência', value: 'validity_start' },
      { text: 'Fim Vigência', value: 'validity_end' },
      { text: 'Valor BRL', value: 'value_BRL' },
      { text: 'Valor USD', value: 'value_USD' },
      { text: 'Reserva Técnica', value: 'technical_reserve_BRL' }
    ],
    index: 0
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

  watch: {
    items: function () {
      this.$emit('input', this.items)
    }
  },

  mounted () {
    this.items = this.formData.items || []
  },

  methods: {
    addToTable () {
      if (
        this.formData.process_number &&
        this.formData.value_BRL >= 0 &&
        this.formData.value_USD >= 0 &&
        this.formData.validity_start &&
        this.formData.validity_end &&
        this.formData.funding_agency &&
        this.formData.technical_reserve_BRL >= 0
      ) {
        this.formData['items'] = null
        this.items.push({
          index: this.index,
          ...this.formData,
          funding_agency_id: this.formData.funding_agency.value,
          funding_agency_name: this.formData.funding_agency.text })
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
    },
    reset () {
      this.items = []
    }
  }
}
</script>
