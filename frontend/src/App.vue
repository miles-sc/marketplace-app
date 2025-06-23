<template>
    <HeaderBar/>
    <div  class="page">
            <RouterView/>
    </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { RouterView } from 'vue-router'
import { useMaterialsStore } from '@/stores/materials'
import HeaderBar from './components/HeaderBar.vue'

const store = useMaterialsStore()

onMounted(() => {
    store.fetchMaterials()
})
</script>

<style>

html, body, #app {
  margin: 0;
  padding: 0;
  height: 100%;
}

#app {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
  margin-top: 0;
  ul {
    list-style-position: inside;
    padding-left: 0;
    }

    .page {
    padding-left: 1.5rem;
}

}
</style>
