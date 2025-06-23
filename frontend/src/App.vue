<template>
    <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/materials">Materials</RouterLink>
    </nav>
    <RouterView/>
</template>

<script setup>
import { onMounted } from 'vue'
import { RouterLink, RouterView } from 'vue-router'
import { useMaterialsStore } from '@/stores/materials'

const store = useMaterialsStore()

onMounted(() => {
    store.fetchMaterials()
})
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 0;
  ul {
    list-style-position: inside;
    padding-left: 0;
    }

    .content {
  display: flex;
    }

}
</style>
