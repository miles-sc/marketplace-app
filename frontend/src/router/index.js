import { createRouter, createWebHistory } from 'vue-router'
import MaterialGuide from '@/components/MaterialGuide.vue'
import HomePage from '@/components/HomePage.vue'
import CartPage from '@/components/CartPage.vue'

const routes = [
  { path: '/', component: HomePage },
  { path: '/materials', component: MaterialGuide },
  { path: '/cart', component: CartPage }
]

export default createRouter({
  history: createWebHistory(),
  routes
})
