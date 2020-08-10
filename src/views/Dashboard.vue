<template>
  <v-container>
    <v-row>
      <v-col>
        <bar-chart/>
      </v-col>
      <v-col>
        <pie-chart/>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <doughnut-chart/>
      </v-col>
      <v-col>
      </v-col>
  </v-row>
  </v-container>
</template>

<script>
  import DoughnutChart from '../charts/DoughnutChart'
  import BarChart from '../charts/BarChart'
  import PieChart from '../charts/PieChart'
  import ChartDataLabels from 'chartjs-plugin-datalabels'
  import ChartLalbs from 'chartjs-plugin-labels'

  export default {
  name: 'Dashboard',
  components: {
    DoughnutChart,
    PieChart,
    BarChart,
    ChartDataLabels,
    ChartLalbs
  }
}
</script>

<style scoped>
.small {
  max-width: 600px;
  margin:  150px auto;
}
</style>
