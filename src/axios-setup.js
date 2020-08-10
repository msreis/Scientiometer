import axios from 'axios'
import { Service } from 'axios-middleware'

const service = new Service(axios)

let axiosStore = null

export function setAxiosStore (store) {
  axiosStore = store
}

service.register({
  onRequest (config) {
    // Only add headers of authentication and authorization to requests made to
    // our backend
    if (axiosStore.getters['session/logged_in'] && new
    RegExp(process.env.VUE_APP_BACKENDURL).test(config.url)) {
      config.headers['Authorization'] = 'Bearer ' +
        axiosStore.getters['session/token']
    }
    return config
  }
})
