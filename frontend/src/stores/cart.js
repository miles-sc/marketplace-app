import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useCartStore = defineStore('cart', () => {
  const items = ref([])

  function addItem({ jobId, filename, material, price }) {
    items.value.push({ jobId, filename, material, price })
  }

  function removeItem(index) {
    items.value.splice(index, 1)
  }

  return { items, addItem, removeItem }
})
