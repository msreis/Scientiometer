<template>
  <v-menu
    ref="menu"
    v-model="menu"
    :close-on-content-click="false"
    min-width="290px"
    offset-y
    transition="scale-transition"
  >
    <template v-slot:activator="{ on }">
      <ValidationProvider
        v-slot="{ errors, valid }"
        rules="required"
      >
        <v-text-field
          :label="label"
          :value="year"
          outlined
          append-icon="mdi-calendar"
          readonly
          :error-messages="errors"
          :success="valid"
          v-on="on"
        />
      </ValidationProvider>
    </template>

    <v-date-picker
      ref="picker"
      v-model="date"
      :max="max"
      :min="min"
      locale="PT-BR"
      reactive
      @input="save"
    />
  </v-menu>
</template>
<script>
import { ValidationProvider } from 'vee-validate'
import { DateTime } from 'luxon'

export default {
  name: 'YearPicker',

  components: {
    ValidationProvider
  },

  props: ['min', 'max', 'label'],

  data () {
    return {
      date: '',
      menu: false
    }
  },

  computed: {
    year () {
      return this.date.substring(0, 4)
    }
  },

  watch: {
    date: function () {
      this.date = DateTime.fromISO(this.date)
        .set({ day: 1, month: 1 })
        .toISO()
        .substring(0, 10)
      this.$emit('input', this.date)
    },
    menu (val) {
      val && this.$nextTick(() => (this.$refs.picker.activePicker = 'YEAR'))
    }
  },

  methods: {
    save (date) {
      this.$refs.menu.save(date)
      this.$refs.picker.activePicker = 'YEAR'
      this.menu = false
    }
  }
}
</script>
