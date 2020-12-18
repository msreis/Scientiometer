<template>
  <v-container v-if="access_level" class="flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card outlined>
          <v-card-title headline>
            Funcionários {{ this.propObj ? "Fundação" : "Servidores" }}
          </v-card-title>

          <v-card class="ma-4">
            <v-data-table
              ref="table"
              v-model="selected"
              :headers="headers"
              :items="items"
              hide-default-footer
              item-key="index"
              show-select
            />

            <v-btn
              :color="selected.length == 0 ? '': 'error'"
              :disabled="items.length == 0"
              class="ma-4"
              @click="removeSelected()"
            >
              Remover
            </v-btn>
          </v-card>

          <v-form
            ref="form"
            v-model="form_valid"
            lazy-validation
            class="ma-4"
          >
            <v-text-field
              v-model="form_data.name"
              label="Nome"
              outlined
              prepend-inner-icon="mdi-face"
              valid
            />

            <data-select
              v-model="form_data.role_foundation_level"
              icon="mdi-account-badge"
              :label="this.label"
              resource="role_foundation_levels"
              :params="this.resource"
              show-value="description"
              object
            />

            <data-select
              ref="title_select"
              v-model="form_data.title"
              icon="mdi-certificate"
              label="Titulação"
              resource="titles"
              show-value="name"
              object
            />

            <v-btn @click="addToTable()">
              Adicionar Novo
            </v-btn>
          </v-form>
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>
<script>
import DataSelect from '../components/DataSelect'

export default {
  name: 'NewEmployee',
  components: {
    DataSelect
  },
  props: {
    propObj: {
      default: false
    },
    form_data: {}
  },
  data: () => ({
    form_valid: false,
    headers: [
      { text: 'Nome', value: 'name' },
      { text: 'Cargo', value: 'role_foundation_level_description' },
      { text: 'Titulação', value: 'title_name' }
    ],
    items: [],
    index: 0,
    selected: []
  }),
  computed: {
    access_level () {
      return this.$store.state.session.access_level > 1
    },
    resource () {
      return  this.propObj ? "categories=fundação" : "categories=estatutário"
    },
    label () {
      return  this.propObj ? "Cargo Fundação" : "Cargo Servidor"
    }
  },

  mounted () {
    this.items = this.form_data.items || []
  },
  methods: {
    addToTable () {
      if (
        this.form_data.name &&
        this.form_data.role_foundation_level &&
        this.form_data.title
      ) {
        this.form_data['items'] = null
        this.items.push({
          index: this.index,
          ...this.form_data,
          role_foundation_level_id: this.form_data.role_foundation_level.value,
          role_foundation_level_description: this.form_data.role_foundation_level.text,
          title_id: this.form_data.title.value,
          title_name: this.form_data.title.text })
        this.$refs.form.reset()
        this.index++
      }
      this.form_data['items'] = this.items
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
