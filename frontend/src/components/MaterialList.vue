<template>
  <div>
    <h2>Materials</h2>
    <table>
        <thead>
            <tr>
            <th>Name</th>
            <th>Price/in<sup>3</sup></th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="material in store.materials" :key="material.id">
            <td>{{ material.name }}</td>
            <td>{{ formatPrice(material.price) }}</td>
            </tr>
        </tbody>
    </table>

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
