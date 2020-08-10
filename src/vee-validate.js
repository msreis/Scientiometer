import { required, email, max, numeric } from 'vee-validate/dist/rules'
import { extend } from 'vee-validate'

extend('required', {
  ...required,
  message: 'Campo obrigatório'
})

extend('max', {
  ...max,
  message: 'Este campo deve ter no máximo {length} caracteres'
})

extend('email', {
  ...email,
  message: 'Deve ser um e-mail válido'
})

extend('numeric', {
  ...numeric,
  message: 'O campo deve conter apenas números'
})
