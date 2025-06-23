<template>
  <div>
    <h1>Material Guide</h1>
    <section v-for="material in store.materials" :key="material.id">
      <h2>{{ material.name }}</h2>
      <p>{{ material.description }}</p>
    </section>
  </div>
</template>

<script setup>
import { useMaterialsStore } from '@/stores/materials';

const store = useMaterialsStore()
</script>

<style scoped>
</style>
