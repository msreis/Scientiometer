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
            {{ title }}
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

          <slot />
        </v-card>
      </v-col>
      <v-col />
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'MultiInsert',

  props: {
    headers: {
      type: Array,
      default: () => ([])
    },
    propObj: {
      default: false
    }
  },

  data: () => ({
    form_data: {
    },
    items: [],
    index: 0,
    selected: []
  }),

  methods: {
    addToTable () {
      if (this.form_data.name &&
        this.form_data.role_foundation_level_id &&
        this.form_data.title_id) {
        this.items.push({ index: this.index, ...this.form_data })
        this.index++
      }
    },

    removeSelected () {
      for (let i = 0; i < this.selected.length; i++) {
        this.items = this.items.filter(item => { return item.index !== this.selected[i].index })
      }
    }
  }
}
</script>
