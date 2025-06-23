<template>
  <div>
    <h2>Available Materials</h2>
    <p>Click any material for more information</p>
    <ul>
      <li
        v-for="material in store.materials"
        :key="material.id">
        {{ material.name }} - ${{ formatPrice(material.price) }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { useMaterialsStore } from '@/stores/materials';

function formatPrice(price) {
      return Number(price).toFixed(2);
    }

const store = useMaterialsStore()
</script>

<style scoped>
</style>
