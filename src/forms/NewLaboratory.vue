<template>
  <v-container class="flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card outlined>
          <v-card-title headline>
            Novo Laboratório
          </v-card-title>
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
              prepend-inner-icon="mdi-office-building"
              valid
            />

            <DataSelect
              v-model="form_data.laboratory_division_id"
              resource="laboratory_divisions"
              label="Divisão do Laboratório"
              show-value="name"
              icon="mdi-briefcase-edit"
            />

            <v-btn @click="create">
              Criar Laboratório
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
import createItem from '../plugins/createItem'

export default {
  name: 'NewLaboratory',
  components: {
    DataSelect
  },
  data: () => ({
    form_valid: false,
    form_data: {
      name: '',
      laboratory_division_id: null
    }
  }),
  methods: {
    create () {
      const response = createItem(this.form_data, 'laboratories')
      console.log(response)
    }
  }
}
</script>
