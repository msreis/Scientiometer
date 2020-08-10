<template>
  <validation-provider
    v-slot="{ errors, valid }"
    rules="required"
  >
    <v-autocomplete
      v-model="val"
      :error-messages="errors"
      :items="items"
      :search-input.sync="search"
      :success="valid"
      autocomplete="off"
      item-text="translations.pt"
      item-value="alpha3Code"
      label="País"
      no-filter
      outlined
      placeholder="Digite para pesquisar..."
      prepend-inner-icon="mdi-earth"
    >
      <template v-slot:item="data">
        <v-list-item-avatar tile>
          <img :src="data.item.flag">
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title v-html="data.item.translations.pt" />
        </v-list-item-content>
      </template>
    </v-autocomplete>
  </validation-provider>
</template>

<script>
import axios from 'axios'
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'CountrySelect',

  components: {
    ValidationProvider
  },

  data: () => ({
    items: [],
    search: null,
    val: null
  }),

  watch: {
    async search (val) {
      if (!val) return

      this.items = (
        await axios.get(`https://restcountries.eu/rest/v2/name/${val}`, {
          headers: {
            'Content-Type': 'application/json;charset=UTF-8'
          }
        })
      ).data
      console.log(this.items)
    },

    val: function () {
      this.$emit('input', this.val)
    }
  }
}
</script>

<style scoped>
img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}
</style>
