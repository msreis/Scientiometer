import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/login',
      name: 'login',
      component: () => import(/* webpackChunkName: "login" */ './forms/Login.vue')
    },
    {
      path: '/laboratory/new',
      name: 'new_laboratory',
      component: () => import(/* webpackChunkName: "new_laboratory" */ './forms/NewLaboratory.vue')
    },
    {
      path: '/laboratory_division/new',
      name: 'new_laboratory_division',
      component: () => import(/* webpackChunkName: "new_laboratory_division" */ './forms/NewLaboratoryDivision.vue')
    },
    {
      path: '/fill',
      name: 'form_stepper',
      component: () => import(/* webpackChunkName: "form_stepper" */ './views/FormStepper.vue')
    },
    {
      path: '/review',
      name: 'review',
      component: () => import(/* webpackChunkName: "review" */ './views/SubmissionsLab.vue')
    },
    {
      path: '/summary',
      name: 'summary',
      component: () => import(/* webpackChunkName: "summary" */ './views/SubmissionsDiv.vue')
    },
    {
      path: '/profile',
      name: 'profile',
      component: () => import(/* webpackChunkName: "profile" */ './views/Profile.vue')
    },
    {
      path: '/my_submissions',
      name: 'submission',
      component: () => import(/* webpackChunkName: "submission" */ './views/Submission.vue')
    }
  ]
})
