<template>
  <div>
    <v-card class="my-4">
      <v-card-title class="title">
        {{ label }}
      </v-card-title>
      <v-data-table
        ref="table"
        v-model="marked"
        :headers="headers"
        :items="selected"
        hide-default-footer
        item-key="value"
        show-select
      >
        <template v-slot:no-data>
          <span>Nenhum selecionado</span>
        </template>
      </v-data-table>

      <v-btn
        :color="marked.length == 0 ? '': 'error'"
        :disabled="selected.length == 0"
        class="ma-4"
        @click="removeSelected()"
      >
        Remover
      </v-btn>
      <v-autocomplete
        v-model="selected"
        :items="data"
        :label="label"
        :prepend-inner-icon="icon"
        return-object
        outlined
        placeholder="Digite para buscar"
        multiple
        v-bind="$attrs"
        :loading="awaitingData"
        class="mx-4"
        @focus="getData"
      >
        <template v-slot:no-data>
          <v-list-item>
            <v-list-item-title>{{ message }}</v-list-item-title>
          </v-list-item>
        </template>

        <template v-slot:selection="{ item, index }">
          <span
            v-if="index == 0"
            class="grey--text"
          >Digite para buscar</span>
        </template>
      </v-autocomplete>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios'
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'MultiSelect',

  components: {
    ValidationProvider
  },

  props: {
    resource: {},
    label: {},
    showValue: {},
    item_key: {},
    icon: {},
    object: { default: () => false },
    rules: { default: 'required' },
    headers: {
      type: Array,
      default: () => []
    }
  },

  data: () => ({
    marked: [],
    selected: [],
    data: [],
    awaitingData: false,
    message: ''
  }),

  watch: {
    selected: function () {
      this.$emit('input', this.selected)
    }
  },

  methods: {
    async getData () {
      this.awaitingData = true
      this.message = 'Carregando dados...'

      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/' + this.resource
      )

      if (response) {
        this.data = response.data.map(item => {
          return { text: item[this.showValue], value: item.id }
        })
        if (this.data.length === 0) {
          this.message = 'Sem dados'
        }
      }

      this.awaitingData = false
    },
    removeSelected () {
      for (let i = 0; i < this.marked.length; i++) {
        this.selected = this.selected.filter(item => {
          return item.index !== this.marked[i].index
        })
      }
      this.marked = []
    }
  }
}
</script>
