import { createRouter, createWebHistory } from 'vue-router'
import MaterialGuide from '@/components/MaterialGuide.vue'
import HomePage from '@/components/HomePage.vue'

const routes = [
  { path: '/', component: HomePage },
  { path: '/materials', component: MaterialGuide }
]

export default createRouter({
  history: createWebHistory(),
  routes
})
