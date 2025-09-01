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
                <RouterLink to="/cart" > <IconCart /> </RouterLink>
                <RouterLink to="/profile" > <IconProfile /> </RouterLink>
            </div>
        </nav>
    </header>
</template>

<script setup>
import { RouterLink } from 'vue-router';
import { IconCart, IconProfile } from '@/components/icons';
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

</style>
