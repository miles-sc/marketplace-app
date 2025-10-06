<template>
    <header class="header-bar">
        <h1 class="site-title">MakerMarket</h1>
        <nav class="nav-links">
            <div class="nav-left">
                <RouterLink to="/">Home</RouterLink>
                <RouterLink to="/materials">Materials</RouterLink>
                <RouterLink to="/resources">Resources</RouterLink>
            </div>
            <div class="nav-right">
                <RouterLink to="/cart" class="cart-link">
                    <IconCart />
                    <span v-if="cart.items.length > 0" class="cart-badge">{{ cart.items.length }}</span>
                </RouterLink>
                <RouterLink :to="authStore.isLoggedIn ? '/profile' : '/login'" > <IconProfile /> </RouterLink>
            </div>
        </nav>
    </header>
</template>

<script setup>
import { RouterLink } from 'vue-router';
import { IconCart, IconProfile } from '@/components/icons';
import { useCartStore } from '@/stores/cart';
import { useAuthStore } from '@/stores/auth';

const cart = useCartStore();
const authStore = useAuthStore();
</script>


<style scoped>
.header-bar {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  background-color: #8B0000;
  color: #f8f8f8;
  padding: 0.75rem 1.5rem;

  position: sticky;
  top: 0;
  z-index: 1000;
}

.site-title {
  font-size: 1.5rem;
  margin: 0;
  color: inherit;
}

.nav-links {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex: 1;
  margin-left: 1.5rem;
}

.nav-links a {
  color: #f8f8f8;
  text-decoration: none;
}

.nav-links a:hover {
  transform: scale(1.05);
  transition: transform 0.1s linear;
}

.nav-left {
  display: flex;
  gap: 1rem;
}

.nav-right {
  display: flex;
  gap: 1rem;
}

.cart-link {
  position: relative;
  display: inline-block;
}

.cart-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background-color: #f8f8f8;
  color: #8B0000;
  font-size: 0.625rem;
  font-weight: bold;
  border-radius: 50%;
  border: 1px solid #8B0000;
  min-width: 14px;
  height: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1px;
}

</style>
