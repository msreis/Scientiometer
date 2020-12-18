<template>
  <div>
    <v-data-table
      :headers="headers"
      hide-default-footer
      :items="items"
      :loading="loading"
      sort-by="created"
      sort-desc
    />
  </div>
</template>

<script>
import axios from 'axios'
import { DateTime } from 'luxon'

export default {
  name: 'ApprovalTable',
  props: ['item'],
  data: () => ({
    loading: false,
    headers: [
      { value: 'account', text: 'Usuário' },
      { value: 'action', text: 'Ação' },
      { value: 'comment', text: 'Comentário' },
      { value: 'created', text: 'Data' }
    ],
    items: []
  }),

  mounted () {
    this.get_approvals()
  },

  methods: {
    async get_approvals () {
      this.loading = true
      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/approval_histories/submissions/' + this.item.id
      )
      this.loading = false
      this.items = response.data
      this.items.map((item) => {
        item.created = DateTime
          .fromISO(item.created)
          .setLocale('br')
          .toFormat("dd/MM/yyyy 'às' HH:mm")
      })
    }
  }
}
</script>
