<template>
    <header class="header-bar">
        <h1 class="site-title">MakerMarket</h1>
        <nav class="nav-links">
            <RouterLink to="/">Home</RouterLink>
            <RouterLink to="/materials">Materials</RouterLink>
        </nav>
    </header>
</template>

import { RouterLink, RouterView } from 'vue-router'

<script setup>
import { RouterLink } from 'vue-router';
</script>


<style scoped>
.header-bar {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  background-color: #8B0000; /* dark red */
  color: #f8f8f8; /* off white */
  padding: 0.75rem 1.5rem;
}

.site-title {
  font-size: 1.5rem;
  margin: 0;
  color: inherit;
}

.nav-links {
  display: flex;
  gap: 1rem;
  margin-left: 1.5rem;
}

.nav-links a {
  color: #f8f8f8;
  text-decoration: none;
}

.nav-links a:hover {
  text-decoration: underline;
}
</style>
