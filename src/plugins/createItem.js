import axios from 'axios'

const createItem = async (data, url) => {
  const response = await axios.post(process.env.VUE_APP_BACKENDURL + '/' + url, {
    ...data
  })
  return response
}

export default createItem
