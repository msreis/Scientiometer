<template>
  <ValidationProvider
    v-slot="{ errors, valid }"
    :name="label"
    :rules="rules"
  >
    <v-autocomplete
      v-model="value"
      :error-messages="errors"
      :items="data"
      :label="label"
      :prepend-inner-icon="icon"
      :return-object="object"
      :success="valid"
      placeholder="Digite para buscar"
      outlined
      v-bind="$attrs"
      :loading="awaitingData"
      @focus="getData"
    >
      <template v-slot:no-data>
        <v-list-item>
          <v-list-item-title>{{ message }}</v-list-item-title>
        </v-list-item>
      </template>
    </v-autocomplete>
  </ValidationProvider>
</template>

<script>
import axios from 'axios'
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'DataSelect',

  components: {
    ValidationProvider
  },

  props: { 'value': {}, 'resource': {}, 'label': {}, 'showValue': {}, 'icon': {}, 'object': { default: () => false }, 'rules': { default: 'required' } },

  data: () => ({
    selected: null,
    data: [],
    awaitingData: false,
    message: ''
  }),

  watch: {
    selected: function () {
      this.$emit('input', this.selected)
    },
    value: function () {
      this.selected = this.value
    }
  },

  beforeMount () {
    this.getData()
  },

  methods: {
    async getData () {
      console.log('getting data')

      this.awaitingData = true
      this.message = 'Carregando dados...'

      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/' + this.resource
      )

      if (response) {
        this.data = response.data.map(item => {
          return { text: item[this.showValue], value: item.id }
        })
        if (this.data.length === 0) { this.message = 'Sem dados' }
      }

      this.awaitingData = false
    }
  }
}
</script>
