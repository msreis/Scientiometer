import {Pie} from 'vue-chartjs'
import {background_colors, labs, total_publicacoes} from './static'

export default {
  extends: Pie,
  data: () => ({
    chartdata: {
      labels: labs.data,
      datasets: [
        {
          label: total_publicacoes.name,
          data: total_publicacoes.data,
          backgroundColor: background_colors
        }
      ]
    },
    options: {
      title: {
        display: true,
        text: 'Publicações',
      },
      plugins: {
        labels: [
          {
            shadowColor: 'black',
            fontColor: 'white',
            fontStyle: 'bold',
            textShadow: true
          },
          {
            render: function (args) {
              return args.label + ' (' + args.value + ')';
            },
            shadowColor: 'white',
            fontColor: 'black',
            position: 'outside',
            fontStyle: 'bold',
            textShadow: true
          }
        ],
        datalabels: {
          display: false
        }
      },
      tooltips: {
        mode: 'index',
        intersect: false
      },
      responsive: true,
      maintainAspectRatio: false
    }
  }),

  mounted () {
    this.renderChart(this.chartdata, this.options)
  }
}
