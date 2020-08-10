<template>
  <v-container class="register flex-column justify-around">
    <v-row>
      <v-col />
      <v-col class="col-9">
        <v-card class="px-6 pb-6 pt-2">
          <v-card-title>Formulários Aprovados por Laboratório</v-card-title>
          <v-data-table
            :headers="headers"
            :items="items"
            search
            item-key="index"
          >
            <template v-slot:item.approved="{item}">
              <b>{{ item.approved }}</b>
            </template>

            <template v-slot:no-data>
              Sem formulários submetidos
            </template>
          </v-data-table>
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'SubmissionsDiv',
  data: () => ({
    headers: [
      { value: 'name', text: 'Laboratório' },
      { value: 'approved', text: 'Aprovados' }
    ],
    items: [
    ]
  }),
  mounted () {
    this.get_items()
  },
  methods: {
    async get_items () {
      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/submissions_summary'
      )
      this.items = response.data
      this.items.map(function (item) {
        item.approved = item.partial.toString() + '/' + item.all.toString()
      })
    }
  }
}
</script>
