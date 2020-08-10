import { Bar } from 'vue-chartjs'
import {labs, pesquisadores_celetistas, pesquisadores_estatutarios, pesquisadores_outros} from './static'

export default {
  extends: Bar,
  data: () => ({
    chartdata: {
      labels: labs.data,
      datasets: [
        {
          label: pesquisadores_estatutarios.name,
          backgroundColor: 'rgb(236,218,255)',
          data: pesquisadores_estatutarios.data
        },
        {
          label: pesquisadores_celetistas.name,
          backgroundColor: 'rgb(203,249,253)',
          data: pesquisadores_celetistas.data
        },
        {
          label: pesquisadores_outros.name,
          backgroundColor: 'rgb(255,247,221)',
          data: pesquisadores_outros.data
        }
      ]
    },
    options: {
      plugins: {
        labels: false,
        datalabels: {
          color: 'grey',
          font: {
            weight: 'bold'
          }
        }
      },
      tooltips: {
        mode: 'label',
        callbacks: {
          afterTitle: () => {
            window.total = 0;
          },
          label: (tooltipItem, data) => {
            const lab = data.datasets[tooltipItem.datasetIndex].label;
            const valor = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
            window.total += valor;
            return lab + ": " + valor.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
          },
          footer: () => {
            return "TOTAL: " + window.total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
          }
        }
      },
      scales: {
        xAxes: [{
          stacked: true
        }],
        yAxes: [{
          stacked: true
        }]
      },
      responsive: true,
      maintainAspectRatio: false
    }
  }),

  mounted () {
    this.renderChart(this.chartdata, this.options)
  }
}
