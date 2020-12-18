<template>
  <v-row>
    <v-col>
      <v-stepper
        v-model="form_step"
        :vertical="false"
      >
        <v-stepper-header
          :key="1"
          :class="`${color}`"
        >
          <template v-for="step in steps">
            <v-stepper-step
              :key="step.index"
              :step="step.index"
              editable
            >
              {{ step.label }}
            </v-stepper-step>
            <v-divider :key="`divider-${step.index}`" />
          </template>
        </v-stepper-header>

        <template v-if="form_data.generated">
          <v-stepper-items class="mt-4">
            <v-stepper-content
              v-for="step in steps"
              :ref="step.index"
              :key="step.index"
              :step="step.index"
            >
              <template v-for="pair in step.components.map((comp, index) => ({index, comp}))">
                <v-lazy :key="`lazy-${pair.index}`">
                  <keep-alive :key="`alive-${pair.index}`">
                    <component
                      :is="pair.comp.component || pair.comp"
                      :key="`${pair.index}-curr-${form_step}`"
                      :prop-obj="pair.comp.prop"
                      :form_data="form_data[form_step][pair.index]"
                    />
                  </keep-alive>
                </v-lazy>
                <v-divider :key="`divider-${pair.index}`" />
              </template>
            </v-stepper-content>
            <v-row>
              <v-spacer />
              <v-btn
                class="mb-6 mr-6 mt-4 ml-4 primary"
                x-large
                @click="submit()"
              >
                {{ editable ? "Salvar passo " + form_step + " e prosseguir" : "Próximo passo" }}
                <v-icon
                  right
                  large
                >
                  mdi-chevron-right
                </v-icon>
              </v-btn>
            </v-row>
          </v-stepper-items>
        </template>
      </v-stepper>
      <!-- ALERT FOR ERROR AND SUCCESS RESPONSES -->
      <v-snackbar
        v-model="alert"
        bottom
        :color="alert_color"
        multi-line
        :timeout="timeout"
      >
        {{ alert_text }}
        <v-btn
          dark
          text
          @click="alert = false"
        >
          Fechar
        </v-btn>
      </v-snackbar>
      <v-col />
    </v-col>
  </v-row>
</template>

<script>
import NewResearcher from '../forms/NewResearcher.vue'
import NewEmployee from '../forms/NewEmployee.vue'
import NewAdvisement from '../forms/NewAdvisement.vue'
import NewProdGrant from '../forms/NewProdGrant.vue'
import NewPaper from '../forms/NewPaper.vue'
import NewScientometricIndices from '../forms/NewScientometricIndices.vue'
import NewCongress from '../forms/NewCongress.vue'
import NewAccreditation from '../forms/NewAccreditation.vue'
import NewActivity from '../forms/NewActivity.vue'
import NewNote from '../forms/NewNote.vue'
import NewMinisteredClass from '../forms/NewMinisteredClass.vue'
import NewLecture from '../forms/NewLecture.vue'
import NewCourseCoordination from '../forms/NewCourseCoordination.vue'
import NewGrant from '../forms/NewGrant.vue'
import NewThesis from '../forms/NewThesis.vue'
import NewBook from '../forms/NewBook.vue'

import axios from 'axios'

import { mapGetters, mapMutations } from 'vuex'

export default {
  name: 'FormPager',
  props: { 'submission': {}, 'editable': { default: true } },
  data: () => ({
    steps: [
      { index: 1, label: 'Pesquisador', components: [NewResearcher] },
      {
        index: 2,
        label: 'Pessoal',
        components: [
          NewEmployee,
          { component: NewEmployee, prop: true },
          NewAdvisement,
          NewProdGrant
        ]
      },
      {
        index: 3,
        label: 'Produção',
        components: [NewPaper, NewBook, NewScientometricIndices, NewCongress]
      },
      {
        index: 4,
        label: 'Formação',
        components: [
          NewThesis,
          NewAccreditation,
          NewMinisteredClass,
          NewLecture,
          NewCourseCoordination
        ]
      },
      {
        index: 5,
        label: 'Captação',
        components: [NewGrant]
      },
      { index: 6, label: 'Atividades', components: [NewActivity] },
      { index: 7, label: 'Observações', components: [NewNote] }
    ],
    formData: {},
    alert: false,
    alert_color: 'success',
    timeout: 6000,
    alert_text: 'algo'
  }),

  computed: {
    form_data () {
      // If form data has been received from backend and is to be displayed
      if (this.submission && !this.formData.generated) {
        // create a dummy form_data
        this.empty_form_data()
        this.load_submission()
      } else if (!this.formData.generated) {
        this.empty_form_data()
      }
      return this.formData
    },
    form_step: {
      get () {
        return this.$store.getters['general/step']
      },
      set (step) {
        this.$store.commit('general/step', step)
      }
    },
    color: {
      get () {
        return this.$store.getters['general/dark_theme']
          ? 'grey darken-3'
          : 'white'
      }
    }
  },

  beforeMount () {
    this.$store.commit('general/step', 1)
  },

  methods: {
    async submit () {
      if (!this.editable) {
        this.form_step = (this.form_step + 1) % this.steps.length
        return
      }
      const data = {
        step: this.form_step,
        ...this.formData[this.form_step]
      }
      console.log(data)
      try {
        const response = await axios.post(
          process.env.VUE_APP_BACKENDURL + '/forms/steps',
          {
            ...data
          },
          {
            headers: {
              'Content-Type': 'application/json;charset=UTF-8',
              'Access-Control-Allow-Origin': '*'
            }
          }
        )
        if (response.status === 200) {
          this.alert_text = `PASSO ${this.form_step} ENVIADO`
          this.form_step = (this.form_step + 1) % this.steps.length
          this.alert_color = 'success'
        }
      } catch (error) {
        this.alert_color = 'error'
        this.alert_text = error
        console.log(error)

        const match = new RegExp('401')
        if (error.toString().match(match)) {
          this.alert_text = 'Sessão expirada. Faça LOGIN novamente.'
        }
      }
      this.alert = true
    },
    async load_submission () {
      for (let i = 1; i <= 7; i++) {
        const response = await axios.get(
          process.env.VUE_APP_BACKENDURL + '/forms/steps/' + i.toString(), {
            params: {
              submission: this.submission
            }
          }
        )
        this.formData[i] = response.data
      }
      this.formData.generated = true
    },
    empty_form_data () {
      let temp = {}
      this.steps.forEach(function (step) {
        temp[step.index] = {}
        let i = 0
        step.components.forEach(function (comp) {
          temp[step.index][i++] = {}
        })
      })
      this.formData = temp
      this.formData.generated = true
    }
  }
}
</script>
