import { createRouter, createWebHistory } from 'vue-router'
import MaterialGuide from '@/components/MaterialGuide.vue'
import HomePage from '@/components/HomePage.vue'
import CartPage from '@/components/CartPage.vue'
import LoginPage from '@/components/LoginPage.vue'
import RegisterPage from '@/components/RegisterPage.vue'
import ProfilePage from '@/components/ProfilePage.vue'
import { useAuthStore } from '@/stores/auth'

const routes = [
  { path: '/', component: HomePage },
  { path: '/materials', component: MaterialGuide },
  { path: '/cart', component: CartPage },
  { path: '/login', component: LoginPage },
  { path: '/register', component: RegisterPage },
  {
    path: '/profile',
    component: ProfilePage,
    meta: { requiresAuth: true }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// Navigation guard to redirect to login if not authenticated
router.beforeEach((to, _from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiresAuth && !authStore.isLoggedIn) {
    next('/login')
  } else {
    next()
  }
})

export default router
