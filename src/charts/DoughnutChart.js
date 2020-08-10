import {Doughnut} from 'vue-chartjs'
import {
  background_colors,
  background_colors_light,
  labs,
  pesquisadores_celetistas,
  pesquisadores_estatutarios, pesquisadores_outros
} from './static'

export default {
  extends: Doughnut,
  data: () => ({
    chartdata: {
      datasets: [
        {
          name: pesquisadores_estatutarios.name,
          data: pesquisadores_estatutarios.data,
          backgroundColor: background_colors_light
        },
        {
          name: pesquisadores_celetistas.name,
          data: pesquisadores_celetistas.data,
          backgroundColor: background_colors_light
        },
        {
          name: pesquisadores_outros.name,
          data: pesquisadores_outros.data,
          backgroundColor: background_colors_light
        }
      ],
      labels: labs.data
    },
    options: {
      title: {
        display: true,
        text: 'Pesquisadores outros) celetistas) estatutários)'
      },
      responsive: true,
      plugins: {
        labels:[
          {
            render: function (args) {
              return args.percentage + '% (' + args.value + ')';
            },
            shadowColor: 'white',
            fontColor: 'black',
            fontStyle: 'bold',
            textShadow: true
          }
        ],
        datalabels: {
          display: false
        }
      },
      tooltips: {
        intersect : false,
        mode: 'index',
        callbacks: {
          title: (tooltipItem, data) => {
            return data['labels'][tooltipItem[0]['index']];
          },
          afterTitle: () => {
            window.total = 0;
          },
          label: (tooltipItem, data) => {
            const type = data.datasets[tooltipItem.datasetIndex].name;
            const valor = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
            window.total += valor;
            return type + ": " + valor.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
          },
          footer: () => {
            return "TOTAL: " + window.total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
          }
        }
      }
    }
  }),

  mounted() {
    this.renderChart(this.chartdata, this.options)
  }
}
