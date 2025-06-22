import { createRouter, createWebHistory } from 'vue-router'
import HelloWorld from '../components/HelloWorld.vue'
import HeaderBar from '../components/HeaderBar.vue'

const routes = [
  { path: '/', component: HelloWorld },
  { path: '/HeaderBar', component: HeaderBar }
]

export default createRouter({
  history: createWebHistory(),
  routes
})
