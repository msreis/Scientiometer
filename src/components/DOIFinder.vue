
<template>
  <div>
    <template v-if="doi_metadata.doi.length > 0 && !loading">
      <p v-if="doi_metadata && doi_metadata.title">
        Título:
        <b>{{ doi_metadata.title }}</b>
      </p>

      <p v-if="doi_metadata.authors.length > 0">
        Autores:
      </p>

      <div v-if="doi_metadata">
        <div
          v-for="author in doi_metadata.authors"
          :key="author.given_name + author.surname"
        >
          <b>{{ author.given_name }} {{ author.surname }}</b>
        </div>
      </div>
    </template>
    <v-skeleton-loader
      v-if="loading"
      type="paragraph"
    />
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'DOIFinder',
  props: ['doi'],
  data: () => ({
    doi_metadata: { doi: '', title: null, authors: [] },
    loading: false
  }),
  watch: {
    async doi () {
      this.loading = true

      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/doi?doi=' + this.doi
      )
      this.doi_metadata = response.data

      this.loading = false
    },
    doi_metadata () {
      this.$emit('input', this.doi_metadata)
    }
  }
}
</script>
