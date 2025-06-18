<template>
  <div class="material-list">
    <h2>Available Materials</h2>
    <p class="subtitle">Click any material for more information</p>
    <ul>
      <li
        v-for="material in materials"
        :key="material.id"
        class="material-item"
        @click="$emit('select', material)"
      >
        {{ material.name }} - ${{ formatPrice(material.price) }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'MaterialList',
  props: {
    materials: {
      type: Array,
      required: true
    }
  },
  methods: {
    formatPrice(price) {
      return Number(price).toFixed(2);
    }
  }
}
</script>

<style scoped>
.material-list {
  padding: 1rem;
}

.subtitle {
  font-size: 0.9rem;
  color: #666;
}

.material-item {
  cursor: pointer;
  padding: 0.25rem 0;
}

.material-item:hover {
  text-decoration: underline;
}
</style>
