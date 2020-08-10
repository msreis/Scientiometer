<template>
  <v-container class="register flex-column justify-around">
    <v-row>
      <v-col />
      <v-col class="col-9">
        <v-card class="px-6 pb-6 pt-2">
          <v-card-title>Meus Formulários</v-card-title>
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
                  <v-card-title>Submeter formulário?</v-card-title>
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
                        color="primary"
                        @click="submit(editedItem.id)"
                      >
                        Submeter
                      </v-btn>
                    </v-card-actions>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </template>

            <template v-slot:item.preview="{ item }">
              <v-dialog>
                <template v-slot:activator="{ on }">
                  <v-icon
                    v-on="on"
                  >
                    {{ item.accepted || item.submitted ?
                      "mdi-eye":
                      "mdi-pencil" }}
                  </v-icon>
                </template>
                <v-card>
                  <FormStepper
                    :submission="item.id"
                    :editable="!item.accepted && !item.submitted"
                  />
                </v-card>
              </v-dialog>
            </template>

            <template v-slot:item.accepted="{ item }">
              <v-icon>
                {{ item.accepted ?
                  "mdi-check-outline":
                  "mdi-close-outline" }}
              </v-icon>
            </template>

            <template v-slot:item.submit="{ item }">
              <v-icon
                v-if="!item.accepted && !item.submitted"
                @click="submitItem(item)"
              >
                mdi-arrow-up
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
import { mapGetters } from 'vuex'

import FormStepper from '../views/FormStepper.vue'
import ApprovalTable from '../components/ApprovalTable.vue'

export default {
  name: 'Submission',
  components: {
    FormStepper,
    ApprovalTable
  },
  computed: {
    ...mapGetters({
      laboratory: 'session/laboratory'
    })
  },
  data: () => ({
    headers: [
      { value: 'name', text: 'Pesquisador' },
      { value: 'last', text: 'Última Modificação' },
      { value: 'accepted', text: 'Aceito' },
      { value: 'preview', text: '', sortable: false },
      { value: 'submit', text: '', sortable: false }
    ],
    loading: false,
    items: [],
    preview_data: {},
    editedItem: {},
    dialog: false,
    comment: null
  }),
  mounted () {
    this.get_items()
  },
  methods: {
    async get_items () {
      this.loading = true
      const response = await axios.get(
        process.env.VUE_APP_BACKENDURL + '/me/submissions'
      )
      console.log(response)
      this.items = response.data
      this.items.map(function (item) {
        item.last = DateTime
          .fromISO(item.last)
          .setLocale('br')
          .toFormat("dd/MM/yyyy 'às' HH:mm")
        item.dialog = false
      })
      this.loading = false
    },
    submitItem (item) {
      this.editedItem = Object.assign({}, item)
      this.comment = null
      this.dialog = true
    },
    async submit (id) {
      this.dialog = false
      console.log('submetido ' + id + ' ' + this.comment)
      const response = await axios.post(process.env.VUE_APP_BACKENDURL + /submit/ + id, { comment: this.comment })
      console.log(response)
    },
    async preview (item) {
    }
  }
}
</script>
