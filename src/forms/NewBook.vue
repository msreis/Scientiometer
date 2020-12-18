<template>
  <v-container class="register flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card outlined>
          <v-card-title headline>
            Lista de livros e capítulos publicados
          </v-card-title>
          <v-card class="ma-4">
            <v-data-table
              ref="table"
              v-model="selected"
              :headers="headers"
              :items="items"
              hide-default-footer
              item-key="doi"
              show-select
              show-expand
            >
              <template v-slot:expanded-item="{ headers, item }">
                <td :colspan="headers.length">
                  <v-data-table
                    :headers="[{text: 'Nome', value: 'text'}]"
                    :items="[].concat(item.ic, item.msc, item.phd, item.postdoc)"
                    hide-default-footer
                  />
                </td>
              </template>
            </v-data-table>

            <v-btn
              :color="selected.length == 0 ? '': 'error'"
              :disabled="items.length == 0"
              class="ma-4"
              @click="removeSelected()"
            >
              Remover
            </v-btn>
          </v-card>
        </v-card>
        <ValidationObserver
          ref="obs"
          v-slot="{invalid, validated, passes, validate}"
        >
          <v-card outlined>
            <v-card-title headline>
              Novo Livro/capítulo publicado
            </v-card-title>
            <v-form
              ref="form"
              lazy-validation
              class="pa-4"
            >
              <ValidationProvider
                v-slot="{errors, valid}"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.doi"
                  :error-messages="errors"
                  :success="valid"
                  label="DOI"
                  placeholder="Exemplo: 10.1101/398013"
                  outlined
                  prepend-inner-icon="mdi-file-document"
                />
              </ValidationProvider>

              <!-- DOI metadata -->
              <DOIFinder
                v-model="doi_metadata"
                :doi="form_data.doi"
              />

              <ValidationProvider
                v-slot="{errors, valid}"
                rules="required"
              >
                <v-text-field
                  v-model="form_data.isbn"
                  :error-messages="errors"
                  :success="valid"
                  label="ISBN"
                  placeholder="Exemplo: 85-359-0277-5"
                  outlined
                  prepend-inner-icon="mdi-book-open-variant"
                />
              </ValidationProvider>

              <v-row>
                <v-col>
                  <data-select
                    v-model="form_data.qualis"
                    icon="mdi-certificate"
                    label="Qualis"
                    resource="qualis"
                    show-value="qualis"
                    object
                  />
                </v-col>

                <v-col>
                  <ValidationProvider
                    v-slot="{errors, valid}"
                    rules="required"
                  >
                    <v-text-field
                      v-model="form_data.impact_factor"
                      :error-messages="errors"
                      :success="valid"
                      label="Fator de Impacto Mais Recente"
                      outlined
                      prepend-inner-icon="mdi-file-document"
                    />
                  </ValidationProvider>
                </v-col>
              </v-row>

              <data-select
                v-model="form_data.collaboration_type"
                icon="mdi-certificate"
                label="Tipo de Colaboração"
                resource="collaboration_types"
                show-value="collaboration"
                object
              />

              <v-card
                outlined
                class="pa-4 mb-6"
              >
                <v-label class="bold">
                  Tipo de Autoria
                </v-label>
                <v-row>
                  <v-col>
                    <v-checkbox
                      v-model="form_data.first_author"
                      label="Primeiro Autor"
                    />
                  </v-col>
                  <v-col>
                    <v-checkbox
                      v-model="form_data.last_author"
                      label="Último Autor"
                    />
                  </v-col>
                  <v-col>
                    <v-checkbox
                      v-model="form_data.corresponding_author"
                      label="Autor Correspondente"
                    />
                  </v-col>
                </v-row>
              </v-card>

              <multi-select
                v-model="form_data.postdoc"
                icon="mdi-certificate"
                label="Participação de Pós-doc"
                resource="postphds"
                show-value="name"
                item-key="value"
                hide-selected
                :headers="[{text: 'Nome', value: 'text'}]"
                rules
              />

              <multi-select
                v-model="form_data.phd"
                icon="mdi-certificate"
                label="Participação de Doutorando"
                resource="phds"
                show-value="name"
                item-key="value"
                hide-selected
                :headers="[{text: 'Nome', value: 'text'}]"
                rules
              />

              <multi-select
                v-model="form_data.msc"
                icon="mdi-certificate"
                label="Participação de Mestrando"
                resource="mscs"
                show-value="name"
                item-key="value"
                hide-selected
                :headers="[{text: 'Nome', value: 'text'}]"
                rules
              />

              <multi-select
                v-model="form_data.ic"
                icon="mdi-certificate"
                label="Participação de Aluno IC"
                resource="ics"
                show-value="name"
                item-key="value"
                hide-selected
                :headers="[{text: 'Nome', value: 'text'}]"
                rules
              />
              <v-btn @click="addToTable()">
                Adicionar Artigo
              </v-btn>
            </v-form>
          </v-card>
        </ValidationObserver>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import DataSelect from '../components/DataSelect.vue'
import DOIFinder from '../components/DOIFinder.vue'
import MultiSelect from '../components/MultiSelect.vue'
import axios from 'axios'

export default {
  name: 'NewPaper',

  components: {
    ValidationObserver,
    ValidationProvider,
    DataSelect,
    DOIFinder,
    MultiSelect
  },

  props: ['form_data'],

  data: () => ({
    doi_metadata: [],
    items: [],
    selected: [],
    headers: [{ text: 'DOI', value: 'doi' }, { text: 'ISBN', value: 'isbn' }, { text: 'Título', value: 'title' }],
    index: 0
  }),

  mounted () {
    this.items = this.form_data.items || []
  },
  methods: {
    addToTable () {
      if (true) {
        this.form_data.items = []
        this.items.push({ index: this.index, ...this.form_data, title: this.doi_metadata.title })
        this.form_data.items = this.items
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
    }
  }
}
</script>
