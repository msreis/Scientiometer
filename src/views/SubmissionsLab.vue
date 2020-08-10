<template>
  <v-container class="register flex-column justify-around">
    <v-row>
      <v-col />
      <v-col class="col-9">
        <v-card class="px-6 pb-6 pt-2">
          <v-card-title>Aprovação de Formulários</v-card-title>
          <v-data-table
            :headers="headers"
            :items="items"
            item-key="id"
            :loading="loading"
            show-expand
            single-expand
          >
            <template v-slot:top>
              <v-dialog
                v-model="dialog"
                max-width="500px"
              >
                <template v-slot:activator="{ on, attrs }" />
                <v-card>
                  <v-card-title>{{ cardTitle }}</v-card-title>
                  <v-card-text>Essa ação não poderá ser desfeita.</v-card-text>
                  <v-card-text>
                    <v-textarea
                      v-model="comment"
                      outlined
                      placeholder="Comentário"
                    />
                  </v-card-text>
                  <v-divider />

                  <v-card-actions>
                    <v-spacer />
                    <v-btn
                      color="primary"
                      text
                      @click="dialog = false"
                    >
                      Cancelar
                    </v-btn>
                    <v-card-actions>
                      <v-btn
                        :class="button.class"
                        @click="action(mode, editedItem.id)"
                      >
                        {{ button.text }}
                      </v-btn>
                    </v-card-actions>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </template>

            <template v-slot:item.accepted="{ item }">
              <v-icon>
                {{ item.accepted === true ?
                  "mdi-check-outline":
                  "mdi-close-outline" }}
              </v-icon>
            </template>

            <template v-slot:item.preview="{ item }">
              <v-dialog>
                <template v-slot:activator="{ on }">
                  <v-icon
                    v-on="on"
                  >
                    mdi-eye
                  </v-icon>
                </template>
                <v-card>
                  <FormStepper
                    :submission="item.id"
                    :editable="false"
                  />
                </v-card>
              </v-dialog>
            </template>

            <template v-slot:item.reprove="{ item }">
              <v-icon
                v-if="item.submitted && !item.accepted"
                @click="reproveItem(item)"
              >
                mdi-thumb-down
              </v-icon>
            </template>

            <template v-slot:item.approve="{ item }">
              <v-icon
                v-if="item.submitted && !item.accepted"
                @click="approveItem(item)"
              >
                mdi-thumb-up
              </v-icon>
            </template>

            <template v-slot:expanded-item="{ headers, item }">
              <td :colspan="headers.length">
                <ApprovalTable :item="item" />
              </td>
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
import { DateTime } from 'luxon'
import store from '@/store'
import FormStepper from '@/views/FormStepper'
import ApprovalTable from '@/components/ApprovalTable.vue'

export default {
  name: 'SubmissionsLab',
  components: {
    FormStepper,
    ApprovalTable
  },
  data: () => ({
    dialog: false,
    headers: [
      { value: 'name', text: 'Pesquisador' },
      { value: 'last', text: 'Última Modificação' },
      { value: 'accepted', text: 'Aceito' },
      { value: 'preview', text: '', sortable: false },
      { value: 'reprove', text: '', sortable: false },
      { value: 'approve', text: '', sortable: false }
    ],
    items: [],
    laboratory: store.state.session.laboratory,
    loading: false,
    editedItem: {},
    mode: '',
    cardTitle: '',
    button: {
      class: '',
      text: ''
    },
    comment: null
  }),

  created () {
    this.get_items()
  },

  methods: {
    async get_items () {
      this.loading = true
      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/sub_by_lab/' + this.laboratory
      )
      console.log(response)
      this.items = response.data
      this.items.map(function (item) {
        item.last = DateTime
          .fromISO(item.last)
          .setLocale('br')
          .toFormat("dd/MM/yyyy 'às' HH:mm")
      })
      this.loading = false
    },

    reproveItem (item) {
      this.editedItem = Object.assign({}, item)
      this.comment = null
      this.mode = 'reprove'
      this.cardTitle = 'Reprovar Formulário?'
      this.button = {
        class: 'error',
        text: 'Reprovar'
      }
      this.dialog = true
    },

    approveItem (item) {
      this.editedItem = Object.assign({}, item)
      this.comment = null
      this.mode = 'approve'
      this.cardTitle = 'Aprovar Formulário?'
      this.button = {
        class: 'info',
        text: 'Aprovar'
      }
      this.dialog = true
    },

    action (mode, id) {
      this.dialog = false
      switch (mode) {
        case 'approve': this.approve(id)
          break
        case 'reprove': this.reprove(id)
          break
      }
      this.$router.push('/review')
    },

    async approve (id) {
      console.log('aprovado ' + id + ' ' + this.comment)
      const response = await axios.post(process.env.VUE_APP_BACKENDURL + /accept/ + id, { comment: this.comment })
      console.log(response)
    },

    async reprove (id) {
      await console.log('reprovado ' + id + ' ' + this.comment)
      const response = await axios.post(process.env.VUE_APP_BACKENDURL + /reprove/ + id, { comment: this.comment })
      console.log(response)
    }
  }
}
</script>
