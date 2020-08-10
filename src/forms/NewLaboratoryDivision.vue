<template>
  <v-container class="flex-column justify-around">
    <v-row>
      <v-col />
      <v-col
        cols="12"
        lg="9"
        xl="7"
      >
        <v-card
          ref="card"
          outlined
        >
          <v-card-title headline>
            Nova Divisão de Laboratórios
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
              prepend-inner-icon="mdi-briefcase-edit"
              valid
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
import createItem from '../plugins/createItem'

export default {
  name: 'NewLaboratoryDivision',
  data: () => ({
    form_valid: false,
    form_data: {
      name: ''
    }
  }),
  methods: {
    create () {
      const response = createItem(this.form_data, 'laboratory_divisions')
      console.log(response)
    }
  }
}
</script>
