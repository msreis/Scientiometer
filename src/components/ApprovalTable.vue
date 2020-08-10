<template>
  <v-data-table
    :headers="headers"
    hide-default-footer
    :items="items"
  >
  </v-data-table>
</template>

<script>
export default {
  name: 'ApprovalTable',
  props: ['item'],
  data: () => ({
    headers: [
      { value: 'account', text: 'Usuário' },
      { value: 'action', text: 'Ação' },
      { value: 'comment', text: 'Comentário' },
      { value: 'date', text: 'Data' }
    ],
    items: [
      { account: 'João', action: 'Reprovação', comment: 'Necessário inserir dados de publicações', date: '18/06/2020 às 12:00' },
      { account: 'Ana', action: 'Reprovação', comment: 'Remover dados duplicados nos congressos', date: '10/02/2020 às 07:00' },
      { account: 'Maria', action: 'Submissão', comment: 'Relatório submetido', date: '22/01/2020 às 08:00' },
      { account: 'José', action: 'Aprovação', comment: 'Relatório aprovado', date: '22/07/2020 às 05:00' },
    ]
  })
}
</script>
